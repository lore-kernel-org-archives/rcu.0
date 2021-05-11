Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD5C433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AA56192C
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEKXNe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0429E61939;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=Uog1S7WsBIrXCS25dIIcDb0EkZFYMMhyP3nVexwVKdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0jnAK7hDZXvaQfW4HESvTU5etQXYONLTAOkVPVU0Fag2R0WI4yObopx/Uo+6ea+0
         7KId74lCbJKTLhN6O4Zkx+C7rXW2e5713rr/4yHNZTTqPkgwSC4gZv6w/rFbekUXmQ
         fhQuHfFbJKE3Ijw50eAWjvxV/ZYzaCrPnBt1gOkkTciHW5+i1LSJV/3bRaA34cvJzY
         BB3BB78AnCII6+eaFaZLe5VrwQj22DNp6XYR8x96Cat+JIUoq6pwPLJREW5EGDj/VX
         MKdy11mHXiajGhlDNmqo4nQ2ctsuAnc7fpKbuT8lovxA+PwmaAsNp4xk703+gIGkKE
         uLZM55snjGa7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B92B5C0DEA; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/26] torture: Abstract end-of-run summary
Date:   Tue, 11 May 2021 16:12:07 -0700
Message-Id: <20210511231223.2895398-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit abstractst the end-of-run summary from kvm-again.sh, and,
while in the area, brings its format into line with that of kvm.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-again.sh     | 11 ++---
 .../rcutorture/bin/kvm-end-run-stats.sh       | 40 +++++++++++++++++++
 2 files changed, 43 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index b74bb4343ab9..d8c8483c46f1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -143,6 +143,8 @@ then
 	usage
 fi
 rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+touch "$rundir/log"
+echo $scriptname $args | tee -a "$rundir/log"
 echo $oldrun > "$rundir/re-run"
 if ! test -d "$rundir/../../bin"
 then
@@ -178,12 +180,5 @@ then
 	echo ---- Dryrun complete, directory: $rundir | tee -a "$rundir/log"
 else
 	( cd "$rundir"; sh $T/runbatches.sh )
-	kcsan-collapse.sh "$rundir" | tee -a "$rundir/log"
-	echo | tee -a "$rundir/log"
-	echo ---- Results directory: $rundir | tee -a "$rundir/log"
-	kvm-recheck.sh "$rundir" > $T/kvm-recheck.sh.out 2>&1
-	ret=$?
-	cat $T/kvm-recheck.sh.out | tee -a "$rundir/log"
-	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a "$rundir/log"
-	exit $ret
+	kvm-end-run-stats.sh "$rundir" "$starttime"
 fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
new file mode 100755
index 000000000000..e4a00779b8c6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Check the status of the specified run.
+#
+# Usage: kvm-end-run-stats.sh /path/to/run starttime
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+# scriptname=$0
+# args="$*"
+rundir="$1"
+if ! test -d "$rundir"
+then
+	echo kvm-end-run-stats.sh: Specified run directory does not exist: $rundir
+	exit 1
+fi
+
+T=${TMPDIR-/tmp}/kvm-end-run-stats.sh.$$
+trap 'rm -rf $T' 0
+mkdir $T
+
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+default_starttime="`get_starttime`"
+starttime="${2-default_starttime}"
+
+echo | tee -a "$rundir/log"
+echo | tee -a "$rundir/log"
+echo " --- `date` Test summary:" | tee -a "$rundir/log"
+echo Results directory: $rundir | tee -a "$rundir/log"
+kcsan-collapse.sh "$rundir" | tee -a "$rundir/log"
+kvm-recheck.sh "$rundir" > $T/kvm-recheck.sh.out 2>&1
+ret=$?
+cat $T/kvm-recheck.sh.out | tee -a "$rundir/log"
+echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a "$rundir/log"
+exit $ret
-- 
2.31.1.189.g2e36527f23

