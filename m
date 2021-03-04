Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C365C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF8264F18
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbhCDBBg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452924AbhCDAjh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A2BA64E60;
        Thu,  4 Mar 2021 00:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818294;
        bh=J2KMfxZO5DQzJDG5W0hH05KLjhwBL0PXWzZdtf1orMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMXHyegzuK4OMeGL47zoatynas7JAdDe+nq/uYCR3yf/gespdOhcE6Pq/EUFq0pKe
         XC11++DWn3NXAVsXTGRxFNx3ZFEJ4J2WFRuZ3geFth0B/MeN7VHxu5DVPiSTLptQMY
         mt5ZWRpMfYOahWwJ3ZpvLHSh6j3w3iJmfmDaw2EDT9ZPhSu7aRyciplhejyWB82Jcj
         W7svtP1PYbyrT8yOlU1ZQp00zkEqG1BhEtzb+2wvwJsXbQpPRSW4akUCuW37z/cqDv
         xikY6itjf6U2Sg1vALgtwE0TW8HWB+TKo0w+asamUf6k8el0UzwAS0jkVa1/a1rfHI
         wKbzm/9ntRbAQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/28] torture: Move build/run synchronization files into scenario directories
Date:   Wed,  3 Mar 2021 16:37:51 -0800
Message-Id: <20210304003812.24833-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently the bN.ready and bN.wait files are placed in the
rcutorture directory, which really is not at all a good place
for run-specific files.  This commit therefore renames these
files to build.ready and build.wait and then moves them into the
scenario directories within the "res" directory, for example, into
tools/testing/selftests/rcutorture/res/2021.02.10-15.08.23/TINY01.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     | 25 +++++++++++-----------
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 10 ++++-----
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 03c0410..91578d3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -7,7 +7,7 @@
 # Execute this in the source tree.  Do not run it as a background task
 # because qemu does not seem to like that much.
 #
-# Usage: kvm-test-1-run.sh config builddir resdir seconds qemu-args boot_args_in
+# Usage: kvm-test-1-run.sh config resdir seconds qemu-args boot_args_in
 #
 # qemu-args defaults to "-enable-kvm -nographic", along with arguments
 #			specifying the number of CPUs and other options
@@ -35,8 +35,7 @@ mkdir $T
 config_template=${1}
 config_dir=`echo $config_template | sed -e 's,/[^/]*$,,'`
 title=`echo $config_template | sed -e 's/^.*\///'`
-builddir=${2}
-resdir=${3}
+resdir=${2}
 if test -z "$resdir" -o ! -d "$resdir" -o ! -w "$resdir"
 then
 	echo "kvm-test-1-run.sh :$resdir: Not a writable directory, cannot store results into it"
@@ -89,9 +88,9 @@ then
 	ln -s $base_resdir/Make*.out $resdir  # for kvm-recheck.sh
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	echo Initial build failed, not running KVM, see $resdir.
-	if test -f $builddir.wait
+	if test -f $resdir/build.wait
 	then
-		mv $builddir.wait $builddir.ready
+		mv $resdir/build.wait $resdir/build.ready
 	fi
 	exit 1
 elif kvm-build.sh $T/KcList $resdir
@@ -118,23 +117,23 @@ else
 	# Build failed.
 	cp .config $resdir || :
 	echo Build failed, not running KVM, see $resdir.
-	if test -f $builddir.wait
+	if test -f $resdir/build.wait
 	then
-		mv $builddir.wait $builddir.ready
+		mv $resdir/build.wait $resdir/build.ready
 	fi
 	exit 1
 fi
-if test -f $builddir.wait
+if test -f $resdir/build.wait
 then
-	mv $builddir.wait $builddir.ready
+	mv $resdir/build.wait $resdir/build.ready
 fi
-while test -f $builddir.ready
+while test -f $resdir/build.ready
 do
 	sleep 1
 done
-seconds=$4
-qemu_args=$5
-boot_args_in=$6
+seconds=$3
+qemu_args=$4
+boot_args_in=$5
 
 if test -z "$TORTURE_BUILDONLY"
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 1de198d..7944510 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -444,7 +444,6 @@ function dump(first, pastlast, batchnum)
 	print "needqemurun="
 	jn=1
 	for (j = first; j < pastlast; j++) {
-		builddir=KVM "/b" j - first + 1
 		cpusr[jn] = cpus[j];
 		if (cfrep[cf[j]] == "") {
 			cfr[jn] = cf[j];
@@ -453,15 +452,15 @@ function dump(first, pastlast, batchnum)
 			cfrep[cf[j]]++;
 			cfr[jn] = cf[j] "." cfrep[cf[j]];
 		}
+		builddir=rd cfr[jn] "/build";
 		if (cpusr[jn] > ncpus && ncpus != 0)
 			ovf = "-ovf";
 		else
 			ovf = "";
 		print "echo ", cfr[jn], cpusr[jn] ovf ": Starting build. `date` | tee -a " rd "log";
-		print "rm -f " builddir ".*";
-		print "touch " builddir ".wait";
 		print "mkdir " rd cfr[jn] " || :";
-		print "kvm-test-1-run.sh " CONFIGDIR cf[j], builddir, rd cfr[jn], dur " \"" TORTURE_QEMU_ARG "\" \"" TORTURE_BOOTARGS "\" > " rd cfr[jn]  "/kvm-test-1-run.sh.out 2>&1 &"
+		print "touch " builddir ".wait";
+		print "kvm-test-1-run.sh " CONFIGDIR cf[j], rd cfr[jn], dur " \"" TORTURE_QEMU_ARG "\" \"" TORTURE_BOOTARGS "\" > " rd cfr[jn]  "/kvm-test-1-run.sh.out 2>&1 &"
 		print "echo ", cfr[jn], cpusr[jn] ovf ": Waiting for build to complete. `date` | tee -a " rd "log";
 		print "while test -f " builddir ".wait"
 		print "do"
@@ -471,7 +470,7 @@ function dump(first, pastlast, batchnum)
 		jn++;
 	}
 	for (j = 1; j < jn; j++) {
-		builddir=KVM "/b" j
+		builddir=rd cfr[j] "/build";
 		print "rm -f " builddir ".ready"
 		print "if test -f \"" rd cfr[j] "/builtkernel\""
 		print "then"
@@ -509,7 +508,6 @@ function dump(first, pastlast, batchnum)
 	print "\techo ---- No kernel runs. `date` | tee -a " rd "log";
 	print "fi"
 	for (j = 1; j < jn; j++) {
-		builddir=KVM "/b" j
 		print "echo ----", cfr[j], cpusr[j] ovf ": Build/run results: | tee -a " rd "log";
 		print "cat " rd cfr[j]  "/kvm-test-1-run.sh.out | tee -a " rd "log";
 	}
-- 
2.9.5

