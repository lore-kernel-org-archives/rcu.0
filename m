Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3B2C433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DDD64F62
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351486AbhCDBBo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452953AbhCDAj6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14A2F64F2B;
        Thu,  4 Mar 2021 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818296;
        bh=w9pB+wrg4FHKROMwMhZxKW3mYIoH604FwI7t7RmTR1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdFXd/F/PHLayVTJUSAk0XIzIgtthMTutkicnYHhqJmxqzycfBXZvL+O49BJ5oo0F
         VPLA9EXBSw6tlgNYAFIuGSLlBXNIglZ+5EcMw8j1FWVaZh6QbH/5DKUkguzsLL37dq
         A4fKrtHL9QK7S3Qw12tcc5hsZIcgSqUqeRdBmrlP5ajVJIInTiby501Ikcco2zURKR
         uUF9xrBVMn1W7tY1s0JIhFAridtclPKm0x+c7IjYo2ZT08BwJNa8lWYMIsdkiQ/1lW
         G3ogRG6bZHuaKshYxKPbJ7/x5JMSb8P3SvyOdLUPYgQoq+krASWkQnb11Ku3mEB/+O
         BEjZV6WrQnGNw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/28] torture: Record jitter start/stop commands
Date:   Wed,  3 Mar 2021 16:37:59 -0800
Message-Id: <20210304003812.24833-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Distributed runs of rcutorture will need to start and stop jittering on
the remote hosts, which means that the commands must be communicated to
those hosts.  The commit therefore causes kvm.sh to place these commands
in new TORTURE_JITTER_START and TORTURE_JITTER_STOP environment variables
to communicate them to the scripts that will set this up.  In addition,
this commit causes kvm-test-1-run.sh to append these commands to each
generated qemu-cmd file, which allows any remotely executing script to
extract the needed commands from this file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  2 ++
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 24 +++++++++++++---------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index f3d2ded..a69f8ae 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -202,6 +202,8 @@ echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_appen
 echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
 echo "# seconds=$seconds" >> $resdir/qemu-cmd
 echo "# TORTURE_KCONFIG_GDB_ARG=\"$TORTURE_KCONFIG_GDB_ARG\"" >> $resdir/qemu-cmd
+echo "# TORTURE_JITTER_START=\"$TORTURE_JITTER_START\"" >> $resdir/qemu-cmd
+echo "# TORTURE_JITTER_STOP=\"$TORTURE_JITTER_STOP\"" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index d6973e4..efcbd12 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -35,6 +35,8 @@ TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_GDB_ARG=""
 TORTURE_BOOT_GDB_ARG=""
 TORTURE_QEMU_GDB_ARG=""
+TORTURE_JITTER_START=""
+TORTURE_JITTER_STOP=""
 TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
@@ -443,6 +445,16 @@ function dump(first, pastlast, batchnum)
 	print "echo ----Start batch " batchnum ": `date` | tee -a " rd "log";
 	print "needqemurun="
 	jn=1
+	njitter = 0;
+	split(jitter, ja);
+	if (ja[1] == -1 && ncpus == 0)
+		njitter = 1;
+	else if (ja[1] == -1)
+		njitter = ncpus;
+	else
+		njitter = ja[1];
+	print "TORTURE_JITTER_START=\". jitterstart.sh " njitter " " rd " " dur " " ja[2] " " ja[3] "\"; export TORTURE_JITTER_START";
+	print "TORTURE_JITTER_STOP=\". jitterstop.sh " rd " \"; export TORTURE_JITTER_STOP"
 	for (j = first; j < pastlast; j++) {
 		cpusr[jn] = cpus[j];
 		if (cfrep[cf[j]] == "") {
@@ -484,14 +496,6 @@ function dump(first, pastlast, batchnum)
 		print "\tneedqemurun=1"
 		print "fi"
 	}
-	njitter = 0;
-	split(jitter, ja);
-	if (ja[1] == -1 && ncpus == 0)
-		njitter = 1;
-	else if (ja[1] == -1)
-		njitter = ncpus;
-	else
-		njitter = ja[1];
 	if (TORTURE_BUILDONLY && njitter != 0) {
 		njitter = 0;
 		print "echo Build-only run, so suppressing jitter | tee -a " rd "log"
@@ -502,12 +506,12 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	print "\t. jitterstart.sh " njitter " " rd " " dur " " ja[2] " " ja[3]
+	print "\t$TORTURE_JITTER_START";
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
 	print "\tdone"
-	print "\t. jitterstop.sh " rd
+	print "\t$TORTURE_JITTER_STOP";
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
 	print "\twait"
-- 
2.9.5

