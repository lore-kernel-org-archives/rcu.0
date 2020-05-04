Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BA7C28CBC
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821FB2073B
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588551634;
	bh=mBgEpiCYIAy4aLFXfj72QuehtRR6sDbK9nZqWJ8tCpo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tnP09bkQheIBEO8ZbGzve6o7L2xy6+Q5rmEp0ctS5HAQEVrH2byKyii6oExTYXhqv
	 LeIj7sXpUllWn0Jtsm+8l4aV/LFnV/256/5sKXQQPpY7EfEHMAug/k2TCQNZ6Mg6CS
	 tUxeYHvldCtGNdHfqWqPw36Hjd+JUgDzivwiPJtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgEDAUe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgEDAUe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 3 May 2020 20:20:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D7320735;
        Mon,  4 May 2020 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588551632;
        bh=mBgEpiCYIAy4aLFXfj72QuehtRR6sDbK9nZqWJ8tCpo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IETXcWjL/8faWyHF72TuuU6UwVqGjvPv0TlrlraWAezh8YwHkqTNo3yD/4MCriqPk
         sMz487kq90j53FsYCnnwj+uG6qUf/C7xBPtxSeq7AMmbvFd6TX56jYHaRcxTqb/UAi
         Wgd6xDavhwQZodwnpK2xtiWlZkWOJ5Q7M3sIxrLo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1CF143520D7D; Sun,  3 May 2020 17:20:32 -0700 (PDT)
Date:   Sun, 3 May 2020 17:20:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 11/24] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200504002032.GC2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-12-urezki@gmail.com>
 <20200501213753.GE7560@paulmck-ThinkPad-P72>
 <20200503234250.GA197097@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503234250.GA197097@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 03, 2020 at 07:42:50PM -0400, Joel Fernandes wrote:
> On Fri, May 01, 2020 at 02:37:53PM -0700, Paul E. McKenney wrote:
> [...]
> > > @@ -2993,41 +2994,73 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > >  static void kfree_rcu_work(struct work_struct *work)
> > >  {
> > >  	unsigned long flags;
> > > +	struct kvfree_rcu_bulk_data *bkhead, *bvhead, *bnext;
> > >  	struct rcu_head *head, *next;
> > > -	struct kfree_rcu_bulk_data *bhead, *bnext;
> > >  	struct kfree_rcu_cpu *krcp;
> > >  	struct kfree_rcu_cpu_work *krwp;
> > > +	int i;
> > >  
> > >  	krwp = container_of(to_rcu_work(work),
> > >  			    struct kfree_rcu_cpu_work, rcu_work);
> > >  	krcp = krwp->krcp;
> > > +
> > >  	raw_spin_lock_irqsave(&krcp->lock, flags);
> > > +	/* Channel 1. */
> > > +	bkhead = krwp->bkvhead_free[0];
> > > +	krwp->bkvhead_free[0] = NULL;
> > > +
> > > +	/* Channel 2. */
> > > +	bvhead = krwp->bkvhead_free[1];
> > > +	krwp->bkvhead_free[1] = NULL;
> > > +
> > > +	/* Channel 3. */
> > >  	head = krwp->head_free;
> > >  	krwp->head_free = NULL;
> > > -	bhead = krwp->bhead_free;
> > > -	krwp->bhead_free = NULL;
> > >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > >  
> > > -	/* "bhead" is now private, so traverse locklessly. */
> > > -	for (; bhead; bhead = bnext) {
> > > -		bnext = bhead->next;
> > > -
> > > -		debug_rcu_bhead_unqueue(bhead);
> > > +	/* kmalloc()/kfree() channel. */
> > > +	for (; bkhead; bkhead = bnext) {
> > > +		bnext = bkhead->next;
> > > +		debug_rcu_bhead_unqueue(bkhead);
> > >  
> > >  		rcu_lock_acquire(&rcu_callback_map);
> > 
> > Given that rcu_lock_acquire() only affects lockdep, I have to ask exactly
> > what concurrency design you are using here...
> 
> I believe the rcu_callback_map usage above follows a similar pattern from old
> code where the rcu_callback_map is acquired before doing the kfree.
> 
> static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
> {
>         rcu_callback_t f;
>         unsigned long offset = (unsigned long)head->func;
> 
>         rcu_lock_acquire(&rcu_callback_map);
>         if (__is_kfree_rcu_offset(offset)) {
>                 trace_rcu_invoke_kfree_callback(rn, head, offset);
>                 kfree((void *)head - offset);
>                 rcu_lock_release(&rcu_callback_map);
> 
> So when kfree_rcu() was rewritten, the rcu_lock_acquire() of rcu_callback_map
> got carried.
> 
> I believe it is for detecting recursion where we possibly try to free
> RCU-held memory while already freeing memory. Or was there anoher purpose of
> the rcu_callback_map?

It looks like rcu_callback_map was been added by 77a40f97030 ("rcu:
Remove kfree_rcu() special casing and lazy-callback handling").  Which
was less than a year ago.  ;-)

Hmmm...  This would be a good way to allow lockdep to tell you that you
are running within an RCU callback on the one hand are are reclaiming
due to kfree_rcu() on the other.  Was that the intent?  If so, a comment
seems necessary.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > >  		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
> > > -			bhead->nr_records, bhead->records);
> > > +			bkhead->nr_records, bkhead->records);
> > > +
> > > +		kfree_bulk(bkhead->nr_records, bkhead->records);
> > > +		rcu_lock_release(&rcu_callback_map);
> > > +
> > > +		krcp = krc_this_cpu_lock(&flags);
> > > +		if (put_cached_bnode(krcp, bkhead))
> > > +			bkhead = NULL;
> > > +		krc_this_cpu_unlock(krcp, flags);
> > > +
> > > +		if (bkhead)
> > > +			free_page((unsigned long) bkhead);
> > > +
> > > +		cond_resched_tasks_rcu_qs();
> > > +	}
> > > +
> > > +	/* vmalloc()/vfree() channel. */
> > > +	for (; bvhead; bvhead = bnext) {
> > > +		bnext = bvhead->next;
> > > +		debug_rcu_bhead_unqueue(bvhead);
> > >  
> > > -		kfree_bulk(bhead->nr_records, bhead->records);
> > > +		rcu_lock_acquire(&rcu_callback_map);
> > 
> > And the same here.
> > 
> > > +		for (i = 0; i < bvhead->nr_records; i++) {
> > > +			trace_rcu_invoke_kfree_callback(rcu_state.name,
> > > +				(struct rcu_head *) bvhead->records[i], 0);
> > > +			vfree(bvhead->records[i]);
> > > +		}
> > >  		rcu_lock_release(&rcu_callback_map);
> > >  
> > >  		krcp = krc_this_cpu_lock(&flags);
> > > -		if (put_cached_bnode(krcp, bhead))
> > > -			bhead = NULL;
> > > +		if (put_cached_bnode(krcp, bvhead))
> > > +			bvhead = NULL;
> > >  		krc_this_cpu_unlock(krcp, flags);
> > >  
> > > -		if (bhead)
> > > -			free_page((unsigned long) bhead);
> > > +		if (bvhead)
> > > +			free_page((unsigned long) bvhead);
> > >  
> > >  		cond_resched_tasks_rcu_qs();
> > >  	}
> > > @@ -3047,7 +3080,7 @@ static void kfree_rcu_work(struct work_struct *work)
> > >  		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
> > >  
> > >  		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
> > > -			kfree(ptr);
> > > +			kvfree(ptr);
> > >  
> > >  		rcu_lock_release(&rcu_callback_map);
> > >  		cond_resched_tasks_rcu_qs();
> > > @@ -3072,21 +3105,34 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > >  		krwp = &(krcp->krw_arr[i]);
> > >  
> > >  		/*
> > > -		 * Try to detach bhead or head and attach it over any
> > > +		 * Try to detach bkvhead or head and attach it over any
> > >  		 * available corresponding free channel. It can be that
> > >  		 * a previous RCU batch is in progress, it means that
> > >  		 * immediately to queue another one is not possible so
> > >  		 * return false to tell caller to retry.
> > >  		 */
> > > -		if ((krcp->bhead && !krwp->bhead_free) ||
> > > +		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> > > +			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> > >  				(krcp->head && !krwp->head_free)) {
> > > -			/* Channel 1. */
> > > -			if (!krwp->bhead_free) {
> > > -				krwp->bhead_free = krcp->bhead;
> > > -				krcp->bhead = NULL;
> > > +			/*
> > > +			 * Channel 1 corresponds to SLAB ptrs.
> > > +			 */
> > > +			if (!krwp->bkvhead_free[0]) {
> > > +				krwp->bkvhead_free[0] = krcp->bkvhead[0];
> > > +				krcp->bkvhead[0] = NULL;
> > >  			}
> > >  
> > > -			/* Channel 2. */
> > > +			/*
> > > +			 * Channel 2 corresponds to vmalloc ptrs.
> > > +			 */
> > > +			if (!krwp->bkvhead_free[1]) {
> > > +				krwp->bkvhead_free[1] = krcp->bkvhead[1];
> > > +				krcp->bkvhead[1] = NULL;
> > > +			}
> > 
> > Why not a "for" loop here?  Duplicate code is most certainly not what
> > we want, as it can cause all sorts of trouble down the road.
> > 
> > 							Thanx, Paul
> > 
> > > +			/*
> > > +			 * Channel 3 corresponds to emergency path.
> > > +			 */
> > >  			if (!krwp->head_free) {
> > >  				krwp->head_free = krcp->head;
> > >  				krcp->head = NULL;
> > > @@ -3095,16 +3141,17 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > >  			WRITE_ONCE(krcp->count, 0);
> > >  
> > >  			/*
> > > -			 * One work is per one batch, so there are two "free channels",
> > > -			 * "bhead_free" and "head_free" the batch can handle. It can be
> > > -			 * that the work is in the pending state when two channels have
> > > -			 * been detached following each other, one by one.
> > > +			 * One work is per one batch, so there are three
> > > +			 * "free channels", the batch can handle. It can
> > > +			 * be that the work is in the pending state when
> > > +			 * channels have been detached following by each
> > > +			 * other.
> > >  			 */
> > >  			queue_rcu_work(system_wq, &krwp->rcu_work);
> > >  		}
> > >  
> > >  		/* Repeat if any "free" corresponding channel is still busy. */
> > > -		if (krcp->bhead || krcp->head)
> > > +		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
> > >  			repeat = true;
> > >  	}
> > >  
> > > @@ -3146,23 +3193,22 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > >  }
> > >  
> > >  static inline bool
> > > -kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> > > -	struct rcu_head *head, rcu_callback_t func)
> > > +kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > >  {
> > > -	struct kfree_rcu_bulk_data *bnode;
> > > +	struct kvfree_rcu_bulk_data *bnode;
> > > +	int idx;
> > >  
> > >  	if (unlikely(!krcp->initialized))
> > >  		return false;
> > >  
> > >  	lockdep_assert_held(&krcp->lock);
> > > +	idx = !!is_vmalloc_addr(ptr);
> > >  
> > >  	/* Check if a new block is required. */
> > > -	if (!krcp->bhead ||
> > > -			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
> > > +	if (!krcp->bkvhead[idx] ||
> > > +			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > >  		bnode = get_cached_bnode(krcp);
> > >  		if (!bnode) {
> > > -			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
> > > -
> > >  			/*
> > >  			 * To keep this path working on raw non-preemptible
> > >  			 * sections, prevent the optional entry into the
> > > @@ -3175,7 +3221,7 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> > >  			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > >  				return false;
> > >  
> > > -			bnode = (struct kfree_rcu_bulk_data *)
> > > +			bnode = (struct kvfree_rcu_bulk_data *)
> > >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > >  		}
> > >  
> > > @@ -3185,30 +3231,30 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> > >  
> > >  		/* Initialize the new block. */
> > >  		bnode->nr_records = 0;
> > > -		bnode->next = krcp->bhead;
> > > +		bnode->next = krcp->bkvhead[idx];
> > >  
> > >  		/* Attach it to the head. */
> > > -		krcp->bhead = bnode;
> > > +		krcp->bkvhead[idx] = bnode;
> > >  	}
> > >  
> > >  	/* Finally insert. */
> > > -	krcp->bhead->records[krcp->bhead->nr_records++] =
> > > -		(void *) head - (unsigned long) func;
> > > +	krcp->bkvhead[idx]->records
> > > +		[krcp->bkvhead[idx]->nr_records++] = ptr;
> > >  
> > >  	return true;
> > >  }
> > >  
> > >  /*
> > > - * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
> > > - * period. Please note there are two paths are maintained, one is the main one
> > > - * that uses kfree_bulk() interface and second one is emergency one, that is
> > > - * used only when the main path can not be maintained temporary, due to memory
> > > - * pressure.
> > > + * Queue a request for lazy invocation of appropriate free routine after a
> > > + * grace period. Please note there are three paths are maintained, two are the
> > > + * main ones that use array of pointers interface and third one is emergency
> > > + * one, that is used only when the main path can not be maintained temporary,
> > > + * due to memory pressure.
> > >   *
> > >   * Each kfree_call_rcu() request is added to a batch. The batch will be drained
> > >   * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
> > >   * be free'd in workqueue context. This allows us to: batch requests together to
> > > - * reduce the number of grace periods during heavy kfree_rcu() load.
> > > + * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
> > >   */
> > >  void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  {
> > > @@ -3231,7 +3277,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  	 * Under high memory pressure GFP_NOWAIT can fail,
> > >  	 * in that case the emergency path is maintained.
> > >  	 */
> > > -	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
> > > +	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
> > >  		head->func = func;
> > >  		head->next = krcp->head;
> > >  		krcp->head = head;
> > > @@ -4212,7 +4258,7 @@ static void __init kfree_rcu_batch_init(void)
> > >  
> > >  	for_each_possible_cpu(cpu) {
> > >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > -		struct kfree_rcu_bulk_data *bnode;
> > > +		struct kvfree_rcu_bulk_data *bnode;
> > >  
> > >  		for (i = 0; i < KFREE_N_BATCHES; i++) {
> > >  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> > > @@ -4220,7 +4266,7 @@ static void __init kfree_rcu_batch_init(void)
> > >  		}
> > >  
> > >  		for (i = 0; i < rcu_min_cached_objs; i++) {
> > > -			bnode = (struct kfree_rcu_bulk_data *)
> > > +			bnode = (struct kvfree_rcu_bulk_data *)
> > >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > >  
> > >  			if (bnode)
> > > -- 
> > > 2.20.1
> > > 
