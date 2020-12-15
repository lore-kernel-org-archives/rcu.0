Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77270C2BBCF
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2652250F
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgLOORn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:17:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgLOORm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 09:17:42 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608041819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTUTxJfm61lzLxyyInZp9qdXL3B+P9QD47lufOlImbA=;
        b=JEkM3G4HfklZBTn24g2b+glHY89kRHoLZtUV5H+nH9P7KRpyxzCcWHJQOqjAPI9IffbLCV
        dRpj8F/yTN52J6o6HKgZR7IVkbw41p0Xipt3ChFF9i6cUEOJAqF4vXbDIlPbRK1zB8W/79
        dcCrJRij/cvrpJ3GU/cFnE+78XveQR6vxwyuCpiyOkDFQF7D2DoAI4QfLswWOeS0QFVZjK
        NDsaYsRc+D4IY3jDYrJtBzxPwO3NfUak2rSNIrXhvF8NfVydZCnc/LZCsghcEoJkIU+IDL
        JBSc0rYTaxpC4N8o5MsVuonD+aSm7nnLBXmYyXcI4Ybd9Cj9sh8Y85kDW/uePA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608041819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTUTxJfm61lzLxyyInZp9qdXL3B+P9QD47lufOlImbA=;
        b=5p6VglGIDTtD9D1RCY9M4kBQnMQ7epklQLQM4c9CmfLXZATfp0jnbpowTG5Mus5zJ117xU
        106y2ynJpHFxQiDg==
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/5] doc: Use CONFIG_PREEMPTION
Date:   Tue, 15 Dec 2020 15:16:49 +0100
Message-Id: <20201215141649.796472-6-bigeasy@linutronix.de>
In-Reply-To: <20201215141649.796472-1-bigeasy@linutronix.de>
References: <20201215141649.796472-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Update the documents and mention CONFIG_PREEMPTION. Spell out
CONFIG_PREEMPT_RT (instead PREEMPT_RT) since it is an option now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../Expedited-Grace-Periods.rst               |  4 ++--
 .../RCU/Design/Requirements/Requirements.rst  | 22 +++++++++----------
 Documentation/RCU/checklist.rst               |  2 +-
 Documentation/RCU/rcubarrier.rst              |  6 ++---
 Documentation/RCU/stallwarn.rst               |  4 ++--
 Documentation/RCU/whatisRCU.rst               | 10 ++++-----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Gra=
ce-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited=
-Grace-Periods.rst
index 72f0f6fbd53c0..6f89cf1e567d0 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Peri=
ods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Peri=
ods.rst
@@ -38,7 +38,7 @@ sections.
 RCU-preempt Expedited Grace Periods
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-``CONFIG_PREEMPT=3Dy`` kernels implement RCU-preempt.
+``CONFIG_PREEMPTION=3Dy`` kernels implement RCU-preempt.
 The overall flow of the handling of a given CPU by an RCU-preempt
 expedited grace period is shown in the following diagram:
=20
@@ -112,7 +112,7 @@ things.
 RCU-sched Expedited Grace Periods
 ---------------------------------
=20
-``CONFIG_PREEMPT=3Dn`` kernels implement RCU-sched. The overall flow of
+``CONFIG_PREEMPTION=3Dn`` kernels implement RCU-sched. The overall flow of
 the handling of a given CPU by an RCU-sched expedited grace period is
 shown in the following diagram:
=20
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Docum=
entation/RCU/Design/Requirements/Requirements.rst
index e93cdc476e008..0da9133fa13ab 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -78,7 +78,7 @@ RCU treats a nested set as one big RCU read-side critical=
 section.
 Production-quality implementations of rcu_read_lock() and
 rcu_read_unlock() are extremely lightweight, and in fact have
 exactly zero overhead in Linux kernels built for production use with
-``CONFIG_PREEMPT=3Dn``.
+``CONFIG_PREEMPTION=3Dn``.
=20
 This guarantee allows ordering to be enforced with extremely low
 overhead to readers, for example:
@@ -1181,7 +1181,7 @@ and has become decreasingly so as memory sizes have e=
xpanded and memory
 costs have plummeted. However, as I learned from Matt Mackall's
 `bloatwatch <http://elinux.org/Linux_Tiny-FAQ>`__ efforts, memory
 footprint is critically important on single-CPU systems with
-non-preemptible (``CONFIG_PREEMPT=3Dn``) kernels, and thus `tiny
+non-preemptible (``CONFIG_PREEMPTION=3Dn``) kernels, and thus `tiny
 RCU <https://lore.kernel.org/r/20090113221724.GA15307@linux.vnet.ibm.com>`=
__
 was born. Josh Triplett has since taken over the small-memory banner
 with his `Linux kernel tinification <https://tiny.wiki.kernel.org/>`__
@@ -1497,7 +1497,7 @@ limitations.
=20
 Implementations of RCU for which rcu_read_lock() and
 rcu_read_unlock() generate no code, such as Linux-kernel RCU when
-``CONFIG_PREEMPT=3Dn``, can be nested arbitrarily deeply. After all, there
+``CONFIG_PREEMPTION=3Dn``, can be nested arbitrarily deeply. After all, th=
ere
 is no overhead. Except that if all these instances of
 rcu_read_lock() and rcu_read_unlock() are visible to the
 compiler, compilation will eventually fail due to exhausting memory,
@@ -1769,7 +1769,7 @@ implementation can be a no-op.
=20
 However, once the scheduler has spawned its first kthread, this early
 boot trick fails for synchronize_rcu() (as well as for
-synchronize_rcu_expedited()) in ``CONFIG_PREEMPT=3Dy`` kernels. The
+synchronize_rcu_expedited()) in ``CONFIG_PREEMPTION=3Dy`` kernels. The
 reason is that an RCU read-side critical section might be preempted,
 which means that a subsequent synchronize_rcu() really does have to
 wait for something, as opposed to simply returning immediately.
@@ -2038,7 +2038,7 @@ The compiler must not be permitted to transform this =
source code into
        5 rcu_read_unlock();
        6 do_something_with(v, user_v);
=20
-If the compiler did make this transformation in a ``CONFIG_PREEMPT=3Dn`` k=
ernel
+If the compiler did make this transformation in a ``CONFIG_PREEMPTION=3Dn`=
` kernel
 build, and if get_user() did page fault, the result would be a quiescent
 state in the middle of an RCU read-side critical section.  This misplaced
 quiescent state could result in line 4 being a use-after-free access,
@@ -2320,7 +2320,7 @@ conjunction with the `-rt
 patchset <https://wiki.linuxfoundation.org/realtime/>`__. The
 real-time-latency response requirements are such that the traditional
 approach of disabling preemption across RCU read-side critical sections
-is inappropriate. Kernels built with ``CONFIG_PREEMPT=3Dy`` therefore use
+is inappropriate. Kernels built with ``CONFIG_PREEMPTION=3Dy`` therefore u=
se
 an RCU implementation that allows RCU read-side critical sections to be
 preempted. This requirement made its presence known after users made it
 clear that an earlier `real-time
@@ -2460,11 +2460,11 @@ not have this property, given that any point in the=
 code outside of an
 RCU read-side critical section can be a quiescent state. Therefore,
 *RCU-sched* was created, which follows =E2=80=9Cclassic=E2=80=9D RCU in th=
at an
 RCU-sched grace period waits for pre-existing interrupt and NMI
-handlers. In kernels built with ``CONFIG_PREEMPT=3Dn``, the RCU and
+handlers. In kernels built with ``CONFIG_PREEMPTION=3Dn``, the RCU and
 RCU-sched APIs have identical implementations, while kernels built with
-``CONFIG_PREEMPT=3Dy`` provide a separate implementation for each.
+``CONFIG_PREEMPTION=3Dy`` provide a separate implementation for each.
=20
-Note well that in ``CONFIG_PREEMPT=3Dy`` kernels,
+Note well that in ``CONFIG_PREEMPTION=3Dy`` kernels,
 rcu_read_lock_sched() and rcu_read_unlock_sched() disable and
 re-enable preemption, respectively. This means that if there was a
 preemption attempt during the RCU-sched read-side critical section,
@@ -2645,10 +2645,10 @@ userspace execution also delimit tasks-RCU read-sid=
e critical sections.
=20
 The tasks-RCU API is quite compact, consisting only of
 call_rcu_tasks(), synchronize_rcu_tasks(), and
-rcu_barrier_tasks(). In ``CONFIG_PREEMPT=3Dn`` kernels, trampolines
+rcu_barrier_tasks(). In ``CONFIG_PREEMPTION=3Dn`` kernels, trampolines
 cannot be preempted, so these APIs map to call_rcu(),
 synchronize_rcu(), and rcu_barrier(), respectively. In
-``CONFIG_PREEMPT=3Dy`` kernels, trampolines can be preempted, and these
+``CONFIG_PREEMPTION=3Dy`` kernels, trampolines can be preempted, and these
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
=20
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.=
rst
index 2d1dc1deffc9a..1030119294d08 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -212,7 +212,7 @@ over a rather long period of time, but improvements are=
 always welcome!
 	the rest of the system.
=20
 7.	As of v4.20, a given kernel implements only one RCU flavor,
-	which is RCU-sched for PREEMPT=3Dn and RCU-preempt for PREEMPT=3Dy.
+	which is RCU-sched for PREEMPTION=3Dn and RCU-preempt for PREEMPTION=3Dy.
 	If the updater uses call_rcu() or synchronize_rcu(),
 	then the corresponding readers may use rcu_read_lock() and
 	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrie=
r.rst
index f64f4413a47c4..3b4a248774961 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -9,7 +9,7 @@ RCU (read-copy update) is a synchronization mechanism that =
can be thought
 of as a replacement for read-writer locking (among other things), but with
 very low-overhead readers that are immune to deadlock, priority inversion,
 and unbounded latency. RCU read-side critical sections are delimited
-by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPT
+by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPTION
 kernels, generate no code whatsoever.
=20
 This means that RCU writers are unaware of the presence of concurrent
@@ -329,10 +329,10 @@ Answer: This cannot happen. The reason is that on_eac=
h_cpu() has its last
 	to smp_call_function() and further to smp_call_function_on_cpu(),
 	causing this latter to spin until the cross-CPU invocation of
 	rcu_barrier_func() has completed. This by itself would prevent
-	a grace period from completing on non-CONFIG_PREEMPT kernels,
+	a grace period from completing on non-CONFIG_PREEMPTION kernels,
 	since each CPU must undergo a context switch (or other quiescent
 	state) before the grace period can complete. However, this is
-	of no use in CONFIG_PREEMPT kernels.
+	of no use in CONFIG_PREEMPTION kernels.
=20
 	Therefore, on_each_cpu() disables preemption across its call
 	to smp_call_function() and also across the local call to
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.=
rst
index d53856cc63908..7148e9be08c34 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -25,7 +25,7 @@ So your kernel printed an RCU CPU stall warning.  The nex=
t question is
=20
 -	A CPU looping with bottom halves disabled.
=20
--	For !CONFIG_PREEMPT kernels, a CPU looping anywhere in the kernel
+-	For !CONFIG_PREEMPTION kernels, a CPU looping anywhere in the kernel
 	without invoking schedule().  If the looping in the kernel is
 	really expected and desirable behavior, you might need to add
 	some calls to cond_resched().
@@ -44,7 +44,7 @@ So your kernel printed an RCU CPU stall warning.  The nex=
t question is
 	result in the ``rcu_.*kthread starved for`` console-log message,
 	which will include additional debugging information.
=20
--	A CPU-bound real-time task in a CONFIG_PREEMPT kernel, which might
+-	A CPU-bound real-time task in a CONFIG_PREEMPTION kernel, which might
 	happen to preempt a low-priority task in the middle of an RCU
 	read-side critical section.   This is especially damaging if
 	that low-priority task is not permitted to run on any other CPU,
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.=
rst
index 1a4723f48bd9c..17e95ab2a2014 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -683,7 +683,7 @@ so there can be no deadlock cycle.
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 This section presents a "toy" RCU implementation that is based on
 "classic RCU".  It is also short on performance (but only for updates) and
-on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
+on features such as hotplug CPU and the ability to run in CONFIG_PREEMPTION
 kernels.  The definitions of rcu_dereference() and rcu_assign_pointer()
 are the same as those shown in the preceding section, so they are omitted.
 ::
@@ -739,7 +739,7 @@ to that data item, so we can safely reclaim it.
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
-		PREEMPT_RT, where normal spinlocks can block???
+		CONFIG_PREEMPT_RT, where normal spinlocks can block???
=20
 :ref:`Answers to Quick Quiz <8_whatisRCU>`
=20
@@ -1093,7 +1093,7 @@ the right tool for your job.
 		overhead is **negative**.
=20
 Answer:
-		Imagine a single-CPU system with a non-CONFIG_PREEMPT
+		Imagine a single-CPU system with a non-CONFIG_PREEMPTION
 		kernel where a routing table is used by process-context
 		code, but can be updated by irq-context code (for example,
 		by an "ICMP REDIRECT" packet).	The usual way of handling
@@ -1120,10 +1120,10 @@ the right tool for your job.
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
-		PREEMPT_RT, where normal spinlocks can block???
+		CONFIG_PREEMPT_RT, where normal spinlocks can block???
=20
 Answer:
-		Just as PREEMPT_RT permits preemption of spinlock
+		Just as CONFIG_PREEMPT_RT permits preemption of spinlock
 		critical sections, it permits preemption of RCU
 		read-side critical sections.  It also permits
 		spinlocks blocking while in RCU read-side critical
--=20
2.29.2

