Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC3C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6352312C
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbhAFRcH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbhAFRcD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C31023132;
        Wed,  6 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954281;
        bh=M9h+80bXKidob2Edx/w6S/+5UzTnKAAvGAvyBWKk5YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkT1DxwaYsHIZd9IiqZLAeQiMMWzpkCpqkDXbxI9Rh6o4HnMB3diVSgijbkL02nSJ
         hwmo++1YvlYbd8F2K4ns3i/gunx3rqTuitRzFEadMBG9OSSlpoAdPxFn3SHqBRQaB3
         gwQ4tXtFyOnpY6O+dJwYi3hB+Rl8vdHB1OSn42CXjmgWKCnfPJbqg9rvVVmmErlbrg
         nxs/aJDiHOZJXlfOL+TslYUJDuEUU+7NAmhjGT0DOPwt090CrOuXkPNTLOI79xv+s2
         gbgeKzKyAnKi3a8CTiQKwLHlZ6EsWmRQJ4grB2VLAFv3I+fHUFi5u0HwWHm7qZpKR9
         OLI48ml0aRRCA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/18] torture: Add torture.sh torture-everything script
Date:   Wed,  6 Jan 2021 09:31:03 -0800
Message-Id: <20210106173119.23159-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although tailoring a specific set of kvm.sh runs has served rcutorture
testing well over many years, it requires a relatively distraction-free
environment, which is not always available.  This commit therefore
adds a prototype torture.sh script that by default tortures pretty much
everything the rcutorture scripting is designed to torture, and which
can be given command-line arguments to take a more focused approach.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 301 ++++++++++++++++++++++
 1 file changed, 301 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/bin/torture.sh

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
new file mode 100644
index 0000000..f556cc7
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -0,0 +1,301 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run a series of torture tests, intended for overnight or
+# longer timeframes, and also for large systems.
+#
+# Usage: torture.sh [ options ]
+#
+# Copyright (C) 2020 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+scriptname=$0
+args="$*"
+
+# Default duration and apportionment.
+duration_base=10
+duration_rcutorture_frac=7
+duration_locktorture_frac=1
+duration_scftorture_frac=2
+
+# "yes" or "no" parameters
+do_rcutorture=yes
+do_locktorture=yes
+do_scftorture=yes
+do_rcuscale=yes
+do_refscale=yes
+do_kvfree=yes
+do_kasan=yes
+do_kcsan=no
+
+usage () {
+	echo "Usage: $scriptname optional arguments:"
+	echo "       --doall"
+	echo "       --do-kasan / --do-no-kasan"
+	echo "       --do-kcsan / --do-no-kcsan"
+	echo "       --do-kvfree / --do-no-kvfree"
+	echo "       --do-locktorture / --do-no-locktorture"
+	echo "       --do-none"
+	echo "       --do-rcuscale / --do-no-rcuscale"
+	echo "       --do-rcutorture / --do-no-rcutorture"
+	echo "       --do-refscale / --do-no-refscale"
+	echo "       --do-scftorture / --do-no-scftorture"
+	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
+	exit 1
+}
+
+while test $# -gt 0
+do
+	case "$1" in
+	--doall)
+		do_rcutorture=yes
+		do_locktorture=yes
+		do_scftorture=yes
+		do_rcuscale=yes
+		do_refscale=yes
+		do_kvfree=yes
+		do_kasan=yes
+		do_kcsan=yes
+		;;
+	--do-kasan|--do-no-kasan)
+		if test "$1" = --do-kasan
+		then
+			do_kasan=yes
+		else
+			do_kasan=no
+		fi
+		;;
+	--do-kcsan|--do-no-kcsan)
+		if test "$1" = --do-kcsan
+		then
+			do_kcsan=yes
+		else
+			do_kcsan=no
+		fi
+		;;
+	--do-kvfree|--do-no-kvfree)
+		if test "$1" = --do-kvfree
+		then
+			do_kvfree=yes
+		else
+			do_kvfree=no
+		fi
+		;;
+	--do-locktorture|--do-no-locktorture)
+		if test "$1" = --do-locktorture
+		then
+			do_locktorture=yes
+		else
+			do_locktorture=no
+		fi
+		;;
+	--do-none)
+		do_rcutorture=no
+		do_locktorture=no
+		do_scftorture=no
+		do_rcuscale=no
+		do_refscale=no
+		do_kvfree=no
+		do_kasan=no
+		do_kcsan=no
+		;;
+	--do-rcuscale|--do-no-rcuscale)
+		if test "$1" = --do-rcuscale
+		then
+			do_rcuscale=yes
+		else
+			do_rcuscale=no
+		fi
+		;;
+	--do-rcutorture|--do-no-rcutorture)
+		if test "$1" = --do-rcutorture
+		then
+			do_rcutorture=yes
+		else
+			do_rcutorture=no
+		fi
+		;;
+	--do-refscale|--do-no-refscale)
+		if test "$1" = --do-refscale
+		then
+			do_refscale=yes
+		else
+			do_refscale=no
+		fi
+		;;
+	--do-scftorture|--do-no-scftorture)
+		if test "$1" = --do-scftorture
+		then
+			do_scftorture=yes
+		else
+			do_scftorture=no
+		fi
+		;;
+	--duration)
+		# checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
+		mult=60
+		if echo "$2" | grep -q 's$'
+		then
+			mult=1
+		elif echo "$2" | grep -q 'h$'
+		then
+			mult=3600
+		elif echo "$2" | grep -q 'd$'
+		then
+			mult=86400
+		fi
+		ts=`echo $2 | sed -e 's/[smhd]$//'`
+		duration_base=$(($ts*mult))
+		shift
+		;;
+	*)
+		echo Unknown argument $1
+		usage
+		;;
+	esac
+	shift
+done
+
+duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
+# Need to sum remaining weights, and if duration weights to zero,
+# set do_no_rcutorture. @@@
+duration_locktorture=$((duration_base*duration_locktorture_frac/10))
+duration_scftorture=$((duration_base*duration_scftorture_frac/10))
+
+T=/tmp/torture.sh.$$
+trap 'rm -rf $T' 0 2
+mkdir $T
+
+touch $T/failures
+touch $T/successes
+
+ds="`date +%Y.%m.%d-%H.%M.%S`-torture"
+startdate="`date`"
+starttime="`awk 'BEGIN { print systime() }' < /dev/null`"
+
+# tortureme flavor command
+# Note that "flavor" is an arbitrary string.  Supply --torture if needed.
+function torture_one {
+	echo " --- $curflavor:" Start `date` | tee -a $T/log
+	eval $* --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
+	retcode=$?
+	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
+	if test -n "$resdir"
+	then
+		cp $T/$curflavor.out $resdir/log.long
+		echo retcode=$retcode >> $resdir/log.long
+	else
+		cat $T/$curflavor.out | tee -a $T/log
+		echo retcode=$retcode | tee -a $T/log
+	fi
+	if test "$retcode" == 0
+	then
+		echo "$curflavor($retcode)" $resdir >> $T/successes
+	else
+		echo "$curflavor($retcode)" $resdir >> $T/failures
+	fi
+}
+
+function torture_set {
+	local flavor=$1
+	shift
+	curflavor=$flavor
+	torture_one $*
+	if test "$do_kasan" = "yes"
+	then
+		curflavor=${flavor}-kasan
+		torture_one $* --kasan
+	fi
+	if test "$do_kcsan" = "yes"
+	then
+		curflavor=${flavor}-kcsan
+		torture_one $* --kconfig '"CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"' --kmake-arg "CC=clang" --kcsan
+	fi
+}
+
+if test "$do_rcutorture" = "yes"
+then
+	torture_set "rcutorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration '"$duration_rcutorture"' --configs "TREE10 4*CFLIST" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000" --trust-make'
+fi
+
+if test "$do_locktorture" = "yes"
+then
+	torture_set "locktorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration '"$duration_locktorture"' --configs "14*CFLIST" --bootargs "torture.disable_onoff_at_boot" --trust-make'
+fi
+
+if test "$do_scftorture" = "yes"
+then
+	torture_set "scftorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration '"$duration_scftorture"' --kconfig "CONFIG_NR_CPUS=224" --bootargs "scftorture.nthreads=224 torture.disable_onoff_at_boot" --trust-make'
+fi
+
+if test "$do_refscale" = yes
+then
+	primlist="`grep '\.name[ 	]*=' kernel/rcu/refscale*.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
+else
+	primlist=
+fi
+for prim in $primlist
+do
+	torture_set "refscale-$prim" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --bootargs "refscale.scale_type='"$prim"' refscale.nreaders=224 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make'
+done
+
+if test "$do_rcuscale" = yes
+then
+	primlist="`grep '\.name[ 	]*=' kernel/rcu/rcuscale*.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
+else
+	primlist=
+fi
+for prim in $primlist
+do
+	torture_set "rcuscale-$prim" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --bootargs "rcuscale.scale_type='"$prim"' rcuscale.nwriters=224 rcuscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make'
+done
+
+if test "$do_kvfree" = "yes"
+then
+	torture_set "rcuscale-kvfree" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=224" --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make'
+fi
+
+echo " --- " $scriptname $args
+echo " --- " Done `date` | tee -a $T/log
+ret=0
+nsuccesses=0
+echo SUCCESSES: | tee -a $T/log
+if test -s "$T/successes"
+then
+	cat "$T/successes" | tee -a $T/log
+	nsuccesses="`wc -l "$T/successes" | awk '{ print $1 }'`"
+fi
+nfailures=0
+echo FAILURES: | tee -a $T/log
+if test -s "$T/failures"
+then
+	cat "$T/failures" | tee -a $T/log
+	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
+	ret=2
+fi
+duration="`awk -v starttime=$starttime '
+BEGIN {
+	s = systime() - starttime; 
+	h = s / 3600;
+	d = h /24;
+	if (d < 1)
+		print h " hours";
+	else
+		print d " days (" h " hours)";
+}' < /dev/null`"
+echo Started at $startdate, ended at `date`, duration $duration. | tee -a $T/log
+echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
+tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
+if test -n "$tdir"
+then
+	cp $T/log $tdir
+fi
+exit $ret
+
+# RCU CPU stall warnings?
+# scftorture warnings?
+# Need a way for the invoker to specify clang.
+# Work out --configs based on number of available CPUs?
+# Need a way to specify --configs.  --configs--rcutorture?
+# Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
-- 
2.9.5

