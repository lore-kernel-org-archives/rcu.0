Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ECDC433EF
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670AC61A10
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354822AbhJARwo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:52:44 -0400
Received: from foss.arm.com ([217.140.110.172]:49486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355237AbhJARwn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Oct 2021 13:52:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40986106F;
        Fri,  1 Oct 2021 10:50:59 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 942EC3F70D;
        Fri,  1 Oct 2021 10:50:57 -0700 (PDT)
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
Subject: Re: [PATCH 07/11] rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
In-Reply-To: <20210929221012.228270-8-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org> <20210929221012.228270-8-frederic@kernel.org>
Date:   Fri, 01 Oct 2021 18:50:55 +0100
Message-ID: <878rzcmy68.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/09/21 00:10, Frederic Weisbecker wrote:
> Instead of hardcoding IRQ save and nocb lock, use the consolidated
> API.
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

Just one comment nit below.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/rcu/tree.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b1fc6e498d90..1971a4e15e96 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2492,8 +2492,7 @@ static void rcu_do_batch(struct rcu_data *rdp)

While at it:

-	 * Extract the list of ready callbacks, disabling to prevent
+-	 * Extract the list of ready callbacks, disabling IRQs to prevent

>        * races with call_rcu() from interrupt handlers.  Leave the
>        * callback counts, as rcu_barrier() needs to be conservative.
>        */
> -	local_irq_save(flags);
> -	rcu_nocb_lock(rdp);
> +	rcu_nocb_lock_irqsave(rdp, flags);
>       WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
>       pending = rcu_segcblist_n_cbs(&rdp->cblist);
>       div = READ_ONCE(rcu_divisor);
