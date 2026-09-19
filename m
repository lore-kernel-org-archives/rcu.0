Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578C30AAA6;
	Sat, 19 Sep 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776066; cv=none; b=b7pazorF+bqWx+WDvf0msvo58kkgx2BH14CUL808wpta3rB2lBXLNj2bGbLufOD8OaAWJbVAtR6VcrgNwZGLtlmnUJ5tc6FEkeIP4+RF3cQt81dd8aQQuPcE3cCaKZOmucSnYe8EdzgPQDEknLH6IltJWVWfJbgJd2+T2InukqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776066; c=relaxed/simple;
	bh=GkwfLf9gbindh3+AmOseVDauZbFQvsI/Kr/naW6n2L8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q06S5oPmEFV2WaQSvOi7RfMWPBjCG+SoZmpj/EcDhP2AFO9Cu1H2nhlR0GSalaMQLUFublhtYxysKxhGOK/zVgfq6kMAsPQ3JiibO0UvlDCUA5uMggJdaDhWbEcl3Ps56mi8t2zYH+29qaUUiYNo2IzQBfVrgcrc2TrN4kyAZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNHKiWCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNHKiWCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6199A1F00903;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=qiKSNVlE1hC8lwKn5N172cPvdyb0utd+S03kXu64O0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SNHKiWCTdWyzeTm2vMU2r1a+UI6iTY2gVSzbAKHRVEe0yXPxpEVSjjPj8MfOOWhtI
	 ju2AXDua7ryp+/+6rZqNBDKpiY2wRslIQ2q2CQJdDAtBP/YbPaezrBC9tHdLietwUm
	 VQYFSC7Bhiw45szKWhoXMZJlxsBSdrOi65gNqMqOSATu1+PBBjmxPaCzluqAzuhSe9
	 ++sy4t1jx7HuxBwQoMsBeW2eHGdWJHFxmAt9Uf5xrjcfG6DSauaRKiLVrNCbiCcs8Z
	 6Cjn3fma7VOGZslRINiJeZ39uIRNWTf7HKb10HhyzpaMtEn6TrSVPIKEwU0DFRYooM
	 fNJaFCSXDhhJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 805AFCE0E85; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 19/28] hazptr: Permit detaching hazard pointers from contexts
Date: Fri, 18 Sep 2026 17:00:47 -0700
Message-Id: <20260919000056.3132131-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Provide a new hazptr_detach() function that detaches a given hazard
pointer from its acquisition context.  This context might be a task or
an interrupt handler.

[ paulmck: s/hazptr_detach_from_task/hazptr_detach/ per Mathieu. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 include/linux/hazptr.h | 55 ++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index b121f7779cda..8197a51b9f7a 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -98,6 +98,41 @@ bool hazptr_slot_is_backup(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
 	return slot == &ctx->backup_slot.slot;
 }
 
+/* Internal helper. */
+static inline
+void hazptr_promote_to_backup_slot(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
+{
+	struct hazptr_slot *backup_slot;
+
+	backup_slot = hazptr_chain_backup_slot(ctx);
+	/*
+	 * Move hazard pointer from the per-CPU slot to the
+	 * backup slot. This requires hazard pointer
+	 * synchronize to iterate on per-CPU slots with
+	 * load-acquire before iterating on the overflow list.
+	 */
+	WRITE_ONCE(backup_slot->addr, slot->addr);
+	/*
+	 * store-release orders store to backup slot addr before
+	 * store to per-CPU slot addr.
+	 */
+	smp_store_release(&slot->addr, NULL);
+	/* Use the backup slot for context. */
+	ctx->slot = backup_slot;
+}
+
+static inline
+void hazptr_detach(struct hazptr_ctx *ctx)
+{
+	struct hazptr_slot *slot;
+
+	guard(preempt)();
+	slot = ctx->slot;
+	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
+		return;
+	hazptr_promote_to_backup_slot(ctx, slot);
+}
+
 static inline
 void hazptr_note_context_switch(void)
 {
@@ -106,27 +141,11 @@ void hazptr_note_context_switch(void)
 
 	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
 		struct hazptr_slot_item *item = &percpu_slots->items[idx];
-		struct hazptr_slot *slot = &item->slot, *backup_slot;
-		struct hazptr_ctx *ctx;
+		struct hazptr_slot *slot = &item->slot;
 
 		if (!slot->addr)
 			continue;
-		ctx = item->ctx.ctx;
-		backup_slot = hazptr_chain_backup_slot(ctx);
-		/*
-		 * Move hazard pointer from the per-CPU slot to the
-		 * backup slot. This requires hazard pointer
-		 * synchronize to iterate on per-CPU slots with
-		 * load-acquire before iterating on the overflow list.
-		 */
-		WRITE_ONCE(backup_slot->addr, slot->addr);
-		/*
-		 * store-release orders store to backup slot addr before
-		 * store to per-CPU slot addr.
-		 */
-		smp_store_release(&slot->addr, NULL);
-		/* Use the backup slot for context. */
-		ctx->slot = backup_slot;
+		hazptr_promote_to_backup_slot(item->ctx.ctx, slot);
 	}
 }
 
-- 
2.40.1

