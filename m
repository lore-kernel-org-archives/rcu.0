Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FE4F5DF2;
	Fri,  9 Oct 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570686; cv=none; b=MDBaBkkGuyw4KnaVOOOsWPcg/UydJ4LuAwzit8bcDyplEt/qCO/JFDxzUeTdYDok64VXkuJJBpyb5+Bm/uYTwVZxxtI05lf/nI7O1S1B80IC5xBq3huTpnBamWPUXIlDtj5j95Z6v/26MN/WvOlPoBCiRSFPQYtTDax8Lm69zDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570686; c=relaxed/simple;
	bh=q+YbLiYK87MYhqvupnzSJ/VKIJAWqCMl+ACSG820VWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=addEAt0W5ybtMVRijmFLrAok2BGXlnLHcg0+9cgsk+Kgvk9NtpsRdWbWY9yNdKaR5rtC7W/4xWVKldfWGqL2Vd6VbUA2O0+bSqMAlXl4Ll9cjJ+eolp+4TJf1O2zzOHYNb98DLNH4yU6i0K6iV2kW0BtCrMkJuLBInCTexwmAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QH29pLU8; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QH29pLU8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1791570109;
	bh=Cup/SgEH7yRhYK9bMqbPCbZ0T4VmAsjlMvtSBzc9wMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QH29pLU898cT2hOdg7SqCHeesNB0FfUtZ9Go2QFh+Ra/0Dp9whvkIGzRLyZvTBKCK
	 H1BWmd3yC1gKqVHIdnfs5ICMJO4sk8I6WqBxgbdG72AqOAwpAYuKbEMYObKEh3RvmW
	 5qCt+0VpuvSZPgz/i0VY6ml5dqdrKCaBBtAYWMejh7SJtSsIP6nVc9VUjxVzgYN0F3
	 40fLiagX5YhpZc4LHlwyiShjUsbLa6NN6Jg1G0Sv88O5KG1KVAZ+fyfyBBD+iB4XvL
	 u6Wja3i3RYvYB7xrJlkYyDqshG+ozYxciOVnDm04O+VeziCYjbw50T9V139gMDUozG
	 YiaslzM72uSZA==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j1ZvK3gSSzkl1;
	Fri, 09 Oct 2026 14:21:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH hazptr v2 1/4] hazptr: Fix two-phase hazptr_synchronize race with detach
Date: Fri,  9 Oct 2026 14:21:32 -0400
Message-ID: <20261009182142.6311-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
References: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Boqun Feng pointed out that a detach happening concurrently with
hazptr_synchronize can miss a slot. Indeed, scanning the per-CPU
slots needs to be done *before* scanning the overflow lists. Fix the
implementation accordingly.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Boqun Feng <boqun@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
Cc: Lian Wang <lianux.mm@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
---
Changes since v0:
- Load the new overflow list phase word in "hazptr_chain_backup_slot".
- Rename the lock to hazptr_phase_lock to make it clear that it
  protects both the wildcard and the overflow list phases.
---
 kernel/hazptr.c | 50 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index d3d1050d92cf..13faa5ba7677 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -13,6 +13,8 @@
 #include <linux/list.h>
 #include <linux/export.h>
 
+static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the wildcard and list phase flip. */
+
 /*
  * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
  * hazptr_synchronize forward progress even with a steady stream of readers.
@@ -20,10 +22,12 @@
  * This also affects the overflow list selection: the current list used by
  * readers is array[(unsigned long) hazptr_wildcard - 1].
  */
-static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
 void *hazptr_wildcard = (void *) 1UL;
 EXPORT_SYMBOL_GPL(hazptr_wildcard);
 
+/* The current overflow list phase. */
+static unsigned int hazptr_overflow_list_phase;
+
 struct hazptr_overflow_list {
 	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
 	struct hlist_head head;		/* Overflow list head. */
@@ -53,6 +57,12 @@ void *flip_wildcard(void *wildcard)
 	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
 }
 
+static
+unsigned int flip_list_phase(unsigned int phase)
+{
+	return 1 - phase;
+}
+
 static
 bool is_wildcard(void *addr)
 {
@@ -178,15 +188,12 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
 }
 
 static
-void hazptr_scan_period(void *addr, void *scan_wildcard)
+void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
 {
-	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
 	int cpu;
 
 	/* Scan all CPUs slots. */
 	for_each_possible_cpu(cpu) {
-		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
-
 		/*
 		 * Scan CPU slots.
 		 * Forward progress against recurring wildcards is guaranteed
@@ -199,6 +206,17 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
 		 * to acquire that same hazard pointer value.
 		 */
 		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
+	}
+}
+
+static
+void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
+{
+	int cpu;
+
+	/* Scan all CPUs overflow lists. */
+	for_each_possible_cpu(cpu) {
+		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
 
 		/*
 		 * Scan backup slots in percpu overflow lists.
@@ -218,6 +236,7 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
  */
 void hazptr_synchronize(void *addr)
 {
+	unsigned int scan_list_phase;
 	void *scan_wildcard;
 
 	/*
@@ -235,18 +254,29 @@ void hazptr_synchronize(void *addr)
 	/* Memory ordering: Store A before Load B. */
 	smp_mb();
 
-	guard(mutex)(&hazptr_wildcard_lock);
+	guard(mutex)(&hazptr_phase_lock);
+
+	/* Scan per-CPU slots. */
 	scan_wildcard = flip_wildcard(hazptr_wildcard);
-	hazptr_scan_period(addr, scan_wildcard);
-	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
-	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
+	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
+	WRITE_ONCE(hazptr_wildcard, scan_wildcard);			/* Flip the current wildcard. */
+	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
+
+	/*
+	 * Scan overflow lists *after* scanning per-CPU slots. See
+	 * hazptr_promote_to_backup_slot() for scan ordering requirement.
+	 */
+	scan_list_phase = flip_list_phase(hazptr_overflow_list_phase);
+	hazptr_scan_overflow_list_period(addr, scan_list_phase);
+	WRITE_ONCE(hazptr_overflow_list_phase, scan_list_phase);	/* Flip the current list phase. */
+	hazptr_scan_overflow_list_period(addr, flip_list_phase(scan_list_phase));
 }
 EXPORT_SYMBOL_GPL(hazptr_synchronize);
 
 struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
 {
 	struct hazptr_overflow_list_flip *overflow_list_flip = this_cpu_ptr(&percpu_overflow_list_flip);
-	unsigned int list_idx = (unsigned long) READ_ONCE(hazptr_wildcard) - 1;
+	unsigned int list_idx = READ_ONCE(hazptr_overflow_list_phase);
 	struct hazptr_overflow_list *overflow_list = &overflow_list_flip->array[list_idx];
 	struct hazptr_slot *slot = &ctx->backup_slot.slot;
 
-- 
2.43.0

