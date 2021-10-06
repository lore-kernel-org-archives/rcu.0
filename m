Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D838C433F5
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 15:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441B360F22
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 15:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhJFPOI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Oct 2021 11:14:08 -0400
Received: from foss.arm.com ([217.140.110.172]:35868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhJFPOI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Oct 2021 11:14:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0E706D;
        Wed,  6 Oct 2021 08:12:15 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 485D23F66F;
        Wed,  6 Oct 2021 08:12:14 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 10/11] rcu: Apply callbacks processing time limit only on softirq
In-Reply-To: <20211004134748.GD273854@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org> <20210929221012.228270-11-frederic@kernel.org> <874ka0my57.mognet@arm.com> <20211004134748.GD273854@lothringen>
Date:   Wed, 06 Oct 2021 16:12:12 +0100
Message-ID: <87ilyakx0z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 04/10/21 15:47, Frederic Weisbecker wrote:
> On Fri, Oct 01, 2021 at 06:51:32PM +0100, Valentin Schneider wrote:
>> On 30/09/21 00:10, Frederic Weisbecker wrote:
>> > Time limit only makes sense when callbacks are serviced in softirq mode
>> > because:
>> >
>> > _ In case we need to get back to the scheduler,
>> >   cond_resched_tasks_rcu_qs() is called after each callback.
>> >
>> > _ In case some other softirq vector needs the CPU, the call to
>> >   local_bh_enable() before cond_resched_tasks_rcu_qs() takes care about
>> >   them via a call to do_softirq().
>> >
>> > _ The time spent on other tasks after scheduling out, or on softirqs
>> >   processing, is spuriously accounted to the time limit.
>> >
>>
>> That wasn't the case before ("rcu: Fix callbacks processing time limit
>> retaining cond_resched()")
>
> But if cond_resched_tasks_rcu_qs() was called and then on the next iteration
> tlimit is checked, the time spent scheduling out is included, right?
>

if tlimit was set, then that branch would either continue or break; both
cases would have skipped over the cond_resched_tasks_rcu_qs() (which the
aforementioned patch addresses).
