Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F46524F
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737722884; cv=none; b=s6GSlo+GD0r2QIFLapm/mz8jgx6vWjenrePz8ymopS1oINXAIdl+1qnb8DvYjOpxSzztqqKQTwwr/i3v8h9IcUugPleY3skqEcRBQhqGiSCYI3NJUrfssmcHiQ9815HQR95RXOxU2moCgOU8cxBWs7XxvrTq9IrZMqBbvGqXxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737722884; c=relaxed/simple;
	bh=zKNm+4G3DcbYBG1x6VxPCQAUeJrs0nOfEYdTJ70LSlM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1kHnoh9BTGN/J+fguCIZiujHjGCm+bCILXGSX7XOGcJ8KcQeWOHwqdWZtgXXGKvd33TMwu/Lz6MvXBxrOexDBXd2JTfaB7iFd6dJd1VaBCzup/9wKubAUCpJHJq05sAjHNUHms9F3HMiZrHibnupy7uQlhwY7JHg5hUbkUUgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4qqfY4p; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4qqfY4p"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5439b0dd4bfso1635616e87.0
        for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737722880; x=1738327680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4BzrtAZUmYmJhcFIblC4VJWVTxNvUlbeOqI5x0bXKmI=;
        b=f4qqfY4pGQgzIdyauhzI26cjtfFqmkXByRPMqxk99DTW7h5T0fe17KmTi+cassyF5C
         7WqRJGdE+NfYwEEjwMOaJH8yRJRlCFP457NINfVlR2Nnyezxw0e+iQvvXGLYkl0KHvfN
         OElfqdP8i49HKBBiBcJLchcVIeYtbm0/ENuORolDESiQVb3jeUXqVqRZhXcHDGxFiKhX
         HVL5Za67VDeQCZoi/Zu9x0sNZA0bQbPiYs5C4RvPcr6woCZQtsm/8bg6X9uojIP6oZ+K
         v/UIHOlAgYw4ISELiy9QVWhqEldVTkh1F0lSSO3qP34DAKX5nxpEG9Hw3zeor3F8s3OU
         G+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737722880; x=1738327680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BzrtAZUmYmJhcFIblC4VJWVTxNvUlbeOqI5x0bXKmI=;
        b=RANUCzKzi0dkkQip7x19r7g9HhUuGfeYuRd1NzFp4/obJRM6yjSpYCtaJIhO3PCK7s
         /INb3uz8ABOCPNrbZDs1EwSz37xIYyHwuUJu3kTA40xR8wBjAK6x6/qS8+Nix5XKD2Dj
         Og8Mgy4LhG53PBY2c+mR+LRj3xTiNbFr6eAD+n5aKRJFB6ieQlyfA366hlYshdhXhtn3
         u5Q+3+uvpttrvfBzjcgZNMJO/Nghwo4py6GE37nTXCe9Q/AL5Y+PV9ehilyPT+X/IdXe
         PkyvpfY0gE08tGqEdQhcNvNyEt3JeMnZxpozrWscEENLYY4s6i+vkajWEieAbk7lTkLr
         +acg==
X-Forwarded-Encrypted: i=1; AJvYcCUanKl3xgSG6wXGI4pCgD2GE4k8HHclMUY27Lf5fZAd9uHehea34gJ0jbQtZwTxzdn9dOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPXiH6cJqcnVefE4ORX5GPvM2jl4QN8m15Bn+QiZTc6v49LJv
	94+xcOATz4jHu68/q8a/M/oeGIZa22jEq9wB2UjgEQ12QOOlXuy8
X-Gm-Gg: ASbGncugUrklRdlZbjI4GY/gp5z4Apeg9sTElc4MFihcMTTQsdWkvkifWAV26xVKHQs
	MyfazVaTW2eJbnd3REM0KGKHL1Mz6whr0keAFQTBTFbdpC+1oHe5Cs3kv4Z0AyKH/+IlQaVZO98
	Yvr3lfmh1cfmRA9OstVpRStJHGvEvfXWghL5BJO4FkA6jicmS5kRnbZoLPwoN5tSWbemcmruLnm
	x+ovFWUkZLBymwNBwUFnOo9f6d98XJ7psiagEDvbkf3UGgRl9iJilExODyjYb6+4CKK05nzl9fr
	vPax5zD41ofkcWLkFLU7NAF7PicvqWPCmNM=
X-Google-Smtp-Source: AGHT+IHfDCKln2WQAdqNwoqpNnunQ0kWDLLio3VptmybfPuU4j38QgVw6I8QCrCL2FcPVriNtBeZnA==
X-Received: by 2002:ac2:520b:0:b0:542:98bb:566f with SMTP id 2adb3069b0e04-5439c287e74mr8146119e87.52.1737722879720;
        Fri, 24 Jan 2025 04:47:59 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c822f827sm288753e87.71.2025.01.24.04.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:47:59 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 24 Jan 2025 13:47:56 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] rcu, slab: use a regular callback function for
 kvfree_rcu
Message-ID: <Z5OL_OeL8olMaeml@pc636>
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
 <20250123-slub-tiny-kfree_rcu-v1-3-0e386ef1541a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-slub-tiny-kfree_rcu-v1-3-0e386ef1541a@suse.cz>

On Thu, Jan 23, 2025 at 11:37:20AM +0100, Vlastimil Babka wrote:
> RCU has been special-casing callback function pointers that are integers
> lower than 4096 as offsets of rcu_head for kvfree() instead. The tree
> RCU implementation no longer does that as the batched kvfree_rcu() is
> not a simple call_rcu(). The tiny RCU still does, and the plan is also
> to make tree RCU use call_rcu() for SLUB_TINY configurations.
> 
> Instead of teaching tree RCU again to special case the offsets, let's
> remove the special casing completely. Since there's no SLOB anymore, it
> is possible to create a callback function that can take a pointer to a
> middle of slab object with unknown offset and determine the object's
> pointer before freeing it, so implement that as kvfree_rcu_cb().
> 
> Large kmalloc and vmalloc allocations are handled simply by aligning
> down to page size. For that we retain the requirement that the offset is
> smaller than 4096. But we can remove __is_kvfree_rcu_offset() completely
> and instead just opencode the condition in the BUILD_BUG_ON() check.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/rcupdate.h | 24 +++++++++---------------
>  kernel/rcu/tiny.c        | 13 -------------
>  mm/slab.h                |  2 ++
>  mm/slab_common.c         |  5 +----
>  mm/slub.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 54 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 3f70d1c8144426f40553c8c589f07097ece8a706..7ff16a70ca1c0fb1012c4118388f60687c5e5b3f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1025,12 +1025,6 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  #define RCU_POINTER_INITIALIZER(p, v) \
>  		.p = RCU_INITIALIZER(v)
>  
> -/*
> - * Does the specified offset indicate that the corresponding rcu_head
> - * structure can be handled by kvfree_rcu()?
> - */
> -#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
> -
>  /**
>   * kfree_rcu() - kfree an object after a grace period.
>   * @ptr: pointer to kfree for double-argument invocations.
> @@ -1041,11 +1035,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   * when they are used in a kernel module, that module must invoke the
>   * high-latency rcu_barrier() function at module-unload time.
>   *
> - * The kfree_rcu() function handles this issue.  Rather than encoding a
> - * function address in the embedded rcu_head structure, kfree_rcu() instead
> - * encodes the offset of the rcu_head structure within the base structure.
> - * Because the functions are not allowed in the low-order 4096 bytes of
> - * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
> + * The kfree_rcu() function handles this issue. In order to have a universal
> + * callback function handling different offsets of rcu_head, the callback needs
> + * to determine the starting address of the freed object, which can be a large
> + * kmalloc of vmalloc allocation. To allow simply aligning the pointer down to
> + * page boundary for those, only offsets up to 4095 bytes can be accommodated.
>   * If the offset is larger than 4095 bytes, a compile-time error will
>   * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
>   * either fall back to use of call_rcu() or rearrange the structure to
> @@ -1091,10 +1085,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr);
>  do {									\
>  	typeof (ptr) ___p = (ptr);					\
>  									\
> -	if (___p) {									\
> -		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
> -		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));			\
> -	}										\
> +	if (___p) {							\
> +		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);	\
> +		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));	\
> +	}								\
>
Why removing the macro? At least __is_kvfree_rcu_offset() makes it
clear what and why + it has a nice comment what it is used for. 4096
looks like hard-coded value.

Or you do not want that someone else started to use that macro in
another places?

>  } while (0)
>  
>  #define kvfree_rcu_arg_1(ptr)					\
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 0ec27093d0e14a4b1060ea08932c4ac13f9b0f26..77e0db0221364376a99ebeb17485650879385a6e 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -88,12 +88,6 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>  	unsigned long offset = (unsigned long)head->func;
>  
>  	rcu_lock_acquire(&rcu_callback_map);
> -	if (__is_kvfree_rcu_offset(offset)) {
> -		trace_rcu_invoke_kvfree_callback("", head, offset);
> -		kvfree((void *)head - offset);
> -		rcu_lock_release(&rcu_callback_map);
> -		return true;
> -	}
>  
>  	trace_rcu_invoke_callback("", head);
>  	f = head->func;
> @@ -159,10 +153,6 @@ void synchronize_rcu(void)
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu);
>  
> -static void tiny_rcu_leak_callback(struct rcu_head *rhp)
> -{
> -}
> -
>  /*
>   * Post an RCU callback to be invoked after the end of an RCU grace
>   * period.  But since we have but one CPU, that would be after any
> @@ -178,9 +168,6 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
>  			mem_dump_obj(head);
>  		}
> -
> -		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
> -			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
>  		return;
>  	}
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index e9fd9bf0bfa65b343a4ae0ecd5b4c2a325b04883..2f01c7317988ce036f0b22807403226a59f0f708 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -604,6 +604,8 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  			    void **p, int objects, struct slabobj_ext *obj_exts);
>  #endif
>  
> +void kvfree_rcu_cb(struct rcu_head *head);
> +
>  size_t __ksize(const void *objp);
>  
>  static inline size_t slab_ksize(const struct kmem_cache *s)
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 330cdd8ebc5380090ee784c58e8ca1d1a52b3758..f13d2c901daf1419993620459fbd5845eecb85f1 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1532,9 +1532,6 @@ kvfree_rcu_list(struct rcu_head *head)
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_kvfree_callback("slab", head, offset);
>  
> -		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> -			kvfree(ptr);
> -
This is not correct unless i miss something. Why do you remove this?

>  
> diff --git a/mm/slub.c b/mm/slub.c
> index c2151c9fee228d121a9cbcc220c3ae054769dacf..651381bf05566e88de8493e0550f121d23b757a1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -19,6 +19,7 @@
>  #include <linux/bitops.h>
>  #include <linux/slab.h>
>  #include "slab.h"
> +#include <linux/vmalloc.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/kasan.h>
> @@ -4732,6 +4733,47 @@ static void free_large_kmalloc(struct folio *folio, void *object)
>  	folio_put(folio);
>  }
>  
> +void kvfree_rcu_cb(struct rcu_head *head)
> +{
> +	void *obj = head;
> +	struct folio *folio;
> +	struct slab *slab;
> +	struct kmem_cache *s;
> +	void *slab_addr;
> +
> +	if (unlikely(is_vmalloc_addr(obj))) {
> +		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
> +		vfree(obj);
> +		return;
> +	}
> +
> +	folio = virt_to_folio(obj);
> +	if (unlikely(!folio_test_slab(folio))) {
> +		/*
> +		 * rcu_head offset can be only less than page size so no need to
> +		 * consider folio order
> +		 */
> +		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
> +		free_large_kmalloc(folio, obj);
> +		return;
> +	}
> +
> +	slab = folio_slab(folio);
> +	s = slab->slab_cache;
> +	slab_addr = folio_address(folio);
> +
> +	if (is_kfence_address(obj)) {
> +		obj = kfence_object_start(obj);
> +	} else {
> +		unsigned int idx = __obj_to_index(s, slab_addr, obj);
> +
> +		obj = slab_addr + s->size * idx;
> +		obj = fixup_red_left(s, obj);
> +	}
> +
> +	slab_free(s, slab, obj, _RET_IP_);
> +}
> +
Tiny computer case. Just small nit, maybe remove unlikely() but you decide :)

--
Uladzislau Rezki
