Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F0C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36CA20836
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 22:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgBQWVf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgBQWVf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 17:21:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC93B2070B;
        Mon, 17 Feb 2020 22:21:32 +0000 (UTC)
Date:   Mon, 17 Feb 2020 17:21:31 -0500
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
Message-ID: <20200217172131.1f4c48d2@gandalf.local.home>
In-Reply-To: <20200217220356.GY2935@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
        <20200214235607.13749-22-paulmck@kernel.org>
        <20200214225305.48550d6a@oasis.local.home>
        <20200215110111.GZ2935@paulmck-ThinkPad-P72>
        <20200215134208.GA9879@paulmck-ThinkPad-P72>
        <20200217152517.26cc11ea@gandalf.local.home>
        <20200217220356.GY2935@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 17 Feb 2020 14:03:56 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> And what is a day without micro-optimization of a slowpath?  :-)

A day you have off, but still find yourself working ;-)

> 
> OK, let's see...
> 
> Grace-period kthread wakeups are normally mediated by rcu_start_this_gp(),
> which uses a funnel lock to consolidate concurrent requests to start
> a grace period.  If a grace period is already in progress, it refrains
> from doing a wakeup because that means that the grace-period kthread
> will check for another grace period being needed at the end of the
> current grace period.
> 
> Exceptions include:
> 
> o	The wakeup reporting the last quiescent state of the current
> 	grace period.
> 
> o	Emergency situations such as callback overloads and RCU CPU stalls.
> 
> So on a busy system that is not overloaded, the common case is that
> rcu_gp_kthread_wake() is invoked only once per grace period because there
> is no emergency and there is a grace period in progress.  If this system
> has short idle periods and a fair number of quiescent states, a reasonable
> amount of idle time, then the last quiescent state will not normally be
> detected by the grace-period kthread.  But workloads can of course vary.
> 
> The "!t" holds only during early boot.  So we could put a likely() around
> the "t".  But more to the point, at runtime, "!t" would always be false,
> so it really should be last in the list of "||" clauses.  This isn't
> enough of a fastpath for a static branch to make sense.

Hey! Does that mean we can add a static branch for that check?


struct static_key rcu_booting = STATIC_KEY_INIT_TRUE;

[...]

	if (READ_ONCE(rcu_state.gp_flags) ||
	    (current == t && !in_irq() && !in_serving_softirq())
		return;

	if (static_branch_unlikely(&rcu_booting) && !t)
		return;

At end of boot:

	static_key_disable(&rcu_booting);

That way we can really micro-optimize the slow path, and it basically
becomes a nop!

-- Steve

> 
> The "!READ_ONCE(rcu_state.gp_flags)" will normally hold, though it is
> false often enough to pay for itself.  Or has been in the past, anyway.
> I suspect that access to the global variable rcu_state.gp_flags is not
> always fast either.
> 
> So I am having difficulty talking myself into modifying this one given
> the frequency of operations.
> 
> 							Thanx, Paul

