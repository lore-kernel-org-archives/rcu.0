Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184C4E13E8
	for <rcu@vger.kernel.org>; Fri,  2 Oct 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960993; cv=none; b=jd4rNvsdq3nwpi3roACrj8utrs1lnG4D2+UAjK42R32lhfkYrM1BCR2L1IgUEe/3N9Si368wltLUBoMDmvrFjnXsrW8BKPzI2aTplCD9SKGIdkQZkTB5YUBhoIjV8aeEeqnuYhzmxBkL2Fy3LhMZElp83vNT6ofcHtckVS99vJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960993; c=relaxed/simple;
	bh=8NuyF6qDUWQBXBIkLeP3/lavelfuwnWRCmtSE2YKnuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A67yseXO6qw2HFVcwGBA/6eW8VHWmGkAPRuxeCY2qzqupviJqUC2uxh/TFRzsk3GK6mJNgNtOzWQrh5jpF05RviFPpsqdYaADYtbfbx7wKBonbUC1dThbv7/Vimzmy4PfQdoqHCQPuoc8hmg/8gMosk2sloCfJeRj9ghBb1lk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNjFMNFv; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNjFMNFv"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2e2e0d89e58so22002925ad.1
        for <rcu@vger.kernel.org>; Fri, 02 Oct 2026 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960988; x=1791565788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtL6vbzPvQXVWHTKwirmF+KIwLuuD5CR0v0OHwTiljs=;
        b=WNjFMNFvKfJ/1IDsq9qowgsjjFhOqzTdxDhAn5mfmVv2jV/R4X+ceVNQMQqs11atoJ
         Eg1fu01GcZ1ii0pJExuSRo2TUokI0P54HGPAELFfS0XSOVDlInbOQ8yt1Pix+BOWA6Fj
         KcH+2omNMQh2taPwqtDmr3TOElqqTnysA12XZ6MtS5syW7jcchtlCdvSpm9gmrZXYXyy
         fdGs7wPA4bWiRlyPt+H1It17NCvrQAag1XGULJl2wsfxYKjWWdGXqRDj2KRlvt5bKlPK
         RBXxJ8PCvkQ3dpQsDQ38sGOHY4qUVXU3SpcgE2Ds5k1nauOc9P4O0qyqpwSGpY/utol6
         aEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960988; x=1791565788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtL6vbzPvQXVWHTKwirmF+KIwLuuD5CR0v0OHwTiljs=;
        b=U74gV0b/jAOM4yk94bTrc8QPKwdrS37F2EP+8k3Vhurkx/a/StjYuuvrkHQr5+FyU+
         PgDZ2YUklucCIxprNNQnf4ANAMVMcYymSKwKGCoSL3qQ6k6vKyHDbKmjGjDZo0PToLHO
         R67zjjlOGR4JK7ezYwp1Pcf/Jz8EOuv+nzfPN/A0ZgztKKXjR5TECNAzdkbIcrh3Hjyv
         Ii9GtRZA3cNiy9dQd7dD3CDvaDEcohxqmBd/ri64O6U2IrZQ+ELNflw0GhaFOWLag9pX
         GeKauyIXC5cMlQO/A0XUt19LgZvmhwIr9Vn6joNKhbfjUc4hQesbH256Gv70t4jHxICA
         /AOQ==
X-Forwarded-Encrypted: i=1; AKwUvBymoPxjd/1K47cc1UhVLyU/luWsu2JU0Afgv2ycwfnce/ekKOgsnbq9JpITCyymDvwVBW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsMBbFb5tc6n0wogQPkiqxOqC3dDTaqEwHSjw2P+ezFH0JbK56
	gpCLxVVDeOtUnyczThDPtJJNoFQlJrHsIYRGp1Ng/dAnE/a5IkEnMj4q
X-Gm-Gg: AYBFou1WJHbELPi19WO1QXFKfYeTQfY+yUVjFXvDjGplu13Tdeo8u3dt7AZJV/34LsI
	p6UY885TwZ4oFIUFQOQ6bdFGhzCLa+W3g/dY25uqK7nR8zI2zRMetuS2J6lA1PUnOKDfGXlVBCn
	i8ECs/Q7nPoXlSzSEAgODYIcHnYF2o4Vcgsf57V6akb0lbdIFZME/6Xr/x3jwQgCB8wmikah7qg
	4AMQsi+O8iEXQWq1okDBy+JotWotB+8In6hAz/mBfLxSCw4X5gH1CRCqFGNKr5jMLxYO1lHda9Y
	bToj1VpA8TqSFCn72oiaDwjRfGaI+cNq+lJNFf5TQMEEUgeNwdmI1iKcqTRQMVnnRVzGOGTGXTZ
	ZR5tE3l4fcf6ECd8mbLT8Q8bd7g2um4xAH0QriYfsPOmPNwg+WiBgFcVPnNw+8cNhMb0zGIB7/2
	CelxlFnOM71WIefFNOB/k3qKskh0aejTO7xcOKWcChKPlcvJYIr83/JEuSTABdwv5hYXxFEXzbN
	v6YAOpwv0XYBgZ0og==
X-Received: by 2002:a17:90b:564e:b0:3a4:e9e4:37f9 with SMTP id 98e67ed59e1d1-3a6ceaeebe3mr3029048a91.31.1790960987338;
        Fri, 02 Oct 2026 10:09:47 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:09:46 -0700 (PDT)
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
Subject: [PATCH RFC v2 04/15] hazptr: add scoped_guard() support
Date: Sat,  3 Oct 2026 01:08:36 +0800
Message-ID: <20261002170847.3653663-5-kunwu.chan@gmail.com>
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

