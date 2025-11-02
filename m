Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929A24E01D;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119879; cv=none; b=U0quv92Kge+5odlygCt+179ZD2+qalgY04KZoWXm+DQtdT4rkdXQuoam+kY/VxUa9Z8N6SkvdaIStC1FLcKGzMVSeHZRBgORpzKClpwyy2SQno9lhDWchQ3Qi915SRxBGyDBS3kxfqWTjPOY8f3Nnao7mhM/xd2JMwx5IdL+BBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119879; c=relaxed/simple;
	bh=bdRaLOeGRlaNeOitkkHmPDSe++KDC1F2xKdPiknDIIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJltZwqr/Br24WD2WuhstTGGdMGftLtCrlVoKVGzcO4qGGoTlwJuC7SH2dOqfMFT5HciXC6ZwgSDoNAB+q16mZvzigO45Hu2uHDfNgFwTLKi25auxtO8s1LIurl1eVL77gogeu62q7WQV3hvj0MI3z6RbL56v/e3EjSQDP6IhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGROng2V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGROng2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E93C16AAE;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119879;
	bh=bdRaLOeGRlaNeOitkkHmPDSe++KDC1F2xKdPiknDIIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGROng2Vrwr7izBe1JMo0rTtk/LECrRXPoseahtv9nErOznfGE5Xvlp0yFprbemi8
	 AAZWbrKf76/4O4Y1sXXQZIHyp+RzljtpYC6tOVU4pPgmJ8ieX5A/AYc6zk2tcjswFw
	 nSqzJeyiuZ/WAyIFG83ufr32gH9gIpKLxXgpdta4VAJFmP4q2vJ/bQHzZtp7c+/7Kv
	 vqkVD2tfKFW9eO3puAEvnhHfDWf70CsL4ROx/OsQ5XlaGe00mkoS9khBx95BsrCWSk
	 hKl7y4wT4E3zLofx6Q8HfKaBfrIXr25kD8dpCZ8Z/espWEkNgRCMaPG2U21b0pifu+
	 ibfESU8CBhx2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96CDECE15C3; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 12/19] rcutorture: Permit kvm-again.sh to re-use the build directory
Date: Sun,  2 Nov 2025 13:44:29 -0800
Message-Id: <20251102214436.3905633-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds "inplace" and "inplace-force" values to the kvm-again.sh
"--link" argument, which causes the run's output to be placed into the
build directory.  This could be used to save build time if the machine
went down partway into a run, but it can also be used to do a large
number of builds, and run the resulting kernels concurrently even if the
builds are based on different commits.  A later commit will add this
latter capability to kvm-series.sh in order to produce large speedups
for branch-checking operations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-again.sh     | 56 +++++++++++++------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 88ca4e368489..b5239b52cb5d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -31,7 +31,7 @@ fi
 if ! cp "$oldrun/scenarios" $T/scenarios.oldrun
 then
 	# Later on, can reconstitute this from console.log files.
-	echo Prior run batches file does not exist: $oldrun/batches
+	echo Prior run scenarios file does not exist: $oldrun/scenarios
 	exit 1
 fi
 
@@ -68,7 +68,7 @@ usage () {
 	echo "       --datestamp string"
 	echo "       --dryrun"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
-	echo "       --link hard|soft|copy"
+	echo "       --link hard|soft|copy|inplace|inplace-force"
 	echo "       --remote"
 	echo "       --rundir /new/res/path"
 	echo "Command line: $scriptname $args"
@@ -121,7 +121,7 @@ do
 		shift
 		;;
 	--link)
-		checkarg --link "hard|soft|copy" "$#" "$2" 'hard\|soft\|copy' '^--'
+		checkarg --link "hard|soft|copy|inplace|inplace-force" "$#" "$2" 'hard\|soft\|copy\|inplace\|inplace-force' '^--'
 		case "$2" in
 		copy)
 			arg_link="cp -R"
@@ -132,6 +132,14 @@ do
 		soft)
 			arg_link="cp -Rs"
 			;;
+		inplace)
+			arg_link="inplace"
+			rundir="$oldrun"
+			;;
+		inplace-force)
+			arg_link="inplace-force"
+			rundir="$oldrun"
+			;;
 		esac
 		shift
 		;;
@@ -172,21 +180,37 @@ fi
 
 echo ---- Re-run results directory: $rundir
 
-# Copy old run directory tree over and adjust.
-mkdir -p "`dirname "$rundir"`"
-if ! $arg_link "$oldrun" "$rundir"
-then
-	echo "Cannot copy from $oldrun to $rundir."
-	usage
-fi
-rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
-touch "$rundir/log"
-echo $scriptname $args | tee -a "$rundir/log"
-echo $oldrun > "$rundir/re-run"
-if ! test -d "$rundir/../../bin"
+if test "$oldrun" != "$rundir"
 then
-	$arg_link "$oldrun/../../bin" "$rundir/../.."
+	# Copy old run directory tree over and adjust.
+	mkdir -p "`dirname "$rundir"`"
+	if ! $arg_link "$oldrun" "$rundir"
+	then
+		echo "Cannot copy from $oldrun to $rundir."
+		usage
+	fi
+	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+	touch "$rundir/log"
+	echo $scriptname $args | tee -a "$rundir/log"
+	echo $oldrun > "$rundir/re-run"
+	if ! test -d "$rundir/../../bin"
+	then
+		$arg_link "$oldrun/../../bin" "$rundir/../.."
+	fi
+else
+	# Check for a run having already happened.
+	find "$rundir" -name console.log -print > $T/oldrun-console.log
+	if test -s $T/oldrun-console.log
+	then
+		echo Run already took place in $rundir
+		if test "$arg_link" = inplace
+		then
+			usage
+		fi
+	fi
 fi
+
+# Find runs to be done based on their qemu-cmd files.
 for i in $rundir/*/qemu-cmd
 do
 	cp "$i" $T
-- 
2.40.1

