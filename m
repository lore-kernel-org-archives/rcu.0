Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13499EEDA
	for <rcu@vger.kernel.org>; Fri, 14 Jun 2024 03:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718335345; cv=none; b=brC0hs2UCHyYgqWNYRQSCm2riM+G+RkMxNjGvdVTux3hIS5x/EoAGuZA0r8D0BWk0qDYUh2GFI5CJt6uMqCbdGdovtnx2utrsUbzdAAXbI0vy1Q3Xtg0kQLMv9mHEbAp4dgmV2O/SWaHgRwrMraNC+TJ1cCsnI9a7zPSfTB2XlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718335345; c=relaxed/simple;
	bh=mIUsoPiiuDsZvyOZlj1qPIt/KA8niGQn+bcizw1UhRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2pfO3H1VKD3wDiKyM5+wkuMHtYAjoGDSIF6Nv/ybEqmRREM1ZdjZHSf9wxE23dofCH5aV+wuR0KYQZeZ3eWcYjPrEWRcDjqmhO9bK3sok5eYWHAoQs+8cfEJtj0+/ORmKgf3pwlF/W21T059Fgcs2fObyM4HLWMFaFg5dBAUIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa6JTBq+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa6JTBq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90914C2BBFC;
	Fri, 14 Jun 2024 03:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718335344;
	bh=mIUsoPiiuDsZvyOZlj1qPIt/KA8niGQn+bcizw1UhRw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=aa6JTBq+DtBV9ZvUvzMrgay22c9TkPV/oG5N64/tzhr/br7Ge9wJguUvV9dNZDpXI
	 bmuZJIHGRin6D36MYndCzvD70bfvskd3Vy4DjxJGT5aiPjjhqf6NMvI63mIXvrxcWK
	 5UwX4CuBqIKU7fSA8A8hR95lkvrVA2/0207Pk6Wz51o+lsXt3gg7zhnXkE6EU8MZI7
	 1pzcG1r+q1W7hYxHjCA6PbyTnwlh2yJa4zTzPw8LBWM5fEuDdtVjlbITDHTUMDHi6v
	 56wSkrTP65MIWRg8VIsxDNVLokTVFff720+sqQFMBjuOUC/h0zu/fcK6+hEB7QZm4s
	 Y1PctnlwkcKyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 29030CE094C; Thu, 13 Jun 2024 20:22:19 -0700 (PDT)
Date: Thu, 13 Jun 2024 20:22:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
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
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>

On Thu, Jun 13, 2024 at 02:32:27PM -0400, Kent Overstreet wrote:
> On Wed, Jun 12, 2024 at 08:48:40PM -0700, Paul E. McKenney wrote:
> > The number two is the number of distinct values, which will not be
> > consecutive numbers.  As you noticed, they currently are always multiples
> > of four, but that is an accident of implementation that is subject to
> > change.
> 
> I take it you're stuffing something else into the low bits and masking
> it off, and you can't shift that off because that would break
> comparisons. That's a tiny bit unfortunate; it would be nicer if we
> could do array indexing based on the sequence number.

That was my initial thought as well, and so there was in fact a time
when RCU grace periods were numbered consecutively.  The problem with
that was that it was necessary to maintain a separate indication of
whether or not a grace period was in progress.  It is often necessary
to atomically determine both the grace-period number and whether that
grace period is still in progress, which required acquiring a lock,
which necessitated a number of contention-reduction workarounds which
eventually became problematic.

When led to the next phase, which reserved the bottom bit to indicate
whether a grace period was in progress and left the remaining bits to
count the grace periods.  This greatly simplified the code and likely
also improve performance and scalability.

Then I implemented Tree SRCU, which requires multiple grace-period phases,
hence the current state with the two bottom bits indicating grace=-period
phase and the remaining bits counting the grace periods.  Hence your
seeing get_state_synchronize_srcu() always returning a multiple of
four ("grace period N has not yet started").

> What if we added something like this?
> 
> #define RCU_SEQ_SKIP_SHIFT	2

Right now, get_state_synchronize_srcu() returns the grace-period sequence
number from the root of the tree.  This has been working fine thus far,
but it is quite possible that memory-contention issues will force me to
get the value from the leaves of this tree.  If that happens, the value
of NUM_ACTIVE_SRCU_POLL_OLDSTATE will change from 2 to 3.

In addition, vanilla RCU users are looking for reduced synchronize_rcu()
latency, which in the past resulted in the addition of expedited
grace periods, which have their own counter.  Similar pressure on SRCU
could result in overlapping computed grace periods, which would use
additional bits and make the cookies only partially ordered (as the RCU
rcu_gp_oldstate structure variant of cookie already is).

And those are just a couple of changes that I can foresee.  There might
be others.

So, annoying thought it might be, we really need for this to remain an
opaque cookie.

> > > I could use a doubly linked list for tracking all uncompleted objects,
> > > but I'm hoping use a darray per sequence number. Is it a max of two
> > > sequence numbers that had objects/callbacks/were requested pulling,
> > > or...?
> > 
> > Agreed, an array should work.  Each array element would need a field
> > recording its cookie.  Right, so you likely need a few more simple
> > functions:
> > 
> > 	same_state_synchronize_srcu(): Equality comparison of the
> > 		pair of cookies passed in.
> > 	get_completed_synchronize_srcu(): Return a special cookie
> > 		that, when passed to poll_state_synchronize_srcu(),
> > 		always results in a @true return value.
> > 
> > Or maybe not, you tell me.
> 
> I don't think so, but I'm not sure what your intended use is.

For same_state_synchronize_srcu(), places where you likely planned to
instead use C-language comparisons.  For get_completed_synchronize_srcu(),
as a way of marking an unused entry, for which it looks like you are
currently using ->rcu_armed.

> > > Also, I'm wondering if this code might be worth turning into something
> > > generic...
> > > 
> > > What I'm sketching out is:
> > > 
> > > struct btree_key_cache_freelist {
> > > 	spinlock_t		lock;
> > > 	bool			rcu_armed;
> > 
> > This says whether or not the callback corresponding to ->rcu is in
> > flight?
> 
> Correct.
> 
> > 
> > > 	unsigned long		seq;
> > 
> > You store the get_state_synchronize_srcu() return value in ->seq?
> 
> Yes
> 
> > 
> > > 	struct bkey_cached	*free[2]; /* singly linked list for now,
> > > 					   * perhaps darray/vector later
> > > 					   */
> > 
> > If ->free[] is the array, then you also need an array to hold the cookies.
> > Unless you are placing them in the objects themselves, which would
> > also work.
> > 
> > By "darray" you mean distributed array?
> 
> dynamic array, basically a c++ vector - fs/bcachefs/darray.h

So the darray is to hold the callbacks themselves as opposed to
the per-unexpired-cookie-value groups of callbacks?

> > > 	struct rcu_head		rcu; /* rearming callback to free objects */
> > > };
> > > 
> > > and these are percpu. Thoughts?
> > 
> > This definitely looks to be moving in a good direction, give or take
> > the accuracy of my guesses above.
> 
> I think I have something mostly working, with the caveat that my
> assumption about get_state_synchronize_srcu() and
> start_poll_synchronize_srcu() turned out to be wrong.
> 
> Think this would be worth factoring out and turning into something
> generic? If RCU wanted to use this internally for tracking pending
> callbacks, we could get rid of linked list overhead there...

For the kfree_rcu() path, we have a pages-of-pointers approach.  For the
call_rcu() path, the callbacks almost always access the memory, so it
is not clear that the linked-list overhead is an issue.  You get that
cold-cache miss either way.

But longer term, who knows?

More on the patch interspersed.

							Thanx, Paul

> commit 3bb5d34d6d6e2d5433cce5d248fd81211afedec0
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Mon Jun 10 20:47:03 2024 -0400
> 
>     bcachefs: pending_rcu_items
>     
>     Generic (?) data structure for explicitly tracking pending SRCU items
>     
>     - Can we make this generic across other RCU flavors?
>     
>     - Do we need to add a fallback to linked lists when darray allocation
>       fails?
>     
>     - We wish to avoid the overhead of start_poll_synchronize_srcu() if we
>       already have items for a given sequence number, but it appears
>       get_poll_synchronize_srcu(); start_poll_synchronize_srcu() can
>       actually return differert sequence numbers within the same read-side
>       critical section. Is this the correct way of doing this?
>     
>     - Do we need to ensure the rearming RCU callback is correctly flushed
>       when exiting? (Probably)
>     
>     Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
> index ebed60a43647..46f7fa549d59 100644
> --- a/fs/bcachefs/btree_key_cache.c
> +++ b/fs/bcachefs/btree_key_cache.c
> @@ -83,18 +83,109 @@ static bool bkey_cached_evict(struct btree_key_cache *c,
>  	return ret;
>  }
>  
> -static void __bkey_cached_free(struct rcu_head *rcu)
> +#define RCU_SEQ_SKIP_SHIFT	2
> +
> +static void pending_rcu_items_exit(struct pending_rcu_items *pending)
> +{
> +	darray_exit(&pending->objs[0]);
> +	darray_exit(&pending->objs[1]);
> +}
> +
> +static void pending_rcu_items_init(struct pending_rcu_items *pending,
> +				   struct srcu_struct *srcu,
> +				   pending_rcu_item_process_fn process)
> +{
> +	memset(pending, 0, sizeof(*pending));
> +	pending->srcu		= srcu;
> +	pending->process	= process;
> +	spin_lock_init(&pending->lock);
> +}
> +
> +static bool pending_rcu_has_items(struct pending_rcu_items *pending)
> +{
> +	return pending->objs[0].nr || pending->objs[1].nr;
> +}
> +
> +static void pending_rcu_items_process(struct pending_rcu_items *pending)
>  {
> -	struct bkey_cached *ck = container_of(rcu, struct bkey_cached, rcu);
> +	while (pending_rcu_has_items(pending) &&
> +	       poll_state_synchronize_srcu(pending->srcu, pending->seq)) {
> +		darray_for_each(pending->objs[0], i)
> +			pending->process(pending, *i);
> +		darray_exit(&pending->objs[0]);
> +		swap(pending->objs[0], pending->objs[1]);
> +		pending->seq += 1 << RCU_SEQ_SKIP_SHIFT;
> +	}
> +}
> +
> +static void pending_rcu_items_rcu_cb(struct rcu_head *rcu)
> +{
> +	struct pending_rcu_items *pending =
> +		container_of(rcu, struct pending_rcu_items, rcu);
> +
> +	unsigned long flags;
> +	spin_lock_irqsave(&pending->lock, flags);
> +	pending_rcu_items_process(pending);

SRCU callbacks execute in softirq context.  You therefore might need to
push this call to pending_rcu_items_process() to a workqueue handler,
at least if there are very many objects in need of processing.

>  
> -	kmem_cache_free(bch2_key_cache, ck);
> +	pending->rcu_armed = pending_rcu_has_items(pending);
> +	if (pending->rcu_armed)
> +		call_srcu(pending->srcu, &pending->rcu, pending_rcu_items_rcu_cb);
> +	spin_unlock_irqrestore(&pending->lock, flags);
> +}
> +
> +static void pending_rcu_item_enqueue(struct pending_rcu_items *pending, void *obj)
> +{
> +	darray_voidp preallocated = {};
> +retry:
> +	spin_lock_irq(&pending->lock);
> +	pending_rcu_items_process(pending);

Suppose that poll_state_synchronize_srcu() returns false so that
start_poll_synchronize_srcu() does nothing...

... then we get vCPU preemption here so that some number of SRCU grace
periods elapse (which looks to be limited to just one of them, but that
is enough because we might already have requested the next one courtesy of
the previous call to either call_srcu() or start_poll_synchronize_srcu()) ...

> +	unsigned long seq = start_poll_synchronize_srcu(pending->srcu);

... so that we get a seq that is 8 or 12 larger than pending->seq ...

> +	if (!pending_rcu_has_items(pending))
> +		pending->seq = seq;

... and we don't update pending->seq because there are still items there ...

> +	unsigned idx = (seq - pending->seq) >> RCU_SEQ_SKIP_SHIFT;
> +	BUG_ON(idx > ARRAY_SIZE(pending->objs));

... then can't this BUG_ON() trigger?

And why this ugly reliance on the cookie format?  Why not just have
the pending_rcu_items structure's ->seq be a two-element array?

Then all you need to do is to check each ->seq[] element to see if it
is equal to seq, while remembering the index of the first that is empty.
If you find a ->seq[] match, just enqueue into the corresponding ->objs[]
element.  Otherwise, you are guaranteed to have found an empty ->obj[],
at least if you move the start_poll_synchronize_srcu() to precede
the pending_rcu_items_process().

*Much* looser coupling with SRCU and rather simpler.

> +	darray_voidp *objs = pending->objs + idx;
> +
> +	if (!darray_room(*objs)) {
> +		if (preallocated.size > objs->size) {
> +			memcpy(preallocated.data,
> +			       objs->data,
> +			       sizeof(objs->data[0]) * objs->nr);
> +			swap(preallocated.data, objs->data);
> +			swap(preallocated.size, objs->size);
> +		} else if (darray_make_room_gfp(objs, 1, GFP_ATOMIC|__GFP_NOWARN)) {
> +			spin_unlock_irq(&pending->lock);
> +			darray_exit(&preallocated);
> +			darray_make_room_gfp(&preallocated, objs->nr + 1, GFP_KERNEL|__GFP_NOFAIL);
> +			goto retry;
> +		}
> +	}
> +
> +	BUG_ON(darray_push(objs, obj)); /* preallocated */
> +
> +	if (!pending->rcu_armed)
> +		call_srcu(pending->srcu, &pending->rcu, pending_rcu_items_rcu_cb);

The start_poll_synchronize_srcu() above might have started a new
SRCU grace period.  If so, this call_srcu() will start another one.
Which should not be a problem.  If it does prove to be, you might use
get_state_synchronize_srcu() instead, depending.

On the other hand, if this code is prone to bkey_cached_free() floods, the
current combination of start_poll_synchronize_srcu() and call_srcu()
might avoid OOM, given that this function checks for pending objects
whose grace period has ended.

> +	pending->rcu_armed = true;
> +	spin_unlock_irq(&pending->lock);
> +
> +	darray_exit(&preallocated);
> +}
> +
> +static void __bkey_cached_free(struct pending_rcu_items *pending, void *obj)
> +{
> +	struct bch_fs *c = container_of(pending->srcu, struct bch_fs, btree_trans_barrier);
> +
> +	this_cpu_dec(*c->btree_key_cache.nr_pending);
> +	kmem_cache_free(bch2_key_cache, obj);
>  }
>  
>  static void bkey_cached_free(struct btree_key_cache *bc,
>  			     struct bkey_cached *ck)
>  {
> -	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
> -
>  	kfree(ck->k);
>  	ck->k		= NULL;
>  	ck->u64s	= 0;
> @@ -102,7 +193,15 @@ static void bkey_cached_free(struct btree_key_cache *bc,
>  	six_unlock_write(&ck->c.lock);
>  	six_unlock_intent(&ck->c.lock);
>  
> -	call_srcu(&c->btree_trans_barrier, &ck->rcu, __bkey_cached_free);
> +	preempt_disable();
> +	struct pending_rcu_items *pending = this_cpu_ptr(bc->pending);
> +	preempt_enable();
> +	/*
> +	 * pending is protected by a lock, we don't need preemption disabled -
> +	 * and it expects to run in sleepable context:
> +	 */
> +	pending_rcu_item_enqueue(pending, ck);
> +	this_cpu_inc(*bc->nr_pending);
>  }
>  
>  static struct bkey_cached *
> @@ -778,6 +877,13 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
>  
>  	if (bc->table_init_done)
>  		rhashtable_destroy(&bc->table);
> +
> +	free_percpu(bc->nr_pending);
> +
> +	int cpu;
> +	for_each_possible_cpu(cpu)
> +		pending_rcu_items_exit(per_cpu_ptr(bc->pending, cpu));
> +	free_percpu(bc->pending);
>  }
>  
>  void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
> @@ -789,6 +895,20 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
>  	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
>  	struct shrinker *shrink;
>  
> +#ifdef __KERNEL__
> +	bc->pending = alloc_percpu(struct pending_rcu_items);
> +	if (!bc->pending)
> +		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> +#endif
> +	int cpu;
> +	for_each_possible_cpu(cpu)
> +		pending_rcu_items_init(per_cpu_ptr(bc->pending, cpu),
> +				       &c->btree_trans_barrier, __bkey_cached_free);
> +
> +	bc->nr_pending = alloc_percpu(size_t);
> +	if (!bc->nr_pending)
> +		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> +
>  	if (rhashtable_init(&bc->table, &bch2_btree_key_cache_params))
>  		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
>  
> @@ -815,13 +935,15 @@ void bch2_btree_key_cache_to_text(struct printbuf *out, struct btree_key_cache *
>  	prt_printf(out, "keys:\t%lu\r\n",		atomic_long_read(&bc->nr_keys));
>  	prt_printf(out, "dirty:\t%lu\r\n",		atomic_long_read(&bc->nr_dirty));
>  	prt_printf(out, "table size:\t%u\r\n",		bc->table.tbl->size);
> -
> -	prt_printf(out, "\nshrinker:\n");
> +	prt_newline(out);
> +	prt_printf(out, "shrinker:\n");
>  	prt_printf(out, "requested_to_free:\t%lu\r\n",	bc->requested_to_free);
>  	prt_printf(out, "freed:\t%lu\r\n",		bc->freed);
>  	prt_printf(out, "skipped_dirty:\t%lu\r\n",	bc->skipped_dirty);
>  	prt_printf(out, "skipped_accessed:\t%lu\r\n",	bc->skipped_accessed);
>  	prt_printf(out, "skipped_lock_fail:\t%lu\r\n",	bc->skipped_lock_fail);
> +	prt_newline(out);
> +	prt_printf(out, "pending:\t%lu\r\n",		per_cpu_sum(bc->nr_pending));
>  }
>  
>  void bch2_btree_key_cache_exit(void)
> diff --git a/fs/bcachefs/btree_key_cache_types.h b/fs/bcachefs/btree_key_cache_types.h
> index e026c65f54e1..8d11cbac4c37 100644
> --- a/fs/bcachefs/btree_key_cache_types.h
> +++ b/fs/bcachefs/btree_key_cache_types.h
> @@ -2,12 +2,29 @@
>  #ifndef _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
>  #define _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
>  
> +#include "darray.h"
> +
> +struct pending_rcu_items;
> +typedef void (*pending_rcu_item_process_fn)(struct pending_rcu_items *, void *);
> +
> +struct pending_rcu_items {
> +	struct srcu_struct		*srcu;
> +	pending_rcu_item_process_fn	process;
> +	spinlock_t			lock;
> +	bool				rcu_armed;
> +	unsigned long			seq;
> +	darray_voidp			objs[2];
> +	struct rcu_head			rcu;
> +};
> +
>  struct btree_key_cache {
>  	struct rhashtable	table;
>  	bool			table_init_done;
>  
>  	struct shrinker		*shrink;
>  	unsigned		shrink_iter;
> +	struct pending_rcu_items __percpu *pending;
> +	size_t __percpu		*nr_pending;
>  
>  	atomic_long_t		nr_keys;
>  	atomic_long_t		nr_dirty;
> diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
> index 67f3efd9a007..56046f09ac65 100644
> --- a/fs/bcachefs/btree_types.h
> +++ b/fs/bcachefs/btree_types.h
> @@ -396,8 +396,6 @@ struct bkey_cached {
>  	u64			seq;
>  
>  	struct bkey_i		*k;
> -
> -	struct rcu_head		rcu;
>  };
>  
>  static inline struct bpos btree_node_pos(struct btree_bkey_cached_common *b)
> diff --git a/fs/bcachefs/darray.h b/fs/bcachefs/darray.h
> index 4b340d13caac..cdace10f4572 100644
> --- a/fs/bcachefs/darray.h
> +++ b/fs/bcachefs/darray.h
> @@ -19,6 +19,7 @@ struct {								\
>  
>  #define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
>  
> +typedef DARRAY(void *)	darray_voidp;
>  typedef DARRAY(char)	darray_char;
>  typedef DARRAY(char *) darray_str;
>  
