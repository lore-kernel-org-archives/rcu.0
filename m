Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284F2D8DD0
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767931; cv=none; b=L3uU7BNQihjvav7Q6RopIQyrLmN4iaKwM2UOg0AcO5cTWeLujc6q+XDQRGgyb1ox7LMqhDR41WgyeTqH3ot5Lo0u7a/pkA021axphZpQqSoiUATOWtAcHHMJNXyvpVV9Ep9hKe2FXHpGLjF0HBI9VAL1dtBAgn/ngWV9IOo5N0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767931; c=relaxed/simple;
	bh=TCCpXwnmodeVmKo1E6y7S918XFzRwDxpNrXxJ9AKFVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKelLs9A5ngp4MtJkaSeAT/65IsOF8wbqrYuTJ+TnH3dJO6fYoG53PnTf88oW17le/9TaSsEnoCOyFqT4NmRFeLNuIv4K0IkAloId9WK6TP4FvJwVBX3jcrdoAWUbCvJ/LTVLuz5agJ+6YGnNdNyUsjmxuNPsa4t4x4VyLfOHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG1bOGsB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG1bOGsB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d01663d816so21997455ad.1
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767927; x=1789372727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkKaVITt+/rz08+YgC0jvTu5c22naN5LQ082iYcixrU=;
        b=SG1bOGsBqe8CnfPDXvaR6Qj4r+mDvEJoZMa9O2M+gLVJ7ZY2308DAh0NvCM4ntJMW/
         j1ugl2zMkmizJtVEr4fQQZNRUaqikpEFbYIvsG9X+rZt94v6ZZBATyNFfhsKcmgvK7H6
         yBGOHkrIENzwALIheKqd0lsRh6pmnXLonLqARhh8UoXgb28NODO/rLYOrBTXqV2uF2wl
         j7CXxx6bB7ME2nVGDegZCdbpcsF0Q+l1tgmZ2aLoLfrB9uDPCvTUJun/9KoZjHJngbfD
         Xbf9E9o0L3VimHI3Y/MHJcwhTuzCHli++grhfDm2OE8D6+IO4sK23who2PQF4eVce3AK
         m1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767927; x=1789372727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kkKaVITt+/rz08+YgC0jvTu5c22naN5LQ082iYcixrU=;
        b=KfKIs+DfCoXmXP9XNNdWbpm/thpigB16Lmgrt3401ow5Jwcbg01WDRPKaoFuYpnrzQ
         XLC/3RFbfsehJJJwcGoTC8WAeZnnzCUbXL4Roh7nS53OBIjoelTemhOfRK6DY26XVCPm
         bDp/cgAeCzGpwZccWezIcwz/ZimDbOqTFgn+dLsgin3ulmjv6xnZw60fEMFmBQnzlMmx
         sQrCvjIhvrFJ471b1zU+FCAx7rsmdd2ux+nikzDRuA9vxXL3CZcsfLSLJygE0ISHaPZ/
         DuSPwZlWkEDQfNEY5Wq6Oy8aDGEop7S4xipLIF2TaZcalOtkrMA1MwSwBJPpZnUfG411
         Av4A==
X-Forwarded-Encrypted: i=1; AKwUvBys74UyZdj1AhVW2cow0iLf3zEPtmVM53I4x4KlkTXUqwjplRMcn82jIX+FR54aa0VFjMU=@vger.kernel.org
X-Gm-Message-State: AFuF++m3cz9KvJBvHjCj9eBj3m3nEyuX0MCKCcnpCDWvO74+KuGw5kma
	KtXaog7KISMlXHMxLM3/1m4XVrsGF5AFMivOF3MRZb5IB+/lf+VfSqCO
X-Gm-Gg: AYBFou1bRjD3OLwXALzREg3e06rBRVf3IkH4/TxrDqydi+HW/UkbwWqWLMVoO/i/MO7
	w4QIqpE5pFWWIRwrWqjmvZpCuvgo603L3Kq+FAPEA5QP28aXryPzE/fk/Xl5vDhY1e6NEBxZuFT
	BdOqJFs3yFQrch/PiguxYrfz8w4F9rjyoxswiT9jBDKn1eEVzg8gdq0mH86h6uy0UmkhVJePUh0
	9cbqFNZF4TRtV2/PYGT2pVRy6ho++bnfMc5LZKgbpfe+M1w+K6SGISDKuYsc7fJC2gTb+0y6wYU
	4K0XsOISFCVXt7cxgY2dYmcEAM6FJySVr8/t/FQxptO+xScFMyWbEYmeg+rg1bYi/o48iOfT0FU
	vTsojnXuySscEdk3ObO2gSudd1NUVR1/68NsC9tz8o/qSZA7yEWTFaqvhvIUfGsA+B0D66HvOKu
	7BkgNMKo766+peyp/aCdiMezO++gx3gSgvQ/D6XmU6MeCyYPO1R/rUsC9gs6/G7XoI5xXo/tHmZ
	OXzmM2z
X-Received: by 2002:a17:903:2383:b0:2d8:d4ce:9f35 with SMTP id d9443c01a7336-2db12757af4mr288425665ad.19.1788767926938;
        Mon, 07 Sep 2026 00:58:46 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:58:46 -0700 (PDT)
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
Subject: [PATCH 01/13] litmus: Add SRCU fastpath anchor-before-scan test
Date: Mon,  7 Sep 2026 15:58:17 +0800
Message-ID: <20260907075829.2073224-2-kunwu.chan@linux.dev>
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

synchronize_srcu_atomic() may end its grace period immediately when
its scan of the per-CPU lock counters finds no readers.  Correctness
requires the grace-period anchor written by srcu_gp_start() to precede
the smp_mb() ordering the lock scan.  This ordering ensures that any
reader whose lock increment is missed by the scan cannot have
incremented its lock counter before the grace-period anchor, and
therefore cannot be a pre-existing reader of this grace period.

This litmus test models the key ordering between the grace-period
anchor and the lock counter scan, where "seq" models the
grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
smp_mb() and the lock scan.  P1 models the reader-side counter
increment, with the smp_mb() of __srcu_read_lock() following the
increment.  P2 models an observer that sees the reader's increment
before seeing the anchor.

The outcome is forbidden by LKMM, and herd7 reports "Never".  See
SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
which permits this outcome.

Tested with herd7 7.58 using linux-kernel.cfg.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../SRCU-fastpath-anchor-before-scan.litmus   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus

diff --git a/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
new file mode 100644
index 000000000000..8200a75e15ef
--- /dev/null
+++ b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
@@ -0,0 +1,56 @@
+C SRCU-fastpath-anchor-before-scan
+
+(*
+ * Result: Never
+ *
+ * The synchronize_srcu_atomic() fastpath may end its grace period
+ * immediately when its scan of the per-CPU lock counters finds no
+ * readers.  Correctness requires the grace-period anchor written by
+ * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
+ * This ordering ensures that any reader whose lock increment is missed
+ * by the scan cannot have incremented its lock counter before the
+ * grace-period anchor, and therefore cannot be a pre-existing reader
+ * of this grace period.
+ *
+ * This litmus test models the key ordering between the grace-period
+ * anchor and the lock counter scan, where "seq" models the
+ * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
+ * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
+ * smp_mb() and the lock scan.  P1 models the reader-side counter
+ * increment, with the smp_mb() of __srcu_read_lock() following the
+ * increment.  P2 models an observer that sees the reader's increment
+ * before seeing the anchor.
+ *
+ * The outcome is forbidden by LKMM, and herd7 reports "Never".  See
+ * SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
+ * which permits this outcome.
+ *)
+
+{}
+
+P0(int *seq, int *ctr)
+{
+	int r2;
+
+	WRITE_ONCE(*seq, 1);
+	smp_mb();
+	r2 = READ_ONCE(*ctr);
+}
+
+P1(int *ctr)
+{
+	WRITE_ONCE(*ctr, 1);
+	smp_mb();
+}
+
+P2(int *seq, int *ctr)
+{
+	int r3;
+	int r4;
+
+	r3 = READ_ONCE(*ctr);
+	smp_mb();
+	r4 = READ_ONCE(*seq);
+}
+
+exists (0:r2 = 0 /\ 2:r3 = 1 /\ 2:r4 = 0)
-- 
2.43.0

