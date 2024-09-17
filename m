Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB57171099;
	Tue, 17 Sep 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583699; cv=none; b=q9UpPvK84LmHlGqb6RhjkMt1gNs9OR+Bt8polyx46elVYHIrJivAut1ViEXkA+N8NfWGrp4pv8tl7a5BQmPkbmVlfiBZFDA2KrL9iw4u/n7ZhKQu9mwDwrCYsyJRkN1sa7xMdExIoFZ+N+ahQj/VzUq6FF4knX1mOa99qDvEzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583699; c=relaxed/simple;
	bh=70+JTe3/30bqlGhhwCby5vVoVe2AsO0uexxaGSUepHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STxiesC0Mk6bXug+hCUgxtAZ7teTH1JFRZza6Jh3y7GPAQNyOLVRFqmLP92g1DxCU/p2hp6tG/+KPj1EIOqMlL4NUEQXP5NP2uPE+xgYjxaXk7ZFjkO0Qn/66qTPbOIL90npA2J8X/kCp1p8KMuPtfB1c2+rgBlHqVFO13p6mDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeyyMoN2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeyyMoN2"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c35427935eso30307686d6.3;
        Tue, 17 Sep 2024 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726583696; x=1727188496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZq7RPD+uH42F46mDIKK9Ztk0MZzott+JAYc6fmxJrg=;
        b=TeyyMoN24NW3hXHaL24izD4vNHhuN5OuHaFw5yE+ymh/f+TM6B8YMK9N8kYaIqtWm4
         87eaLS7XI5KBwHX86vIT71rneXe2wdbG1PJr8MR+l0eWy3RLhdKqhkOlxJ3tMsxmN54R
         Q/FBFOqrg2V9Vlc49RtuWD+MyAg/NTCSjo5itlquyfWG7C3CTrJOFr9I9ByzMbcjDKC+
         OX5zHzP7MFz/BNtMjK6DDo8fOz+rvwadatzQB32X1k/nabqSL/tZUHwlBFtVPODJ+3Wg
         C3biUCem10VUCwlEOuQxmLSq+CfqjT3VyLLs7/ZcMkRMSYugLPglVsrnjEmsthtfGe3b
         068Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726583696; x=1727188496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZq7RPD+uH42F46mDIKK9Ztk0MZzott+JAYc6fmxJrg=;
        b=mqU8kDCVIUiBgQjoVVQET0ExnCAu7Jve4SzCR1okQureWmpZPxAHhPffTojYEoYBr5
         e9+/3dNmvy/Gk5aY+002Oetu4Kd9UlzOGxFnnzZN3dT7gBkDFShGHTRXSZXRIB7L+gVc
         C5aQWiBqpnsoN+bNcIMy3lOhKRgcqMSebJtdZBIdWO5si274w1IpJ341NWW2+b8LM7Ly
         zUnpU9qZyGbr0wIvCKhoBm+zYZEvvJQuQ6mUjW3tDJ5EYOCoBXtQ9r1PvWhTjk0iica1
         /jWv+TEFlgyeXyTrf149lh8v0PSmwRwxJQaMZQ948gC2KIiX/ui8syh+8z1860oGp0W4
         EK2A==
X-Forwarded-Encrypted: i=1; AJvYcCWzloDCuT1mpfkfIuEsob9SjWd/Cf6hkf/Qb82sFnyExKNNIKSJH7Qd6Tbtu7v/sLS2KxCW@vger.kernel.org, AJvYcCXrV19BK0evXDIQCM7NZJnX7QlPpvrMcgEy8fQYNukD+0HrcN++AUHwANrxXIQP8zUe5eEr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyve76ybWtWLigPWCFamRqORIDRzjGRdkldYqTunl1NH+JmLoaV
	VuSw3fhJy2uKYr+y0Hcclef7paNyZAR/2CUkAjd0p/ffEteocGbi
X-Google-Smtp-Source: AGHT+IF2pmEI6yhOYlc9yJ0coEnr4ACImy1rxYaWM0jfd3MyvAsabH8ssbs86MX7XRNikWoU3iGneA==
X-Received: by 2002:a05:6214:498b:b0:6c5:72c0:728b with SMTP id 6a1803df08f44-6c573572609mr285955006d6.24.1726583696247;
        Tue, 17 Sep 2024 07:34:56 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c7aefb7sm35174946d6.124.2024.09.17.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:34:55 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 34B341200070;
	Tue, 17 Sep 2024 10:34:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 17 Sep 2024 10:34:55 -0400
X-ME-Sender: <xms:j5PpZsLx60s23RsYk1IqXpT13Gx8AtwlLa6ctr8vLX1caxM72SgFwA>
    <xme:j5PpZsJXeLGCIZSq8SxeER9iDA2QTx9LqdzzkTvyc-9Lv3tGhjKFXeIQEdSW8PHg1
    EAgn89cqGgR5W6a6g>
X-ME-Received: <xmr:j5PpZssBTsmB11R_Z6x28ll13utD7C9ZBrajJbXKHICd2eIDMGXsRObNPHF3BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    eplhhkmhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgt
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprh
    gtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:j5PpZpaR2sGPj5TezCCHiB3gwbtakN5mKKwogFKHw4kT1a7qiACI9A>
    <xmx:j5PpZjaFaG_NddcSBbxj22ajOuDV7eKV9rc-t8st9avvjL2BoPmxLA>
    <xmx:j5PpZlDY3XmPKXNGtvojaqd5Jl1MPHpsF1y6bMG3xn55I75rSd2fKw>
    <xmx:j5PpZpaLKnB8cTXWpI_PLvzalJ_ZAwiaoCF927MgRsjnluNZUGuG0A>
    <xmx:j5PpZrr_fsbvvWU47AVM2etZkpTLOtrwNPl7yTjtaBvJ0HBa4ECOdd-4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 10:34:54 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Subject: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
Date: Tue, 17 Sep 2024 07:33:59 -0700
Message-ID: <20240917143402.930114-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240917143402.930114-1-boqun.feng@gmail.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hazard pointers [1] provide a way to dynamically distribute refcounting
and can be used to improve the scalability of refcounting without
significant space cost.

Hazard pointers are similar to RCU: they build the synchronization
between two part, readers and updaters. Readers are refcount users, they
acquire and release refcount. Updaters cleanup objects when there are no
reader referencing them (via call_hazptr()). The difference is instead
of waiting for a grace period, hazard pointers can free an object as
long as there is no one referencing the object. This means for a
particular workload, hazard pointers may have smaller memory footprint
due to fewer pending callbacks.

The synchronization between readers and updaters is built around "hazard
pointer slots": a slot readers can use to store a pointer value.

Reader side protection:

1.	Read the value of a pointer to the target data element.
2.	Store it to a hazard pointer slot.
3.	Enforce full ordering (e.g. smp_mb()).
4.	Re-read the original pointer, reset the slot and retry if the
	value changed.
5.	Otherwise, the continued existence of the target data element
	is guaranteed.

Updater side check:

1.	Unpublish the target data element (e.g. setting the pointer
	value to NULL).
2.	Enforce full ordering.
3.	Read the value from a hazard pointer slot.
4.	If the value doesn't match the target data element, then this
	slot doesn't represent a reference to it.
5.	Otherwise, updater needs to re-check (step 3).

To distribute the accesses of hazptr slots from different contexts,
hazptr_context is introduced. Users need to define/allocate their own
hazptr_context to allocate hazard pointer slots.

For the updater side to confirm no existing reference, it needs to scan
all the possible slots, and to speed up this process, hazptr_context
also contains an rbtree node for each slot so that updater can cache the
reader-scan result in an rbtree. The rbtree nodes are pre-allocated in
this way to prevent "allocate memory to free memory" in extreme cases.

[1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
     lock-free objects," in IEEE Transactions on Parallel and
     Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004

Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/hazptr.h |  83 ++++++++
 kernel/Makefile        |   1 +
 kernel/hazptr.c        | 463 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 547 insertions(+)
 create mode 100644 include/linux/hazptr.h
 create mode 100644 kernel/hazptr.c

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
new file mode 100644
index 000000000000..4548ca8c75eb
--- /dev/null
+++ b/include/linux/hazptr.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HAZPTR_H
+#define _LINUX_HAZPTR_H
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/rbtree.h>
+
+/* Hazard pointer slot. */
+typedef void* hazptr_t;
+
+#define HAZPTR_SLOT_PER_CTX 8
+
+struct hazptr_slot_snap {
+	struct rb_node node;
+	hazptr_t slot;
+};
+
+/*
+ * A set of hazard pointer slots for a context.
+ *
+ * The context can be a task, CPU or reader (depends on the use case). It may
+ * be allocated statically or dynamically. It can only be used after calling
+ * init_hazptr_context(), and users are also responsible to call
+ * cleaup_hazptr_context() when it's not used any more.
+ */
+struct hazptr_context {
+	// The lock of the percpu context lists.
+	spinlock_t *lock;
+
+	struct list_head list;
+	struct hazptr_slot_snap snaps[HAZPTR_SLOT_PER_CTX];
+	____cacheline_aligned hazptr_t slots[HAZPTR_SLOT_PER_CTX];
+};
+
+void init_hazptr_context(struct hazptr_context *hzcp);
+void cleanup_hazptr_context(struct hazptr_context *hzcp);
+hazptr_t *hazptr_alloc(struct hazptr_context *hzcp);
+void hazptr_free(struct hazptr_context *hzcp, hazptr_t *hzp);
+
+#define hazptr_tryprotect(hzp, gp, field)	(typeof(gp))__hazptr_tryprotect(hzp, (void **)&(gp), offsetof(typeof(*gp), field))
+#define hazptr_protect(hzp, gp, field) ({				\
+	typeof(gp) ___p;						\
+									\
+	___p = hazptr_tryprotect(hzp, gp, field);			\
+	BUG_ON(!___p);							\
+	___p;								\
+})
+
+static inline void *__hazptr_tryprotect(hazptr_t *hzp,
+					void *const *p,
+					unsigned long head_offset)
+{
+	void *ptr;
+	struct callback_head *head;
+
+	ptr = READ_ONCE(*p);
+
+	if (ptr == NULL)
+		return NULL;
+
+	head = (struct callback_head *)(ptr + head_offset);
+
+	WRITE_ONCE(*hzp, head);
+	smp_mb();
+
+	ptr = READ_ONCE(*p); // read again
+
+	if (ptr + head_offset != head) { // pointer changed
+		WRITE_ONCE(*hzp, NULL);  // reset hazard pointer
+		return NULL;
+	} else
+		return ptr;
+}
+
+static inline void hazptr_clear(hazptr_t *hzp)
+{
+	/* Pairs with smp_load_acquire() in reader scan. */
+	smp_store_release(hzp, NULL);
+}
+
+void call_hazptr(struct callback_head *head, rcu_callback_t func);
+#endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..7927264b9870 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += hazptr.o
 obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
new file mode 100644
index 000000000000..f22ccc2a4a62
--- /dev/null
+++ b/kernel/hazptr.c
@@ -0,0 +1,463 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/spinlock.h>
+#include <linux/cleanup.h>
+#include <linux/hazptr.h>
+#include <linux/percpu.h>
+#include <linux/workqueue.h>
+
+#define HAZPTR_UNUSED (1ul)
+
+/* Per-CPU data for hazard pointer management. */
+struct hazptr_percpu {
+	spinlock_t ctx_lock;		/* hazptr context list lock */
+	struct list_head ctx_list;	/* hazptr context list */
+	spinlock_t callback_lock;	/* Per-CPU callback queue lock */
+	struct callback_head *queued;	/* Per-CPU callback queue */
+	struct callback_head **tail;
+};
+
+/*
+ * Per-CPU data contains context lists and callbacks, which are maintained in a
+ * per-CPU maner to reduce potential contention. This means a global scan (for
+ * readers or callbacks) has to take each CPU's lock, but it's less problematic
+ * because that's a slowpath.
+ */
+DEFINE_PER_CPU(struct hazptr_percpu, hzpcpu);
+
+/* A RBTree that stores the reader scan result of all hazptr slot */
+struct hazptr_reader_tree {
+	spinlock_t lock;
+	struct rb_root root;
+};
+
+static void init_hazptr_reader_tree(struct hazptr_reader_tree *tree)
+{
+	spin_lock_init(&tree->lock);
+	tree->root = RB_ROOT;
+}
+
+static bool is_null_or_unused(hazptr_t slot)
+{
+	return slot == NULL || ((unsigned long)slot) == HAZPTR_UNUSED;
+}
+
+static int hazptr_node_cmp(const void *key, const struct rb_node *curr)
+{
+	unsigned long slot = (unsigned long)key;
+	struct hazptr_slot_snap *curr_snap = container_of(curr, struct hazptr_slot_snap, node);
+	unsigned long curr_slot = (unsigned long)(curr_snap->slot);
+
+	if (slot < curr_slot)
+		return -1;
+	else if (slot > curr_slot)
+		return 1;
+	else
+		return 0;
+}
+
+static bool hazptr_node_less(struct rb_node *new, const struct rb_node *curr)
+{
+	struct hazptr_slot_snap *new_snap = container_of(new, struct hazptr_slot_snap, node);
+
+	return hazptr_node_cmp((void *)new_snap->slot, curr) < 0;
+}
+
+/* Add the snapshot into a search tree. tree->lock must be held. */
+static inline void reader_add_locked(struct hazptr_reader_tree *tree,
+				     struct hazptr_slot_snap *snap)
+{
+	lockdep_assert_held(&tree->lock);
+	BUG_ON(is_null_or_unused(snap->slot));
+
+	rb_add(&snap->node, &tree->root, hazptr_node_less);
+}
+
+static inline void reader_add(struct hazptr_reader_tree *tree,
+			      struct hazptr_slot_snap *snap)
+{
+	guard(spinlock_irqsave)(&tree->lock);
+
+	reader_add_locked(tree, snap);
+}
+
+/* Delete the snapshot from a search tree. tree->lock must be held. */
+static inline void reader_del_locked(struct hazptr_reader_tree *tree,
+				     struct hazptr_slot_snap *snap)
+{
+	lockdep_assert_held(&tree->lock);
+
+	rb_erase(&snap->node, &tree->root);
+}
+
+static inline void reader_del(struct hazptr_reader_tree *tree,
+			      struct hazptr_slot_snap *snap)
+{
+	guard(spinlock_irqsave)(&tree->lock);
+
+	reader_del_locked(tree, snap);
+}
+
+/* Find whether a read exists. tree->lock must be held. */
+static inline bool reader_exist_locked(struct hazptr_reader_tree *tree,
+				       unsigned long slot)
+{
+	lockdep_assert_held(&tree->lock);
+
+	return !!rb_find((void *)slot, &tree->root, hazptr_node_cmp);
+}
+
+static inline bool reader_exist(struct hazptr_reader_tree *tree,
+				unsigned long slot)
+{
+	guard(spinlock_irqsave)(&tree->lock);
+
+	return reader_exist_locked(tree, slot);
+}
+
+/*
+ * Scan the readers from one hazptr context and update the global readers tree.
+ *
+ * Must be called with hzcp->lock held.
+ */
+static void hazptr_context_snap_readers_locked(struct hazptr_reader_tree *tree,
+					       struct hazptr_context *hzcp)
+{
+	lockdep_assert_held(hzcp->lock);
+
+	for (int i = 0; i < HAZPTR_SLOT_PER_CTX; i++) {
+		/*
+		 * Pairs with smp_store_release() in hazptr_{clear,free}().
+		 *
+		 * Ensure
+		 *
+		 * <reader>		<updater>
+		 *
+		 * [access protected pointers]
+		 * hazptr_clear();
+		 *   smp_store_release()
+		 *			// in reader scan.
+		 *			smp_load_acquire(); // is null or unused.
+		 *			[run callbacks] // all accesses from
+		 *					// reader must be
+		 *					// observed.
+		 */
+		hazptr_t val = smp_load_acquire(&hzcp->slots[i]);
+
+		if (!is_null_or_unused(val)) {
+			struct hazptr_slot_snap *snap = &hzcp->snaps[i];
+
+			// Already in the tree, need to remove first.
+			if (!is_null_or_unused(snap->slot)) {
+				reader_del(tree, snap);
+			}
+			snap->slot = val;
+			reader_add(tree, snap);
+		}
+	}
+}
+
+/*
+ * Initialize a hazptr context.
+ *
+ * Must be called before using the context for hazptr allocation.
+ */
+void init_hazptr_context(struct hazptr_context *hzcp)
+{
+	struct hazptr_percpu *pcpu = this_cpu_ptr(&hzpcpu);
+
+	for (int i = 0; i < HAZPTR_SLOT_PER_CTX; i++) {
+		hzcp->slots[i] = (hazptr_t)HAZPTR_UNUSED;
+		hzcp->snaps[i].slot = (hazptr_t)HAZPTR_UNUSED;
+	}
+
+	guard(spinlock_irqsave)(&pcpu->ctx_lock);
+	list_add(&hzcp->list, &pcpu->ctx_list);
+	hzcp->lock = &pcpu->ctx_lock;
+}
+
+struct hazptr_struct {
+	struct work_struct work;
+	bool scheduled;
+
+	// list of callbacks, we move percpu queued callbacks into the global
+	// queued list in workqueue function.
+	spinlock_t callback_lock;
+	struct callback_head *queued;
+	struct callback_head **tail;
+
+	struct hazptr_reader_tree readers;
+};
+
+static struct hazptr_struct hazptr_struct;
+
+/*
+ * Clean up hazptr context.
+ *
+ * Must call before freeing the context. This function also removes any
+ * reference held by the hazard pointer slots in the context, even
+ * hazptr_clear() or hazptr_free() is not called previously.
+ */
+void cleanup_hazptr_context(struct hazptr_context *hzcp)
+{
+	if (hzcp->lock) {
+		scoped_guard(spinlock_irqsave, hzcp->lock) {
+			list_del(&hzcp->list);
+			hzcp->lock = NULL;
+		}
+
+		for (int i = 0; i < HAZPTR_SLOT_PER_CTX; i++) {
+			struct hazptr_slot_snap *snap = &hzcp->snaps[i];
+
+			if (!is_null_or_unused(snap->slot))
+				reader_del(&hazptr_struct.readers, snap);
+		}
+	}
+}
+
+/*
+ * Allocate a hazptr slot from a hazptr_context.
+ *
+ * Return: NULL means fail to allocate, otherwise the address of the allocated
+ * slot.
+ */
+hazptr_t *hazptr_alloc(struct hazptr_context *hzcp)
+{
+	unsigned long unused;
+
+	for (int i = 0; i < HAZPTR_SLOT_PER_CTX; i++) {
+		if (((unsigned long)READ_ONCE(hzcp->slots[i])) == HAZPTR_UNUSED) {
+			unused = HAZPTR_UNUSED;
+
+			/*
+			 * rwm-sequence is relied on here.
+			 *
+			 * This is needed since in case of a previous reader:
+			 *
+			 * <reader 1>		<reader 2>		<updater>
+			 * [access protected pointers]
+			 * hazptr_free():
+			 *   smp_store_release(); // hzptr == UNUSED
+			 *			hazptr_alloc():
+			 *			  try_cmpxchg_relaxed(); // hzptr == NULL
+			 *
+			 *						// in reader scan
+			 *						smp_load_acquire(); // is null
+			 *						[run callbacks]
+			 *
+			 * Because of the rwm-sequence of release operations,
+			 * when callbacks are run, accesses from reader 1 must
+			 * be already observed by the updater.
+			 */
+			if (try_cmpxchg_relaxed(&hzcp->slots[i], &unused, NULL)) {
+				return (hazptr_t *)&hzcp->slots[i];
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/* Free a hazptr slot. */
+void hazptr_free(struct hazptr_context *hzcp, hazptr_t *hzptr)
+{
+	WARN_ON(((unsigned long)*hzptr) == HAZPTR_UNUSED);
+
+	/* Pairs with smp_load_acquire() in reader scan */
+	smp_store_release(hzptr, (void *)HAZPTR_UNUSED);
+}
+
+/* Scan all possible readers, and update the global reader tree. */
+static void check_readers(struct hazptr_struct *hzst)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct hazptr_percpu *pcpu = per_cpu_ptr(&hzpcpu, cpu);
+		struct hazptr_context *ctx;
+
+		guard(spinlock_irqsave)(&pcpu->ctx_lock);
+		list_for_each_entry(ctx, &pcpu->ctx_list, list)
+			hazptr_context_snap_readers_locked(&hzst->readers, ctx);
+	}
+}
+
+/*
+ * Start the background work for hazptr callback handling if not started.
+ *
+ * Must be called with hazptr_struct lock held.
+ */
+static void kick_hazptr_work(void)
+{
+	if (hazptr_struct.scheduled)
+		return;
+
+	queue_work(system_wq, &hazptr_struct.work);
+	hazptr_struct.scheduled = true;
+}
+
+/*
+ * Check which callbacks are ready to be called.
+ *
+ * Return: a callback list that no reader is referencing the corresponding
+ * objects.
+ */
+static struct callback_head *do_hazptr(struct hazptr_struct *hzst)
+{
+	struct callback_head *tmp, **curr;
+	struct callback_head *todo = NULL, **todo_tail = &todo;
+
+	// Currently, the lock is unnecessary, but maybe we will have multiple
+	// work_structs sharing the same callback list in the future;
+	guard(spinlock_irqsave)(&hzst->callback_lock);
+
+	curr = &hzst->queued;
+
+	while ((tmp = *curr)) {
+		// No reader, we can free the object.
+		if (!reader_exist(&hzst->readers, (unsigned long)tmp)) {
+			// Add tmp into todo.
+			*todo_tail = tmp;
+			todo_tail = &tmp->next;
+
+			// Delete tmp from ->queued and move to the next entry.
+			*curr = tmp->next;
+		} else
+			curr = &tmp->next;
+	}
+
+	hzst->tail = curr;
+
+	// Keep checking if callback list is not empty.
+	if (hzst->queued)
+		kick_hazptr_work();
+
+	*todo_tail = NULL;
+
+	return todo;
+}
+
+static void hazptr_work_func(struct work_struct *work)
+{
+	struct hazptr_struct *hzst = container_of(work, struct hazptr_struct, work);
+	struct callback_head *todo;
+
+	// Advance callbacks from hzpcpu to hzst
+	scoped_guard(spinlock_irqsave, &hzst->callback_lock) {
+		int cpu;
+
+		hzst->scheduled = false;
+		for_each_possible_cpu(cpu) {
+			struct hazptr_percpu *pcpu = per_cpu_ptr(&hzpcpu, cpu);
+
+			guard(spinlock)(&pcpu->callback_lock);
+
+			if (pcpu->queued) {
+				*(hzst->tail) = pcpu->queued;
+				hzst->tail = pcpu->tail;
+				pcpu->queued = NULL;
+				pcpu->tail = &pcpu->queued;
+			}
+		}
+	}
+
+	// Pairs with the smp_mb() on the reader side. This guarantees that if
+	// the hazptr work picked up the callback from an updater and the
+	// updater set the global pointer to NULL before enqueue the callback,
+	// the hazptr work must observe a reader that protects the hazptr before
+	// the updater.
+	//
+	// <reader>		<updater>		<hazptr work>
+	// ptr = READ_ONCE(gp);
+	// WRITE_ONCE(*hazptr, ptr);
+	// smp_mb(); // => ->strong-fence
+	//			tofree = gp;
+	// ptr = READ_ONCE(gp); // re-read, gp is not NULL
+	//			// => ->fre
+	//			WRITE_ONCE(gp, NULL);
+	//			call_hazptr(gp, ...):
+	//			  lock(->callback_lock);
+	//			  [queued the callback]
+	//			  unlock(->callback_lock);// => ->po-unlock-lock-po
+	//						lock(->callback_lock);
+	//						[move from hzpcpu to hzst]
+	//
+	//						smp_mb(); => ->strong-fence
+	//						ptr = READ_ONCE(*hazptr);
+	//						// ptr == gp, otherwise => ->fre
+	//
+	// If ptr != gp, it means there exists a circle with the following
+	// memory ordering relationships:
+	//	->strong-fence ->fre ->po-unlock-lock-po ->strong-fence ->fre
+	// => (due to the definition of prop)
+	//	->strong-fence ->prop ->strong-fence ->hb ->prop
+	// => (rotate the circle)
+	//	->prop ->strong-fence ->prop ->strong-fence ->hb
+	// => (due to the definition of pb)
+	//	->pb ->pb
+	// but pb is acyclic according to LKMM, so this cannot happen.
+	smp_mb();
+	check_readers(hzst);
+
+	todo = do_hazptr(hzst);
+
+	while (todo) {
+		struct callback_head *next = todo->next;
+		void (*func)(struct callback_head *) = todo->func;
+
+		func(todo);
+
+		todo = next;
+	}
+}
+
+/*
+ * Put @head into the cleanup callback queue.
+ *
+ * @func(@head) will be called after no one is referencing the object. Caller
+ * must ensure the object has been unpublished before calling this.
+ */
+void call_hazptr(struct callback_head *head, rcu_callback_t func)
+{
+	struct hazptr_percpu *pcpu = this_cpu_ptr(&hzpcpu);
+
+	head->func = func;
+	head->next = NULL;
+
+	scoped_guard(spinlock_irqsave, &pcpu->callback_lock) {
+		*(pcpu->tail) = head;
+		pcpu->tail = &head->next;
+	}
+
+	guard(spinlock_irqsave)(&hazptr_struct.callback_lock);
+	kick_hazptr_work();
+}
+
+static int init_hazptr_struct(void)
+{
+	int cpu;
+
+	INIT_WORK(&hazptr_struct.work, hazptr_work_func);
+
+	spin_lock_init(&hazptr_struct.callback_lock);
+	hazptr_struct.queued = NULL;
+	hazptr_struct.tail = &hazptr_struct.queued;
+
+	for_each_possible_cpu(cpu) {
+		struct hazptr_percpu *pcpu = per_cpu_ptr(&hzpcpu, cpu);
+
+		spin_lock_init(&pcpu->ctx_lock);
+		INIT_LIST_HEAD(&pcpu->ctx_list);
+
+		spin_lock_init(&pcpu->callback_lock);
+		pcpu->queued = NULL;
+		pcpu->tail = &pcpu->queued;
+
+	}
+
+	init_hazptr_reader_tree(&hazptr_struct.readers);
+
+	return 0;
+}
+
+early_initcall(init_hazptr_struct);
-- 
2.45.2

