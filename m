Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CA6C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620E4206E9
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rpIPcafZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895058AbgDPNSG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894983AbgDPNSC (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 09:18:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88AC061A0F
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 06:17:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o19so13862103qkk.5
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eR5I4E4T4/4IxSicnYUr1AFVo0A/LtIPYrGBPrB2/04=;
        b=rpIPcafZ4VdWvQi/EUbIUk6OPIpu2cqkTR9znN28OoXOPxV9dh2le9vWUaRTFHECXB
         51vgWhOIGhCHWh/CoORjkuU9gkv9Q1OlEaCSdZvoTwVNFjQD9kPDqTxTCtyeOVQG8jqo
         gTWskFIfjD1u928/59/2fQyK8n996XcKgPPjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eR5I4E4T4/4IxSicnYUr1AFVo0A/LtIPYrGBPrB2/04=;
        b=ahhUJF3Nk67UAHP8LdQ6jFMdwmQLnqg2sy85rRPeEGK+lSaDhmzYLYpfIn8o0AaB1P
         QyJbEXsozxu916aoREgU8+Ftwcw48Do7uVMEiEFwtF2lD0J/r8S4R8q1Oc+K3TRomk0m
         0gYsgstewpA/LexH5tCJYRDwoQpa3/U7WfjtnzmfM1z0rC0JMvt/xDdazl7bNyunY8YB
         upng7T3VYxIV9FyceUcfRSupngebD1rFO3mJm5hAsFlRiDnxpJrkuWAsrCcfnajrhsyi
         hFtsIJMIiAQS3UPfzj99Cpq1w+ICvRNSINuv/SmiF2xAepAjDcs7VvV6ei259vpcVeFx
         sXjw==
X-Gm-Message-State: AGi0PuanCpz29pwHCWBVlWmfk9sZ2VQyAtSBMee0GSy7lwbwHMnLduJG
        fqBD4HaxKAKWoK9brL/q7ksz1/OeWaw=
X-Google-Smtp-Source: APiQypJZHeSuH696w1N1+pBEt6HXR6rAeDmFv3fXRVtzpa2ny4Lxkx2vFr4DA0DZtPyLNE/ijMI+5g==
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr18143094qka.496.1587043066238;
        Thu, 16 Apr 2020 06:17:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j90sm15174409qte.20.2020.04.16.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 06:17:45 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:17:45 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200416131745.GA90777@google.com>
References: <20200413211504.108086-1-joel@joelfernandes.org>
 <20200414194353.GQ17661@paulmck-ThinkPad-P72>
 <20200416103007.GA3925@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416103007.GA3925@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 12:30:07PM +0200, Uladzislau Rezki wrote:
> Hello, Paul, Joel.
> 
> See my comments below. They are for better understanding a
> whole strategy and the best way how to drive headless objects :)

Thanks for the comments on the RFC patch :) I am on the same page and Ok with
being more conservative on memory allocation.

> > > This is a small code refactor and also removes the restriction that
> > > headless kfree_rcu() users cannot sleep for allocation of the per-cpu
> > > array where their pointers will be placed . Since they are always called
> > > in a sleepable context, we can use this information to try harder during
> > > the array allocation stage to allocate the per-cpu array.
> > 
> > In kernels, needing to do allocations in order to free memory must be
> > regarded with great suspicion.  It -might- be kind-of sort-of OK here,
> > but only if we never impede reclaim, I/O, or OOM handling.  Even then,
> > this can be made to work only given that it is possible to fall back
> > on a direct call to synchronize_rcu() in the case where absolutely no
> > memory is available.
> > 
> I see your point and agree. So, the idea is to do progress instead of
> doing OOM, I/O or direct reclaiming. It means that we should avoid of
> using any allocations flags which will trigger such effects, directly
> or indirectly. I think we are on the same base now.

Right.
 
> > > Also there is a possible bug-fix for a migration scenario where a
> > > kfree_rcu() headless user can get migrated during the
> > > sleepable-allocation and end up on another CPU and restoring the wrong
> > > CPU's flags. To remedy this, we store only the IRQ state on the stack
> > > and save/restore IRQ state from there. Sure, for the headless case we
> > > don't need to restore flags. But the code saving/restoring state is
> > > common between headless and with-head kfree_rcu() variants, so it
> > > handles all scenarios sampling/restoring just the IRQ state and not
> > > saving/restoring all the flags.
> > 
> > I will suspend disbelief while I look at the patch, but this indirect flag
> > handling sounds like an accident waiting to happen.  So in the meantime,
> > is there a way to structure the code to make the flag handling more
> > explicitly visible at the top level?
> > 
> > In addition, the usual way to conditionally disable interrupts
> > is local_irq_save(flags) rather than conditionally invoking
> > local_irq_disable().

I agree with the below suggestions and that would remove the need for the
conditional disabling of interrupts.

> > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > > 
> > > This is just RFC and is based on top of Vlad's latest patches:
> > > https://lkml.org/lkml/2020/4/2/383
> > > 
> > > The git tree containing this patch is at:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/dev
> > > 
> > > (This patch will be a part of a much large series in the future).
> > > 
> > > 
> > >  kernel/rcu/tree.c | 150 +++++++++++++++++++++++++++++++---------------
> > >  1 file changed, 103 insertions(+), 47 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 744d04d8b7724..2e0eaec929059 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3104,11 +3104,95 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > >  		spin_unlock_irqrestore(&krcp->lock, flags);
> > >  }
> > >  
> > > +static inline struct kfree_rcu_cpu *krc_this_cpu_lock(bool irqs_disabled)
> > > +{
> > > +	struct kfree_rcu_cpu *krcp;
> > > +
> > > +	// For safely calling this_cpu_ptr().
> > > +	if (!irqs_disabled)
> > > +		local_irq_disable();
> > 
> > Again, local_irq_save() is the usual approach here.  And local_irq_restore()
> > in krc_this_cpu_unlock() below.
> > 
> We discussed that with Joel and i also think that keeping previous
> variant of the krc_this_cpu_lock()/krc_this_cpu_unlock() is better
> and what is more important is easy, i.e. we do not really need to
> understand whether IRQs are disabled or not, instead just save flags
> and restore and that is it.

Sounds good, if we are avoiding any possiblity of direct-reclaim, then that
removes the need for dropping the lock and thus removes the chance of
migrations that I was concerned about.

> > > +	krcp = this_cpu_ptr(&krc);
> > > +	if (likely(krcp->initialized))
> > > +		spin_lock(&krcp->lock);
> > > +
> > > +	return krcp;
> > > +}
> > > +
> > > +static inline void
> > > +krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, bool irqs_disabled)
> > > +{
> > > +	if (likely(krcp->initialized))
> > > +		spin_unlock(&krcp->lock);
> > > +
> > > +	if (!irqs_disabled)
> > > +		local_irq_enable();
> > > +}
> > > +
> > > +// alloc_object_locked - Try to allocate an object of size while dropping the lock.
> > > +//
> > > +// @size: Size of the object to internally allocate for kfree_rcu().
> > > +// @slab: Do we allocate on slab or using buddy.
> > > +// @can_sleep: Was kfree_rcu() called in sleepable context?
> > > +// @krcp: The pointer to krcp. Needed if when relocking, we got migrated.
> > > +//
> > > +// Caveats:
> > > +//
> > > +// 1. Per-cpu krc's lock must be held with interrupts disabled.
> > > +//
> > > +// 2. Failure to allocate returns NULL and does not cause a warning.
> > > +//
> > > +// 3. Caller is responsible for using the correct free() APIs. If size == PAGE_SIZE,
> > > +//    then free_page() should be called for freeing. Otherwise kfree().
> > > +//
> > > +static inline void *alloc_object_locked(size_t size, bool slab, bool can_sleep,
> > > +					struct kfree_rcu_cpu **krcpp)
> > > +{
> > > +	void *ptr;
> > > +	gfp_t gfp_flags, wmark_flags, reclaim_flags;
> > > +	struct kfree_rcu_cpu *krcp = *krcpp;
> > > +
> > > +	WARN_ON_ONCE(size == PAGE_SIZE && slab);
> > > +
> > > +	// Decompose the flags:
> > > +	// wmark_flags   - affect the watermark to control reserve access.
> > > +	// reclaim_flags - these effect how reclaim works but would
> > > +	//                 have no-affect in atomic or nowait context.
> > > +	wmark_flags = (__GFP_HIGH | __GFP_ATOMIC);
> > > +	reclaim_flags = (__GFP_RETRY_MAYFAIL);
> > 
> > You have a __GFP_RETRY_MAYFAIL here, which is good.  However, if
> > this CPU has quite a few 4K blocks of memory already allocated for
> > kfree_rcu(), at some point __GFP_NORETRY becomes necessary.  Again,
> > single-argument kfree_rcu() has the option of invoking synchronize_rcu()
> > and most other memory allocators do not.  And double-argument kfree_rcu()
> > has a pre-allocated rcu_head in the structure that it can fall back on.
> > 
> > So let's please not get too memory-greedy here!
> > 
> As i see, your point is to use "light" allocations flags which will
> not initiate direct reclaim, OOM, I/O waiting and so on. Please correct
> me if i miss something.

I agree. One thing I want to add is any allocation however small has an
effect either directly or indirectly, but I agree trying too hard may further
avoid another unrelated needy user getting the memory they may need.

> > Note also that most systems will normally invoke an RCU callback on the
> > same CPU that registered it.  This allows easy maintenance of an
> > emergency cache for these situations.
> > 
> I have a patch that specifies number of pages to be cached, but i will
> send out it later when we sort things like that out.

Sounds good. I am assuming that you are going to make it such that there are
2 pages per-cpu by default which can be used for either vfree or kfree
arrays and further caching being made user-configurable. But either way
looking forward to the patch.

> > Exceptions include systems doing frequent CPU-hotplug operations and
> > rcu_nocbs CPUs.

Per my understanding, the CPU hotplug has an effect on migrating callbacks so
that's why CPU hotplug has an effect of not invoking callbacks on the same
CPU that they were queued on, but please let me know if my understanding is
not correct.

> > > +
> > > +	// These flags will be common to all allocations, whether we want to
> > > +	// wait or sleep or reclaim will be controlled with additional flags
> > > +	// later during the actual allocation.
> > > +	gfp_flags = (wmark_flags | reclaim_flags | __GFP_NOWARN);
> > > +
> > > +	// First, do an allocation without waiting.
> > > +	ptr = (size == PAGE_SIZE) ? (void *)__get_free_page(gfp_flags | GFP_NOWAIT)
> > > +				  : (void *)kmalloc(size, gfp_flags | GFP_NOWAIT);
> > > +	// If we cannot sleep, we are done.
> > > +	if (ptr || !can_sleep)
> > > +		return ptr;
> > > +
> > > +	// Now try to do it with more relaxed flags, we may enter direct-reclaim.
> > > +	//
> > > +	// IRQs were not enabled since can_sleep == true. So there's no need to
> > > +	// save/restore flags.
> > > +	krc_this_cpu_unlock(krcp, false);
> > > +	ptr = (size == PAGE_SIZE) ? (void *)__get_free_page(gfp_flags | GFP_KERNEL)
> > > +				  : (void *)kmalloc(size, gfp_flags | GFP_KERNEL);
> > 
> > Dropping the possibility of small allocations also simplifies this code,
> > and also simplifies a fair amount of code elsewhere.
> > 
> I have a question about dynamic attaching of the rcu_head. Do you think
> that we should drop it? We have it because of it requires 8 + syzeof(struct rcu_head)
> bytes and is used when we can not allocate 1 page what is much more for array purpose.
> Therefore, dynamic attaching can succeed because of using SLAB and requesting much
> less memory then one page. There will be higher chance of bypassing synchronize_rcu()
> and inlining freeing on a stack.
> 
> I agree that we should not use GFP_* flags instead we could go with GFP_NOWAIT |
> __GFP_NOWARN when head attaching only. Also dropping GFP_ATOMIC to keep
> atomic reserved memory for others.

I also have same question. Just to add here, previous patches added a warning
to synchronize_rcu(). Should that warning be dropped then if it is more
normal for kfree_rcu() to enter the synchronous path when the user had not
passed in an rcu_head?

> > >  			if (head == NULL)
> > > -				goto inline_return;
> > > -
> > > -			/* Take it back. */
> > > -			krcp = krc_this_cpu_lock(&flags);
> > > +				goto unlock_return;
> > >  
> > >  			/*
> > >  			 * Tag the headless object. Such objects have a back-pointer
> > > @@ -3280,9 +3337,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  	}
> > >  
> > >  unlock_return:
> > > -	krc_this_cpu_unlock(krcp, flags);
> > > +	krc_this_cpu_unlock(krcp, irqs_disabled);
> > >  
> > > -inline_return:
> > >  	/*
> > >  	 * High memory pressure, so inline kvfree() after
> > >  	 * synchronize_rcu(). We can do it from might_sleep()
> > > -- 
> > > 2.26.0.110.g2183baf09c-goog
> 
> I know Joel will also write some comments because we has discussed it
> via IRC. The idea is to find common view, and do it
> as best as we can :)
> 
> Thanks Paul for good comments!

Thanks a lot for all the comments to both of you :)

 - Joel

