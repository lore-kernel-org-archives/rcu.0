Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6FDC6377E
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E5861279
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhGUT2X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhGUT2U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C85206121F;
        Wed, 21 Jul 2021 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898134;
        bh=0/+9Ds2nYq23Vrp98ZdFSBDOmDW4de7H4iN14rx/Tk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOVcxnPwJ9Hyc1CyHYwruPr9TjjoVyKG9/Ewu7Y1hNfS+uYPiR0qAZX6NggfUntFb
         PJCmeQQvYqNqG6azSZLCiK30RyU9I0FQevGr2sy4bTApQ5b2d5FyPbseBJ9F/8MgQw
         5Lv+OjeX/sGQ+RezZG5y8gbGm01bEhsSDYwZHi/ZDoQ3mjrsXXNydtY9LPjUY65lZZ
         7rnUL4adBrmrYgTqPsOaCBzr9Ld6ZPZ7jvJEFs51TQQxORclhc6wMGbg+9j9GgS4rP
         FWDWSuq6nCLZvlYsNMuIBuMtmhJ1QcvOnoWADKiR579St1WTb31UND0ZETQ/Kz1AVn
         HhPevEOoc7ARQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 852685C09A4; Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Akira Yokosawa <akiyks@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/5] Documentation/RCU: Fix emphasis markers
Date:   Wed, 21 Jul 2021 13:08:49 -0700
Message-Id: <20210721200853.1175189-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
References: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

"-foo-" does not work as emphasis in ReST markdown.
Use "*foo*" instead.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst       | 24 ++++++++++++------------
 Documentation/RCU/rcu_dereference.rst |  6 +++---
 Documentation/RCU/stallwarn.rst       |  8 ++++----
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 01cc21f17f7bd..f4545b7c9a63d 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -37,7 +37,7 @@ over a rather long period of time, but improvements are always welcome!
 
 1.	Does the update code have proper mutual exclusion?
 
-	RCU does allow -readers- to run (almost) naked, but -writers- must
+	RCU does allow *readers* to run (almost) naked, but *writers* must
 	still use some sort of mutual exclusion, such as:
 
 	a.	locking,
@@ -73,7 +73,7 @@ over a rather long period of time, but improvements are always welcome!
 	critical section is every bit as bad as letting them leak out
 	from under a lock.  Unless, of course, you have arranged some
 	other means of protection, such as a lock or a reference count
-	-before- letting them out of the RCU read-side critical section.
+	*before* letting them out of the RCU read-side critical section.
 
 3.	Does the update code tolerate concurrent accesses?
 
@@ -101,7 +101,7 @@ over a rather long period of time, but improvements are always welcome!
 	c.	Make updates appear atomic to readers.	For example,
 		pointer updates to properly aligned fields will
 		appear atomic, as will individual atomic primitives.
-		Sequences of operations performed under a lock will -not-
+		Sequences of operations performed under a lock will *not*
 		appear to be atomic to RCU readers, nor will sequences
 		of multiple atomic primitives.
 
@@ -333,7 +333,7 @@ over a rather long period of time, but improvements are always welcome!
 	for example) may be omitted.
 
 10.	Conversely, if you are in an RCU read-side critical section,
-	and you don't hold the appropriate update-side lock, you -must-
+	and you don't hold the appropriate update-side lock, you *must*
 	use the "_rcu()" variants of the list macros.  Failing to do so
 	will break Alpha, cause aggressive compilers to generate bad code,
 	and confuse people trying to read your code.
@@ -359,12 +359,12 @@ over a rather long period of time, but improvements are always welcome!
 	callback pending, then that RCU callback will execute on some
 	surviving CPU.	(If this was not the case, a self-spawning RCU
 	callback would prevent the victim CPU from ever going offline.)
-	Furthermore, CPUs designated by rcu_nocbs= might well -always-
+	Furthermore, CPUs designated by rcu_nocbs= might well *always*
 	have their RCU callbacks executed on some other CPUs, in fact,
 	for some  real-time workloads, this is the whole point of using
 	the rcu_nocbs= kernel boot parameter.
 
-13.	Unlike other forms of RCU, it -is- permissible to block in an
+13.	Unlike other forms of RCU, it *is* permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
 	Please note that if you don't need to sleep in read-side critical
@@ -411,16 +411,16 @@ over a rather long period of time, but improvements are always welcome!
 14.	The whole point of call_rcu(), synchronize_rcu(), and friends
 	is to wait until all pre-existing readers have finished before
 	carrying out some otherwise-destructive operation.  It is
-	therefore critically important to -first- remove any path
+	therefore critically important to *first* remove any path
 	that readers can follow that could be affected by the
-	destructive operation, and -only- -then- invoke call_rcu(),
+	destructive operation, and *only then* invoke call_rcu(),
 	synchronize_rcu(), or friends.
 
 	Because these primitives only wait for pre-existing readers, it
 	is the caller's responsibility to guarantee that any subsequent
 	readers will execute safely.
 
-15.	The various RCU read-side primitives do -not- necessarily contain
+15.	The various RCU read-side primitives do *not* necessarily contain
 	memory barriers.  You should therefore plan for the CPU
 	and the compiler to freely reorder code into and out of RCU
 	read-side critical sections.  It is the responsibility of the
@@ -459,8 +459,8 @@ over a rather long period of time, but improvements are always welcome!
 	pass in a function defined within a loadable module, then it in
 	necessary to wait for all pending callbacks to be invoked after
 	the last invocation and before unloading that module.  Note that
-	it is absolutely -not- sufficient to wait for a grace period!
-	The current (say) synchronize_rcu() implementation is -not-
+	it is absolutely *not* sufficient to wait for a grace period!
+	The current (say) synchronize_rcu() implementation is *not*
 	guaranteed to wait for callbacks registered on other CPUs.
 	Or even on the current CPU if that CPU recently went offline
 	and came back online.
@@ -470,7 +470,7 @@ over a rather long period of time, but improvements are always welcome!
 	-	call_rcu() -> rcu_barrier()
 	-	call_srcu() -> srcu_barrier()
 
-	However, these barrier functions are absolutely -not- guaranteed
+	However, these barrier functions are absolutely *not* guaranteed
 	to wait for a grace period.  In fact, if there are no call_rcu()
 	callbacks waiting anywhere in the system, rcu_barrier() is within
 	its rights to return immediately.
diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index f3e587acb4deb..0b418a5b243c5 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -43,7 +43,7 @@ Follow these rules to keep your RCU code working properly:
 	-	Set bits and clear bits down in the must-be-zero low-order
 		bits of that pointer.  This clearly means that the pointer
 		must have alignment constraints, for example, this does
-		-not- work in general for char* pointers.
+		*not* work in general for char* pointers.
 
 	-	XOR bits to translate pointers, as is done in some
 		classic buddy-allocator algorithms.
@@ -174,7 +174,7 @@ Follow these rules to keep your RCU code working properly:
 		Please see the "CONTROL DEPENDENCIES" section of
 		Documentation/memory-barriers.txt for more details.
 
-	-	The pointers are not equal -and- the compiler does
+	-	The pointers are not equal *and* the compiler does
 		not have enough information to deduce the value of the
 		pointer.  Note that the volatile cast in rcu_dereference()
 		will normally prevent the compiler from knowing too much.
@@ -360,7 +360,7 @@ in turn destroying the ordering between this load and the loads of the
 return values.  This can result in "p->b" returning pre-initialization
 garbage values.
 
-In short, rcu_dereference() is -not- optional when you are going to
+In short, rcu_dereference() is *not* optional when you are going to
 dereference the resulting pointer.
 
 
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 7148e9be08c34..1cc944aec46f2 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -32,7 +32,7 @@ warnings:
 
 -	Booting Linux using a console connection that is too slow to
 	keep up with the boot-time console-message rate.  For example,
-	a 115Kbaud serial console can be -way- too slow to keep up
+	a 115Kbaud serial console can be *way* too slow to keep up
 	with boot-time message rates, and will frequently result in
 	RCU CPU stall warning messages.  Especially if you have added
 	debug printk()s.
@@ -105,7 +105,7 @@ warnings:
 	leading the realization that the CPU had failed.
 
 The RCU, RCU-sched, and RCU-tasks implementations have CPU stall warning.
-Note that SRCU does -not- have CPU stall warnings.  Please note that
+Note that SRCU does *not* have CPU stall warnings.  Please note that
 RCU only detects CPU stalls when there is a grace period in progress.
 No grace period, no CPU stall warnings.
 
@@ -145,7 +145,7 @@ CONFIG_RCU_CPU_STALL_TIMEOUT
 	this parameter is checked only at the beginning of a cycle.
 	So if you are 10 seconds into a 40-second stall, setting this
 	sysfs parameter to (say) five will shorten the timeout for the
-	-next- stall, or the following warning for the current stall
+	*next* stall, or the following warning for the current stall
 	(assuming the stall lasts long enough).  It will not affect the
 	timing of the next warning for the current stall.
 
@@ -202,7 +202,7 @@ causing stalls, and that the stall was affecting RCU-sched.  This message
 will normally be followed by stack dumps for each CPU.  Please note that
 PREEMPT_RCU builds can be stalled by tasks as well as by CPUs, and that
 the tasks will be indicated by PID, for example, "P3421".  It is even
-possible for an rcu_state stall to be caused by both CPUs -and- tasks,
+possible for an rcu_state stall to be caused by both CPUs *and* tasks,
 in which case the offending CPUs and tasks will all be called out in the list.
 
 CPU 2's "(3 GPs behind)" indicates that this CPU has not interacted with
-- 
2.31.1.189.g2e36527f23

