Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C91D7E4B
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683938; cv=none; b=p7j7m6ij3DYOhYh0kUFK5YxaNg3KcrcSCGh0aifXD87WdD5mgIszEeghO+LtNsmJwZ6GX2pvxnVf3C1wKO7zk3jBqAoq+kmF227KS2XgBik5F1EFdPTN3EkOvHhUpaW6K4O2zDJ243aThFVuZ6s9NMpBCirkiSZk3SoQteVY1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683938; c=relaxed/simple;
	bh=OuvN4hSJXio2PoJiej9Y5bVI4DH3N1EbznQzh95Pj9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/oNBsx+IInSE+yWIVAGGx+2lOx5q/bWMqgGRwIE0VjvgtQkj7o0VGMxmd/SCjRK4WfAXLTEdZkczc9LlPLUbA6/cTcVsYR6AI0i1zwZYoT2mMwk4WS25b8NfB7rCfTAYl9f59PTYZNBMDWistMB4d73Jiqr0pwgzTPqiOrBUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=p9sJ16iP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p9sJ16iP"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6f0afda3fso73761985a.2
        for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 17:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737683936; x=1738288736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+QF5oSbZcs+JbJsvoCUbafjxE54u1Cr2sHAMeNdyY0=;
        b=p9sJ16iPpGjmXQzZZTBy6IXvDnvihbEf5W3TycdIx+HB+x8xYDfrsA14Jom8Co5Qye
         orhK+xwH8+i54VVjj1HuGFtetmd2P6fqdEU9WBrFz2BldUS4xGnDnON0/2q49kUlOSJc
         eCpsJkXXfzkAfdPp9oAocY5JIcsEjnTULcyzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683936; x=1738288736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+QF5oSbZcs+JbJsvoCUbafjxE54u1Cr2sHAMeNdyY0=;
        b=Evfyy4YDg4Yag1sErSdhzLfgNc55DTtJ3qIAE06Gubew0BSe5Ik6hk3XUyDhX4KWWE
         VBN+9JABS003eCAbUoST+B7C13NHWLnoYForRaP5LiAofp1nugUId0Em28Cn1uQPDmvX
         Upf7NmfA/D/9YHyb6vLWaih3QRqUaru5q1xWFqe0ksHKGn7ZbVj5Z66GJKLbNpSPb16M
         PmSzQk+i71fFQ9aA84lxBRMrKu/UrOuIF3hhVhVMp6CHRtgKzuE0H80e/rJAtV7nPYeu
         QR53qGBNHPO39U7NVyVNHem5ECf+2EZWvMTDopJLOVX2zp6qtkNLW/rivdxO7ZrcR9hj
         HE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXnimdmSFvI7WpQq8tBaIW60tjBk7k0++mNyjjCZKxGBGxWCGRgNcW006gTgS31VrNp2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hu+YMSwBDwDWMmqrMFmUpOVKMXdKnDcfWnHL2R/boCrfc8CF
	Nwp+TcmYKxtlKOXzU9lpzoia+NxS7J1/hIRyqM+y85Nbh0qE4/vMNlQ/gepGo4c=
X-Gm-Gg: ASbGnctqvhPiFZZdIMooEV8vtNb2MQ7IOtwV63cOTpOO1JboyLKdxijbC2dZuhdWeWj
	ghnkQPVljtUQ0TgJ6wDYo24riHt2QgiGmj7ai+qd4JbJdb7rkVUa6rx2F00AQtIcnNfuLEnQ6kJ
	QOuPdAmxewWMqPTBRrEhKZgAl83qzvWg7UCX5REYQWRm2b2/A6WKkQ1lYzijBV6KWoX950WvkhZ
	umtiBMUXloxVqFJ6uZwpst2zUewl4uYD87t4dlbdA9lj3iHNNouSSV7SmeeWIbMynkaQMGoDFvb
	60IiF05efUCfgB6ncSU3A4tcRWYyx9yfQWhkQSlQRiVcjzk=
X-Google-Smtp-Source: AGHT+IH36P6Jv8uzjmbePn9/vGkZZmN7+mVBRG1wMuKKi1ngiL7zOS7+fOI/X1b/u1OyY3fqtN5Vkw==
X-Received: by 2002:a05:620a:1a02:b0:7b6:6a76:3a44 with SMTP id af79cd13be357-7be631f2fe6mr3884618085a.17.1737683936019;
        Thu, 23 Jan 2025 17:58:56 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a5fbsm44741985a.31.2025.01.23.17.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:58:55 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 5/5] rcutorture: kvm: Invoke stress-ng building it if necessary
Date: Thu, 23 Jan 2025 20:58:36 -0500
Message-Id: <20250124015836.732086-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124015836.732086-1-joel@joelfernandes.org>
References: <20250124015836.732086-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invoke stress-ng from init using new --stress-ng and optional
--stress-ng-args. Default --stress-ng-args are used if none are
provided. Not passing --stress-ng does not change the behavior of kvm.sh
from before.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 4766c3023fed..d35496247ee6 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -42,13 +42,15 @@ TORTURE_JITTER_STOP=""
 TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
+TORTURE_MOD=rcutorture
 TORTURE_NO_AFFINITY=""
 TORTURE_QEMU_MEM=512
 torture_qemu_mem_default=1
 TORTURE_REMOTE=
 TORTURE_SHUTDOWN_GRACE=180
+TORTURE_STRESS_NG=
+TORTURE_STRESS_NG_DEFAULT_ARGS="--cpu 1 --cpu-method matrixprod --cpu-ops 1000000 --perf -t 5"
 TORTURE_SUITE=rcu
-TORTURE_MOD=rcutorture
 TORTURE_TRUST_MAKE=""
 debuginfo="CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y"
 resdir=""
@@ -90,6 +92,8 @@ usage () {
 	echo "       --remote"
 	echo "       --results absolute-pathname"
 	echo "       --shutdown-grace seconds"
+	echo "       --stress-ng"
+	echo "       --stress-ng-args \"stress-ng arguments\""
 	echo "       --torture lock|rcu|rcuscale|refscale|scf|X*"
 	echo "       --trust-make"
 	exit 1
@@ -251,6 +255,14 @@ do
 		TORTURE_SHUTDOWN_GRACE=$2
 		shift
 		;;
+	--stress-ng)
+		TORTURE_STRESS_NG=1
+		;;
+	--stress-ng-args)
+		checkarg --stress-ng-args "(stress-ng arguments)" "$#" "$2" '.*' '^error'
+		TORTURE_STRESS_NG_DEFAULT_ARGS="$2"
+		shift
+		;;
 	--torture)
 		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuscale\|refscale\|scf\|X.*\)$' '^--'
 		TORTURE_SUITE=$2
@@ -275,9 +287,27 @@ do
 	shift
 done
 
-if test -z "$dryrun" && test -n "$TORTURE_INITRD" && !tools/testing/selftests/rcutorture/bin/mkinitrd.sh
-	echo No initrd and unable to create one, aborting test >&2
-	exit 1
+if test -n "$TORTURE_STRESS_NG"
+then
+	if ! "$RCUTORTURE/bin/mkstress-ng.sh"
+	then
+		echo "Failed to build stress-ng, aborting test" >&2
+		exit 1
+	fi
+fi
+
+if test -z "$dryrun" && test -n "$TORTURE_INITRD"
+then
+	stress_args=""
+	if test -n "$TORTURE_STRESS_NG"
+	then
+		stress_args="stress-ng $TORTURE_STRESS_NG_DEFAULT_ARGS"
+	fi
+	if ! "$RCUTORTURE/bin/mkinitrd.sh" $stress_args
+	then
+		echo "No initrd and unable to create one, aborting test" >&2
+		exit 1
+	fi
 fi
 
 CONFIGFRAG=${RCUTORTURE}/configs/${TORTURE_SUITE}; export CONFIGFRAG
-- 
2.34.1

