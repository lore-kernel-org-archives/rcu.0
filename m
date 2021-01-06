Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12871C433E9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D610F23125
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbhAFRcD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbhAFRcC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B1C223137;
        Wed,  6 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954281;
        bh=SmkaDM3xbNdVZK12ictQ5JKki4fweM8zuSPxIgEGJ0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XieAKe8dNPUXhzdWJ9tFrLreBr2roAY8kn/vC2n8Cx+5kCNXIoJWUEv0E28BQTU1f
         8j8f9cQSB/W6y8jz96gqCjYCI+toejZz8J5/uP2keQHYDubqHew1WSo6cBAgJntbLB
         rkZxxizmouVbIjV+Jz25Fq4WgYCY3vBYQVSIm7RoW6sPAiurps7eFlRbNhIx2lED4D
         EnpJmTj3ytGNoF0fN9o14ljjY67PpECxZGiq7cWR873U5Xt3ZHMvla06AcnDF7I2Np
         SmU0zsYbVgrCrLkvf3VodToo2S8brJwEzVvr1mlA0G43Vo6kBt8Sf1h9dVFfFV1MFr
         KsNQtMDC1yKCA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/18] torture: Remove use of "eval" in torture.sh
Date:   Wed,  6 Jan 2021 09:31:05 -0800
Message-Id: <20210106173119.23159-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The bash "eval" command enables Bobby Tables attacks, which might not
be a concern in torture testing by themselves, but one could imagine
these combined with a cut-and-paste attack.  This commit therefore gets
rid of them.  This comes at a price in terms of bash quoting not working
nicely, so the "--bootargs" argument lists are now passed to torture_one
via a bash-variable side channel.  This might be a bit ugly, but it will
also allow torture.sh to grow its own --bootargs parameter.

While in the area, add proper header comments for the bash functions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 55 ++++++++++++++++++-----
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 1657404..0bd8e84 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -178,11 +178,26 @@ ds="`date +%Y.%m.%d-%H.%M.%S`-torture"
 startdate="`date`"
 starttime="`get_starttime`"
 
-# tortureme flavor command
+# torture_one - Does a single kvm.sh run.
+#
+# Usage:
+#	torture_bootargs="[ kernel boot arguments ]"
+#	torture_one flavor [ kvm.sh arguments ]
+#
 # Note that "flavor" is an arbitrary string.  Supply --torture if needed.
+# Note that quoting is problematic.  So on the command line, pass multiple
+# values with multiple kvm.sh argument instances.
 function torture_one {
+	local cur_bootargs=
+	local boottag=
+
 	echo " --- $curflavor:" Start `date` | tee -a $T/log
-	eval $* --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
+	if test -n "$torture_bootargs"
+	then
+		boottag="--bootargs"
+		cur_bootargs="$torture_bootargs"
+	fi
+	"$@" $boottag "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
 	retcode=$?
 	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
 	if test -n "$resdir"
@@ -201,36 +216,48 @@ function torture_one {
 	fi
 }
 
+# torture_set - Does a set of tortures with and without KASAN and KCSAN.
+#
+# Usage:
+#	torture_bootargs="[ kernel boot arguments ]"
+#	torture_set flavor [ kvm.sh arguments ]
+#
+# Note that "flavor" is an arbitrary string.  Supply --torture if needed.
+# Note that quoting is problematic.  So on the command line, pass multiple
+# values with multiple kvm.sh argument instances.
 function torture_set {
 	local flavor=$1
 	shift
 	curflavor=$flavor
-	torture_one $*
+	torture_one "$@"
 	if test "$do_kasan" = "yes"
 	then
 		curflavor=${flavor}-kasan
-		torture_one $* --kasan
+		torture_one "$@" --kasan
 	fi
 	if test "$do_kcsan" = "yes"
 	then
 		curflavor=${flavor}-kcsan
-		torture_one $* --kconfig '"CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"' --kmake-arg "CC=clang" --kcsan
+		torture_one $* --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --kmake-arg "CC=clang" --kcsan
 	fi
 }
 
 if test "$do_rcutorture" = "yes"
 then
-	torture_set "rcutorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration '"$duration_rcutorture"' --configs "TREE10 4*CFLIST" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000" --trust-make'
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE10 4*CFLIST" --trust-make
 fi
 
 if test "$do_locktorture" = "yes"
 then
-	torture_set "locktorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration '"$duration_locktorture"' --configs "14*CFLIST" --bootargs "torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="torture.disable_onoff_at_boot"
+	torture_set "locktorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration "$duration_locktorture" --configs "14*CFLIST" --trust-make
 fi
 
 if test "$do_scftorture" = "yes"
 then
-	torture_set "scftorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration '"$duration_scftorture"' --kconfig "CONFIG_NR_CPUS=224" --bootargs "scftorture.nthreads=224 torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="scftorture.nthreads=224 torture.disable_onoff_at_boot"
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --kconfig "CONFIG_NR_CPUS=224" --trust-make
 fi
 
 if test "$do_refscale" = yes
@@ -241,7 +268,8 @@ else
 fi
 for prim in $primlist
 do
-	torture_set "refscale-$prim" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --bootargs "refscale.scale_type='"$prim"' refscale.nreaders=224 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=224 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --trust-make
 done
 
 if test "$do_rcuscale" = yes
@@ -252,12 +280,14 @@ else
 fi
 for prim in $primlist
 do
-	torture_set "rcuscale-$prim" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --bootargs "rcuscale.scale_type='"$prim"' rcuscale.nwriters=224 rcuscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=224 rcuscale.holdoff=20 torture.disable_onoff_at_boot"
+	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --trust-make
 done
 
 if test "$do_kvfree" = "yes"
 then
-	torture_set "rcuscale-kvfree" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=224" --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
+	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=224" --trust-make
 fi
 
 echo " --- " $scriptname $args
@@ -293,3 +323,6 @@ exit $ret
 # Need a way for the invoker to specify clang.
 # Work out --configs based on number of available CPUs?
 # Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
+# --kconfig as with --bootargs (Both have overrides.)
+# Command line parameters for --bootargs, --config, --kconfig, --kmake-arg, and --qemu-arg
+# Ensure that build failures count as failures
-- 
2.9.5

