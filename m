Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52F4248D2
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767936; cv=none; b=r9p6kWz1htPdsBCb77drpF10g0mju83iWBmsB3O/bQwsQjo2ZKX0oz/JkZlTqu+7oqsWF6STvFi6M1sKh+R9EKS+9IJ3PRHWOZfenLyBaOxCDAvdlj0TVyQPO7mByS9ZQl6VKJ6mHEfhDc/9pzs2GKkTqKIEuO6H31/JIBfawVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767936; c=relaxed/simple;
	bh=y+BKA/RD4U8D0pkVHR30bN2c+9yOk5iGeepHr0HLGn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iy/i1IxNJgeFJqUYTiv9XGwAsTo4MhRTy0dSzrHMaePAfPUUlWpCT2yJSY3mejyeX5SpYoTSLSDOv0OKxiq9lggx1pRn3YqU3ryLWovwskSCgY3mF8K3rwvEwvg8X2M+GvIKWopkzOvgoBMDHNjySbFDt4qL1lfI6y4pck2KP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/bOgsdq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/bOgsdq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6d28aa26cso18962095ad.2
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767935; x=1789372735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KuHltOQMtvIyLbH/3yCpfQv67OgWo+va2cml6EO5eig=;
        b=i/bOgsdqUnJPDVyhp+B8Er/UUqw3aAaPqy/Mhp8NjZllVUcyQu0q9wJlqS2ecdz7/D
         xPEQ+m2aXsEDR3twb9ZPr7f7TZl5J6THBp9s77X4gFYApSAcwucVWFbgsesAUhLYzMy4
         KWfTHXBZwAWfgI2vM2ADgv2Vua7JkJ3bC3zTkCGGr2+GIqHA3mM0aDWE+QJ4x297XZXF
         2xt38x00Q3Ya1ihZz4inxVXFd1J56bfoAkVBLtzIax0X2eIT5dqxuTZp8e1/wUInAxli
         xHoxiTJFGWx/efVcSUZpTJ088K8juqn5rS+Rb66ickN5N5QroCu0hBRrajfMmi0Pmb7s
         RSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767935; x=1789372735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KuHltOQMtvIyLbH/3yCpfQv67OgWo+va2cml6EO5eig=;
        b=s4ddBjCu/zC1mlmUopUrlfBe2Y33NrFmGLFwcqRBstGeRjO/dpvplApTgT7isnCHaL
         VvTP4SmZoIGBC0p1R3Eie+vesVNa8mTa5QXPKqtyggxvXa8kkLYmoUAeF2j7sMOKLeC0
         3uB0y/wmfGL6Js/BOaoHrk0SqVrpd5XpYvFxbgX6hsfDiddxL6ZDbtjPivdX4oiPrthb
         14LsM7+T2hTSmVjDmnb3FFwR0mKxspKAV1ZeCkXrZYT/DSGaSjoNhXEHUjKLaL1pTbhC
         ktJR1uQl80/kWSdSmXL6O6n2v4tixmxBRPSk6a5kzpuPutRRbC8+cJyU5mntrN/AyPwN
         6VNw==
X-Forwarded-Encrypted: i=1; AKwUvBzWskqlIGrSaVSj5HyvOMtSH1GXlOl+bEk6i48tDEQL2dKOe6z+e5xHnwTARl01dJHP6uc=@vger.kernel.org
X-Gm-Message-State: AFuF++nVkVDZQ+3jIMVvbpp2cfAtihx8ezpIxSHw/T/ePewvXEdRWXoL
	stWqFNbbo80RqjlObA5c5oJYwfYqJrOMWg4Ut8Pa8sbkME7TkD246C8W
X-Gm-Gg: AYBFou3qxvQTaSmSjEicACXuuBMSCM1bS9nST6I+y2Imb05VPhv8ifqjFtz/EIES2R2
	XCWwK9FTmhGmZAYq8vSIpHCcQHLpdjv+lyxH94LbNT2mZnb0BGlrCRP0DDsP2r8s0RQN7dRfPvJ
	7NEPuDvfx57LE53jqbPCd96ZIONcqUiLG9faxWXcqFiGL57o5w/Rt3XE6yiNn+nqTW/Wnh1+1Sr
	PVuo5yv2ApPoNghZ4lAuVj0URvif53finTmwlJ4d6E+3cxSZEDpWpPhp4aKykaXXRFUtmtH90JY
	IJSzLCu5TlQ3hx8G8geKErNewsrGd9jM6bL1ji/h20fC+bFr3yoqm5H2FU4RBO+PsrYoJC16m09
	rt7bpMAfyotKBU6+rIJO6Ixt0XBUh2JmIUfgVLTvOoWfPqDwpaeGbGKmK8pvLK3y/URuf6ZLhPm
	2TZl7aC9oBm+TJq6+YJslRV8c2tM3PqirN8u0FwtWrHej5KTy4x07E7dPu8NBtzXb3duiuX4wlk
	0tZfY8=
X-Received: by 2002:a17:902:b114:b0:2d9:1dee:43e3 with SMTP id d9443c01a7336-2db12757f17mr202313705ad.18.1788767934067;
        Mon, 07 Sep 2026 00:58:54 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:58:53 -0700 (PDT)
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
Subject: [PATCH 03/13] srcutree: Add reader-free fastpath to synchronize_srcu_atomic()
Date: Mon,  7 Sep 2026 15:58:19 +0800
Message-ID: <20260907075829.2073224-4-kunwu.chan@linux.dev>
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

synchronize_srcu_atomic() is restricted to srcu_read_lock_atomic() and
srcu_read_unlock_atomic(), whose read-side critical sections disable
preemption.  In the common case where there are no readers at all, the
grace period therefore need not do the index flip.  Add a fastpath
that sums both ranks of the per-CPU ->srcu_ctrs[] counters and, if the
lock counts match the unlock counts on both ranks, ends the grace
period immediately, skipping the srcu_advance_state() scans, mirroring
the similar Tiny SRCU fastpath.

Correctness requires the counter-sum proof to follow the grace-period
anchor written by srcu_gp_start(); placing it before the anchor could
let this grace period miss a pre-existing reader and return without
waiting for it.  The smp_mb() between the unlock and lock sums pairs
with the smp_mb() in __srcu_read_lock().  The grace period is ended
manually under ->lock and ->srcu_atomic_gp_flag.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/srcutree.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7dd705eec573..533607de5728 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2113,6 +2113,8 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 {
 	unsigned long srcu_state;
 	struct srcu_usage *sup = ssp->srcu_sup;
+	unsigned long rdm0, rdm1;
+	unsigned long unlocks0, unlocks1;
 
 	// Initialize.	Either init_srcu_struct() was invoked or
 	// DEFINE_SRCU() or similar was used.  Therefore, no allocation
@@ -2149,6 +2151,52 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	srcu_gp_start(ssp);
 	raw_spin_unlock_irq_rcu_node(sup);
 
+	//
+	// Fastpath:  If there are no readers at all, neither grace-period
+	// scan need wait, so both can be satisfied at once without doing
+	// the index flip.  The counter-sum proof is the same as that of
+	// srcu_readers_active_idx_check(), but spanning both indices.
+	// Atomic SRCU guarantees that all readers are of
+	// SRCU_READ_FLAVOR_ATOMIC, so the SLOWGP check never triggers and
+	// the ->srcu_reader_flavor masks returned by
+	// srcu_readers_unlock_idx() are unused.
+	//
+	// This proof must follow the grace-period anchor written by the
+	// srcu_gp_start() above, never precede it.  With the anchor first,
+	// a reader whose lock increment is missed by the sums below cannot
+	// have incremented its lock counter before the anchor, and therefore
+	// cannot be a pre-existing reader of this grace period.  Placing the
+	// proof before the anchor would let this grace period miss a
+	// pre-existing reader and return without waiting for it.
+	//
+	// The smp_mb() pairs with the smp_mb() in __srcu_read_lock()
+	// (store-buffering pattern), which guarantees that a lock is always
+	// counted if the corresponding unlock is counted, the same
+	// memory-ordering guarantee as is provided by
+	// srcu_readers_active_idx_check().
+	//
+	unlocks0 = srcu_readers_unlock_idx(ssp, 0, &rdm0);
+	unlocks1 = srcu_readers_unlock_idx(ssp, 1, &rdm1);
+	smp_mb(); /* A */
+	if (srcu_readers_lock_idx(ssp, 0, false, unlocks0) &&
+	    srcu_readers_lock_idx(ssp, 1, false, unlocks1)) {
+		// No readers, so end this grace period manually, skipping
+		// the index flip.  Advancing the sequence number via
+		// rcu_seq_start() in srcu_gp_start() above and rcu_seq_end()
+		// below keeps get_state_synchronize_srcu() and
+		// poll_state_synchronize_srcu() working, all under ->lock
+		// and ->srcu_atomic_gp_flag, which excludes concurrent
+		// sequence-number updates.
+		raw_spin_lock_irq_rcu_node(sup);
+		rcu_seq_end(&sup->srcu_gp_seq);
+		raw_spin_unlock_irq_rcu_node(sup);
+		WARN_ON_ONCE(!poll_state_synchronize_srcu(ssp, srcu_state));
+		atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
+		preempt_enable();
+		non_block_end();
+		return;
+	}
+
 	// Wait for it to complete, helping it along.
 	while (!poll_state_synchronize_srcu(ssp, srcu_state)) {
 		cpu_relax();
-- 
2.43.0

