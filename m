Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313A282FD;
	Fri,  2 Aug 2024 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559073; cv=none; b=oVrLde2rg23so9OITRWJQirxUZRWbKXq9L+1cGKm1wpO1Dv1Ca1Ois+1cJWlHIwadj7J3nnmaGHwVt6dWHU+B4pyJdQ1n2QPWKA2uQYAH9dn1Ee9AdwvGA78TgYzYs7DTzdKSi3QT5k7R5hH0xojM8dYaKu2BkIi0Qleaf5xBTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559073; c=relaxed/simple;
	bh=ORPsIKilCO2aukBgqnmuWKArS6fdjcdYNMJJxLt6Zz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqA2WEgskaEJLBSCOc3EIKKE2JZM8j0bCdIShXGUYBm+ZbZNV/oQTHGnq8s5iPGx8iRZd3IcIcBWKpOUUjbIqTm4CUT6XnP83rtdP1i0cOdY/6miPj+hWlFVqs4/wwc9yByR/zNYSFR/vR4fQrsm8gFOHB0Y+3eBA9hXWOCH/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3jDwwYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3jDwwYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D60C4AF0D;
	Fri,  2 Aug 2024 00:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559072;
	bh=ORPsIKilCO2aukBgqnmuWKArS6fdjcdYNMJJxLt6Zz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3jDwwYWgRcbA4Yp0Kf8ALb+Xg8JrV2pKnbHcSRsoSfWOq1ss4dH5PlhddnHo0+kF
	 h/qeP9nhZMWYvZMlITxhowKY9vcuNB6uzY7NFl4llJSu4dmo3PCTW42dCnEbzfGKBb
	 Sgcc5ZLYDDu6T4OzEpehiC1b1wmi71hhjEZ6QLQPHHbfZtOqlwUemYm4Q+rskZQRht
	 KGd6ml8WqhRcANTwQ6bw25H2cw2Pt7atn3vTk5KrTI5NEcyzpe4aGBqJInQ8+9uEaG
	 EBWbMmNmc1PzSdJVdERA1vlJRQJjS/QOphDig9mvw4Dn+C5eKgstoqhDWy5mPmbUn/
	 bcUhcUglx1Pfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6C41FCE0BC3; Thu,  1 Aug 2024 17:37:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/3] torture: Add torture.sh --guest-cpu-limit argument for limited hosts
Date: Thu,  1 Aug 2024 17:37:50 -0700
Message-Id: <20240802003750.4134451-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <22c4b040-7b7b-45ff-8fa5-41b741c7cd7e@paulmck-laptop>
References: <22c4b040-7b7b-45ff-8fa5-41b741c7cd7e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some servers have limitations on the number of CPUs a given guest OS
can use.  In my earlier experience, such limitations have been at least
half of the host's CPUs, but in a recent example, this limit is less
than 40%.  This commit therefore adds a --guest-cpu-limit argument that
allows such low limits to be made known to torture.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 990d24696fd34..0447c4a00cc4d 100755
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

