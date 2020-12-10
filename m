Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AB5C433FE
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 00:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8913233EF
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 00:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgLJAvp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:51:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbgLJAvi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 19:51:38 -0500
Date:   Wed, 9 Dec 2020 16:50:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607561457;
        bh=FKfFS3P2tnXTZ5B8IbXhgv+55qT0M8nfUMu7IrEthgc=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FDyARYbNQjfJaTRX2p/Wdcca0eb6731Zy/WVMOEwsSn72g3e0wgyRWCfpFy9PIbxm
         2mUWwzkDZysLzsHdcnCgzNeuL0TFaQNnC8B/9H4EJ9KESqiFS67t1lBFqWqHelkDlU
         t6sthdQuDrmyhFaNVzcm/14uz5llqVNPJNY5LRb9FVMsUdTDiHELkJoRiZt0mdVI13
         KyUhol7NYWnflqzMBDDjo1ureJI0OAcmpmA9+5aQ/Rp/UtqqdiNJcUdYFMi457O6ig
         V/g6VbA3ZEug8UJu3qsVDijt3OL4FSW23ekqfl55O24/cRb/G/z3RwtecCEXIHzZrZ
         lXoOK148V/WtA==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201210005056.GM2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201208145810.GA4875@paulmck-ThinkPad-P72>
 <20201208155457.GA3916@lothringen>
 <20201208171927.GS2657@paulmck-ThinkPad-P72>
 <20201208175230.GB3916@lothringen>
 <20201208182409.GT2657@paulmck-ThinkPad-P72>
 <20201208220438.GC3916@lothringen>
 <20201209021449.GK3025@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209021449.GK3025@boqun-archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 10:14:49AM +0800, Boqun Feng wrote:
> Hi Frederic,
> 
> On Tue, Dec 08, 2020 at 11:04:38PM +0100, Frederic Weisbecker wrote:
> > On Tue, Dec 08, 2020 at 10:24:09AM -0800, Paul E. McKenney wrote:
> > > > It reduces the code scope running with BH disabled.
> > > > Also narrowing down helps to understand what it actually protects.
> > > 
> > > I thought that you would call out unnecessarily delaying other softirq
> > > handlers.  ;-)
> > > 
> > > But if such delays are a problem (and they might well be), then to
> > > avoid them on non-rcu_nocb CPUs would instead/also require changing the
> > > early-exit checks to check for other pending softirqs to the existing
> > > checks involving time, need_resched, and idle.  At which point, entering and
> > > exiting BH-disabled again doesn't help, other than your point about the
> > > difference in BH-disabled scopes on rcu_nocb and non-rcu_nocb CPUs.
> > 
> > Wise observation!
> > 
> > > 
> > > Would it make sense to exit rcu_do_batch() if more than some amount
> > > of time had elapsed and there was some non-RCU softirq pending?
> > > 
> > > My guess is that the current tlimit checks in rcu_do_batch() make this
> > > unnecessary.
> > 
> > Right and nobody has complained about it so far.
> > 
> > But I should add a comment explaining the reason for the BH-disabled
> > section in my series.
> > 
> 
> Some background for the original question: I'm revisiting the wait
> context checking feature of lockdep (which can detect bugs like
> acquiring a spinlock_t lock inside a raw_spinlock_t), I've post my first
> version:
> 
> 	https://lore.kernel.org/lkml/20201208103112.2838119-1-boqun.feng@gmail.com/	
> 
> , and will surely copy you in the next version ;-)
> 
> The reason I asked for the RCU callback context requirement is that we
> have the virtual lock (rcu_callback_map) that marks a RCU callback
> context, so if RCU callback contexts have special restrictions on the
> locking usage inside, we can use the wait context checking to do the
> check (like what I did in the patch #3 of the above series).
> 
> My current summary is that since in certain configs (use_softirq is true
> and nocb is disabled) RCU callbacks are executed in a softirq context,
> so the least requirement for any RCU callbacks is they need to obey the
> rules in softirq contexts. And yes, I'm aware that in some configs, RCU
> callbacks are not executed in a softirq context (sometimes, even the BH
> is not disabled), but we need to make all the callback work in the
> "worst" (or strictest) case (callbacks executing in softirq contexts).
> Currently, the effect of using wait context for rcu_callback_map in my
> patchset is that lockdep will complain if a RCU callback use a mutex or
> other sleepable locks, but using spinlock_t (even in PREEMPT_RT) won't
> cause lockdep to complain. Am I getting this correct?

It matches what I know.  And yes, in PREEMPT_RT, softirq is preemptible,
allowing spinlock_t to be used, but there are restrictions that
lopckdep enforces.  I am not going to claim to remember the exact set
of restrictions.

							Thanx, Paul
