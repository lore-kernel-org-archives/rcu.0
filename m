Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C87C54FCC
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 18:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38368206D5
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587492556;
	bh=HHCsaC6PAuBgJgcKQuEIrlMyLwclSgLYfB1JCmzr48E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=BY818lWY96ghntwAktlV+OLsMbiWU0TsLkfauUS4Gn1cJRE5lH4uNdVc0cLqdrbnt
	 hYvYocDHqrAoK1qtwobZj3LtU6j8X9FNyadziyS+PJjDVYaouStb/Hj7hZ+QZyjEdz
	 PpbFKY1OSzZOBwe3/W1eW7Q1qEeAHH7cDLjzzYUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgDUSJQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUSJP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 14:09:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE9120663;
        Tue, 21 Apr 2020 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587492554;
        bh=HHCsaC6PAuBgJgcKQuEIrlMyLwclSgLYfB1JCmzr48E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aw1yr1uTixXcASAf3TC/qALxfpWtevngXU84GASNDUp4C9Mqx+rf+rbscc7jwdOuR
         GhOL/4Sc/YHTKQZspaTDfb+muAyeWXEnyZyyp2WgDsEvS0N9/xXgHkpc/uANubnnxk
         sJjcPJGSOuOZ794lCTMx3eL5BJlpzHR7CI4PNOPg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B4CDA3523441; Tue, 21 Apr 2020 11:09:14 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:09:14 -0700
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
Message-ID: <20200421180914.GT17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200420160847.GA11451@pc636>
 <20200420162534.GD17661@paulmck-ThinkPad-P72>
 <20200420162900.GA11867@pc636>
 <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200421133947.cmdchrx73ru7szuz@linutronix.de>
 <20200421154101.GN17661@paulmck-ThinkPad-P72>
 <20200421170556.lvgb6gtjivjbr7gl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421170556.lvgb6gtjivjbr7gl@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 21, 2020 at 07:05:56PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-21 08:41:01 [-0700], Paul E. McKenney wrote:
> > > Invoking queue_work() is not a problem locking wise. It does however
> > > extend the length of the critical section (which is not yet needed).
> > 
> > I am guessing that by "which is not yet needed" you were meaning that
> > it is not absolutely necessary to extend the length of the critical
> > section.  Please correct me if my guess is wrong.
> 
> By changing the lock type you extend the atomic section from "only"
> queue_work() (if invoked) to everything kfree_rcu() does plus
> queue_work().

Got it, thank you!

> > In the meantime, plunging ahead...
> > 
> > One approach might be to move queue_work() and friends out of the critical
> > section, but only enable interrupts between the two critical sections
> > under CONFIG_PREEMPT_RT_FULL.  Would that be a reasonable approach?
> 
> Yes but why do we do this raw_spinlock_t here? It is not yet needed on
> v5.6-RT as I *did* check. It also complicates the code for !RT but
> nobody responded to that part but…

I did respond by pointing out that the essentially similar call_rcu()
function ends up being invoked pretty much everywhere, including early
boot before rcu_init() has been invoked.  It is therefore only reasonable
to assume that there will be a need for kfree_rcu() to tolerate a similar
range of calling contexts.

> That said: the current memory allocation is the problem here. The
> remaining part is fine. The part under the lock is small enough so it
> should not cause the trouble if it invokes queue_work() which will
> "only" enqueue the timer. 

To your point, the small memory allocation will be going away.  The
memory allocations will pull in 4K pages of pointers.

On the timer, are you thinking of the queue_work() calls or instead of
the queue_delayed_work() calls?

> Side question: Is there any real-life workloads that benefits from this?
> I'm asking because rcuperf allocates the kfree_rcu() the pointer right
> away. The chances are high that the pointer are fed from the same page.
> SLUB's build_detached_freelist() scans the page of RCU's pointers to
> ensure that they are in the same page and then slab_free() them in one
> go. There is lookahead = 3 so it finds three different pages it stops
> further scanning and does slab_free() with what it found so far.
> 
> Which means if your kfree_rcu() collects random pointer from the system,
> they may belong to different pages (especially if they are part of
> different "types").

It gets significantly better performance as it currently is due to
the reduced cache-miss rate scanning pointers in a page as opposed to
pointer-chasing through a series of rcu_head pointers.

Yes, it might be even better if kfree_rcu() further sorted the freed
objects per slab or maybe even per page within a slab, but one step at
a time!  For one thing, it is not hard to imagine situations where this
further sorting actually slowed things down, especially if the system
was under any sort of memory pressure or if the kfree_rcu() calls were
scattered across so many slabs and pages that it essentially reverted
back to pointer chasing.

Make sense, or am I missing your point?

							Thanx, Paul
