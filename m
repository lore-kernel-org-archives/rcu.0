Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294641487F4
	for <rcu@vger.kernel.org>; Fri, 14 Jun 2024 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396904; cv=none; b=rh6GEpBcOTQLH7ZOePWu+NBOR+5QQj6uufzPdtlMq8AnVLujxMzVBX6EeGioj6NB/XCDfeLXkFnfmS3IskccJ5CbDVZnPbqKsA7jIjzcLmabl8KDizCvXMhSZt4stS1/DLKfdR1ojs+aYPtlEKcxfZmParxTvqOX5VvLqAhu/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396904; c=relaxed/simple;
	bh=x54EcQozxO/y0UiAbMpmAL8JYeWOtMAdjTo6+5RMPpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/dKgFGp6z+x9qLSwW4U2Jp0DJ/LnCzUFZYpK9gh1cmHU1DGRRcSSF0o4Bc5bwpl7cIIuBiqKc30hnVQpo7gPrYdcNtM6CVqpBvu4Tp5SW/4VnacP4mfMdvy0Svy2aEpx6EYW1uQDB8Y1Ccyp7jr01SFegkXsdpGVcJFvx0PTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oGtaUE33; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oGtaUE33"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718396901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgm9iXF3NSSEIZ8sHMm1y6IBrGvYZES8HtZ1U4ooCT0=;
	b=oGtaUE33QVKzuLOn3GSzzDfj5bqVvLRHHTnKvTRe8oVU3QmLJF+1AgQRo8gcfNthF7fkmp
	mOzPSZZDc3YOXFeI4Tx0i9iTGzJqHOYFpSgkShAvj3Wdz6tu4LqLZEFKnFiQpuACa28x+c
	Bqgf27/iHeaE2hPxS5pk/B+FfNGNRck=
X-Envelope-To: rcu@vger.kernel.org
Date: Fri, 14 Jun 2024 16:28:14 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: [PATCH] bcachefs: pending_rcu_items
Message-ID: <xharqajk2o7xkpdk7mpd3jzj2suztubbqfms5xva367pcli5ny@6gjjjdbjo7om>
References: <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

This should incorporate everything we've covered so far; the one thing I
still have to look at is making it work as a kvfree_rcu() backend.

I decided not to do the "store the callback in the radix tree"
optimization for generic use - it made the code fairly ugly, and just
replacing the linked list with a radix tree should already be a
significant improvement.

Thoughts?

-- >8 --

Generic data structure for explicitly tracking pending RCU items,
allowing items to be dequeued (i.e. allocate from items pending
freeing).

- Works with conventional RCU and SRCU; pass in NULL for the srcu_struct
  for regular RCU

- Tracks pending items in a radix tree; falls back to linked list if
  radix tree allocation fails

todo: add support for being a kvfree_rcu() backend

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 0ab533a2b03b..c8394ec6f22f 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -68,6 +68,7 @@ bcachefs-y		:=	\
 	opts.o			\
 	printbuf.o		\
 	quota.o			\
+	rcu_pending.o		\
 	rebalance.o		\
 	recovery.o		\
 	recovery_passes.o	\
diff --git a/fs/bcachefs/rcu_pending.c b/fs/bcachefs/rcu_pending.c
new file mode 100644
index 000000000000..9b2f4da94425
--- /dev/null
+++ b/fs/bcachefs/rcu_pending.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/generic-radix-tree.h>
+#include <linux/percpu.h>
+#include <linux/srcu.h>
+#include "rcu_pending.h"
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
+static inline void __rcu_barrier(struct srcu_struct *ssp)
+{
+	return ssp
+		? srcu_barrier(ssp)
+		: rcu_barrier();
+}
+
+struct pending_rcu_items_seq {
+	GENRADIX(struct rcu_head *)	objs;
+	size_t				nr;
+	struct rcu_head			*list;
+	unsigned long			seq;
+};
+
+struct pending_rcu_items_pcpu {
+	struct pending_rcu_items	*parent;
+	spinlock_t			lock;
+	bool				rcu_armed;
+	struct pending_rcu_items_seq	objs[2];
+	struct rcu_head			rcu;
+	struct work_struct		work;
+};
+
+static bool get_finished_items(struct pending_rcu_items *pending,
+			       struct pending_rcu_items_pcpu *p,
+			       struct pending_rcu_items_seq *out)
+{
+	for (struct pending_rcu_items_seq *objs = p->objs;
+	     objs < p->objs + ARRAY_SIZE(p->objs); objs++)
+		if ((objs->nr || objs->list) &&
+		    poll_state_synchronize_srcu(pending->srcu, objs->seq)) {
+			*out = (struct pending_rcu_items_seq) {
+				/*
+				 * the genradix can only be modified with atomic instructions,
+				 * since we allocate new nodes without
+				 * pending_rcu_items_pcpu.lock
+				 */
+				.objs.tree.root	= xchg(&objs->objs.tree.root, NULL),
+				.nr		= objs->nr,
+				.list		= objs->list,
+			};
+			objs->nr	= 0;
+			objs->list	= NULL;
+			return true;
+		}
+	return false;
+}
+
+static void process_finished_items(struct pending_rcu_items *pending,
+				   struct pending_rcu_items_seq *objs)
+{
+	for (size_t i = 0; i < objs->nr; i++)
+		pending->process(pending, *genradix_ptr(&objs->objs, i));
+	genradix_free(&objs->objs);
+
+	while (objs->list) {
+		struct rcu_head *obj = objs->list;
+		objs->list = obj->next;
+		pending->process(pending, obj);
+	}
+}
+
+static void pending_rcu_items_rcu_cb(struct rcu_head *rcu)
+{
+	struct pending_rcu_items_pcpu *p =
+		container_of(rcu, struct pending_rcu_items_pcpu, rcu);
+
+	schedule_work(&p->work);
+}
+
+static bool __pending_rcu_items_has_pending(struct pending_rcu_items_pcpu *p)
+{
+	for (struct pending_rcu_items_seq *objs = p->objs;
+	     objs < p->objs + ARRAY_SIZE(p->objs); objs++)
+		if (objs->nr || objs->list)
+			return true;
+	return false;
+}
+
+static void pending_rcu_items_work(struct work_struct *work)
+{
+	struct pending_rcu_items_pcpu *p =
+		container_of(work, struct pending_rcu_items_pcpu, work);
+	struct pending_rcu_items *pending = p->parent;
+again:
+	spin_lock_irq(&p->lock);
+	struct pending_rcu_items_seq finished;
+	while (get_finished_items(pending, p, &finished)) {
+		spin_unlock_irq(&p->lock);
+		process_finished_items(pending, &finished);
+		goto again;
+	}
+
+	BUG_ON(!p->rcu_armed);
+	p->rcu_armed = __pending_rcu_items_has_pending(p);
+	if (p->rcu_armed)
+		call_srcu(pending->srcu, &p->rcu, pending_rcu_items_rcu_cb);
+	spin_unlock_irq(&p->lock);
+}
+
+void bch2_pending_rcu_item_enqueue(struct pending_rcu_items *pending, struct rcu_head *obj)
+{
+	struct pending_rcu_items_pcpu *p = raw_cpu_ptr(pending->p);
+	bool alloc_failed = false;
+	unsigned long flags;
+retry:
+	spin_lock_irqsave(&p->lock, flags);
+
+	struct pending_rcu_items_seq finished;
+	while (get_finished_items(pending, p, &finished)) {
+		spin_unlock_irqrestore(&p->lock, flags);
+		process_finished_items(pending, &finished);
+		goto retry;
+	}
+
+	struct pending_rcu_items_seq *objs;
+
+	unsigned long seq = __get_state_synchronize_rcu(pending->srcu);
+	for (objs = p->objs; objs < p->objs + ARRAY_SIZE(p->objs); objs++)
+		if (objs->nr && objs->seq == seq)
+			goto add;
+
+	seq = __start_poll_synchronize_rcu(pending->srcu);
+	for (objs = p->objs; objs < p->objs + ARRAY_SIZE(p->objs); objs++)
+		if (!objs->nr) {
+			objs->seq = seq;
+			goto add;
+		}
+
+	BUG();
+	struct rcu_head **entry;
+add:
+	entry = genradix_ptr_alloc(&objs->objs, objs->nr, GFP_ATOMIC|__GFP_NOWARN);
+	if (likely(entry)) {
+		*entry = obj;
+		objs->nr++;
+	} else if (likely(!alloc_failed)) {
+		spin_unlock_irqrestore(&p->lock, flags);
+		alloc_failed = !genradix_ptr_alloc(&objs->objs, objs->nr, GFP_KERNEL);
+		goto retry;
+	} else {
+		obj->next = objs->list;
+		objs->list = obj;
+	}
+
+	if (!p->rcu_armed) {
+		call_srcu(pending->srcu, &p->rcu, pending_rcu_items_rcu_cb);
+		p->rcu_armed = true;
+	}
+	spin_unlock_irqrestore(&p->lock, flags);
+}
+
+static struct rcu_head *pending_rcu_item_pcpu_dequeue(struct pending_rcu_items_pcpu *p)
+{
+	struct rcu_head *ret = NULL;
+
+	spin_lock_irq(&p->lock);
+	unsigned idx = p->objs[1].seq > p->objs[0].seq;
+
+	for (unsigned i = 0; i < 2; i++, idx ^= 1) {
+		struct pending_rcu_items_seq *objs = p->objs + idx;
+
+		if (objs->nr) {
+			ret = *genradix_ptr(&objs->objs, --objs->nr);
+			break;
+		}
+
+		if (objs->list) {
+			ret = objs->list;
+			objs->list = ret->next;
+			break;
+		}
+	}
+	spin_unlock_irq(&p->lock);
+
+	return ret;
+}
+
+struct rcu_head *bch2_pending_rcu_item_dequeue(struct pending_rcu_items *pending)
+{
+	return pending_rcu_item_pcpu_dequeue(raw_cpu_ptr(pending->p));
+}
+
+struct rcu_head *bch2_pending_rcu_item_dequeue_from_all(struct pending_rcu_items *pending)
+{
+	struct rcu_head *ret = NULL;
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		ret = pending_rcu_item_pcpu_dequeue(per_cpu_ptr(pending->p, cpu));
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static bool pending_rcu_items_has_pending(struct pending_rcu_items *pending)
+{
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		struct pending_rcu_items_pcpu *p = per_cpu_ptr(pending->p, cpu);
+		spin_lock_irq(&p->lock);
+		if (__pending_rcu_items_has_pending(p)) {
+			spin_unlock_irq(&p->lock);
+			return true;
+		}
+		spin_unlock_irq(&p->lock);
+	}
+
+	return false;
+}
+
+void bch2_pending_rcu_items_exit(struct pending_rcu_items *pending)
+{
+	if (!pending->p)
+		return;
+
+	while (pending_rcu_items_has_pending(pending))
+		__rcu_barrier(pending->srcu);
+
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		struct pending_rcu_items_pcpu *p = per_cpu_ptr(pending->p, cpu);
+
+		flush_work(&p->work);
+
+		WARN_ON(p->objs[0].nr);
+		WARN_ON(p->objs[1].nr);
+		WARN_ON(p->objs[0].list);
+		WARN_ON(p->objs[1].list);
+
+		genradix_free(&p->objs[0].objs);
+		genradix_free(&p->objs[1].objs);
+	}
+	free_percpu(pending->p);
+}
+
+int bch2_pending_rcu_items_init(struct pending_rcu_items *pending,
+				struct srcu_struct *srcu,
+				pending_rcu_item_process_fn process)
+{
+	pending->p = alloc_percpu(struct pending_rcu_items_pcpu);
+	if (!pending->p)
+		return -ENOMEM;
+
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		struct pending_rcu_items_pcpu *p = per_cpu_ptr(pending->p, cpu);
+		p->parent	= pending;
+		spin_lock_init(&p->lock);
+		INIT_WORK(&p->work, pending_rcu_items_work);
+	}
+
+	pending->srcu = srcu;
+	pending->process = process;
+
+	return 0;
+}
diff --git a/fs/bcachefs/rcu_pending.h b/fs/bcachefs/rcu_pending.h
new file mode 100644
index 000000000000..e45ede074443
--- /dev/null
+++ b/fs/bcachefs/rcu_pending.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_RCU_PENDING_H
+#define _BCACHEFS_RCU_PENDING_H
+
+struct pending_rcu_items;
+typedef void (*pending_rcu_item_process_fn)(struct pending_rcu_items *, struct rcu_head *);
+
+struct pending_rcu_items_pcpu;
+
+struct pending_rcu_items {
+	struct pending_rcu_items_pcpu __percpu *p;
+	struct srcu_struct		*srcu;
+	pending_rcu_item_process_fn	process;
+};
+
+void bch2_pending_rcu_item_enqueue(struct pending_rcu_items *pending, struct rcu_head *obj);
+struct rcu_head *bch2_pending_rcu_item_dequeue(struct pending_rcu_items *pending);
+struct rcu_head *bch2_pending_rcu_item_dequeue_from_all(struct pending_rcu_items *pending);
+
+void bch2_pending_rcu_items_exit(struct pending_rcu_items *pending);
+int bch2_pending_rcu_items_init(struct pending_rcu_items *pending,
+				struct srcu_struct *srcu,
+				pending_rcu_item_process_fn process);
+
+#endif /* _BCACHEFS_RCU_PENDING_H */
