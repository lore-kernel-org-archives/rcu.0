Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A145C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087A62072C
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 20:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgBQUZU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:25:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgBQUZU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 15:25:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A75C72067D;
        Mon, 17 Feb 2020 20:25:18 +0000 (UTC)
Date:   Mon, 17 Feb 2020 15:25:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 22/30] rcu: Don't flag non-starting GPs
 before GP kthread is running
Message-ID: <20200217152517.26cc11ea@gandalf.local.home>
In-Reply-To: <20200215134208.GA9879@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
        <20200214235607.13749-22-paulmck@kernel.org>
        <20200214225305.48550d6a@oasis.local.home>
        <20200215110111.GZ2935@paulmck-ThinkPad-P72>
        <20200215134208.GA9879@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, 15 Feb 2020 05:42:08 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> 
> And does the following V2 look better?
> 

For the issue I brought up, yes. But now I have to ask...

> @@ -1252,10 +1253,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
>   */
>  static void rcu_gp_kthread_wake(void)
>  {
> -	if ((current == rcu_state.gp_kthread &&
> -	     !in_irq() && !in_serving_softirq()) ||
> -	    !READ_ONCE(rcu_state.gp_flags) ||
> -	    !rcu_state.gp_kthread)
> +	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
> +
> +	if ((current == t && !in_irq() && !in_serving_softirq()) ||
> +	    !READ_ONCE(rcu_state.gp_flags) || !t)

Why not test !t first? As that is the fastest operation in the if
statement, and will shortcut all the other operations if it is true.

As I like to micro-optimize ;-), for or (||) statements, I like to add
the fastest operations first. To me, that would be:

	if (!t || READ_ONCE(rcu_state.gp_flags) ||
	    (current == t && !in_irq() && !in_serving_softirq()))
		return;

Note, in_irq() reads preempt_count which is not always a fast operation.

-- Steve


>  		return;
>  	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
>  	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
> @@ -3554,7 +3555,10 @@ static int __init rcu_spawn_gp_kthread(void)
>  	}
>  	rnp = rcu_get_root();
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -	rcu_state.gp_kthread = t;
> +	WRITE_ONCE(rcu_state.gp_activity, jiffies);
> +	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
> +	// Reset .gp_activity and .gp_req_activity before setting .gp_kthread.
> +	smp_store_release(&rcu_state.gp_kthread, t);  /* ^^^ */
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	wake_up_process(t);
>  	rcu_spawn_nocb_kthreads();
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 488b71d..16ad7ad 100644
\
