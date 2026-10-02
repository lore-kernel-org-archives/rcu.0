Received: from mail-pj2-f33.google.com (mail-pj2-f33.google.com [74.125.227.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EED4FDA6D
	for <rcu@vger.kernel.org>; Fri,  2 Oct 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960984; cv=none; b=JcQ3+CqXTIsBSVIiQihSYfM52KVpytcg2ExfqMypw6+ogoL1ZAO8lUljjAFvay1upDQ0t8YI33KFpBkNcCJnDbuj6leO+7/YetuDUiGkcXmFHbgD1QCbWwdugRy6E01PP2sBPSQAaO6Zz4srO74A0FBe8Yz3B9wLLQKyoAXfI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960984; c=relaxed/simple;
	bh=SrwdHIX17te8vYpXerlPrT9uvUAXxdpliS9rJVsJABc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmC99gBX6f6eD57JpUyl0SMmNDkCmDhywmKQvNiMDqvoWYk+YZ8+Xhqs4tdyFKAdKemZPVmtJqBNkTWGPbWBFvTcNJEfnbLQy7SB+DUGh279ggKwfd62LL49VX5gq/5EO5nhh966jMW4apM0vvXgxVR537HbDopWlvT/kK6vOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un49n1N4; arc=none smtp.client-ip=74.125.227.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un49n1N4"
Received: by mail-pj2-f33.google.com with SMTP id d9443c01a7336-2e2e688de2eso29058765ad.3
        for <rcu@vger.kernel.org>; Fri, 02 Oct 2026 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960977; x=1791565777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkxMy1Mx1AmQEa8UR49QVnQhvwoc8QcMpxJihofQjBM=;
        b=Un49n1N4XuFz5RmuyPfRxTtvHHSf6s5cZOkFeAE1cBpsf//Ia+2rDlkNOxNoYLTqbr
         mMTFYrnaGxnVhzI1YBGtA4AJC+f5q8D/XU7kdV5QIJueYkrjkKj2SBTbXWg6d0fqRd8x
         XKXNbuUD48bIr2EUVw0O0p1yBwugB7O8nNJIeX9zDGx2Le056nBNtY130+tjPmNMfrWW
         uE57MBdLqhdFjxVeeuKTAjbelAwQqaWgv4kIFna9qv7TQT+ey/Qwebiy8ptKgrF2/NET
         9qSxrjKOCrmryGHZ1ireXD3mbVpww9l69kroAnmKFfEQyOuXdW/RmQh7TmgS12B4ji9M
         UIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960977; x=1791565777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kkxMy1Mx1AmQEa8UR49QVnQhvwoc8QcMpxJihofQjBM=;
        b=gATKV+xv+R3BJq6bi0wf+uhB9N8l4mNR/IrVxReWe1sM5ubvWvmumHPPv6NIUttSlT
         gWf1ItcZLFGKkWWgogkjjG0iIogHjxjGrZJnAiGqGvQKtrsX+gi0z2k1DDBcboCN/vad
         Kj3ZefvtQx7o07CxK5hU1cjl5o4m0vWCrPOhITHjK+NiZWy9ah4g2+Np5vb5JTsyuGZy
         N7poa3z9kOHJjTU8OsvV2S0UsxZey7w3+zokzV/n6JGK2rQbfYr7QkHIDPQpwOfqp+dT
         nj2QCjCXO2SmdC51wTp/leUg4TD0OVouspxfjaUTZVCpXOcAgDQehwEP0a8WVDuQL8Sm
         MSoA==
X-Forwarded-Encrypted: i=1; AKwUvBwMHlgU4mXJ4vYlWYoIr///Uq9R82hqp9fgNN1v23vltpzWiz8p+ET2uWM04wsGLmColtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1BPWukOJbOUJ1dTUUq+5gwsLB98zv3EMTPG25VD/uBbkwbPfJ
	pXMIZ/wGn62eHTwPnAF3Wh2TH/f9m/poMDmU3qJi6ipcQKU363cf0nQo
X-Gm-Gg: AYBFou2Q7+fBLJ5sYO+b1QH2ipCphbqjDJ8Ojs3+Kz334/drWWOAVm2kiZzKaNSc0B1
	tud99UkAlLy81A6PArKsEySU6rc9eKdj/wfy+VDwCHtN/AkA6Ifeng+1yM0b69MU/jaM9Fh0NjJ
	iBVcIcCysM8SlcRQZDGHEjNYai9NcJJqWZeEZD4RoP1V3jKVpDsQTPMmE32gROITjsF8ebMoPWs
	i9Jh087hj3qvPrDeSUWFe1fo83jbDdCnU/RdIALaDeZOjHuvuU2t/mh+e+bpNuW1zXIG1Ka5K/9
	Ox2HgD5SjRJGd90g43DhVKjCOdf0llquMBXRa5m3bXVQiix4bGsM5HOUCpc3gxKqahXC3RrMdeX
	d1u7mm0JdJ8XiV/Y4A4MLv78s5V2ATX5hMA1uapuX06sT/WFe0zi/6f2upnN4oiGZ4MLwJTio+n
	mYdA5On7leTpLUTlsQVz5+bl7sNmlNbd3BYrddggjcu2WGgFSpBE0DXkrAU//xrnqlMNIM7mrHF
	2BMDZeUJ+kAwXAesw==
X-Received: by 2002:a17:90b:134e:b0:3a4:aa26:21c7 with SMTP id 98e67ed59e1d1-3a6ceae5a45mr3035280a91.25.1790960976257;
        Fri, 02 Oct 2026 10:09:36 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:09:35 -0700 (PDT)
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
Subject: [PATCH RFC v2 03/15] hazptr: scan all per-CPU slots before overflow lists
Date: Sat,  3 Oct 2026 01:08:35 +0800
Message-ID: <20261002170847.3653663-4-kunwu.chan@gmail.com>
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

Boqun Feng pointed out that a promote racing a scan can cause the
scan to miss a hazard pointer: hazptr_promote_to_backup_slot()
chains the backup slot into an overflow list before clearing the
per-CPU slot, so the scan must observe the old location before the
new one.  The scan currently visits each CPU's overflow lists right
after that CPU's per-CPU slots, so a promote that moves a hazard
pointer from a per-CPU slot of a later-scanned CPU into an overflow
list of an earlier-scanned CPU can be missed.

The direct two-phase scan has a related race because the overflow
list selection follows the wildcard phase: a promote racing the
wildcard flip can move a backup slot to the list not covered by the
second phase.

Fix this by scanning all per-CPU slots before any overflow-list
slot, in both the shared-scan walk and the direct fallback scan.
Give the overflow lists a flip phase of their own, independent of
the wildcard, so each list is scanned while it is the non-live one:
new backup slots are chained to the other list, preserving forward
progress.

The same race was also addressed by Mathieu Desnoyers.

Fixes: 0b8114b25f17 ("hazptr: Implement two-phase wildcard scan")
Reported-by: Boqun Feng <boqun@kernel.org>
Link: https://lore.kernel.org/all/20260925195958.4766-1-mathieu.desnoyers@efficios.com/
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/hazptr.c | 88 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 24 deletions(-)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 900ba35de2cb..799784f698ed 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -23,13 +23,20 @@
  * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
  * hazptr_synchronize forward progress even with a steady stream of readers.
  * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
- * This also affects the overflow list selection: the current list used by
- * readers is array[(unsigned long) hazptr_wildcard - 1].
  */
-static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
+static DEFINE_MUTEX(hazptr_phase_lock);
+/* Protect the wildcard and overflow-list phase flips. */
 void *hazptr_wildcard = (void *) 1UL;
 EXPORT_SYMBOL_GPL(hazptr_wildcard);
 
+/*
+ * The current overflow list phase. Independent from the wildcard so that the
+ * overflow list scan can be placed after the per-CPU slot scan while still
+ * scanning the non-live list: the current list used by readers is
+ * array[hazptr_overflow_list_phase].
+ */
+static unsigned int hazptr_overflow_list_phase;
+
 struct hazptr_overflow_list {
 	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
 	struct hlist_head head;		/* Overflow list head. */
@@ -59,6 +66,12 @@ void *flip_wildcard(void *wildcard)
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
@@ -184,15 +197,12 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
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
@@ -205,12 +215,22 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
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
+	/*
+	 * Scan backup slots in percpu overflow lists.
+	 * Forward progress is guaranteed by scanning one list
+	 * while new elements are added into the other list.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
 
-		/*
-		 * Scan backup slots in percpu overflow lists.
-		 * Forward progress is guaranteed by scanning one list
-		 * while new elements are added into the other list.
-		 */
 		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
 	}
 }
@@ -285,10 +305,13 @@ static struct hazptr_scan_state hazptr_scan;
  * Walk all slots and return true if @watch is present.  If @bloom
  * is non-NULL, record observed non-wildcard addresses in it.
  *
- * Per-CPU slots are examined before overflow-list slots on each CPU
- * to preserve the acquisition ordering required by the promote path:
- * synchronize must observe the per-CPU slot release before the
- * overflow-list entry can be missed.
+ * All per-CPU slots are examined before any overflow-list slot: a
+ * promote (hazptr_detach() or a context switch) moves a hazard
+ * pointer from a per-CPU slot to an overflow list by chaining the
+ * backup slot before clearing the per-CPU slot, see
+ * hazptr_promote_to_backup_slot().  Therefore the scan must observe
+ * the old location before the new location for every slot/list
+ * pair, including pairs on different CPUs.
  */
 static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
 {
@@ -297,9 +320,9 @@ static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
 	if (bloom)
 		hazptr_bloom_reset(bloom);
 
+	/* Scan all per-CPU slots before any overflow-list slot. */
 	for_each_possible_cpu(cpu) {
 		struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
-		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
 		unsigned int idx;
 
 		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
@@ -313,6 +336,10 @@ static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
 			if (bloom && v && !is_wildcard(v))
 				hazptr_bloom_add(bloom, v);
 		}
+	}
+	for_each_possible_cpu(cpu) {
+		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
+
 		for (int i = 0; i < 2; i++) {
 			struct hazptr_overflow_list *list = &overflow_list_flip->array[i];
 			struct hazptr_backup_slot *b;
@@ -359,14 +386,14 @@ static void hazptr_scan_do_cycle(void)
 	struct hazptr_waiter *w, *n;
 	LIST_HEAD(done);
 
-	mutex_lock(&hazptr_wildcard_lock);
+	mutex_lock(&hazptr_phase_lock);
 
 	mutex_lock(&hazptr_scan.lock);
 	list_splice_tail_init(&hazptr_scan.pending, &hazptr_scan.scanning);
 	mutex_unlock(&hazptr_scan.lock);
 
 	if (list_empty(&hazptr_scan.scanning)) {
-		mutex_unlock(&hazptr_wildcard_lock);
+		mutex_unlock(&hazptr_phase_lock);
 		return;
 	}
 
@@ -391,7 +418,7 @@ static void hazptr_scan_do_cycle(void)
 			list_move(&w->node, &done);
 	}
 
-	mutex_unlock(&hazptr_wildcard_lock);
+	mutex_unlock(&hazptr_phase_lock);
 
 	list_for_each_entry_safe(w, n, &done, node) {
 		list_del_init(&w->node);
@@ -463,6 +490,7 @@ static void hazptr_synchronize_queued(void *addr)
 void hazptr_synchronize(void *addr)
 {
 	void *scan_wildcard;
+	unsigned int scan_list_phase;
 
 	/*
 	 * Busy-wait should only be done from preemptible context.
@@ -486,18 +514,30 @@ void hazptr_synchronize(void *addr)
 	}
 
 	/* Fallback: use the direct scan path. */
-	guard(mutex)(&hazptr_wildcard_lock);
+	guard(mutex)(&hazptr_phase_lock);
 	scan_wildcard = flip_wildcard(hazptr_wildcard);
-	hazptr_scan_period(addr, scan_wildcard);
+	/* Scan per-CPU slots. */
+	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
 	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
-	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
+	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
+
+	/*
+	 * Scan overflow lists *after* scanning all per-CPU slots, see
+	 * hazptr_promote_to_backup_slot().  Flip the overflow list phase
+	 * between the two lists so that each list is scanned while it is
+	 * the non-live one.
+	 */
+	scan_list_phase = flip_list_phase(hazptr_overflow_list_phase);
+	hazptr_scan_overflow_list_period(addr, scan_list_phase);
+	WRITE_ONCE(hazptr_overflow_list_phase, scan_list_phase);
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

