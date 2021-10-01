Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF0BC433FE
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72DC619F8
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355137AbhJARuT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:50:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232413AbhJARuR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Oct 2021 13:50:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E463B106F;
        Fri,  1 Oct 2021 10:48:31 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4347C3F70D;
        Fri,  1 Oct 2021 10:48:30 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 02/11] rcu/nocb: Prepare state machine for a new step
In-Reply-To: <20210929221012.228270-3-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org> <20210929221012.228270-3-frederic@kernel.org>
Date:   Fri, 01 Oct 2021 18:48:28 +0100
Message-ID: <87ee94myab.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/09/21 00:10, Frederic Weisbecker wrote:
> Currently SEGCBLIST_SOFTIRQ_ONLY is a bit of an exception among the
> segcblist flags because it is an exclusive state that doesn't mix up
> with the other flags. Remove it in favour of:
>
> _ A flag specifying that rcu_core() needs to perform callbacks execution
>   and acceleration
>
> and
>
> _ A flag specifying we want the nocb lock to be held in any needed
>   circumstances
>
> This clarifies the code and is more flexible: It allows to have a state
> where rcu_core() runs with locking while offloading hasn't started yet.
> This is a necessary step to prepare for triggering rcu_core() at the
> very beginning of the de-offloading process so that rcu_core() won't
> dismiss work while being preempted by the de-offloading process, at
> least not without a pending subsequent rcu_core() that will quickly
> catch up.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

One question and a comment nit below, other than that:

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>

> @@ -84,7 +84,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
>  static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)

It doesn't show up on the diff but there's a SEGCBLIST_SOFTIRQ_ONLY
straggler in the comment above (the last one according to grep).

>  {
>       if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -	    !rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
> +	    rcu_segcblist_test_flags(rsclp, SEGCBLIST_LOCKING))
>               return true;
>
>       return false;

> @@ -1000,12 +1000,12 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>        */
>       rcu_nocb_lock_irqsave(rdp, flags);
>       /*
> -	 * Theoretically we could set SEGCBLIST_SOFTIRQ_ONLY after the nocb
> +	 * Theoretically we could clear SEGCBLIST_LOCKING after the nocb
>        * lock is released but how about being paranoid for once?
>        */
> -	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
> +	rcu_segcblist_clear_flags(cblist, SEGCBLIST_LOCKING);

Thought experiment for me; AFAICT the comment still holds: we can't offload
until deoffload has finished, and we shouldn't be able to preempt
rcu_core() while it holds ->nocb_lock. With that said, I'm all for
paranoia.

>       /*
> -	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
> +	 * Without SEGCBLIST_LOCKING, we can't use
>        * rcu_nocb_unlock_irqrestore() anymore.
>        */
>       raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
