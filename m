Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1065D35CB91;
	Sat, 19 Sep 2026 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789816713; cv=none; b=SZowcaMv/ra/Ixzd4IJdpFX1l7hcBSWZAYRp5xB8lb7MRI2AiMthYXthIGGxHZhwYuW8eY2vfRXv6fu8VyPqSMVjWl10/pkU1vQL9Rkm5zmk5xRPKQNV7w9UQ1fonwJoJy4GW9YWOhW0pNwjbK/QwcYWKNJ7LlXsjZfYdU3Z6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789816713; c=relaxed/simple;
	bh=X/KMhtPuaMlPEv0rbZG2bsyP9v63pjKOD1jGeKYNdMw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CAFbpAk6+x24mjXQzMc6n+YKMzq50KDarZtw9+cP73Pd9ttlZ+SlYOqJPdXpB99gRCQa9pAaAyqSYPNMKphzygB1G+V9ZA0O0yzG2Kpelw0cCDiEJbh9L9X2hCLbcCXqA5kBmruCuTkiOzgTdDBKqqMpUuDvwES6czRPhth2To0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=raJcMdI3; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=OFjAUCWz; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="raJcMdI3";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="OFjAUCWz"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789816696; bh=oNCf2PohaIMiDCK4YFeaz2d
	CZsq4STxl19+ykDcY+yw=; b=raJcMdI3Jk5CPJJh3/ZFHXgALSdVYatsk+KZQWoF6cY78koEu6
	P6vWE7Yk6gXREeP3C1HzUaUQvP1eQ6oOXpd/+jmdL55N7EmxHoqMR+NgnfbBz92nSGE4sXdDN/I
	2Wg+ELkN2akjY+fNNeOJver6gBppCzNNM1vhhu91/R1K2/LjOs9id4jyu6o2elFEmRxM6zvO5dO
	M+ST3wdjT0SDKXgLFqelGg5aEVuSjMdS/B3p2xCOWKXbzMMsXlXglqk/swE+cPrF2fjdrKBWswA
	Q2hSRR1egNdre/35r7WDCSsbtyyFCn5I4TWMhZNV29s7Fm0y/1cILtTSdfUfPGflEEg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789816696; bh=oNCf2PohaIMiDCK4YFeaz2d
	CZsq4STxl19+ykDcY+yw=; b=OFjAUCWzGJOHiB+wRW61m6BcK/EVdI7RZTgx6MyuV+z9gW3hiE
	77QkjDxtTov1Oto5XADdZFoEn5zUO803NkBg==;
Date: Sat, 19 Sep 2026 12:18:17 +0100
From: Bradley Morgan <brads@mainlining.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: kernel-team@meta.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 lkmm@lists.linux.dev, Zqiang <qiang.zhang@linux.dev>,
 Wang Lian <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 28/28] torture.sh: Add hazptr torturing
In-Reply-To: <20260919000056.3132131-28-paulmck@kernel.org>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop> <20260919000056.3132131-28-paulmck@kernel.org>
Message-ID: <CDA33B6C-128C-445C-B869-A9ABB8E02EC3@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 September 2026 01:00:56 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>This commit adds hazard-pointer torturing to the torture.sh script
>as a default-on option.  This uses the same duration as rcutorture.
>While in the area, change kvm.sh to tolerate the empty-string arguments
>that torture.sh can generate, for example, if a given test needs no
>boot arguments.
>
>Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>Cc: Boqun Feng <boqun@kernel.org>
>Cc: Bradley Morgan <brads@mainlining.org>

Why CC? Well thanks, this'll benefit my new PowerPC box :) (manifesting!)

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>---
> tools/testing/selftests/rcutorture/bin/kvm.sh |  4 +++
> .../selftests/rcutorture/bin/torture.sh       | 26 ++++++++++++++++++-
> 2 files changed, 29 insertions(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
>index 32c319997638..2f386cf536e3 100755
>--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
>+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
>@@ -98,6 +98,7 @@ usage () {
> 
> while test $# -gt 0
> do
>+	echo Argument: :$1:
> 	case "$1" in
> 	--allcpus)
> 		cpus=$TORTURE_ALLOTED_CPUS
>@@ -271,6 +272,9 @@ do
> 	--trust-make)
> 		TORTURE_TRUST_MAKE="y"
> 		;;
>+	"")
>+		# torture.sh can pass empty arguments.  Ignore them.
>+		;;
> 	*)
> 		echo Unknown argument $1
> 		usage
>diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
>index f0083891ee81..2824dab14d41 100755
>--- a/tools/testing/selftests/rcutorture/bin/torture.sh
>+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
>@@ -43,6 +43,7 @@ fi
> configs_rcutorture=
> configs_locktorture=
> configs_scftorture=
>+configs_hazptr=
> kcsan_kmake_args=
> 
> # Default compression, duration, and apportionment.
>@@ -69,6 +70,7 @@ do_rt=yes
> do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n
> auto-avoided
> do_srcu_lockdep=yes
> do_rcu_rust=no
>+do_hazptr=yes
> 
> # doyesno - Helper function for yes/no arguments
> function doyesno () {
>@@ -89,6 +91,7 @@ usage () {
> 	echo "       --do-all"
> 	echo "       --do-allmodconfig / --do-no-allmodconfig / --no-allmodconfig"
> 	echo "       --do-clocksourcewd / --do-no-clocksourcewd / --no-clocksourcewd"
>+	echo "       --do-hazptr / --do-no-hazptr / --no-hazptr"
> 	echo "       --do-kasan / --do-no-kasan / --no-kasan"
> 	echo "       --do-kcsan / --do-no-kcsan / --no-kcsan"
> 	echo "       --do-kvfree / --do-no-kvfree / --no-kvfree"
>@@ -117,6 +120,11 @@ do
> 		compress_concurrency=$2
> 		shift
> 		;;
>+	--config-hazptr|--configs-hazptr)
>+		checkarg --configs-hazptr "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
>+		configs_hazptr="$configs_hazptr $2"
>+		shift
>+		;;
> 	--config-rcutorture|--configs-rcutorture)
> 		checkarg --configs-rcutorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
> 		configs_rcutorture="$configs_rcutorture $2"
>@@ -147,6 +155,7 @@ do
> 		do_kasan=yes
> 		do_kcsan=yes
> 		do_clocksourcewd="${ifnotaarch64}"
>+		do_hazptr=yes
> 		do_srcu_lockdep=yes
> 		;;
> 	--do-allmodconfig|--do-no-allmodconfig|--no-allmodconfig)
>@@ -155,6 +164,9 @@ do
> 	--do-clocksourcewd|--do-no-clocksourcewd|--no-clocksourcewd)
> 		do_clocksourcewd=`doyesno "$1" --do-clocksourcewd`
> 		;;
>+	--do-hazptr|--do-no-hazptr|--no-hazptr)
>+		do_hazptr=`doyesno "$1" --do-hazptr`
>+		;;
> 	--do-kasan|--do-no-kasan|--no-kasan)
> 		do_kasan=`doyesno "$1" --do-kasan`
> 		;;
>@@ -182,6 +194,7 @@ do
> 		do_kasan=no
> 		do_kcsan=no
> 		do_clocksourcewd=no
>+		do_hazptr=no
> 		do_srcu_lockdep=no
> 		;;
> 	--do-normal|--do-norm|--do-no-normal|--do-no-norm|--no-normal|--no-norm)
>@@ -343,7 +356,7 @@ function torture_one {
> 		boottag="--bootargs"
> 		cur_bootargs="$torture_bootargs"
> 	fi
>-	"$@" $boottag "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
>+	"$@" "${boottag}" "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
> 	retcode=$?
> 	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
> 	if test -z "$resdir"
>@@ -704,6 +717,17 @@ then
> 	fi
> fi
> 
>+# Calculate hazptr defaults and apportion time
>+if test -z "$configs_hazptr"
>+then
>+	configs_hazptr=CFLIST
>+fi
>+if test "$do_hazptr" = "yes"
>+then
>+	torture_bootargs=""
>+	torture_set "hazptr" tools/testing/selftests/rcutorture/bin/kvm.sh --torture hazptr --allcpus --duration "$duration_rcutorture" --configs "$configs_hazptr" --trust-make
>+fi
>+
> echo " --- " $scriptname $args
> echo " --- " Done `date` | tee -a $T/log
> ret=0
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
