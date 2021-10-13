Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C454C433EF
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 03:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1744260E0C
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 03:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhJMDaf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Oct 2021 23:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237161AbhJMDae (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Oct 2021 23:30:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F97960551;
        Wed, 13 Oct 2021 03:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634095712;
        bh=PZmKYywtaXhvP9BNydlKqgBxJy0a2ZLT5or+sly/VBM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FQK7INIwFBmlVpK7Gm4MpYoLUHqw1V84lh1LbYe9UVSCpH57RSkngsVNbekGQBlxF
         TR3Z4YSvhocQTDKTOQkY8BgRULrBMalR385M3UYonKLpvpIGy+L5LIpYkkezVoPW+5
         mOSwkSC9Ye4BQiZTUW8WZicBSH6JGanU6clP45FTNFNs4UHa7Dk5s836pQlcI12/Co
         yrYTqUBFIQjAnPabKMu5cQ5tjJhLRyMQfaMUr+nBC6QW231LKbH36nrVA6/hoA2HJ0
         gy1rc9c7ZoOCv8ualSUAJ645v0aQojx4XKB3TE39OoUBQoNMtvGT3IDq3v4zic0itg
         N8CuglBTf/3Mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 33FB05C0887; Tue, 12 Oct 2021 20:28:32 -0700 (PDT)
Date:   Tue, 12 Oct 2021 20:28:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB
 + a few other fixes v2
Message-ID: <20211013032832.GQ880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211011145140.359412-1-frederic@kernel.org>
 <20211013003215.GP880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013003215.GP880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 12, 2021 at 05:32:15PM -0700, Paul E. McKenney wrote:
> On Mon, Oct 11, 2021 at 04:51:29PM +0200, Frederic Weisbecker wrote:
> > Hi,
> > 
> > No code change in this v2, only changelogs:
> > 
> > * Add tags from Valentin and Sebastian
> > 
> > * Remove last reference to SEGCBLIST_SOFTIRQ_ONLY (thanks Valentin)
> > 
> > * Rewrite changelog for "rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check"
> >   after off-list debates with Paul.
> > 
> > * Remove the scenario with softirq interrupting rcuc on
> >   "rcu/nocb: Limit number of softirq callbacks only on softirq" as it's
> >   probably not possible (thanks Valentin).
> > 
> > * Remove the scenario with task spent scheduling out accounted on tlimit
> >   as it's not possible (thanks Valentin)
> >   (see "rcu: Apply callbacks processing time limit only on softirq")
> > 
> > * Fixed changelog of
> >   "rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread"
> >   (thanks Sebastian).
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	rcu/rt-v2
> > 
> > HEAD: 2c9349986d5f70a555195139665841cd98e9aba4
> > 
> > Thanks,
> > 	Frederic
> 
> Nice!
> 
> I queued these for further review and testing.  I reworked the commit log
> of 6/11 to give my idea of the reason, though I freely admit that this
> reason is not as compelling as it no doubt seemed when I wrote that code.

But in initial tests TREE04.5, TREE04.6, and TREE04.9 all hit the
WARN_ON(1) in rcu_torture_barrier(), which indicates rcu_barrier()
breakage.  My best (but not so good) guess is a five-hour MTBF on a
dual-socket system.

I started an automated "git bisect" with each step running 100 hours
of TREE04, but I would be surprised if anything useful comes of it.
Pleased, mind you, but surprised.

							Thanx, Paul

> > ---
> > 
> > Frederic Weisbecker (10):
> >       rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
> >       rcu/nocb: Prepare state machine for a new step
> >       rcu/nocb: Invoke rcu_core() at the start of deoffloading
> >       rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
> >       rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
> >       rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
> >       rcu/nocb: Limit number of softirq callbacks only on softirq
> >       rcu: Fix callbacks processing time limit retaining cond_resched()
> >       rcu: Apply callbacks processing time limit only on softirq
> >       rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
> > 
> > Thomas Gleixner (1):
> >       rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe
> > 
> > 
> >  include/linux/rcu_segcblist.h | 51 ++++++++++++++++++-------
> >  kernel/rcu/rcu_segcblist.c    | 10 ++---
> >  kernel/rcu/rcu_segcblist.h    | 12 +++---
> >  kernel/rcu/tree.c             | 87 +++++++++++++++++++++++++++++--------------
> >  kernel/rcu/tree.h             | 16 +++++---
> >  kernel/rcu/tree_nocb.h        | 29 ++++++++++++---
> >  6 files changed, 141 insertions(+), 64 deletions(-)
