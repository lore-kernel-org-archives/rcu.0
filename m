Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14F7C43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A880B22242
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbhAFAzc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbhAFAzb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:55:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F3C323101;
        Wed,  6 Jan 2021 00:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894450;
        bh=43IIe2ELsIMWxEw452+SpcVmGKRHgN4Z8/d9AwKpCuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLgZ6Z1S2jVePQ/HMdnCeJ0/P0Hu8xIzCZBKwzACpSgacBumRD+pDNsPaqKTUc5aa
         ZLvMiW+5LvlP3swysfkHCcMh54lBJJMwadHrtnWApv+TKQlx9Ht+EiBV3CmQZgXgxb
         ydhChoEqVd8hTr/++Aq/k8KtDuXThNlWQuEsx+uunmbgj6FnP6FKG8jeAAmqRDhHvu
         An4qB/AHnQg68Lpj/W0KZ8jTJdCrjC0VwK9bPgE9wTHAr1fIDosAyslWJVYpNKPZAD
         eDJ0Wk4Umo3uhtwg78+Bw9aGOQqlPahYQeVMY5TaBCvh5yfdMxbJ9HsqGkU77FsE4m
         WjQUX3UEee+kA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 8/8] doc: Use CONFIG_PREEMPTION
Date:   Tue,  5 Jan 2021 16:54:07 -0800
Message-Id: <20210106005407.12295-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005334.GA12159@paulmck-ThinkPad-P72>
References: <20210106005334.GA12159@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Update the documents and mention CONFIG_PREEMPTION. Spell out
CONFIG_PREEMPT_RT (instead PREEMPT_RT) since it is an option now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Expedited-Grace-Periods.rst                    |  4 ++--
 .../RCU/Design/Requirements/Requirements.rst       | 22 +++++++++++-----------
 Documentation/RCU/checklist.rst                    |  2 +-
 Documentation/RCU/rcubarrier.rst                   |  6 +++---
 Documentation/RCU/stallwarn.rst                    |  4 ++--
 Documentation/RCU/whatisRCU.rst                    | 10 +++++-----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
index 72f0f6f..6f89cf1 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -38,7 +38,7 @@ sections.
 RCU-preempt Expedited Grace Periods
 ===================================
 
-``CONFIG_PREEMPT=y`` kernels implement RCU-preempt.
+``CONFIG_PREEMPTION=y`` kernels implement RCU-preempt.
 The overall flow of the handling of a given CPU by an RCU-preempt
 expedited grace period is shown in the following diagram:
 
@@ -112,7 +112,7 @@ things.
 RCU-sched Expedited Grace Periods
 ---------------------------------
 
-``CONFIG_PREEMPT=n`` kernels implement RCU-sched. The overall flow of
+``CONFIG_PREEMPTION=n`` kernels implement RCU-sched. The overall flow of
 the handling of a given CPU by an RCU-sched expedited grace period is
 shown in the following diagram:
 
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index bac1cdd..42a81e3 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -78,7 +78,7 @@ RCU treats a nested set as one big RCU read-side critical section.
 Production-quality implementations of rcu_read_lock() and
 rcu_read_unlock() are extremely lightweight, and in fact have
 exactly zero overhead in Linux kernels built for production use with
-``CONFIG_PREEMPT=n``.
+``CONFIG_PREEMPTION=n``.
 
 This guarantee allows ordering to be enforced with extremely low
 overhead to readers, for example:
@@ -1181,7 +1181,7 @@ and has become decreasingly so as memory sizes have expanded and memory
 costs have plummeted. However, as I learned from Matt Mackall's
 `bloatwatch <http://elinux.org/Linux_Tiny-FAQ>`__ efforts, memory
 footprint is critically important on single-CPU systems with
-non-preemptible (``CONFIG_PREEMPT=n``) kernels, and thus `tiny
+non-preemptible (``CONFIG_PREEMPTION=n``) kernels, and thus `tiny
 RCU <https://lore.kernel.org/r/20090113221724.GA15307@linux.vnet.ibm.com>`__
 was born. Josh Triplett has since taken over the small-memory banner
 with his `Linux kernel tinification <https://tiny.wiki.kernel.org/>`__
@@ -1497,7 +1497,7 @@ limitations.
 
 Implementations of RCU for which rcu_read_lock() and
 rcu_read_unlock() generate no code, such as Linux-kernel RCU when
-``CONFIG_PREEMPT=n``, can be nested arbitrarily deeply. After all, there
+``CONFIG_PREEMPTION=n``, can be nested arbitrarily deeply. After all, there
 is no overhead. Except that if all these instances of
 rcu_read_lock() and rcu_read_unlock() are visible to the
 compiler, compilation will eventually fail due to exhausting memory,
@@ -1769,7 +1769,7 @@ implementation can be a no-op.
 
 However, once the scheduler has spawned its first kthread, this early
 boot trick fails for synchronize_rcu() (as well as for
-synchronize_rcu_expedited()) in ``CONFIG_PREEMPT=y`` kernels. The
+synchronize_rcu_expedited()) in ``CONFIG_PREEMPTION=y`` kernels. The
 reason is that an RCU read-side critical section might be preempted,
 which means that a subsequent synchronize_rcu() really does have to
 wait for something, as opposed to simply returning immediately.
@@ -2038,7 +2038,7 @@ the following:
        5 rcu_read_unlock();
        6 do_something_with(v, user_v);
 
-If the compiler did make this transformation in a ``CONFIG_PREEMPT=n`` kernel
+If the compiler did make this transformation in a ``CONFIG_PREEMPTION=n`` kernel
 build, and if get_user() did page fault, the result would be a quiescent
 state in the middle of an RCU read-side critical section.  This misplaced
 quiescent state could result in line 4 being a use-after-free access,
@@ -2320,7 +2320,7 @@ conjunction with the `-rt
 patchset <https://wiki.linuxfoundation.org/realtime/>`__. The
 real-time-latency response requirements are such that the traditional
 approach of disabling preemption across RCU read-side critical sections
-is inappropriate. Kernels built with ``CONFIG_PREEMPT=y`` therefore use
+is inappropriate. Kernels built with ``CONFIG_PREEMPTION=y`` therefore use
 an RCU implementation that allows RCU read-side critical sections to be
 preempted. This requirement made its presence known after users made it
 clear that an earlier `real-time
@@ -2460,11 +2460,11 @@ not have this property, given that any point in the code outside of an
 RCU read-side critical section can be a quiescent state. Therefore,
 *RCU-sched* was created, which follows “classic” RCU in that an
 RCU-sched grace period waits for pre-existing interrupt and NMI
-handlers. In kernels built with ``CONFIG_PREEMPT=n``, the RCU and
+handlers. In kernels built with ``CONFIG_PREEMPTION=n``, the RCU and
 RCU-sched APIs have identical implementations, while kernels built with
-``CONFIG_PREEMPT=y`` provide a separate implementation for each.
+``CONFIG_PREEMPTION=y`` provide a separate implementation for each.
 
-Note well that in ``CONFIG_PREEMPT=y`` kernels,
+Note well that in ``CONFIG_PREEMPTION=y`` kernels,
 rcu_read_lock_sched() and rcu_read_unlock_sched() disable and
 re-enable preemption, respectively. This means that if there was a
 preemption attempt during the RCU-sched read-side critical section,
@@ -2627,10 +2627,10 @@ userspace execution also delimit tasks-RCU read-side critical sections.
 
 The tasks-RCU API is quite compact, consisting only of
 call_rcu_tasks(), synchronize_rcu_tasks(), and
-rcu_barrier_tasks(). In ``CONFIG_PREEMPT=n`` kernels, trampolines
+rcu_barrier_tasks(). In ``CONFIG_PREEMPTION=n`` kernels, trampolines
 cannot be preempted, so these APIs map to call_rcu(),
 synchronize_rcu(), and rcu_barrier(), respectively. In
-``CONFIG_PREEMPT=y`` kernels, trampolines can be preempted, and these
+``CONFIG_PREEMPTION=y`` kernels, trampolines can be preempted, and these
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
 
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 2d1dc1d..1030119 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -212,7 +212,7 @@ over a rather long period of time, but improvements are always welcome!
 	the rest of the system.
 
 7.	As of v4.20, a given kernel implements only one RCU flavor,
-	which is RCU-sched for PREEMPT=n and RCU-preempt for PREEMPT=y.
+	which is RCU-sched for PREEMPTION=n and RCU-preempt for PREEMPTION=y.
 	If the updater uses call_rcu() or synchronize_rcu(),
 	then the corresponding readers may use rcu_read_lock() and
 	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index f64f4413..3b4a248 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -9,7 +9,7 @@ RCU (read-copy update) is a synchronization mechanism that can be thought
 of as a replacement for read-writer locking (among other things), but with
 very low-overhead readers that are immune to deadlock, priority inversion,
 and unbounded latency. RCU read-side critical sections are delimited
-by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPT
+by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPTION
 kernels, generate no code whatsoever.
 
 This means that RCU writers are unaware of the presence of concurrent
@@ -329,10 +329,10 @@ Answer: This cannot happen. The reason is that on_each_cpu() has its last
 	to smp_call_function() and further to smp_call_function_on_cpu(),
 	causing this latter to spin until the cross-CPU invocation of
 	rcu_barrier_func() has completed. This by itself would prevent
-	a grace period from completing on non-CONFIG_PREEMPT kernels,
+	a grace period from completing on non-CONFIG_PREEMPTION kernels,
 	since each CPU must undergo a context switch (or other quiescent
 	state) before the grace period can complete. However, this is
-	of no use in CONFIG_PREEMPT kernels.
+	of no use in CONFIG_PREEMPTION kernels.
 
 	Therefore, on_each_cpu() disables preemption across its call
 	to smp_call_function() and also across the local call to
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index c9ab6af..e97d1b4 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -25,7 +25,7 @@ warnings:
 
 -	A CPU looping with bottom halves disabled.
 
--	For !CONFIG_PREEMPT kernels, a CPU looping anywhere in the kernel
+-	For !CONFIG_PREEMPTION kernels, a CPU looping anywhere in the kernel
 	without invoking schedule().  If the looping in the kernel is
 	really expected and desirable behavior, you might need to add
 	some calls to cond_resched().
@@ -44,7 +44,7 @@ warnings:
 	result in the ``rcu_.*kthread starved for`` console-log message,
 	which will include additional debugging information.
 
--	A CPU-bound real-time task in a CONFIG_PREEMPT kernel, which might
+-	A CPU-bound real-time task in a CONFIG_PREEMPTION kernel, which might
 	happen to preempt a low-priority task in the middle of an RCU
 	read-side critical section.   This is especially damaging if
 	that low-priority task is not permitted to run on any other CPU,
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 1a4723f..17e95ab 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -683,7 +683,7 @@ Quick Quiz #1:
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 This section presents a "toy" RCU implementation that is based on
 "classic RCU".  It is also short on performance (but only for updates) and
-on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
+on features such as hotplug CPU and the ability to run in CONFIG_PREEMPTION
 kernels.  The definitions of rcu_dereference() and rcu_assign_pointer()
 are the same as those shown in the preceding section, so they are omitted.
 ::
@@ -739,7 +739,7 @@ Quick Quiz #2:
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
-		PREEMPT_RT, where normal spinlocks can block???
+		CONFIG_PREEMPT_RT, where normal spinlocks can block???
 
 :ref:`Answers to Quick Quiz <8_whatisRCU>`
 
@@ -1093,7 +1093,7 @@ Quick Quiz #2:
 		overhead is **negative**.
 
 Answer:
-		Imagine a single-CPU system with a non-CONFIG_PREEMPT
+		Imagine a single-CPU system with a non-CONFIG_PREEMPTION
 		kernel where a routing table is used by process-context
 		code, but can be updated by irq-context code (for example,
 		by an "ICMP REDIRECT" packet).	The usual way of handling
@@ -1120,10 +1120,10 @@ Answer:
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
-		PREEMPT_RT, where normal spinlocks can block???
+		CONFIG_PREEMPT_RT, where normal spinlocks can block???
 
 Answer:
-		Just as PREEMPT_RT permits preemption of spinlock
+		Just as CONFIG_PREEMPT_RT permits preemption of spinlock
 		critical sections, it permits preemption of RCU
 		read-side critical sections.  It also permits
 		spinlocks blocking while in RCU read-side critical
-- 
2.9.5

