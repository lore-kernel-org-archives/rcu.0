Received: from mail.kxxt.dev (mail.kxxt.dev [74.48.220.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07D399D05;
	Tue, 12 May 2026 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.48.220.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593946; cv=none; b=X9co16HhRRD19E1B5a/LZjsEwUamKsIWKX0BGYOIKBAWvyj9dltOGk8yy1i80j741ClTC7F1uWEol8KNPBqaSlu9ZAYjxcCnST+pXgolGfCEkWe9BulbJFKCMEBQT1rEAkO0GIlNsUzHd4aYsM+FRA/r1uFWl3ZyT5w8oX0gAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593946; c=relaxed/simple;
	bh=Y9KiNztu39SmYDMANFhoiNmRYPRtr+nQoBOZIYrXhwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrPPb3F8usDe0kbjn+4OF0QmFUhDtq0G2wU+nj1txyDnnm/Oi8uPsQp+JREtXzwdXI7PWZhX9TipEcI7pxFm8P6LpQjorD4NGla5qNxEpEFz6NKI7luRH9b01Z1NdQIhPh9+ezKsJ5inQ8ZCRLx7FEHy5aBHzDlV5TXfalh4P88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev; spf=pass smtp.mailfrom=kxxt.dev; dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b=qlRlYsyW; arc=none smtp.client-ip=74.48.220.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b="qlRlYsyW"
Message-ID: <9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kxxt.dev; s=mail;
	t=1778593602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXtVRnAFzPBTdFnQGRS3LP4/Y+Sm9N9LKspnJjmOSt4=;
	b=qlRlYsyWFI8QLsiI51Y/BH2C33pgPWZ1sLEAW6QmdxJSRCNgWo+vTHV0juVqTWQLbTD4nI
	gPSN0MwZpv2+fa0+FhcMCVDOwD2fFTQ9QVrcZiZLwz3HNLB6M7qnTpBl7rMIpMWcHAwMEz
	20W9pWlZHzTwPNECVaDNRPghLHqiVko=
Date: Tue, 12 May 2026 21:46:33 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
To: "Harry Yoo (Oracle)" <harry@kernel.org>, linux-mm@kvack.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, Uladzislau Rezki
 <urezki@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Amery Hung <ameryhung@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
Content-Language: en-US
From: Levi Zim <i@kxxt.dev>
In-Reply-To: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/26 8:25 PM, Harry Yoo (Oracle) wrote:
> Hello everybody. This is a follow-up discussion of
> "kmalloc_nolock() follow-ups, including kfree_rcu_nolock()" topic at
> LSFMMBPF 2026 last week. Unfortunately, many RCU folks were not there,
> but we can still discuss over email ;)
> 
> The slides: https://docs.google.com/presentation/d/1kpaLd7D1dwRvIqRwQfSjJVVJL0CC2gwb-AV56yCMqXw/edit?usp=sharing
> 
> I'm copying the slides here to make it easier to reply.
> 
> kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
> =========================================================
> 
> Today's goal
> ============
> 
> 1. Present why and what we're doing
> 2. Demystify BPF's requirements for memory allocation
> 3. Discuss solutions
> 
> Motivation
> ==========
> 
> BPF map preallocation wastes memory for correctness
> - preallocate all elements by default, unless opted out explicitly
>   (BPF_F_NO_PREALLOC)
> - Typically not all elements are used, wasting memory
> 
> The BPF memory allocator was invented to avoid that
> - Allocate elements on demand at BPF runtime
> - kmalloc isn't safe in some BPF contexts (in NMI, or in a critical
>   section), so a new allocator was invented
> 
> Challenges with the BPF memory allocator
> - Memory is tied to the BPF subsystem and can't be used elsewhere
> - A burst of allocations can cause failures until async refill catches up
> - Trade-off between memory waste and allocation failures at large sizes
> - Reinventing every memory allocator feature is a maintenance burden
> 
> The end goal
> ============
> 
> - Drop the BPF memory allocator
> - Avoid preallocation as much as possible in BPF
> - Use kmalloc_nolock() and kfree_{,rcu_}nolock() (and friends) instead

By using kmalloc_nolock, a regression happens on architectures without HAVE_CMPXCHG_DOUBLE.
For reference, currently only x86, arm64, s390 and loongarch selects HAVE_CMPXCHG_DOUBLE

For example, this has already caused bpf_task_storage_get with flag
BPF_LOCAL_STORAGE_GET_F_CREATE to always fail on riscv64 6.19 kernel.
I attempted to fix it in https://lists.infradead.org/pipermail/linux-riscv/2026-March/087159.html,
but as pointed out in the threads, the approach is not sound.

After that, I thought about using the BPF memory allocator instead of kmalloc_nolock on such
architectures to fix it. But I haven't got time to implement it.

I don't know how could we fix it otherwise after removing BPF memory allocator completely.
Could we find a path to move forward without causing regressions on architectures without HAVE_CMPXCHG_DOUBLE?

Thanks,
Levi

> 
> To achieve that, we need to define requirements & expectations from BPF
> 
> Background - RCU and BPF programs
> =================================
> 
> - Non-sleepable BPF progs run in an RCU critical section
> - Sleepable BPF progs run in an RCU Tasks Trace critical section
> - Freeing by RCU for both non-sleepable (RCU) and sleepable
>   (RCU-tt) progs means we need to wait both GPs before releasing memory
> - RCU Tasks Trace (RCU-tt) is an RCU flavor designed for sleepable
>   BPF progs, lighter than SRCU
> - Since v7.0, RCU Tasks Trace is implemented using SRCU-fast
> - Since v7.1-rc1, RCU Tasks Trace GP is contractually guaranteed to
>   imply an RCU GP
>   - Yes, that means waiting for an SRCU-fast GP automatically covers RCU
>     readers
> 
> Background - BPF memory lifetime
> ================================
> 
> Objects allocated for BPF may be referenced by either 1) non-sleepable
> or 2) sleepable BPF programs, or both
> 
> Memory allocated for BPF may be:
> 1. Freed immediately <- This is supported today via kfree_nolock()
> 2. Freed immediately, but can be recycled with typesafety-by-rcu
>    semantics (for both RCU, RCU-tt)
>   - bpf_mem{,_cache}_free()
> 3. Freed after RCU GP
>   - sleepable progs not allowed
> 4. Freed after RCU GP + RCU-tt GP
>   - sleepable progs allowed
>   - bpf_mem{,_cache}_free_rcu()
> 
> If you need something not listed here, please let us know!
> 
> The big picture (today, within the BPF memory allocator)
> ========================================================
> 
> - bpf_mem{,_cache}_free()
> - Analogous to SLAB_TYPESAFE_BY_RCU, but for BPF
> - Insert objects to free_llist or free_llist_extra
> - When high watermark is hit, move objects to free_by_rcu_ttrace
>   and then return objects to slab after RCU-tt GP
> - However, they can be reused before returned to slab (again,
>   analogous to SLAB_TYPESAFE_BY_RCU)
> - bpf_mem{,_cache}_free_rcu()
> - Analogous to kfree_rcu(), but for BPF
> - Objects are inserted to free_by_rcu
> - Moved to waiting_for_gp list, then wait for RCU GP
> - Moved to waiting_for_gp_ttrace list, then wait for RCU-tt GP,
>   then returned to slab
> - Objects remain intact for RCU GP and RCU-tt GP
> 
> The big picture (today, outside the BPF memory allocator)
> =========================================================
> 
> - This slide is intentionally left blank :)
> 
> The big picture (in the future - with kmalloc_nolock() follow-ups)
> ==================================================================
> 
> Let's drop the BPF memory allocator completely!
> 
> Case A: Free immediately
> - Cache: existing kmalloc-<size> family
> - Alloc: kmalloc_nolock() -> alloc_pages_nolock()
> - Free immediately: kfree_nolock() -> free_pages_nolock()
> 
> Case B: Non-sleepable readers only, free by RCU
> - Cache: existing kmalloc-<size> family
> - Alloc: kmalloc_nolock() -> alloc_pages_nolock()
> - Free by RCU: kfree_rcu_nolock(obj, rf) -> call_rcu_nolock()
> 
> Case C: Both sleepable and non-sleepable readers, with free by RCU
> - Cache: existing kmalloc-<size> family
> - Alloc: kmalloc_nolock()
> - Free by RCU: kfree_srcu_fast_nolock() -> call_srcu_fast_nolock()
> 
> Case D: Both sleepable and non-sleepable readers*, with typesafety-
> by-rcu semantics
> - Cache: a fixed-size kmem_cache with SLAB_TYPESAFE_BY_SRCU_FAST
> - Slab freeing deferred until SRCU-fast GP but objects can be
>   reused (analogous to SLAB_TYPESAFE_BY_RCU)
> - Alloc: kmem_cache_alloc_nolock()
> - Free immediately: kmem_cache_free_nolock() ->
>   call_srcu_fast_nolock() (to free slabs)
> - Need slab dtor support to release resources when freeing slabs
>   after SRCU-fast GP
> 
> Unlike kmalloc_nolock(), "try the next bucket" trick doesn't work.
> Instead, create two caches: one for normal allocations, the other for
> fallback. Free objects with kfree_nolock() without passing the cache
> pointer.
> 
> *Even when only non-sleepable readers are allowed, you can still
> use this!
> 
> Progress since last year
> ========================
> 
> - alloc_pages_nolock() / free_pages_nolock() merged in v6.15
> - kmalloc_nolock() / kfree_nolock() merged in v6.18
> - RCU Tasks Trace re-implemented on top of SRCU-fast in v7.0
> - Transition to SRCU-fast was not smooth, ended up fixing bugs
> - RCU Tasks Trace GP now explicitly implies RCU GP
> - implicit since SRCU-fast was introduced in v6.15
> - explicit contractual guarantee in v7.1-rc1
> 
> Things to do
> ============
> 
> - Define clear requirements/expectations from BPF (for memory allocation)
> - Introduce kfree_rcu_nolock() (in RFC)
> - Introduce kfree_srcu_fast_nolock()
> - Add SLAB_TYPESAFE_BY_SRCU_FAST support
>   - Need slab destructor support to clean up when freeing slabs
>   - Need call_srcu_fast_nolock() to submit free slabs to RCU
> - Migrate remaining bpf_mem_alloc users to kmalloc_nolock()
> - Introduce call_rcu_nolock() and call_srcu_fast_nolock()
> - Allow kmalloc_nolock() with large kmalloc sizes via
>   alloc_pages_nolock()
> 

