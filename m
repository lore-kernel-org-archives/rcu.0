Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADAC433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E77E20874
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872219;
	bh=gXkXDAf7PeNCQXChyIU/OUiTHm+cWnF84swFkMcUlMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jy+WJ5CUCr4PeLQBgxiuiqg+LIgf7iGbM84pI9n6pjkf4cnYaq/AB82vjegmYSVI/
	 DKOIJ/3LPdakhTwH7PcCwGNNYIRI2f9KEX8QKtuBuEsWIpMrmBxg2FDYewLoiUHD71
	 l4dyoBz1haYUIw6KEXkGAU0UkCuwHEAPTXWD+hVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgFWAaS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731621AbgFWAaR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BFC20786;
        Tue, 23 Jun 2020 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872216;
        bh=gXkXDAf7PeNCQXChyIU/OUiTHm+cWnF84swFkMcUlMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXZnBCZqexarRbbWxuxb/1ryQ/YA+ZVAHS5/zPWyoWr61Qa+mkYb/06dfCTBSacWX
         M6le4rteDgmK59vmFvRKDRyO45aDMB3NAniVrfWpVHrtWEQFUinvAx8shRoYiSWm3h
         lk8znmcuPEK8GvrxaY+03Nj6s/dg1VEPg1RT/Luw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/30] torture: Add refperf to the rcutorture scripting
Date:   Mon, 22 Jun 2020 17:29:47 -0700
Message-Id: <20200623003013.26252-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit updates the rcutorture scripting to include the new refperf
torture-test module.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../rcutorture/bin/kvm-recheck-refperf.sh          | 67 ++++++++++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  9 +--
 .../selftests/rcutorture/bin/parse-console.sh      |  4 +-
 .../selftests/rcutorture/configs/refperf/CFLIST    |  2 +
 .../selftests/rcutorture/configs/refperf/CFcommon  |  2 +
 .../selftests/rcutorture/configs/refperf/NOPREEMPT | 18 ++++++
 .../selftests/rcutorture/configs/refperf/PREEMPT   | 18 ++++++
 .../rcutorture/configs/refperf/ver_functions.sh    | 16 ++++++
 8 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
new file mode 100755
index 0000000..6fc06cd
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Analyze a given results directory for refperf performance measurements.
+#
+# Usage: kvm-recheck-refperf.sh resdir
+#
+# Copyright (C) IBM Corporation, 2016
+#
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
+
+i="$1"
+if test -d "$i" -a -r "$i"
+then
+	:
+else
+	echo Unreadable results directory: $i
+	exit 1
+fi
+PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
+. functions.sh
+
+configfile=`echo $i | sed -e 's/^.*\///'`
+
+sed -e 's/^\[[^]]*]//' < $i/console.log | tr -d '\015' |
+awk -v configfile="$configfile" '
+/^[ 	]*Threads	Time\(ns\) *$/ {
+	if (dataphase + 0 == 0) {
+		dataphase = 1;
+		# print configfile, $0;
+	}
+	next;
+}
+
+/[^ 	]*[0-9][0-9]*	[0-9][0-9]*\.[0-9][0-9]*$/ {
+	if (dataphase == 1) {
+		# print $0;
+		readertimes[++n] = $2;
+		sum += $2;
+	}
+	next;
+}
+
+{
+	if (dataphase == 1)
+		dataphase == 2;
+	next;
+}
+
+END {
+	print configfile " results:";
+	newNR = asort(readertimes);
+	if (newNR <= 0) {
+		print "No refperf records found???"
+		exit;
+	}
+	medianidx = int(newNR / 2);
+	if (newNR == medianidx * 2)
+		medianvalue = (readertimes[medianidx - 1] + readertimes[medianidx]) / 2;
+	else
+		medianvalue = readertimes[medianidx];
+	print "Average reader duration: " sum / newNR " nanoseconds";
+	print "Minimum reader duration: " readertimes[1];
+	print "Median reader duration: " medianvalue;
+	print "Maximum reader duration: " readertimes[newNR];
+	print "Computed from refperf printk output.";
+}'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c279cf9..48b6a72 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -180,13 +180,14 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refperf\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
-		if test "$TORTURE_SUITE" = rcuperf
+		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refperf
 		then
-			# If you really want jitter for rcuperf, specify
-			# it after specifying rcuperf.  (But why?)
+			# If you really want jitter for refperf or
+			# rcuperf, specify it after specifying the rcuperf
+			# or the refperf.  (But why jitter in these cases?)
 			jitter=0
 		fi
 		;;
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 4bf62d7..85af11d 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -33,8 +33,8 @@ then
 fi
 cat /dev/null > $file.diags
 
-# Check for proper termination, except that rcuperf runs don't indicate this.
-if test "$TORTURE_SUITE" != rcuperf
+# Check for proper termination, except for rcuperf and refperf.
+if test "$TORTURE_SUITE" != rcuperf && test "$TORTURE_SUITE" != refperf
 then
 	# check for abject failure
 
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFLIST b/tools/testing/selftests/rcutorture/configs/refperf/CFLIST
new file mode 100644
index 0000000..4d62eb4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/CFLIST
@@ -0,0 +1,2 @@
+NOPREEMPT
+PREEMPT
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
new file mode 100644
index 0000000..8ba5ba2
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
@@ -0,0 +1,2 @@
+CONFIG_RCU_REF_PERF_TEST=y
+CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
new file mode 100644
index 0000000..1cd25b7
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_PREEMPT_RCU=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT b/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
new file mode 100644
index 0000000..d10bc69
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
new file mode 100644
index 0000000..489f05d
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Torture-suite-dependent shell functions for the rest of the scripts.
+#
+# Copyright (C) IBM Corporation, 2015
+#
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
+
+# per_version_boot_params bootparam-string config-file seconds
+#
+# Adds per-version torture-module parameters to kernels supporting them.
+per_version_boot_params () {
+	echo $1 refperf.shutdown=1 \
+		refperf.verbose=1
+}
-- 
2.9.5

