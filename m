Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C4FC388F9
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 21:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A847E22242
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 21:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjzSuS/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgKSVfO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 16:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSVfO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 16:35:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7352222A;
        Thu, 19 Nov 2020 21:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605821712;
        bh=WiDazihmUqIbfDQNuj5oVU9c796OAQteSS6DruzFVVQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FjzSuS/vurox71DLRNzjRg39KsUR34CUpNxVObvX5FV4wv3PP0o64vUT9+Dw1sBzt
         FZIThnUqycC7x7xGy8L3bjvSkry83weBw4JFoSKDMxC4H5ZktGT+rdSyMoNk2/qJJw
         tdb98ssEZERXZ0YrzHdwdsHaJxnjjeGk9Fg57cR4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 75FDB35225D3; Thu, 19 Nov 2020 13:35:12 -0800 (PST)
Date:   Thu, 19 Nov 2020 13:35:12 -0800
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
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201119213512.GB1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201113175754.GA6273@paulmck-ThinkPad-P72>
 <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119193819.GA2601289@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 08:38:19PM +0100, Marco Elver wrote:
> On Thu, Nov 19, 2020 at 10:48AM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 19, 2020 at 06:02:59PM +0100, Marco Elver wrote:

[ . . . ]

> > > I can try bisection again, or reverting some commits that might be
> > > suspicious? But we'd need some selection of suspicious commits.
> > 
> > The report claims that one of the rcu_node ->lock fields is held
> > with interrupts enabled, which would indeed be bad.  Except that all
> > of the stack traces that it shows have these locks held within the
> > scheduling-clock interrupt handler.  Now with the "rcu: Don't invoke
> > try_invoke_on_locked_down_task() with irqs disabled" but without the
> > "sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled"
> > commit, I understand why.  With both, I don't see how this happens.
> 
> I'm at a loss, but happy to keep bisecting and trying patches. I'm also
> considering:
> 
> 	Is it the compiler? Probably not, I tried 2 versions of GCC.
> 
> 	Can we trust lockdep to precisely know IRQ state? I know there's
> 	been some recent work around this, but hopefully we're not
> 	affected here?
> 
> 	Is QEMU buggy?
> 
> > At this point, I am reduced to adding lockdep_assert_irqs_disabled()
> > calls at various points in that code, as shown in the patch below.
> > 
> > At this point, I would guess that your first priority would be the
> > initial bug rather than this following issue, but you never know, this
> > might well help diagnose the initial bug.
> 
> I don't mind either way. I'm worried deadlocking the whole system might
> be worse.

Here is another set of lockdep_assert_irqs_disabled() calls on the
off-chance that they actually find something.

							Thanx, Paul

------------------------------------------------------------------------

commit bcca5277df3f24db15e15ccc8b05ecf346d05169
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Nov 19 13:30:33 2020 -0800

    rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
    
    This commit adds a lockdep_assert_irqs_disabled() call to the
    helper macros that release the rcu_node structure's ->lock, namely
    to raw_spin_unlock_rcu_node(), raw_spin_unlock_irq_rcu_node() and
    raw_spin_unlock_irqrestore_rcu_node().  The point of this is to help track
    down a situation where lockdep appears to be insisting that interrupts
    are enabled while holding an rcu_node structure's ->lock.
    
    Link: https://lore.kernel.org/lkml/20201111133813.GA81547@elver.google.com/
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 59ef1ae..bf0827d 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -378,7 +378,11 @@ do {									\
 	smp_mb__after_unlock_lock();					\
 } while (0)
 
-#define raw_spin_unlock_rcu_node(p) raw_spin_unlock(&ACCESS_PRIVATE(p, lock))
+#define raw_spin_unlock_rcu_node(p)					\
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock(&ACCESS_PRIVATE(p, lock));			\
+} while (0)
 
 #define raw_spin_lock_irq_rcu_node(p)					\
 do {									\
@@ -387,7 +391,10 @@ do {									\
 } while (0)
 
 #define raw_spin_unlock_irq_rcu_node(p)					\
-	raw_spin_unlock_irq(&ACCESS_PRIVATE(p, lock))
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock_irq(&ACCESS_PRIVATE(p, lock));			\
+} while (0)
 
 #define raw_spin_lock_irqsave_rcu_node(p, flags)			\
 do {									\
@@ -396,7 +403,10 @@ do {									\
 } while (0)
 
 #define raw_spin_unlock_irqrestore_rcu_node(p, flags)			\
-	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags);	\
+} while (0)
 
 #define raw_spin_trylock_rcu_node(p)					\
 ({									\
