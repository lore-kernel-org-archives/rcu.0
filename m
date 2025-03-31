Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC021B9DF;
	Mon, 31 Mar 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=lgFuBHn+h/h0I8jOn+FPas/Q0fl+zRhDAhAyQHSVnt6NGGlgimXs/+sdfrY10gI0lSGjxeHGoHfD+N3mmGwBl4tkC/mQTqH33XnsuEOAzfYpjOnLVnclFKgr2sihYbUaOg41I59MiFAPytm0Qh4YHx2RxQk1A6BhhwFlqZ2SegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=JcZBJabSTeR6VVDLh2M4X/uJWHu8jyYG489yVTC87Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVNrcLBOFtBvHIj8HdUHiYr2TpBZyccyUKKNj8Y04w14yMOyB+LRBLd17LVuifu0YE1oL3UqG6alrBDsuu5cvjFgAxLClD5zDPjFzlFNei0ww1jly4UNnO0OLxLGXDcNk+pISRwjxrQrnpd03Vd2Cj6MvTS5YxW1zomvBWY9Thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAWpBFaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAWpBFaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC82C4CEF6;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454996;
	bh=JcZBJabSTeR6VVDLh2M4X/uJWHu8jyYG489yVTC87Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAWpBFazJ48gfsXr3Y1ES97nMJjvbDPTRsQTPV6OimREWecQUjGxYe5tM92XmTwy4
	 S3IG9FH+xIifob8DBr3hVu1EmFZk63XBCrbqnFBg3FhjJsUvfti+my81TpX+fLDnZG
	 zsCokxkZiQO/2ckFGaqR62NlE2DscVA/go9oy/MYaCpNAluUXTF87uhohWEWCqRsb5
	 3mUR8plPObXTanTazmuh59kh1V6gEYWEDnYGFA8otlbNNeROo4ORH9bBrmRRZztwHJ
	 8XTiCL0FTcD7g12MJ23Sw6zuqGd2DkwnoStoaxh6SeWl9kUxXyFEYknGexiVz/Fso3
	 NfXKaGdOVyEvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 40A61CE13DF; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2 12/12] torture: Add testing of RCU's Rust bindings to torture.sh
Date: Mon, 31 Mar 2025 14:03:14 -0700
Message-Id: <20250331210314.590622-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a --do-rcu-rust parameter to torture.sh, which invokes
a rust_doctests_kernel kunit run.  Note that kunit wants a clean source
tree, so this runs "make mrproper", which might come as a surprise to
some users.  Should there be a --mrproper parameter to torture.sh to make
the user explicitly ask for it?

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 751ce770e5462..2c3e86fe8c0a2 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -59,6 +59,7 @@ do_clocksourcewd=yes
 do_rt=yes
 do_rcutasksflavors=yes
 do_srcu_lockdep=yes
+do_rcu_rust=no
 
 # doyesno - Helper function for yes/no arguments
 function doyesno () {
@@ -89,6 +90,7 @@ usage () {
 	echo "       --do-rcutorture / --do-no-rcutorture / --no-rcutorture"
 	echo "       --do-refscale / --do-no-refscale / --no-refscale"
 	echo "       --do-rt / --do-no-rt / --no-rt"
+	echo "       --do-rcu-rust / --do-no-rcu-rust / --no-rcu-rust"
 	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
 	echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-srcu-lockdep"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
@@ -191,6 +193,9 @@ do
 	--do-rt|--do-no-rt|--no-rt)
 		do_rt=`doyesno "$1" --do-rt`
 		;;
+	--do-rcu-rust|--do-no-rcu-rust|--no-rcu-rust)
+		do_rcu_rust=`doyesno "$1" --do-rcu-rust`
+		;;
 	--do-scftorture|--do-no-scftorture|--no-scftorture)
 		do_scftorture=`doyesno "$1" --do-scftorture`
 		;;
@@ -485,6 +490,46 @@ then
 	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_LAZY=n CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y" --trust-make
 fi
 
+if test "$do_rcu_rust" = "yes"
+then
+	echo " --- do-rcu-rust:" Start `date` | tee -a $T/log
+	rrdir="tools/testing/selftests/rcutorture/res/$ds/results-rcu-rust"
+	mkdir -p "$rrdir"
+	echo " --- make LLVM=1 rustavailable " | tee -a $rrdir/log > $rrdir/rustavailable.out
+	make LLVM=1 rustavailable > $T/rustavailable.out 2>&1
+	retcode=$?
+	echo $retcode > $rrdir/rustavailable.exitcode
+	cat $T/rustavailable.out | tee -a $rrdir/log >> $rrdir/rustavailable.out 2>&1
+	buildphase=rustavailable
+	if test "$retcode" -eq 0
+	then
+		echo " --- Running 'make mrproper' in order to run kunit." | tee -a $rrdir/log > $rrdir/mrproper.out
+		make mrproper > $rrdir/mrproper.out 2>&1
+		retcode = $?
+		echo $retcode > $rrdir/mrproper.exitcode
+		buildphase=mrproper
+	fi
+	if test "$retcode" -eq 0
+	then
+		echo " --- Running rust_doctests_kernel." | tee -a $rrdir/log > $rrdir/rust_doctests_kernel.out
+		./tools/testing/kunit/kunit.py run --make_options LLVM=1 --make_options CLIPPY=1 --arch arm64 --kconfig_add CONFIG_SMP=y --kconfig_add CONFIG_WERROR=y --kconfig_add CONFIG_RUST=y rust_doctests_kernel >> $rrdir/rust_doctests_kernel.out 2>&1
+		# @@@ Remove "--arch arm64" in order to test on native architecture?
+		# @@@ Analyze $rrdir/rust_doctests_kernel.out contents?
+		retcode=$?
+		echo $retcode > $rrdir/rust_doctests_kernel.exitcode
+		buildphase=rust_doctests_kernel
+	fi
+	if test "$retcode" -eq 0
+	then
+		echo "rcu-rust($retcode)" $rrdir >> $T/successes
+		echo Success >> $rrdir/log
+	else
+		echo "rcu-rust($retcode)" $rrdir >> $T/failures
+		echo " --- rcu-rust Test summary:" >> $rrdir/log
+		echo " --- Summary: Exit code $retcode from $buildphase, see $rrdir/$buildphase.out" >> $rrdir/log
+	fi
+fi
+
 if test "$do_srcu_lockdep" = "yes"
 then
 	echo " --- do-srcu-lockdep:" Start `date` | tee -a $T/log
-- 
2.40.1

