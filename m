Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DEBC433EF
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A526A61A10
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhJARtr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:49:47 -0400
Received: from foss.arm.com ([217.140.110.172]:49340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhJARtr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Oct 2021 13:49:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF1C5106F;
        Fri,  1 Oct 2021 10:48:01 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D0993F70D;
        Fri,  1 Oct 2021 10:47:59 -0700 (PDT)
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
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
Date:   Fri, 01 Oct 2021 18:47:51 +0100
Message-ID: <87fstkmybc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/09/21 00:10, Frederic Weisbecker wrote:
> PREEMPT_RT has made rcu_core() preemptible, making it unsafe against
> concurrent NOCB (de-)offloading.
>
> Thomas suggested to drop the local_lock() based solution and simply
> check the offloaded state while context looks safe but that's not
> enough. Here is a bit of rework.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
>       rcu/rt
>
> HEAD: aac1c58961446c731f2e989bd822ca1fd2659bad
>
> Thanks,
>       Frederic

FWIW I've had RCU torture with NOCB toggling running for half a day on my
Arm Juno and nothing to report. I still need to rebase this on an -rt tree
and give it a spin with CONFIG_PREEMPT_RT.
