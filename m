Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CBAC5519F
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 23:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859C7246BC
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 23:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoMx8dVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgKRXin (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:38:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgKRXin (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Nov 2020 18:38:43 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B52246BB;
        Wed, 18 Nov 2020 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605742721;
        bh=T4iirwkR9sU55gHt13mrRbiBIJC+KhSqR34p7NFMaN8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AoMx8dVRGWJMgXkuoTFYfWDbMiJI/OubrXc+W4SGEOA7jFgjMNvsVbvzOnNGBZ2m5
         euD457kohDyAF/TIZ4sjVBcEloeKHPJXxPcPpRuw+txL6nF8sblbxkirZ0daN6pDqV
         0cvz09yfMNv6WlmH2GDkhTikNVOWT1qOLt8i+XgE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 755523522614; Wed, 18 Nov 2020 15:38:41 -0800 (PST)
Date:   Wed, 18 Nov 2020 15:38:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201118233841.GS1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201111192123.GB3249@paulmck-ThinkPad-P72>
 <20201111202153.GT517454@elver.google.com>
 <20201112001129.GD3249@paulmck-ThinkPad-P72>
 <CANpmjNNyZs6NrHPmomC4=9MPEvCy1bFA5R2pRsMhG7=c3LhL_Q@mail.gmail.com>
 <20201112161439.GA2989297@elver.google.com>
 <20201112175406.GF3249@paulmck-ThinkPad-P72>
 <20201113175754.GA6273@paulmck-ThinkPad-P72>
 <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118225621.GA1770130@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 18, 2020 at 11:56:21PM +0100, Marco Elver wrote:
> On Tue, Nov 17, 2020 at 10:29AM -0800, Paul E. McKenney wrote:
> [...] 
> > But it would be good to get the kcompactd() people to look at this (not
> > immediately seeing who they are in MAINTAINERS).  Perhaps preemption is
> > disabled somehow and I am failing to see it.
> > 
> > Failing that, maybe someone knows of a way to check for overly long
> > timeout handlers.
> 
> I think I figured out one piece of the puzzle. Bisection keeps pointing
> me at some -rcu merge commit, which kept throwing me off. Nor did it
> help that reproduction is a bit flaky. However, I think there are 2
> independent problems, but the manifestation of 1 problem triggers the
> 2nd problem:
> 
> 1. problem: slowed forward progress (workqueue lockup / RCU stall reports)
> 
> 2. problem: DEADLOCK which causes complete system lockup
> 
> 	| ...
> 	|        CPU0
> 	|        ----
> 	|   lock(rcu_node_0);
> 	|   <Interrupt>
> 	|     lock(rcu_node_0);
> 	| 
> 	|  *** DEADLOCK ***
> 	| 
> 	| 1 lock held by event_benchmark/105:
> 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:493 [inline]
> 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:652 [inline]
> 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3752 [inline]
> 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x428/0xd40 kernel/rcu/tree.c:2581
> 	| ...
> 
> Problem 2 can with reasonable confidence (5 trials) be fixed by reverting:
> 
> 	rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
> 
> At which point the system always boots to user space -- albeit with a
> bunch of warnings still (attached). The supposed "good" version doesn't
> end up with all those warnings deterministically, so I couldn't say if
> the warnings are expected due to recent changes or not (Arm64 QEMU
> emulation, 1 CPU, and lots of debugging tools on).
> 
> Does any of that make sense?

Marco, it makes all too much sense!  :-/

Does the patch below help?

							Thanx, Paul

------------------------------------------------------------------------

commit 444ef3bbd0f243b912fdfd51f326704f8ee872bf
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sat Aug 29 10:22:24 2020 -0700

    sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled
    
    The try_invoke_on_locked_down_task() function currently requires
    that interrupts be enabled, but it is called with interrupts
    disabled from rcu_print_task_stall(), resulting in an "IRQs not
    enabled as expected" diagnostic.  This commit therefore updates
    try_invoke_on_locked_down_task() to use raw_spin_lock_irqsave() instead
    of raw_spin_lock_irq(), thus allowing use from either context.
    
    Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
    Link: https://lore.kernel.org/lkml/20200928075729.GC2611@hirez.programming.kicks-ass.net/
    Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
    Signed-off-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e172f2d..09ef5cf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2984,7 +2984,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 /**
  * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
- * @p: Process for which the function is to be invoked.
+ * @p: Process for which the function is to be invoked, can be @current.
  * @func: Function to invoke.
  * @arg: Argument to function.
  *
@@ -3002,12 +3002,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
 		if (task_rq(p) == rq)
@@ -3024,7 +3023,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 
