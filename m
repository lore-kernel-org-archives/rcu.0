Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB64E80A5
	for <rcu@vger.kernel.org>; Mon,  5 Oct 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220605; cv=none; b=PBAp0X2jq1TYq1w37UYVSydsFEFtvzl/HNjSXlHjYtCr6POGuAhfIvOlXK106i7j9a+1Jbsdbnvuqix6KlZSIQiNTgmXRJ+57uM0/OYnRP42JV1LyR8K6Qn+IDVwUOh2R9+EFs+XWiLarxW8DIbji/OHZTTXrJ84NPZAY4OfR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220605; c=relaxed/simple;
	bh=8NuyF6qDUWQBXBIkLeP3/lavelfuwnWRCmtSE2YKnuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rtk0IQGaGfCBBLs80c6U1KJ5hC1Tinby6XnXrTjs0kKMhZN3XvoqeJVBteicdD5V3WpDtjn1CLD7LbOLgoSYAX0Qq4kopi1UTh72YXFVYiH+MUhLDOlhICSJ4Lq31Qy/T97mgmDms3LwTFhDE222JELdHyvh9KtQJo1J9jPeyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBBcsIKd; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBBcsIKd"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so842594a91.2
        for <rcu@vger.kernel.org>; Mon, 05 Oct 2026 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220602; x=1791825402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtL6vbzPvQXVWHTKwirmF+KIwLuuD5CR0v0OHwTiljs=;
        b=cBBcsIKdTf/4BM0kB37KIEAy8UOCwt6erlxIBf/0s9m8sWiH9s6KTjZG/xgjgnnKmB
         vksAzdqXZnKnPuqx9/06JECP01BeUCmNFvV+CHyv3oTocAapkIHFVv6UYSG4+yFzNQV4
         0T8jkn0uPcNI+qhgjXkRJTUn58+xcVxVWC7rXq4a7GBsvOkJLyGzFez95P7qGhL+9zfv
         F1JC9nn5oC9OaH4WKSS4VexzXarso1GqrPTZro8LSscwIZHSA74348qxYrmz6KUZERt2
         4IdgP31u8tU/gimJ+M/DXrFX/HeeStwt4AqsY+Hmy+SSeQSlFalUSSts3j0fCz9C79Nh
         A0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220602; x=1791825402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtL6vbzPvQXVWHTKwirmF+KIwLuuD5CR0v0OHwTiljs=;
        b=ogJi9RRf9tmP+OrW5xAJKTYs7aEZzVcJCZAELC2/Zeuf3uyN9O+LSgyM+yxkRtLzSV
         6Bz2Uds8oPa+fkMgbJqLGEq29QNTDlFFsIgvGNmx3cn60aIrfY9300oTCSI8C4/XYHj+
         XxiXtBMr+cPJQkslyunZ24kOmyFikZCq0qb+hTc8ZF+B4yhuyrXkgRCVJh61y1yXwe1A
         KaVkIkTY5zncEHylFaf2GEhy/wy9aK1C293nQddJkID5zJIah4qFJ8YlwATgToI+ID8T
         /7z+iuPwEM6XjHYG4qfGAhCXFiLnSwEk2tOuyNQAWBxemncMTbZzob3lDcxCgWrYEC8P
         dAjw==
X-Forwarded-Encrypted: i=1; AKwUvBwpjWL/xBJNzHTet4CLVAOMOlKwn1L9yOJ/+I7kOoAsWr4fthJXWweZ/BpVAml1jK5Vx1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8PtxoOeKYydYIqqaeWChq2b7QiUSb0y5IwvFywxQS+g2rMfUN
	ooyFp04P29jvJPWVuZR4a/s1OlhGIs29RjFksuPKgZCL2J/chAuzyzzf
X-Gm-Gg: AYBFou2W3HJD3J7W25xrInmSdUz4EhsZZ7ItXdcJus4FrGdLeC9w3mX4xLjxGqGHxuG
	9osr47z729IJ9urOnPst0pPcV2g5jG9cj54oRPApylYvkX3aEsLH8IZ6x9ITQC14Nx1nxvNWK/0
	3gSLgfOdTKq93/RGptfHhf3pSCZIUydrDsDhJ8gKUFBmgZCWjx27in0v8khXB5J1y0dGR+VKL7j
	Mqn4+MPSGgAK259CmDLpILhwwt1XrLv/sWQDkGpPK98cwnBNVYrnELbAMCevchG71PTAxSDFZvL
	smf6oHd+WpdwVUzWuo/YluanwINEK8RgDUFojT3whiNvahZnQURNjEOmfeNw9Uy8YFIwi1dnuLI
	VkCXEmk5Hj4X34Ed9IV4iQkAz22EDRMQxaqZUZL7cD0qsVX26hqnezo7y9xR1K32BCMb7kcn/6p
	FlZ4QYjjMcyeqRSIUj/KbFzkhtoK5vwsiXwz9lvKnUtn9nIr68ylLh+/md/rUWKA6Q+zeCGt5nf
	Oh8DB+WRRhVhkDxJU/5MDESUAMvTw==
X-Received: by 2002:a17:90a:dfd0:b0:3a4:bc68:310e with SMTP id 98e67ed59e1d1-3a6ce7f684amr7983000a91.39.1791220601705;
        Mon, 05 Oct 2026 10:16:41 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:16:41 -0700 (PDT)
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
Subject: [PATCH RFC v3 04/15] hazptr: add scoped_guard() support
Date: Tue,  6 Oct 2026 01:15:18 +0800
Message-ID: <20261005171529.1378809-5-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005171529.1378809-1-kunwu.chan@gmail.com>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a scoped_guard() class for hazptr so that callers can pair
hazptr_acquire() with hazptr_release() on scope exit.

The guard holds a pointer to a caller-provided hazptr_ctx rather
than embedding it.  The ctx must remain at a stable address while
the hazard pointer is held because the slow path can chain its
backup slot into the overflow list by address.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/hazptr.h | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index d1670121947a..275cbe54b075 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -320,6 +320,57 @@ void hazptr_release(struct hazptr_ctx *ctx, void *addr)
 		hazptr_unchain_backup_slot(ctx);
 }
 
+/**
+ * struct hazptr_guard - cleanup.h guard for a single hazard pointer
+ *
+ * @ctx: Pointer to the caller-provided hazard-pointer context.
+ * @addr: The address returned by the matching hazptr_acquire().
+ */
+struct hazptr_guard {
+	struct hazptr_ctx *ctx;
+	void *addr;
+};
+
+/**
+ * hazptr_guard_acquire - Acquire a hazard pointer for scoped_guard() use
+ *
+ * @ctx: The caller-provided hazard-pointer context.
+ * @addr_p: Pointer to the pointer that is to be hazard-pointer protected.
+ *
+ * Acquire a hazard pointer using @ctx and return a guard that
+ * cleanup.h releases via hazptr_release() on scope exit.  The guard
+ * only carries the ctx pointer and the address returned by
+ * hazptr_acquire().
+ */
+static inline struct hazptr_guard
+hazptr_guard_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
+{
+	struct hazptr_guard g;
+
+	g.ctx = ctx;
+	g.addr = hazptr_acquire(ctx, addr_p);
+	return g;
+}
+
+DEFINE_CLASS(hazptr, struct hazptr_guard,
+	     hazptr_release(_T.ctx, _T.addr),
+	     hazptr_guard_acquire(ctx, addr_p),
+	     struct hazptr_ctx *ctx, void * const *addr_p)
+DEFINE_CLASS_IS_UNCONDITIONAL(hazptr)
+
+/*
+ * The ctx must remain at a stable address while the hazard pointer
+ * is held because the slow path can chain its backup slot
+ * into the overflow list by address.
+ *
+ *	struct hazptr_ctx ctx;
+ *	void *obj = ptr;
+ *
+ *	scoped_guard(hazptr, &ctx, &obj) {
+ *		...
+ *	}
+ */
+
 void hazptr_init(void);
 
 #endif /* _LINUX_HAZPTR_H */
-- 
2.43.0

