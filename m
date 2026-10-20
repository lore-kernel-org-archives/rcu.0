Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530730;
	b=ZXytQxC8DaQtKMUpI15dFHiAxSypJJQblwGAoS1GNwkT4O3gCHM3Yi+8UbDSvTF2JFRf
	 Djn9UwKEJzz8DuNx6NR2mjAE+rwv8G8EOGGjTxv22hMouboeVizet4nKrFHvj9I5B3mIo
	 JDmL8dZ1Bxtcmsj81rrlHWh2hxftzCqn1FJCcH/ep37Zl7v2M1DPBR0M+8e0QVp0zPCXF
	 +ANqFK6e36PCaSDVvOXIz1OsonPGY2j5g7Z1BiGkFf3OoK6HOUoXosPCaWMmllOO9Maq2
	 aAbFAHXN6G1qV05JoNBx77p1orUiEiWm9TFtYBLJvnpXYFmDYFOcMB1apFmeQdItyVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530730;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=u4LsqDObZa/KNAA8Cvg/L2TdIZSNo8LvgC36WXiIIic=;
	b=vZs7GtTKZ23osbyeAA9Dl7sN4VI8sPNmRiZYE/weeh9R1MIHTRCknhabKHF1f5ajs9ha
	 zEwDWRkNmJdZyrKHdrPmWN+T1XBiyV7ixGmJuty/6rBy+GQNE3EyqK9APCCIWHpmrSzFI
	 57Hi3+u4BNoTMSWbRi4qxXijQc+kL0neDQDmpmEKi/FSmI+hMdKF6j4c++4NQwUOlKGsQ
	 nC2fm8+wlA1pBTIIv8wAq7iWYkyLi+kdHUhtbuvlMQSlQLACy+QQ3UU/CLvIuap4fyQ2T
	 HH/hpkb4pqSvpmMSlsnpoJHyijVU41l2B5dXAtY55Qdil7hjzCUKxo0c/jJIkRCc2rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAEohcNS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A8606A319;
	Tue, 20 Oct 2026 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAEohcNS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A0B1F000C9;
	Tue, 20 Oct 2026 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530729;
	bh=u4LsqDObZa/KNAA8Cvg/L2TdIZSNo8LvgC36WXiIIic=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=GAEohcNS8LDKbZEVHBRM4vf4UJBz6IYfOu6/IlHXDhhujrhQJWdP/QklhN9gbVOA8
	 oSBZseNQ0hgwsxD38yDhe3dAuGvHC3VbFndmDrBfz8dkGRNZvoUj4+YxA6wk3Pcrt5
	 TxuMwVHR2Ffo854QaLpkxPw+qlhnHlsJ4Fdd6c6i4MSG3eOEFzfS8f86/iPdhVl/Dm
	 Z+qrTIAbxryAKcJjRB675SX9k2OAQwN8WD7ylGQvMbTtOOPxE91HPmuIJjYgRLk9nP
	 b4wsQeufk6X2oXxRnElcI/QhTXRiOO34xox4zz+qESAEIoZLqc7g08qm34Zs4/OVRV
	 0aiy2IElLUHkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0ECE1CE09E8; Tue, 20 Oct 2026 14:12:09 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:12:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>, Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptr: Record per-CPU slot owner after
 claiming the slot
Message-ID: <fa16d2b1-594e-494b-8cfc-9b8c13f2c223@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261019161852.12783-1-parri.andrea@gmail.com>
 <4defa4de-ab42-4809-9645-100cad68972b@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4defa4de-ab42-4809-9645-100cad68972b@efficios.com>

On Tue, Oct 20, 2026 at 03:11:13PM -0400, Mathieu Desnoyers wrote:
> On 2026-10-19 12:18, Andrea Parri wrote:
> > An interrupt that uses a hazard pointer while the interrupted task is
> > in the acquire slow path can leave its own context recorded as the
> > owner of the per-CPU slot the task then publishes into.  The next
> > context switch promotes the task's pointer with the interrupt's
> > context.
> > 
> > hazptr_get_free_percpu_slot() records the owner when it picks an empty
> > slot, but only Store B in __hazptr_try_acquire() claims the slot.  An
> > interrupt in between picks the same slot, as the lowest free one:
> > 
> >    Task on CPU 0                        IRQ on CPU 0
> >    -------------                        ------------
> >    hazptr_acquire(ctx)
> >      fast path fails
> >      __hazptr_acquire(ctx)
> >        picks item k (empty)
> >        item k->ctx.ctx = ctx
> >                                         hazptr_acquire(irq_ctx)
> >                                           claims item k
> >                                           item k->ctx.ctx = irq_ctx
> >                                         hazptr_release(irq_ctx)
> >                                           clears slot k
> >        __hazptr_try_acquire()
> >          Store B into slot k
> >        (item k still names irq_ctx)
> >    sleeps holding the pointer
> >    hazptr_note_context_switch()
> >      promotes item k with irq_ctx
> 
> You are correct. Writing directly to item->ctx.ctx before having
> reserved the slot address (store B) fails to prevent the nested
> irq handler from using that slot as well and causing confusion between
> the two contexts.
> 
> Thanks for catching this !
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thank you all!  Queued for testing and further review.

Andrea, on your KUNIT reproducer, is there any chance that this code
can be folded into the existing hazptrtorture.c work so that it just
gets tested automatically?

							Thanx, Paul

> > The task gets there with k > 0 when it already holds an outer hazard
> > pointer in slot 0; no other task can, as its slot is promoted when it
> > is switched out.
> > 
> > The task gets there with k == 0 when the fast path leaves slot 0
> > empty: either its ptr_eq() check fails because an updater changed the
> > pointer, or the pointer is NULL and an updater publishes a non-NULL one
> > before the slow path loads it.
> > 
> > The promotion moves the task's pointer into irq_ctx's backup slot,
> > which nothing unchains, so hazptr_synchronize() on that pointer never
> > returns.  The task's ctx->slot still names slot k, so its
> > hazptr_release() clears whatever another reader on that CPU has since
> > published there.
> > 
> > If the interrupt detaches instead, as hazptr_torture_acquire() does,
> > the promotion chains irq_ctx's backup slot a second time while it is
> > still linked.  The overflow list then loops on that node, or follows
> > LIST_POISON1 once hazptr_unchain_backup_slot() removes it.
> > 
> > Record the owner after __hazptr_try_acquire() succeeds, as the fast
> > path in hazptr_acquire() does.  This should be safe because an
> > interrupt that used the slot has released or detached it by the time
> > the task resumes, and only hazptr_note_context_switch() reads the
> > owner, which cannot run before the task enables preemption.
> > 
> > Fixes: 50b568234163 ("hazptr: Implement Hazard Pointers")
> > Assisted-by: LLM
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > ---
> > 
> > Notes:
> >      With this patch, hazptrtorture's NOPREEMPT scenario passes a 30-minute
> >      run on x86_64 with 8 CPUs.  PREEMPT runs clean for 30 minutes but can
> >      hang at shutdown, in hazptrtorture's release of deferred hazard
> >      pointers; that hang does not involve this patch, and is addressed by
> >      "hazptrtorture: Release all deferred hazard pointers before stopping",
> >      posted separately.
> >      With that fix also applied, 30-minute runs pass for PREEMPT, for
> >      NOPREEMPT with torture_type=hazptr, for PREEMPT with
> >      torture_type=hazptr-stack, and for PREEMPT with CONFIG_HAZPTR_DEBUG=n.
> >      PREEMPT and NOPREEMPT also pass without this patch: their readers hold
> >      one hazard pointer each, so they reach the slow path only when the
> >      ptr_eq() check fails or the pointer is NULL, which happens only before
> >      the writer publishes its first element and after it stops.
> >      A KUnit reproducer, with a test-only hook in __hazptr_try_acquire()
> >      between the free-slot check and Store B, fails on 940793b926aa and
> >      passes with this patch.  I can post it if useful.
> > 
> >   kernel/hazptr.c | 21 +++++++++++++--------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> > index 3ca73b56a5c25..b15b84ebd4ceb 100644
> > --- a/kernel/hazptr.c
> > +++ b/kernel/hazptr.c
> > @@ -54,19 +54,16 @@ unsigned int flip_list_phase(unsigned int phase)
> >   }
> >   static
> > -struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
> > +struct hazptr_slot_item *hazptr_get_free_percpu_slot_item(void)
> >   {
> >   	struct hazptr_percpu_slots *percpu_slots = this_cpu_ptr(&hazptr_percpu_slots);
> >   	unsigned int idx;
> >   	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> >   		struct hazptr_slot_item *item = &percpu_slots->items[idx];
> > -		struct hazptr_slot *slot = &item->slot;
> > -		if (!slot->addr) {
> > -			item->ctx.ctx = ctx;
> > -			return slot;
> > -		}
> > +		if (!item->slot.addr)
> > +			return item;
> >   	}
> >   	/* All slots are in use. */
> >   	return NULL;
> > @@ -78,6 +75,7 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
> >    */
> >   void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> >   {
> > +	struct hazptr_slot_item *item;
> >   	struct hazptr_slot *slot;
> >   	void *addr;
> > @@ -85,10 +83,17 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> >   	 * In case we are called due to nested use of hazard pointers,
> >   	 * try a slot protection with per-CPU slots.
> >   	 */
> > -	slot = hazptr_get_free_percpu_slot(ctx);
> > -	if (likely(slot)) {
> > +	item = hazptr_get_free_percpu_slot_item();
> > +	if (likely(item)) {
> > +		slot = &item->slot;
> >   		addr = __hazptr_try_acquire(ctx, addr_p, slot);
> >   		if (addr) {
> > +			/*
> > +			 * Record the owner only once Store B has claimed the
> > +			 * slot, as hazptr_acquire() does: an interrupt may
> > +			 * have used this slot since it was chosen.
> > +			 */
> > +			item->ctx.ctx = ctx;
> >   			ctx->slot = slot;
> >   			return addr;
> >   		}
> > 
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
