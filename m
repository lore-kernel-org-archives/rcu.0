Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C527325495;
	Sat, 19 Sep 2026 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778146; cv=none; b=rY6QjVnXoeTHsKyLJqUSIwPmKGHUTSmfsYOnB3rg/R+OGyBScB9CiWYCOHMh2rtVvw26zpjV8//QZVFlvBsT65bqd1T2Fp3GZ8VQY/1nOVxzSmGwKFVrRPJfiFlitc9Ks4nVRmEm7fMQOPmbv8a4pwV/kMVenNAmu/TZpu22SvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778146; c=relaxed/simple;
	bh=Z3Hq8MB7MC2CdIL5t0qKx/Nb3myEZ+NYT4GuUzOm40o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7XHUJWii6jyZkqu1mKcUBwcXNbT6aqITWGXxLoCo6LKu0jsfLnc+3lmfwa0fkV5XNt1s12FeiJHhlZIlMphUo4iogU45O91JhdY1neCsvqPBPnPVAhD7WX6jhOaIoFKakCSXleSmi4aynXS9SUPibvzetn5kKchWIxXHUsnIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2sYhXgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2sYhXgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397C11F008BC;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=xQi3LexBdeioHlPsYw6/EfTg9lM9UCcZ8R/HVZsUByI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k2sYhXgMqK2OGib4oC4MU8wIVv8SzPAiVQR/iNR5kcDR1HzzJF9nzrLbrIVfBBKhl
	 h8QwLPPMOhEf2aWP7mie+uS8VnpW1xs+M5OAlUF9JB0e+zmO6jOJcwt2Ub5b9PhQQ5
	 zBfNt1Z5Hcr5NFe88A1jAhUXvhqmPm6gmnLL3Ni7MvlQ+hCqxL0I8RFH4GufVaMYo9
	 n09SHttPmvRRCPYSxNyBsitdy6vZDgPpTzd22HPUI+cRkysuWH7MfuyN2Jb+TV+eum
	 McKNH6DUIucQP0Ogb7iyOf3HDZ0yy4GikPY/FqHrJOlCt5eWMDpkiyqetGsQe6KP5w
	 yq8i2NFfB19Bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B02A6CE18B5; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 12/19] rcutorture: Add atomic-SRCU support to torture.sh
Date: Fri, 18 Sep 2026 17:35:14 -0700
Message-Id: <20260919003521.3134552-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
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
index f0083891ee81..e7b578ec152f 100755
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

