Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0782472A2;
	Thu, 16 Jul 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161097; cv=none; b=Br8ZWjKzdq7LGdZ8E2IPBXaQwQsTSQL1EvsyHDHmEIv/BXsBbbu/Kg3bKF4WFC9LtBbLLg10aWL+0QLfGJNeIuwUPDz25nHQr6e5QaR0ODLURrc/FvUrzM3ltyJE/JQfaEAD2Vm17mEjcXlv7Tj4o0G8mlfFGWcj3D65BqFHPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161097; c=relaxed/simple;
	bh=g33j4FMeJZmbihNcQPD8E3FIRztKnqE/UjXk5EguQa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXVKZ0X/tVxqLcusJ22xtuT5ToUiflrufdkDUK0LVdn+TVNrHmD1drS6aNWRBtibowNtwXAgJVIhGebEzub317cysCoSoyaVfcnWlb6XeiNsxVRw4iqQb5WST69en+35zgFkvi0MX6j1NTgxMmjk2aLRx39FBBQ0kSRT2W3DsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWDMh877; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWDMh877"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEEF1F01562;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=EKacui6kllvNGfuSReTdOlVtHpqrAdOu+NWLYtwgPkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWDMh877XUQepw0OsbHKLovZp/FjITWiGZvqowJXxyVIrFXzqlj9XYHTVDCUosWes
	 zaNy4ycAzxm7zN8BuIMz3H+/eKGIrUhlhfgCbbrrlJFy/kWhu0lJ3QD8vNYHvy8u71
	 aPxVEH5e/MAZV87AD7F5MQsLg1WYJ1kscm/BHU2/JOxZ+t3PdOQdZPb84ARfuiBUsY
	 EBDA7RAZ9hZZBspwnEB93SOaGiG+pbkLC171m0CmmpfolfvjF0jrnsShQ5ts8CeQ1v
	 xjnURL73cLAGaw7zDEGGZ/Nq/39WKJx0kjEZJiwxlSBQK5GUBoyUtQ8+85i/NaZ04W
	 ZhcwAAeC9jgZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5184CCE0F72; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 19/24] hazptr: Permit detaching hazard pointers from contexts
Date: Wed, 15 Jul 2026 17:18:04 -0700
Message-Id: <20260716001809.11084-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
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
---
 include/linux/hazptr.h | 55 ++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 461f481a480b9c..fd19579d1260e7 100644
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

