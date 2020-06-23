Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2200DC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D3720890
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872717;
	bh=zJqCMZ7Nvc8+rI2tctx6dZY0axoJnmJdlEQSqbhmTpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KkkUMJLig+Hu4bq/VY0d0LeEIysHTBSSa9SPu2JQP1+D+yQFppyC/dmq/gU3BNG5K
	 JeTx50WVzqJqopYXYEjXqeW6QzMlT+5O0GxN0ed1o8Rg3mlrQVyY06cDSztGJaNeKH
	 RNMFFxsXzz/gNIhG4XUk6sF58v3NZ7kUBXyrzWAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbgFWAh5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbgFWAh5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C7F20C56;
        Tue, 23 Jun 2020 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872676;
        bh=zJqCMZ7Nvc8+rI2tctx6dZY0axoJnmJdlEQSqbhmTpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahFOjxIfCLHtG7RDM3lzKLWpWoMpPD4uY6gj6/l95/hTibep0p+fomaprQ2IdyqOh
         Vv/oxdxXYACg2IQR4023AlL9dn06wVmHVV89BFwPYLmOxKWVVxPtmrp3gCoTtIr0EF
         Vg68NpV3SSIiMGmn73jSww10dSp5pjELS3v/LGOs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/23] torture: Add a stop-run capability
Date:   Mon, 22 Jun 2020 17:37:41 -0700
Message-Id: <20200623003752.26872-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When bisecting RCU issues, it is often the case that the first error in
an unsuccessful run will happen quickly, but that a successful run must
go on for some time in order to obtain a sufficiently low false-negative
error rate.  In many cases, a bisection requires multiple concurrent
runs, in which case the first failure in any run indicates failure,
pure and simple.  In such cases, it would speed things up greatly if
the first failure terminated all runs.

This commit therefore adds scripting that checks for a file named "STOP"
in the top-level results directory, terminating the run when it appears.
Note that in-progress builds will continue until completion, but future
builds and all runs will be cut short.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh         |  6 ++++++
 tools/testing/selftests/rcutorture/bin/kvm-build.sh      |  6 ++++++
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 13 +++++++++++--
 tools/testing/selftests/rcutorture/bin/kvm.sh            |  2 ++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 30cb5b2..188b864 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -46,6 +46,12 @@ do
 		exit 0;
 	fi
 
+	# Check for stop request.
+	if test -f "$TORTURE_STOPFILE"
+	then
+		exit 1;
+	fi
+
 	# Set affinity to randomly selected online CPU
 	if cpus=`grep 1 /sys/devices/system/cpu/*/online 2>&1 |
 		 sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//'`
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 18d6518..115e182 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -9,6 +9,12 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
+if test -f "$TORTURE_STOPFILE"
+then
+	echo "kvm-build.sh early exit due to run STOP request"
+	exit 1
+fi
+
 config_template=${1}
 if test -z "$config_template" -o ! -f "$config_template" -o ! -r "$config_template"
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 064dd73..5ec095d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -182,7 +182,7 @@ do
 	kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 	if test -z "$qemu_pid" || kill -0 "$qemu_pid" > /dev/null 2>&1
 	then
-		if test $kruntime -ge $seconds
+		if test $kruntime -ge $seconds -o -f "$TORTURE_STOPFILE"
 		then
 			break;
 		fi
@@ -211,10 +211,19 @@ then
 fi
 if test $commandcompleted -eq 0 -a -n "$qemu_pid"
 then
-	echo Grace period for qemu job at pid $qemu_pid
+	if ! test -f "$TORTURE_STOPFILE"
+	then
+		echo Grace period for qemu job at pid $qemu_pid
+	fi
 	oldline="`tail $resdir/console.log`"
 	while :
 	do
+		if test -f "$TORTURE_STOPFILE"
+		then
+			echo "PID $qemu_pid killed due to run STOP request" >> $resdir/Warnings 2>&1
+			kill -KILL $qemu_pid
+			break
+		fi
 		kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 		if kill -0 $qemu_pid > /dev/null 2>&1
 		then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 7dbce7a..3578c85 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -337,6 +337,8 @@ then
 	mkdir -p "$resdir" || :
 fi
 mkdir $resdir/$ds
+TORTURE_RESDIR="$resdir/$ds"; export TORTURE_RESDIR
+TORTURE_STOPFILE="$resdir/$ds/STOP"; export TORTURE_STOPFILE
 echo Results directory: $resdir/$ds
 echo $scriptname $args
 touch $resdir/$ds/log
-- 
2.9.5

