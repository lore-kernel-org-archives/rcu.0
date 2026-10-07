Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F64137B2;
	Wed,  7 Oct 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406768; cv=none; b=D4+NEpmk9Ny+WigupLlr26c1TIM+rIlU2eFS9OL9JnWikrydv1YRRbJuHwyFTnGU8RGqSOkvCPOLUSr/q+r4exhSEagjdmPRcfv8DYsJkmPJJt2IFxCvSHDY+s68CM/sm98PTlrCAeGlwXgd5UWdshFmWjcPqwsqRFhkGHkvwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406768; c=relaxed/simple;
	bh=yMBAufJOBf3mLeKn38tWJgeD26HhkSRh7dhOscup0uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFf8rUJFLNiSpqAGP2s3nIOpwqXBPqMahpRfkF+H/Y/05ZedeQNBm124ad6lJKTsLtTbtWGl54T0QESeeQiASAL8G/tBKCLzxwiiZbI7mQpRP/q4ElvNM3t8q74mQAwDboWvslFRDYE6EFLKuAbC5hiRsVm2ZTheAdqd3EmZC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyQRghdU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyQRghdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80651F008A0;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=2CDRlUFhz156Dp1g1KN4XpW7RbGGjBJ468eEKIlvzUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyQRghdUAwHWO9jx18KqGRGOxM8N4manFCOIveeIaAfB6zqK3dpHSgLif2ASXEwcb
	 zfU8iGeOLjXYsKcAgdfTOzYQVBoQSNBvDAGw8qEu2ESp2IF2F3bhEiW1N1GjlQ8l4I
	 PJSnw6eOhm3z4J0lyu/Bj9kRvPofOoUJZ6ZKPqPrVCD5DY6bzFWdSzFUMe64TKMxrj
	 0CcJIm1rjvAN+IAd35lQzgzBv0klB/j2mqjEbKwmnB7l4tHc39SgpVyRs8JidPE9Kj
	 TYTTcwrB6j7Py9Uc52A3qm0RqY9bDkSDgImNLzya7hNgclrIsk+gRgtm1fNHk3sROJ
	 5ASQbqif3suSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B3DFCE2751; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 11/21] rcutorture: Add atomic-SRCU support to torture.sh
Date: Wed,  7 Oct 2026 13:59:14 -0700
Message-Id: <20261007205924.1983367-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Add the --do-atomic-srcu argument to torture.sh, which runs the
SRCU-N, SRCU-P, and SRCU-T scenarios, thus covering both Tree SRCU
(SRCU-N and SRCU-P) and Tiny SRCU (SRCU-T), with
rcutorture.reader_flavor=0x10 appended to the boot parameters so
that it takes precedence over each scenario's own reader-flavor
setting.  This exercises srcu_read_lock_atomic(),
srcu_read_unlock_atomic(), and synchronize_srcu_atomic().

As with other torture.sh tests, the --do-kcsan argument runs a
KCSAN+PROVE_LOCKING variant of this test.

[ paulmck: Make --do-atomic-srcu be default-on. ]

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index f0083891ee814..e7b578ec152f1 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -68,6 +68,7 @@ do_clocksourcewd="${ifnotaarch64}"
 do_rt=yes
 do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n auto-avoided
 do_srcu_lockdep=yes
+do_atomic_srcu=yes
 do_rcu_rust=no
 
 # doyesno - Helper function for yes/no arguments
@@ -103,6 +104,7 @@ usage () {
 	echo "       --do-rcu-rust / --do-no-rcu-rust / --no-rcu-rust"
 	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
 	echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-srcu-lockdep"
+	echo "       --do-atomic-srcu / --do-no-atomic-srcu / --no-atomic-srcu"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
 	echo "       --guest-cpu-limit N"
 	echo "       --kcsan-kmake-arg kernel-make-arguments"
@@ -148,6 +150,7 @@ do
 		do_kcsan=yes
 		do_clocksourcewd="${ifnotaarch64}"
 		do_srcu_lockdep=yes
+		do_atomic_srcu=yes
 		;;
 	--do-allmodconfig|--do-no-allmodconfig|--no-allmodconfig)
 		do_allmodconfig=`doyesno "$1" --do-allmodconfig`
@@ -183,6 +186,7 @@ do
 		do_kcsan=no
 		do_clocksourcewd=no
 		do_srcu_lockdep=no
+		do_atomic_srcu=no
 		;;
 	--do-normal|--do-norm|--do-no-normal|--do-no-norm|--no-normal|--no-norm)
 		do_normal=`doyesno "$1" --do-normal`
@@ -212,6 +216,9 @@ do
 	--do-srcu-lockdep|--do-no-srcu-lockdep|--no-srcu-lockdep)
 		do_srcu_lockdep=`doyesno "$1" --do-srcu-lockdep`
 		;;
+	--do-atomic-srcu|--do-no-atomic-srcu|--no-atomic-srcu)
+		do_atomic_srcu=`doyesno "$1" --do-atomic-srcu`
+		;;
 	--duration)
 		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(m\|h\|d\|\)$' '^error'
 		mult=1
@@ -497,6 +504,23 @@ then
 	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "$configs_rcutorture" --trust-make
 fi
 
+# Test atomic SRCU across Tree SRCU (SRCU-N and SRCU-P) and Tiny SRCU
+# (SRCU-T).  The reader flavor selects srcu_read_lock_atomic() and
+# synchronize_srcu_atomic().  Tiny SRCU requires SMP=n, which aarch64
+# does not support.
+if test "$do_atomic_srcu" = "yes"
+then
+	torture_bootargs="rcutorture.reader_flavor=0x10"
+	configs_atomic_srcu="SRCU-N SRCU-P"
+	if test "$ifnotaarch64" = yes
+	then
+		configs_atomic_srcu="$configs_atomic_srcu SRCU-T"
+	fi
+	torture_set "atomic-srcu" tools/testing/selftests/rcutorture/bin/kvm.sh \
+		--allcpus --duration "$duration_rcutorture" \
+		--configs "$configs_atomic_srcu" --trust-make
+fi
+
 if test "$do_locktorture" = "yes"
 then
 	torture_bootargs="torture.disable_onoff_at_boot"
-- 
2.40.1

