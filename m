Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A1187843
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086803; cv=none; b=snAjSkfnJ9iBV5cWmQXtIa5qhrOSJ8WA1dQAk4jbdCPJiRszcenxzWeDCTVQWlGUe0tWBsY1kalJ4VPN2KO/cAL2taNA1/ASsHDdDhdExOI+3EyyE57E1HZ65FDOGTT2RY1sRkEvO79INac8/l17JprRLSAB1dpHjsZjxoGqj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086803; c=relaxed/simple;
	bh=pgv1l393B0by42SiqMGb59U4E7RXDVUhMFTAQktcsBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT6yPkgzlv8rToGZbw/RVCiYk9F0FY9leOgBJSHlJwfFkzOJrTQALDXApTT105c65169+g2mMFvceV6MyjC0AzDCQxwu3blTuikoXuRRbbQg5cnVbd3545g7N7B0nu7u2Yy4ILZIxHpdFYHML1HTtplsWZD0QKVxAXZbqnTlpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H+gBgc8N; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H+gBgc8N"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ni5HbLiknOx6sLPUcsUxyw+sGHaVdXeBnNZEciF7GTI=;
	b=H+gBgc8NOnTab0mxiLNUVQXTye2cI9XLNrKblbZ6Rmvf82+hHFBdU0C5HKYlOS65WpMv3B
	3iz6yMz1uAQzq/E0t5vgnUyUf1W+jiiqriZdIago0aChaN2QLMw90UaLv1BxytALXX5MdQ
	1O9KlXUE2UfBExGJEwYYZ96Zogjb08I=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] rcu: rcu_pending
Date: Mon, 19 Aug 2024 12:59:32 -0400
Message-ID: <20240819165939.745801-7-kent.overstreet@linux.dev>
In-Reply-To: <20240819165939.745801-1-kent.overstreet@linux.dev>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Generic data structure for explicitly tracking pending RCU items,
allowing items to be dequeued (i.e. allocate from items pending
freeing). Works with conventional RCU and SRCU, and possibly other RCU
flavors in the future, meaning this can serve as a more generic
replacement for SLAB_TYPESAFE_BY_RCU.

Pending items are tracked in radix trees; if memory allocation fails, we
fall back to linked lists.

A rcu_pending is initialized with a callback, which is invoked when
pending items's grace periods have expired. Two types of callback
processing are handled specially:

- RCU_PENDING_KVFREE_FN

  New backend for kvfree_rcu(). Slightly faster, and eliminates the
  synchronize_rcu() slowpath in kvfree_rcu_mightsleep() - instead, an
  rcu_head is allocated if we don't have one and can't use the radix
  tree

  TODO:
  - add a shrinker (as in the existing kvfree_rcu implementation) so that
    memory reclaim can free expired objects if callback processing isn't
    keeping up, and to expedite a grace period if we're under memory
    pressure and too much memory is stranded by RCU

  - add a counter for amount of memory pending

- RCU_PENDING_CALL_RCU_FN

  Accelerated backend for call_rcu() - pending callbacks are tracked in
  a radix tree to eliminate linked list overhead.

to serve as replacement backends for kvfree_rcu() and call_rcu(); these
may be of interest to other uses (e.g. SLAB_TYPESAFE_BY_RCU users).

Note:

Internally, we're using a single rearming call_rcu() callback for
notifications from the core RCU subsystem for notifications when objects
are ready to be processed.

Ideally we would be getting a callback every time a grace period
completes for which we have objects, but that would require multiple
rcu_heads in flight, and since the number of gp sequence numbers with
uncompleted callbacks is not bounded, we can't do that yet.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/rcu_pending.h |  25 ++
 kernel/rcu/Makefile         |   2 +-
 kernel/rcu/pending.c        | 603 ++++++++++++++++++++++++++++++++++++
 3 files changed, 629 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/rcu_pending.h
 create mode 100644 kernel/rcu/pending.c

diff --git a/include/linux/rcu_pending.h b/include/linux/rcu_pending.h
new file mode 100644
index 000000000000..a875c640da8d
--- /dev/null
+++ b/include/linux/rcu_pending.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RCU_PENDING_H
+#define _LINUX_RCU_PENDING_H
+
+struct rcu_pending;
+typedef void (*rcu_pending_process_fn)(struct rcu_pending *, struct rcu_head *);
+
+struct rcu_pending_pcpu;
+
+struct rcu_pending {
+	struct rcu_pending_pcpu __percpu *p;
+	struct srcu_struct		*srcu;
+	rcu_pending_process_fn		process;
+};
+
+void rcu_pending_enqueue(struct rcu_pending *pending, struct rcu_head *obj);
+struct rcu_head *rcu_pending_dequeue(struct rcu_pending *pending);
+struct rcu_head *rcu_pending_dequeue_from_all(struct rcu_pending *pending);
+
+void rcu_pending_exit(struct rcu_pending *pending);
+int rcu_pending_init(struct rcu_pending *pending,
+		     struct srcu_struct *srcu,
+		     rcu_pending_process_fn process);
+
+#endif /* _LINUX_RCU_PENDING_H */
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 0cfb009a99b9..2582f0324a11 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -7,7 +7,7 @@ ifeq ($(CONFIG_KCSAN),y)
 KBUILD_CFLAGS += -g -fno-omit-frame-pointer
 endif
 
-obj-y += update.o sync.o
+obj-y += update.o sync.o pending.o
 obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
diff --git a/kernel/rcu/pending.c b/kernel/rcu/pending.c
new file mode 100644
index 000000000000..c0e2351ba198
--- /dev/null
+++ b/kernel/rcu/pending.c
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) "%s() " fmt "\n", __func__
+
+#include <linux/darray.h>
+#include <linux/generic-radix-tree.h>
+#include <linux/mm.h>
+#include <linux/percpu.h>
+#include <linux/rcu_pending.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+#include <linux/vmalloc.h>
+
+#include "rcu.h"
+
+#define static_array_for_each(_a, _i)			\
+	for (typeof(&(_a)[0]) _i = _a;			\
+	     _i < (_a) + ARRAY_SIZE(_a);		\
+	     _i++)
+
+enum rcu_pending_special {
+	RCU_PENDING_KVFREE	= 1,
+	RCU_PENDING_CALL_RCU	= 2,
+};
+
+#define RCU_PENDING_KVFREE_FN		((rcu_pending_process_fn) (ulong) RCU_PENDING_KVFREE)
+#define RCU_PENDING_CALL_RCU_FN		((rcu_pending_process_fn) (ulong) RCU_PENDING_CALL_RCU)
+
+static inline unsigned long __get_state_synchronize_rcu(struct srcu_struct *ssp)
+{
+	return ssp
+		? get_state_synchronize_srcu(ssp)
+		: get_state_synchronize_rcu();
+}
+
+static inline unsigned long __start_poll_synchronize_rcu(struct srcu_struct *ssp)
+{
+	return ssp
+		? start_poll_synchronize_srcu(ssp)
+		: start_poll_synchronize_rcu();
+}
+
+static inline bool __poll_state_synchronize_rcu(struct srcu_struct *ssp, unsigned long cookie)
+{
+	return ssp
+		? poll_state_synchronize_srcu(ssp, cookie)
+		: poll_state_synchronize_rcu(cookie);
+}
+
+static inline void __rcu_barrier(struct srcu_struct *ssp)
+{
+	return ssp
+		? srcu_barrier(ssp)
+		: rcu_barrier();
+}
+
+static inline void __call_rcu(struct srcu_struct *ssp, struct rcu_head *rhp,
+			      rcu_callback_t func)
+{
+	if (ssp)
+		call_srcu(ssp, rhp, func);
+	else
+		call_rcu(rhp, func);
+}
+
+struct rcu_pending_seq {
+	/*
+	 * We're using a radix tree like a vector - we're just pushing elements
+	 * onto the end; we're using a radix tree instead of an actual vector to
+	 * avoid reallocation overhead
+	 */
+	GENRADIX(struct rcu_head *)	objs;
+	size_t				nr;
+	struct rcu_head			**cursor;
+	unsigned long			seq;
+};
+
+struct rcu_pending_list {
+	struct rcu_head			*head;
+	struct rcu_head			*tail;
+	unsigned long			seq;
+};
+
+struct rcu_pending_pcpu {
+	struct rcu_pending		*parent;
+	spinlock_t			lock;
+	int				cpu;
+
+	/*
+	 * We can't bound the number of unprocessed gp sequence numbers, and we
+	 * can't efficiently merge radix trees for expired grace periods, so we
+	 * need darray/vector:
+	 */
+	DARRAY_PREALLOCATED(struct rcu_pending_seq, 4) objs;
+
+	/* Third entry is for expired objects: */
+	struct rcu_pending_list		lists[NUM_ACTIVE_RCU_POLL_OLDSTATE + 1];
+
+	struct rcu_head			cb;
+	bool				cb_armed;
+	struct work_struct		work;
+};
+
+static bool __rcu_pending_has_pending(struct rcu_pending_pcpu *p)
+{
+	if (p->objs.nr)
+		return true;
+
+	static_array_for_each(p->lists, i)
+		if (i->head)
+			return true;
+
+	return false;
+}
+
+static void rcu_pending_list_merge(struct rcu_pending_list *l1,
+				   struct rcu_pending_list *l2)
+{
+	if (!l1->head)
+		l1->head = l2->head;
+	else
+		l1->tail->next = l2->head;
+	l1->tail = l2->tail;
+
+	l2->head = l2->tail = NULL;
+}
+
+static void rcu_pending_list_add(struct rcu_pending_list *l,
+				 struct rcu_head *n)
+{
+	if (!l->head)
+		l->head = n;
+	else
+		l->tail->next = n;
+	l->tail = n;
+	n->next = NULL;
+}
+
+static void merge_expired_lists(struct rcu_pending_pcpu *p)
+{
+	struct rcu_pending_list *expired = &p->lists[NUM_ACTIVE_RCU_POLL_OLDSTATE];
+
+	for (struct rcu_pending_list *i = p->lists; i < expired; i++)
+		if (i->head && __poll_state_synchronize_rcu(p->parent->srcu, i->seq))
+			rcu_pending_list_merge(expired, i);
+}
+
+static noinline void __process_finished_items(struct rcu_pending *pending,
+					      struct rcu_pending_pcpu *p,
+					      unsigned long flags)
+{
+	struct rcu_pending_list *expired = &p->lists[NUM_ACTIVE_RCU_POLL_OLDSTATE];
+	struct rcu_pending_seq objs = {};
+	struct rcu_head *list = NULL;
+
+	if (p->objs.nr &&
+	    __poll_state_synchronize_rcu(pending->srcu, p->objs.data[0].seq)) {
+		objs = p->objs.data[0];
+		darray_remove_item(&p->objs, p->objs.data);
+	}
+
+	merge_expired_lists(p);
+
+	list = expired->head;
+	expired->head = expired->tail = NULL;
+
+	spin_unlock_irqrestore(&p->lock, flags);
+
+	switch ((ulong) pending->process) {
+	case RCU_PENDING_KVFREE:
+		for (size_t i = 0; i < objs.nr; ) {
+			size_t nr_this_node = min(GENRADIX_NODE_SIZE / sizeof(void *), objs.nr - i);
+
+			kfree_bulk(nr_this_node, (void **) genradix_ptr(&objs.objs, i));
+			i += nr_this_node;
+		}
+		genradix_free(&objs.objs);
+
+		while (list) {
+			struct rcu_head *obj = list;
+			list = obj->next;
+
+			/*
+			 * low bit of pointer indicates whether rcu_head needs
+			 * to be freed - kvfree_rcu_mightsleep()
+			 */
+			BUILD_BUG_ON(ARCH_SLAB_MINALIGN == 0);
+
+			void *ptr = (void *)(((unsigned long) obj->func) & ~1UL);
+			kvfree(ptr);
+
+			bool free_head = ((unsigned long) obj->func) & 1UL;
+			if (free_head)
+				kfree(obj);
+		}
+
+		break;
+
+	case RCU_PENDING_CALL_RCU:
+		for (size_t i = 0; i < objs.nr; i++) {
+			struct rcu_head *obj = *genradix_ptr(&objs.objs, i);
+			obj->func(obj);
+		}
+		genradix_free(&objs.objs);
+
+		while (list) {
+			struct rcu_head *obj = list;
+			list = obj->next;
+			obj->func(obj);
+		}
+		break;
+
+	default:
+		for (size_t i = 0; i < objs.nr; i++)
+			pending->process(pending, *genradix_ptr(&objs.objs, i));
+		genradix_free(&objs.objs);
+
+		while (list) {
+			struct rcu_head *obj = list;
+			list = obj->next;
+			pending->process(pending, obj);
+		}
+		break;
+	}
+}
+
+static bool process_finished_items(struct rcu_pending *pending,
+				   struct rcu_pending_pcpu *p,
+				   unsigned long flags)
+{
+	/*
+	 * XXX: we should grab the gp seq once and avoid multiple function
+	 * calls, this is called from __rcu_pending_enqueue() fastpath in
+	 * may_sleep==true mode
+	 */
+	if ((p->objs.nr && __poll_state_synchronize_rcu(pending->srcu, p->objs.data[0].seq)) ||
+	    (p->lists[0].head && __poll_state_synchronize_rcu(pending->srcu, p->lists[0].seq)) ||
+	    (p->lists[1].head && __poll_state_synchronize_rcu(pending->srcu, p->lists[1].seq)) ||
+	    p->lists[2].head) {
+		__process_finished_items(pending, p, flags);
+		return true;
+	}
+
+	return false;
+}
+
+static void rcu_pending_work(struct work_struct *work)
+{
+	struct rcu_pending_pcpu *p =
+		container_of(work, struct rcu_pending_pcpu, work);
+	struct rcu_pending *pending = p->parent;
+	unsigned long flags;
+
+	do {
+		spin_lock_irqsave(&p->lock, flags);
+	} while (process_finished_items(pending, p, flags));
+
+	spin_unlock_irqrestore(&p->lock, flags);
+}
+
+static void rcu_pending_rcu_cb(struct rcu_head *rcu)
+{
+	struct rcu_pending_pcpu *p = container_of(rcu, struct rcu_pending_pcpu, cb);
+
+	schedule_work_on(p->cpu, &p->work);
+
+	unsigned long flags;
+	spin_lock_irqsave(&p->lock, flags);
+	if (__rcu_pending_has_pending(p))
+		__call_rcu(p->parent->srcu, &p->cb, rcu_pending_rcu_cb);
+	else
+		p->cb_armed = false;
+	spin_unlock_irqrestore(&p->lock, flags);
+}
+
+static __always_inline struct rcu_pending_seq *
+get_object_radix(struct rcu_pending_pcpu *p, unsigned long seq)
+{
+	darray_for_each_reverse(p->objs, objs)
+		if (objs->seq == seq)
+			return objs;
+
+	if (darray_push_gfp(&p->objs, ((struct rcu_pending_seq) { .seq = seq }), GFP_ATOMIC))
+		return NULL;
+
+	return &darray_last(p->objs);
+}
+
+static noinline bool
+rcu_pending_enqueue_list(struct rcu_pending_pcpu *p, unsigned long seq,
+			 struct rcu_head *head, void *ptr,
+			 unsigned long *flags)
+{
+	if (ptr) {
+		if (!head) {
+			/*
+			 * kvfree_rcu_mightsleep(): we weren't passed an
+			 * rcu_head, but we need one: use the low bit of the
+			 * ponter to free to flag that the head needs to be
+			 * freed as well:
+			 */
+			ptr = (void *)(((unsigned long) ptr)|1UL);
+			head = kmalloc(sizeof(*head), __GFP_NOWARN);
+			if (!head) {
+				spin_unlock_irqrestore(&p->lock, *flags);
+				head = kmalloc(sizeof(*head), GFP_KERNEL|__GFP_NOFAIL);
+				/*
+				 * dropped lock, did GFP_KERNEL allocation,
+				 * check for gp expiration
+				 */
+				if (unlikely(__poll_state_synchronize_rcu(p->parent->srcu, seq))) {
+					kvfree(--ptr);
+					kfree(head);
+					spin_lock_irqsave(&p->lock, *flags);
+					return false;
+				}
+			}
+		}
+
+		head->func = ptr;
+	}
+again:
+	for (struct rcu_pending_list *i = p->lists;
+	     i < p->lists + NUM_ACTIVE_RCU_POLL_OLDSTATE; i++) {
+		if (i->seq == seq) {
+			rcu_pending_list_add(i, head);
+			return false;
+		}
+	}
+
+	for (struct rcu_pending_list *i = p->lists;
+	     i < p->lists + NUM_ACTIVE_RCU_POLL_OLDSTATE; i++) {
+		if (!i->head) {
+			i->seq = seq;
+			rcu_pending_list_add(i, head);
+			return true;
+		}
+	}
+
+	merge_expired_lists(p);
+	goto again;
+}
+
+/*
+ * __rcu_pending_enqueue: enqueue a pending RCU item, to be processed (via
+ * pending->pracess) once grace period elapses.
+ *
+ * Attempt to enqueue items onto a radix tree; if memory allocation fails, fall
+ * back to a linked list.
+ *
+ * - If @ptr is NULL, we're enqueuing an item for a generic @pending with a
+ *   process callback
+ *
+ * - If @ptr and @head are both not NULL, we're kvfree_rcu()
+ *
+ * - If @ptr is not NULL and @head is, we're kvfree_rcu_mightsleep()
+ *
+ * - If @may_sleep is true, will do GFP_KERNEL memory allocations and process
+ *   expired items.
+ */
+static __always_inline void
+__rcu_pending_enqueue(struct rcu_pending *pending, struct rcu_head *head,
+		      void *ptr, bool may_sleep)
+{
+
+	struct rcu_pending_pcpu *p;
+	struct rcu_pending_seq *objs;
+	struct genradix_node *new_node = NULL;
+	unsigned long seq, flags;
+	bool start_gp = false;
+
+	BUG_ON((ptr != NULL) != (pending->process == RCU_PENDING_KVFREE_FN));
+
+	local_irq_save(flags);
+	p = this_cpu_ptr(pending->p);
+	spin_lock(&p->lock);
+	seq = __get_state_synchronize_rcu(pending->srcu);
+restart:
+	if (may_sleep &&
+	    unlikely(process_finished_items(pending, p, flags)))
+		goto check_expired;
+
+	/*
+	 * In kvfree_rcu() mode, the radix tree is only for slab pointers so
+	 * that we can do kfree_bulk() - vmalloc pointers always use the linked
+	 * list:
+	 */
+	if (ptr && unlikely(is_vmalloc_addr_inlined(ptr)))
+		goto list_add;
+
+	objs = get_object_radix(p, seq);
+	if (unlikely(!objs))
+		goto list_add;
+
+	if (unlikely(!objs->cursor)) {
+		/*
+		 * New radix tree nodes must be added under @p->lock because the
+		 * tree root is in a darray that can be resized (typically,
+		 * genradix supports concurrent unlocked allocation of new
+		 * nodes) - hence preallocation and the retry loop:
+		 */
+		objs->cursor = genradix_ptr_alloc_preallocated_inlined(&objs->objs,
+						objs->nr, &new_node, GFP_ATOMIC|__GFP_NOWARN);
+		if (unlikely(!objs->cursor)) {
+			if (may_sleep) {
+				spin_unlock_irqrestore(&p->lock, flags);
+
+				gfp_t gfp = GFP_KERNEL;
+				if (!head)
+					gfp |= __GFP_NOFAIL;
+
+				new_node = genradix_alloc_node(gfp);
+				if (!new_node)
+					may_sleep = false;
+				goto check_expired;
+			}
+list_add:
+			start_gp = rcu_pending_enqueue_list(p, seq, head, ptr, &flags);
+			goto start_gp;
+		}
+	}
+
+	*objs->cursor++ = ptr ?: head;
+	/* zero cursor if we hit the end of a radix tree node: */
+	if (!(((ulong) objs->cursor) & (GENRADIX_NODE_SIZE - 1)))
+		objs->cursor = NULL;
+	start_gp = !objs->nr;
+	objs->nr++;
+start_gp:
+	if (unlikely(start_gp)) {
+		/*
+		 * We only have one callback (ideally, we would have one for
+		 * every outstanding graceperiod) - so if our callback is
+		 * already in flight, we may still have to start a grace period
+		 * (since we used get_state() above, not start_poll())
+		 */
+		if (!p->cb_armed) {
+			p->cb_armed = true;
+			__call_rcu(pending->srcu, &p->cb, rcu_pending_rcu_cb);
+		} else {
+			__start_poll_synchronize_rcu(pending->srcu);
+		}
+	}
+	spin_unlock_irqrestore(&p->lock, flags);
+free_node:
+	if (new_node)
+		genradix_free_node(new_node);
+	return;
+check_expired:
+	if (unlikely(__poll_state_synchronize_rcu(pending->srcu, seq))) {
+		switch ((ulong) pending->process) {
+		case RCU_PENDING_KVFREE:
+			kvfree(ptr);
+			break;
+		case RCU_PENDING_CALL_RCU:
+			head->func(head);
+			break;
+		default:
+			pending->process(pending, head);
+			break;
+		}
+		goto free_node;
+	}
+
+	local_irq_save(flags);
+	p = this_cpu_ptr(pending->p);
+	spin_lock(&p->lock);
+	goto restart;
+}
+
+void rcu_pending_enqueue(struct rcu_pending *pending, struct rcu_head *obj)
+{
+	__rcu_pending_enqueue(pending, obj, NULL, true);
+}
+
+static struct rcu_head *rcu_pending_pcpu_dequeue(struct rcu_pending_pcpu *p)
+{
+	struct rcu_head *ret = NULL;
+
+	spin_lock_irq(&p->lock);
+	darray_for_each(p->objs, objs)
+		if (objs->nr) {
+			ret = *genradix_ptr(&objs->objs, --objs->nr);
+			objs->cursor = NULL;
+			if (!objs->nr)
+				genradix_free(&objs->objs);
+			goto out;
+		}
+
+	static_array_for_each(p->lists, i)
+		if (i->head) {
+			ret = i->head;
+			i->head = ret->next;
+			if (!i->head)
+				i->tail = NULL;
+			goto out;
+		}
+out:
+	spin_unlock_irq(&p->lock);
+
+	return ret;
+}
+
+struct rcu_head *rcu_pending_dequeue(struct rcu_pending *pending)
+{
+	return rcu_pending_pcpu_dequeue(raw_cpu_ptr(pending->p));
+}
+
+struct rcu_head *rcu_pending_dequeue_from_all(struct rcu_pending *pending)
+{
+	struct rcu_head *ret = rcu_pending_dequeue(pending);
+
+	if (ret)
+		return ret;
+
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		ret = rcu_pending_pcpu_dequeue(per_cpu_ptr(pending->p, cpu));
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static bool rcu_pending_has_pending_or_armed(struct rcu_pending *pending)
+{
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
+		spin_lock_irq(&p->lock);
+		if (__rcu_pending_has_pending(p) || p->cb_armed) {
+			spin_unlock_irq(&p->lock);
+			return true;
+		}
+		spin_unlock_irq(&p->lock);
+	}
+
+	return false;
+}
+
+void rcu_pending_exit(struct rcu_pending *pending)
+{
+	int cpu;
+
+	if (!pending->p)
+		return;
+
+	while (rcu_pending_has_pending_or_armed(pending)) {
+		__rcu_barrier(pending->srcu);
+
+		for_each_possible_cpu(cpu) {
+			struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
+			flush_work(&p->work);
+		}
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
+		flush_work(&p->work);
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
+
+		static_array_for_each(p->lists, i)
+			WARN_ON(i->head);
+		WARN_ON(p->objs.nr);
+		darray_exit(&p->objs);
+	}
+	free_percpu(pending->p);
+}
+
+/**
+ * rcu_pending_init: - initialize a rcu_pending
+ *
+ * @pending:	Object to init
+ * @srcu:	May optionally be used with an srcu_struct; if NULL, uses normal
+ *		RCU flavor
+ * @process:	Callback function invoked on objects once their RCU barriers
+ *		have completed; if NULL, kvfree() is used.
+ */
+int rcu_pending_init(struct rcu_pending *pending,
+		     struct srcu_struct *srcu,
+		     rcu_pending_process_fn process)
+{
+	pending->p = alloc_percpu(struct rcu_pending_pcpu);
+	if (!pending->p)
+		return -ENOMEM;
+
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
+		p->parent	= pending;
+		p->cpu		= cpu;
+		spin_lock_init(&p->lock);
+		darray_init(&p->objs);
+		INIT_WORK(&p->work, rcu_pending_work);
+	}
+
+	pending->srcu = srcu;
+	pending->process = process;
+
+	return 0;
+}
-- 
2.45.2

