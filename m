Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E312C6379D
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90BB2240B
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 18:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgKTSCN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:02:13 -0500
Received: from foss.arm.com ([217.140.110.172]:53070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbgKTSCN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 13:02:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 483481042;
        Fri, 20 Nov 2020 10:02:12 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBCEC3F719;
        Fri, 20 Nov 2020 10:02:08 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:06 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201120180206.GF2328@C02TD0UTHF1T.local>
References: <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201120141928.GB3120165@elver.google.com>
 <20201120143928.GH1437@paulmck-ThinkPad-P72>
 <20201120152200.GD2328@C02TD0UTHF1T.local>
 <20201120173824.GJ1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120173824.GJ1437@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 09:38:24AM -0800, Paul E. McKenney wrote:
> On Fri, Nov 20, 2020 at 03:22:00PM +0000, Mark Rutland wrote:
> > On Fri, Nov 20, 2020 at 06:39:28AM -0800, Paul E. McKenney wrote:
> > > On Fri, Nov 20, 2020 at 03:19:28PM +0100, Marco Elver wrote:
> > > > I found that disabling ftrace for some of kernel/rcu (see below) solved
> > > > the stalls (and any mention of deadlocks as a side-effect I assume),
> > > > resulting in successful boot.
> > > > 
> > > > Does that provide any additional clues? I tried to narrow it down to 1-2
> > > > files, but that doesn't seem to work.
> > > 
> > > There were similar issues during the x86/entry work.  Are the ARM guys
> > > doing arm64/entry work now?
> > 
> > I'm currently looking at it. I had been trying to shift things to C for
> > a while, and right now I'm trying to fix the lockdep state tracking,
> > which is requiring untangling lockdep/rcu/tracing.
> > 
> > The main issue I see remaining atm is that we don't save/restore the
> > lockdep state over exceptions taken from kernel to kernel. That could
> > result in lockdep thinking IRQs are disabled when they're actually
> > enabled (because code in the nested context might do a save/restore
> > while IRQs are disabled, then return to a context where IRQs are
> > enabled), but AFAICT shouldn't result in the inverse in most cases since
> > the non-NMI handlers all call lockdep_hardirqs_disabled().
> > 
> > I'm at a loss to explaim the rcu vs ftrace bits, so if you have any
> > pointers to the issuies ween with the x86 rework that'd be quite handy.
> 
> There were several over a number of months.  I especially recall issues
> with the direct-from-idle execution of smp_call_function*() handlers,
> and also with some of the special cases in the entry code, for example,
> reentering the kernel from the kernel.  This latter could cause RCU to
> not be watching when it should have been or vice versa.

Ah; those are precisely the cases I'm currently fixing, so if we're
lucky this is an indirect result of one of those rather than a novel
source of pain...

> I would of course be most aware of the issues that impinged on RCU
> and that were located by rcutorture.  This is actually not hard to run,
> especially if the ARM bits in the scripting have managed to avoid bitrot.
> The "modprobe rcutorture" approach has fewer dependencies.  Either way:
> https://paulmck.livejournal.com/57769.html and later posts.

That is a very good idea. I'd been relying on Syzkaller to tickle the
issue, but the torture infrastructure is a much better fit for this
problem. I hadn't realise how comprehensive the scripting was, thanks
for this!

I'll see about giving that a go once I have the irq-from-idle cases
sorted, as those are very obviously broken if you hack
trace_hardirqs_{on,off}() to check that RCU is watching.

Thanks,
Mark.
