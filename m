Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4042C55189
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 13:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814BB2084D
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587562428;
	bh=qzzLIdzmHWdekVJh4YnpLBfKFgYwrVRZBBV6qa29Sic=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XW6S1jS7ZM1Mt9Bjr1IXK9NNgYaLy4c9+XT7Pw3QjXO8aqtzWK3LWzZnxoxBLw+iO
	 7VTSLG6fiYvrRZqDcGBorb15LDEY0QVb8PDQz/tQeTJXIjlnmWdpFLsCJ+PLpObhyT
	 DINbM+kPyeaIuUGH5VH5Iyab7tRXkDqGL2wUiL3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDVNds (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgDVNdr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Apr 2020 09:33:47 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E908820774;
        Wed, 22 Apr 2020 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587562427;
        bh=qzzLIdzmHWdekVJh4YnpLBfKFgYwrVRZBBV6qa29Sic=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eyvL68sA8OyLCzHjHvKDM5aBmaDr8P8lBCxa64idhSs66vQq4g6PB8dmxt7HOzuMa
         xUxVZdF7MAwh83TkoKZCRvQwGWrApUJ+H4ELbYEo4ow3XMl5aOJCKkbJcpcsIc6X0q
         ZuFRZiJ8Nxp09C4cL6fjRbz+r9rTRh2wPx81xFu8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C51713522EFF; Wed, 22 Apr 2020 06:33:46 -0700 (PDT)
Date:   Wed, 22 Apr 2020 06:33:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200422133346.GN17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200420162900.GA11867@pc636>
 <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200421133947.cmdchrx73ru7szuz@linutronix.de>
 <20200421154101.GN17661@paulmck-ThinkPad-P72>
 <20200421170556.lvgb6gtjivjbr7gl@linutronix.de>
 <20200421180914.GT17661@paulmck-ThinkPad-P72>
 <20200422111324.cummbkw2faxoeaxk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422111324.cummbkw2faxoeaxk@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 22, 2020 at 01:13:24PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-21 11:09:14 [-0700], Paul E. McKenney wrote:
> > > Yes but why do we do this raw_spinlock_t here? It is not yet needed on
> > > v5.6-RT as I *did* check. It also complicates the code for !RT but
> > > nobody responded to that part but…
> > 
> > I did respond by pointing out that the essentially similar call_rcu()
> > function ends up being invoked pretty much everywhere, including early
> > boot before rcu_init() has been invoked.  It is therefore only reasonable
> > to assume that there will be a need for kfree_rcu() to tolerate a similar
> > range of calling contexts.
> 
> Early in the boot we have IRQs disabled but also one CPU and no
> scheduling. That means that not a single lock is contained.

You are saying that call_rcu() is never invoked while holding a raw
spinlock?

> > > That said: the current memory allocation is the problem here. The
> > > remaining part is fine. The part under the lock is small enough so it
> > > should not cause the trouble if it invokes queue_work() which will
> > > "only" enqueue the timer. 
> > 
> > To your point, the small memory allocation will be going away.  The
> > memory allocations will pull in 4K pages of pointers.
> 
> Oki.
> 
> > On the timer, are you thinking of the queue_work() calls or instead of
> > the queue_delayed_work() calls?
> 
> As of now, on the "first" invocation of kfree_rcu() it invokes
> queue_delayed_work(). The work is not active, the timer is not pending
> so it always enqueues a new timer.

Fair enough, and thank you for checking!

The other work-queuing operations are also OK as they are, then?

> > > Side question: Is there any real-life workloads that benefits from this?
> > > I'm asking because rcuperf allocates the kfree_rcu() the pointer right
> > > away. The chances are high that the pointer are fed from the same page.
> > > SLUB's build_detached_freelist() scans the page of RCU's pointers to
> > > ensure that they are in the same page and then slab_free() them in one
> > > go. There is lookahead = 3 so it finds three different pages it stops
> > > further scanning and does slab_free() with what it found so far.
> > > 
> > > Which means if your kfree_rcu() collects random pointer from the system,
> > > they may belong to different pages (especially if they are part of
> > > different "types").
> > 
> > It gets significantly better performance as it currently is due to
> > the reduced cache-miss rate scanning pointers in a page as opposed to
> > pointer-chasing through a series of rcu_head pointers.
> 
> So the performance boost is not due to kfree_bulk() but due to the
> pointers which are "in ordered".

Almost.  Rather that the performance boost due to the cache locality
of the pointers justifies the change.  The performance boost due to
kfree_bulk() can sometimes help further, for example, when a large number
of objects from the same slab are freed.

Again, thank you for digging into this!

							Thanx, Paul

> > Yes, it might be even better if kfree_rcu() further sorted the freed
> > objects per slab or maybe even per page within a slab, but one step at
> > a time!  For one thing, it is not hard to imagine situations where this
> > further sorting actually slowed things down, especially if the system
> > was under any sort of memory pressure or if the kfree_rcu() calls were
> > scattered across so many slabs and pages that it essentially reverted
> > back to pointer chasing.
> 
> Okay.
> 
> > Make sense, or am I missing your point?
> 
> No, you got it.
> 
> > 							Thanx, Paul
> 
> Sebastian
