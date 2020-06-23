Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BCBC433E2
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F9F208A7
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872245;
	bh=3pYFhXqKTFY2pMPdZv3LeLmznqsHYNsP2sxRiFF0Q6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VFa18lKCcJdRD1zBj25cr5aqN+pMoZ7saQCmYA4+aFLQ58EbhZU04NHyCq6VHKEDV
	 9Mq8a2iOOyeF1rcmmOfYUqxs3YUdeptIMX6QMF7sbRaUiurWN958uN2GEijwu4hqK9
	 yzk4ItqFy3RGVc47sDn66aWoGNQWFSLj6snTJfsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgFWAap (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731728AbgFWAaV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1BC20B80;
        Tue, 23 Jun 2020 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872221;
        bh=3pYFhXqKTFY2pMPdZv3LeLmznqsHYNsP2sxRiFF0Q6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ja5ENAKSF+kr1G//xlSSSKWQv6w5XMG5IuFcNHVBv+Iiv+52YS85CZEmo4TnGRiGz
         PLfvOCxgFJh9/I+9ubqnGf69UDy/tO2qZ4IDtRUMo0fWis10OzRBMthHYwDEkpwdey
         42m8YoWDA9Kz0XChENbB/2AhGpy7V1G1Ys97MBsU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 30/30] refscale: Change --torture type from refperf to refscale
Date:   Mon, 22 Jun 2020 17:30:13 -0700
Message-Id: <20200623003013.26252-30-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit renames the rcutorture config/refperf to config/refscale to
further avoid conflation with the Linux kernel's perf feature.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../bin/{kvm-recheck-refperf.sh => kvm-recheck-refscale.sh}       | 8 ++++----
 tools/testing/selftests/rcutorture/bin/kvm.sh                     | 8 ++++----
 tools/testing/selftests/rcutorture/bin/parse-console.sh           | 4 ++--
 .../selftests/rcutorture/configs/{refperf => refscale}/CFLIST     | 0
 .../selftests/rcutorture/configs/{refperf => refscale}/CFcommon   | 0
 .../selftests/rcutorture/configs/{refperf => refscale}/NOPREEMPT  | 0
 .../selftests/rcutorture/configs/{refperf => refscale}/PREEMPT    | 0
 .../rcutorture/configs/{refperf => refscale}/ver_functions.sh     | 0
 8 files changed, 10 insertions(+), 10 deletions(-)
 rename tools/testing/selftests/rcutorture/bin/{kvm-recheck-refperf.sh => kvm-recheck-refscale.sh} (87%)
 rename tools/testing/selftests/rcutorture/configs/{refperf => refscale}/CFLIST (100%)
 rename tools/testing/selftests/rcutorture/configs/{refperf => refscale}/CFcommon (100%)
 rename tools/testing/selftests/rcutorture/configs/{refperf => refscale}/NOPREEMPT (100%)
 rename tools/testing/selftests/rcutorture/configs/{refperf => refscale}/PREEMPT (100%)
 rename tools/testing/selftests/rcutorture/configs/{refperf => refscale}/ver_functions.sh (100%)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
similarity index 87%
rename from tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
rename to tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
index 0e29cfd..35a463d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
@@ -1,9 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Analyze a given results directory for refperf performance measurements.
+# Analyze a given results directory for refscale performance measurements.
 #
-# Usage: kvm-recheck-refperf.sh resdir
+# Usage: kvm-recheck-refscale.sh resdir
 #
 # Copyright (C) IBM Corporation, 2016
 #
@@ -51,7 +51,7 @@ END {
 	print configfile " results:";
 	newNR = asort(readertimes);
 	if (newNR <= 0) {
-		print "No refperf records found???"
+		print "No refscale records found???"
 		exit;
 	}
 	medianidx = int(newNR / 2);
@@ -67,5 +67,5 @@ END {
 	print "Minimum reader duration: " readertimes[1];
 	print "Median reader duration: " medianvalue;
 	print "Maximum reader duration: " readertimes[newNR];
-	print "Computed from refperf printk output.";
+	print "Computed from refscale printk output.";
 }'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 48b6a72..ce05db3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -180,14 +180,14 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refperf\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refscale\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
-		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refperf
+		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refscale
 		then
-			# If you really want jitter for refperf or
+			# If you really want jitter for refscale or
 			# rcuperf, specify it after specifying the rcuperf
-			# or the refperf.  (But why jitter in these cases?)
+			# or the refscale.  (But why jitter in these cases?)
 			jitter=0
 		fi
 		;;
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 85af11d..8cb908f 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -33,8 +33,8 @@ then
 fi
 cat /dev/null > $file.diags
 
-# Check for proper termination, except for rcuperf and refperf.
-if test "$TORTURE_SUITE" != rcuperf && test "$TORTURE_SUITE" != refperf
+# Check for proper termination, except for rcuperf and refscale.
+if test "$TORTURE_SUITE" != rcuperf && test "$TORTURE_SUITE" != refscale
 then
 	# check for abject failure
 
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFLIST b/tools/testing/selftests/rcutorture/configs/refscale/CFLIST
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/refperf/CFLIST
rename to tools/testing/selftests/rcutorture/configs/refscale/CFLIST
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon b/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/refperf/CFcommon
rename to tools/testing/selftests/rcutorture/configs/refscale/CFcommon
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
rename to tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
rename to tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
rename to tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
-- 
2.9.5

