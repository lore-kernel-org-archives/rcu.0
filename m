Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D301C54FCC
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49971206E9
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDURGE convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Tue, 21 Apr 2020 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDURGD (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 21 Apr 2020 13:06:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC6FC061A41
        for <rcu@vger.kernel.org>; Tue, 21 Apr 2020 10:06:03 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jQwLN-0007Su-1y; Tue, 21 Apr 2020 19:05:57 +0200
Date:   Tue, 21 Apr 2020 19:05:56 +0200
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
Message-ID: <20200421170556.lvgb6gtjivjbr7gl@linutronix.de>
References: <20200420132601.GY17661@paulmck-ThinkPad-P72>
 <20200420160847.GA11451@pc636>
 <20200420162534.GD17661@paulmck-ThinkPad-P72>
 <20200420162900.GA11867@pc636>
 <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200421133947.cmdchrx73ru7szuz@linutronix.de>
 <20200421154101.GN17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200421154101.GN17661@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-21 08:41:01 [-0700], Paul E. McKenney wrote:
> > Invoking queue_work() is not a problem locking wise. It does however
> > extend the length of the critical section (which is not yet needed).
> 
> I am guessing that by "which is not yet needed" you were meaning that
> it is not absolutely necessary to extend the length of the critical
> section.  Please correct me if my guess is wrong.

By changing the lock type you extend the atomic section from "only"
queue_work() (if invoked) to everything kfree_rcu() does plus
queue_work().

> In the meantime, plunging ahead...
> 
> One approach might be to move queue_work() and friends out of the critical
> section, but only enable interrupts between the two critical sections
> under CONFIG_PREEMPT_RT_FULL.  Would that be a reasonable approach?

Yes but why do we do this raw_spinlock_t here? It is not yet needed on
v5.6-RT as I *did* check. It also complicates the code for !RT but
nobody responded to that part but…

That said: the current memory allocation is the problem here. The
remaining part is fine. The part under the lock is small enough so it
should not cause the trouble if it invokes queue_work() which will
"only" enqueue the timer. 

Side question: Is there any real-life workloads that benefits from this?
I'm asking because rcuperf allocates the kfree_rcu() the pointer right
away. The chances are high that the pointer are fed from the same page.
SLUB's build_detached_freelist() scans the page of RCU's pointers to
ensure that they are in the same page and then slab_free() them in one
go. There is lookahead = 3 so it finds three different pages it stops
further scanning and does slab_free() with what it found so far.

Which means if your kfree_rcu() collects random pointer from the system,
they may belong to different pages (especially if they are part of
different "types").

> 							Thanx, Paul

Sebastian
