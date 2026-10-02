Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBB4E01E2
	for <rcu@vger.kernel.org>; Fri,  2 Oct 2026 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961006; cv=none; b=Wi8kqBZi7vmWf6h2jsBqZip6IjGIWCzh8e0km3IIC88tPbVbuoxf9pOTQJoAXgSy7UcKFLVxnc8ID5DIAgq67LvsNUxZ8Td5MgFlYYxY+sZwfvZ2gu7tMDvG2PL5v3Gzps0rc+m2SIB6G4OzxADi7OUjcpwv0W63tPxnPYE4VMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961006; c=relaxed/simple;
	bh=9wEbN2n5LQFaWEnfgc/fjcdj12CgL82mEepIN/jxNKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAlmhceu3OWHrP0LvTKG7IjCIwvxnXVORJ7Q6YQ35XyyQvKE3BlxsB5QJpQSPCgVgEe/IU4tqX4HYAUjc2d0hfgXDeWA/ia64pSxeeiwyDS2JDyjlSj/I4ep097q1ingyKMf3wQxa1IzH3USBAZ3uBPmUHNgVDUEzQQoqlwggpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dalPDMRq; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dalPDMRq"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so111679a91.2
        for <rcu@vger.kernel.org>; Fri, 02 Oct 2026 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960998; x=1791565798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InVY38nfxVAqb/WmgYkdpIBcCwx01OQ8UJwYgwWPio4=;
        b=dalPDMRqF/pTMZKC7gM+vbuuHhe+AzE9gT3Z6UtI20aEydFwMb2S3ppM8uHDc4kq67
         H/5HHerSCV+pGQ6iNfXLUDLrmLvI9zQHbE+D8F14nVDrMeZZ76mjeF4RYasyIGFuyHjc
         bJZ1eRwSeTr09fQyXxUTfGaW9GEcX6NrqQb7BXe9o/VWo1heh6veKHTWuc+bb6y1XWeT
         7ieFI9GptxE5VYBmWMT3+gdABLWqRDSPcE3jmT4m/e1sxCTm8dgYz59rAb3+fi01bSTh
         4/1sIBX8Mogz+e84NsEJZy107IZm5s5lIh0jrd5wCH0gpKTXZ4JHAut6q0afhEaOaJdZ
         +ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960998; x=1791565798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InVY38nfxVAqb/WmgYkdpIBcCwx01OQ8UJwYgwWPio4=;
        b=PlTK+hnTnEFsv3/I+6Q1eTRGui6QOTP03XSI4dTnq20mfcYAgSfXFTcTeSVMamyVAa
         YA/6Xz+JDbBHGFayr3fdHFQe+bgV33lKp4MsBs/2cjnSWCODT8d3ewc77tWxDhJLRCcA
         y/cTJxH19GJ3X8zPZsnClse8hNfDQrtyQ5lt9w4A30SE8tQBGDxBgqkcmtPkTYyJYuZA
         yaMDOxa0X5FNKlBoH1c1WFjOjQCfat/QNWoUbxDAqMwaC87JsLXLdbR6YMrGk6RMvWXh
         Y4gFKUQbnui4FanvXoZUQ1fpbddYcfi+qklO/3ZfewsHCJhCeA3OsLp/6GyJh+PObnRc
         lc5g==
X-Forwarded-Encrypted: i=1; AKwUvBxy0EdUveBh1DiN3354ffJdBk/dg1ir4Kab1NDng4+OJP3ndAOWAgn5wbMcCzvxeaVxdUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9ElnGsMG0w25jp8YvO6OCjnz7lHTEhaNU/KRHskBsete0pymk
	DatT90Tp2thidcSI2+rbbZCQFLSf/SJMHkOyPGls6esI0LA/nCwmWXPJ
X-Gm-Gg: AYBFou2Gsqq4c4bsn4f2Q/KShiQuW+TSR5GlIjkB+B4ya5va+UuZnSLrfEGUsQ+q5tE
	rtLKRxy+KtVgXmYY11tzpi1DWy6ByxzxPPfCRhivSq4PRkSkRrEsGnzcf8qpyzXEf5Cnf+Xqd7J
	f4+UTsbijrF5m+ycTIB37eaeM0CAxvl41rp0XaXSbv4CO67vEDJoBVl5qqZbFxJmo0ZUxVznKI/
	7mPY/9/U9uL4Rd3/IEHyS4q4K5Vxrn145YlLNNT0vZWwyy6GILbevUzF4r9ymZZpowfgwzpgCbr
	Kpr7EA2WrCoccpUDEuHt2KVFGEBg01Enb7SEhn6d6RFTTkDeRo7HppNOPw+wElpbuTzJPFJSOnK
	5x5bmXH7EcGxSSucstzDkyxk2Ha0Pevojw3AsT+o7JY49eTUgh9Uqw7KXUfQysrYDv/nuUT51kv
	Nw11UdM2AY7srFPJuWwpV51l4kwnVZPt1VEcr23emz3DvfXyt0cZALFuyGaYQEsA4vUxFU8aFSO
	ubl/n2RqmLcvOn9+g==
X-Received: by 2002:a17:90b:39ac:b0:3a4:a7eb:1da7 with SMTP id 98e67ed59e1d1-3a6ce7f8bcbmr2920094a91.42.1790960997498;
        Fri, 02 Oct 2026 10:09:57 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:09:57 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
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
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v2 05/15] hazptr: add debug option to force the acquire slow path
Date: Sat,  3 Oct 2026 01:08:37 +0800
Message-ID: <20261002170847.3653663-6-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002170847.3653663-1-kunwu.chan@gmail.com>
References: <20261002170847.3653663-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debug option that makes hazptr_acquire() always enter
__hazptr_acquire(), even when a per-CPU slot is available.

This allows the slow path, including its lock acquisition, to be
exercised by lockdep-heavy workloads.  It also lets hazptrtorture
exercise the slow path without requiring the per-CPU slots to be
exhausted.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/hazptr.h   |  3 ++-
 kernel/rcu/Kconfig.debug | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 275cbe54b075..4ee02d23abc9 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -245,7 +245,8 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	ctx->acquire_cpu = smp_processor_id();
 	ctx->acquire_caller = _THIS_IP_;
 #endif
-	if (unlikely(slot->addr))
+	if (IS_ENABLED(CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH) ||
+	    unlikely(slot->addr))
 		return __hazptr_acquire(ctx, addr_p);
 	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
 
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 7c3c6017b266..3a2e9d7f58f8 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -265,4 +265,14 @@ config HAZPTR_DEBUG
 
 	  Say Y here if you want to enable those assert, N otherwise.
 
+config HAZPTR_ACQUIRE_FORCE_SLOWPATH
+	bool "Force hazard-pointer acquire into the slow path"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  Make hazptr_acquire() always enter __hazptr_acquire().
+	  This is useful for testing slow-path locking, especially
+	  with lockdep.  It also lets hazptrtorture exercise the slow
+	  path without filling the per-CPU slots.
+
 endmenu # "RCU Debugging"
-- 
2.43.0

