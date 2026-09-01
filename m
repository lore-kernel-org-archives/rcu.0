Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D446D09B
	for <rcu@vger.kernel.org>; Tue,  1 Sep 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248943; cv=none; b=pqb4UE43PtDaL+oGFWsqPJvA2emxa6644ZaguaNQht1wCTxV4aknr4z/SK1I6ITahErhyYpNQ85F1Trmh3xgJB1Hu9BZekO2ciE8HdIhm2uYH2wMqSkadJs9c52UcXjsgpLTr9ZUd0M0ftR0/EK1QLvlvjXg/su+20Uyfg9xmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248943; c=relaxed/simple;
	bh=6XI3eg8IaD/wYB87LRoiYG7IH7ZCCHeePKHRPOP75Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dexoOUy5zNWL9L1XEHF9ZgQWOvHkofF438zEBH84Cwn8MmR+VrIWNfArwAe2r4LkZI1fM4bIudxANMnhvcl+hnh/dacJ6lYSxvVfG5T1X0Xk/vsxFyxngbWxdWPL1szaCakJIpGKNOV1WP4VQ0QWFKK9GlJ/ePKvNP6aC8/En/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXzQc/Cm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXzQc/Cm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso46469395ad.2
        for <rcu@vger.kernel.org>; Tue, 01 Sep 2026 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788248941; x=1788853741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OhH+6P1yI44nri9QpXqL2U01mVLBeU0+majSA9ZCwVI=;
        b=WXzQc/Cmcw7mlCQtIHv8pmi8agtx7EAfNy2Nvr1lD/CJVGfC8wvBAzBzzjq7TLAs/R
         KbL9c1EMPLIYKLwRRtOUz3s/ko5meJmYnzawn/JVYfv9VOHz9rKpSsgva4uTm1XUQ2uG
         Ejxs7r6zfMQReMXxn3nB9RQHHOD9mlj8rtaoszgSm1WYnoJ16jVcHQa2vhcaEiKK3Jhc
         +ZiogzVvcM5spCnVLBAEIhK6xZcwLQPVaTGkzlNmdHcVGaljDTd0nXec7toMLXBCX7VC
         X+RJNAXyHye+H9sIxj8HeUgW/zQ7ZYbNyG4scfqZ2kFqYEgBq6o8V6wXk7cw6v48Jfjh
         rgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248941; x=1788853741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OhH+6P1yI44nri9QpXqL2U01mVLBeU0+majSA9ZCwVI=;
        b=ntcolJ4hk14UYImqBAFZbJIGP8gbKfV/oR3FJ/xizVYHcuT2i+24KfEgwQE0leCPgb
         Q+rRKi2dTFTIygeH50agtPIZngWi0EyvFkYuUWb5ygT8EHsDpTpQcqo2YHVcsQefhiC3
         BuVU6zt9xYSFVOUPvEx4Y8P7woL51+zSQ7XnQv/8gPsBZuHy4ihiT3MxJwuwZpP21ZpZ
         uTu1EweBc1FA+NF2issskzmon66fXjcN4zhMh29KCfDC1pD/Pz2e9+0sHU3t7aqJrgVx
         /dr0Q/eyUNiyeZDSisYM2aydrscmZS+8EA8psE4mEoXIOaBkaiwcC8I7dJmQ7fFVHnD+
         wBcQ==
X-Gm-Message-State: AFuF++m3FWIene+MBrQWrXs9gPkk7CpWkLghcg6XH4ozzJRQAzI0UCNo
	uX1Jou5/OZM8xr3+kuEKAEZfalAhbhG5I7OKJRqDAiBTifCu2IO3qgOO
X-Gm-Gg: AYBFou2oOuIyzO4uMdJjNOKAqbu1aeb8a19RC6NsdqBJ/T78DH9+fa9MsceB+atmT2R
	v0rVH0vpUMX8BFqeAfmOXGKzN8IBMDGylxmQqotYdkmAQg3qw6dtqtixcmuN/VcVbuwomyWZ+75
	g0FaEUT8RJHsLUDHrxo3eO6ysG+EqDBhqGBK2ICzBGTRwfDEKC2EoqZcMnEaWyuaU5IX+DauSIb
	z9vuuGGPhTHOCwGN02ydcQlvM6k5opgoEgt5FUbp7f1wUJz+b9jCXoMn7XE/5OxHdf3x5LbJrRD
	C9FkT6im1wwMF2ELbbhI4ojU7kCeYMggGmnwWuX1zzgUZUd75Bo5pzUUYRbQVmufgLaKjfbpru/
	CmbaHQldTUeMKgrRRM5PVhHC6A7dN+3MK1p05yMwSd6wF19VmkwEO3FCdoz+KBSI394ear00hCP
	1qqy+Bqp5PJwUXmswcMZ4nH/E8+yIF9kDU8zCCWockI/hs0B9P5Q06KwurrvLbDB71o3Ohm0SNl
	V92RPk=
X-Received: by 2002:a17:90b:2552:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-396d0f02a58mr48677714a91.7.1788248940660;
        Tue, 01 Sep 2026 00:49:00 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990c40d0c9sm4535507a91.7.2026.09.01.00.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:49:00 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH] srcutiny: Enable atomic SRCU flavor tracking
Date: Tue,  1 Sep 2026 15:48:15 +0800
Message-ID: <20260901074815.3145037-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Set srcu_reader_flavor to SRCU_READ_FLAVOR_ATOMIC in the Tiny SRCU
atomic initialization paths, so that the entry-point checks added by
the previous commit can identify atomic SRCU domains.

For static initialization, add a flavor parameter to
__SRCU_STRUCT_INIT() and pass SRCU_READ_FLAVOR_ATOMIC through
DEFINE_SRCU_ATOMIC() and DEFINE_STATIC_SRCU_ATOMIC().

For dynamic initialization, initialize srcu_reader_flavor to zero in
init_srcu_struct_fields() for the generic initialization path, and
set it to SRCU_READ_FLAVOR_ATOMIC in init_srcu_struct_atomic().
Handle both CONFIG_DEBUG_LOCK_ALLOC and non-debug initialization paths.

Enable srcu_check_read_flavor() for Tiny SRCU, matching the Tree SRCU
behavior, so that readers can verify that the requested flavor matches
the SRCU domain.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/srcutiny.h | 39 +++++++++++++++++++++++++++++----------
 kernel/rcu/srcutiny.c    |  1 +
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 2b293336525a..9dce4b5aa084 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -40,7 +40,7 @@ void srcu_drive_gp(struct work_struct *wp);
 void srcu_tiny_irq_work(struct irq_work *irq_work);
 void srcu_defer_drain(struct irq_work *irq_work);
 
-#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
+#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, flavor)		\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
@@ -49,6 +49,7 @@ void srcu_defer_drain(struct irq_work *irq_work);
 	.defer_cbs = LLIST_HEAD_INIT(name.defer_cbs),			\
 	.defer_iw = { .node = { .u_flags = IRQ_WORK_HARD_IRQ },		\
 		      .func = srcu_defer_drain },			\
+	.srcu_reader_flavor = flavor,					\
 	__SRCU_DEP_MAP_INIT(name)					\
 }
 
@@ -57,29 +58,43 @@ void srcu_defer_drain(struct irq_work *irq_work);
  * Tree SRCU, which needs some per-CPU data.
  */
 #define DEFINE_SRCU(name) \
-	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
 #define DEFINE_STATIC_SRCU(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
 #define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
 #define DEFINE_STATIC_SRCU_FAST(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
 #define DEFINE_SRCU_FAST_UPDOWN(name) DEFINE_SRCU(name)
 #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
-#define DEFINE_SRCU_ATOMIC(name) DEFINE_SRCU(name)
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
+#define DEFINE_SRCU_ATOMIC(name) \
+	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, SRCU_READ_FLAVOR_ATOMIC)
 #define DEFINE_STATIC_SRCU_ATOMIC(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+	static struct srcu_struct name = \
+		__SRCU_STRUCT_INIT(name, name, name, SRCU_READ_FLAVOR_ATOMIC)
 
 // Dummy structure for srcu_notifier_head.
 struct srcu_usage { };
 #define __SRCU_USAGE_INIT(name) { }
 #define __init_srcu_struct_fast __init_srcu_struct
 #define __init_srcu_struct_fast_updown __init_srcu_struct
-#define __init_srcu_struct_atomic __init_srcu_struct
+#define __init_srcu_struct_atomic(ssp, name, key) \
+({ \
+	int __ret = __init_srcu_struct(ssp, name, key); \
+	if (!__ret) \
+		(ssp)->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC; \
+	__ret; \
+})
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 #define init_srcu_struct_fast init_srcu_struct
 #define init_srcu_struct_fast_updown init_srcu_struct
-#define init_srcu_struct_atomic init_srcu_struct
+#define init_srcu_struct_atomic(ssp)					\
+	({								\
+		int __ret = init_srcu_struct(ssp);			\
+		if (!__ret)						\
+			(ssp)->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;\
+		__ret;							\
+	})
 #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
 
 void synchronize_srcu(struct srcu_struct *ssp);
@@ -148,7 +163,11 @@ static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 void srcu_barrier(struct srcu_struct *ssp);
 
 static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
-#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
+#define srcu_check_read_flavor(ssp, read_flavor) \
+	({ \
+		u8 __f = (ssp)->srcu_reader_flavor; \
+		WARN_ON_ONCE(__f && !(__f & (read_flavor))); \
+	})
 
 /* Defined here to avoid size increase for non-torture kernels. */
 static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 22f7716cbb0e..873b30ccf563 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -42,6 +42,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 	ssp->srcu_gp_running = false;
 	ssp->srcu_gp_waiting = false;
 	ssp->srcu_atomic_gp_flag = 0;
+	ssp->srcu_reader_flavor = 0;
 	ssp->srcu_idx = 0;
 	ssp->srcu_idx_max = 0;
 	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
-- 
2.43.0

