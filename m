Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF05D6FB1
	for <rcu@vger.kernel.org>; Fri, 14 Jun 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374310; cv=none; b=lxnz8V/mVtq7EWKucdOvuuZ2FdsX5TKHMWtQZJtqyhCMsMGVjzvFA7q6FoEqwncWp/3h50UINJ1bF7p2crzj6IZCmVFIxS8rl5r4qqxDDV9mLypA9+HeUGQVhrleBnYJ1oXavDpNNEGw7twVww3ugtNsYcsl6EmZAYxLGy0iEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374310; c=relaxed/simple;
	bh=Op23UnGLbA3BGHWzY0J9AKLr//RqLWDwn6E+X+rOAIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoU5tv6fm6Bth/y4ELD7ShTyTvHEJIklSUrkqawSC8Op7V+FY55KHY4osyF11MUhWshYVCd62+UyGHrXY4ASpGXlDRGfMw9BklBnpMWoVFgax8v0GauuI6mWUQx8h4Catxe11ozsb2OOVK2P5cGNUzsizVYtiZ3nzx1461NrxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT/gWKC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT/gWKC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EE7C2BD10;
	Fri, 14 Jun 2024 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718374310;
	bh=Op23UnGLbA3BGHWzY0J9AKLr//RqLWDwn6E+X+rOAIw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NT/gWKC1l7xrTiO7kz+OXFNq+RJ2jUcq0ASilcLLgQjDNw9GbXnTIRdoVgQJcLnHG
	 4zWRqSE/JN3cTZU6EBNXU8LNqKzK9U9j6C8izBVlHCgvVtteuAPvxwxmeNfzby6X+w
	 6ullzX+r7pZIEJimOLwAwOP2k3mzfReP0IeS34rh80/YNGFEKZk4GsmDkYU/QUBw7i
	 xaeLYKREd30ik3AKLWkYrHD3dWLbH9KIOlj3ifMYAjZCrrf50ypEHdpDupglxyyH0j
	 gEg9HptVDcZlGdTwNMzA87KJBa+rFt1Yak/iFRSVZLK8OcvYC7xyafojOwRFVUQWt0
	 uVgUxDkq37V7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F269CE0551; Fri, 14 Jun 2024 07:11:50 -0700 (PDT)
Date: Fri, 14 Jun 2024 07:11:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>

On Thu, Jun 13, 2024 at 08:22:19PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 02:32:27PM -0400, Kent Overstreet wrote:

[ . . . ]

After sleeping on it, backing up a level of abstraction, and thus perhaps
responding a bit more constructively...

And also, thank you very much for looking into this!

> > commit 3bb5d34d6d6e2d5433cce5d248fd81211afedec0
> > Author: Kent Overstreet <kent.overstreet@linux.dev>
> > Date:   Mon Jun 10 20:47:03 2024 -0400
> > 
> >     bcachefs: pending_rcu_items
> >     
> >     Generic (?) data structure for explicitly tracking pending SRCU items
> >     
> >     - Can we make this generic across other RCU flavors?

It should be possible, at least for current RCU and SRCU.  I think I owe
you SRCU variants of a couple of existing RCU functions.  Later today!

> >     - Do we need to add a fallback to linked lists when darray allocation
> >       fails?

In general, as in kfree_rcu(), yes.  In your specific case here, maybe not.

> >     - We wish to avoid the overhead of start_poll_synchronize_srcu() if we
> >       already have items for a given sequence number, but it appears
> >       get_poll_synchronize_srcu(); start_poll_synchronize_srcu() can
> >       actually return differert sequence numbers within the same read-side
> >       critical section. Is this the correct way of doing this?

You can always buffer up items that have not yet been assigned a sequence
number, then after you have enough or after enough time has passed, do a
single get_poll_synchronize_srcu() for the group.

> >     - Do we need to ensure the rearming RCU callback is correctly flushed
> >       when exiting? (Probably)

I believe so, and setting a flag then doing an srcu_barrier() should suffice.

> >     Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > 
> > diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
> > index ebed60a43647..46f7fa549d59 100644
> > --- a/fs/bcachefs/btree_key_cache.c
> > +++ b/fs/bcachefs/btree_key_cache.c
> > @@ -83,18 +83,109 @@ static bool bkey_cached_evict(struct btree_key_cache *c,
> >  	return ret;
> >  }
> >  
> > -static void __bkey_cached_free(struct rcu_head *rcu)
> > +#define RCU_SEQ_SKIP_SHIFT	2
> > +
> > +static void pending_rcu_items_exit(struct pending_rcu_items *pending)
> > +{
> > +	darray_exit(&pending->objs[0]);
> > +	darray_exit(&pending->objs[1]);
> > +}
> > +
> > +static void pending_rcu_items_init(struct pending_rcu_items *pending,
> > +				   struct srcu_struct *srcu,
> > +				   pending_rcu_item_process_fn process)
> > +{
> > +	memset(pending, 0, sizeof(*pending));
> > +	pending->srcu		= srcu;
> > +	pending->process	= process;
> > +	spin_lock_init(&pending->lock);
> > +}
> > +
> > +static bool pending_rcu_has_items(struct pending_rcu_items *pending)
> > +{
> > +	return pending->objs[0].nr || pending->objs[1].nr;
> > +}
> > +
> > +static void pending_rcu_items_process(struct pending_rcu_items *pending)
> >  {
> > -	struct bkey_cached *ck = container_of(rcu, struct bkey_cached, rcu);
> > +	while (pending_rcu_has_items(pending) &&
> > +	       poll_state_synchronize_srcu(pending->srcu, pending->seq)) {
> > +		darray_for_each(pending->objs[0], i)
> > +			pending->process(pending, *i);

Given that you have interrupts and/or bh disabled, there needs to be a
third set of callbacks, those whose grace periods are already elapsed.

Unioning one of the ->objs[] sets onto this third set, leaving the source
->objs[] set empty, should strongly be O(1) without the need for memory
allocation.  I might be missing something, but at first glance darray
does not support this.

The pages-of-pointers structure named kvfree_rcu_bulk_data, along with
the associated structures in kernel/rcu/tree.c does this work, but (1)
is open-coded and (2) has to deal with the full range of what the kernel
can throw at it.  It falls back to an embedded rcu_head structure, in
response to your second question in the commit log.

But perhaps this code could be generalized?  Or maybe darray can be
appropriately extended?

And one thing that I missed the first time around is that you are using
a single ->seq for two sets of objects (->objs[0] and ->objs[1]).
Each set needs its own sequence number.

> > +		darray_exit(&pending->objs[0]);
> > +		swap(pending->objs[0], pending->objs[1]);
> > +		pending->seq += 1 << RCU_SEQ_SKIP_SHIFT;
> > +	}
> > +}
> > +
> > +static void pending_rcu_items_rcu_cb(struct rcu_head *rcu)
> > +{
> > +	struct pending_rcu_items *pending =
> > +		container_of(rcu, struct pending_rcu_items, rcu);
> > +
> > +	unsigned long flags;
> > +	spin_lock_irqsave(&pending->lock, flags);
> > +	pending_rcu_items_process(pending);
> 
> SRCU callbacks execute in softirq context.  You therefore might need to
> push this call to pending_rcu_items_process() to a workqueue handler,
> at least if there are very many objects in need of processing.

Plus you have irqs disabled, which I somehow missed on the first pass.

Again, please union the objects whose grace period has ended into a set
that is ready to be processed, and then do the processing in a workqueue
handler, kthread, or similar.  This avoids causing real-time latency
problems, or, in extreme cases, softlockups or RCU CPU stall warnings.

> > -	kmem_cache_free(bch2_key_cache, ck);
> > +	pending->rcu_armed = pending_rcu_has_items(pending);
> > +	if (pending->rcu_armed)
> > +		call_srcu(pending->srcu, &pending->rcu, pending_rcu_items_rcu_cb);
> > +	spin_unlock_irqrestore(&pending->lock, flags);
> > +}
> > +
> > +static void pending_rcu_item_enqueue(struct pending_rcu_items *pending, void *obj)
> > +{
> > +	darray_voidp preallocated = {};
> > +retry:
> > +	spin_lock_irq(&pending->lock);
> > +	pending_rcu_items_process(pending);
> 
> Suppose that poll_state_synchronize_srcu() returns false so that
> start_poll_synchronize_srcu() does nothing...
> 
> ... then we get vCPU preemption here so that some number of SRCU grace
> periods elapse (which looks to be limited to just one of them, but that
> is enough because we might already have requested the next one courtesy of
> the previous call to either call_srcu() or start_poll_synchronize_srcu()) ...
> 
> > +	unsigned long seq = start_poll_synchronize_srcu(pending->srcu);
> 
> ... so that we get a seq that is 8 or 12 larger than pending->seq ...
> 
> > +	if (!pending_rcu_has_items(pending))
> > +		pending->seq = seq;
> 
> ... and we don't update pending->seq because there are still items there ...
> 
> > +	unsigned idx = (seq - pending->seq) >> RCU_SEQ_SKIP_SHIFT;
> > +	BUG_ON(idx > ARRAY_SIZE(pending->objs));

And more on this later today.

							Thanx, Paul

> ... then can't this BUG_ON() trigger?
> 
> And why this ugly reliance on the cookie format?  Why not just have
> the pending_rcu_items structure's ->seq be a two-element array?
> 
> Then all you need to do is to check each ->seq[] element to see if it
> is equal to seq, while remembering the index of the first that is empty.
> If you find a ->seq[] match, just enqueue into the corresponding ->objs[]
> element.  Otherwise, you are guaranteed to have found an empty ->obj[],
> at least if you move the start_poll_synchronize_srcu() to precede
> the pending_rcu_items_process().
> 
> *Much* looser coupling with SRCU and rather simpler.
> 
> > +	darray_voidp *objs = pending->objs + idx;
> > +
> > +	if (!darray_room(*objs)) {
> > +		if (preallocated.size > objs->size) {
> > +			memcpy(preallocated.data,
> > +			       objs->data,
> > +			       sizeof(objs->data[0]) * objs->nr);
> > +			swap(preallocated.data, objs->data);
> > +			swap(preallocated.size, objs->size);
> > +		} else if (darray_make_room_gfp(objs, 1, GFP_ATOMIC|__GFP_NOWARN)) {
> > +			spin_unlock_irq(&pending->lock);
> > +			darray_exit(&preallocated);
> > +			darray_make_room_gfp(&preallocated, objs->nr + 1, GFP_KERNEL|__GFP_NOFAIL);
> > +			goto retry;
> > +		}
> > +	}
> > +
> > +	BUG_ON(darray_push(objs, obj)); /* preallocated */
> > +
> > +	if (!pending->rcu_armed)
> > +		call_srcu(pending->srcu, &pending->rcu, pending_rcu_items_rcu_cb);
> 
> The start_poll_synchronize_srcu() above might have started a new
> SRCU grace period.  If so, this call_srcu() will start another one.
> Which should not be a problem.  If it does prove to be, you might use
> get_state_synchronize_srcu() instead, depending.
> 
> On the other hand, if this code is prone to bkey_cached_free() floods, the
> current combination of start_poll_synchronize_srcu() and call_srcu()
> might avoid OOM, given that this function checks for pending objects
> whose grace period has ended.
> 
> > +	pending->rcu_armed = true;
> > +	spin_unlock_irq(&pending->lock);
> > +
> > +	darray_exit(&preallocated);
> > +}
> > +
> > +static void __bkey_cached_free(struct pending_rcu_items *pending, void *obj)
> > +{
> > +	struct bch_fs *c = container_of(pending->srcu, struct bch_fs, btree_trans_barrier);
> > +
> > +	this_cpu_dec(*c->btree_key_cache.nr_pending);
> > +	kmem_cache_free(bch2_key_cache, obj);
> >  }
> >  
> >  static void bkey_cached_free(struct btree_key_cache *bc,
> >  			     struct bkey_cached *ck)
> >  {
> > -	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
> > -
> >  	kfree(ck->k);
> >  	ck->k		= NULL;
> >  	ck->u64s	= 0;
> > @@ -102,7 +193,15 @@ static void bkey_cached_free(struct btree_key_cache *bc,
> >  	six_unlock_write(&ck->c.lock);
> >  	six_unlock_intent(&ck->c.lock);
> >  
> > -	call_srcu(&c->btree_trans_barrier, &ck->rcu, __bkey_cached_free);
> > +	preempt_disable();
> > +	struct pending_rcu_items *pending = this_cpu_ptr(bc->pending);
> > +	preempt_enable();
> > +	/*
> > +	 * pending is protected by a lock, we don't need preemption disabled -
> > +	 * and it expects to run in sleepable context:
> > +	 */
> > +	pending_rcu_item_enqueue(pending, ck);
> > +	this_cpu_inc(*bc->nr_pending);
> >  }
> >  
> >  static struct bkey_cached *
> > @@ -778,6 +877,13 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
> >  
> >  	if (bc->table_init_done)
> >  		rhashtable_destroy(&bc->table);
> > +
> > +	free_percpu(bc->nr_pending);
> > +
> > +	int cpu;
> > +	for_each_possible_cpu(cpu)
> > +		pending_rcu_items_exit(per_cpu_ptr(bc->pending, cpu));
> > +	free_percpu(bc->pending);
> >  }
> >  
> >  void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
> > @@ -789,6 +895,20 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
> >  	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
> >  	struct shrinker *shrink;
> >  
> > +#ifdef __KERNEL__
> > +	bc->pending = alloc_percpu(struct pending_rcu_items);
> > +	if (!bc->pending)
> > +		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> > +#endif
> > +	int cpu;
> > +	for_each_possible_cpu(cpu)
> > +		pending_rcu_items_init(per_cpu_ptr(bc->pending, cpu),
> > +				       &c->btree_trans_barrier, __bkey_cached_free);
> > +
> > +	bc->nr_pending = alloc_percpu(size_t);
> > +	if (!bc->nr_pending)
> > +		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> > +
> >  	if (rhashtable_init(&bc->table, &bch2_btree_key_cache_params))
> >  		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> >  
> > @@ -815,13 +935,15 @@ void bch2_btree_key_cache_to_text(struct printbuf *out, struct btree_key_cache *
> >  	prt_printf(out, "keys:\t%lu\r\n",		atomic_long_read(&bc->nr_keys));
> >  	prt_printf(out, "dirty:\t%lu\r\n",		atomic_long_read(&bc->nr_dirty));
> >  	prt_printf(out, "table size:\t%u\r\n",		bc->table.tbl->size);
> > -
> > -	prt_printf(out, "\nshrinker:\n");
> > +	prt_newline(out);
> > +	prt_printf(out, "shrinker:\n");
> >  	prt_printf(out, "requested_to_free:\t%lu\r\n",	bc->requested_to_free);
> >  	prt_printf(out, "freed:\t%lu\r\n",		bc->freed);
> >  	prt_printf(out, "skipped_dirty:\t%lu\r\n",	bc->skipped_dirty);
> >  	prt_printf(out, "skipped_accessed:\t%lu\r\n",	bc->skipped_accessed);
> >  	prt_printf(out, "skipped_lock_fail:\t%lu\r\n",	bc->skipped_lock_fail);
> > +	prt_newline(out);
> > +	prt_printf(out, "pending:\t%lu\r\n",		per_cpu_sum(bc->nr_pending));
> >  }
> >  
> >  void bch2_btree_key_cache_exit(void)
> > diff --git a/fs/bcachefs/btree_key_cache_types.h b/fs/bcachefs/btree_key_cache_types.h
> > index e026c65f54e1..8d11cbac4c37 100644
> > --- a/fs/bcachefs/btree_key_cache_types.h
> > +++ b/fs/bcachefs/btree_key_cache_types.h
> > @@ -2,12 +2,29 @@
> >  #ifndef _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
> >  #define _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
> >  
> > +#include "darray.h"
> > +
> > +struct pending_rcu_items;
> > +typedef void (*pending_rcu_item_process_fn)(struct pending_rcu_items *, void *);
> > +
> > +struct pending_rcu_items {
> > +	struct srcu_struct		*srcu;
> > +	pending_rcu_item_process_fn	process;
> > +	spinlock_t			lock;
> > +	bool				rcu_armed;
> > +	unsigned long			seq;
> > +	darray_voidp			objs[2];
> > +	struct rcu_head			rcu;
> > +};
> > +
> >  struct btree_key_cache {
> >  	struct rhashtable	table;
> >  	bool			table_init_done;
> >  
> >  	struct shrinker		*shrink;
> >  	unsigned		shrink_iter;
> > +	struct pending_rcu_items __percpu *pending;
> > +	size_t __percpu		*nr_pending;
> >  
> >  	atomic_long_t		nr_keys;
> >  	atomic_long_t		nr_dirty;
> > diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
> > index 67f3efd9a007..56046f09ac65 100644
> > --- a/fs/bcachefs/btree_types.h
> > +++ b/fs/bcachefs/btree_types.h
> > @@ -396,8 +396,6 @@ struct bkey_cached {
> >  	u64			seq;
> >  
> >  	struct bkey_i		*k;
> > -
> > -	struct rcu_head		rcu;
> >  };
> >  
> >  static inline struct bpos btree_node_pos(struct btree_bkey_cached_common *b)
> > diff --git a/fs/bcachefs/darray.h b/fs/bcachefs/darray.h
> > index 4b340d13caac..cdace10f4572 100644
> > --- a/fs/bcachefs/darray.h
> > +++ b/fs/bcachefs/darray.h
> > @@ -19,6 +19,7 @@ struct {								\
> >  
> >  #define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
> >  
> > +typedef DARRAY(void *)	darray_voidp;
> >  typedef DARRAY(char)	darray_char;
> >  typedef DARRAY(char *) darray_str;
> >  
