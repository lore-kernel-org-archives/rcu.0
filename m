Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426917;
	b=lsTdmLFvrF2Cmm4e/INr3AgxLPJeTYjWAAvbf60h+/GtqK9l/yMJSz6T+7nU8RUbp9R0
	 7Oovo/U84zajg1gasQ8Rzyz0QzlpZpCSYQhCqs/tgo0AY22UmwdCEshmJMmmpA6P9uF9r
	 eItG2gHq6ZhNL8SAhfw4oX1B1ZIl6SlpP3AEz1JUTseDYYM5eVgprdPmlPXLQ9stbZ7az
	 F7S2qEhM91TFG3/iWmN1/fGhYHVwsOuZoyhGEaT0luELXo8N6sVDPBKXOO2Id7NB48cAa
	 TWoSAzm1arHizV91aGQYbQVgGAXahc5vOa6ujsBla2nlBH+zMGmrSG3mCRnd9I7hJyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426917;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cAPcpsII7gFpyShVm3rNkMnNdzBtBeLEAij9GqgyYDg=;
	b=kIb5cQ8AV+SvsQhU4FX4zXtHB5S5S5f0j5ksKL8kQtybs9vS2p11tObgReU2CIa9pJbH
	 FYqtOetTf699u9Lg1SAuB8bKAPS02Vg16HHiP0pUiMT/IRda8nyGds3aqTlYYFNQyJGaI
	 /XNPRTSmKTEGbhNa5cnFmiTaNuPxTuSaszEa0q72C1++lhzoqHRtIjOGhLz1cMPq8UhR5
	 21lEzOKWtVv4dgEmfElbpsMmVJW2vPeKjiRfUCj00X/VbxgHsH4Jm17NxFO+/L9hm3kZf
	 /jTZ4xnxn6mN1SZutbihQNZdJEDBvMFxZhzCXmfDZ1REPh8MClCznV1e+hO9KGfcEsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=FUWR54s5;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Xhq5Nehv;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9A606A31D;
	Mon, 19 Oct 2026 16:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF9A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=FUWR54s5;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Xhq5Nehv
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792426902; bh=cAPcpsII7gFpyShVm3rNkMn
	NdzBtBeLEAij9GqgyYDg=; b=FUWR54s5TRC3GUWV9gRsHsFJXvB+KrBA38U2cQuRxcqjFRJGME
	yUWZRbykzgneW62aOD/nsxIoYlIbAB+pv05RttjaEFuzhLtFnNSjXtxyC5FzmLkZl2FxO82t5sI
	h28Mp62dLQydjh1LJmR3JzL44INu3sZcUaH5Odbri0nG21leZMhVYhNb3FvuML8Y5MWNlwunW1R
	l5yM4GFk/IYNXPRtcLxHfO5VhRpD1ekY07tXmG0LzkoDWLl2uwpMeHCwb65F3fRUbIaaZ4jhIun
	FthubCKpjXtCvvib2dw5fm1oq+OQmjP4a3hrkj+lTJO/LK7bRDohcbPPvs3VohUgN5w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792426902; bh=cAPcpsII7gFpyShVm3rNkMn
	NdzBtBeLEAij9GqgyYDg=; b=Xhq5NehvAlASS45T3DhRitdm2oWikXsVVuURa8Z3kiKsRraWPX
	6A0cc1MbC1ANImgmHrj/50UzF+x18vNFnZCA==;
Date: Mon, 19 Oct 2026 17:21:43 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Andrea Parri <parri.andrea@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
CC: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_-rcu/dev=5D_hazptr=3A_Record_p?=
 =?US-ASCII?Q?er-CPU_slot_owner_after_claiming_the_slot?=
In-Reply-To: <20261019161852.12783-1-parri.andrea@gmail.com>
References: <20261019161852.12783-1-parri.andrea@gmail.com>
Message-ID: <B645B8F7-3073-448B-938E-9223A4E4A10F@mainlining.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 October 2026 17:18:48 BST, Andrea Parri <parri.andrea@gmail.com>
wrote:
>An interrupt that uses a hazard pointer while the interrupted task is
>in the acquire slow path can leave its own context recorded as the
>owner of the per-CPU slot the task then publishes into.  The next
>context switch promotes the task's pointer with the interrupt's
>context.
>
>hazptr_get_free_percpu_slot() records the owner when it picks an empty
>slot, but only Store B in __hazptr_try_acquire() claims the slot.  An
>interrupt in between picks the same slot, as the lowest free one:
>
>  Task on CPU 0                        IRQ on CPU 0
>  -------------                        ------------
>  hazptr_acquire(ctx)
>    fast path fails
>    __hazptr_acquire(ctx)
>      picks item k (empty)
>      item k->ctx.ctx = ctx
>                                       hazptr_acquire(irq_ctx)
>                                         claims item k
>                                         item k->ctx.ctx = irq_ctx
>                                       hazptr_release(irq_ctx)
>                                         clears slot k
>      __hazptr_try_acquire()
>        Store B into slot k
>      (item k still names irq_ctx)
>  sleeps holding the pointer
>  hazptr_note_context_switch()
>    promotes item k with irq_ctx
>
>The task gets there with k > 0 when it already holds an outer hazard
>pointer in slot 0; no other task can, as its slot is promoted when it
>is switched out.
>
>The task gets there with k == 0 when the fast path leaves slot 0
>empty: either its ptr_eq() check fails because an updater changed the
>pointer, or the pointer is NULL and an updater publishes a non-NULL one
>before the slow path loads it.
>
>The promotion moves the task's pointer into irq_ctx's backup slot,
>which nothing unchains, so hazptr_synchronize() on that pointer never
>returns.  The task's ctx->slot still names slot k, so its
>hazptr_release() clears whatever another reader on that CPU has since
>published there.
>
>If the interrupt detaches instead, as hazptr_torture_acquire() does,
>the promotion chains irq_ctx's backup slot a second time while it is
>still linked.  The overflow list then loops on that node, or follows
>LIST_POISON1 once hazptr_unchain_backup_slot() removes it.
>
>Record the owner after __hazptr_try_acquire() succeeds, as the fast
>path in hazptr_acquire() does.  This should be safe because an
>interrupt that used the slot has released or detached it by the time
>the task resumes, and only hazptr_note_context_switch() reads the
>owner, which cannot run before the task enables preemption.
>
>Fixes: 50b568234163 ("hazptr: Implement Hazard Pointers")
>Assisted-by: LLM

Awesome! 

Acked-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---
>
>Notes:
>    With this patch, hazptrtorture's NOPREEMPT scenario passes a 30-minute
>    run on x86_64 with 8 CPUs.  PREEMPT runs clean for 30 minutes but can
>    hang at shutdown, in hazptrtorture's release of deferred hazard
>    pointers; that hang does not involve this patch, and is addressed by
>    "hazptrtorture: Release all deferred hazard pointers before stopping",
>    posted separately.
>    
>    With that fix also applied, 30-minute runs pass for PREEMPT, for
>    NOPREEMPT with torture_type=hazptr, for PREEMPT with
>    torture_type=hazptr-stack, and for PREEMPT with CONFIG_HAZPTR_DEBUG=n.
>    
>    PREEMPT and NOPREEMPT also pass without this patch: their readers hold
>    one hazard pointer each, so they reach the slow path only when the
>    ptr_eq() check fails or the pointer is NULL, which happens only before
>    the writer publishes its first element and after it stops.
>    
>    A KUnit reproducer, with a test-only hook in __hazptr_try_acquire()
>    between the free-slot check and Store B, fails on 940793b926aa and
>    passes with this patch.  I can post it if useful.
>
> kernel/hazptr.c | 21 +++++++++++++--------
> 1 file changed, 13 insertions(+), 8 deletions(-)
>
>diff --git a/kernel/hazptr.c b/kernel/hazptr.c
>index 3ca73b56a5c25..b15b84ebd4ceb 100644
>--- a/kernel/hazptr.c
>+++ b/kernel/hazptr.c
>@@ -54,19 +54,16 @@ unsigned int flip_list_phase(unsigned int phase)
> }
> 
> static
>-struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>+struct hazptr_slot_item *hazptr_get_free_percpu_slot_item(void)
> {
> 	struct hazptr_percpu_slots *percpu_slots = this_cpu_ptr(&hazptr_percpu_slots);
> 	unsigned int idx;
> 
> 	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> 		struct hazptr_slot_item *item = &percpu_slots->items[idx];
>-		struct hazptr_slot *slot = &item->slot;
> 
>-		if (!slot->addr) {
>-			item->ctx.ctx = ctx;
>-			return slot;
>-		}
>+		if (!item->slot.addr)
>+			return item;
> 	}
> 	/* All slots are in use. */
> 	return NULL;
>@@ -78,6 +75,7 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>  */
> void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> {
>+	struct hazptr_slot_item *item;
> 	struct hazptr_slot *slot;
> 	void *addr;
> 
>@@ -85,10 +83,17 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> 	 * In case we are called due to nested use of hazard pointers,
> 	 * try a slot protection with per-CPU slots.
> 	 */
>-	slot = hazptr_get_free_percpu_slot(ctx);
>-	if (likely(slot)) {
>+	item = hazptr_get_free_percpu_slot_item();
>+	if (likely(item)) {
>+		slot = &item->slot;
> 		addr = __hazptr_try_acquire(ctx, addr_p, slot);
> 		if (addr) {
>+			/*
>+			 * Record the owner only once Store B has claimed the
>+			 * slot, as hazptr_acquire() does: an interrupt may
>+			 * have used this slot since it was chosen.
>+			 */
>+			item->ctx.ctx = ctx;
> 			ctx->slot = slot;
> 			return addr;
> 		}
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
