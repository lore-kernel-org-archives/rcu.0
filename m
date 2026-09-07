Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51354427F8F
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767944; cv=none; b=sxGYJjjeCVaWnD9E8wRr7pvY0jl/YDzOneHwytvRNyGnMFzghXhxSXD5aWNeKc1ZK/S9LVBoMprMS+IPUcREm5ragERjMLR1KdAQhF3iVB6pYOqHi5sFtgfx7ZokQYjWhMUaR9xTAnz/SWUgLu6oSwAElF4c3zCGemk+bkmf3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767944; c=relaxed/simple;
	bh=YCbEy7LvZ4zvg5lCpybvZOkKAZyBBdYj0Er77Bwz/GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIbcqogUL7OI34Nl512PWBl4ieGs9E+U4dKCEGdm1BnkeNAUC9+BageNzmH8hrAyx1B+/ymfNYyuqsq2BnBWwMZinJj3sBxJkTG5Sc96TanHgz74uL7tECpp5UtYfmvWBW6KQJPS9vpgbaXeAKzgNWddTs47DSiBGQpTwJ32vDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMfJaW3x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMfJaW3x"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceab75934dso31008495ad.2
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767938; x=1789372738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWQbirqnoJrko/xoiAbUUJU+D4b2sHL+OPlLYee7Yc4=;
        b=YMfJaW3xPWojgT0rx1bnlGosexhl8K0YxO0WFAi+mOEfpFNqcE2XD0SD7bH/uJVUtj
         StEuviRmP9ZGCgzO/0qtOtY/k6yqgS60GFyShfHRi1y6fn9sYchxWSpVddkXbqqC/rLQ
         ta0fM03WCSya4glJTHaSQhfH+VUgRQ+n/1bgLwe4gUkatk1tQ+xpy5o5Ij5yGEbw4E1F
         yxLMnice7htvdOwbiNEcdrOyj+Ij+kRwX+U5bkUmvu+nRE+xF4JZ6vWtyQXMUr40HexE
         RJxNIV2XTn5PWTGCVJM+3slxy9TGFLe3PZytYBrpSzFsuD4rFpHpwlmWnClgs3a0ODms
         +UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767938; x=1789372738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWQbirqnoJrko/xoiAbUUJU+D4b2sHL+OPlLYee7Yc4=;
        b=D6aDGxSuk2mfnHCyVVzMNa65Yw1Jo8SrcrK8c2fXefZx9HZB4JaNooOhzEyDSzyMe9
         no8hrOQFPO8fJg7m8h87z1vcjGOc2ovVuo0+5IUZYU4XLJ+Ec/fAbTWYXMnCTRIc3b4X
         gr16Ht2pB0NWgiJTIdkyYeroov73FKn+jIA9qGsY7CBUAw9/SyCB+uU3YIyA5dkiT8v/
         /XJZZx9Hm1aDd8bRAAAvVX9utLdOXP9ngctpZuJmdkzzVBC0p8b8xktzQu2fJ9PyTTdp
         goY4ElbeXtQ5E/VCH45XnuIVHQ3B1XpXav8rgtrxJqcKiBS3xwAI4fPrMe7esu/KYnmL
         cqQw==
X-Forwarded-Encrypted: i=1; AKwUvByPrRJJJVB0Bor6CjKxtKK7OhZWNCJa0IA3ORFPhUOGPVJiL090HN9UVuidFRjh7ZZtnaI=@vger.kernel.org
X-Gm-Message-State: AFuF++n8PR/Uk8NN1/hod5FLgpJxBnN5ByXRzg7mPL6MixSwR8+MbIeZ
	1THX/1h9yXqBNO+/xr/5O0QvUIqGvcHJg4BhMlgI35Qgc+l6TaUMG0zX+B+EqIknBIQ=
X-Gm-Gg: AYBFou3pzHiW6qMA/FicFa6FekcCSXOh7uO+VZXlbb8uPh8Qf7XiN0MAcqR9djS4CdT
	Cg8rKlavUEzU9ZQf4xcqpbUK+Jz/cN78KOhN8Kpv1RzdD9lafW79pyD5sAmAAnJPOSgxUDmYl57
	TXqehU4mqQJXx+zDSeUPznn3QRuHmC/ClE0jwqyTCfNWQGa5WIFO+oUMWDhtas9HQX7XDBJ9WDx
	39mgE/xKJulJsM3ay5BvfHvwPqhRYxnGvLE8Q8SBs61Q3HS+WaNpteBB3a9kvaFuFJ/HqnJNE3K
	BZHUBQICZQpX1NlbeBz36Inh1Db00eWu1LNoJ+uWlfI56Pr6WPl8yScpCDJm8z0oJUsYPDYyn3+
	4g1qxWMYkU8ccUk16Jej7uVVTuM5vXKqL4sWMlayslIwg23eE55ikENjWjNCYF09gqt67J1BP7y
	eNWnliQTuehasXY45hwba28OZ1VVghl8wfHG62MVHdtcqPMCW4/GPKGIT/AaC+nV+pEdgBVQCZ0
	QStsK0=
X-Received: by 2002:a17:903:13c8:b0:2db:56da:6a0e with SMTP id d9443c01a7336-2db56da6ea1mr65563755ad.9.1788767937845;
        Mon, 07 Sep 2026 00:58:57 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:58:57 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 04/13] rcutorture: Add atomic-SRCU support to torture.sh
Date: Mon,  7 Sep 2026 15:58:20 +0800
Message-ID: <20260907075829.2073224-5-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907075829.2073224-1-kunwu.chan@linux.dev>
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
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

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../selftests/rcutorture/bin/torture.sh       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index f0083891ee81..8885812d866a 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -68,6 +68,7 @@ do_clocksourcewd="${ifnotaarch64}"
 do_rt=yes
 do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n auto-avoided
 do_srcu_lockdep=yes
+do_atomic_srcu=no
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
2.43.0

