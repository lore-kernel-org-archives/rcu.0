Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6ABC4361B
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7164A23A7B
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 15:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgLHPRn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgLHPRm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 10:17:42 -0500
Date:   Tue, 8 Dec 2020 07:17:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607440622;
        bh=sOLjfmSGv043E0EIO2v/kyNGWMFwowAWFXBL4rHV5+E=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J0hqZIybRD8nsLlo6SyS+sxhHTME3EdkR3yS30bFB/hjaFOdkY0fnYbs+8eD7pfw9
         0RyJ206yalOzLE91/FFPtn5Rdnmub0PxRJPEjuvqo57OvYaDt0YLdR2mOaapag3Q1x
         /xIRIlOgKf83Pqs5N4eshpTxtNAKiAsAG3KMqwuAQ2nUjw7hWRO2NiFzGpJxbpvW4K
         rzEPflRo/8JXHy5jEU7xsI2kU4GJP+kskBnHH8eL8ca7KS1drHWvArUAvE4V4KxdjB
         X21V1+9Os7inbE2n1nriWZomt0J6jbA/oX151eJRvRIFsbMVrlKfUh58l3CgtpWrKx
         jDsLHt/slWN/Q==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH sl-b 1/6] mm: Add kmem_last_alloc() to return last
 allocation for memory block
Message-ID: <20201208151701.GR2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
 <20201205004057.32199-1-paulmck@kernel.org>
 <20201207090243.GA20765@js1304-desktop>
 <20201207172554.GI2657@paulmck-ThinkPad-P72>
 <20201208085653.GA26940@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208085653.GA26940@js1304-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 05:57:07PM +0900, Joonsoo Kim wrote:
> On Mon, Dec 07, 2020 at 09:25:54AM -0800, Paul E. McKenney wrote:
> > On Mon, Dec 07, 2020 at 06:02:53PM +0900, Joonsoo Kim wrote:
> > > Hello, Paul.
> > > 
> > > On Fri, Dec 04, 2020 at 04:40:52PM -0800, paulmck@kernel.org wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > There are kernel facilities such as per-CPU reference counts that give
> > > > error messages in generic handlers or callbacks, whose messages are
> > > > unenlightening.  In the case of per-CPU reference-count underflow, this
> > > > is not a problem when creating a new use of this facility because in that
> > > > case the bug is almost certainly in the code implementing that new use.
> > > > However, trouble arises when deploying across many systems, which might
> > > > exercise corner cases that were not seen during development and testing.
> > > > Here, it would be really nice to get some kind of hint as to which of
> > > > several uses the underflow was caused by.
> > > > 
> > > > This commit therefore exposes a new kmem_last_alloc() function that
> > > > takes a pointer to dynamically allocated memory and returns the return
> > > > address of the call that allocated it.  This pointer can reference the
> > > > middle of the block as well as the beginning of the block, as needed
> > > > by things like RCU callback functions and timer handlers that might not
> > > > know where the beginning of the memory block is.  These functions and
> > > > handlers can use the return value from kmem_last_alloc() to give the
> > > > kernel hacker a better hint as to where the problem might lie.
> > > 
> > > I agree with exposing allocation caller information to the other
> > > subsystem to help the debugging. Some suggestions...
> > 
> > Good to hear!  ;-)
> > 
> > > 1. It's better to separate a slab object check (validity check) and
> > > retrieving the allocation caller. Someone else would want to check
> > > only a validity. And, it doesn't depend on the debug configuration so
> > > it's not good to bind it to the debug function.
> > > 
> > > kmem_cache_valid_(obj|ptr)
> > > kmalloc_valid_(obj|ptr)
> > 
> > Here both functions would say "true" for a pointer from kmalloc()?
> > Or do I need to add a third function that is happy with a pointer from
> > either source?
> 
> I focused on separation and missed this case that the user sometimes
> cannot know the object source (kmalloc/kmem_cache). At first step,
> just checking whether it is a slab-object or not looks enough.
> 
> int kmem_valid_obj()

OK, I will update my current kmalloc_valid_obj() to kmem_valid_obj(),
thank you!

> > I do understand that people who don't want to distinguish could just do
> > "kmem_cache_valid_ptr(p) || kmalloc_valid_ptr(p)".  However, the two
> > use cases in the series have no idea whether the pointer they have came
> > from kmalloc(), kmem_cache_alloc(), or somewhere else entirely, even an
> > on-stack variable.
> > 
> > Are you asking me to choose between the _obj() and _ptr() suffixes?
> 
> Yes, I prefer _obj().

Then _obj() it is.

> > If not, please help me understand the distinction.
> > 
> > Do we want "debug" in these names as well?
> 
> I don't think so since it can be called without enabling the debug
> option.

OK, understood.

> > > 2. rename kmem_last_alloc to ...
> > > 
> > > int kmem_cache_debug_alloc_caller(cache, obj, &ret_addr)
> > > int kmalloc_debug_alloc_caller(obj, &ret_addr)
> > > 
> > > or debug_kmem_cache_alloc_caller()
> > > 
> > > I think that function name need to include the keyword 'debug' to show
> > > itself as a debugging facility (enabled at the debugging). And, return
> > > errno and get caller address by pointer argument.
> > 
> > I am quite happy to add the "debug", but my use cases have no idea
> > how the pointer was allocated.  In fact, the next version of the
> > patch will also handle allocator return addresses from vmalloc().
> > 
> > And for kernels without sufficient debug enabled, I need to provide
> > the name of the slab cache, and this also is to be in the next version.
> 
> Okay. So, your code would be...
> 
> if (kmem_valid_obj(ptr))
>         kmalloc_debug_print_provenance(ptr)
> else if (vmalloc_valid_obj(ptr))
>         ....

Suggestions on where to put the mem_dump_obj() or whatever name that
executes this code?  Left to myself, I will pick a likely on the theory
that it can always be moved later.

This structuring does cause double work, but this should be OK because
all of the uses I know of are on error paths.

> > > 3. If concrete error message is needed, please introduce more functions.
> > > 
> > > void *kmalloc_debug_error(errno)
> > 
> > Agreed, in fact, I was planning to have a function that printed out
> > a suitable error-message continuation to the console for ease-of-use
> > reasons.  For example, why is the caller deciding how deep the stack
> > frame is?  ;-)
> > 
> > So something like this?
> > 
> > 	void kmalloc_debug_print_provenance(void *ptr);
> > 
> > With the understanding that it will print something helpful regardless
> > of where ptr came from, within the constraints of the kernel build and
> > boot options?
> 
> Looks good idea. I suggest a name, kmem_dump_obj(), for this function.
> In this case, I don't think that "debug" keyword is needed since it shows
> something useful (slab cache info) even if debug option isn't enabled.
> 
> So, for summary, we need to introduce two functions to accomplish your
> purpose. Please correct me if wrong.
> 
> int kmem_valid_obj(ptr)
> void kmem_dump_obj(ptr)

Within slab, agreed.

We course also need something like mem_dump_obj() to handle a pointer
with unknown provenance, along with the vmalloc_valid_obj() and the
vmalloc_dump_obj().  And similar functions should other allocation
sources become important.

							Thanx, Paul
