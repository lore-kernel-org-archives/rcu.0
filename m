Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFA8C4332F
	for <rcu@archiver.kernel.org>; Fri,  8 Oct 2021 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF40461039
	for <rcu@archiver.kernel.org>; Fri,  8 Oct 2021 14:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhJHOFI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Oct 2021 10:05:08 -0400
Received: from foss.arm.com ([217.140.110.172]:54092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234083AbhJHOFI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Oct 2021 10:05:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93B316D;
        Fri,  8 Oct 2021 07:03:12 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1E253F66F;
        Fri,  8 Oct 2021 07:03:10 -0700 (PDT)
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
Subject: Re: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB + a few other fixes
In-Reply-To: <87fstkmybc.mognet@arm.com>
References: <20210929221012.228270-1-frederic@kernel.org> <87fstkmybc.mognet@arm.com>
Date:   Fri, 08 Oct 2021 15:03:02 +0100
Message-ID: <87ee8vlill.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 01/10/21 18:47, Valentin Schneider wrote:
> On 30/09/21 00:10, Frederic Weisbecker wrote:
>> PREEMPT_RT has made rcu_core() preemptible, making it unsafe against
>> concurrent NOCB (de-)offloading.
>>
>> Thomas suggested to drop the local_lock() based solution and simply
>> check the offloaded state while context looks safe but that's not
>> enough. Here is a bit of rework.
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
>>       rcu/rt
>>
>> HEAD: aac1c58961446c731f2e989bd822ca1fd2659bad
>>
>> Thanks,
>>       Frederic
>
> FWIW I've had RCU torture with NOCB toggling running for half a day on my
> Arm Juno and nothing to report. I still need to rebase this on an -rt tree
> and give it a spin with CONFIG_PREEMPT_RT.

Rebased on top of v5.15-rc4-rt7-rebase with Thomas' patch reverted and ran
the same thing under CONFIG_PREEMPT_RT, nothing seems to catch on fire, so:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
