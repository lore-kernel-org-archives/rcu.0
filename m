Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254814A62B
	for <rcu@vger.kernel.org>; Thu, 13 Jun 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303557; cv=none; b=jSHCavWbzKBVH92lWL3lDATK7MifjeI1vfshrvUNexTm4JlBKWm6pTg08Ew3IpD2qH+1RyWLq+jnXCHqBpbxi3Gl373B+PI7i5O5ms7VH974xpgL0o4d7FRwwnT+mp0tH8j77xmQ+qMV76PyfQsCuC7of5KmozePPT6RE0ri0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303557; c=relaxed/simple;
	bh=xPq3MpEGOqxKEbYmS2b/HYXdJ9lNSmMEzWmd0e4cU2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzU0orPdEHYltQ073qB9mcPJeSc3GK/Y8ilkrCFO2HZ2bnF1Oqf+p5FMh4mP4NwdqFlQl1YBQ8SK2IgckP5f5sxl5aDCpjpssZXoIc5K7/H1YSBEZxpBnCtDTSwFQp0upKl3i53930PCf2imGKdf6mei1ZxeTdga8CmqH7KTUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o/l4Mvdp; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o/l4Mvdp"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718303552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZ4kRL9e9EYYNONvM1iFZ3spcaKIPI15RvuZ05QRpJ8=;
	b=o/l4Mvdp0S7RHXeJHh+SC2hQU2cSYKNtdrvTWGNVQsevXMlOPblcRxYP+qeqkRY2MqZpZe
	37/CPmju5vOpF2XDZCUutnMUNs3czDkXJRUgZRy7x1RLI67xtfE3R1ATkAzxC3ik+WVEPs
	fjXR4VbsHinIVmBT0d7LRYuhCxdKRhs=
X-Envelope-To: rcu@vger.kernel.org
Date: Thu, 13 Jun 2024 14:32:27 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 12, 2024 at 08:48:40PM -0700, Paul E. McKenney wrote:
> The number two is the number of distinct values, which will not be
> consecutive numbers.  As you noticed, they currently are always multiples
> of four, but that is an accident of implementation that is subject to
> change.

I take it you're stuffing something else into the low bits and masking
it off, and you can't shift that off because that would break
comparisons. That's a tiny bit unfortunate; it would be nicer if we
could do array indexing based on the sequence number.

What if we added something like this?

#define RCU_SEQ_SKIP_SHIFT	2

> > I could use a doubly linked list for tracking all uncompleted objects,
> > but I'm hoping use a darray per sequence number. Is it a max of two
> > sequence numbers that had objects/callbacks/were requested pulling,
> > or...?
> 
> Agreed, an array should work.  Each array element would need a field
> recording its cookie.  Right, so you likely need a few more simple
> functions:
> 
> 	same_state_synchronize_srcu(): Equality comparison of the
> 		pair of cookies passed in.
> 	get_completed_synchronize_srcu(): Return a special cookie
> 		that, when passed to poll_state_synchronize_srcu(),
> 		always results in a @true return value.
> 
> Or maybe not, you tell me.

I don't think so, but I'm not sure what your intended use is.

> > Also, I'm wondering if this code might be worth turning into something
> > generic...
> > 
> > What I'm sketching out is:
> > 
> > struct btree_key_cache_freelist {
> > 	spinlock_t		lock;
> > 	bool			rcu_armed;
> 
> This says whether or not the callback corresponding to ->rcu is in
> flight?

Correct.

> 
> > 	unsigned long		seq;
> 
> You store the get_state_synchronize_srcu() return value in ->seq?

Yes

> 
> > 	struct bkey_cached	*free[2]; /* singly linked list for now,
> > 					   * perhaps darray/vector later
> > 					   */
> 
> If ->free[] is the array, then you also need an array to hold the cookies.
> Unless you are placing them in the objects themselves, which would
> also work.
> 
> By "darray" you mean distributed array?

dynamic array, basically a c++ vector - fs/bcachefs/darray.h

> 
> > 	struct rcu_head		rcu; /* rearming callback to free objects */
> > };
> > 
> > and these are percpu. Thoughts?
> 
> This definitely looks to be moving in a good direction, give or take
> the accuracy of my guesses above.

I think I have something mostly working, with the caveat that my
assumption about get_state_synchronize_srcu() and
start_poll_synchronize_srcu() turned out to be wrong.

Think this would be worth factoring out and turning into something
generic? If RCU wanted to use this internally for tracking pending
callbacks, we could get rid of linked list overhead there...

commit 3bb5d34d6d6e2d5433cce5d248fd81211afedec0
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Jun 10 20:47:03 2024 -0400

    bcachefs: pending_rcu_items
    
    Generic (?) data structure for explicitly tracking pending SRCU items
    
    - Can we make this generic across other RCU flavors?
    
    - Do we need to add a fallback to linked lists when darray allocation
      fails?
    
    - We wish to avoid the overhead of start_poll_synchronize_srcu() if we
      already have items for a given sequence number, but it appears
      get_poll_synchronize_srcu(); start_poll_synchronize_srcu() can
      actually return differert sequence numbers within the same read-side
      critical section. Is this the correct way of doing this?
    
    - Do we need to ensure the rearming RCU callback is correctly flushed
      when exiting? (Probably)
    
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index ebed60a43647..46f7fa549d59 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -83,18 +83,109 @@ static bool bkey_cached_evict(struct btree_key_cache *c,
 	return ret;
 }
 
-static void __bkey_cached_free(struct rcu_head *rcu)
+#define RCU_SEQ_SKIP_SHIFT	2
+
+static void pending_rcu_items_exit(struct pending_rcu_items *pending)
+{
+	darray_exit(&pending->objs[0]);
+	darray_exit(&pending->objs[1]);
+}
+
+static void pending_rcu_items_init(struct pending_rcu_items *pending,
+				   struct srcu_struct *srcu,
+				   pending_rcu_item_process_fn process)
+{
+	memset(pending, 0, sizeof(*pending));
+	pending->srcu		= srcu;
+	pending->process	= process;
+	spin_lock_init(&pending->lock);
+}
+
+static bool pending_rcu_has_items(struct pending_rcu_items *pending)
+{
+	return pending->objs[0].nr || pending->objs[1].nr;
+}
+
+static void pending_rcu_items_process(struct pending_rcu_items *pending)
 {
-	struct bkey_cached *ck = container_of(rcu, struct bkey_cached, rcu);
+	while (pending_rcu_has_items(pending) &&
+	       poll_state_synchronize_srcu(pending->srcu, pending->seq)) {
+		darray_for_each(pending->objs[0], i)
+			pending->process(pending, *i);
+		darray_exit(&pending->objs[0]);
+		swap(pending->objs[0], pending->objs[1]);
+		pending->seq += 1 << RCU_SEQ_SKIP_SHIFT;
+	}
+}
+
+static void pending_rcu_items_rcu_cb(struct rcu_head *rcu)
+{
+	struct pending_rcu_items *pending =
+		container_of(rcu, struct pending_rcu_items, rcu);
+
+	unsigned long flags;
+	spin_lock_irqsave(&pending->lock, flags);
+	pending_rcu_items_process(pending);
 
-	kmem_cache_free(bch2_key_cache, ck);
+	pending->rcu_armed = pending_rcu_has_items(pending);
+	if (pending->rcu_armed)
+		call_srcu(pending->srcu, &pending->rcu, pending_rcu_items_rcu_cb);
+	spin_unlock_irqrestore(&pending->lock, flags);
+}
+
+static void pending_rcu_item_enqueue(struct pending_rcu_items *pending, void *obj)
+{
+	darray_voidp preallocated = {};
+retry:
+	spin_lock_irq(&pending->lock);
+	pending_rcu_items_process(pending);
+
+	unsigned long seq = start_poll_synchronize_srcu(pending->srcu);
+
+	if (!pending_rcu_has_items(pending))
+		pending->seq = seq;
+
+	unsigned idx = (seq - pending->seq) >> RCU_SEQ_SKIP_SHIFT;
+	BUG_ON(idx > ARRAY_SIZE(pending->objs));
+
+	darray_voidp *objs = pending->objs + idx;
+
+	if (!darray_room(*objs)) {
+		if (preallocated.size > objs->size) {
+			memcpy(preallocated.data,
+			       objs->data,
+			       sizeof(objs->data[0]) * objs->nr);
+			swap(preallocated.data, objs->data);
+			swap(preallocated.size, objs->size);
+		} else if (darray_make_room_gfp(objs, 1, GFP_ATOMIC|__GFP_NOWARN)) {
+			spin_unlock_irq(&pending->lock);
+			darray_exit(&preallocated);
+			darray_make_room_gfp(&preallocated, objs->nr + 1, GFP_KERNEL|__GFP_NOFAIL);
+			goto retry;
+		}
+	}
+
+	BUG_ON(darray_push(objs, obj)); /* preallocated */
+
+	if (!pending->rcu_armed)
+		call_srcu(pending->srcu, &pending->rcu, pending_rcu_items_rcu_cb);
+	pending->rcu_armed = true;
+	spin_unlock_irq(&pending->lock);
+
+	darray_exit(&preallocated);
+}
+
+static void __bkey_cached_free(struct pending_rcu_items *pending, void *obj)
+{
+	struct bch_fs *c = container_of(pending->srcu, struct bch_fs, btree_trans_barrier);
+
+	this_cpu_dec(*c->btree_key_cache.nr_pending);
+	kmem_cache_free(bch2_key_cache, obj);
 }
 
 static void bkey_cached_free(struct btree_key_cache *bc,
 			     struct bkey_cached *ck)
 {
-	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
-
 	kfree(ck->k);
 	ck->k		= NULL;
 	ck->u64s	= 0;
@@ -102,7 +193,15 @@ static void bkey_cached_free(struct btree_key_cache *bc,
 	six_unlock_write(&ck->c.lock);
 	six_unlock_intent(&ck->c.lock);
 
-	call_srcu(&c->btree_trans_barrier, &ck->rcu, __bkey_cached_free);
+	preempt_disable();
+	struct pending_rcu_items *pending = this_cpu_ptr(bc->pending);
+	preempt_enable();
+	/*
+	 * pending is protected by a lock, we don't need preemption disabled -
+	 * and it expects to run in sleepable context:
+	 */
+	pending_rcu_item_enqueue(pending, ck);
+	this_cpu_inc(*bc->nr_pending);
 }
 
 static struct bkey_cached *
@@ -778,6 +877,13 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
 
 	if (bc->table_init_done)
 		rhashtable_destroy(&bc->table);
+
+	free_percpu(bc->nr_pending);
+
+	int cpu;
+	for_each_possible_cpu(cpu)
+		pending_rcu_items_exit(per_cpu_ptr(bc->pending, cpu));
+	free_percpu(bc->pending);
 }
 
 void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
@@ -789,6 +895,20 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
 	struct shrinker *shrink;
 
+#ifdef __KERNEL__
+	bc->pending = alloc_percpu(struct pending_rcu_items);
+	if (!bc->pending)
+		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
+#endif
+	int cpu;
+	for_each_possible_cpu(cpu)
+		pending_rcu_items_init(per_cpu_ptr(bc->pending, cpu),
+				       &c->btree_trans_barrier, __bkey_cached_free);
+
+	bc->nr_pending = alloc_percpu(size_t);
+	if (!bc->nr_pending)
+		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
+
 	if (rhashtable_init(&bc->table, &bch2_btree_key_cache_params))
 		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
 
@@ -815,13 +935,15 @@ void bch2_btree_key_cache_to_text(struct printbuf *out, struct btree_key_cache *
 	prt_printf(out, "keys:\t%lu\r\n",		atomic_long_read(&bc->nr_keys));
 	prt_printf(out, "dirty:\t%lu\r\n",		atomic_long_read(&bc->nr_dirty));
 	prt_printf(out, "table size:\t%u\r\n",		bc->table.tbl->size);
-
-	prt_printf(out, "\nshrinker:\n");
+	prt_newline(out);
+	prt_printf(out, "shrinker:\n");
 	prt_printf(out, "requested_to_free:\t%lu\r\n",	bc->requested_to_free);
 	prt_printf(out, "freed:\t%lu\r\n",		bc->freed);
 	prt_printf(out, "skipped_dirty:\t%lu\r\n",	bc->skipped_dirty);
 	prt_printf(out, "skipped_accessed:\t%lu\r\n",	bc->skipped_accessed);
 	prt_printf(out, "skipped_lock_fail:\t%lu\r\n",	bc->skipped_lock_fail);
+	prt_newline(out);
+	prt_printf(out, "pending:\t%lu\r\n",		per_cpu_sum(bc->nr_pending));
 }
 
 void bch2_btree_key_cache_exit(void)
diff --git a/fs/bcachefs/btree_key_cache_types.h b/fs/bcachefs/btree_key_cache_types.h
index e026c65f54e1..8d11cbac4c37 100644
--- a/fs/bcachefs/btree_key_cache_types.h
+++ b/fs/bcachefs/btree_key_cache_types.h
@@ -2,12 +2,29 @@
 #ifndef _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
 #define _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
 
+#include "darray.h"
+
+struct pending_rcu_items;
+typedef void (*pending_rcu_item_process_fn)(struct pending_rcu_items *, void *);
+
+struct pending_rcu_items {
+	struct srcu_struct		*srcu;
+	pending_rcu_item_process_fn	process;
+	spinlock_t			lock;
+	bool				rcu_armed;
+	unsigned long			seq;
+	darray_voidp			objs[2];
+	struct rcu_head			rcu;
+};
+
 struct btree_key_cache {
 	struct rhashtable	table;
 	bool			table_init_done;
 
 	struct shrinker		*shrink;
 	unsigned		shrink_iter;
+	struct pending_rcu_items __percpu *pending;
+	size_t __percpu		*nr_pending;
 
 	atomic_long_t		nr_keys;
 	atomic_long_t		nr_dirty;
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 67f3efd9a007..56046f09ac65 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -396,8 +396,6 @@ struct bkey_cached {
 	u64			seq;
 
 	struct bkey_i		*k;
-
-	struct rcu_head		rcu;
 };
 
 static inline struct bpos btree_node_pos(struct btree_bkey_cached_common *b)
diff --git a/fs/bcachefs/darray.h b/fs/bcachefs/darray.h
index 4b340d13caac..cdace10f4572 100644
--- a/fs/bcachefs/darray.h
+++ b/fs/bcachefs/darray.h
@@ -19,6 +19,7 @@ struct {								\
 
 #define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
 
+typedef DARRAY(void *)	darray_voidp;
 typedef DARRAY(char)	darray_char;
 typedef DARRAY(char *) darray_str;
 
