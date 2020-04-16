Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9BC2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C872A221EB
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587060063;
	bh=1RsSKQTajcRDMdHZkyk30y91wMRuYDUbk+//YFqJ9Zg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=o/B4sjIaIwpep7pPZJuqOUfo0yKkqQftwuS8iZqstQz5ZhpL4T0WUltgzC3ddD0p7
	 SgM9+hXzSJN5vLoax9sQJxOFWh6pXv0iMK36IXKDGfZVNX+/LE6wi0fFhRbpOAhvkH
	 tWrC+Xha1fA7+91SAe9TxdtKv6/kWio5cBUVDIYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393516AbgDPSBD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgDPSBD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 14:01:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B315A21924;
        Thu, 16 Apr 2020 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587060060;
        bh=1RsSKQTajcRDMdHZkyk30y91wMRuYDUbk+//YFqJ9Zg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PWJZgV0Wi4PnpwuBWFOeq2XURYbIT84RDNcpQIW58zfaq21ScVNTaX0c3bRTL/YKV
         ye7Es15VnKa2eMXQUHyLjvepY+DGWc8eQYqjHezjYKzmppgQtOltNsuqRMaUC5ApCW
         hy3sVdzWvZB4U38GkKsR0bzycd/Gt283ZzNTKqvw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6EDF035226B0; Thu, 16 Apr 2020 11:01:00 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:01:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200416180100.GT17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200413211504.108086-1-joel@joelfernandes.org>
 <20200414194353.GQ17661@paulmck-ThinkPad-P72>
 <20200416103007.GA3925@pc636>
 <20200416131745.GA90777@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416131745.GA90777@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 09:17:45AM -0400, Joel Fernandes wrote:
> On Thu, Apr 16, 2020 at 12:30:07PM +0200, Uladzislau Rezki wrote:
> > Hello, Paul, Joel.
> > 
> > See my comments below. They are for better understanding a
> > whole strategy and the best way how to drive headless objects :)
> 
> Thanks for the comments on the RFC patch :) I am on the same page and Ok with
> being more conservative on memory allocation.
> 
> > > > This is a small code refactor and also removes the restriction that
> > > > headless kfree_rcu() users cannot sleep for allocation of the per-cpu
> > > > array where their pointers will be placed . Since they are always called
> > > > in a sleepable context, we can use this information to try harder during
> > > > the array allocation stage to allocate the per-cpu array.
> > > 
> > > In kernels, needing to do allocations in order to free memory must be
> > > regarded with great suspicion.  It -might- be kind-of sort-of OK here,
> > > but only if we never impede reclaim, I/O, or OOM handling.  Even then,
> > > this can be made to work only given that it is possible to fall back
> > > on a direct call to synchronize_rcu() in the case where absolutely no
> > > memory is available.
> > > 
> > I see your point and agree. So, the idea is to do progress instead of
> > doing OOM, I/O or direct reclaiming. It means that we should avoid of
> > using any allocations flags which will trigger such effects, directly
> > or indirectly. I think we are on the same base now.
> 
> Right.

To Joel's point below, it is more that others need the memory, and don't
have the synchronize_rcu() option.  So this code should not take memory
that the reclaim, I/O, or OOM handling code needs, or even memory that
this code could make good use of.

For example, it is entirely possible that a given kfree_rcu() might
only be freeing 16 bytes of data.  It clearly does not make much sense
to allocate another 24 bytes of data to free 16 bytes.  In contrast
the reclaim, I/O, and OOM handling can often free up many hundreds of
megabytes or even large numbers of gigabytes.

Of course, it might be that kfree_rcu() is freeing a larger block
of memory, say 64KB.  But even in that case, allocating the extra 24
bytes isn't going to cause that memory to be freed any sooner than would
invoking synchronize_rcu() followed by kfree().  (Besides which, if you
have a 64KB structure, in most cases you aren't going to have too much
trouble finding 16 bytes for a rcu_head within that structure.)

Instead, the memory-footprint benefit of allocating the extra memory for
kfree_rcu() comes when the calling process will immediately do another
kfree_rcu(), but of a large structure.  The problem is that there is
no way to tell within kfree_rcu() whether the caller is going to invoke
another kfree_rcu() ever, let alone immediately.

So kfree_rcu() needs to restrain itself in its use of memory during
OOM conditions.  And if a 4K allocation fails, OOM conditions are
almost always in effect.

> > > > Also there is a possible bug-fix for a migration scenario where a
> > > > kfree_rcu() headless user can get migrated during the
> > > > sleepable-allocation and end up on another CPU and restoring the wrong
> > > > CPU's flags. To remedy this, we store only the IRQ state on the stack
> > > > and save/restore IRQ state from there. Sure, for the headless case we
> > > > don't need to restore flags. But the code saving/restoring state is
> > > > common between headless and with-head kfree_rcu() variants, so it
> > > > handles all scenarios sampling/restoring just the IRQ state and not
> > > > saving/restoring all the flags.
> > > 
> > > I will suspend disbelief while I look at the patch, but this indirect flag
> > > handling sounds like an accident waiting to happen.  So in the meantime,
> > > is there a way to structure the code to make the flag handling more
> > > explicitly visible at the top level?
> > > 
> > > In addition, the usual way to conditionally disable interrupts
> > > is local_irq_save(flags) rather than conditionally invoking
> > > local_irq_disable().
> 
> I agree with the below suggestions and that would remove the need for the
> conditional disabling of interrupts.
> 
> > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > > 
> > > > This is just RFC and is based on top of Vlad's latest patches:
> > > > https://lkml.org/lkml/2020/4/2/383
> > > > 
> > > > The git tree containing this patch is at:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/dev
> > > > 
> > > > (This patch will be a part of a much large series in the future).
> > > > 
> > > > 
> > > >  kernel/rcu/tree.c | 150 +++++++++++++++++++++++++++++++---------------
> > > >  1 file changed, 103 insertions(+), 47 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 744d04d8b7724..2e0eaec929059 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3104,11 +3104,95 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > > >  		spin_unlock_irqrestore(&krcp->lock, flags);
> > > >  }
> > > >  
> > > > +static inline struct kfree_rcu_cpu *krc_this_cpu_lock(bool irqs_disabled)
> > > > +{
> > > > +	struct kfree_rcu_cpu *krcp;
> > > > +
> > > > +	// For safely calling this_cpu_ptr().
> > > > +	if (!irqs_disabled)
> > > > +		local_irq_disable();
> > > 
> > > Again, local_irq_save() is the usual approach here.  And local_irq_restore()
> > > in krc_this_cpu_unlock() below.
> > > 
> > We discussed that with Joel and i also think that keeping previous
> > variant of the krc_this_cpu_lock()/krc_this_cpu_unlock() is better
> > and what is more important is easy, i.e. we do not really need to
> > understand whether IRQs are disabled or not, instead just save flags
> > and restore and that is it.
> 
> Sounds good, if we are avoiding any possiblity of direct-reclaim, then that
> removes the need for dropping the lock and thus removes the chance of
> migrations that I was concerned about.

Sounds good here as well!  I will let you guys discuss with Sebastian, at
least for the moment.  ;-)

> > > > +	krcp = this_cpu_ptr(&krc);
> > > > +	if (likely(krcp->initialized))
> > > > +		spin_lock(&krcp->lock);
> > > > +
> > > > +	return krcp;
> > > > +}
> > > > +
> > > > +static inline void
> > > > +krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, bool irqs_disabled)
> > > > +{
> > > > +	if (likely(krcp->initialized))
> > > > +		spin_unlock(&krcp->lock);
> > > > +
> > > > +	if (!irqs_disabled)
> > > > +		local_irq_enable();
> > > > +}
> > > > +
> > > > +// alloc_object_locked - Try to allocate an object of size while dropping the lock.
> > > > +//
> > > > +// @size: Size of the object to internally allocate for kfree_rcu().
> > > > +// @slab: Do we allocate on slab or using buddy.
> > > > +// @can_sleep: Was kfree_rcu() called in sleepable context?
> > > > +// @krcp: The pointer to krcp. Needed if when relocking, we got migrated.
> > > > +//
> > > > +// Caveats:
> > > > +//
> > > > +// 1. Per-cpu krc's lock must be held with interrupts disabled.
> > > > +//
> > > > +// 2. Failure to allocate returns NULL and does not cause a warning.
> > > > +//
> > > > +// 3. Caller is responsible for using the correct free() APIs. If size == PAGE_SIZE,
> > > > +//    then free_page() should be called for freeing. Otherwise kfree().
> > > > +//
> > > > +static inline void *alloc_object_locked(size_t size, bool slab, bool can_sleep,
> > > > +					struct kfree_rcu_cpu **krcpp)
> > > > +{
> > > > +	void *ptr;
> > > > +	gfp_t gfp_flags, wmark_flags, reclaim_flags;
> > > > +	struct kfree_rcu_cpu *krcp = *krcpp;
> > > > +
> > > > +	WARN_ON_ONCE(size == PAGE_SIZE && slab);
> > > > +
> > > > +	// Decompose the flags:
> > > > +	// wmark_flags   - affect the watermark to control reserve access.
> > > > +	// reclaim_flags - these effect how reclaim works but would
> > > > +	//                 have no-affect in atomic or nowait context.
> > > > +	wmark_flags = (__GFP_HIGH | __GFP_ATOMIC);
> > > > +	reclaim_flags = (__GFP_RETRY_MAYFAIL);
> > > 
> > > You have a __GFP_RETRY_MAYFAIL here, which is good.  However, if
> > > this CPU has quite a few 4K blocks of memory already allocated for
> > > kfree_rcu(), at some point __GFP_NORETRY becomes necessary.  Again,
> > > single-argument kfree_rcu() has the option of invoking synchronize_rcu()
> > > and most other memory allocators do not.  And double-argument kfree_rcu()
> > > has a pre-allocated rcu_head in the structure that it can fall back on.
> > > 
> > > So let's please not get too memory-greedy here!
> > > 
> > As i see, your point is to use "light" allocations flags which will
> > not initiate direct reclaim, OOM, I/O waiting and so on. Please correct
> > me if i miss something.
> 
> I agree. One thing I want to add is any allocation however small has an
> effect either directly or indirectly, but I agree trying too hard may further
> avoid another unrelated needy user getting the memory they may need.

I would say that the main point is to avoid depriving reclaim, I/O, and
OOM handling of memory that they could make good use of.

> > > Note also that most systems will normally invoke an RCU callback on the
> > > same CPU that registered it.  This allows easy maintenance of an
> > > emergency cache for these situations.
> > > 
> > I have a patch that specifies number of pages to be cached, but i will
> > send out it later when we sort things like that out.
> 
> Sounds good. I am assuming that you are going to make it such that there are
> 2 pages per-cpu by default which can be used for either vfree or kfree
> arrays and further caching being made user-configurable. But either way
> looking forward to the patch.
> 
> > > Exceptions include systems doing frequent CPU-hotplug operations and
> > > rcu_nocbs CPUs.
> 
> Per my understanding, the CPU hotplug has an effect on migrating callbacks so
> that's why CPU hotplug has an effect of not invoking callbacks on the same
> CPU that they were queued on, but please let me know if my understanding is
> not correct.

You got it -- if a CPU is removed, some other CPU will adopt any remaining
callbacks from the outgoing CPU.

But is should be easy to mark the pre-allocated pages with the CPU that
they belong to and locklessly put them back.  There are quite a few ways
to do that, especially if those pages are used only when allocation fails.

For example, each CPU could have an array of pointers to its reserved
set of pages, and each such page could have a pointer to its pointer.
Then just use smp_store_release() and done.  (Please let me know if
you would like more detail.  And, yes, this is compatible with lazy
populating of the reserve set.)

> > > > +
> > > > +	// These flags will be common to all allocations, whether we want to
> > > > +	// wait or sleep or reclaim will be controlled with additional flags
> > > > +	// later during the actual allocation.
> > > > +	gfp_flags = (wmark_flags | reclaim_flags | __GFP_NOWARN);
> > > > +
> > > > +	// First, do an allocation without waiting.
> > > > +	ptr = (size == PAGE_SIZE) ? (void *)__get_free_page(gfp_flags | GFP_NOWAIT)
> > > > +				  : (void *)kmalloc(size, gfp_flags | GFP_NOWAIT);
> > > > +	// If we cannot sleep, we are done.
> > > > +	if (ptr || !can_sleep)
> > > > +		return ptr;
> > > > +
> > > > +	// Now try to do it with more relaxed flags, we may enter direct-reclaim.
> > > > +	//
> > > > +	// IRQs were not enabled since can_sleep == true. So there's no need to
> > > > +	// save/restore flags.
> > > > +	krc_this_cpu_unlock(krcp, false);
> > > > +	ptr = (size == PAGE_SIZE) ? (void *)__get_free_page(gfp_flags | GFP_KERNEL)
> > > > +				  : (void *)kmalloc(size, gfp_flags | GFP_KERNEL);
> > > 
> > > Dropping the possibility of small allocations also simplifies this code,
> > > and also simplifies a fair amount of code elsewhere.
> > > 
> > I have a question about dynamic attaching of the rcu_head. Do you think
> > that we should drop it? We have it because of it requires 8 + syzeof(struct rcu_head)
> > bytes and is used when we can not allocate 1 page what is much more for array purpose.
> > Therefore, dynamic attaching can succeed because of using SLAB and requesting much
> > less memory then one page. There will be higher chance of bypassing synchronize_rcu()
> > and inlining freeing on a stack.
> > 
> > I agree that we should not use GFP_* flags instead we could go with GFP_NOWAIT |
> > __GFP_NOWARN when head attaching only. Also dropping GFP_ATOMIC to keep
> > atomic reserved memory for others.

I must defer to people who understand the GFP flags better than I do.
The suggestion of __GFP_RETRY_MAYFAIL for no memory pressure (or maybe
when the CPU's reserve is not yet full) and __GFP_NORETRY otherwise came
from one of these people.  ;-)

> I also have same question. Just to add here, previous patches added a warning
> to synchronize_rcu(). Should that warning be dropped then if it is more
> normal for kfree_rcu() to enter the synchronous path when the user had not
> passed in an rcu_head?

Agreed.  I could imagine a default-disabled kernel-boot flag, but people
wanting such a thing would probably be better served by the current
sysctl_panic_on_oom.

> > > >  			if (head == NULL)
> > > > -				goto inline_return;
> > > > -
> > > > -			/* Take it back. */
> > > > -			krcp = krc_this_cpu_lock(&flags);
> > > > +				goto unlock_return;
> > > >  
> > > >  			/*
> > > >  			 * Tag the headless object. Such objects have a back-pointer
> > > > @@ -3280,9 +3337,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  	}
> > > >  
> > > >  unlock_return:
> > > > -	krc_this_cpu_unlock(krcp, flags);
> > > > +	krc_this_cpu_unlock(krcp, irqs_disabled);
> > > >  
> > > > -inline_return:
> > > >  	/*
> > > >  	 * High memory pressure, so inline kvfree() after
> > > >  	 * synchronize_rcu(). We can do it from might_sleep()
> > > > -- 
> > > > 2.26.0.110.g2183baf09c-goog
> > 
> > I know Joel will also write some comments because we has discussed it
> > via IRC. The idea is to find common view, and do it
> > as best as we can :)
> > 
> > Thanks Paul for good comments!
> 
> Thanks a lot for all the comments to both of you :)

We will get there!  ;-)

							Thanx, Paul
