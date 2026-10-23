Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750787;
	b=v7VYG+u0g+BD2V98fJfUDJ4r4pCINo7rePklq4+YmtOqJRkZ/YX3jxcMosXH9l+EW2Ha
	 3xI6ntqFQc7dwey3GmrEIBfxZ0r8pzRitW8GFZLOMbCoeUlZ7lkGszBmTpW7fA988k61V
	 iDt4jGKpxro8oRt9cS8muYpw86FxWfEUvmxlc1ZZHUjlFaBXmzkVTyvqov9LiH0buJNrN
	 cRWNISrZkyekTfFzIr21KEaeEYFMTqbvSLbStBi++No4SA9pCFwA7ajwRT/6J2a23flvN
	 3pHvSFDaWzxAN8w4OW3LCtUtokofqORqXSIBE9Oze/ya+XYmdqHwJK/NvjWnu94VguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ysCvLZPGVtFGxSlHiZpjqvLUwJkgfMWFoc/Ns4wjzwM=;
	b=Um4adejjZgio/JR2398tvJLBFTRJvEqBLMNLOmVuM9MpXPQMfW2a8zo6R6mJgV+DSKEv
	 5J1QZShSlFG6h0uIaGiPqxIykCTuB/LPDHkSAPrtO8sTwiucNinlqFzx3MnvxkWHPs26v
	 FgV9gbFDybh4sO52E3b7EW+S4tjnrcMgfA0W1BXj8RnPRdgPdNksIOhgDK0TH6cvyeNVi
	 yRqR2XlSK0KAujoBNvYB/YvYbVXZI80+iViBx7piP5Bi/DKfx5MDYVCw6ItrcorZSQZuX
	 p7DXjm7v8ddBmumm/RK9JEWG26xtTJvk5sCyWWZqxYjT4rdaVsjKlyY4/lEiTlIlwjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZG7+Ukz8;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363F606A31A
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0363F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZG7+Ukz8
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-14fd9dafb0dso20602c88.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750786; x=1793355586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ysCvLZPGVtFGxSlHiZpjqvLUwJkgfMWFoc/Ns4wjzwM=;
        b=ZG7+Ukz8SjtUGehbJKVuTa1/UwNmO84XZM68Wpfmck/BPHDtnJXsuEez9Wkbo2fZR/
         VWDSM0I/2IaYpJvkE5mgSXzfmBJCyct0dBZeYyJi/qX8xMCl/JtOLX7Bm+abk4+Jug65
         rwtDXLPaKQr7W3ZMJTEy/uIe85jCVSK2T2atQQF7Q23WDTPXLJu0kXE9o5jL0JQkfVT2
         u/tnQGTaQg2mSDGTJJ76iNaPcDAJ4DWDedpAL3aMyburXZ+nHOfHrTxDJm2/rtn2m4Kv
         rkhFsNpa7Vr1mnNSKth6F7hYG9LcA7hCCmGQRytk9dY4I1WQEBJ/4Cp9KOSf9vTA6LD8
         CPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750786; x=1793355586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ysCvLZPGVtFGxSlHiZpjqvLUwJkgfMWFoc/Ns4wjzwM=;
        b=td+pbel9iqTLtla3T2XHGGinEcyBx9oz2rD/WpB9loySz9w9H/UmewmkwddkNGdNeE
         GvIW8IYg05ORm4gUz2Buy8PoZgaD+KgwysKuhHgWK6IbldTpNNlCp+6M/Ai1p4bXfI9S
         ieI4MB6FChoqT6XIvqryNdaqZWL618gb4O1gjkBh0ecNh/Dvns55AwobqtNY9I0xvUrQ
         iNCUKIGeDm0vXKFMsFAxDLzDkAQSZKgNxw7qwG5tfwU+nfuEAYvUbhC0W4aQv/Drq5Xf
         U/4/a9HJ76znpG/kQaUAtJn5JQPblxlBKUUBZwxoVhZuOOrnMmeRjov09T0UEo++FY0/
         m+lA==
X-Forwarded-Encrypted: i=1; AKwUvBxN6Gw3aW8gF2qB22EQ/PWk2VZyYEXgXRzwQTL175KNGLJgamLR1HLGyHCGO7X56+de2vs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL50zBDRAGUesClBp7jrJ2coScuzOJdEjCS6XSWcnZqkvLfNuY0
	a8XF/hgu7307EkkPZPrgMgo+Bf0w4gBeOuM0Bn5x2kOLAwx11nGXSfOZ
X-Gm-Gg: AYBFou3G8kWzL6kTCfqbkCLyEAdtrUTb8km9hCHclfjXwxKTDNp4VXN3MQxdYyPODBs
	Rh6lrb+SzXUwKWbTORQS4JmE7XZEvwvlZCbq55m3lhpHd2jKgj9jFY6uiB5SppC6boW4pKZOIqX
	gohhOgs9A0tlb1idrnwQvkM9o7DJNVHZmphXKf/kQTmn2VqFTiIVmtx00qlZbwW3N/9qJe3wzqT
	mbtnnWSAT27vpiWEW58CIENZuK1S2EajsRCOapqbE/Ti/awEWZxsQbyGVvhurndTYQb8PRbVQyr
	RhuQ+KLZFECc/6KlNyfvapRq0c/aKJBUkpvIjL/sEMwdZxXvwIxYPhNavFxZ6vqflcZeslMKT9G
	Pew14eu+NRtQNcM6HW7GTLDfM5bW7onXqyqEyvQfJPLa3p7AP5M0Irlf7qKvzv59S5X506so9Kq
	wLZL9H4In3k6PB7c134YRDS0zHqe60ko9ESYZoUYXxfSn/vmf92Ky7BIGKcYO2qT5gSaqxVU9Jw
	3VVWqoG4vgLgH4w/0cicFfFmDtbmBh1KOoG8s+jg/i8nMe5rumYtFZd3JDorsevhPb82DGRUA==
X-Received: by 2002:a05:7301:490c:b0:367:941:c253 with SMTP id 5a478bee46e88-369d9730ee9mr2529100eec.11.1792750785795;
        Fri, 23 Oct 2026 03:19:45 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:44 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 7/9] srcu: Detect duplicate callback enqueue at registration
Date: Fri, 23 Oct 2026 18:18:39 +0800
Message-ID: <20261023101841.2910719-8-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023101841.2910719-1-kunwu.chan@gmail.com>
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
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

Move the duplicate-callback check from srcu_do_enqueue() to
__call_srcu() entry so that detected duplicate registrations
are rejected before they reach the deferred-list enqueue path.
Report the callback address, function symbol, and object
information, rate-limited to the first three occurrences.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/srcutree.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1993ddbdb828..3838d9fdf532 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -27,6 +27,7 @@
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/srcu.h>
 
@@ -1511,12 +1512,6 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
 			    rcu_callback_t func, bool do_norm)
 {
-	if (debug_rcu_head_queue(rhp)) {
-		/* Probable double call_srcu(), so leak the callback. */
-		WRITE_ONCE(rhp->func, srcu_leak_callback);
-		WARN_ONCE(1, "call_srcu(): Leaked duplicate callback\n");
-		return;
-	}
 	rhp->func = func;
 	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
 }
@@ -1529,6 +1524,8 @@ static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
+	static atomic_t doublefrees;
+
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
 
@@ -1539,6 +1536,16 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
 		return; // Leak the callback rather than corrupt SRCU state.
 
+	if (debug_rcu_head_queue(rhp)) {
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
+			       __func__, rhp, rhp->func);
+			mem_dump_obj(rhp);
+		}
+		WRITE_ONCE(rhp->func, srcu_leak_callback);
+		return;
+	}
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(rhp);
 
@@ -1554,6 +1561,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		if (READ_ONCE(sndp->draining) && !in_nmi()) {
 			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
 				  "call_srcu() re-entered during callback drain; leaking callback\n");
+			debug_rcu_head_unqueue(rhp);
 			return;
 		}
 		sdp = this_cpu_ptr(ssp->sda);
-- 
2.43.0

