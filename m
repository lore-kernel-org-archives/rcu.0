Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5F9C433FE
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F40660E94
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhJFPPc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Oct 2021 11:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbhJFPPb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Oct 2021 11:15:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61DD460F41;
        Wed,  6 Oct 2021 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633533219;
        bh=EVmb4kirYxxRbhN6bHVfWsWVSxxibQUQbKgIpq0U4Lw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tLu9CimrveddQ6EYZLM8TvjgiGwPNRa3iBI4to+CyqdiiMopEwFVgsokgXcp7q4g6
         wpW4xmB5/BqJSe/ZM81DDY4U9W2wsCgGbRBwBj8rhFfKFVJUK5fEACVwOXTyVuzQP5
         5Ywh/ksp6sHT5oE7g75/rjZlhJERX+b215DYPjbcyqFMgrA+ZRU0oBaiN0a931/KF/
         n/oXh2+XYyp1ztY1OYlI0W2+KOndny56k09uIqRdVPFDx7QcPJRvbM4Qm224P3zgIQ
         LqCW86rcs614M1RAUy69icLG+d+KwG66Q38Fh1MH+Fp7o13McchLvC9SY3vAPwhFTM
         8ZYX6tDBOCpUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 31A935C0800; Wed,  6 Oct 2021 08:13:39 -0700 (PDT)
Date:   Wed, 6 Oct 2021 08:13:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB
 + a few other fixes
Message-ID: <20211006151339.GA422833@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210929221012.228270-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 30, 2021 at 12:10:01AM +0200, Frederic Weisbecker wrote:
> PREEMPT_RT has made rcu_core() preemptible, making it unsafe against
> concurrent NOCB (de-)offloading.
> 
> Thomas suggested to drop the local_lock() based solution and simply
> check the offloaded state while context looks safe but that's not
> enough. Here is a bit of rework.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/rt
> 
> HEAD: aac1c58961446c731f2e989bd822ca1fd2659bad

Many of these look quite good, but any chance of getting an official
Tested-by from someone in the -rt community?

							Thanx, Paul

> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (10):
>       rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
>       rcu/nocb: Prepare state machine for a new step
>       rcu/nocb: Invoke rcu_core() at the start of deoffloading
>       rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
>       rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
>       rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
>       rcu/nocb: Limit number of softirq callbacks only on softirq
>       rcu: Fix callbacks processing time limit retaining cond_resched()
>       rcu: Apply callbacks processing time limit only on softirq
>       rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
> 
> Thomas Gleixner (1):
>       rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe
> 
> 
>  include/linux/rcu_segcblist.h | 51 +++++++++++++++++++-------
>  kernel/rcu/rcu_segcblist.c    | 10 ++---
>  kernel/rcu/rcu_segcblist.h    |  7 ++--
>  kernel/rcu/tree.c             | 85 ++++++++++++++++++++++++++++++-------------
>  kernel/rcu/tree.h             | 16 +++++---
>  kernel/rcu/tree_nocb.h        | 29 ++++++++++++---
>  6 files changed, 136 insertions(+), 62 deletions(-)
