Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C6C28CBC
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7205206E6
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V5IH22NQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgEDA7D (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDA7C (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 3 May 2020 20:59:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292AC061A0F
        for <rcu@vger.kernel.org>; Sun,  3 May 2020 17:59:00 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 71so12733388qtc.12
        for <rcu@vger.kernel.org>; Sun, 03 May 2020 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dGzpuHGQt/CpMRztwrrMy5WaYbVy7faS3B3/1U2TlFs=;
        b=V5IH22NQkcmtPC+TnV1Y8jq09aCmmuGnr87PTbVLQfU68J9Pg6hHAkl5oD4nlQUnIQ
         SYan+tfRTALA3aRtFZuUAceBmBml1BF2W27evU8idfLXQRleT9OTIDTmOl6TLlFJskS8
         9lvijALKBvRsOZrRYzuJ/GO6NszRzhgDGpQ/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dGzpuHGQt/CpMRztwrrMy5WaYbVy7faS3B3/1U2TlFs=;
        b=ep+GBqlS+YiUiN4rUMsjN4ZlVAW8jYGnkHMQcy6u2f0wPKyO97jlyBpSNJXp0jm92/
         mR+ewcapPUtEJEhRuhkExPJlHe751xkcEYmmsCbDtGEfX7OkBdLUk43hm30pG4CuHyyP
         W1fwmesJIxSCX6tllAnCzkmpkafwn0TzvNsMBHWmdBwBpWrVOcJadgDdCyps6igs5BvL
         GD+mnA/S0nPlXNhc5jCpfQzwz322PcZcl29Vm6HAFZUeVocjmnVgs6j4eF2eUxG3ffKe
         MMe+gQ/iOoUuaRzbsLGRkTOCayGiTIxoA10Hom2rFe49NrdtAkMQ1fhQe1b36fa5QiCr
         V4HA==
X-Gm-Message-State: AGi0PubTv/l6qCyjPqGCaFuMoaQW8P5FYQeQx734aI1CQ2iB8ITxKsKf
        I0F5hCpPIpuJ2OAmPvBr6fQqTg==
X-Google-Smtp-Source: APiQypILv43RT1IcmAFRdgmlrKPKk9csSPDAKXmUkL/NC+0vNmgqp9fP7Dy1tyAbBQF+DMzWUacCRg==
X-Received: by 2002:ac8:17c9:: with SMTP id r9mr15018660qtk.392.1588553939422;
        Sun, 03 May 2020 17:58:59 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y6sm8521336qky.133.2020.05.03.17.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 17:58:58 -0700 (PDT)
Date:   Sun, 3 May 2020 20:58:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 11/24] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200504005858.GG212435@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-12-urezki@gmail.com>
 <20200501213753.GE7560@paulmck-ThinkPad-P72>
 <20200503234250.GA197097@google.com>
 <20200504002032.GC2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504002032.GC2869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 03, 2020 at 05:20:32PM -0700, Paul E. McKenney wrote:
> On Sun, May 03, 2020 at 07:42:50PM -0400, Joel Fernandes wrote:
> > On Fri, May 01, 2020 at 02:37:53PM -0700, Paul E. McKenney wrote:
> > [...]
> > > > @@ -2993,41 +2994,73 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > >  static void kfree_rcu_work(struct work_struct *work)
> > > >  {
> > > >  	unsigned long flags;
> > > > +	struct kvfree_rcu_bulk_data *bkhead, *bvhead, *bnext;
> > > >  	struct rcu_head *head, *next;
> > > > -	struct kfree_rcu_bulk_data *bhead, *bnext;
> > > >  	struct kfree_rcu_cpu *krcp;
> > > >  	struct kfree_rcu_cpu_work *krwp;
> > > > +	int i;
> > > >  
> > > >  	krwp = container_of(to_rcu_work(work),
> > > >  			    struct kfree_rcu_cpu_work, rcu_work);
> > > >  	krcp = krwp->krcp;
> > > > +
> > > >  	raw_spin_lock_irqsave(&krcp->lock, flags);
> > > > +	/* Channel 1. */
> > > > +	bkhead = krwp->bkvhead_free[0];
> > > > +	krwp->bkvhead_free[0] = NULL;
> > > > +
> > > > +	/* Channel 2. */
> > > > +	bvhead = krwp->bkvhead_free[1];
> > > > +	krwp->bkvhead_free[1] = NULL;
> > > > +
> > > > +	/* Channel 3. */
> > > >  	head = krwp->head_free;
> > > >  	krwp->head_free = NULL;
> > > > -	bhead = krwp->bhead_free;
> > > > -	krwp->bhead_free = NULL;
> > > >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > >  
> > > > -	/* "bhead" is now private, so traverse locklessly. */
> > > > -	for (; bhead; bhead = bnext) {
> > > > -		bnext = bhead->next;
> > > > -
> > > > -		debug_rcu_bhead_unqueue(bhead);
> > > > +	/* kmalloc()/kfree() channel. */
> > > > +	for (; bkhead; bkhead = bnext) {
> > > > +		bnext = bkhead->next;
> > > > +		debug_rcu_bhead_unqueue(bkhead);
> > > >  
> > > >  		rcu_lock_acquire(&rcu_callback_map);
> > > 
> > > Given that rcu_lock_acquire() only affects lockdep, I have to ask exactly
> > > what concurrency design you are using here...
> > 
> > I believe the rcu_callback_map usage above follows a similar pattern from old
> > code where the rcu_callback_map is acquired before doing the kfree.
> > 
> > static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
> > {
> >         rcu_callback_t f;
> >         unsigned long offset = (unsigned long)head->func;
> > 
> >         rcu_lock_acquire(&rcu_callback_map);
> >         if (__is_kfree_rcu_offset(offset)) {
> >                 trace_rcu_invoke_kfree_callback(rn, head, offset);
> >                 kfree((void *)head - offset);
> >                 rcu_lock_release(&rcu_callback_map);
> > 
> > So when kfree_rcu() was rewritten, the rcu_lock_acquire() of rcu_callback_map
> > got carried.
> > 
> > I believe it is for detecting recursion where we possibly try to free
> > RCU-held memory while already freeing memory. Or was there anoher purpose of
> > the rcu_callback_map?
> 
> It looks like rcu_callback_map was been added by 77a40f97030 ("rcu:
> Remove kfree_rcu() special casing and lazy-callback handling").  Which
> was less than a year ago.  ;-)

I think that's just git blame falsely looking at moved code instead of the
original code.

It was actually the following commit. I think you were trying to detect
blocking and context-switching within an RCU callback. Since kfree_rcu() does
not have RCU callback functions, may be we can just remove it?

commit 24ef659a857c3cba40b64ea51ea4fce8d2fb7bbc
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Oct 28 09:22:24 2013 -0700

    rcu: Provide better diagnostics for blocking in RCU callback functions

    Currently blocking in an RCU callback function will result in
    "scheduling while atomic", which could be triggered for any number
    of reasons.  To aid debugging, this patch introduces a rcu_callback_map
    that is used to tie the inappropriate voluntary context switch back
    to the fact that the function is being invoked from within a callback.

thanks,

 - Joel


> 
> Hmmm...  This would be a good way to allow lockdep to tell you that you
> are running within an RCU callback on the one hand are are reclaiming
> due to kfree_rcu() on the other.  Was that the intent?  If so, a comment
> seems necessary.
> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > >  		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
> > > > -			bhead->nr_records, bhead->records);
> > > > +			bkhead->nr_records, bkhead->records);
> > > > +
> > > > +		kfree_bulk(bkhead->nr_records, bkhead->records);
> > > > +		rcu_lock_release(&rcu_callback_map);
> > > > +
> > > > +		krcp = krc_this_cpu_lock(&flags);
> > > > +		if (put_cached_bnode(krcp, bkhead))
> > > > +			bkhead = NULL;
> > > > +		krc_this_cpu_unlock(krcp, flags);
> > > > +
> > > > +		if (bkhead)
> > > > +			free_page((unsigned long) bkhead);
> > > > +
> > > > +		cond_resched_tasks_rcu_qs();
> > > > +	}
> > > > +
> > > > +	/* vmalloc()/vfree() channel. */
> > > > +	for (; bvhead; bvhead = bnext) {
> > > > +		bnext = bvhead->next;
> > > > +		debug_rcu_bhead_unqueue(bvhead);
> > > >  
> > > > -		kfree_bulk(bhead->nr_records, bhead->records);
> > > > +		rcu_lock_acquire(&rcu_callback_map);
> > > 
> > > And the same here.
> > > 
> > > > +		for (i = 0; i < bvhead->nr_records; i++) {
> > > > +			trace_rcu_invoke_kfree_callback(rcu_state.name,
> > > > +				(struct rcu_head *) bvhead->records[i], 0);
> > > > +			vfree(bvhead->records[i]);
> > > > +		}
> > > >  		rcu_lock_release(&rcu_callback_map);
> > > >  
> > > >  		krcp = krc_this_cpu_lock(&flags);
> > > > -		if (put_cached_bnode(krcp, bhead))
> > > > -			bhead = NULL;
> > > > +		if (put_cached_bnode(krcp, bvhead))
> > > > +			bvhead = NULL;
> > > >  		krc_this_cpu_unlock(krcp, flags);
> > > >  
> > > > -		if (bhead)
> > > > -			free_page((unsigned long) bhead);
> > > > +		if (bvhead)
> > > > +			free_page((unsigned long) bvhead);
> > > >  
> > > >  		cond_resched_tasks_rcu_qs();
> > > >  	}
> > > > @@ -3047,7 +3080,7 @@ static void kfree_rcu_work(struct work_struct *work)
> > > >  		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
> > > >  
> > > >  		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
> > > > -			kfree(ptr);
> > > > +			kvfree(ptr);
> > > >  
> > > >  		rcu_lock_release(&rcu_callback_map);
> > > >  		cond_resched_tasks_rcu_qs();
> > > > @@ -3072,21 +3105,34 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > > >  		krwp = &(krcp->krw_arr[i]);
> > > >  
> > > >  		/*
> > > > -		 * Try to detach bhead or head and attach it over any
> > > > +		 * Try to detach bkvhead or head and attach it over any
> > > >  		 * available corresponding free channel. It can be that
> > > >  		 * a previous RCU batch is in progress, it means that
> > > >  		 * immediately to queue another one is not possible so
> > > >  		 * return false to tell caller to retry.
> > > >  		 */
> > > > -		if ((krcp->bhead && !krwp->bhead_free) ||
> > > > +		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> > > > +			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> > > >  				(krcp->head && !krwp->head_free)) {
> > > > -			/* Channel 1. */
> > > > -			if (!krwp->bhead_free) {
> > > > -				krwp->bhead_free = krcp->bhead;
> > > > -				krcp->bhead = NULL;
> > > > +			/*
> > > > +			 * Channel 1 corresponds to SLAB ptrs.
> > > > +			 */
> > > > +			if (!krwp->bkvhead_free[0]) {
> > > > +				krwp->bkvhead_free[0] = krcp->bkvhead[0];
> > > > +				krcp->bkvhead[0] = NULL;
> > > >  			}
> > > >  
> > > > -			/* Channel 2. */
> > > > +			/*
> > > > +			 * Channel 2 corresponds to vmalloc ptrs.
> > > > +			 */
> > > > +			if (!krwp->bkvhead_free[1]) {
> > > > +				krwp->bkvhead_free[1] = krcp->bkvhead[1];
> > > > +				krcp->bkvhead[1] = NULL;
> > > > +			}
> > > 
> > > Why not a "for" loop here?  Duplicate code is most certainly not what
> > > we want, as it can cause all sorts of trouble down the road.
> > > 
> > > 							Thanx, Paul
> > > 
> > > > +			/*
> > > > +			 * Channel 3 corresponds to emergency path.
> > > > +			 */
> > > >  			if (!krwp->head_free) {
> > > >  				krwp->head_free = krcp->head;
> > > >  				krcp->head = NULL;
> > > > @@ -3095,16 +3141,17 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > > >  			WRITE_ONCE(krcp->count, 0);
> > > >  
> > > >  			/*
> > > > -			 * One work is per one batch, so there are two "free channels",
> > > > -			 * "bhead_free" and "head_free" the batch can handle. It can be
> > > > -			 * that the work is in the pending state when two channels have
> > > > -			 * been detached following each other, one by one.
> > > > +			 * One work is per one batch, so there are three
> > > > +			 * "free channels", the batch can handle. It can
> > > > +			 * be that the work is in the pending state when
> > > > +			 * channels have been detached following by each
> > > > +			 * other.
> > > >  			 */
> > > >  			queue_rcu_work(system_wq, &krwp->rcu_work);
> > > >  		}
> > > >  
> > > >  		/* Repeat if any "free" corresponding channel is still busy. */
> > > > -		if (krcp->bhead || krcp->head)
> > > > +		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
> > > >  			repeat = true;
> > > >  	}
> > > >  
> > > > @@ -3146,23 +3193,22 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > > >  }
> > > >  
> > > >  static inline bool
> > > > -kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> > > > -	struct rcu_head *head, rcu_callback_t func)
> > > > +kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > >  {
> > > > -	struct kfree_rcu_bulk_data *bnode;
> > > > +	struct kvfree_rcu_bulk_data *bnode;
> > > > +	int idx;
> > > >  
> > > >  	if (unlikely(!krcp->initialized))
> > > >  		return false;
> > > >  
> > > >  	lockdep_assert_held(&krcp->lock);
> > > > +	idx = !!is_vmalloc_addr(ptr);
> > > >  
> > > >  	/* Check if a new block is required. */
> > > > -	if (!krcp->bhead ||
> > > > -			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
> > > > +	if (!krcp->bkvhead[idx] ||
> > > > +			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > >  		bnode = get_cached_bnode(krcp);
> > > >  		if (!bnode) {
> > > > -			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
> > > > -
> > > >  			/*
> > > >  			 * To keep this path working on raw non-preemptible
> > > >  			 * sections, prevent the optional entry into the
> > > > @@ -3175,7 +3221,7 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> > > >  			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > >  				return false;
> > > >  
> > > > -			bnode = (struct kfree_rcu_bulk_data *)
> > > > +			bnode = (struct kvfree_rcu_bulk_data *)
> > > >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > >  		}
> > > >  
> > > > @@ -3185,30 +3231,30 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> > > >  
> > > >  		/* Initialize the new block. */
> > > >  		bnode->nr_records = 0;
> > > > -		bnode->next = krcp->bhead;
> > > > +		bnode->next = krcp->bkvhead[idx];
> > > >  
> > > >  		/* Attach it to the head. */
> > > > -		krcp->bhead = bnode;
> > > > +		krcp->bkvhead[idx] = bnode;
> > > >  	}
> > > >  
> > > >  	/* Finally insert. */
> > > > -	krcp->bhead->records[krcp->bhead->nr_records++] =
> > > > -		(void *) head - (unsigned long) func;
> > > > +	krcp->bkvhead[idx]->records
> > > > +		[krcp->bkvhead[idx]->nr_records++] = ptr;
> > > >  
> > > >  	return true;
> > > >  }
> > > >  
> > > >  /*
> > > > - * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
> > > > - * period. Please note there are two paths are maintained, one is the main one
> > > > - * that uses kfree_bulk() interface and second one is emergency one, that is
> > > > - * used only when the main path can not be maintained temporary, due to memory
> > > > - * pressure.
> > > > + * Queue a request for lazy invocation of appropriate free routine after a
> > > > + * grace period. Please note there are three paths are maintained, two are the
> > > > + * main ones that use array of pointers interface and third one is emergency
> > > > + * one, that is used only when the main path can not be maintained temporary,
> > > > + * due to memory pressure.
> > > >   *
> > > >   * Each kfree_call_rcu() request is added to a batch. The batch will be drained
> > > >   * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
> > > >   * be free'd in workqueue context. This allows us to: batch requests together to
> > > > - * reduce the number of grace periods during heavy kfree_rcu() load.
> > > > + * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
> > > >   */
> > > >  void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  {
> > > > @@ -3231,7 +3277,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  	 * Under high memory pressure GFP_NOWAIT can fail,
> > > >  	 * in that case the emergency path is maintained.
> > > >  	 */
> > > > -	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
> > > > +	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
> > > >  		head->func = func;
> > > >  		head->next = krcp->head;
> > > >  		krcp->head = head;
> > > > @@ -4212,7 +4258,7 @@ static void __init kfree_rcu_batch_init(void)
> > > >  
> > > >  	for_each_possible_cpu(cpu) {
> > > >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > -		struct kfree_rcu_bulk_data *bnode;
> > > > +		struct kvfree_rcu_bulk_data *bnode;
> > > >  
> > > >  		for (i = 0; i < KFREE_N_BATCHES; i++) {
> > > >  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> > > > @@ -4220,7 +4266,7 @@ static void __init kfree_rcu_batch_init(void)
> > > >  		}
> > > >  
> > > >  		for (i = 0; i < rcu_min_cached_objs; i++) {
> > > > -			bnode = (struct kfree_rcu_bulk_data *)
> > > > +			bnode = (struct kvfree_rcu_bulk_data *)
> > > >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > >  
> > > >  			if (bnode)
> > > > -- 
> > > > 2.20.1
> > > > 
