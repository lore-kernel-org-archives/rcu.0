Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB6C433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193CE206C3
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871030;
	bh=Ek8EfCbICOB90yBhrr0TgcV/O/2IbTB08/ZmKsyJYMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XeuvOztIjH5Q+5xi8Ao4FQuwxeJsc2ChJU+/K8nEXz2mcnvvFhhziSXSwh9PHUmRd
	 +4yGjuVKLvmvEMLTwpzT3aZ+H/9R8FogYfdOmCK7wmI0n60ks4ko14gs6pHEAfpxvM
	 l/83xLXFVvcQSS3u0CG/PwmvcYcVg3N+dFHqaoXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbgFWAKZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731496AbgFWAJv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667722084D;
        Tue, 23 Jun 2020 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870990;
        bh=Ek8EfCbICOB90yBhrr0TgcV/O/2IbTB08/ZmKsyJYMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxykK1X60lXgrbu+NaHfzr381Nm0NoFIH47NCW92l13IQLjZ1c0nHLldVDkQaDGdY
         WprkNqs2hsQdhWOBY+6+GvIYZPNR1lP+SZe1awbS7oEwftpzixdEYLQfQmiUH3q27v
         V2kQa1KkWlrFLSjDc279ciSp0P0tnzy6tEOwNPjo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/10] docs: RCU: Convert torture.txt to ReST
Date:   Mon, 22 Jun 2020 17:09:42 -0700
Message-Id: <20200623000947.25222-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623000923.GA25047@paulmck-ThinkPad-P72>
References: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

- Add a SPDX header;
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst                    |   1 +
 Documentation/RCU/{torture.txt => torture.rst} | 117 ++++++++++++++-----------
 Documentation/locking/locktorture.rst          |   2 +-
 MAINTAINERS                                    |   4 +-
 kernel/rcu/rcutorture.c                        |   2 +-
 5 files changed, 69 insertions(+), 57 deletions(-)
 rename Documentation/RCU/{torture.txt => torture.rst} (76%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 577a47e..5d5f9a1 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -18,6 +18,7 @@ RCU concepts
    whatisRCU
    rcu
    rculist_nulls
+   torture
    listRCU
    NMI-RCU
    UP
diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.rst
similarity index 76%
rename from Documentation/RCU/torture.txt
rename to Documentation/RCU/torture.rst
index af712a3..a901477 100644
--- a/Documentation/RCU/torture.txt
+++ b/Documentation/RCU/torture.rst
@@ -1,7 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
 RCU Torture Test Operation
+==========================
 
 
 CONFIG_RCU_TORTURE_TEST
+=======================
 
 The CONFIG_RCU_TORTURE_TEST config option is available for all RCU
 implementations.  It creates an rcutorture kernel module that can
@@ -13,9 +18,10 @@ when the module is loaded, and stops when the module is unloaded.
 Module parameters are prefixed by "rcutorture." in
 Documentation/admin-guide/kernel-parameters.txt.
 
-OUTPUT
+Output
+======
 
-The statistics output is as follows:
+The statistics output is as follows::
 
 	rcu-torture:--- Start of test: nreaders=16 nfakewriters=4 stat_interval=30 verbose=0 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4
 	rcu-torture: rtc:           (null) ver: 155441 tfle: 0 rta: 155441 rtaf: 8884 rtf: 155440 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3055767
@@ -36,53 +42,53 @@ automatic determination as to whether RCU operated correctly.
 
 The entries are as follows:
 
-o	"rtc": The hexadecimal address of the structure currently visible
+*	"rtc": The hexadecimal address of the structure currently visible
 	to readers.
 
-o	"ver": The number of times since boot that the RCU writer task
+*	"ver": The number of times since boot that the RCU writer task
 	has changed the structure visible to readers.
 
-o	"tfle": If non-zero, indicates that the "torture freelist"
+*	"tfle": If non-zero, indicates that the "torture freelist"
 	containing structures to be placed into the "rtc" area is empty.
 	This condition is important, since it can fool you into thinking
 	that RCU is working when it is not.  :-/
 
-o	"rta": Number of structures allocated from the torture freelist.
+*	"rta": Number of structures allocated from the torture freelist.
 
-o	"rtaf": Number of allocations from the torture freelist that have
+*	"rtaf": Number of allocations from the torture freelist that have
 	failed due to the list being empty.  It is not unusual for this
 	to be non-zero, but it is bad for it to be a large fraction of
 	the value indicated by "rta".
 
-o	"rtf": Number of frees into the torture freelist.
+*	"rtf": Number of frees into the torture freelist.
 
-o	"rtmbe": A non-zero value indicates that rcutorture believes that
+*	"rtmbe": A non-zero value indicates that rcutorture believes that
 	rcu_assign_pointer() and rcu_dereference() are not working
 	correctly.  This value should be zero.
 
-o	"rtbe": A non-zero value indicates that one of the rcu_barrier()
+*	"rtbe": A non-zero value indicates that one of the rcu_barrier()
 	family of functions is not working correctly.
 
-o	"rtbke": rcutorture was unable to create the real-time kthreads
+*	"rtbke": rcutorture was unable to create the real-time kthreads
 	used to force RCU priority inversion.  This value should be zero.
 
-o	"rtbre": Although rcutorture successfully created the kthreads
+*	"rtbre": Although rcutorture successfully created the kthreads
 	used to force RCU priority inversion, it was unable to set them
 	to the real-time priority level of 1.  This value should be zero.
 
-o	"rtbf": The number of times that RCU priority boosting failed
+*	"rtbf": The number of times that RCU priority boosting failed
 	to resolve RCU priority inversion.
 
-o	"rtb": The number of times that rcutorture attempted to force
+*	"rtb": The number of times that rcutorture attempted to force
 	an RCU priority inversion condition.  If you are testing RCU
 	priority boosting via the "test_boost" module parameter, this
 	value should be non-zero.
 
-o	"nt": The number of times rcutorture ran RCU read-side code from
+*	"nt": The number of times rcutorture ran RCU read-side code from
 	within a timer handler.  This value should be non-zero only
 	if you specified the "irqreader" module parameter.
 
-o	"Reader Pipe": Histogram of "ages" of structures seen by readers.
+*	"Reader Pipe": Histogram of "ages" of structures seen by readers.
 	If any entries past the first two are non-zero, RCU is broken.
 	And rcutorture prints the error flag string "!!!" to make sure
 	you notice.  The age of a newly allocated structure is zero,
@@ -94,14 +100,14 @@ o	"Reader Pipe": Histogram of "ages" of structures seen by readers.
 	RCU.  If you want to see what it looks like when broken, break
 	it yourself.  ;-)
 
-o	"Reader Batch": Another histogram of "ages" of structures seen
+*	"Reader Batch": Another histogram of "ages" of structures seen
 	by readers, but in terms of counter flips (or batches) rather
 	than in terms of grace periods.  The legal number of non-zero
 	entries is again two.  The reason for this separate view is that
 	it is sometimes easier to get the third entry to show up in the
 	"Reader Batch" list than in the "Reader Pipe" list.
 
-o	"Free-Block Circulation": Shows the number of torture structures
+*	"Free-Block Circulation": Shows the number of torture structures
 	that have reached a given point in the pipeline.  The first element
 	should closely correspond to the number of structures allocated,
 	the second to the number that have been removed from reader view,
@@ -112,7 +118,7 @@ o	"Free-Block Circulation": Shows the number of torture structures
 
 Different implementations of RCU can provide implementation-specific
 additional information.  For example, Tree SRCU provides the following
-additional line:
+additional line::
 
 	srcud-torture: Tree SRCU per-CPU(idx=0): 0(35,-21) 1(-4,24) 2(1,1) 3(-26,20) 4(28,-47) 5(-9,4) 6(-10,14) 7(-14,11) T(1,6)
 
@@ -123,15 +129,15 @@ using a dynamically allocated srcu_struct (hence "srcud-" rather than
 "old" and "current" values to the underlying array, and is useful for
 debugging.  The final "T" entry contains the totals of the counters.
 
-
-USAGE ON SPECIFIC KERNEL BUILDS
+Usage on Specific Kernel Builds
+===============================
 
 It is sometimes desirable to torture RCU on a specific kernel build,
 for example, when preparing to put that kernel build into production.
 In that case, the kernel should be built with CONFIG_RCU_TORTURE_TEST=m
 so that the test can be started using modprobe and terminated using rmmod.
 
-For example, the following script may be used to torture RCU:
+For example, the following script may be used to torture RCU::
 
 	#!/bin/sh
 
@@ -148,7 +154,8 @@ two are self-explanatory, while the last indicates that while there
 were no RCU failures, CPU-hotplug problems were detected.
 
 
-USAGE ON MAINLINE KERNELS
+Usage on Mainline Kernels
+=========================
 
 When using rcutorture to test changes to RCU itself, it is often
 necessary to build a number of kernels in order to test that change
@@ -180,16 +187,16 @@ to Tree SRCU might run only the SRCU-N and SRCU-P scenarios using the
 --configs argument to kvm.sh as follows:  "--configs 'SRCU-N SRCU-P'".
 Large systems can run multiple copies of of the full set of scenarios,
 for example, a system with 448 hardware threads can run five instances
-of the full set concurrently.  To make this happen:
+of the full set concurrently.  To make this happen::
 
 	kvm.sh --cpus 448 --configs '5*CFLIST'
 
 Alternatively, such a system can run 56 concurrent instances of a single
-eight-CPU scenario:
+eight-CPU scenario::
 
 	kvm.sh --cpus 448 --configs '56*TREE04'
 
-Or 28 concurrent instances of each of two eight-CPU scenarios:
+Or 28 concurrent instances of each of two eight-CPU scenarios::
 
 	kvm.sh --cpus 448 --configs '28*TREE03 28*TREE04'
 
@@ -199,14 +206,14 @@ values for memory may require disabling the callback-flooding tests
 using the --bootargs parameter discussed below.
 
 Sometimes additional debugging is useful, and in such cases the --kconfig
-parameter to kvm.sh may be used, for example, "--kconfig 'CONFIG_KASAN=y'".
+parameter to kvm.sh may be used, for example, ``--kconfig 'CONFIG_KASAN=y'``.
 
 Kernel boot arguments can also be supplied, for example, to control
 rcutorture's module parameters.  For example, to test a change to RCU's
 CPU stall-warning code, use "--bootargs 'rcutorture.stall_cpu=30'".
 This will of course result in the scripting reporting a failure, namely
 the resuling RCU CPU stall warning.  As noted above, reducing memory may
-require disabling rcutorture's callback-flooding tests:
+require disabling rcutorture's callback-flooding tests::
 
 	kvm.sh --cpus 448 --configs '56*TREE04' --memory 128M \
 		--bootargs 'rcutorture.fwd_progress=0'
@@ -225,7 +232,7 @@ is listed at the end of the kvm.sh output, which you really should redirect
 to a file.  The build products and console output of each run is kept in
 tools/testing/selftests/rcutorture/res in timestamped directories.  A
 given directory can be supplied to kvm-find-errors.sh in order to have
-it cycle you through summaries of errors and full error logs.  For example:
+it cycle you through summaries of errors and full error logs.  For example::
 
 	tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh \
 		tools/testing/selftests/rcutorture/res/2020.01.20-15.54.23
@@ -245,38 +252,42 @@ that was tested and any uncommitted changes in diff format.
 
 The most frequently used files in each per-scenario-run directory are:
 
-.config: This file contains the Kconfig options.
+.config:
+	This file contains the Kconfig options.
 
-Make.out: This contains build output for a specific scenario.
+Make.out:
+	This contains build output for a specific scenario.
 
-console.log: This contains the console output for a specific scenario.
+console.log:
+	This contains the console output for a specific scenario.
 	This file may be examined once the kernel has booted, but
 	it might not exist if the build failed.
 
-vmlinux: This contains the kernel, which can be useful with tools like
+vmlinux:
+	This contains the kernel, which can be useful with tools like
 	objdump and gdb.
 
 A number of additional files are available, but are less frequently used.
 Many are intended for debugging of rcutorture itself or of its scripting.
 
 As of v5.4, a successful run with the default set of scenarios produces
-the following summary at the end of the run on a 12-CPU system:
-
-SRCU-N ------- 804233 GPs (148.932/s) [srcu: g10008272 f0x0 ]
-SRCU-P ------- 202320 GPs (37.4667/s) [srcud: g1809476 f0x0 ]
-SRCU-t ------- 1122086 GPs (207.794/s) [srcu: g0 f0x0 ]
-SRCU-u ------- 1111285 GPs (205.794/s) [srcud: g1 f0x0 ]
-TASKS01 ------- 19666 GPs (3.64185/s) [tasks: g0 f0x0 ]
-TASKS02 ------- 20541 GPs (3.80389/s) [tasks: g0 f0x0 ]
-TASKS03 ------- 19416 GPs (3.59556/s) [tasks: g0 f0x0 ]
-TINY01 ------- 836134 GPs (154.84/s) [rcu: g0 f0x0 ] n_max_cbs: 34198
-TINY02 ------- 850371 GPs (157.476/s) [rcu: g0 f0x0 ] n_max_cbs: 2631
-TREE01 ------- 162625 GPs (30.1157/s) [rcu: g1124169 f0x0 ]
-TREE02 ------- 333003 GPs (61.6672/s) [rcu: g2647753 f0x0 ] n_max_cbs: 35844
-TREE03 ------- 306623 GPs (56.782/s) [rcu: g2975325 f0x0 ] n_max_cbs: 1496497
-CPU count limited from 16 to 12
-TREE04 ------- 246149 GPs (45.5831/s) [rcu: g1695737 f0x0 ] n_max_cbs: 434961
-TREE05 ------- 314603 GPs (58.2598/s) [rcu: g2257741 f0x2 ] n_max_cbs: 193997
-TREE07 ------- 167347 GPs (30.9902/s) [rcu: g1079021 f0x0 ] n_max_cbs: 478732
-CPU count limited from 16 to 12
-TREE09 ------- 752238 GPs (139.303/s) [rcu: g13075057 f0x0 ] n_max_cbs: 99011
+the following summary at the end of the run on a 12-CPU system::
+
+    SRCU-N ------- 804233 GPs (148.932/s) [srcu: g10008272 f0x0 ]
+    SRCU-P ------- 202320 GPs (37.4667/s) [srcud: g1809476 f0x0 ]
+    SRCU-t ------- 1122086 GPs (207.794/s) [srcu: g0 f0x0 ]
+    SRCU-u ------- 1111285 GPs (205.794/s) [srcud: g1 f0x0 ]
+    TASKS01 ------- 19666 GPs (3.64185/s) [tasks: g0 f0x0 ]
+    TASKS02 ------- 20541 GPs (3.80389/s) [tasks: g0 f0x0 ]
+    TASKS03 ------- 19416 GPs (3.59556/s) [tasks: g0 f0x0 ]
+    TINY01 ------- 836134 GPs (154.84/s) [rcu: g0 f0x0 ] n_max_cbs: 34198
+    TINY02 ------- 850371 GPs (157.476/s) [rcu: g0 f0x0 ] n_max_cbs: 2631
+    TREE01 ------- 162625 GPs (30.1157/s) [rcu: g1124169 f0x0 ]
+    TREE02 ------- 333003 GPs (61.6672/s) [rcu: g2647753 f0x0 ] n_max_cbs: 35844
+    TREE03 ------- 306623 GPs (56.782/s) [rcu: g2975325 f0x0 ] n_max_cbs: 1496497
+    CPU count limited from 16 to 12
+    TREE04 ------- 246149 GPs (45.5831/s) [rcu: g1695737 f0x0 ] n_max_cbs: 434961
+    TREE05 ------- 314603 GPs (58.2598/s) [rcu: g2257741 f0x2 ] n_max_cbs: 193997
+    TREE07 ------- 167347 GPs (30.9902/s) [rcu: g1079021 f0x0 ] n_max_cbs: 478732
+    CPU count limited from 16 to 12
+    TREE09 ------- 752238 GPs (139.303/s) [rcu: g13075057 f0x0 ] n_max_cbs: 99011
diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
index 8012a74..dfaf9fc 100644
--- a/Documentation/locking/locktorture.rst
+++ b/Documentation/locking/locktorture.rst
@@ -166,4 +166,4 @@ checked for such errors.  The "rmmod" command forces a "SUCCESS",
 two are self-explanatory, while the last indicates that while there
 were no locking failures, CPU-hotplug problems were detected.
 
-Also see: Documentation/RCU/torture.txt
+Also see: Documentation/RCU/torture.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d4..62b67aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14424,7 +14424,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	Documentation/RCU/
 F:	include/linux/rcu*
 F:	kernel/rcu/
-X:	Documentation/RCU/torture.txt
+X:	Documentation/RCU/torture.rst
 X:	include/linux/srcu*.h
 X:	kernel/rcu/srcu*.c
 
@@ -17273,7 +17273,7 @@ M:	Josh Triplett <josh@joshtriplett.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
-F:	Documentation/RCU/torture.txt
+F:	Documentation/RCU/torture.rst
 F:	kernel/locking/locktorture.c
 F:	kernel/rcu/rcuperf.c
 F:	kernel/rcu/rcutorture.c
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index efb792e..8205295 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -7,7 +7,7 @@
  * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
  *	  Josh Triplett <josh@joshtriplett.org>
  *
- * See also:  Documentation/RCU/torture.txt
+ * See also:  Documentation/RCU/torture.rst
  */
 
 #define pr_fmt(fmt) fmt
-- 
2.9.5

