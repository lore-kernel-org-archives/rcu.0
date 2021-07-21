Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C955C6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A206124C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGUUVR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9F7061370;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=RdAL1UJ/R+LAq6pmS9aqielVwWYgDIKANDlmflWnGsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LwRfv0/l4LHyO1DcD6AXu30JhmBMRrs6bu/qj7Tgd6hNiRBzIMxORWHQzhx9n6Lig
         mO58qC9vXzK6/8kqhlJwXJPc8zE8L8O8Ff33FLC5WQwXWmgv0K4hPxNB2BIgIE1g98
         RPYNgSe8EhDPvmWXTbnjC011PreAvduZNjdZ6g/NxnvbSgsqvD7OgXHnbefZYlu+2r
         +8kkHX2SODzd8IF2l8zVkSP6iZXTfpKfEcP/TyKLE0GXOMwT/fp7/kclm6j+hlwVsm
         0PHSmwGr1bREuluZrr6TjxJRq6x4zGDmDkxxl4lfBPSjV6h7yRKB9VpixNEeulafUG
         VxP1dnc1885FQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E819B5C2315; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 17/21] torture: Consistently name "qemu*" test output files
Date:   Wed, 21 Jul 2021 14:01:36 -0700
Message-Id: <20210721210140.787717-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There is "qemu-affinity", "qemu-cmd", "qemu-retval", but also "qemu_pid".
This is hard to remember, not so good for bash tab completion, and just
plain inconsistent.  This commit therefore renames the "qemu_pid" file to
"qemu-pid".  A couple of the scripts must deal with old runs, and thus
must handle both "qemu_pid" and "qemu-pid", but new runs will produce
"qemu-pid".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-again.sh        |  2 +-
 .../selftests/rcutorture/bin/kvm-remote.sh       |  2 +-
 .../rcutorture/bin/kvm-test-1-run-qemu.sh        | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index d8c8483c46f13..b7b8d6856d7ec 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -142,7 +142,7 @@ then
 	echo "Cannot copy from $oldrun to $rundir."
 	usage
 fi
-rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
 touch "$rundir/log"
 echo $scriptname $args | tee -a "$rundir/log"
 echo $oldrun > "$rundir/re-run"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index f52641fdd1fe7..19cadb1b2f2d3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -254,7 +254,7 @@ do
 		sleep 30
 	done
 	echo " ---" Collecting results from $i `date`
-	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu_pid */qemu-retval; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
+	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
 done
 
 ( kvm-end-run-stats.sh "$oldrun" "$starttime"; echo $? > $T/exitcode ) | tee -a "$oldrun/remote-log"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index b9a0bb6f01154..d828a34b5b89f 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -47,7 +47,7 @@ then
 fi
 sed -e 's/^[^#].*$/'"$taskset_command"'& 2>\&1 \&/' < $resdir/qemu-cmd > $T/qemu-cmd
 echo 'qemu_pid=$!' >> $T/qemu-cmd
-echo 'echo $qemu_pid > $resdir/qemu_pid' >> $T/qemu-cmd
+echo 'echo $qemu_pid > $resdir/qemu-pid' >> $T/qemu-cmd
 echo 'taskset -c -p $qemu_pid > $resdir/qemu-affinity' >> $T/qemu-cmd
 
 # In case qemu refuses to run...
@@ -55,14 +55,14 @@ echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
 
 # Attempt to run qemu
 kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
-( . $T/qemu-cmd; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
+( . $T/qemu-cmd; wait `cat  $resdir/qemu-pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
 if test -z "$TORTURE_KCONFIG_GDB_ARG"
 then
 	sleep 10 # Give qemu's pid a chance to reach the file
-	if test -s "$resdir/qemu_pid"
+	if test -s "$resdir/qemu-pid"
 	then
-		qemu_pid=`cat "$resdir/qemu_pid"`
+		qemu_pid=`cat "$resdir/qemu-pid"`
 		echo Monitoring qemu job at pid $qemu_pid
 	else
 		qemu_pid=""
@@ -89,9 +89,9 @@ then
 fi
 while :
 do
-	if test -z "$qemu_pid" -a -s "$resdir/qemu_pid"
+	if test -z "$qemu_pid" -a -s "$resdir/qemu-pid"
 	then
-		qemu_pid=`cat "$resdir/qemu_pid"`
+		qemu_pid=`cat "$resdir/qemu-pid"`
 	fi
 	kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 	if test -z "$qemu_pid" || kill -0 "$qemu_pid" > /dev/null 2>&1
@@ -122,9 +122,9 @@ do
 		break
 	fi
 done
-if test -z "$qemu_pid" -a -s "$resdir/qemu_pid"
+if test -z "$qemu_pid" -a -s "$resdir/qemu-pid"
 then
-	qemu_pid=`cat "$resdir/qemu_pid"`
+	qemu_pid=`cat "$resdir/qemu-pid"`
 fi
 if test $commandcompleted -eq 0 -a -n "$qemu_pid"
 then
-- 
2.31.1.189.g2e36527f23

