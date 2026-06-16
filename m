Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537B44BCBE;
	Tue, 16 Jun 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630676; cv=none; b=UQQo3tM4f7zgQwdfi+ovtFXyJbSCInwo3rIHXZIvRj8MOWqbAKTqPICwRLLkeiJ4slt93F/L+ZYvuGRrcIPiQpu4zNZighUfse2yeGVBKNYeYwi1d5+BzLANSG/WSSxXdaZ+TxGHs8YElu830Imoy+3u5kbep6mHbr2pFkVKqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630676; c=relaxed/simple;
	bh=mIB9fwDXoE3FvVEjATxzUqiC3mhFpssbEWgD32OsNU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUU742gOUsK6ECb70NeFX0neJ5UyotyNJiGwrIY+0C58GwIXDxsGnYtBNIbv2+N55JxRXEfU5DE/4BhvKJno6hTJrv1ANvrR/iPDtFN1r9knXXP3u6h6lkpxjoLaXMFsVIPTInkn2ja2XDuIOCq35C6Q/b3u254mG6MR0AaT+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcrdmCKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcrdmCKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C131F00A3A;
	Tue, 16 Jun 2026 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781630675;
	bh=5rZHvUYAFFezct1JmztPZchYNztAliiGoPJ37fwtMSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VcrdmCKDG348Ke2lDsy2UqK00o1do3UWIjsrQ/MslTqIzvLcsQyKthAP/HbhczEni
	 Edg6r0anV/gtHzlj3y8mYx4mQ3urRDoiuPmfcW3A6ErnbUHo52nmtIM8nCOW0QdT/4
	 +MbnpBZq7dD8xeHa3DbGzWe/svWvNWIRFZE3rROWW7VCV/uBURMaRUjhhiGtUi5DgO
	 Sp9LJWbJ5vsE9DXhtnv8yCXSZYI3a6GZeYsXb6kU1Fmi+2dV9ANkaTvjqCJnnfz7PN
	 bCzrMMO+NjuagZLpAWDHc9gzXMOMLqlngiJPHb8rLu5lTZTTearUx2+GPAAI/IpPcl
	 lJC/2OvRStrvA==
Message-ID: <f3a56a5a-f10b-46dc-bc99-28449ade1661@kernel.org>
Date: Tue, 16 Jun 2026 19:24:27 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 6/9] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-6-70a54f3775bb@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260615-kfree_rcu_nolock-v3-6-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 13:06, Harry Yoo (Oracle) wrote:
> As suggested by Vlastimil Babka, kfree_rcu_sheaf() can be used
> on PREEMPT_RT if we always assume spinning is not allowed on PREEMPT_RT.
> This is because local_trylock and spinlock_t are safe to use with
> trylock variant as long as the kernel does not spin and the context is
> not NMI and not hardirq.
> 
> Now that __kfree_rcu_sheaf() knows how to handle allow_spin = false,
> relax the limitation and try the sheaves path on PREEMPT_RT as well.
> 
> Keep the lockdep map on non RT kernels. However, do not use the lockdep
> map on PREEMPT_RT to avoid suppressing valid lockdep warnings.
> 
> Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org
> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>

LGTM, but maybe unnecessary pessimistic wrt call_rcu() on PREEMPT_RT?
I thought (in the Link: above) we'd only need to downgrade allow_spin to
false on PREEMPT_RT for handling sheaves movement from/to barn and
alloc_empty_sheaf(), but call_rcu() would be safe from kfree_rcu() even on
RT? Or is the irqs_disabled() condition rare enough so we don't care?

> ---
>  mm/slab_common.c | 11 +++++++++--
>  mm/slub.c        | 17 ++++++++++-------
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 55546b8385ff..807924a94fb0 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1595,6 +1595,13 @@ static bool kfree_rcu_sheaf(void *obj)
>  {
>  	struct kmem_cache *s;
>  	struct slab *slab;
> +	bool allow_spin;
> +
> +	/*
> +	 * It is not safe to spin on PREEMPT_RT because the kernel might be
> +	 * holding a raw spinlock and slab acquires sleeping locks.
> +	 */
> +	allow_spin = !IS_ENABLED(CONFIG_PREEMPT_RT);
>  
>  	if (is_vmalloc_addr(obj))
>  		return false;
> @@ -1605,7 +1612,7 @@ static bool kfree_rcu_sheaf(void *obj)
>  
>  	s = slab->slab_cache;
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
> -		return __kfree_rcu_sheaf(s, obj, /* allow_spin = */ true);
> +		return __kfree_rcu_sheaf(s, obj, allow_spin);
>  
>  	return false;
>  }
> @@ -1954,7 +1961,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	if (!head)
>  		might_sleep();
>  
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
> +	if (kfree_rcu_sheaf(ptr))
>  		return;
>  
>  	// Queue the object but don't yet schedule the batch.
> diff --git a/mm/slub.c b/mm/slub.c
> index ba593c1c53d5..4850629774b2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6082,12 +6082,13 @@ static void rcu_free_sheaf(struct rcu_head *head)
>   * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
>   * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMPT_RT),
>   * this would violate lock nesting rules. Therefore, kvfree_call_rcu() avoids
> - * this problem by bypassing the sheaves layer entirely on PREEMPT_RT.
> + * this problem by passing allow_spin = false on PREEMPT_RT.
>   *
>   * However, lockdep still complains that it is invalid to acquire spinlock_t
>   * while holding raw_spinlock_t, even on !PREEMPT_RT where spinlock_t is a
>   * spinning lock. Tell lockdep that acquiring spinlock_t is valid here
> - * by temporarily raising the wait-type to LD_WAIT_CONFIG.
> + * by temporarily raising the wait-type to LD_WAIT_CONFIG. Skip the lockdep map
> + * on PREEMPT_RT to avoid suppressing valid lockdep warnings.
>   */
>  static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
>  
> @@ -6096,10 +6097,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *rcu_sheaf;
>  
> -	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
> -		return false;
> +	VM_WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT) && allow_spin);
>  
> -	lock_map_acquire_try(&kfree_rcu_sheaf_map);
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		lock_map_acquire_try(&kfree_rcu_sheaf_map);
>  
>  	if (!local_trylock(&s->cpu_sheaves->lock))
>  		goto fail;
> @@ -6199,12 +6200,14 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>  	local_unlock(&s->cpu_sheaves->lock);
>  
>  	stat(s, FREE_RCU_SHEAF);
> -	lock_map_release(&kfree_rcu_sheaf_map);
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		lock_map_release(&kfree_rcu_sheaf_map);
>  	return true;
>  
>  fail:
>  	stat(s, FREE_RCU_SHEAF_FAIL);
> -	lock_map_release(&kfree_rcu_sheaf_map);
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		lock_map_release(&kfree_rcu_sheaf_map);
>  	return false;
>  }
>  
> 

