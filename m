Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B49C433F5
	for <rcu@archiver.kernel.org>; Thu, 14 Oct 2021 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E757061027
	for <rcu@archiver.kernel.org>; Thu, 14 Oct 2021 11:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhJNLow (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Oct 2021 07:44:52 -0400
Received: from foss.arm.com ([217.140.110.172]:53700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhJNLow (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Oct 2021 07:44:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 808412F;
        Thu, 14 Oct 2021 04:42:47 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECFDD3F66F;
        Thu, 14 Oct 2021 04:42:45 -0700 (PDT)
From:   Valentin Schneider <Valentin.Schneider@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 03/11] rcu/nocb: Invoke rcu_core() at the start of deoffloading
In-Reply-To: <YWcEXj2+nqO8kIFS@boqun-archlinux>
References: <20211011145140.359412-1-frederic@kernel.org> <20211011145140.359412-4-frederic@kernel.org> <YWcEXj2+nqO8kIFS@boqun-archlinux>
Date:   Thu, 14 Oct 2021 12:42:40 +0100
Message-ID: <87o87rkf2n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 14/10/21 00:07, Boqun Feng wrote:
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index e38028d48648..b236271b9022 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2717,6 +2717,23 @@ static __latent_entropy void rcu_core(void)
>>      unsigned long flags;
>>      struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
>>      struct rcu_node *rnp = rdp->mynode;
>> +	/*
>> +	 * On RT rcu_core() can be preempted when IRQs aren't disabled.
>> +	 * Therefore this function can race with concurrent NOCB (de-)offloading
>> +	 * on this CPU and the below condition must be considered volatile.
>> +	 * However if we race with:
>> +	 *
>> +	 * _ Offloading:   In the worst case we accelerate or process callbacks
>> +	 *                 concurrently with NOCB kthreads. We are guaranteed to
>> +	 *                 call rcu_nocb_lock() if that happens.
>
> If offloading races with rcu_core(), can the following happen?
>
>       <offload work>
>       rcu_nocb_rdp_offload():
>                                               rcu_core():
>                                                 ...
>                                                 rcu_nocb_lock_irqsave(); // no a lock
>         raw_spin_lock_irqsave(->nocb_lock);
>           rdp_offload_toggle():
>             <LOCKING | OFFLOADED set>
>                                                 if (!rcu_segcblist_restempty(...))
>                                                   rcu_accelerate_cbs_unlocked(...);
>                                                 rcu_nocb_unlock_irqrestore();
>                                                 // ^ a real unlock,
>                                                 // and will preempt_enable()
>           // offload continue with ->nocb_lock not held
>
> If this can happen, it means an unpaired preempt_enable() and an
> incorrect unlock. Thoughts? Maybe I'm missing something here?
>

As Frederic pointed out in an earlier thread [1], this can't happen because
we still have IRQs disabled, and the offloading process has to be processed
on the CPU being offloaded. IOW, in the above scenario, rcu_core() can't be
preempted by the rcu_nocb_rdp_offload() work until it re-enables IRQs at
rcu_nocb_unlock_irqrestore().

(hopefully Paul or Frederic will correct me if I've just spewed garbage)

[1]: https://lore.kernel.org/lkml/20210930105340.GA232241@lothringen/

> Regards,
> Boqun
>
