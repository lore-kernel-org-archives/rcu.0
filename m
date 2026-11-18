Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991966;
	b=wdS2n13x9nbflpAtpdTNgTMntiOoPYpnHWVtVwZyuOAsZVX7EAMaw+ekRDBpVb2p0nVJ
	 i2BKTVvexMIpRIS2CABofrIaCeD24udFSYxCG+X1lxE7yE8+fmPFv+n0MUYzkAsMFWPG5
	 eEvl17ASnuTh/UIxrYb0VY8r4jc53rUkq8Hh+ACnt6goMxFeNKndzxKRie3IjxCY7e0+2
	 WEIy7axQmhyqLcgQUREZNI8A3F986sDhzQarrPFbTDBkiXBtvlLrFvGpK/9sR4mx5ppzT
	 SxR8FynwtUoOKLQyKhWxfDjVXUb1Oais/L1mAdHZfUWGPaWiyziHePxzgFwGzFDBZBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=krPi16xH6tVaY+e08Z0j1ze4+4KgT2K6/rWPsZWSlTs=;
	b=xg7Usbv3OezXiLPYvUA6koi4+3l7DgCWfFoezqVkMM5Mt9uoxOJ+3iFkyhtMZNJLhe0i
	 OZ89dKBnqDKWJDHvqaT2rzkosXcqGeawtUBOFFxOCj7gkjpJHx511cdR7bOaw1ie139yk
	 wO71u5jgkhlr98sc4zAFSkOIfZcNjWzLw06jVhDGWfnzcr7Z444St6HMqGxUHPbmMZIlx
	 +aF6aFMeXuQnibyIbtpTCzmEBpLQGDLw2hiio5cxjyyZjv2nOeF2qlGhN9rIGhSKQrbmw
	 8beDafTLhfQqGHskds3hunYztG6IV+GlQL0hAY/vLtAXxfd6amRHbe1spbIXHA+3SDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojxSF7kt;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9B606A32C
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 08:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC9B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojxSF7kt
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1373795a12.0
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 00:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991965; x=1795596765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=krPi16xH6tVaY+e08Z0j1ze4+4KgT2K6/rWPsZWSlTs=;
        b=ojxSF7ktJz0O2YGuDQ3cs5y69A5HDP2xRJJBh0tCTHJl7koP5e+/z6heBh5Ouzyn7L
         mybD4zSZu9vokM6aFlkwDMsPH5cZPbBJ0r5CbVhzFxeEbocmNhnzpgKglfmREs5+cVqR
         heyoxL/kyaH/3gR4wWc+J4zCkwgsQph/+rAHvks6PHjZ4mdaItTyTHztlaNHGjyas6XG
         AfWvEoRjKcCaB7PPPaxdCOixMm5stSaxmTwGGjCkCEYX5YIDYfgiuGeHqxYxEbTRn3kZ
         7r7h8lXLv2Hzi7Z15Yy97ut8FQ7uCjyU8y9Gk778cfs6LJTJCb7/AU2Y/VH6MQlZ1pU4
         T/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991965; x=1795596765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=krPi16xH6tVaY+e08Z0j1ze4+4KgT2K6/rWPsZWSlTs=;
        b=0bKExIlwT8Ua2PAjA39aTki6bBJEUzOjhyKX/O8t8opnv1Ip3jd2RgCXQC89ihdsOn
         lYTn/w78nG/ffXe87STTDVcoctsrfvY7zgqTSN9gMeo97lTiEUOvB23Uoas40lTO22bg
         NzAlTPJp8M9nCP+zeeL55amZ+nVWLFAVh8h1bhPbI5QspJwFlneI8coTZ4mM+sO4NUCo
         /7NXfrfSQFoAGkeAaz9eFSz8JPTqCqUYdhcbpCs5kUggnk2aRj+sc/emmKIaZOWzMnhL
         qd1Ad86rop3Zo9eoYY2UVO27NUiZfvaESvRMxfRNC4J4wwaGX+IFOd1tyR7ZkxMYavnO
         LiPg==
X-Forwarded-Encrypted: i=1; AL+hErGIC7tBLC9oZbwlYIRyFg7RzXRptsgcAVXNChgCB4sdMEh9aD9HXw5GKDwJaWYvBtJGZg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wJ03uwbxhQQy/HbciwikZOFu45BukzxtexA3bDFrlGaUuf2hR
	hm5/+RAWmeoZM6DNwbo0Lf7FSNJhDmuOTEP4v26oYZO+pZx/31ZX5dgi
X-Gm-Gg: AYBFou1/nJIlOd78QSli/uMYT/3jjK39yafFhmpDA3D/GF7mPu1YTflZ0Pw3mA4lkM0
	zjsRfE6Yt18M/+vvSqsIEnGqjqHXSKz6wfW4ifnCK4ALJMCVsn96XddOyODlKEtNgWzyQDxmzhX
	X9TMKeU2XwvSLuwNgWBDyGpiqkMKJfHYmzBdANQhvKUJbW4UMY4FSL0RHXZhiLvtpqCoM8PfM12
	L/sGAurLgJF5kglEEoFgk2skmq2vT8jvbkpQ8yUQ9edwHscRP3xIVJoxEjxhON6/rBGBCMOU6Jf
	udfoNf7zbr1n+QoR1p0XckRC6T1GiHC8ieoTgt5eBM2h56gwxbfOkuHuDLkclmlhiBGeBEiaoaQ
	ah4LOFuHH8D/yMBpRfpqCDEd53IaYXNMDze7AvzZvAgzgaEKmze1ZMu53t2cASMclNZh2SMaT0b
	tqkfLYgoP8uF84qBP6o/YLfl2vFuLjMCQuFst1dk0oCVruIYMr5fjguUewilgiDGqWBAqGBjVar
	wh4D4M0eagyT0qr7150WxImoniGANT71hlsnxrK6PFssllpOiYVt1WN2+YX100FKgApaX5rNbyz
	pbEoiHPRJqTnIdVlrT2RYBMCvk5nTvyUhNVU
X-Received: by 2002:a17:907:7b93:b0:c46:a5bb:5740 with SMTP id a640c23a62f3a-c510deb706emr164817466b.5.1794991964090;
        Wed, 18 Nov 2026 00:52:44 -0800 (PST)
Received: from kernel.. ([191.40.25.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm71077266b.10.2026.11.18.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:52:43 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2 7/7] rcutorture: Run KASAN aux-stack checks from torture.sh
Date: Wed, 18 Nov 2026 16:51:47 +0800
Message-ID: <20261118085147.1668598-8-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118085147.1668598-1-kunwu.chan@gmail.com>
References: <20261118085147.1668598-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invoke kasan-aux.sh when torture.sh has both RCU-torture and KASAN
testing enabled, reusing the existing --do-kasan switch, the
torture_one bookkeeping, and the --configs-rcutorture scenario
selection, so the added kernel builds scale with that selection.
--no-kasan disables both ordinary KASAN and aux-stack testing.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 Documentation/RCU/torture.rst                     | 14 ++++++++++++++
 tools/testing/selftests/rcutorture/bin/torture.sh |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index 15a430f5111f4..8c8dcf6449bf0 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -244,6 +244,20 @@ As with the intentional warnings tested by ``srcu_lockdep.sh``, ordinary
 diagnostic; use the dedicated check to distinguish the expected report
 from failures.
 
+``torture.sh`` includes these dedicated runs when both RCU torture and
+KASAN testing are enabled, as they are by default, using the scenarios
+selected by ``--configs-rcutorture`` and 30-second run durations.
+``--no-kasan`` disables both ordinary KASAN and auxiliary-stack testing.
+For example::
+
+	tools/testing/selftests/rcutorture/bin/torture.sh \
+		--do-none --do-rcutorture --do-kasan \
+		--configs-rcutorture TREE03 --duration 2
+
+This runs ordinary KASAN torture with TREE03, followed by the dedicated
+auxiliary-stack verification of TREE03.  To run only the auxiliary
+checks, invoke ``kasan-aux.sh`` directly.
+
 Kernel boot arguments can also be supplied, for example, to control
 rcutorture's module parameters.  For example, to test a change to RCU's
 CPU stall-warning code, use "--bootargs 'rcutorture.stall_cpu=30'".
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 90b5e113a0b03..e04ed2c27f533 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -515,6 +515,15 @@ if test "$do_rcutorture" = "yes"
 then
 	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
 	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "$configs_rcutorture" --trust-make
+
+	# Check intentional reports separately from the ordinary KASAN bug hunts.
+	# kasan-aux.sh supplies its own boot arguments and rejects --bootargs.
+	if test "$do_kasan" = "yes"
+	then
+		torture_bootargs=""
+		curflavor=rcu-aux-kasan
+		torture_one tools/testing/selftests/rcutorture/bin/kasan-aux.sh --configs "$configs_rcutorture"
+	fi
 fi
 
 # Test atomic SRCU across Tree SRCU (SRCU-N and SRCU-P) and Tiny SRCU
-- 
2.43.0

