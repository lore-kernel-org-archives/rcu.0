Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35A2C6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBDF6124C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGUUVS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAA5E61375;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=2ypAAf1//UhTVaprCt661gjp0uOoM61nRDgGX5MymnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIt9nlKuGjnZQKZy02GFCYcLZ0Sh16YyhUpk9Gi48LZnlXTYj2e6PRZPgmR7hDIvs
         kr5YEi6IMVY+KcUDNDhlpnMJUf2zPz7gJ/XwB+nZNIjl1xUx5OTOxj778xybM8bwWA
         EXTMTjeOWR3RtH+cQOlD2Wi8zbdYU6xxMqnJ0T8ofXTxFVZkf8ldGL0+VKH5KoN1kB
         Dlhz+2WBGKX0zs3xbw9cd9uxM7no2xoSeiSyTelPCTYB97zJwXDYF/BuNm+qN8XDhh
         2GxiuCZwCrwvlJZv0y8Bf1yajuCjci2265vv2Xj/LW6KsNfUF1knT6OrfiY4nzHQ72
         vuraLIxim63CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA04E5C23AA; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 18/21] torture: Make kvm-test-1-run-batch.sh select per-scenario affinity masks
Date:   Wed, 21 Jul 2021 14:01:37 -0700
Message-Id: <20210721210140.787717-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit causes kvm-test-1-run-batch.sh to use the new
kvm-assign-cpus.sh and kvm-get-cpus-script.sh scripts to create a
TORTURE_AFFINITY environment variable containing either an empty string
(for no affinity) or a list of CPUs to pin the scenario's vCPUs to.
The additional change to kvm-test-1-run.sh places the per-scenario
number-of-CPUs information where it can easily be found.

If there is some reason why affinity cannot be supplied, this commit
prints and logs the reason via changes to kvm-again.sh.

Finally, this commit updates the kvm-remote.sh script to copy the
qemu-affinity output files back to the host system.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-again.sh     |  2 +-
 .../selftests/rcutorture/bin/kvm-remote.sh    |  2 +-
 .../rcutorture/bin/kvm-test-1-run-batch.sh    | 23 +++++++++++++++++++
 .../rcutorture/bin/kvm-test-1-run.sh          |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index b7b8d6856d7ec..5a0023d183dac 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -179,6 +179,6 @@ if test -n "$dryrun"
 then
 	echo ---- Dryrun complete, directory: $rundir | tee -a "$rundir/log"
 else
-	( cd "$rundir"; sh $T/runbatches.sh )
+	( cd "$rundir"; sh $T/runbatches.sh ) | tee -a "$rundir/log"
 	kvm-end-run-stats.sh "$rundir" "$starttime"
 fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 19cadb1b2f2d3..03126eb6ec5ae 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -254,7 +254,7 @@ do
 		sleep 30
 	done
 	echo " ---" Collecting results from $i `date`
-	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
+	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval */qemu-affinity; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
 done
 
 ( kvm-end-run-stats.sh "$oldrun" "$starttime"; echo $? > $T/exitcode ) | tee -a "$oldrun/remote-log"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
index 005a048c55aa0..1e29d656501bc 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
@@ -50,11 +50,34 @@ grep '^#' $1/qemu-cmd | sed -e 's/^# //' > $T/qemu-cmd-settings
 echo ---- System running test: `uname -a`
 echo ---- Starting kernels. `date` | tee -a log
 $TORTURE_JITTER_START
+kvm-assign-cpus.sh /sys/devices/system/node > $T/cpuarray.awk
 for i in "$@"
 do
 	echo ---- System running test: `uname -a` > $i/kvm-test-1-run-qemu.sh.out
 	echo > $i/kvm-test-1-run-qemu.sh.out
 	export TORTURE_AFFINITY=
+	kvm-get-cpus-script.sh $T/cpuarray.awk $T/cpubatches.awk $T/cpustate
+	cat << '	___EOF___' >> $T/cpubatches.awk
+	END {
+		affinitylist = "";
+		if (!gotcpus()) {
+			print "echo No CPU-affinity information, so no taskset command.";
+		} else if (cpu_count !~ /^[0-9][0-9]*$/) {
+			print "echo " scenario ": Bogus number of CPUs (old qemu-cmd?), so no taskset command.";
+		} else {
+			affinitylist = nextcpus(cpu_count);
+			if (!(affinitylist ~ /^[0-9,-][0-9,-]*$/))
+				print "echo " scenario ": Bogus CPU-affinity information, so no taskset command.";
+			else if (!dumpcpustate())
+				print "echo " scenario ": Could not dump state, so no taskset command.";
+			else
+				print "export TORTURE_AFFINITY=" affinitylist;
+		}
+	}
+	___EOF___
+	cpu_count="`grep '# TORTURE_CPU_COUNT=' $i/qemu-cmd | sed -e 's/^.*=//'`"
+	affinity_export="`awk -f $T/cpubatches.awk -v cpu_count="$cpu_count" -v scenario=$i < /dev/null`"
+	$affinity_export
 	kvm-test-1-run-qemu.sh $i >> $i/kvm-test-1-run-qemu.sh.out 2>&1 &
 done
 for i in $runfiles
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index f10f426f50893..f4c8055dbf7ad 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -205,6 +205,7 @@ echo "# TORTURE_KCONFIG_GDB_ARG=\"$TORTURE_KCONFIG_GDB_ARG\"" >> $resdir/qemu-cm
 echo "# TORTURE_JITTER_START=\"$TORTURE_JITTER_START\"" >> $resdir/qemu-cmd
 echo "# TORTURE_JITTER_STOP=\"$TORTURE_JITTER_STOP\"" >> $resdir/qemu-cmd
 echo "# TORTURE_TRUST_MAKE=\"$TORTURE_TRUST_MAKE\"; export TORTURE_TRUST_MAKE" >> $resdir/qemu-cmd
+echo "# TORTURE_CPU_COUNT=$cpu_count" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
-- 
2.31.1.189.g2e36527f23

