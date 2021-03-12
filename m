Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19607C433DB
	for <rcu@archiver.kernel.org>; Fri, 12 Mar 2021 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC48164F33
	for <rcu@archiver.kernel.org>; Fri, 12 Mar 2021 12:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCLMVt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Mar 2021 07:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhCLMVo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Mar 2021 07:21:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 043B864FE0;
        Fri, 12 Mar 2021 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615551704;
        bh=EtZwk9sCzvWQTPoveCLQpt9Cf8m8GAQV77KFCohEb4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2e3ILe91/LWHXMepsrh2p1QL+TATAabouzwsWJBrRwJ5ekHpA+APqjscI6ng1pZo
         bGwrzfRCSVuparip8ONlTEHuUnNTvWWtA6OKjyhMAMk+Zo71EjmmkNfvVDNfKWy5h+
         4995apP9sccb8cjJSsqgF8BCKO+SHabPyDQeioI5/Y3khh9/pw1w+qUUhZgPB+Sna3
         lBUX+26UeHxmIZFQSVMhWU3ERQkmqOQs5x347s9KIDLl86C2C4pjm94O3CDirIf5Wf
         zV1Dop5mu0BoVu/GOgS82CcC7ukGJjTr/q5PxQ4JETRmh5QpbNsR6Bry2GPHnn6K91
         n69aVxeGXcdAA==
Date:   Fri, 12 Mar 2021 13:21:42 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for
 Tree RCU grace periods
Message-ID: <20210312122142.GB3646@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304002632.23870-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 03, 2021 at 04:26:30PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a non-blocking polling interface for RCU grace
> periods, so this commit supplies start_poll_synchronize_rcu() and
> poll_state_synchronize_rcu() for this purpose.  Note that the existing
> get_state_synchronize_rcu() may be used if future grace periods are
> inevitable (perhaps due to a later call_rcu() invocation).  The new
> start_poll_synchronize_rcu() is to be used if future grace periods
> might not otherwise happen.

By future grace period, you mean if a grace period has been started right
_before_ we start polling, right?


> Finally, poll_state_synchronize_rcu()
> provides a lockless check for a grace period having elapsed since
> the corresponding call to either of the get_state_synchronize_rcu()
> or start_poll_synchronize_rcu().
> 
> As with get_state_synchronize_rcu(), the return value from either
> get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
> to a later call to either poll_state_synchronize_rcu() or the existing
> (might_sleep) cond_synchronize_rcu().
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[...]
>  /**
> + * start_poll_state_synchronize_rcu - Snapshot and start RCU grace period
> + *
> + * Returns a cookie that is used by a later call to cond_synchronize_rcu()
> + * or poll_state_synchronize_rcu() to determine whether or not a full
> + * grace period has elapsed in the meantime.  If the needed grace period
> + * is not already slated to start, notifies RCU core of the need for that
> + * grace period.
> + *
> + * Interrupts must be enabled for the case where it is necessary to awaken
> + * the grace-period kthread.
> + */
> +unsigned long start_poll_synchronize_rcu(void)
> +{
> +	unsigned long flags;
> +	unsigned long gp_seq = get_state_synchronize_rcu();
> +	bool needwake;
> +	struct rcu_data *rdp;
> +	struct rcu_node *rnp;
> +
> +	lockdep_assert_irqs_enabled();
> +	local_irq_save(flags);
> +	rdp = this_cpu_ptr(&rcu_data);
> +	rnp = rdp->mynode;
> +	raw_spin_lock_rcu_node(rnp); // irqs already disabled.
> +	needwake = rcu_start_this_gp(rnp, rdp, gp_seq);

I'm a bit surprised we don't start a new grace period instead of snapshotting
the current one.

So if we do this:

   //start grace period gp_num=5

   old = p;
   rcu_assign_pointer(p, new);

   num = start_poll_synchronize_rcu(); // num = 5

   //grace period ends, start new gp_num=6

   poll_state_synchronize_rcu(num); // rcu seq is done

   kfree(old);

Isn't there a risk that other CPUs still see the old pointer?

Of course I know I'm missing something obvious :-)

Thanks.
