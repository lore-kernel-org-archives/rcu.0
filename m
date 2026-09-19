Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA92334C1D;
	Sat, 19 Sep 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776066; cv=none; b=iLiCzEop4tD78IxnNWsjNfIPSzDsx2lHZNUzwaLfjArYDnlJAcZAs1CDhOGm7xxzGLywyxQBbHSDenmw9IRh6MUG4YuhR4oz3E59Glp7bHEDp04SOhZN9Wo3d3D0hOQwdXJvE+BbkFo2ciruO/mcxmlLxib4dT5rDeL32KKW95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776066; c=relaxed/simple;
	bh=2s4jxd1waEpjFiyoIv3rEdivkL/q31i8XtUrBG/Icos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuGc3FFnf5qGXE3tZOhliXUS6tyzjbNOcTSXwWUPy2+o0HOJyRVwWeHyE8f67Ffk6LetY1LgvfOEP1xfsGb87raaos+6nqvtJzp6xy93lBobjC9RuoV/pB+2Eg14NwXVSMA6sb//XczlkkT9cwA5yCi4zhqOcCgePaErbdlYHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJhLh/lP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJhLh/lP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762E61F00A04;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=G8uCyyrFkGLiaoKB9plfl7B6bytERqU6MWOWXRqFRrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJhLh/lPnSm7IikZHrRlXz8uFoe0SLaGRA7K2z4bwT1lNTcmRmrY5B4czG92zJK3+
	 1DmrJNWFz2mi61apJwcQ7om+mX2G7T8Ixymv2qZ0I5yGuKqbRzVzUnlgV/ppCwtZ8G
	 UNBrPIPWi38bPLL7G6q1+gfuok1DJff3Yz+o58aBk4pRdvRgAUsFDTpu7W7L3oBev7
	 w0CN8yIs16jLH7tvBEK2Fy1X7bU/25NzkuFbdYNIYuaw14+dZHn3IDrQkGf9pO3bpj
	 Xil1ULenmSmzcL7j5UzvYRzw6Q6GmoNsyNRbiH/4ZZ/i3Vf6VAWpudvmWJtBqymw8S
	 zAybsfRs3h+Mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9B2F3CE09DC; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 28/28] torture.sh: Add hazptr torturing
Date: Fri, 18 Sep 2026 17:00:56 -0700
Message-Id: <20260919000056.3132131-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds hazard-pointer torturing to the torture.sh script
as a default-on option.  This uses the same duration as rcutorture.
While in the area, change kvm.sh to tolerate the empty-string arguments
that torture.sh can generate, for example, if a given test needs no
boot arguments.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh |  4 +++
 .../selftests/rcutorture/bin/torture.sh       | 26 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 32c319997638..2f386cf536e3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -98,6 +98,7 @@ usage () {
 
 while test $# -gt 0
 do
+	echo Argument: :$1:
 	case "$1" in
 	--allcpus)
 		cpus=$TORTURE_ALLOTED_CPUS
@@ -271,6 +272,9 @@ do
 	--trust-make)
 		TORTURE_TRUST_MAKE="y"
 		;;
+	"")
+		# torture.sh can pass empty arguments.  Ignore them.
+		;;
 	*)
 		echo Unknown argument $1
 		usage
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index f0083891ee81..2824dab14d41 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -43,6 +43,7 @@ fi
 configs_rcutorture=
 configs_locktorture=
 configs_scftorture=
+configs_hazptr=
 kcsan_kmake_args=
 
 # Default compression, duration, and apportionment.
@@ -69,6 +70,7 @@ do_rt=yes
 do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n auto-avoided
 do_srcu_lockdep=yes
 do_rcu_rust=no
+do_hazptr=yes
 
 # doyesno - Helper function for yes/no arguments
 function doyesno () {
@@ -89,6 +91,7 @@ usage () {
 	echo "       --do-all"
 	echo "       --do-allmodconfig / --do-no-allmodconfig / --no-allmodconfig"
 	echo "       --do-clocksourcewd / --do-no-clocksourcewd / --no-clocksourcewd"
+	echo "       --do-hazptr / --do-no-hazptr / --no-hazptr"
 	echo "       --do-kasan / --do-no-kasan / --no-kasan"
 	echo "       --do-kcsan / --do-no-kcsan / --no-kcsan"
 	echo "       --do-kvfree / --do-no-kvfree / --no-kvfree"
@@ -117,6 +120,11 @@ do
 		compress_concurrency=$2
 		shift
 		;;
+	--config-hazptr|--configs-hazptr)
+		checkarg --configs-hazptr "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs_hazptr="$configs_hazptr $2"
+		shift
+		;;
 	--config-rcutorture|--configs-rcutorture)
 		checkarg --configs-rcutorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
 		configs_rcutorture="$configs_rcutorture $2"
@@ -147,6 +155,7 @@ do
 		do_kasan=yes
 		do_kcsan=yes
 		do_clocksourcewd="${ifnotaarch64}"
+		do_hazptr=yes
 		do_srcu_lockdep=yes
 		;;
 	--do-allmodconfig|--do-no-allmodconfig|--no-allmodconfig)
@@ -155,6 +164,9 @@ do
 	--do-clocksourcewd|--do-no-clocksourcewd|--no-clocksourcewd)
 		do_clocksourcewd=`doyesno "$1" --do-clocksourcewd`
 		;;
+	--do-hazptr|--do-no-hazptr|--no-hazptr)
+		do_hazptr=`doyesno "$1" --do-hazptr`
+		;;
 	--do-kasan|--do-no-kasan|--no-kasan)
 		do_kasan=`doyesno "$1" --do-kasan`
 		;;
@@ -182,6 +194,7 @@ do
 		do_kasan=no
 		do_kcsan=no
 		do_clocksourcewd=no
+		do_hazptr=no
 		do_srcu_lockdep=no
 		;;
 	--do-normal|--do-norm|--do-no-normal|--do-no-norm|--no-normal|--no-norm)
@@ -343,7 +356,7 @@ function torture_one {
 		boottag="--bootargs"
 		cur_bootargs="$torture_bootargs"
 	fi
-	"$@" $boottag "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
+	"$@" "${boottag}" "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
 	retcode=$?
 	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
 	if test -z "$resdir"
@@ -704,6 +717,17 @@ then
 	fi
 fi
 
+# Calculate hazptr defaults and apportion time
+if test -z "$configs_hazptr"
+then
+	configs_hazptr=CFLIST
+fi
+if test "$do_hazptr" = "yes"
+then
+	torture_bootargs=""
+	torture_set "hazptr" tools/testing/selftests/rcutorture/bin/kvm.sh --torture hazptr --allcpus --duration "$duration_rcutorture" --configs "$configs_hazptr" --trust-make
+fi
+
 echo " --- " $scriptname $args
 echo " --- " Done `date` | tee -a $T/log
 ret=0
-- 
2.40.1

