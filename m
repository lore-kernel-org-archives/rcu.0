Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C339C47257
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3B2206F0
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aLgqiSOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgEDAcl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbgEDAcl (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 3 May 2020 20:32:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F16C061A0E
        for <rcu@vger.kernel.org>; Sun,  3 May 2020 17:32:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ep1so7594308qvb.0
        for <rcu@vger.kernel.org>; Sun, 03 May 2020 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=chZRysJjyoY4Orh6QUp2xJf9hfyrbxQFBbg5sIt8W1o=;
        b=aLgqiSOcl+jOd0psqurrTizXOOqdcd14jh/utXfbSaVZOK6NIN+C7XB8Qn0NchL2c/
         aOPnnJcWziS98o5ZrjlJvpUQoG52+RBBeyquCWCVetwPmNFW1q22ka6PsrhvH3XBxzkA
         XokBKSgTfiIrEzyBMlTPcqZjBxGWGRPjuPWWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=chZRysJjyoY4Orh6QUp2xJf9hfyrbxQFBbg5sIt8W1o=;
        b=LIfQl7985Rce8jqTh9B2g89/yrD3+EMHWk+EC4umPdRpIcLVCl8RruZWVAssdYitQD
         7+IlMYsqwniRTVbtT89/daohhCjXPc58Ln46TthMvj8KtN2y3VsVYdxlZElS9pDzsxNp
         8yiPtZ4LBU+n2QXi79VCzFP0Kyuk1aeZ/EWkjuvh7vhof4wK5M8u2Td0kbW1BIecNppQ
         BwlcmvZs1E46+/BN2GEOgMEVerlMsgGQcBNP828O2p1hjttbzgLA50M80mOy2T1B/CFW
         xfGOE0UTeJ7teaPkzPkUaBjkTA49LIuinKSpRvrz0WzEbF03vSN1wHG0q7lEbBDQTNEv
         bsHw==
X-Gm-Message-State: AGi0PubAIoHAgQJ5HDJuEkLpfcjvp2BVCTfnwaw5+IqLnQ5dQFqLCGHK
        pcPt3oOdm2I5TIt/9onnLm1beg==
X-Google-Smtp-Source: APiQypIKWwqjQAM1AZ9mmo7w156/qr6z2kP4LAchZEdCxLl3jA4SBuBp4hTVeQR++T/fquL+LmZlSg==
X-Received: by 2002:a05:6214:1342:: with SMTP id b2mr13838455qvw.171.1588552358798;
        Sun, 03 May 2020 17:32:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c23sm8541893qka.12.2020.05.03.17.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 17:32:38 -0700 (PDT)
Date:   Sun, 3 May 2020 20:32:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 19/24] rcu/tree: Support reclaim for head-less object
Message-ID: <20200504003237.GD212435@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-20-urezki@gmail.com>
 <20200501223909.GF7560@paulmck-ThinkPad-P72>
 <20200504001258.GD197097@google.com>
 <20200504002855.GF2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504002855.GF2869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 03, 2020 at 05:28:55PM -0700, Paul E. McKenney wrote:
> On Sun, May 03, 2020 at 08:12:58PM -0400, Joel Fernandes wrote:
> > On Fri, May 01, 2020 at 03:39:09PM -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 28, 2020 at 10:58:58PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > Update the kvfree_call_rcu() with head-less support, it
> > > > means an object without any rcu_head structure can be
> > > > reclaimed after GP.
> > > > 
> > > > To store pointers there are two chain-arrays maintained
> > > > one for SLAB and another one is for vmalloc. Both types
> > > > of objects(head-less variant and regular one) are placed
> > > > there based on the type.
> > > > 
> > > > It can be that maintaining of arrays becomes impossible
> > > > due to high memory pressure. For such reason there is an
> > > > emergency path. In that case objects with rcu_head inside
> > > > are just queued building one way list. Later on that list
> > > > is drained.
> > > > 
> > > > As for head-less variant. Such objects do not have any
> > > > rcu_head helper inside. Thus it is dynamically attached.
> > > > As a result an object consists of back-pointer and regular
> > > > rcu_head. It implies that emergency path can detect such
> > > > object type, therefore they are tagged. So a back-pointer
> > > > could be freed as well as dynamically attached wrapper.
> > > > 
> > > > Even though such approach requires dynamic memory it needs
> > > > only sizeof(unsigned long *) + sizeof(struct rcu_head) bytes,
> > > > thus SLAB is used to obtain it. Finally if attaching of the
> > > > rcu_head and queuing get failed, the current context has
> > > > to follow might_sleep() annotation, thus below steps could
> > > > be applied:
> > > >    a) wait until a grace period has elapsed;
> > > >    b) direct inlining of the kvfree() call.
> > > > 
> > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 102 ++++++++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 98 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 51726e4c3b4d..501cac02146d 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3072,15 +3072,31 @@ static void kfree_rcu_work(struct work_struct *work)
> > > >  	 */
> > > >  	for (; head; head = next) {
> > > >  		unsigned long offset = (unsigned long)head->func;
> > > > -		void *ptr = (void *)head - offset;
> > > > +		bool headless;
> > > > +		void *ptr;
> > > >  
> > > >  		next = head->next;
> > > > +
> > > > +		/* We tag the headless object, if so adjust offset. */
> > > > +		headless = (((unsigned long) head - offset) & BIT(0));
> > > > +		if (headless)
> > > > +			offset -= 1;
> > > > +
> > > > +		ptr = (void *) head - offset;
> > > > +
> > > >  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
> > > >  		rcu_lock_acquire(&rcu_callback_map);
> > > >  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
> > > >  
> > > > -		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> > > > +		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
> > > > +			/*
> > > > +			 * If headless free the back-pointer first.
> > > > +			 */
> > > > +			if (headless)
> > > > +				kvfree((void *) *((unsigned long *) ptr));
> > > > +
> > > >  			kvfree(ptr);
> > > > +		}
> > > >  
> > > >  		rcu_lock_release(&rcu_callback_map);
> > > >  		cond_resched_tasks_rcu_qs();
> > > > @@ -3221,6 +3237,13 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > >  			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > >  				return false;
> > > >  
> > > > +			/*
> > > > +			 * TODO: For one argument of kvfree_rcu() we can
> > > > +			 * drop the lock and get the page in sleepable
> > > > +			 * context. That would allow to maintain an array
> > > > +			 * for the CONFIG_PREEMPT_RT as well. Thus we could
> > > > +			 * get rid of dynamic rcu_head attaching code.
> > > > +			 */
> > > >  			bnode = (struct kvfree_rcu_bulk_data *)
> > > >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > >  		}
> > > > @@ -3244,6 +3267,23 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > >  	return true;
> > > >  }
> > > >  
> > > > +static inline struct rcu_head *
> > > > +attach_rcu_head_to_object(void *obj)
> > > > +{
> > > > +	unsigned long *ptr;
> > > > +
> > > > +	ptr = kmalloc(sizeof(unsigned long *) +
> > > > +			sizeof(struct rcu_head), GFP_NOWAIT |
> > > > +				__GFP_RECLAIM |	/* can do direct reclaim. */
> > > > +				__GFP_NORETRY |	/* only lightweight one.  */
> > > > +				__GFP_NOWARN);	/* no failure reports. */
> > > 
> > > Again, let's please not do this single-pointer-sized allocation.  If
> > > a full page is not available and this is a single-argument kfree_rcu(),
> > > just call synchronize_rcu() and then free the object directly.
> > 
> > With the additional caching, lack of full page should not be very likely. I
> > agree we can avoid doing any allocation and just straight to
> > synchroize_rcu().
> 
> That sounds good to me!
> 
> > > It should not be -that- hard to adjust locking for CONFIG_PREEMPT_RT!
> > > For example, have some kind of reservation protocol so that a task
> > > that drops the lock can retry the page allocation and be sure of having
> > > a place to put it.  This might entail making CONFIG_PREEMPT_RT reserve
> > > more pages per CPU.  Or maybe that would not be necessary.
> > 
> > If we are not doing single-pointer allocation, then that would also eliminate
> > entering the low-level page allocator for single-pointer allocations.
> > 
> > Or did you mean entry into the allocator for the full-page allocations
> > related to the pointer array for PREEMPT_RT? Even if we skip entry into the
> > allocator for those, we will still have additional caching which further
> > reduces chances of getting a full page. In the event of such failure, we can
> > simply queue the rcu_head.
> > 
> > Thoughts?
> 
> I was just trying to guess why you kept the single-pointer allocation.
> It looks like I guessed wrong.  ;-)
> 
> If, as you say above, you make it go straight to synchronize_rcu()
> upon full-page allocation failure, that would be good!

Paul, sounds good. Vlad, are you also Ok with that?

thanks,

 - Joel


> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > > 
> > > 							Thanx, Paul
> > > 
> > > > +	if (!ptr)
> > > > +		return NULL;
> > > > +
> > > > +	ptr[0] = (unsigned long) obj;
> > > > +	return ((struct rcu_head *) ++ptr);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Queue a request for lazy invocation of appropriate free routine after a
> > > >   * grace period. Please note there are three paths are maintained, two are the
> > > > @@ -3260,16 +3300,34 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  {
> > > >  	unsigned long flags;
> > > >  	struct kfree_rcu_cpu *krcp;
> > > > +	bool success;
> > > >  	void *ptr;
> > > >  
> > > > +	if (head) {
> > > > +		ptr = (void *) head - (unsigned long) func;
> > > > +	} else {
> > > > +		/*
> > > > +		 * Please note there is a limitation for the head-less
> > > > +		 * variant, that is why there is a clear rule for such
> > > > +		 * objects:
> > > > +		 *
> > > > +		 * it can be used from might_sleep() context only. For
> > > > +		 * other places please embed an rcu_head to your data.
> > > > +		 */
> > > > +		might_sleep();
> > > > +		ptr = (unsigned long *) func;
> > > > +	}
> > > > +
> > > >  	krcp = krc_this_cpu_lock(&flags);
> > > > -	ptr = (void *)head - (unsigned long)func;
> > > >  
> > > >  	/* Queue the object but don't yet schedule the batch. */
> > > >  	if (debug_rcu_head_queue(ptr)) {
> > > >  		/* Probable double kfree_rcu(), just leak. */
> > > >  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > > >  			  __func__, head);
> > > > +
> > > > +		/* Mark as success and leave. */
> > > > +		success = true;
> > > >  		goto unlock_return;
> > > >  	}
> > > >  
> > > > @@ -3277,10 +3335,34 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  	 * Under high memory pressure GFP_NOWAIT can fail,
> > > >  	 * in that case the emergency path is maintained.
> > > >  	 */
> > > > -	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
> > > > +	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> > > > +	if (!success) {
> > > > +		if (head == NULL) {
> > > > +			/*
> > > > +			 * Headless(one argument kvfree_rcu()) can sleep.
> > > > +			 * Drop the lock and tack it back. So it can do
> > > > +			 * direct lightweight reclaim.
> > > > +			 */
> > > > +			krc_this_cpu_unlock(krcp, flags);
> > > > +			head = attach_rcu_head_to_object(ptr);
> > > > +			krcp = krc_this_cpu_lock(&flags);
> > > > +
> > > > +			if (head == NULL)
> > > > +				goto unlock_return;
> > > > +
> > > > +			/*
> > > > +			 * Tag the headless object. Such objects have a
> > > > +			 * back-pointer to the original allocated memory,
> > > > +			 * that has to be freed as well as dynamically
> > > > +			 * attached wrapper/head.
> > > > +			 */
> > > > +			func = (rcu_callback_t) (sizeof(unsigned long *) + 1);
> > > > +		}
> > > > +
> > > >  		head->func = func;
> > > >  		head->next = krcp->head;
> > > >  		krcp->head = head;
> > > > +		success = true;
> > > >  	}
> > > >  
> > > >  	WRITE_ONCE(krcp->count, krcp->count + 1);
> > > > @@ -3294,6 +3376,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  
> > > >  unlock_return:
> > > >  	krc_this_cpu_unlock(krcp, flags);
> > > > +
> > > > +	/*
> > > > +	 * High memory pressure, so inline kvfree() after
> > > > +	 * synchronize_rcu(). We can do it from might_sleep()
> > > > +	 * context only, so the current CPU can pass the QS
> > > > +	 * state.
> > > > +	 */
> > > > +	if (!success) {
> > > > +		debug_rcu_head_unqueue(ptr);
> > > > +		synchronize_rcu();
> > > > +		kvfree(ptr);
> > > > +	}
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> > > >  
> > > > -- 
> > > > 2.20.1
> > > > 
