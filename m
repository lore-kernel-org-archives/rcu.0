Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11913342F;
	Fri, 16 Aug 2024 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787641; cv=none; b=ROZd7V6wYXbXAIZqRBcBjS6Zt5XZjs1EPX/kJ/58OHAIw+kQSWFEB8sYAaRg8lmCJsnfnWVCArgQe2+3Q/bGnsaE6lbWB9lN+6PeTiLvu1rs/TxbSSquY7cvD+KvYD58/I1PO8kLUnBZT5tLb1yHnlZss8ekQPxFLYo/8UtQFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787641; c=relaxed/simple;
	bh=eeppvtbDpSkgUcv30kPmrHzbBpLaPSX80LuOauxDDFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTA55OeYL4XVq6RB8c+EBtGce/3ji1CduRGh9uEHlCT7nA4XDpCJ3QSf+LyfmTlgjKVHsMlf0GtnAoJFLEWkhBkOBnwyjSDBFpdnwkkki4Eq7A2EBXQ4JEQKLK8t50dd/KgHUAmP3HY47jvniTZPsrbBIn+wl/IPVvg67C4K2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeiMxHtS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeiMxHtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CCC4AF0B;
	Fri, 16 Aug 2024 05:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787641;
	bh=eeppvtbDpSkgUcv30kPmrHzbBpLaPSX80LuOauxDDFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeiMxHtS39MOWPc+4Mylgh6YtVVzlrSYTKn84GAt/OC1j3Zb+XbU8SfxAQMQTtyc+
	 AfXUy8ASBrx7pmqqGSj4Q4sm3Cn7gypHfus2Lv66VxfUdLUQSJJV2Z0/NLul4eHMSV
	 CYdTV90sBcnXBT3MeYiVlD9Sgly569kahaNFG9koZmINKFkc/xR3N4NVp9ZgD9Y+Q6
	 t28BCzHqI+jq02jjmnjYhm+aYyNX1M9jUp/AH7a/Q7NF7qrlwDpAgy5frX8fFS/afZ
	 p4sDMW7KzqHkL+WF2b0rK7E1AOy+pQi9HtyVsee8KVEo7oMK5IcoUUswLzicVq65pd
	 6jkUMMJh2PArw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 8/8] torture: Add torture.sh --guest-cpu-limit argument for limited hosts
Date: Fri, 16 Aug 2024 11:22:03 +0530
Message-Id: <20240816055203.43784-9-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
References: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Some servers have limitations on the number of CPUs a given guest OS
can use.  In my earlier experience, such limitations have been at least
half of the host's CPUs, but in a recent example, this limit is less
than 40%.  This commit therefore adds a --guest-cpu-limit argument that
allows such low limits to be made known to torture.sh.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 990d24696fd3..0447c4a00cc4 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -19,10 +19,10 @@ PATH=${RCUTORTURE}/bin:$PATH; export PATH
 
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 MAKE_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS*2))
-HALF_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS/2))
-if test "$HALF_ALLOTED_CPUS" -lt 1
+SCALE_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS/2))
+if test "$SCALE_ALLOTED_CPUS" -lt 1
 then
-	HALF_ALLOTED_CPUS=1
+	SCALE_ALLOTED_CPUS=1
 fi
 VERBOSE_BATCH_CPUS=$((TORTURE_ALLOTED_CPUS/16))
 if test "$VERBOSE_BATCH_CPUS" -lt 2
@@ -90,6 +90,7 @@ usage () {
 	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
 	echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-srcu-lockdep"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
+	echo "       --guest-cpu-limit N"
 	echo "       --kcsan-kmake-arg kernel-make-arguments"
 	exit 1
 }
@@ -203,6 +204,21 @@ do
 		duration_base=$(($ts*mult))
 		shift
 		;;
+	--guest-cpu-limit|--guest-cpu-lim)
+		checkarg --guest-cpu-limit "(number)" "$#" "$2" '^[0-9]*$' '^--'
+		if (("$2" <= "$TORTURE_ALLOTED_CPUS" / 2))
+		then
+			SCALE_ALLOTED_CPUS="$2"
+			VERBOSE_BATCH_CPUS="$((SCALE_ALLOTED_CPUS/8))"
+			if (("$VERBOSE_BATCH_CPUS" < 2))
+			then
+				VERBOSE_BATCH_CPUS=0
+			fi
+		else
+			echo "Ignoring value of $2 for --guest-cpu-limit which is greater than (("$TORTURE_ALLOTED_CPUS" / 2))."
+		fi
+		shift
+		;;
 	--kcsan-kmake-arg|--kcsan-kmake-args)
 		checkarg --kcsan-kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
 		kcsan_kmake_args="`echo "$kcsan_kmake_args $2" | sed -e 's/^ *//' -e 's/ *$//'`"
@@ -425,9 +441,9 @@ fi
 if test "$do_scftorture" = "yes"
 then
 	# Scale memory based on the number of CPUs.
-	scfmem=$((3+HALF_ALLOTED_CPUS/16))
-	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot csdlock_debug=1"
-	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory ${scfmem}G --trust-make
+	scfmem=$((3+SCALE_ALLOTED_CPUS/16))
+	torture_bootargs="scftorture.nthreads=$SCALE_ALLOTED_CPUS torture.disable_onoff_at_boot csdlock_debug=1"
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$SCALE_ALLOTED_CPUS" --memory ${scfmem}G --trust-make
 fi
 
 if test "$do_rt" = "yes"
@@ -471,8 +487,8 @@ for prim in $primlist
 do
 	if test -n "$firsttime"
 	then
-		torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-		torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "refscale.verbose_batched=$VERBOSE_BATCH_CPUS torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=$VERBOSE_BATCH_CPUS" --trust-make
+		torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$SCALE_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
+		torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$SCALE_ALLOTED_CPUS" --bootargs "refscale.verbose_batched=$VERBOSE_BATCH_CPUS torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=$VERBOSE_BATCH_CPUS" --trust-make
 		mv $T/last-resdir-nodebug $T/first-resdir-nodebug || :
 		if test -f "$T/last-resdir-kasan"
 		then
@@ -520,8 +536,8 @@ for prim in $primlist
 do
 	if test -n "$firsttime"
 	then
-		torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=$HALF_ALLOTED_CPUS rcuscale.holdoff=20 torture.disable_onoff_at_boot"
-		torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+		torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=$SCALE_ALLOTED_CPUS rcuscale.holdoff=20 torture.disable_onoff_at_boot"
+		torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$SCALE_ALLOTED_CPUS" --trust-make
 		mv $T/last-resdir-nodebug $T/first-resdir-nodebug || :
 		if test -f "$T/last-resdir-kasan"
 		then
@@ -559,7 +575,7 @@ do_kcsan="$do_kcsan_save"
 if test "$do_kvfree" = "yes"
 then
 	torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration $duration_rcutorture --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 2G --trust-make
+	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration $duration_rcutorture --kconfig "CONFIG_NR_CPUS=$SCALE_ALLOTED_CPUS" --memory 2G --trust-make
 fi
 
 if test "$do_clocksourcewd" = "yes"
-- 
2.40.1

