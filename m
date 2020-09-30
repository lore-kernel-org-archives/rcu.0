Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF079C4727C
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 01:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596C320B1F
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 01:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601430810;
	bh=lypUyOA1xr9VE/tv0ok7w874fVvfarUizY0sLsP6U/o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Y9ZI3p7ZRYl2JAdmTjNQekOAMiOCagVYrVuk7Ni4GLX5qvP0DjJfkx3PHG6JetKsC
	 tK09coLqCF9ccSu9DBcl9GMs1jKW0iBEe2nHOmdLGRcmJHWUOiz0Wn7v1vCw4ubO8i
	 0Nv2hiQ/n0n+rSyayT4K6RLvJhBxJjcZZISGopxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgI3Bxa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 21:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3Bxa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 21:53:30 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F9820754;
        Wed, 30 Sep 2020 01:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601430807;
        bh=lypUyOA1xr9VE/tv0ok7w874fVvfarUizY0sLsP6U/o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NIH0teORf68xKUmOTOdqkcDdId2HeHp+mmxqSSiRi2vyZg+UQvkOxXSN3dQ51R/m6
         +NtduLYyM/5ku2zHo31hQ6ukmZkJR62THVF/qHadbVqGSAiw2xvwcUH5yq0cvYThTA
         ssTRn8DtkS60qWKFmgMDR7j82iCoJGWewFHdPP20=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 187613523039; Tue, 29 Sep 2020 18:53:27 -0700 (PDT)
Date:   Tue, 29 Sep 2020 18:53:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20200930015327.GX29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929120756.GC2277@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 29, 2020 at 02:07:56PM +0200, Michal Hocko wrote:
> On Mon 28-09-20 16:31:01, paulmck@kernel.org wrote:
> [...]

Apologies for the delay, but today has not been boring.

> > This commit therefore uses preemptible() to determine whether allocation
> > is possible at all for double-argument kvfree_rcu().
> 
> This deserves a comment. Because GFP_ATOMIC is possible for many
> !preemptible() contexts. It is the raw_spin_lock, NMIs and likely few
> others that are a problem. You are taking a conservative approach which
> is fine but it would be good to articulate that explicitly.

Good point, and so I have added the following as a header comment to
the add_ptr_to_bulk_krc_lock() function:

// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
// state specified by flags.  If can_sleep is true, the caller must
// be schedulable and not be holding any locks or mutexes that might be
// acquired by the memory allocator or anything that it might invoke.
// If !can_sleep, then if !preemptible() no allocation will be undertaken,
// otherwise the allocation will use GFP_ATOMIC to avoid the remainder of
// the aforementioned deadlock possibilities.  Returns true iff ptr was
// successfully recorded, else the caller must use a fallback.

The updated patch is shown below.

Of course, to Vlastimil's point, lockless access to the allocator
would significantly reduce the level of confusion posed by this code.
But that is a separate issue at the moment.

> > If !preemptible(),
> > then allocation is not possible, and kvfree_rcu() falls back to using
> > the less cache-friendly rcu_head approach.  Even when preemptible(),
> > the caller might be involved in reclaim, so the GFP_ flags used by
> > double-argument kvfree_rcu() must avoid invoking reclaim processing.
> 
> Could you be more specific? Is this about being called directly in the
> reclaim context and you want to prevent a recursion? If that is the
> case, do you really need to special case this in any way? Any memory
> reclaim will set PF_MEMALLOC so allocations called from that context
> will not perform reclaim. So if you are called from the reclaim directly
> then you might want to do GFP_KERNEL | __GFP_NOMEMALLOC | __GFP_NOWARN.
> That should handle both from-the-recalim and outside of reclaim contexts
> just fine (assuming you don't allocated from !preemptible()) context.

My thought was to point you at Daniel Vetter, but you already got in
touch with him, so thank you for that!

> > Note that single-argument kvfree_rcu() must be invoked in sleepable
> > contexts, and that its fallback is the relatively high latency
> > synchronize_rcu().  Single-argument kvfree_rcu() therefore uses
> > GFP_KERNEL|__GFP_RETRY_MAYFAIL to allow limited sleeping within the
> > memory allocator.
> [...]
> >  static inline bool
> > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> > +	unsigned long *flags, void *ptr, bool can_sleep)
> >  {
> >  	struct kvfree_rcu_bulk_data *bnode;
> > +	bool can_alloc_page = preemptible();
> > +	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
> 
> This is quite confusing IMHO. At least without a further explanation.
> can_sleep is not as much about sleeping as it is about the reclaim
> recursion AFAIU your changelog, right?

No argument on it being confusing, and I hope that the added header
comment helps.  But specifically, can_sleep==true is a promise by the
caller to be schedulable and not to be holding any lock/mutex/whatever
that might possibly be acquired by the memory allocator or by anything
else that the memory allocator might invoke, to your point, including
for but one example the reclaim logic.

The only way that can_sleep==true is if this function was invoked due
to a call to single-argument kvfree_rcu(), which must be schedulable
because its fallback is to invoke synchronize_rcu().

> >  	int idx;
> >  
> > -	if (unlikely(!krcp->initialized))
> > +	*krcp = krc_this_cpu_lock(flags);
> > +	if (unlikely(!(*krcp)->initialized))
> >  		return false;
> >  
> > -	lockdep_assert_held(&krcp->lock);
> >  	idx = !!is_vmalloc_addr(ptr);
> >  
> >  	/* Check if a new block is required. */
> > -	if (!krcp->bkvhead[idx] ||
> > -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > -		bnode = get_cached_bnode(krcp);
> > -		if (!bnode) {
> > -			/*
> > -			 * To keep this path working on raw non-preemptible
> > -			 * sections, prevent the optional entry into the
> > -			 * allocator as it uses sleeping locks. In fact, even
> > -			 * if the caller of kfree_rcu() is preemptible, this
> > -			 * path still is not, as krcp->lock is a raw spinlock.
> > -			 * With additional page pre-allocation in the works,
> > -			 * hitting this return is going to be much less likely.
> > -			 */
> > -			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > -				return false;
> > -
> > -			/*
> > -			 * NOTE: For one argument of kvfree_rcu() we can
> > -			 * drop the lock and get the page in sleepable
> > -			 * context. That would allow to maintain an array
> > -			 * for the CONFIG_PREEMPT_RT as well if no cached
> > -			 * pages are available.
> > -			 */
> > -			bnode = (struct kvfree_rcu_bulk_data *)
> > -				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > +	if (!(*krcp)->bkvhead[idx] ||
> > +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > +		bnode = get_cached_bnode(*krcp);
> > +		if (!bnode && can_alloc_page) {
> > +			krc_this_cpu_unlock(*krcp, *flags);
> > +			bnode = kmalloc(PAGE_SIZE, gfp);
> 
> What is the point of calling kmalloc  for a PAGE_SIZE object? Wouldn't
> using the page allocator directly be better?

Well, you guys gave me considerable heat about abusing internal allocator
interfaces, and kmalloc() and kfree() seem to be about as non-internal
as you can get and still be invoking the allocator.  ;-)

Again, please see below for the updated patch.  The only change from
the earlier verison is the addition of the header comment mentioned above.

							Thanx, Paul

------------------------------------------------------------------------

commit 3a8e10ea2a2ecf59a33d7d80ad6c4372c0c27f78
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Sep 22 21:06:22 2020 +0200

    rcu/tree: Allocate a page when caller is preemptible
    
    The current memory-allocation interface poses the following challenges:
    
    a)      In kernels built with CONFIG_PROVE_RAW_LOCK_NESTING, lockdep
            complains ("BUG: Invalid wait context").  This complaint is due
            to the memory allocator acquiring non-raw spinlocks while a raw
            spinlocks is held.  This problem can also arise if kvfree_rcu()
            is invoked while holding a raw spinlock.
    
    b)      In -rt kernels built with CONFIG_PREEMPT_RT, the situation
            described in (a) above results in an attempt to acquire a
            sleeplock while holding a spinlock, which is of course forbidden.
            This can lead to "BUG: scheduling while atomic".
    
    c)      Please note that call_rcu() is invoked from raw atomic context,
            so that kfree_rcu() and kvfree_rcu() are therefore also expected
            to be callable from atomic raw context as well.
    
    However given that CONFIG_PREEMPT_COUNT is unconditionally enabled
    by the earlier commits in this series, the preemptible() macro now
    properly detects preempt-disable code regions even in kernels built
    with CONFIG_PREEMPT_NONE.
    
    This commit therefore uses preemptible() to determine whether allocation
    is possible at all for double-argument kvfree_rcu().  If !preemptible(),
    then allocation is not possible, and kvfree_rcu() falls back to using
    the less cache-friendly rcu_head approach.  Even when preemptible(),
    the caller might be involved in reclaim, so the GFP_ flags used by
    double-argument kvfree_rcu() must avoid invoking reclaim processing.
    
    Note that single-argument kvfree_rcu() must be invoked in sleepable
    contexts, and that its fallback is the relatively high latency
    synchronize_rcu().  Single-argument kvfree_rcu() therefore uses
    GFP_KERNEL|__GFP_RETRY_MAYFAIL to allow limited sleeping within the
    memory allocator.
    
    Link: https://lore.kernel.org/lkml/20200630164543.4mdcf6zb4zfclhln@linutronix.de/
    Fixes: 3042f83f19be ("rcu: Support reclaim for head-less object")
    Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    [ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9..39ac930 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3166,7 +3166,7 @@ static void kfree_rcu_work(struct work_struct *work)
 			krc_this_cpu_unlock(krcp, flags);
 
 			if (bkvhead[i])
-				free_page((unsigned long) bkvhead[i]);
+				kfree(bkvhead[i]);
 
 			cond_resched_tasks_rcu_qs();
 		}
@@ -3290,44 +3290,37 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
+// state specified by flags.  If can_sleep is true, the caller must
+// be schedulable and not be holding any locks or mutexes that might be
+// acquired by the memory allocator or anything that it might invoke.
+// If !can_sleep, then if !preemptible() no allocation will be undertaken,
+// otherwise the allocation will use GFP_ATOMIC to avoid the remainder of
+// the aforementioned deadlock possibilities.  Returns true iff ptr was
+// successfully recorded, else the caller must use a fallback.
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_sleep)
 {
 	struct kvfree_rcu_bulk_data *bnode;
+	bool can_alloc_page = preemptible();
+	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
 	int idx;
 
-	if (unlikely(!krcp->initialized))
+	*krcp = krc_this_cpu_lock(flags);
+	if (unlikely(!(*krcp)->initialized))
 		return false;
 
-	lockdep_assert_held(&krcp->lock);
 	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
-	if (!krcp->bkvhead[idx] ||
-			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
-		bnode = get_cached_bnode(krcp);
-		if (!bnode) {
-			/*
-			 * To keep this path working on raw non-preemptible
-			 * sections, prevent the optional entry into the
-			 * allocator as it uses sleeping locks. In fact, even
-			 * if the caller of kfree_rcu() is preemptible, this
-			 * path still is not, as krcp->lock is a raw spinlock.
-			 * With additional page pre-allocation in the works,
-			 * hitting this return is going to be much less likely.
-			 */
-			if (IS_ENABLED(CONFIG_PREEMPT_RT))
-				return false;
-
-			/*
-			 * NOTE: For one argument of kvfree_rcu() we can
-			 * drop the lock and get the page in sleepable
-			 * context. That would allow to maintain an array
-			 * for the CONFIG_PREEMPT_RT as well if no cached
-			 * pages are available.
-			 */
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+	if (!(*krcp)->bkvhead[idx] ||
+			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
+		if (!bnode && can_alloc_page) {
+			krc_this_cpu_unlock(*krcp, *flags);
+			bnode = kmalloc(PAGE_SIZE, gfp);
+			*krcp = krc_this_cpu_lock(flags);
 		}
 
 		/* Switch to emergency path. */
@@ -3336,15 +3329,15 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
-		bnode->next = krcp->bkvhead[idx];
+		bnode->next = (*krcp)->bkvhead[idx];
 
 		/* Attach it to the head. */
-		krcp->bkvhead[idx] = bnode;
+		(*krcp)->bkvhead[idx] = bnode;
 	}
 
 	/* Finally insert. */
-	krcp->bkvhead[idx]->records
-		[krcp->bkvhead[idx]->nr_records++] = ptr;
+	(*krcp)->bkvhead[idx]->records
+		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
 
 	return true;
 }
@@ -3382,24 +3375,20 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
 
-		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
 	/*
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
@@ -4394,23 +4383,12 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		struct kvfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
-		for (i = 0; i < rcu_min_cached_objs; i++) {
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-
-			if (bnode)
-				put_cached_bnode(krcp, bnode);
-			else
-				pr_err("Failed to preallocate for %d CPU!\n", cpu);
-		}
-
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
