Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C09372041;
	Tue, 12 May 2026 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588730; cv=none; b=cqtKfd2cy6FkIBjR7051L+8bi2lM4p1tDYX+0nKhW9JshSS3PAfNlCC8Wawaq8nAqQa7beKuGHqAt+7/OWladaI/H5uk2zt2R+GfWnrKT1O/DVL04i2Xj77jYeKr2DSPXyRdFwrKw0VCEBetyABDQPFVpwjGReExPX6v/pBmksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588730; c=relaxed/simple;
	bh=0RXUz7YJtUgH3NHoplRgNBgOPpNfBk69RhQj1tBwiL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HZPkBw7KzSUiL+7fCfrFyz/Ievc0CbTEcJxmNrav1zvZlKHQZF24hgjrvN5LsX+OzA527XLBD98ND5D4lJGsLxWBtRa9mWB8Z9dLifSldxV2870lAZFICbY2LxlivXNAiA+9TouDHDO3sR9W+/QNKj6Agjcoo2PHKV9jsdqmsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNXZ9iwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNXZ9iwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EE0C2BCB0;
	Tue, 12 May 2026 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778588729;
	bh=0RXUz7YJtUgH3NHoplRgNBgOPpNfBk69RhQj1tBwiL4=;
	h=Date:From:To:Cc:Subject:From;
	b=SNXZ9iwYKiRfJE0ZYpee+yMlFOprVutfjh3JfVHjpSN6YsYT6CwOAARrZbKwHOxsM
	 YAjBEQ1pyiz2Duweujpa1G36NwoK/P+MPTtybLDyKz3DTbFbEuM7+GpWUFf1QAa3vQ
	 AOVFx7IX96tBjIfthl6CQPow3LsR+HAJwXifA14886jwba26Bjkr9EjQtVRIFuCZSQ
	 h1acq5r9QCVvvrklFeTye1cFxB4fvBbyug+NpzxhTTl42gRztcUSo8Zrt02h0nutfa
	 WxT1/qGB/vF4hpT8roaTmEwLpAXoj9jnoba73s6uLu6csgAvT/KrJNbyT0W5nq+Eja
	 ZlY6nplvEguFw==
Date: Tue, 12 May 2026 21:25:27 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: linux-mm@kvack.org, rcu@vger.kernel.org, bpf@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
Message-ID: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everybody. This is a follow-up discussion of
"kmalloc_nolock() follow-ups, including kfree_rcu_nolock()" topic at
LSFMMBPF 2026 last week. Unfortunately, many RCU folks were not there,
but we can still discuss over email ;)

The slides: https://docs.google.com/presentation/d/1kpaLd7D1dwRvIqRwQfSjJVVJL0CC2gwb-AV56yCMqXw/edit?usp=sharing

I'm copying the slides here to make it easier to reply.

kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
=========================================================

Today's goal
============

1. Present why and what we're doing
2. Demystify BPF's requirements for memory allocation
3. Discuss solutions

Motivation
==========

BPF map preallocation wastes memory for correctness
- preallocate all elements by default, unless opted out explicitly
  (BPF_F_NO_PREALLOC)
- Typically not all elements are used, wasting memory

The BPF memory allocator was invented to avoid that
- Allocate elements on demand at BPF runtime
- kmalloc isn't safe in some BPF contexts (in NMI, or in a critical
  section), so a new allocator was invented

Challenges with the BPF memory allocator
- Memory is tied to the BPF subsystem and can't be used elsewhere
- A burst of allocations can cause failures until async refill catches up
- Trade-off between memory waste and allocation failures at large sizes
- Reinventing every memory allocator feature is a maintenance burden

The end goal
============

- Drop the BPF memory allocator
- Avoid preallocation as much as possible in BPF
- Use kmalloc_nolock() and kfree_{,rcu_}nolock() (and friends) instead

To achieve that, we need to define requirements & expectations from BPF

Background - RCU and BPF programs
=================================

- Non-sleepable BPF progs run in an RCU critical section
- Sleepable BPF progs run in an RCU Tasks Trace critical section
- Freeing by RCU for both non-sleepable (RCU) and sleepable
  (RCU-tt) progs means we need to wait both GPs before releasing memory
- RCU Tasks Trace (RCU-tt) is an RCU flavor designed for sleepable
  BPF progs, lighter than SRCU
- Since v7.0, RCU Tasks Trace is implemented using SRCU-fast
- Since v7.1-rc1, RCU Tasks Trace GP is contractually guaranteed to
  imply an RCU GP
  - Yes, that means waiting for an SRCU-fast GP automatically covers RCU
    readers

Background - BPF memory lifetime
================================

Objects allocated for BPF may be referenced by either 1) non-sleepable
or 2) sleepable BPF programs, or both

Memory allocated for BPF may be:
1. Freed immediately <- This is supported today via kfree_nolock()
2. Freed immediately, but can be recycled with typesafety-by-rcu
   semantics (for both RCU, RCU-tt)
  - bpf_mem{,_cache}_free()
3. Freed after RCU GP
  - sleepable progs not allowed
4. Freed after RCU GP + RCU-tt GP
  - sleepable progs allowed
  - bpf_mem{,_cache}_free_rcu()

If you need something not listed here, please let us know!

The big picture (today, within the BPF memory allocator)
========================================================

- bpf_mem{,_cache}_free()
- Analogous to SLAB_TYPESAFE_BY_RCU, but for BPF
- Insert objects to free_llist or free_llist_extra
- When high watermark is hit, move objects to free_by_rcu_ttrace
  and then return objects to slab after RCU-tt GP
- However, they can be reused before returned to slab (again,
  analogous to SLAB_TYPESAFE_BY_RCU)
- bpf_mem{,_cache}_free_rcu()
- Analogous to kfree_rcu(), but for BPF
- Objects are inserted to free_by_rcu
- Moved to waiting_for_gp list, then wait for RCU GP
- Moved to waiting_for_gp_ttrace list, then wait for RCU-tt GP,
  then returned to slab
- Objects remain intact for RCU GP and RCU-tt GP

The big picture (today, outside the BPF memory allocator)
=========================================================

- This slide is intentionally left blank :)

The big picture (in the future - with kmalloc_nolock() follow-ups)
==================================================================

Let's drop the BPF memory allocator completely!

Case A: Free immediately
- Cache: existing kmalloc-<size> family
- Alloc: kmalloc_nolock() -> alloc_pages_nolock()
- Free immediately: kfree_nolock() -> free_pages_nolock()

Case B: Non-sleepable readers only, free by RCU
- Cache: existing kmalloc-<size> family
- Alloc: kmalloc_nolock() -> alloc_pages_nolock()
- Free by RCU: kfree_rcu_nolock(obj, rf) -> call_rcu_nolock()

Case C: Both sleepable and non-sleepable readers, with free by RCU
- Cache: existing kmalloc-<size> family
- Alloc: kmalloc_nolock()
- Free by RCU: kfree_srcu_fast_nolock() -> call_srcu_fast_nolock()

Case D: Both sleepable and non-sleepable readers*, with typesafety-
by-rcu semantics
- Cache: a fixed-size kmem_cache with SLAB_TYPESAFE_BY_SRCU_FAST
- Slab freeing deferred until SRCU-fast GP but objects can be
  reused (analogous to SLAB_TYPESAFE_BY_RCU)
- Alloc: kmem_cache_alloc_nolock()
- Free immediately: kmem_cache_free_nolock() ->
  call_srcu_fast_nolock() (to free slabs)
- Need slab dtor support to release resources when freeing slabs
  after SRCU-fast GP

Unlike kmalloc_nolock(), "try the next bucket" trick doesn't work.
Instead, create two caches: one for normal allocations, the other for
fallback. Free objects with kfree_nolock() without passing the cache
pointer.

*Even when only non-sleepable readers are allowed, you can still
use this!

Progress since last year
========================

- alloc_pages_nolock() / free_pages_nolock() merged in v6.15
- kmalloc_nolock() / kfree_nolock() merged in v6.18
- RCU Tasks Trace re-implemented on top of SRCU-fast in v7.0
- Transition to SRCU-fast was not smooth, ended up fixing bugs
- RCU Tasks Trace GP now explicitly implies RCU GP
- implicit since SRCU-fast was introduced in v6.15
- explicit contractual guarantee in v7.1-rc1

Things to do
============

- Define clear requirements/expectations from BPF (for memory allocation)
- Introduce kfree_rcu_nolock() (in RFC)
- Introduce kfree_srcu_fast_nolock()
- Add SLAB_TYPESAFE_BY_SRCU_FAST support
  - Need slab destructor support to clean up when freeing slabs
  - Need call_srcu_fast_nolock() to submit free slabs to RCU
- Migrate remaining bpf_mem_alloc users to kmalloc_nolock()
- Introduce call_rcu_nolock() and call_srcu_fast_nolock()
- Allow kmalloc_nolock() with large kmalloc sizes via
  alloc_pages_nolock()

-- 
Cheers,
Harry / Hyeonggon
