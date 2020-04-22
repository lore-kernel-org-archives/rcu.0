Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF4EC55189
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 11:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B9F20774
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 11:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgDVLNc convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Wed, 22 Apr 2020 07:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725924AbgDVLNc (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 22 Apr 2020 07:13:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60BEC03C1A8
        for <rcu@vger.kernel.org>; Wed, 22 Apr 2020 04:13:31 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRDJl-0006No-3x; Wed, 22 Apr 2020 13:13:25 +0200
Date:   Wed, 22 Apr 2020 13:13:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200422111324.cummbkw2faxoeaxk@linutronix.de>
References: <20200420162534.GD17661@paulmck-ThinkPad-P72>
 <20200420162900.GA11867@pc636>
 <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200421133947.cmdchrx73ru7szuz@linutronix.de>
 <20200421154101.GN17661@paulmck-ThinkPad-P72>
 <20200421170556.lvgb6gtjivjbr7gl@linutronix.de>
 <20200421180914.GT17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200421180914.GT17661@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-21 11:09:14 [-0700], Paul E. McKenney wrote:
> > Yes but why do we do this raw_spinlock_t here? It is not yet needed on
> > v5.6-RT as I *did* check. It also complicates the code for !RT but
> > nobody responded to that part but…
> 
> I did respond by pointing out that the essentially similar call_rcu()
> function ends up being invoked pretty much everywhere, including early
> boot before rcu_init() has been invoked.  It is therefore only reasonable
> to assume that there will be a need for kfree_rcu() to tolerate a similar
> range of calling contexts.

Early in the boot we have IRQs disabled but also one CPU and no
scheduling. That means that not a single lock is contained.

> > That said: the current memory allocation is the problem here. The
> > remaining part is fine. The part under the lock is small enough so it
> > should not cause the trouble if it invokes queue_work() which will
> > "only" enqueue the timer. 
> 
> To your point, the small memory allocation will be going away.  The
> memory allocations will pull in 4K pages of pointers.

Oki.

> On the timer, are you thinking of the queue_work() calls or instead of
> the queue_delayed_work() calls?

As of now, on the "first" invocation of kfree_rcu() it invokes
queue_delayed_work(). The work is not active, the timer is not pending
so it always enqueues a new timer.

> > Side question: Is there any real-life workloads that benefits from this?
> > I'm asking because rcuperf allocates the kfree_rcu() the pointer right
> > away. The chances are high that the pointer are fed from the same page.
> > SLUB's build_detached_freelist() scans the page of RCU's pointers to
> > ensure that they are in the same page and then slab_free() them in one
> > go. There is lookahead = 3 so it finds three different pages it stops
> > further scanning and does slab_free() with what it found so far.
> > 
> > Which means if your kfree_rcu() collects random pointer from the system,
> > they may belong to different pages (especially if they are part of
> > different "types").
> 
> It gets significantly better performance as it currently is due to
> the reduced cache-miss rate scanning pointers in a page as opposed to
> pointer-chasing through a series of rcu_head pointers.

So the performance boost is not due to kfree_bulk() but due to the
pointers which are "in ordered".

> Yes, it might be even better if kfree_rcu() further sorted the freed
> objects per slab or maybe even per page within a slab, but one step at
> a time!  For one thing, it is not hard to imagine situations where this
> further sorting actually slowed things down, especially if the system
> was under any sort of memory pressure or if the kfree_rcu() calls were
> scattered across so many slabs and pages that it essentially reverted
> back to pointer chasing.

Okay.

> Make sense, or am I missing your point?

No, you got it.

> 							Thanx, Paul

Sebastian
