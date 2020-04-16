Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C649C352BE
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 10:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239C421D91
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 10:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI6sz7Uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504911AbgDPKbC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505031AbgDPKaS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 06:30:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F6C061A0C;
        Thu, 16 Apr 2020 03:30:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z26so7176519ljz.11;
        Thu, 16 Apr 2020 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gMd+uUoRGW+vJrmOIFuRgM9mCi4E/92ThEESCwQ8TFw=;
        b=TI6sz7UvWvIRw88GCX8sFju7HulY/jRa5aEQVh1Y6AeeNW4/Sxb5xUKAVRDZ1aZhya
         rYtd12zt9wshoybLzTsylWiKdqIckdbgjLazuKXlLvTuqGMOOqROpi4N2eX3kilAJWEL
         7UEcrC/4uR0uu7G9IGn+jQDyEIq+kqPTe4AmQ+H5vXhatbZORHN3X2/hKlvTARAizl6F
         2szpdEjvafNvxTjQB4rQ0NqkQPddRxB62EgVdc1JhyiO8hlhHj+UVDJDOVT7KieusEni
         tFX2dCNhMOnTtC6yo3Mj0+SMgzq2BgkLVJHWJSjZzNIFRYL6VSRl6ePDeM7oj+5gggFk
         KPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gMd+uUoRGW+vJrmOIFuRgM9mCi4E/92ThEESCwQ8TFw=;
        b=iZu3rfpn6yTGTo+KAmGfog4EJ+fIlxLuzunLgw6pUAdvag7otrTSAJ4YdW5AYz+tCf
         cM9B6ZgTWcU1+pqE0vXsQkZhlnE6d6QhSbj8q/Rv2CkBSPrtYUUNDVf6/TYoypnp9J4X
         eY/FHWqmPMj096S8bP++KmQIVwiB2W3MuHCrJ4/9lwYjYv5vAdUlnoMZjbSu4Nm5vu+F
         ILYdcbI6MBim9r6tk1pdFrHNiCGZFOhEKIqn4tF1TAuKA7oCvN3TaOb2C/ZexUianDry
         PTnE/6ivu9LE1SJc/09vC8sjVSwQZSP6dgj4NYwfnEQTyK0D0ZGSa0tpklTz9k9Z1Ret
         aK0A==
X-Gm-Message-State: AGi0PuZQi8DTECKH6YKjjieRWTgglJAvaH2Znvqu/nJozwPzLt2AOBJJ
        BHu7b626LSLsHGRR2kqzTOjgeN2AN5A=
X-Google-Smtp-Source: APiQypJUmrXDZ6OCXS/on46FkBBjYMXG8AImU/TH3WnOhYli0vgyRn9epBj0zQQ4FzIdy+pkCXT9bQ==
X-Received: by 2002:a2e:8958:: with SMTP id b24mr6414878ljk.211.1587033016259;
        Thu, 16 Apr 2020 03:30:16 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l29sm2348755ljb.95.2020.04.16.03.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 03:30:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Apr 2020 12:30:07 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200416103007.GA3925@pc636>
References: <20200413211504.108086-1-joel@joelfernandes.org>
 <20200414194353.GQ17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414194353.GQ17661@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Paul, Joel.

See my comments below. They are for better understanding a
whole strategy and the best way how to drive headless objects :)

> > This is a small code refactor and also removes the restriction that
> > headless kfree_rcu() users cannot sleep for allocation of the per-cpu
> > array where their pointers will be placed . Since they are always called
> > in a sleepable context, we can use this information to try harder during
> > the array allocation stage to allocate the per-cpu array.
> 
> In kernels, needing to do allocations in order to free memory must be
> regarded with great suspicion.  It -might- be kind-of sort-of OK here,
> but only if we never impede reclaim, I/O, or OOM handling.  Even then,
> this can be made to work only given that it is possible to fall back
> on a direct call to synchronize_rcu() in the case where absolutely no
> memory is available.
> 
I see your point and agree. So, the idea is to do progress instead of
doing OOM, I/O or direct reclaiming. It means that we should avoid of
using any allocations flags which will trigger such effects, directly
or indirectly. I think we are on the same base now.

> Rest assured that I do understand the attractions of a single-argument
> kfree_rcu().  Attractive, yes, but also very dangerous if not done
> quite carefully.  So let's please do it carefully!  ;-)
> 
Thanks for understanding and helping :)

> > Also there is a possible bug-fix for a migration scenario where a
> > kfree_rcu() headless user can get migrated during the
> > sleepable-allocation and end up on another CPU and restoring the wrong
> > CPU's flags. To remedy this, we store only the IRQ state on the stack
> > and save/restore IRQ state from there. Sure, for the headless case we
> > don't need to restore flags. But the code saving/restoring state is
> > common between headless and with-head kfree_rcu() variants, so it
> > handles all scenarios sampling/restoring just the IRQ state and not
> > saving/restoring all the flags.
> 
> I will suspend disbelief while I look at the patch, but this indirect flag
> handling sounds like an accident waiting to happen.  So in the meantime,
> is there a way to structure the code to make the flag handling more
> explicitly visible at the top level?
> 
> In addition, the usual way to conditionally disable interrupts
> is local_irq_save(flags) rather than conditionally invoking
> local_irq_disable().
> 
> Adding Johannes on CC for his thoughts as well.  (He will not be shy
> about correcting any misapprehensions that I might have.)
> 
> With that, please see below!
> 
> 							Thanx, Paul
> 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > 
> > This is just RFC and is based on top of Vlad's latest patches:
> > https://lkml.org/lkml/2020/4/2/383
> > 
> > The git tree containing this patch is at:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/dev
> > 
> > (This patch will be a part of a much large series in the future).
> > 
> > 
> >  kernel/rcu/tree.c | 150 +++++++++++++++++++++++++++++++---------------
> >  1 file changed, 103 insertions(+), 47 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 744d04d8b7724..2e0eaec929059 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3104,11 +3104,95 @@ static void kfree_rcu_monitor(struct work_struct *work)
> >  		spin_unlock_irqrestore(&krcp->lock, flags);
> >  }
> >  
> > +static inline struct kfree_rcu_cpu *krc_this_cpu_lock(bool irqs_disabled)
> > +{
> > +	struct kfree_rcu_cpu *krcp;
> > +
> > +	// For safely calling this_cpu_ptr().
> > +	if (!irqs_disabled)
> > +		local_irq_disable();
> 
> Again, local_irq_save() is the usual approach here.  And local_irq_restore()
> in krc_this_cpu_unlock() below.
> 
We discussed that with Joel and i also think that keeping previous
variant of the krc_this_cpu_lock()/krc_this_cpu_unlock() is better
and what is more important is easy, i.e. we do not really need to
understand whether IRQs are disabled or not, instead just save flags
and restore and that is it.

> > +
> > +	krcp = this_cpu_ptr(&krc);
> > +	if (likely(krcp->initialized))
> > +		spin_lock(&krcp->lock);
> > +
> > +	return krcp;
> > +}
> > +
> > +static inline void
> > +krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, bool irqs_disabled)
> > +{
> > +	if (likely(krcp->initialized))
> > +		spin_unlock(&krcp->lock);
> > +
> > +	if (!irqs_disabled)
> > +		local_irq_enable();
> > +}
> > +
> > +// alloc_object_locked - Try to allocate an object of size while dropping the lock.
> > +//
> > +// @size: Size of the object to internally allocate for kfree_rcu().
> > +// @slab: Do we allocate on slab or using buddy.
> > +// @can_sleep: Was kfree_rcu() called in sleepable context?
> > +// @krcp: The pointer to krcp. Needed if when relocking, we got migrated.
> > +//
> > +// Caveats:
> > +//
> > +// 1. Per-cpu krc's lock must be held with interrupts disabled.
> > +//
> > +// 2. Failure to allocate returns NULL and does not cause a warning.
> > +//
> > +// 3. Caller is responsible for using the correct free() APIs. If size == PAGE_SIZE,
> > +//    then free_page() should be called for freeing. Otherwise kfree().
> > +//
> > +static inline void *alloc_object_locked(size_t size, bool slab, bool can_sleep,
> > +					struct kfree_rcu_cpu **krcpp)
> > +{
> > +	void *ptr;
> > +	gfp_t gfp_flags, wmark_flags, reclaim_flags;
> > +	struct kfree_rcu_cpu *krcp = *krcpp;
> > +
> > +	WARN_ON_ONCE(size == PAGE_SIZE && slab);
> > +
> > +	// Decompose the flags:
> > +	// wmark_flags   - affect the watermark to control reserve access.
> > +	// reclaim_flags - these effect how reclaim works but would
> > +	//                 have no-affect in atomic or nowait context.
> > +	wmark_flags = (__GFP_HIGH | __GFP_ATOMIC);
> > +	reclaim_flags = (__GFP_RETRY_MAYFAIL);
> 
> You have a __GFP_RETRY_MAYFAIL here, which is good.  However, if
> this CPU has quite a few 4K blocks of memory already allocated for
> kfree_rcu(), at some point __GFP_NORETRY becomes necessary.  Again,
> single-argument kfree_rcu() has the option of invoking synchronize_rcu()
> and most other memory allocators do not.  And double-argument kfree_rcu()
> has a pre-allocated rcu_head in the structure that it can fall back on.
> 
> So let's please not get too memory-greedy here!
> 
As i see, your point is to use "light" allocations flags which will
not initiate direct reclaim, OOM, I/O waiting and so on. Please correct
me if i miss something.

> Note also that most systems will normally invoke an RCU callback on the
> same CPU that registered it.  This allows easy maintenance of an
> emergency cache for these situations.
> 
I have a patch that specifies number of pages to be cached, but i will
send out it later when we sort things like that out.

> Exceptions include systems doing frequent CPU-hotplug operations and
> rcu_nocbs CPUs.
> 
> > +
> > +	// These flags will be common to all allocations, whether we want to
> > +	// wait or sleep or reclaim will be controlled with additional flags
> > +	// later during the actual allocation.
> > +	gfp_flags = (wmark_flags | reclaim_flags | __GFP_NOWARN);
> > +
> > +	// First, do an allocation without waiting.
> > +	ptr = (size == PAGE_SIZE) ? (void *)__get_free_page(gfp_flags | GFP_NOWAIT)
> > +				  : (void *)kmalloc(size, gfp_flags | GFP_NOWAIT);
> > +	// If we cannot sleep, we are done.
> > +	if (ptr || !can_sleep)
> > +		return ptr;
> > +
> > +	// Now try to do it with more relaxed flags, we may enter direct-reclaim.
> > +	//
> > +	// IRQs were not enabled since can_sleep == true. So there's no need to
> > +	// save/restore flags.
> > +	krc_this_cpu_unlock(krcp, false);
> > +	ptr = (size == PAGE_SIZE) ? (void *)__get_free_page(gfp_flags | GFP_KERNEL)
> > +				  : (void *)kmalloc(size, gfp_flags | GFP_KERNEL);
> 
> Dropping the possibility of small allocations also simplifies this code,
> and also simplifies a fair amount of code elsewhere.
> 
I have a question about dynamic attaching of the rcu_head. Do you think
that we should drop it? We have it because of it requires 8 + syzeof(struct rcu_head)
bytes and is used when we can not allocate 1 page what is much more for array purpose.
Therefore, dynamic attaching can succeed because of using SLAB and requesting much
less memory then one page. There will be higher chance of bypassing synchronize_rcu()
and inlining freeing on a stack.

I agree that we should not use GFP_* flags instead we could go with GFP_NOWAIT |
__GFP_NOWARN when head attaching only. Also dropping GFP_ATOMIC to keep
atomic reserved memory for others.

> > +
> > +	// Take it back. We may have got migrated here.
> > +	*krcpp = krc_this_cpu_lock(false);
> > +
> > +	return ptr;
> > +}
> > +
> >  static inline bool
> > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > +kvfree_call_rcu_add_ptr_to_bulk(void *ptr, bool can_sleep, struct kfree_rcu_cpu **krcpp)
> >  {
> >  	struct kvfree_rcu_bulk_data *bnode;
> >  	int idx;
> > +	struct kfree_rcu_cpu *krcp = *krcpp;
> >  
> >  	if (unlikely(!krcp->initialized))
> >  		return false;
> > @@ -3121,9 +3205,11 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >  			krcp->bkvhead[idx]->nr_records ==
> >  				KVFREE_BULK_MAX_ENTR) {
> >  		bnode = xchg(&krcp->bkvcache[idx], NULL);
> > -		if (!bnode)
> > +		if (!bnode) {
> >  			bnode = (struct kvfree_rcu_bulk_data *)
> > -				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > +				alloc_object_locked(PAGE_SIZE, false /* use buddy */,
> > +						    can_sleep, krcpp);
> 
> Given the proper GFP_ flags, use of can_sleep does make sense here, good!
> 
> > +		}
> >  
> >  		/* Switch to emergency path. */
> >  		if (unlikely(!bnode))
> > @@ -3144,14 +3230,15 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >  	return true;
> >  }
> >  
> > -static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> > +static inline struct rcu_head *attach_rcu_head_to_object(void *obj,
> > +			       struct kfree_rcu_cpu **krcpp)
> >  {
> >  	unsigned long *ptr;
> >  
> > -	/* Try hard to get the memory. */
> > -	ptr = kmalloc(sizeof(unsigned long *) +
> > -		sizeof(struct rcu_head), GFP_KERNEL | __GFP_ATOMIC |
> > -			__GFP_HIGH | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> > +	// Allocate rcu_head on the slab.
> > +	ptr = alloc_object_locked(sizeof(unsigned long *) + sizeof(struct rcu_head),
> > +				  true /* slab */, true /* headless, so can sleep */,
> > +				  krcpp);
> 
> This small allocation can impede reclaim, I/O, and OOM handling, so this
> part of the code must be dropped.  If kfree_rcu() cannot allocate a 4K
> page, it needs to leave the tiny amount of remaining memory for others.
> The reason for this is that these others usually don't have the option
> of just calling synchronize_rcu(), and their need is quite likely to be
> much greater than that of kfree_rcu().
> 
That is about dynamic rcu_head attaching. We can drop it for sure. But
that helps to bypass "freeing on stack". Please see above.

> >  	if (!ptr)
> >  		return NULL;
> >  
> > @@ -3159,27 +3246,6 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> >  	return ((struct rcu_head *) ++ptr);
> >  }
> >  
> > -static inline struct kfree_rcu_cpu *
> > -krc_this_cpu_lock(unsigned long *flags)
> > -{
> > -	struct kfree_rcu_cpu *krcp;
> > -
> > -	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
> > -	krcp = this_cpu_ptr(&krc);
> > -	if (likely(krcp->initialized))
> > -		spin_lock(&krcp->lock);
> > -
> > -	return krcp;
> > -}
> > -
> > -static inline void
> > -krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
> > -{
> > -	if (likely(krcp->initialized))
> > -		spin_unlock(&krcp->lock);
> > -	local_irq_restore(flags);
> > -}
> > -
> >  /*
> >   * Queue a request for lazy invocation of appropriate free routine after a
> >   * grace period. Please note there are three paths are maintained, two are the
> > @@ -3195,10 +3261,9 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
> >   */
> >  void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > -	unsigned long flags;
> >  	struct kfree_rcu_cpu *krcp;
> >  	bool expedited_drain = false;
> > -	bool success;
> > +	bool success, irqs_disabled;
> >  	void *ptr;
> >  
> >  	if (head) {
> > @@ -3216,7 +3281,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  		ptr = (unsigned long *) func;
> >  	}
> >  
> > -	krcp = krc_this_cpu_lock(&flags);
> > +	irqs_disabled = irqs_disabled();
> > +	krcp = krc_this_cpu_lock(irqs_disabled);
> >  
> >  	// Queue the object but don't yet schedule the batch.
> >  	if (debug_rcu_head_queue(ptr)) {
> > @@ -3229,23 +3295,14 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  		goto unlock_return;
> >  	}
> >  
> > -	/*
> > -	 * Under high memory pressure GFP_NOWAIT can fail,
> > -	 * in that case the emergency path is maintained.
> > -	 */
> > -	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> > +	// Allow sleeping here only if headless
> > +	success = kvfree_call_rcu_add_ptr_to_bulk(ptr, !head /* can_sleep */, &krcp);
> >  	if (!success) {
> >  		/* Is headless object? */
> >  		if (head == NULL) {
> 
> We get here only if a 4K allocation fails, correct?
> 
Correct.

> > -			/* Drop the lock. */
> > -			krc_this_cpu_unlock(krcp, flags);
> > -
> > -			head = attach_rcu_head_to_object(ptr);
> > +			head = attach_rcu_head_to_object(ptr, &krcp);
> 
> If so, don't bother with the small allocation.  As noted earlier, others
> likely need the memory more than does kfree_rcu(), given that most will
> not have an out like invoking synchronize_rcu().  This approach allows
> dispensing with the behind-the-scenes interrupt enabling, which again
> is an accident waiting to happen.
> 
Same as above. Need to double confirm with you. We can drop it.

> Instead, just call synchronize_rcu(), then directly free the object,
> as in the inline_return label below.
> 

> This also allows you to keep the earlier simpler krc_this_cpu_lock()
> and krc_this_cpu_unlock() definitions and confine the interrupt flags
> manipulation to this function.
> 
Agree.

> >  			if (head == NULL)
> > -				goto inline_return;
> > -
> > -			/* Take it back. */
> > -			krcp = krc_this_cpu_lock(&flags);
> > +				goto unlock_return;
> >  
> >  			/*
> >  			 * Tag the headless object. Such objects have a back-pointer
> > @@ -3280,9 +3337,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	}
> >  
> >  unlock_return:
> > -	krc_this_cpu_unlock(krcp, flags);
> > +	krc_this_cpu_unlock(krcp, irqs_disabled);
> >  
> > -inline_return:
> >  	/*
> >  	 * High memory pressure, so inline kvfree() after
> >  	 * synchronize_rcu(). We can do it from might_sleep()
> > -- 
> > 2.26.0.110.g2183baf09c-goog

I know Joel will also write some comments because we has discussed it
via IRC. The idea is to find common view, and do it
as best as we can :)

Thanks Paul for good comments!

--
Vlad Rezki
