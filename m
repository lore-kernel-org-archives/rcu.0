Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2A1E1330;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496976; cv=none; b=tFZfeiPTN5/vor2e9JSgJWuojFRakjepZGetSufC28B4Rw5QF9ulddbTnl5By+bAGNoaI+HoZS45+unfc4+py9GX/mXk89KtQXA0E4arkQ4cSfld1arngOZisnykfMKjqrSg4ggpGCVd+0SQQVvnemQkvzGrC1bhqrasWtuhS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496976; c=relaxed/simple;
	bh=hlVg4FxJvZjim3cclQmUFm9AlIKDKpHkyjXaet4fHak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHb/AZ05oHa/581uIjo0mt8ttZX6NLLr0NXgYPsBJjFCZmyeXzawUf83h7BTmhk6H6lfirwNTop/LWFKa2lvqVimmTElepFf3sYSCI4Y8Hvt9mOefy+TyAnc4ACf3rYhK6AkvW8Z3ajs04R9+n9Uxw1tjmKPkNA5rc7AdAxX0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxB+ZOsU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxB+ZOsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BA8C4CED3;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496976;
	bh=hlVg4FxJvZjim3cclQmUFm9AlIKDKpHkyjXaet4fHak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxB+ZOsUeIBNIEItVwZ6Q8RH+xmkzldz/yfwUaEGSwgCHfI/Tgxnz7C3Ce1WCASvp
	 jAdeJIz/K1dzPaUpjmedqC7cxIFXrxFTYN2XoiNE/TLqG3dQSmXOqjeSa39iNVwBTL
	 pPdcKxCuX5yTZ59kK5dhekImu+daBXMwD9RZUHzNT+8o4p/R+FKahrZc0NrPR5pbNk
	 oIn2OQbS2y2ztJyRz/2NXE0DXgJlgv7LDZsHM/N1WxMZTQz0R7GBhhFPXn97ZIj7Z2
	 64OOA9Aid/ih3wlIVM1SUsq0YsBpoH7ZpXLn+p6q6LZGZEDzqCs867wU9TY1xIF0XS
	 4PMqbP4n5rcpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7993CE0B68; Wed,  9 Oct 2024 11:02:55 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] torture: Add --no-affinity parameter to kvm.sh
Date: Wed,  9 Oct 2024 11:02:50 -0700
Message-Id: <20241009180253.777965-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
References: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In performance tests, it can be counter-productive to spread torture-test
guest OSes across sockets.  Plus the experimenter might have ideas about
what CPUs individual guest OSes are to run on.  This commit therefore
adds a --no-affinity parameter to kvm.sh to prevent it from running
taskset on its guest OSes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../rcutorture/bin/kvm-test-1-run-batch.sh    | 43 ++++++++++---------
 tools/testing/selftests/rcutorture/bin/kvm.sh |  6 +++
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
index c3808c490d92d..f87046b702d88 100755
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
index 7af73ddc148d1..42e5e8597a1a6 100755
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
2.40.1

