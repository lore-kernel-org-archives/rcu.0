Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C7204F62;
	Wed,  6 Nov 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908953; cv=none; b=Bk9yqk4Fr6UUblRW0tD4ePkMwUUQ+pBm2v3UqeAuja/Y7pf9ywWL9XAedkOPu8eAAhs1Absmzdb3UwMglk1IJcWAiBMiFXnsgWs+kDS1Rt1Pg8ODSFtRl3L5qldAOdr3sV+iAdiUW/sxrqHpKTuABSnM0YyHWy0PxoUM5rJ9quU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908953; c=relaxed/simple;
	bh=U/ItV5j1IpXcUSs5Dm84g9/hYR9gVguqhjK8HZMgJPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQbE6bWDqD+wewac8RP6z6fLtU0ywXakdTfp1ZuqrwFTD+qgbuTHZHQys89vqUb3TlMvbBREQyUfsiDHHCfJDUUhuJXNog8GmHowap7+++zu8bd2ewMKR7pNEWoJ7kuJNb2vmt1JWSrs5LMvwNaNDlRZ5GL6IL5rviSte1pLRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWy4Zodh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWy4Zodh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DE3C4CECC;
	Wed,  6 Nov 2024 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908952;
	bh=U/ItV5j1IpXcUSs5Dm84g9/hYR9gVguqhjK8HZMgJPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWy4Zodh36t9qH9k8xzjHrN5kAOcvILfj3dmKyPcH7U+s5gGDxeRCMjPIKYtIiaZ4
	 KFEt+RY++4V6EUPOmq4qK6tk/BwzbuT+JBPTvcRsrK/CJb+sncSM2Whm43RbjWKm1M
	 M1l4fUFm0GHwdcBqxe6xcsQP7Ni6ztxhB4yO+6kGO598tsKx9dQewSAVtb2CwvJSrm
	 wmyco/F/ThaIVPTmeu/MWUCUSQl50bf3Jg1DJMDVe8g84YZfsYh51HTXhKsags0wqc
	 tJwTp1ypD7mg5nbEQCxN4lEew3gMjQC7I+VymDbsq0IFKmK3C57uGYQzGU17u1gZTk
	 aOn14mVEzQc0g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/6] torture: Add --no-affinity parameter to kvm.sh
Date: Wed,  6 Nov 2024 17:02:18 +0100
Message-ID: <20241106160223.42119-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106160223.42119-1-frederic@kernel.org>
References: <20241106160223.42119-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

In performance tests, it can be counter-productive to spread torture-test
guest OSes across sockets.  Plus the experimenter might have ideas about
what CPUs individual guest OSes are to run on.  This commit therefore
adds a --no-affinity parameter to kvm.sh to prevent it from running
taskset on its guest OSes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../rcutorture/bin/kvm-test-1-run-batch.sh    | 43 ++++++++++---------
 tools/testing/selftests/rcutorture/bin/kvm.sh |  6 +++
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
index c3808c490d92..f87046b702d8 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
@@ -56,27 +56,30 @@ do
 	echo > $i/kvm-test-1-run-qemu.sh.out
 	export TORTURE_AFFINITY=
 	kvm-get-cpus-script.sh $T/cpuarray.awk $T/cpubatches.awk $T/cpustate
-	cat << '	___EOF___' >> $T/cpubatches.awk
-	END {
-		affinitylist = "";
-		if (!gotcpus()) {
-			print "echo No CPU-affinity information, so no taskset command.";
-		} else if (cpu_count !~ /^[0-9][0-9]*$/) {
-			print "echo " scenario ": Bogus number of CPUs (old qemu-cmd?), so no taskset command.";
-		} else {
-			affinitylist = nextcpus(cpu_count);
-			if (!(affinitylist ~ /^[0-9,-][0-9,-]*$/))
-				print "echo " scenario ": Bogus CPU-affinity information, so no taskset command.";
-			else if (!dumpcpustate())
-				print "echo " scenario ": Could not dump state, so no taskset command.";
-			else
-				print "export TORTURE_AFFINITY=" affinitylist;
+	if test -z "${TORTURE_NO_AFFINITY}"
+	then
+		cat << '		___EOF___' >> $T/cpubatches.awk
+		END {
+			affinitylist = "";
+			if (!gotcpus()) {
+				print "echo No CPU-affinity information, so no taskset command.";
+			} else if (cpu_count !~ /^[0-9][0-9]*$/) {
+				print "echo " scenario ": Bogus number of CPUs (old qemu-cmd?), so no taskset command.";
+			} else {
+				affinitylist = nextcpus(cpu_count);
+				if (!(affinitylist ~ /^[0-9,-][0-9,-]*$/))
+					print "echo " scenario ": Bogus CPU-affinity information, so no taskset command.";
+				else if (!dumpcpustate())
+					print "echo " scenario ": Could not dump state, so no taskset command.";
+				else
+					print "export TORTURE_AFFINITY=" affinitylist;
+			}
 		}
-	}
-	___EOF___
-	cpu_count="`grep '# TORTURE_CPU_COUNT=' $i/qemu-cmd | sed -e 's/^.*=//'`"
-	affinity_export="`awk -f $T/cpubatches.awk -v cpu_count="$cpu_count" -v scenario=$i < /dev/null`"
-	$affinity_export
+		___EOF___
+		cpu_count="`grep '# TORTURE_CPU_COUNT=' $i/qemu-cmd | sed -e 's/^.*=//'`"
+		affinity_export="`awk -f $T/cpubatches.awk -v cpu_count="$cpu_count" -v scenario=$i < /dev/null`"
+		$affinity_export
+	fi
 	kvm-test-1-run-qemu.sh $i >> $i/kvm-test-1-run-qemu.sh.out 2>&1 &
 done
 for i in $runfiles
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 7af73ddc148d..42e5e8597a1a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -42,6 +42,7 @@ TORTURE_JITTER_STOP=""
 TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
+TORTURE_NO_AFFINITY=""
 TORTURE_QEMU_MEM=512
 torture_qemu_mem_default=1
 TORTURE_REMOTE=
@@ -82,6 +83,7 @@ usage () {
 	echo "       --kmake-arg kernel-make-arguments"
 	echo "       --mac nn:nn:nn:nn:nn:nn"
 	echo "       --memory megabytes|nnnG"
+	echo "       --no-affinity"
 	echo "       --no-initrd"
 	echo "       --qemu-args qemu-arguments"
 	echo "       --qemu-cmd qemu-system-..."
@@ -220,6 +222,9 @@ do
 		torture_qemu_mem_default=
 		shift
 		;;
+	--no-affinity)
+		TORTURE_NO_AFFINITY="no-affinity"
+		;;
 	--no-initrd)
 		TORTURE_INITRD=""; export TORTURE_INITRD
 		;;
@@ -417,6 +422,7 @@ TORTURE_KCONFIG_KASAN_ARG="$TORTURE_KCONFIG_KASAN_ARG"; export TORTURE_KCONFIG_K
 TORTURE_KCONFIG_KCSAN_ARG="$TORTURE_KCONFIG_KCSAN_ARG"; export TORTURE_KCONFIG_KCSAN_ARG
 TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG"; export TORTURE_KMAKE_ARG
 TORTURE_MOD="$TORTURE_MOD"; export TORTURE_MOD
+TORTURE_NO_AFFINITY="$TORTURE_NO_AFFINITY"; export TORTURE_NO_AFFINITY
 TORTURE_QEMU_CMD="$TORTURE_QEMU_CMD"; export TORTURE_QEMU_CMD
 TORTURE_QEMU_INTERACTIVE="$TORTURE_QEMU_INTERACTIVE"; export TORTURE_QEMU_INTERACTIVE
 TORTURE_QEMU_MAC="$TORTURE_QEMU_MAC"; export TORTURE_QEMU_MAC
-- 
2.46.0

