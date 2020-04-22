Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF14C54FCB
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FD520767
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDVPqb convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Wed, 22 Apr 2020 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDVPqb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Apr 2020 11:46:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4169C03C1A9
        for <rcu@vger.kernel.org>; Wed, 22 Apr 2020 08:46:30 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRHZx-0004IV-2q; Wed, 22 Apr 2020 17:46:25 +0200
Date:   Wed, 22 Apr 2020 17:46:25 +0200
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
Message-ID: <20200422154625.ub6xu5udlhtxsqdc@linutronix.de>
References: <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200421133947.cmdchrx73ru7szuz@linutronix.de>
 <20200421154101.GN17661@paulmck-ThinkPad-P72>
 <20200421170556.lvgb6gtjivjbr7gl@linutronix.de>
 <20200421180914.GT17661@paulmck-ThinkPad-P72>
 <20200422111324.cummbkw2faxoeaxk@linutronix.de>
 <20200422133346.GN17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200422133346.GN17661@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-22 06:33:46 [-0700], Paul E. McKenney wrote:
> On Wed, Apr 22, 2020 at 01:13:24PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-04-21 11:09:14 [-0700], Paul E. McKenney wrote:
> > > > Yes but why do we do this raw_spinlock_t here? It is not yet needed on
> > > > v5.6-RT as I *did* check. It also complicates the code for !RT but
> > > > nobody responded to that part but…
> > > 
> > > I did respond by pointing out that the essentially similar call_rcu()
> > > function ends up being invoked pretty much everywhere, including early
> > > boot before rcu_init() has been invoked.  It is therefore only reasonable
> > > to assume that there will be a need for kfree_rcu() to tolerate a similar
> > > range of calling contexts.
> > 
> > Early in the boot we have IRQs disabled but also one CPU and no
> > scheduling. That means that not a single lock is contained.
> 
> You are saying that call_rcu() is never invoked while holding a raw
> spinlock?

I didn't say that. I said if you use spin_lock() with interrupts
disabled *but* early in the boot process (without the scheduler active)
then it is okay.
This was a response to your "including early boot before …".
But since you ask: On top of my head I know that
task_struct is released via RCU by the scheduler in a preempt-disabled
section. We have a similar workaround for the mm struct. So yes, we have
at the very least those two.

> Fair enough, and thank you for checking!
> 
> The other work-queuing operations are also OK as they are, then?

yes.

Sebastian
