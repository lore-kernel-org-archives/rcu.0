Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811450;
	b=Fj6Xcs6Zk2s06DMUyapjHIuPwArZR7AyWCwuKxIWXBc3wFSFm+ILBLMtS6I8wGAXCIQK
	 MjTTL6i2GLIFAU2s4LmqUPhtkUkz9lUD9hbxNz2LTnoC2KWVIvhZ4fayVSnLtJkqpauzK
	 izpNS2d6sH7roVnLaKz/ihbPk73DHgI2kz5vGL9LwumRy5DXU+VqdeX/SPeB2cmqhNZ4E
	 uM1DscvoY0Fwtz8EVpc6k/EdA9sVyVIX1gfBvpZFG8769VRhON9r087M7w+XSjMF7nKVT
	 PP4Kg2ge4EIh7qsxWCvs54VchWTqrTjWM6xFDTEZe5Jze7+VIIMPT5S8e/+YRXTWdnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/bXC1O9YosHJxDYIJ1dzMZcse+i5XFbEaQqM6b3audU=;
	b=WCJ/5ofJs+5YlS4gkju/qqZM/gEmkyRzzNhS2dRwY2MPO9Zz2/DhqjIgB2PrqrKNrIjY
	 g/YvNYCpNaQ1Ec6z+6Y/J3XzT5+n8GLBMoRDr76GygSAR1n6k7zSr2HdoVNQh8KD1APUY
	 HX42hQ6vk5LmTatQOJdzYqCT2W1EE6dwLzuwPsUU+unmlqgzGFDVQL1nCrdwQ7bgO5tDA
	 n2OgzZLx6gX/z0wUe7vuB0+UEbUQ+INvYS9C8Mv9FwLDxQGU18JwJaaJL7i3jEgKnWE7O
	 L3saLagXiy0opkXXdcyWgDOu7pfwSR/gxCSBydackAlQIqmMbUWiX/xIeIEQ6uLQMxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oERYq9vD;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F4606A335
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B76F4606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oERYq9vD
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1adbf62dd31so1310210c88.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811449; x=1794416249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bXC1O9YosHJxDYIJ1dzMZcse+i5XFbEaQqM6b3audU=;
        b=oERYq9vDte3OR9AG/I37hHAb2AOWwCdiALPPm9kSJa7+KjvO/js3kEDEvedmpE2dOD
         KKPHwO9zWrTs3+mFG0LeYCQl6e+VbEYVXyKHvDEiqFNGKO6gDN4PthaEnwDa8OYo4O/G
         nenVx0Fl0l6tHNOX6g7N/JUZOu/uO/ROT2odCvfbaHYz2HjpyW5Q8G1u0FeXNREcm+Bd
         yjnFaaryaMX2DwqdJ8syR+ngs4BuuOapokcddQcecYMwUUQsRWBQw2n5UpGFlWTkuwHH
         N2R3WRi91ymJ0sotc+VI+xHzcMHPhvmhA59DsZZGrSFUL/0DJ6OVeiHnWeSgsO1dEiwt
         C51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811449; x=1794416249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/bXC1O9YosHJxDYIJ1dzMZcse+i5XFbEaQqM6b3audU=;
        b=zbeNyKZ8N74pgG/vHFdHhAKLRU5Tb9i6+s7B8JsFPauljQjERTNa76C0VBblkjf/vD
         +dieR6R0jru+57AlYp+GhiHlg8NtM6wpB+cEH0kgX9tid8LsVS/obfis0Ot8fX3oujiT
         ZE9BGAcslG3+FPvMSpG3U70Ku/h3CLEuswwLMms7dWlJD2NgKZtjRKff17Lh6i3oByDr
         kNg1sZkytYY0hNr8TzzQHA4YEqwXxHNyh6q2Mp4vPbVAuyogB1EtBxygWi+FVATtytAZ
         o7zoVJCaKX+ScwpEojlQPbsx/rGgjQ70zUG8ml0EmqsBtWI+kpy7irHB7OLaSAHY36LG
         W9BA==
X-Forwarded-Encrypted: i=1; AKwUvBwIkDfqNOAFWFQOSyKi9qf5CWVRUIYt1AKH4gOQoY+TWhuLKxpKAYqyS7UVbpVSHZjvWk8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9utyRcD8ZaWE9b3eVTfPV3AAw+47ov0TEhD7/IPgGGZ/UfRJhZ
	LDCiRslOQbHbWum7td7iBjeTVpvjOVpKMnjmghgOV7abi2E+wZ7L2L7M
X-Gm-Gg: AYBFou0bhA06+xS7q7MJQvDvn475Ol+6ikQovuyCQHJizCWs/rkTyckWUAtyPcYVHP9
	ih74ovtdP3x4UsuyYoA8UrIxMKDi7GrjRfRRURnYRM9Aftdeb46HAEiB4UU0UPaiAITB5o+SZR8
	6pR2Kd6GF2AV2EvhKv3mYQ84GiRiEVrb/InlXIMECPsaa86BzUCLIEhw3Y5txyw0nDGzxZ4xSrp
	NAxCl2PalY9EI3S3bqpRJZdzviTF8K7D/hQkx/4WTAcfJyGW2y57+t1Y2a9uGxW4G9mKWPI+oWT
	K2u+iR7nrjIZCUZ1WtbuB1WMlE3Q06lHvmw8s08EssfXEl1rN1Wjwkrk21yngPUExa/XG1Su3q+
	+94OBW1UVvkDxYw2pCzxZ4NEuL7nOx1N83IkFqxJAxrkAc0nfqxMdeQ4V7e/nry8QyFTe+FXdM+
	erNCgtLzyZT8Ngjr9ysiYO0e+qxlGYP8lCCb4FOG90RQEz+o8NGtvQVVjSzsxybOV9VRHrtMIXA
	pJuc4MxLJuRnTGsm8AoqGPHVe/AEVV1oEKiMvqN/lqC8GIXuRNVLu2iSUL/kXRSff9rO0fjqXpQ
	Jg4A3LiCyS1zB5fJ+Po0W7yM3jXXLcm2bK9ADKY=
X-Received: by 2002:a05:701b:455a:20b0:1b2:42db:8a54 with SMTP id a92af1059eb24-1b242db8f29mr6324036c88.23.1793811448238;
        Wed, 04 Nov 2026 08:57:28 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:27 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
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
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 14/28] hazptr: Add waiter stall detector
Date: Thu,  5 Nov 2026 00:54:32 +0800
Message-ID: <20261104165504.2430480-15-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
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

RCU-CPU-stall-style diagnostic for hazptr_synchronize() waiters
that remain blocked beyond a configurable timeout
(CONFIG_HAZPTR_STALL_DETECTOR, default y; timeout 21s,
CONFIG_HAZPTR_STALL_TIMEOUT).  Purely observational: never
changes synchronization semantics or completion conditions.

The scan kthread checks still-blocked waiters after each cycle.
On timeout, an exact-match walk collects holder blame: per-CPU
slot (cpu, idx), overflow-list entry, and under
CONFIG_HAZPTR_DEBUG the holder's pid, held time, acquire caller,
and task stack (sched_show_task).  Per-holder held times are
evidence, not classification.

/sys/kernel/hazptr/hazptr_stall_count exposes the cumulative
event count.  Adds acquire_jiffies to hazptr_ctx under
CONFIG_HAZPTR_DEBUG so held time can be reported.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/hazptr.h   |  13 ++
 kernel/hazptr.c          | 263 ++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/Kconfig.debug |  16 +++
 3 files changed, 288 insertions(+), 4 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 0fb48518525b..ebf804315a26 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -24,6 +24,7 @@
 #include <linux/percpu.h>
 #include <linux/types.h>
 #include <linux/cleanup.h>
+#include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/ptr_eq.h>
 
@@ -55,6 +56,7 @@ struct hazptr_ctx {
 	bool detach_task, detach_cpu;	/* Whether the ctx has been detached from task/cpu. */
 	int acquire_pid, acquire_cpu;	/* Note the task and cpu number at acquire. */
 	unsigned long acquire_caller;	/* Acquire instruction pointer. */
+	unsigned long acquire_jiffies;	/* Acquire-attempt time, for stall diagnostics. */
 #endif
 };
 
@@ -65,6 +67,11 @@ struct hazptr_slot_ctx {
 struct hazptr_slot_item {
 	struct hazptr_slot slot;
 	struct hazptr_slot_ctx ctx;
+#ifdef CONFIG_HAZPTR_DEBUG
+	int acquire_pid;
+	unsigned long acquire_caller;
+	unsigned long acquire_jiffies;
+#endif
 };
 
 struct hazptr_percpu_slots {
@@ -270,6 +277,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	ctx->acquire_pid = current->pid;
 	ctx->acquire_cpu = smp_processor_id();
 	ctx->acquire_caller = _THIS_IP_;
+	ctx->acquire_jiffies = jiffies;
 #endif
 	if (IS_ENABLED(CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH))
 		return __hazptr_acquire(ctx, addr_p);
@@ -278,6 +286,11 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 		return __hazptr_acquire(ctx, addr_p);
 	slot_item->ctx.ctx = ctx;
 	ctx->slot = slot;
+#ifdef CONFIG_HAZPTR_DEBUG
+	slot_item->acquire_pid = ctx->acquire_pid;
+	slot_item->acquire_caller = ctx->acquire_caller;
+	slot_item->acquire_jiffies = ctx->acquire_jiffies;
+#endif
 	return addr;
 }
 
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 16f6e2acaf87..8de194c07eea 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -16,6 +16,8 @@
 #include <linux/kthread.h>
 #include <linux/swait.h>
 #include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/nmi.h>
 #include <linux/bitops.h>
 #include <linux/bitmap.h>
 
@@ -107,6 +109,11 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 			 */
 			item->ctx.ctx = ctx;
 			ctx->slot = slot;
+#ifdef CONFIG_HAZPTR_DEBUG
+			item->acquire_pid = ctx->acquire_pid;
+			item->acquire_caller = ctx->acquire_caller;
+			item->acquire_jiffies = ctx->acquire_jiffies;
+#endif
 			return addr;
 		}
 	}
@@ -387,6 +394,14 @@ struct hazptr_waiter {
 	struct list_head node;
 	void *addr;
 	struct completion done;
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+	unsigned long enqueue_jiffies;
+	unsigned long last_report;
+	unsigned int cycles;
+	unsigned int reports;
+	int pid;
+	unsigned long caller;
+#endif
 };
 
 struct hazptr_scan_state {
@@ -400,11 +415,14 @@ struct hazptr_scan_state {
 };
 static struct hazptr_scan_state hazptr_scan;
 
+/* Sysfs counters, cf. RCU's rcu_stall_count. */
+static atomic_t hazptr_stall_count = ATOMIC_INIT(0);
+
 /*
- * Queue @addr for the shared scan.  The waiter lives on the caller's
- * stack, so no allocation is needed.
+ * Queue @addr for the shared scan.  The waiter lives on the
+ * caller's stack, so no allocation is needed.
  */
-static void hazptr_synchronize_queued(void *addr)
+static void hazptr_synchronize_queued(void *addr, unsigned long caller)
 {
 	struct hazptr_waiter waiter = {
 		.addr = addr,
@@ -412,7 +430,16 @@ static void hazptr_synchronize_queued(void *addr)
 
 	init_completion(&waiter.done);
 	INIT_LIST_HEAD(&waiter.node);
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+	waiter.enqueue_jiffies = jiffies;
+	waiter.last_report = jiffies;
+	waiter.cycles = 0;
+	waiter.reports = 0;
+	waiter.pid = task_pid_nr(current);
+	waiter.caller = caller;
+#endif
 
+	/* Enqueue and wake the scan kthread. */
 	mutex_lock(&hazptr_scan.lock);
 	list_add_tail(&waiter.node, &hazptr_scan.pending);
 	trace_hazptr_waiter_enqueue(addr);
@@ -422,9 +449,14 @@ static void hazptr_synchronize_queued(void *addr)
 	}
 	mutex_unlock(&hazptr_scan.lock);
 
+	/* Sleep until the scan kthread completes this waiter. */
 	wait_for_completion(&waiter.done);
 }
 
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+static void hazptr_waiter_stall_check(struct hazptr_waiter *w);
+#endif
+
 static void hazptr_scan_do_cycle(void)
 {
 	struct hazptr_waiter *w, *n;
@@ -471,8 +503,201 @@ static void hazptr_scan_do_cycle(void)
 		list_del_init(&w->node);
 		complete(&w->done);
 	}
+
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+	/* Stall diagnostics for waiters still blocked. */
+	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node)
+		hazptr_waiter_stall_check(w);
+#endif
+}
+
+
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+
+/*
+ * Holder blame collected by the stall walk.  Under
+ * CONFIG_HAZPTR_DEBUG, the per-CPU slot's ctx pointer and the
+ * overflow-list node's embedding ctx provide pid and acquire
+ * caller.  These reads are racy diagnostics: the holder may be
+ * releasing concurrently, so blame may be stale -- acceptable for
+ * a debug splat, never used for correctness.
+ */
+struct hazptr_stall_holder {
+	int cpu;		/* -1: overflow-list entry */
+	int idx;
+	int pid;
+	unsigned long caller;
+	unsigned long held;	/* jiffies held at observation (DEBUG) */
+};
+
+/*
+ * Exact-match walk for stall diagnostics: count slots holding
+ * @addr and fill up to @max holders with blame.  Unlike the
+ * wildcard drain, this is safe outside hazptr_phase_lock: it
+ * matches plain slot values and takes the overflow-list locks.
+ * Expensive: only called for stalled waiters, never per cycle.
+ *
+ * The result is a concurrent observation, not an atomic snapshot:
+ * holders may release, re-acquire, or migrate to the overflow list
+ * while the walk runs.  The per-holder fields (pid, held) are
+ * racy reads best-effort diagnostics.
+ */
+static int hazptr_stall_walk(void *addr,
+			     struct hazptr_stall_holder *holders, int max)
+{
+	int cpu, n = 0;
+
+	for_each_possible_cpu(cpu) {
+		struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
+		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
+		unsigned int idx;
+
+		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
+			struct hazptr_slot_item *item = &percpu_slots->items[idx];
+			struct hazptr_stall_holder *h;
+
+			if (smp_load_acquire(&item->slot.addr) != addr)
+				continue;
+			if (n < max) {
+				h = &holders[n];
+				h->cpu = cpu;
+				h->idx = idx;
+				h->pid = -1;
+				h->caller = 0;
+				h->held = 0;
+#ifdef CONFIG_HAZPTR_DEBUG
+				/*
+				 * Read diagnostics from the stable per-CPU
+				 * slot_item rather than the ctx pointer,
+				 * which may belong to a reader that has
+				 * already exited its scope.
+				 */
+				/*
+				 * Best-effort: fields are written after
+				 * the slot address is published, so they
+				 * may briefly describe the previous
+				 * holder.  held is measured from the
+				 * acquire attempt start, not from slot
+				 * publication.
+				 */
+				h->pid = READ_ONCE(item->acquire_pid);
+				h->caller = READ_ONCE(item->acquire_caller);
+				h->held = jiffies - READ_ONCE(item->acquire_jiffies);
+#endif
+			}
+			n++;
+		}
+		for (int i = 0; i < 2; i++) {
+			struct hazptr_overflow_list *list = &overflow_list_flip->array[i];
+			struct hazptr_backup_slot *b;
+			unsigned long flags;
+
+			raw_spin_lock_irqsave(&list->lock, flags);
+			hlist_for_each_entry(b, &list->head, overflow_node) {
+				struct hazptr_stall_holder *h;
+
+				if (smp_load_acquire(&b->slot.addr) != addr)
+					continue;
+				if (n < max) {
+					h = &holders[n];
+					h->cpu = -1;
+					h->idx = i;
+					h->pid = -1;
+					h->caller = 0;
+					h->held = 0;
+#ifdef CONFIG_HAZPTR_DEBUG
+					{
+						struct hazptr_ctx *ctx = container_of(b, struct hazptr_ctx, backup_slot);
+
+						h->pid = READ_ONCE(ctx->acquire_pid);
+						h->caller = READ_ONCE(ctx->acquire_caller);
+						h->held = jiffies - READ_ONCE(ctx->acquire_jiffies);
+					}
+#endif
+				}
+				n++;
+			}
+			raw_spin_unlock_irqrestore(&list->lock, flags);
+		}
+	}
+	return n;
+}
+
+/*
+ * Collect and print holder blame for a stalled waiter.
+ */
+static void hazptr_waiter_stall_report(struct hazptr_waiter *w)
+{
+	struct hazptr_stall_holder holders[16];
+	unsigned long waited = jiffies - w->enqueue_jiffies;
+	int n, i;
+
+	pr_warn("hazptr: waiter stall: pid %d blocked %ums in hazptr_synchronize(%p) caller %pS, %u scan cycles, report #%u\n",
+		w->pid, jiffies_to_msecs(waited), w->addr,
+		(void *)w->caller, w->cycles, w->reports);
+
+	n = hazptr_stall_walk(w->addr, holders, 16);
+	if (!n) {
+		pr_warn("hazptr: stall: no matching holder found during diagnostic walk\n");
+		return;
+	}
+	pr_warn("hazptr: stall: %d slot(s) hold this address\n", n);
+	pr_warn("hazptr: stall: long-lived references are a hazard-pointer feature, so a long wait is not necessarily a problem.  Evidence for interpretation: across reports, per-holder held times that reset mean that slot was re-acquired; growing held times on the same slot mean that acquisition persists (long-held reference, or a holder stuck in its critical section -- check the task).  Compare the full holder set across reports to help interpret re-publication vs. a single long-held reference.\n");
+	for (i = 0; i < min(n, 16); i++) {
+		if (holders[i].cpu >= 0)
+			pr_warn("hazptr: stall:   cpu=%d slot=%d",
+				holders[i].cpu, holders[i].idx);
+		else
+			pr_warn("hazptr: stall:   overflow-list%d",
+				holders[i].idx);
+#ifdef CONFIG_HAZPTR_DEBUG
+		if (holders[i].pid >= 0) {
+			struct task_struct *t;
+
+			pr_cont(" pid=%d held=%ums caller=%pS",
+				holders[i].pid,
+				jiffies_to_msecs(holders[i].held),
+				(void *)holders[i].caller);
+			rcu_read_lock();
+			t = find_task_by_vpid(holders[i].pid);
+			if (t) {
+				touch_nmi_watchdog();
+				sched_show_task(t);
+			}
+			rcu_read_unlock();
+		}
+#endif
+		pr_cont("\n");
+	}
+	if (n > 16)
+		pr_warn("hazptr: stall:   ... and %d more\n", n - 16);
 }
 
+/*
+ * Stall check for one still-blocked waiter, called from the scan
+ * kthread after each cycle.  Purely diagnostic: never changes
+ * completion conditions.  First report at the timeout, re-reports
+ * at twice the timeout while the wait continues.
+ */
+static void hazptr_waiter_stall_check(struct hazptr_waiter *w)
+{
+	unsigned long now = jiffies;
+	unsigned long timeout = msecs_to_jiffies(CONFIG_HAZPTR_STALL_TIMEOUT);
+	unsigned long deadline;
+
+	w->cycles++;
+	deadline = w->reports ? w->last_report + 2 * timeout
+			      : w->enqueue_jiffies + timeout;
+	if (time_before(now, deadline))
+		return;
+	w->reports++;
+	hazptr_waiter_stall_report(w);
+	atomic_inc(&hazptr_stall_count);
+	w->last_report = jiffies;
+}
+
+#endif /* CONFIG_HAZPTR_STALL_DETECTOR */
+
 static int hazptr_scan_kthread(void *unused)
 {
 	for (;;) {
@@ -543,7 +768,7 @@ void hazptr_synchronize(void *addr)
 
 	/* Pairs with smp_store_release in hazptr_scan_init(). */
 	if (smp_load_acquire(&hazptr_scan.kthread)) {
-		hazptr_synchronize_queued(addr);
+		hazptr_synchronize_queued(addr, _RET_IP_);
 		return;
 	}
 
@@ -592,3 +817,33 @@ void __init hazptr_init(void)
 		}
 	}
 }
+#ifdef CONFIG_SYSFS
+
+static ssize_t hazptr_stall_count_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *page)
+{
+	return sysfs_emit(page, "%d\n", atomic_read(&hazptr_stall_count));
+}
+
+static struct kobj_attribute hazptr_stall_count_attr =
+	__ATTR_RO(hazptr_stall_count);
+
+static struct attribute *hazptr_sysfs_attrs[] = {
+	&hazptr_stall_count_attr.attr,
+	NULL,
+};
+
+static struct attribute_group hazptr_sysfs_group = {
+	.name = "hazptr",
+	.attrs = hazptr_sysfs_attrs,
+};
+
+static __init int hazptr_sysfs_init(void)
+{
+	return sysfs_create_group(kernel_kobj, &hazptr_sysfs_group);
+}
+
+late_initcall(hazptr_sysfs_init);
+
+#endif /* CONFIG_SYSFS */
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 3a2e9d7f58f8..b64ae06f3298 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -275,4 +275,20 @@ config HAZPTR_ACQUIRE_FORCE_SLOWPATH
 	  with lockdep.  It also lets hazptrtorture exercise the slow
 	  path without filling the per-CPU slots.
 
+config HAZPTR_STALL_DETECTOR
+	bool "Hazard-pointer waiter stall detector"
+	default y
+	help
+	  Print diagnostics when a hazptr_synchronize() waiter remains
+	  blocked for longer than the stall timeout, like RCU's CPU
+	  stall detector.  Purely observational.
+
+config HAZPTR_STALL_TIMEOUT
+	int "Hazard-pointer waiter stall timeout (ms)"
+	range 1 3600000
+	default 21000
+	depends on HAZPTR_STALL_DETECTOR
+	help
+	  Waiter stall timeout in milliseconds, defaulting to RCU's 21s.
+
 endmenu # "RCU Debugging"
-- 
2.43.0

