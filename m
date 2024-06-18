Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EF17E9
	for <rcu@vger.kernel.org>; Tue, 18 Jun 2024 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669731; cv=none; b=prLJPPjVgFs7fCcXosht8v1sEWM4gWScDyWBmZHav5ahZ5jthtt6uYV9sUMqeO7YM2z4IORgl83Gjeo9kO4kfgyIdqbBcbZzGyY8AUNM38mG5+C12HLKx2ry7xZx72JIVbgn9jmdeEHfKOBaIrbzA0MA8jbf0EfeVR+CpvYX/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669731; c=relaxed/simple;
	bh=OdmejHSpz1iG0KjWxD2AoVFJP8Ug2Koce1L+unzyHdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrqA/YxIpHrWDEPerzwxnkZB74JBqS+Ks9Qu2Qt1iQ3+Q0oHYnxXdhBYn2u9ErVWFSV0Ac+bDbhnGQnS/jhf/gTMzHn2/hHov6heCROOvz4Xb/9jN0Av4ZlXV6bqBKsT6Fs/+NOqiSM2hVnLAcQHOh/ARGTlN0PaEFUwhkPN2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPd3Vufj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPd3Vufj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F03EC2BD10;
	Tue, 18 Jun 2024 00:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718669730;
	bh=OdmejHSpz1iG0KjWxD2AoVFJP8Ug2Koce1L+unzyHdA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XPd3VufjTsZ8ojuuZEwvrc6zluttRCKQ2Od+mPWkhc1jMSW2a7Vt/UQ767R13Cy9v
	 6tEIgQpvkHO1K1MAygTQHDA23l4QI2tIfTjayp6/3RSJvwt/AuJsosNOwLesDKBk2V
	 +32UcBj9wy5RzAFoJYT6vVvsxBiw4GbC+17vFcvqyHpNXd2vSZ0m/xryIdxBWIL9wg
	 vB2vcwG1+tPNcoS0uq6FkwHiQ0Knu2h4VispHLws7eNBHhQfLOrr7gM304oOZXU4dl
	 q/6pCtDzHdlTfiePFxebgegBJpn+dWfJLje0sd4QJ3iNU4iWt2ZIRrgBGYgBH2Z7qG
	 VmHjIBMHCZLmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B1EBBCE09DE; Mon, 17 Jun 2024 17:15:29 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:15:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: [PATCH] bcachefs: pending_rcu_items
Message-ID: <b2d51ae1-a871-426f-8d99-892558c9c8d1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
 <xharqajk2o7xkpdk7mpd3jzj2suztubbqfms5xva367pcli5ny@6gjjjdbjo7om>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xharqajk2o7xkpdk7mpd3jzj2suztubbqfms5xva367pcli5ny@6gjjjdbjo7om>

On Fri, Jun 14, 2024 at 04:28:14PM -0400, Kent Overstreet wrote:
> This should incorporate everything we've covered so far; the one thing I
> still have to look at is making it work as a kvfree_rcu() backend.
> 
> I decided not to do the "store the callback in the radix tree"
> optimization for generic use - it made the code fairly ugly, and just
> replacing the linked list with a radix tree should already be a
> significant improvement.
> 
> Thoughts?

Please see below for few questions and comments.

I do have some catching up to do, as I am having some difficulty imagining
the benefit of a radix tree in this situation.  But might as well dig in!

> -- >8 --
> 
> Generic data structure for explicitly tracking pending RCU items,
> allowing items to be dequeued (i.e. allocate from items pending
> freeing).
> 
> - Works with conventional RCU and SRCU; pass in NULL for the srcu_struct
>   for regular RCU

If it ever becomes helpful to make this work for any of the RCU Tasks
flavors, the rcutorture_type enum from kernel/rcu/rcu.h might be of help.
Until then, NULL works just fine.

> - Tracks pending items in a radix tree; falls back to linked list if
>   radix tree allocation fails

I am still having trouble seeing what a radix tree brings to the table
in this case, but again, migtht as well dig in.

> todo: add support for being a kvfree_rcu() backend
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
> index 0ab533a2b03b..c8394ec6f22f 100644
> --- a/fs/bcachefs/Makefile
> +++ b/fs/bcachefs/Makefile
> @@ -68,6 +68,7 @@ bcachefs-y		:=	\
>  	opts.o			\
>  	printbuf.o		\
>  	quota.o			\
> +	rcu_pending.o		\
>  	rebalance.o		\
>  	recovery.o		\
>  	recovery_passes.o	\
> diff --git a/fs/bcachefs/rcu_pending.c b/fs/bcachefs/rcu_pending.c
> new file mode 100644
> index 000000000000..9b2f4da94425
> --- /dev/null
> +++ b/fs/bcachefs/rcu_pending.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/generic-radix-tree.h>
> +#include <linux/percpu.h>
> +#include <linux/srcu.h>
> +#include "rcu_pending.h"
> +
> +static inline unsigned long __get_state_synchronize_rcu(struct srcu_struct *ssp)
> +{
> +	return ssp
> +		? get_state_synchronize_srcu(ssp)
> +		: get_state_synchronize_rcu();
> +}
> +
> +static inline unsigned long __start_poll_synchronize_rcu(struct srcu_struct *ssp)
> +{
> +	return ssp
> +		? start_poll_synchronize_srcu(ssp)
> +		: start_poll_synchronize_rcu();
> +}

I don't get why you 

> +static inline void __rcu_barrier(struct srcu_struct *ssp)
> +{
> +	return ssp
> +		? srcu_barrier(ssp)
> +		: rcu_barrier();
> +}

You will likely need something like these:

static inline void __get_completed_synchronize_rcu(struct srcu_struct *ssp)
{
	return ssp
		? get_completed_synchronize_srcu(ssp)
		: get_completed_synchronize_rcu();
}

static inline void __same_state_synchronize_rcu(struct srcu_struct *ssp)
{
	return ssp
		? same_state_synchronize_srcu(ssp)
		: same_state_synchronize_rcu();
}

The point of these is to get around the earlier issue where three cookies
appeared to be valid due to time delays.  But perhaps you found some
other way around that.

Anyway, the RCU versions have been around for quite some time, but the
SRCU versions were added to -rcu quite recently:

5f51520ec4fc ("srcu: Fill out polled grace-period APIs")

> +struct pending_rcu_items_seq {
> +	GENRADIX(struct rcu_head *)	objs;
> +	size_t				nr;
> +	struct rcu_head			*list;

A pointer to an rcu_head structure?  Interesting...

OK, I see it.  This is the overflow list in case memory cannot be
allocated.

> +	unsigned long			seq;

OK, this does appear like each group of objs gets its own return value from
either __start_poll_synchronize_rcu() or __get_state_synchronize_rcu().  If
so, much improved!

> +};
> +
> +struct pending_rcu_items_pcpu {
> +	struct pending_rcu_items	*parent;
> +	spinlock_t			lock;
> +	bool				rcu_armed;
> +	struct pending_rcu_items_seq	objs[2];

This can be:
	struct pending_rcu_items_seq	objs[NUM_ACTIVE_SRCU_POLL_OLDSTATE];

This is also recent in -rcu:

36dcb89814f7 ("srcu: Add NUM_ACTIVE_SRCU_POLL_OLDSTATE")

> +	struct rcu_head			rcu;

The purpose of this rcu_head is as before, to flag good times to invoke
poll_state_synchronize_rcu()?

> +	struct work_struct		work;
> +};
> +
> +static bool get_finished_items(struct pending_rcu_items *pending,
> +			       struct pending_rcu_items_pcpu *p,
> +			       struct pending_rcu_items_seq *out)
> +{
> +	for (struct pending_rcu_items_seq *objs = p->objs;
> +	     objs < p->objs + ARRAY_SIZE(p->objs); objs++)
> +		if ((objs->nr || objs->list) &&
> +		    poll_state_synchronize_srcu(pending->srcu, objs->seq)) {
> +			*out = (struct pending_rcu_items_seq) {
> +				/*
> +				 * the genradix can only be modified with atomic instructions,
> +				 * since we allocate new nodes without
> +				 * pending_rcu_items_pcpu.lock
> +				 */
> +				.objs.tree.root	= xchg(&objs->objs.tree.root, NULL),

OK, so this captures the objects that are now ready to invoke.  Very good.

I need to check what the caller does with it, of course.  And one caller
appears to invokes it from a workqueue handler, the other from unknown
context.  But you said earlier that all were from process context,
so that should be fine.  Having the submitters do processing does have
nice overload-handling characteristics, though it might be more prone
to deadlock.  (As in you cannot acquire a mutex in the callback that is
held across a call to the bch2_pending_rcu_item_enqueue() function.)

Both callers re-enable interrupts before doing the processing, which
is another good improvement.

> +				.nr		= objs->nr,
> +				.list		= objs->list,

And here you capture the overflow list.

What provides synchronization for this function?  It looks like it can
be invoked from multiple contexts.  Ah, the pending_rcu_items_pcpu
structure's ->lock, which is dropped after invoking this but before
processing the objects.

> +			};
> +			objs->nr	= 0;
> +			objs->list	= NULL;
> +			return true;
> +		}

If both elements are ready to process, it looks like you only process
the first one that you come to.  Why not look at both and return both
if both are ready?

A linked list of pages of pointers would make this possible by simply
concatenating the lists, right?

Or am I missing something that forces the second element of the array
to be checked?

> +	return false;
> +}
> +
> +static void process_finished_items(struct pending_rcu_items *pending,
> +				   struct pending_rcu_items_seq *objs)
> +{
> +	for (size_t i = 0; i < objs->nr; i++)
> +		pending->process(pending, *genradix_ptr(&objs->objs, i));

I might be missing something, but it looks like a linked list of pages of
pointers would do better here, especially if there are a lot of callbacks.
So what am I missing?

Also, I am not seeing a ->pending() field in the pending_rcu_items_seq
structure.  Again, what am I missing?

> +	genradix_free(&objs->objs);
> +
> +	while (objs->list) {
> +		struct rcu_head *obj = objs->list;
> +		objs->list = obj->next;
> +		pending->process(pending, obj);

And here we process the overflow list.

> +	}
> +}
> +
> +static void pending_rcu_items_rcu_cb(struct rcu_head *rcu)
> +{
> +	struct pending_rcu_items_pcpu *p =
> +		container_of(rcu, struct pending_rcu_items_pcpu, rcu);
> +
> +	schedule_work(&p->work);

OK, we fire off the workqueue after the RCU callback is invoked, which
should be a good time to invoke poll_state_synchronize_srcu().

You could git rid of this function by using queue_rcu_work() instead
of call_rcu().  Except that you would instead need queue_srcu_work().
Never mind!

> +}
> +
> +static bool __pending_rcu_items_has_pending(struct pending_rcu_items_pcpu *p)
> +{
> +	for (struct pending_rcu_items_seq *objs = p->objs;
> +	     objs < p->objs + ARRAY_SIZE(p->objs); objs++)
> +		if (objs->nr || objs->list)
> +			return true;
> +	return false;

And this is always invoked with the ->lock held, so good synchronization.

> +}
> +
> +static void pending_rcu_items_work(struct work_struct *work)
> +{
> +	struct pending_rcu_items_pcpu *p =
> +		container_of(work, struct pending_rcu_items_pcpu, work);
> +	struct pending_rcu_items *pending = p->parent;
> +again:
> +	spin_lock_irq(&p->lock);
> +	struct pending_rcu_items_seq finished;
> +	while (get_finished_items(pending, p, &finished)) {
> +		spin_unlock_irq(&p->lock);

OK, processing this with interrupts enabled is a great improvement!

Also doing it in workqueue context is a good thing.  I don't yet have
an opinion about how this code handles overload conditions.

> +		process_finished_items(pending, &finished);
> +		goto again;
> +	}
> +
> +	BUG_ON(!p->rcu_armed);
> +	p->rcu_armed = __pending_rcu_items_has_pending(p);
> +	if (p->rcu_armed)
> +		call_srcu(pending->srcu, &p->rcu, pending_rcu_items_rcu_cb);
> +	spin_unlock_irq(&p->lock);
> +}
> +
> +void bch2_pending_rcu_item_enqueue(struct pending_rcu_items *pending, struct rcu_head *obj)

As noted earlier, I am assuming that this is invoked from task context
with preemption enabled.

It might be worth a comment stating that the ->process() function cannot
acquire any mutex held across a call to bch2_pending_rcu_item_enqueue().

> +{
> +	struct pending_rcu_items_pcpu *p = raw_cpu_ptr(pending->p);
> +	bool alloc_failed = false;
> +	unsigned long flags;
> +retry:
> +	spin_lock_irqsave(&p->lock, flags);
> +
> +	struct pending_rcu_items_seq finished;
> +	while (get_finished_items(pending, p, &finished)) {
> +		spin_unlock_irqrestore(&p->lock, flags);
> +		process_finished_items(pending, &finished);
> +		goto retry;

This loop could be avoided by passing obj in to get_finished_items(),
and having that function enqueue obj just after emptying things.  Yes,
an infinite loop requires an improbably repeated sequence of preemptions
and migrations, but why not eliminate the possibility?

You might well like the division of processing, but it is not free here.

> +	}
> +
> +	struct pending_rcu_items_seq *objs;
> +
> +	unsigned long seq = __get_state_synchronize_rcu(pending->srcu);

Invoking __get_state_synchronize_rcu() before the call to get_finished_items()
could save you some latency.

> +	for (objs = p->objs; objs < p->objs + ARRAY_SIZE(p->objs); objs++)
> +		if (objs->nr && objs->seq == seq)

OK, the purpose of same_state_synchronize_srcu() is to make that
equality comparison work no matter what debugging information we might
need to put in the cookie returned from get_state_synchronize_srcu().
Or, for that matter, poll_state_synchronize_srcu().

So please use same_state_synchronize_srcu(objs->seq,seq) here.

> +			goto add;

And you can do this part before calling get_finished_items().

> +	seq = __start_poll_synchronize_rcu(pending->srcu);
> +	for (objs = p->objs; objs < p->objs + ARRAY_SIZE(p->objs); objs++)
> +		if (!objs->nr) {

And this is why you don't need get_completed_synchronize_srcu().  The fact
that you can easily check for there being no objects means that you can
easily know when it is OK to reuse this element.

The get_completed_synchronize_srcu() might be useful in caching
situations, where it would mark an object that might need to be rexposed
to readers for reuse, but that can otherwise be immediately freed.
Not the situation here, so you don't need it.

> +			objs->seq = seq;
> +			goto add;
> +		}
> +
> +	BUG();

Can this BUG() trigger?  If we get here, we have had interrupts disabled
across the call to get_finished_items(), and we can only have two
unexpired cookies.

But we still have the time-based issue where get_finished_items()
sees both as being unexpired, one of them expires, we call
__start_poll_synchronize_rcu(), and get a third sequence number.
Then this BUG() triggers.

I wasn't kidding.  That call to __start_poll_synchronize_rcu() absolutely
must precede that call to get_finished_items().  ;-)

> +	struct rcu_head **entry;
> +add:
> +	entry = genradix_ptr_alloc(&objs->objs, objs->nr, GFP_ATOMIC|__GFP_NOWARN);
> +	if (likely(entry)) {
> +		*entry = obj;
> +		objs->nr++;
> +	} else if (likely(!alloc_failed)) {
> +		spin_unlock_irqrestore(&p->lock, flags);
> +		alloc_failed = !genradix_ptr_alloc(&objs->objs, objs->nr, GFP_KERNEL);

Just so you know, the corresponding part of kfree_rcu() was the subject
of much churn as the mm system evolved.  But you can only go through this
retry loop twice, so I am OK, with it.

But you really want to keep this structure, you also really want to call
__start_poll_synchronize_rcu() before the retry: label.

If nothing else, you can check the cookie on allocation failure, and if it
has expired, just immediately free the object.

> +		goto retry;
> +	} else {
> +		obj->next = objs->list;
> +		objs->list = obj;

OK, and here is the OOM fallback processing.

> +	}
> +
> +	if (!p->rcu_armed) {
> +		call_srcu(pending->srcu, &p->rcu, pending_rcu_items_rcu_cb);
> +		p->rcu_armed = true;

In the other order, please!

Yes, you have interrupts disabled here, but you are not in an SRCU
read-side critical section, and a hypervisor isn't necessarily going to
know or care about your interrupt-disabled state.  So the way that the
code is written, you really can have the SRCU callback invoked before
setting ->rcu_armed to true, which might not be a good thing.

Especially given that it won't happen very often.  Except on large
fleets.  ;-)

> +	}
> +	spin_unlock_irqrestore(&p->lock, flags);
> +}
> +
> +static struct rcu_head *pending_rcu_item_pcpu_dequeue(struct pending_rcu_items_pcpu *p)
> +{
> +	struct rcu_head *ret = NULL;
> +
> +	spin_lock_irq(&p->lock);
> +	unsigned idx = p->objs[1].seq > p->objs[0].seq;
> +
> +	for (unsigned i = 0; i < 2; i++, idx ^= 1) {
> +		struct pending_rcu_items_seq *objs = p->objs + idx;
> +
> +		if (objs->nr) {
> +			ret = *genradix_ptr(&objs->objs, --objs->nr);
> +			break;
> +		}
> +
> +		if (objs->list) {
> +			ret = objs->list;
> +			objs->list = ret->next;
> +			break;
> +		}
> +	}
> +	spin_unlock_irq(&p->lock);
> +
> +	return ret;
> +}
> +
> +struct rcu_head *bch2_pending_rcu_item_dequeue(struct pending_rcu_items *pending)
> +{
> +	return pending_rcu_item_pcpu_dequeue(raw_cpu_ptr(pending->p));
> +}
> +
> +struct rcu_head *bch2_pending_rcu_item_dequeue_from_all(struct pending_rcu_items *pending)
> +{
> +	struct rcu_head *ret = NULL;
> +	int cpu;
> +	for_each_possible_cpu(cpu) {
> +		ret = pending_rcu_item_pcpu_dequeue(per_cpu_ptr(pending->p, cpu));
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}

I assume that the point of these guys is to recycle objects that are
waiting for their RCU grace period, similar to SLAB_TYPESAFE_BY_RCU.
Readers would of course need the same sort of checks as used by readers
traversing memory from SLAB_TYPESAFE_BY_RCU slabs.

If my assumption is correct, handing out the oldest items minimizes the
amount of retrying these readers need to do.

> +static bool pending_rcu_items_has_pending(struct pending_rcu_items *pending)
> +{
> +	int cpu;
> +	for_each_possible_cpu(cpu) {
> +		struct pending_rcu_items_pcpu *p = per_cpu_ptr(pending->p, cpu);
> +		spin_lock_irq(&p->lock);
> +		if (__pending_rcu_items_has_pending(p)) {
> +			spin_unlock_irq(&p->lock);
> +			return true;
> +		}
> +		spin_unlock_irq(&p->lock);
> +	}
> +
> +	return false;
> +}
> +
> +void bch2_pending_rcu_items_exit(struct pending_rcu_items *pending)
> +{
> +	if (!pending->p)
> +		return;
> +
> +	while (pending_rcu_items_has_pending(pending))
> +		__rcu_barrier(pending->srcu);

OK, as long as bch2_pending_rcu_item_enqueue() cannot be invoked anymore,
this loop will only do a few iterations.

The rest looks fine.  (Famous last words...)

> +	int cpu;
> +	for_each_possible_cpu(cpu) {
> +		struct pending_rcu_items_pcpu *p = per_cpu_ptr(pending->p, cpu);
> +
> +		flush_work(&p->work);
> +
> +		WARN_ON(p->objs[0].nr);
> +		WARN_ON(p->objs[1].nr);
> +		WARN_ON(p->objs[0].list);
> +		WARN_ON(p->objs[1].list);
> +
> +		genradix_free(&p->objs[0].objs);
> +		genradix_free(&p->objs[1].objs);
> +	}
> +	free_percpu(pending->p);
> +}
> +
> +int bch2_pending_rcu_items_init(struct pending_rcu_items *pending,
> +				struct srcu_struct *srcu,
> +				pending_rcu_item_process_fn process)
> +{
> +	pending->p = alloc_percpu(struct pending_rcu_items_pcpu);
> +	if (!pending->p)
> +		return -ENOMEM;
> +
> +	int cpu;
> +	for_each_possible_cpu(cpu) {
> +		struct pending_rcu_items_pcpu *p = per_cpu_ptr(pending->p, cpu);
> +		p->parent	= pending;
> +		spin_lock_init(&p->lock);
> +		INIT_WORK(&p->work, pending_rcu_items_work);
> +	}
> +
> +	pending->srcu = srcu;
> +	pending->process = process;
> +
> +	return 0;
> +}
> diff --git a/fs/bcachefs/rcu_pending.h b/fs/bcachefs/rcu_pending.h
> new file mode 100644
> index 000000000000..e45ede074443
> --- /dev/null
> +++ b/fs/bcachefs/rcu_pending.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _BCACHEFS_RCU_PENDING_H
> +#define _BCACHEFS_RCU_PENDING_H
> +
> +struct pending_rcu_items;
> +typedef void (*pending_rcu_item_process_fn)(struct pending_rcu_items *, struct rcu_head *);
> +
> +struct pending_rcu_items_pcpu;
> +
> +struct pending_rcu_items {
> +	struct pending_rcu_items_pcpu __percpu *p;
> +	struct srcu_struct		*srcu;
> +	pending_rcu_item_process_fn	process;
> +};
> +
> +void bch2_pending_rcu_item_enqueue(struct pending_rcu_items *pending, struct rcu_head *obj);
> +struct rcu_head *bch2_pending_rcu_item_dequeue(struct pending_rcu_items *pending);
> +struct rcu_head *bch2_pending_rcu_item_dequeue_from_all(struct pending_rcu_items *pending);
> +
> +void bch2_pending_rcu_items_exit(struct pending_rcu_items *pending);
> +int bch2_pending_rcu_items_init(struct pending_rcu_items *pending,
> +				struct srcu_struct *srcu,
> +				pending_rcu_item_process_fn process);
> +
> +#endif /* _BCACHEFS_RCU_PENDING_H */
