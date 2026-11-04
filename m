Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811349;
	b=vxK0FFQUuvYKnYw9isltyH9ouLr0O6p+WCzVbEAjq8Rn3vRaQaRZ+TmEIpuooVOBZ/k/
	 82WrusJiV4IoeSa8j4ebRw+sZUphY52dUXwkpV12xzjXm5vC6ptmPLp5xyDRvrL78XLX9
	 fGBPKHe0IekGRfA6HZCSDdshcqHNUQ/v5rQ37PoO78Y2aBCg28rn0gcvDjrekSH9mxGvM
	 VuUs/z1cuP7aOZcKMSG7sE8xs2WHq8AF+Y4xHNYgfEfzKz9nwxLRgP1xqgTWtDDwT3Ubz
	 tBXVoSqZ2/wBK/o6Q1X+KZbcD9vYcRZrwuaHcgAQb1IxU+1Kl+X6gWlZUAfMvR91dPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zN0OMa6DsitFd0I63/8rm5wsSSArSxIu8WmzT7WDGsU=;
	b=4gepWqh1jP5+uTOe9yHqlLYZ6ZCrWleAM1AMLfYkF96oA6rSrgzoFzV3WOoIk8XjPqfM
	 YqzspoFk/VVoP5Jggj6TDTVLXF0gLLMEwA7rKDtMGUdFWtOutx4s4tCV1PMmyPN9/tuVb
	 tglygXeVrQTR3X2JBy5SUDGfVSAf0ezK/ACBxkhmkmkFsqoMQGMgTLFW3Asn4Hv9Yyxii
	 9sp4D3/dBBZz0fHR+4rET+INtI8pqYTYMcRyWztDNgsCkC9KOODd13fgp4Zzgw1yTQ4ls
	 qvbzMWFPPk0hIYdOFqicoU9vz7QdWE6MdvpDq0k3kz0BJ1FM13D7EjPpH0edrYQCfAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfhIGsI1;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C24606A333
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C24606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfhIGsI1
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a18fc7a38so2022756eec.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811348; x=1794416148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zN0OMa6DsitFd0I63/8rm5wsSSArSxIu8WmzT7WDGsU=;
        b=GfhIGsI1A79J7jj8MJAkxgJjudxW5sb6BpufeqVLWo4k5o9TBPAOkoCPeNcDs2elCb
         91bVJsIm83LcNhiO5mYbF39oD7VEjY9BiK+zk6u8gqDTaVdUFDv0uslgPSVOPnH1Kwk0
         hW0fpiJUPDSulT9sjmuAXODm7KaVFn2/qcZ5VCjidr1u9VELGD6xVErSX1p9jDOreK11
         c0wqkNvo4FFRBO0j78kT2Pted/n+mcjMpXtVQKHfEYds8sVK4NeBEAWete0R+fJr2Z8Q
         gVmU+4MLZBzoKT47koTB0I9kNjDp1iWCjikr7bMtNUnkLsmXm+5nFGPVV+slNHi8wJzC
         BIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811348; x=1794416148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zN0OMa6DsitFd0I63/8rm5wsSSArSxIu8WmzT7WDGsU=;
        b=V3Wdn0IbpzICa1THFlwEoiho3rblpAyM5T2rIFub1/zTZsOqukix9Oqa1Ipko+wIdn
         2oiELlfoqnf6w61HoqZbo9RiZp116LG+ENZEe2tdvepe9ySkAXHVGPvjEu0oBct574BZ
         ztjDKU7pSjVwzStR2n8aBakxF/oUm9XSHshpytz1I7PC2tCgZfGEnOqIRyf+JgDJ/wCY
         Etti8t2dovavjdrJcGVLigDPQq6aHRkTShBMqVG7TxTwvWs2O3fuK0QZ8ONyb2ZW1I23
         d1zXRihIHrmhdBL1usMQ2jllPqkheA0E1xNItNiVPhjgvbqYiIgVYOrJkRb6Z4eVkge2
         3uYA==
X-Forwarded-Encrypted: i=1; AKwUvBwNDFs9/neWSzt48Zr9fiN+dYx1moCn6+LLqlZwvhi0HiU0VoJ2EbzQRdv+IYnKK0XH0TE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KtC4DgQgY2K4fsJgsfUUO8grE+Gn+HX3eDCYyJ/iTevTwn8jN
	hAHMUKiNQp+qR5PByyVZEQvQFw66/mC9RcNAjQxSkyxGis2S47ZjWBo2
X-Gm-Gg: AYBFou2jFN0ESExEVtXf8thwDDdZTUoe5tsBKX5gFLP0Dk1CxyG5i8KxWY/tTI+Y5+j
	y68F+y+9/Axzzz/8SMf70Dud3OXhm0QVM/h6YHZUVHW+dGOqwTQl5J9weib5AXyl+MFmozneFFK
	KOmJ6kmfOpJiPgLJPmD/y3LZ60wRvMfmDBFLFJq1MG+CwaE6bOhqxcwHXhCbckSI0Bqx0szeMXg
	yzbIh2HXQHjiVmHcDxNyxh0Nf+e171apx8jDc6kXQLtH605uG47lZk2tT5T0LOf3Muqn/43k3XJ
	rog63Z8501wSV1XJu8InBomyNpCSe5Fi2SNED19Qcg5Rma+qv+ukW6pGlv0mHNdbBM+/uZupWBB
	Qqna0vwzFaaofP2avNfo3me+apgDaiuXe0IFqBAvXUakQQ1kzmsHSGo5v/hQCOzmjTPIDj4Y9Nq
	51m0saLPbGpJzkmMc+owwJTDLkM3R6LJxxVh4iXYrkYwgnxlQWih68EsJh6h4hhLz30Iruvsmue
	IfOX88aXOfvIx0onXMWGYnEL0A/SEHiFm43FUCG39rL2d/gm+vlVU2YaqcduYH/sg5zAaDgGy4J
	+7DpJqp3rTY/U3Z+95m9PRR89aCferEDBSiytD0fALKSSkm9rzGOO4nPJoMD
X-Received: by 2002:a05:693c:6092:b0:369:1084:8ee3 with SMTP id 5a478bee46e88-36a423e52c8mr29321886eec.23.1793811347548;
        Wed, 04 Nov 2026 08:55:47 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:55:47 -0800 (PST)
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
Subject: [PATCH 03/28] hazptr: Add scoped_guard() support
Date: Thu,  5 Nov 2026 00:54:21 +0800
Message-ID: <20261104165504.2430480-4-kunwu.chan@gmail.com>
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

Add a scoped_guard() class for hazptr so that callers can pair
hazptr_acquire() with hazptr_release() on scope exit.

The guard holds a pointer to a caller-provided hazptr_ctx rather
than embedding it.  The ctx must remain at a stable address while
the hazard pointer is held because the slow path can chain its
backup slot into the overflow list by address.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 include/linux/hazptr.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index d37792af3493..3372b1cdbee6 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -341,6 +341,43 @@ void hazptr_release(struct hazptr_ctx *ctx, void *addr)
 		hazptr_unchain_backup_slot(ctx);
 }
 
+
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
+ * cleanup.h releases via hazptr_release() on scope exit.
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
 void hazptr_init(void);
 
 #endif /* _LINUX_HAZPTR_H */
-- 
2.43.0

