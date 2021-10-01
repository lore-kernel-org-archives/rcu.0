Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC04C433F5
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F8E61A10
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354890AbhJARvx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:51:53 -0400
Received: from foss.arm.com ([217.140.110.172]:49414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354843AbhJARvw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Oct 2021 13:51:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48377106F;
        Fri,  1 Oct 2021 10:50:08 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E41F3F70D;
        Fri,  1 Oct 2021 10:50:06 -0700 (PDT)
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
Subject: Re: [PATCH 03/11] rcu/nocb: Invoke rcu_core() at the start of deoffloading
In-Reply-To: <20210929221012.228270-4-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org> <20210929221012.228270-4-frederic@kernel.org>
Date:   Fri, 01 Oct 2021 18:50:04 +0100
Message-ID: <87czoomy7n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/09/21 00:10, Frederic Weisbecker wrote:
> On PREEMPT_RT, if rcu_core() is preempted by the de-offloading process,
> some work, such as callbacks acceleration and invocation, may be left
> unattended due to the volatile checks on the offloaded state.
>
> In the worst case this work is postponed until the next rcu_pending()
> check that can take a jiffy to reach, which can be a problem in case
> of callbacks flooding.
>
> Solve that with invoking rcu_core() early in the de-offloading process.
> This way any work dismissed by an ongoing rcu_core() call fooled by
> a preempting deoffloading process will be caught up by a nearby future
> recall to rcu_core(), this time fully aware of the de-offloading state.
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

One comment/question below.

> @@ -990,6 +990,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>        * will refuse to put anything into the bypass.
>        */
>       WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +	/*
> +	 * Start with invoking rcu_core() early. This way if the current thread
> +	 * happens to preempt an ongoing call to rcu_core() in the middle,
> +	 * leaving some work dismissed because rcu_core() still thinks the rdp is
> +	 * completely offloaded, we are guaranteed a nearby future instance of
> +	 * rcu_core() to catch up.
> +	 */
> +	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
> +	invoke_rcu_core();

I think your approach is a bit neater, but would there have been any issue
with keeping the setting of SEGCBLIST_RCU_CORE within
rcu_segcblist_offload() and bundling it with an invoke_rcu_core()?

>       ret = rdp_offload_toggle(rdp, false, flags);
>       swait_event_exclusive(rdp->nocb_state_wq,
>                             !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
> --
> 2.25.1
