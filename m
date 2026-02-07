Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499831ACEDF;
	Sat,  7 Feb 2026 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770423407; cv=none; b=bYuxkPCxxoBlzvadRCmiOK9MTr5c0jSdWRKcveGt4ZQSFXNItsledgFQ4Ca45RCKeuCIOlFWoy4G+4hUpxwgE5bZGPKD6E5gP9cvxrwKwl53kd2A+UXD/is2iCroRId8RIodewQay1vdT87YaIrPggteK5anHU5tuv1JmUuHWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770423407; c=relaxed/simple;
	bh=cmHcOieE29bkmKS4OIrRotVZKXlaKd4m1k0Q6/r1ulo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmVwz2pSHmoZqB6oy7IjRPHqrwjfKlNcirPk795STXIAqvDzzFM1vFhtC1dbpRHWUS/bZaLYPXod7CjkFI+dIoXIFlxK/m2RtCkgpJKQSK6KWP+CtTP+BPcMDfvT63nELuxCEAVhfYTsHCFHoHE3gHaMnCWD2DfbwcTl2NqvK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ8QBU3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ8QBU3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69A9C116C6;
	Sat,  7 Feb 2026 00:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770423406;
	bh=cmHcOieE29bkmKS4OIrRotVZKXlaKd4m1k0Q6/r1ulo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WJ8QBU3gAvqXiJztkXogHR7//XU6ECPlbV7aQWFk+TWGS2vbvP5MpnlyXlu0PjbfG
	 JsTV1sG4Fu2/789HI+xuWRG8WEu3rzIHeONZc6A7+TqxM6S9p3eeG2UijE1vSap2Kx
	 VrZXn6iH7vFAyT9cMavRBSkLwd/kk6GHO6/uj8sPQ32xLxEeHMIidELEzVnBtJeiQf
	 Q8iRuqD/x8BsFqjqqIIPyrtlx+cCmUqxegKJlCxhh4Qdr0NYbiLD7n35cvhV5P6fck
	 FuCI+dMSmtoNTZ4YpeDOcP6KaaMhwLnNEHXvVUx8rPnmkQREjTF//zot0M9ZtrRbqI
	 iW/zKYHKsn12g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6D37ACE0F9F; Fri,  6 Feb 2026 16:16:46 -0800 (PST)
Date: Fri, 6 Feb 2026 16:16:46 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] k[v]free_rcu() improvements
Message-ID: <3069e76d-5c7a-4c3f-9b83-43ed1700b95f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260206093410.160622-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206093410.160622-1-harry.yoo@oracle.com>

On Fri, Feb 06, 2026 at 06:34:03PM +0900, Harry Yoo wrote:
> These are a few improvements for k[v]free_rcu() API, which were suggested
> by Alexei Starovoitov.
> 
> [ To kmemleak folks: I'm going to teach delete_object_full() and
>   paint_ptr() to ignore cases when the object does not exist.
>   Could you please let me know if the way it's done in patch 3
>   looks good? Only part 2 is relevant to you. ]

On what commit should I apply this series?  I get conflicts on top of -rcu
(no surprise there) and build errors on top of next-20260205.

							Thanx, Paul

> Although I've put some effort into providing a decent quality
> implementation, I'd like you to consider this as a proof-of-concept
> and let's discuss how best we could tackle those problems:
> 
>   1) Allow an 8-byte field to be used as an alternative to
>      struct rcu_head (16-byte) for 2-argument kvfree_rcu()
>   2) kmalloc_nolock() -> kfree[_rcu]() support
>   3) Add kfree_rcu_nolock() for NMI context
> 
> # Part 1. Allow an 8-byte field to be used as an alternative to
>   struct rcu_head for 2-argument kvfree_rcu()
>   
>   Technically, objects that are freed with k[v]free_rcu() need
>   only one pointer to link objects, because we already know that
>   the callback function is always kvfree(). For this purpose,
>   struct rcu_head is unnecessarily large (16 bytes on 64-bit).
> 
>   Allow a smaller, 8-byte field (of struct rcu_ptr type) to be used
>   with k[v]free_rcu(). Let's save one pointer per slab object.
>   
>   I have to admit that my naming skill isn't great; hopefully
>   we'll come up with a better name than `struct rcu_ptr`.
> 
>   With this feature, either a struct rcu_ptr or rcu_head field
>   can be used as the second argument of the k[v]free_rcu() API.
> 
>   Users that only use k[v]free_rcu() are highly encouraged to use
>   struct rcu_ptr; otherwise you're wasting memory. However, some users,
>   such as maple tree, may use call_rcu() or k[v]free_rcu() depending on
>   the situation for objects of the same type. For such users,
>   struct rcu_head remains the only option.
> 
>   Patch 1 implements this feature, and patch 2 adds a few users in mm/.
> 
> # Part 2. kmalloc_nolock() -> kfree() or kfree_rcu() path support
>   
>   Allow objects allocated with kmalloc_nolock() to be freed with
>   kfree[_rcu](). Without this support, users are forced to call
>   call_rcu() with kfree_nolock() to free objects after a grace period.
>   This is not efficient and can create unnecessarily many grace periods
>   by bypassing the kfree_rcu batching layer.
> 
>   The reason why it was not supported before was because some alloc
>   hooks are not called in kmalloc_nolock(), while all free hooks are
>   called in kfree().
> 
>   Patch 3 adds support for this by teaching kmemleak to ignore cases
>   when free hooks are called without prior alloc hooks. Patch 4 frees
>   a bit in enum objexts_flags, since we no longer have to remember
>   whether the array was allocated using kmalloc_nolock() or kmalloc().
> 
>   Note that the free hooks fall into these categories:
> 
>   - Its alloc hook is called in kmalloc_nolock(), no problem!
>     (kmsan_slab_alloc(), kasan_slab_alloc(),
>      memcg_slab_post_alloc_hook(), alloc_tagging_slab_alloc_hook())
> 
>   - Its alloc hook isn't called in kmalloc_nolock(); free hooks
>     must handle asymmetric hook calls. (kfence_free(),
>     kmemleak_free_recursive())
> 
>   - There is no matching alloc hook for the free hook; it's safe to
>     call. (debug_check_no_{locks,obj}_freed, __kcsan_check_access())
> 
>   Note that kmalloc() -> kfree_nolock() or kfree_rcu_nolock() isn't
>   still supported! That's much trickier :)
> 
> # Part 3. Add kfree_rcu_nolock() for NMI context
> 
>   Add a new 2-argument kfree_rcu_nolock() variant that is safe to be
>   called in NMI context. In NMI context, calling kfree_rcu() or
>   call_rcu() is not legal, and thus users are forced to implement some
>   sort of deferred freeing. Let's make users' lives easier with the new
>   variant.
> 
>   Note that 1-argument kfree_rcu_nolock() is not supported, since there
>   is not much we can do when trylock & memory allocation fails.
>   (You can't call synchronize_rcu() in NMI context!)
> 
>   When spinning on a lock is not allowed, try to acquire the spinlock.
>   When it succeeds in acquiring the lock, do either:
> 
>   1) Use the rcu sheaf to free the object. Note that call_rcu() cannot
>      be called in NMI context! When the rcu sheaf becomes full by
>      freeing the object, it cannot free to the sheaf and has to fall back.
>   
>   2) Use struct rcu_ptr field to link objects. Consuming a bnode
>      (of struct kvfree_rcu_bulk_data) and queueing work to maintain
>      a number of cached bnodes is avoided in NMI context.
> 
>   Note that scheduling delayed monitor work to drain objects after
>   KFREE_DRAIN_JIFFIES is done using a lazy irq_work to avoid raising
>   self-IPIs. That means scheduling delayed monitor work can be delayed
>   up to the length of a time slice.
> 
>   In rare cases where trylock fails, a non-lazy irq_work is used to
>   defer calling kvfree_rcu_call().
> 
>   When certain debug features (kmemleak, debugobjects) are enabled,
>   freeing in NMI context is always deferred because they use spinlocks.
> 
>   Patch 6 implements kfree_rcu_nolock() support, patch 7 adds sheaves
>   support for the new API.
> 
> Harry Yoo (7):
>   mm/slab: introduce k[v]free_rcu() with struct rcu_ptr
>   mm: use rcu_ptr instead of rcu_head
>   mm/slab: allow freeing kmalloc_nolock()'d objects using kfree[_rcu]()
>   mm/slab: free a bit in enum objexts_flags
>   mm/slab: move kfree_rcu_cpu[_work] definitions
>   mm/slab: introduce kfree_rcu_nolock()
>   mm/slab: make kfree_rcu_nolock() work with sheaves
> 
>  include/linux/list_lru.h   |   2 +-
>  include/linux/memcontrol.h |   3 +-
>  include/linux/rcupdate.h   |  68 +++++---
>  include/linux/shrinker.h   |   2 +-
>  include/linux/types.h      |   9 ++
>  mm/kmemleak.c              |  11 +-
>  mm/slab.h                  |   2 +-
>  mm/slab_common.c           | 309 +++++++++++++++++++++++++------------
>  mm/slub.c                  |  47 ++++--
>  mm/vmalloc.c               |   4 +-
>  10 files changed, 310 insertions(+), 147 deletions(-)
> 
> -- 
> 2.43.0
> 
