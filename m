Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2D6C4361B
	for <rcu@archiver.kernel.org>; Mon,  7 Dec 2020 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F91B2388D
	for <rcu@archiver.kernel.org>; Mon,  7 Dec 2020 17:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgLGR0g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Dec 2020 12:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbgLGR0f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Dec 2020 12:26:35 -0500
Date:   Mon, 7 Dec 2020 09:25:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607361954;
        bh=MvigeOv8X2+zbBiSp5HvaHTZ1AYV0CKZmlIA0TtvYP0=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TFwxeKeIxbtEYbTmvzZMJ1u+228sbnax/DCW3h+tKxoxPHY1aGfv5+P+2nZjmgNqi
         UxMjjgvOUnaDdprbgp9FHoHgcEwtDGH5XA1ErCk06fxNfDJIxJ8nbBLrqu5SLr9wd+
         tVnXIrTuwSKFcQrBVm/qzeh1RfFE9fanl7qd66aKU4bv5rPY1RdhF7/pgd/SEY6Yoh
         PMbtrePRqfxzzzLD5cPqYs9SJV01m8lvtSWROFaYv025h+FeuYkxKDPr1Ez9owtcLC
         kSdY4HS8MSgpXF02mFkBN3uGIvJbgk6FByNq9RKQc1oHWgx+KF41vu1rgvDd+Twjmc
         Pycfm7HroXmuA==
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
Message-ID: <20201207172554.GI2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
 <20201205004057.32199-1-paulmck@kernel.org>
 <20201207090243.GA20765@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207090243.GA20765@js1304-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Dec 07, 2020 at 06:02:53PM +0900, Joonsoo Kim wrote:
> Hello, Paul.
> 
> On Fri, Dec 04, 2020 at 04:40:52PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > There are kernel facilities such as per-CPU reference counts that give
> > error messages in generic handlers or callbacks, whose messages are
> > unenlightening.  In the case of per-CPU reference-count underflow, this
> > is not a problem when creating a new use of this facility because in that
> > case the bug is almost certainly in the code implementing that new use.
> > However, trouble arises when deploying across many systems, which might
> > exercise corner cases that were not seen during development and testing.
> > Here, it would be really nice to get some kind of hint as to which of
> > several uses the underflow was caused by.
> > 
> > This commit therefore exposes a new kmem_last_alloc() function that
> > takes a pointer to dynamically allocated memory and returns the return
> > address of the call that allocated it.  This pointer can reference the
> > middle of the block as well as the beginning of the block, as needed
> > by things like RCU callback functions and timer handlers that might not
> > know where the beginning of the memory block is.  These functions and
> > handlers can use the return value from kmem_last_alloc() to give the
> > kernel hacker a better hint as to where the problem might lie.
> 
> I agree with exposing allocation caller information to the other
> subsystem to help the debugging. Some suggestions...

Good to hear!  ;-)

> 1. It's better to separate a slab object check (validity check) and
> retrieving the allocation caller. Someone else would want to check
> only a validity. And, it doesn't depend on the debug configuration so
> it's not good to bind it to the debug function.
> 
> kmem_cache_valid_(obj|ptr)
> kmalloc_valid_(obj|ptr)

Here both functions would say "true" for a pointer from kmalloc()?
Or do I need to add a third function that is happy with a pointer from
either source?

I do understand that people who don't want to distinguish could just do
"kmem_cache_valid_ptr(p) || kmalloc_valid_ptr(p)".  However, the two
use cases in the series have no idea whether the pointer they have came
from kmalloc(), kmem_cache_alloc(), or somewhere else entirely, even an
on-stack variable.

Are you asking me to choose between the _obj() and _ptr() suffixes?
If not, please help me understand the distinction.

Do we want "debug" in these names as well?

> 2. rename kmem_last_alloc to ...
> 
> int kmem_cache_debug_alloc_caller(cache, obj, &ret_addr)
> int kmalloc_debug_alloc_caller(obj, &ret_addr)
> 
> or debug_kmem_cache_alloc_caller()
> 
> I think that function name need to include the keyword 'debug' to show
> itself as a debugging facility (enabled at the debugging). And, return
> errno and get caller address by pointer argument.

I am quite happy to add the "debug", but my use cases have no idea
how the pointer was allocated.  In fact, the next version of the
patch will also handle allocator return addresses from vmalloc().

And for kernels without sufficient debug enabled, I need to provide
the name of the slab cache, and this also is to be in the next version.

> 3. If concrete error message is needed, please introduce more functions.
> 
> void *kmalloc_debug_error(errno)

Agreed, in fact, I was planning to have a function that printed out
a suitable error-message continuation to the console for ease-of-use
reasons.  For example, why is the caller deciding how deep the stack
frame is?  ;-)

So something like this?

	void kmalloc_debug_print_provenance(void *ptr);

With the understanding that it will print something helpful regardless
of where ptr came from, within the constraints of the kernel build and
boot options?

							Thanx, Paul
