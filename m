Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811551;
	b=fEafVuksh8pZymbOGAZQM3VU6HNKkUHJa/dPydt0LR6vsfBRkcZ8uJa48Bcitydnv2qd
	 6lDJcZoA3m/pcpUL2ei6WdYR0iEwHcVQnvvmSovZ3wbu2LC7n9ETivtKzSZTOT1CZwvle
	 imELct7iH2H7veX/KpTF7ROjm+1cmqNcEJcArXSU49dIgRBbvvCAxucsKKdcWfCdFgGkw
	 7z6nOrA4hzd5noRaBJyefLUdu9dJQAFnr6FXXJ8/MOBEYl1A392IsDfg5Sfo4E5r00KKf
	 A/auHvqQFFNojKcj1rEG9VjKqllOUnsP3jJ5jpfCTvMMqqdlYomu5l686SiBkeolcPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/LC+6R33q10vqghO7crsZlwQEV9fByooirEbdHEQuEw=;
	b=GJCoBclxRoS1MQewmNGdmnQiSnQUQWbaYDJWGKsaDOiTfSjDAdfCkV5sctndczLFi7VQ
	 TvcvKfDr1X55N6wm8Kz+0lLW+6XrfLMiLQQkeOEQEbxqicJNu1X22BlKBxU1pxVaZVZdX
	 GTOztrLl+IZh+kUIpAXDFfskerqGt1rm/Wx8NgigykSDLRWC1arkUtdZDo2Dc1WSvDRuo
	 JhVqFxSn7cMA+KX1v3vd2elTwiXCl7E4ISHKqUbrVeVP0Y8m4UZv5I+rZmL0pQb1PDqoW
	 Lu9DXBC8ObwIYMzRMghVs2E5j/Bm9+X0DViKi2zj65BVKnCr83aOdiUvgHf7FUNVRqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y31TZXeY;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B30606D807
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B30606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y31TZXeY
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so1603309eec.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811550; x=1794416350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/LC+6R33q10vqghO7crsZlwQEV9fByooirEbdHEQuEw=;
        b=Y31TZXeYrMNub6CD2yl7wXzZNwbZWHH3eZPG51i7cMvXQr32hmTchJqFckujdmLaR8
         jO2Ybm5+xBQyyCmBfBHUjRxLSITYvm9VfhBZYZctszoMyWT4bemxe4sss/bovxPT2dJs
         k+J4IpNPEe0CddeXVyA/Y7b552MrHB98y/tpmtR8JuVo0QGTEi8v62P+yHXrxe8Qf5FA
         77OjQ6RMgvgZGAeX6Z8tBsU8YO6c7QSqAvOBWbc/pFX2uzgT01/mTcE/PcARiYWsSBj7
         CUZYZ7MlzON05EWeaepGCCOYVGQQlBPbEz6X6AJW+QtO6e0nH21GIU5VM6lSbedpHUeR
         fmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811550; x=1794416350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/LC+6R33q10vqghO7crsZlwQEV9fByooirEbdHEQuEw=;
        b=VQteZeHpY9Jd8FDNgIOhj+Yw88PZZDn728aZq9ICovyLR4BSkJ0gAY5gPZfRoFb8Z9
         QT3+fBJDtZkFCjejB0TaCH37NLpWE94/R+kjIhK7ESyX+R5OOK+SyzOVZwVWy9NFHKMt
         LGJeehk8ApI5QK0GvF21yeFD/IDC0bUaTpDL3ywU9IWemAoUjWr2mWgl63guqiq+Pk1U
         3rM11jcaGOTBd+/neyK3MdK9tv4/NVykeGIpa8FAmXrn1815+AZRi/coP3NJ5cJjnowE
         KnWOxHJhmdNnd1BWjMZ3hhdc4hozmrmJKQkzPMDam1w73H+mCgIYPup2TmGtdHHenO+2
         MXUw==
X-Forwarded-Encrypted: i=1; AKwUvByZyWaCdB0B67wca37X6z74AytAiPw0Ig46Oa31ewmnxV7S4NhLvN4Y2GKRrE09PAmB7dM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1fLjHEhGqTJpwMf7sv2EZYk/FeGBzegGE52fVfeZUDf8zryFW
	MrprnWsNIpoEXurMoFChNnPIoDFMn6vEiGR6zAaY1GUD0cE8yz+7QV9n
X-Gm-Gg: AYBFou2TyFTEZ3cHRlAcOSXoyw7Ayeopx2JxGFbuMCmXcM9jkbzSaZvsKU44KEh2nF+
	aGIOZ6vZ1xAgR6HS3ZDANiMbSMqr2gu/xM7jlf+Ee9aCf6DBUFYE7TWu+ehIBgmXz2JsoPKqAkW
	Rc23c/K33uHaRy9YfceYed+wl6lNAKrysOxeD1ygSA8Cburwen5vE61aqchHesN0BKRsznXFTx+
	lr9DBhhx54bNZn7TWYSe5LmNlzB9nJ2PgL5N/Pp++urXacbQ6k1kWGwpv4K94wzQQZTCbnhgNN9
	+66ep9YNR1a7gXGzh+XkACg08U4O2mtP4zJiaFCCfMIwUzkvV+637me8OaF750ZBmLDM960hDqT
	aMlDrJ7Y++Lag7gkx+lNBrVzd3dRrA1HXphQoQrXTE5WQyjpqPU34DwtVTJzLBzJIEDsoHYKaAW
	g19YefFxB3qmYLeaCIlGGzLR+11nPZ3tGFC06y85pdbnT7vW8MnlRZApBvyoc4p6caJZ/yoDOPI
	1t9VqNObuPd7rajOFr3WS7QvGC6+c6qL7YWl9TPngchGhUyiBY8mknIsl02IyHz8hKgMFXQUe1G
	FY9jzKQsNS4mFYPMPXDkhCN74SRLZVpocq6+oN4=
X-Received: by 2002:a05:693c:8945:20b0:36a:2999:ea9b with SMTP id 5a478bee46e88-36a423c346fmr24991222eec.23.1793811549996;
        Wed, 04 Nov 2026 08:59:09 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:09 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 25/28] hazptr: Select TRACING for HAZPTR_TORTURE_TEST to enable tracepoint
Date: Thu,  5 Nov 2026 00:54:43 +0800
Message-ID: <20261104165504.2430480-26-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
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

The hazptr torture test registers the hazptr_waiter_enqueue
tracepoint for its hot-address scenario; select TRACING so
that the register_trace_*() API is available.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/Kconfig.debug | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index b500e96ea1c1..8fc6434a05d1 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -27,6 +27,7 @@ config RCU_SCALE_TEST
 	tristate "performance tests for RCU"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
+	select TRACING
 	default n
 	help
 	  This option provides a kernel module that runs performance
@@ -42,6 +43,7 @@ config RCU_TORTURE_TEST
 	tristate "torture tests for RCU"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
+	select TRACING
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
@@ -102,6 +104,7 @@ config RCU_REF_SCALE_TEST
 	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
+	select TRACING
 	default n
 	help
 	  This option provides a kernel module that runs performance tests
@@ -117,6 +120,7 @@ config HAZPTR_TORTURE_TEST
 	tristate "Torture tests for hazard pointers"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
+	select TRACING
 	default n
 	help
 	  This option provides in-kernel hazard-pointer stress tests.
-- 
2.43.0

