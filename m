Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68731E857;
	Sun, 27 Sep 2026 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524323; cv=none; b=jtebBA8EpHcNiyw5gRj4k09cOhhFVAGSeHJs1yDYjnxOD53u6IY/lRAlWPSSniWAAivSc5h1XJZgh3N+P1bMh1EF4BbdbrJVPJMrVCbc/XoQDQDkBXQFCSz9tAhijOgHIEvYJukds8EpKxIZdyy3A75obfaHXvjltI6wNBx5Kck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524323; c=relaxed/simple;
	bh=hA0P3QXG4vIUQALa5dP18gAvwez1VjTIFyHeDe3I9TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjU7KJ0nf+iFSXd/uhm1V3+BNaRLIJOFH2Pcngfw5TM0xeiF9Nl/CAgWjRKh0WZq1K9kcxnxV4jMUgX1D8d3cbTOrRlwTQBIONvmODxtqAM9qYaKFme+Y4VfcVnMc6qsRoCDNY0JA6lRjW83Ns27CYmdqUUKPNnviXvBLigR7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=t0FgCivd; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="t0FgCivd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1790524309;
	bh=oBXpuKfAKM6qngbSZJkmYnuEFIrisykwM4g9m2Jhhyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0FgCivdUd/ZN6DEej4+TouomfjWWzJHcZvgRbEL+hG+CpJR5bARBkkji106Vrvcd
	 NYHorOhxDclufSZcXzbEd/AMg//kiFQolPUS21Ca0AnNW4T6h2U+FNR3w4v6SSIGRn
	 0Qwfia/S72MD87hSGm2NRzVpSlWHMC1uO0ETnCEF67J7JPursUVaMlwVJCI0C6ERBs
	 IxkfPu4LDMeo3OeQVX6fXiFiJm9eHwhES3JHSQzBVfKe3fBWnGkxk8d6zBgV2WwiRm
	 o10GzXdY0KMNn77VXY8G7twbmBi084eizTj95sZOhvMtXrgVKJr1d90hgi8WsxbGMC
	 81OWQU5J42YBQ==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ht87n3GvQzhGx;
	Sun, 27 Sep 2026 11:51:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: [PATCH hazptr 1/4] hazptr: Fix two-phase hazptr_synchronize race with detach
Date: Sun, 27 Sep 2026 11:51:28 -0400
Message-ID: <20260927155134.4740-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
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

