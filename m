Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F01DC55185
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBE7206F4
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488682;
	bh=HtfviJYMWAUQnn76H1unLVtLVRpa61DyXl/UOqSeNI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dM4LmiUgvs9HVUUSLvdnKh2mZ6WMjqKL+7WjS/piggUe38bwoM/9fx2Ex0w9dsPtx
	 1eIz+ZONPx/rd2PMU9NT2Mzo2acECLDrAjpaDVS5TFqlo93+opaHm1MiFI5nZOw5Ic
	 FNqbpiQTXdg9g2CFZ29WxxX+Y7vWdwn1agSFunBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDUREh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgDUREQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 13:04:16 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0E120724;
        Tue, 21 Apr 2020 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488654;
        bh=HtfviJYMWAUQnn76H1unLVtLVRpa61DyXl/UOqSeNI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nawnjWrLCE6gDIp4spQFTrPgqLCIyt5E7SNBTI4AQXBGbVHF2feViMCSxStLkq860
         5EsSpmC/92tXoUY7LJ8uDsNgbUO/+yMdLaeduGEsUbrPKgPaU+8jjmUGDJCKG+ovSV
         2tJ7/oPPw5vxHlmvVzMmru5PcXkvvLUUf88nI9gU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwJg-00CmLn-5p; Tue, 21 Apr 2020 19:04:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org
Subject: [PATCH 05/10] docs: RCU: convert torture.txt to ReST
Date:   Tue, 21 Apr 2020 19:04:06 +0200
Message-Id: <3f30d40cbef9919cb9f47e3b0bc8012c003e0089.1587488137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587488137.git.mchehab+huawei@kernel.org>
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/RCU/index.rst                   |   1 +
 .../RCU/{torture.txt => torture.rst}          | 115 ++++++++++--------
 Documentation/locking/locktorture.rst         |   2 +-
 MAINTAINERS                                   |   4 +-
 kernel/rcu/rcutorture.c                       |   2 +-
 5 files changed, 68 insertions(+), 56 deletions(-)
 rename Documentation/RCU/{torture.txt => torture.rst} (76%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 577a47e27f5d..5d5f9a1ab8f9 100644
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
index af712a3c5b6a..a90147713062 100644
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
+the following summary at the end of the run on a 12-CPU system::
 
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
index 5bcb99ba7bd9..0b4bbe378bf1 100644
--- a/Documentation/locking/locktorture.rst
+++ b/Documentation/locking/locktorture.rst
@@ -166,4 +166,4 @@ checked for such errors.  The "rmmod" command forces a "SUCCESS",
 two are self-explanatory, while the last indicates that while there
 were no locking failures, CPU-hotplug problems were detected.
 
-Also see: Documentation/RCU/torture.txt
+Also see: Documentation/RCU/torture.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index ecf38ddd8962..ca534da466db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14309,7 +14309,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	Documentation/RCU/
 F:	include/linux/rcu*
 F:	kernel/rcu/
-X:	Documentation/RCU/torture.txt
+X:	Documentation/RCU/torture.rst
 X:	include/linux/srcu*.h
 X:	kernel/rcu/srcu*.c
 
@@ -17101,7 +17101,7 @@ M:	Josh Triplett <josh@joshtriplett.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
-F:	Documentation/RCU/torture.txt
+F:	Documentation/RCU/torture.rst
 F:	kernel/locking/locktorture.c
 F:	kernel/rcu/rcuperf.c
 F:	kernel/rcu/rcutorture.c
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index efb792e13fca..8205295fc33e 100644
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
2.25.2

