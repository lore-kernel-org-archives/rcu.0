Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886111E1E00;
	Mon,  8 Sep 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332765; cv=none; b=Jzj5BiO28bOP63prJvk3KK0vL19Bf2PAGBWcAozIMsimCePwRZzngoUsfJMDoM0/G08zcIXy375Zr6kkZp0K70ZXZwGe6UaxAJnpf68xJGsRweD13OgCya5+W3RXMnmh+2xnLXJMkbnVvhCAjwLdfMMn6mup3mYpUuuyLKkeAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332765; c=relaxed/simple;
	bh=6KDVunLZEQN245aj/DeSzbQcPt12yUcZjgd1fbE7BfA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sndeNS2M43F4jqZh6KvgLQ5+L24PASW4tBhOkeEklpopCiNJ/+HeU3XxuzZ2VyUCW/2OSrbq19sQLQ398+ymMYvqv/D7qlnT8bONb4gxeWQjLaYqvebADMBHGcK4oqipI1xn7CE+rLAP+v3F2SYz6ILp2JjJ4oAG6kk6ykptg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHO03kCP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHO03kCP"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5608d792558so4847494e87.0;
        Mon, 08 Sep 2025 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757332761; x=1757937561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vd0Gp91t0AdkDLXSNmOHCDstZWivpuuewHLUyrk+zgI=;
        b=KHO03kCPZv4Jo3AX+bfEMlY5wp7tVDcPlNqXFqwnRjCRXlp3KqW7nBiPQJfHgYp/8j
         iZCj0A7QaqOvCHNBrO4oo2v+Gq8i6d2QS7cZ/YAsHx7rf8FANZ+XKFIPKm/fSLi6/q03
         I2NapSfL1J0SQKlq8TE3+VD7wT3HLql/55DX6MKW6YrqWRYAQrsV522D1NfOCjXc2Kd+
         DDoTC5MfMC5LWjEMZ2NOq6/QA2lUobxLiJWMO30qu01ro1vg0b/uXPQEe42ziTIIPCRk
         BrfFNT26imkXQZ6l/wfSIHsL6n1OONUk5jbb3hKI+gax+uDvBAcNhse9dRtPupfHGrZm
         rqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757332761; x=1757937561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd0Gp91t0AdkDLXSNmOHCDstZWivpuuewHLUyrk+zgI=;
        b=vsJdOIP7XsI8AIwL2S1eNjNDdlGVkVI1xx+lL1OcHSI28xPCTJaNWzaGcy8+0vCOmg
         lDhbgGTFLoQTU7qCDvCMyoshEawcn4o2lZQxxaHebZSsH7DZ5LgdXGdNwf3rvHaCAbht
         T1HHqK1B4xMLC4VhNLax8o7RRYMINrWz7CmqlVxxPd9LT2/KcBtRPMIwWjgG4s0Wq3z0
         kKGBEjbTpu6BXGvkwhhfQosbCX7BA5FSoVpOUXqWG2FEqFT3Ay+fAAOvF6LILuOmaBK4
         DPsl0mThlssM3HNQM6NBYq7zm9KpdDVnom7lPfSuHp/BIBOj0pcNreGnLK+NruZs7WS5
         iXug==
X-Forwarded-Encrypted: i=1; AJvYcCUdzNv7mTIu5mbajczQJ8zP/K88a+OgwFPmJBqKcxp36uv1J8ZRQu6b04LLvXlGxkAG6RPK@vger.kernel.org, AJvYcCVYVbBWOcnmqsbf8tY1OIBh27EfA8VisRevQVvjy4KG+VkrVmWQ0SLQRyJIgpd3pPclddmOs0q3cQz7NQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpbcYnJXeJjlpttn24ZrACdrZRYs8gZAC5yPCk7s/FjVbtHjF
	n9+TL/vUqrtxUJTlapJ5jq23H5+5GTahMLSht1dAsZAxIMPzN4yxUmox
X-Gm-Gg: ASbGncs2V/UTrPs2fHLUWr17VMiEI415LhsIRGV5jEt5lWAead377TSbVAKW/xDtBjs
	iP7QG35QlpCEx9dojJnOwY9YkaWU3Nqj385RoRVlEpNhLY/SMrTqNvXcABfLgtcRTrhjn/43pPI
	v8G1wvkBdSkEJbYeNOfpzfh3MfscpZpoSxY0yYgGzYui4aRaBeVMDJ7JKcMctMKn8X9KuAMpSjA
	vHuwIdjpNcY8Hiq6R9zJNc+3vswReicY1BU+dbAjEzxwXN3IjeYOZE4RrA5nqvSVkzFkAjQRKQs
	2bgHOr7mejCPjVBK7WAQYSsi/k1XyQU5W/iBY4F2D2M5c1yWVrqV8BphKJb1VvNAiK02dJCU/gZ
	b5vzPizBoPWSVzGkWcWQkLvf9jG5E
X-Google-Smtp-Source: AGHT+IFbG7GoBt4KHwMsY4mmFph5x9B/J+LW0gLY0cDeVIB+7WdkZBbrf+Q5LzBnwB9+VTjigDATyQ==
X-Received: by 2002:a05:6512:b89:b0:55f:4e62:f0ca with SMTP id 2adb3069b0e04-56260e427bfmr2110773e87.29.1757332761024;
        Mon, 08 Sep 2025 04:59:21 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9c71sm3518718e87.73.2025.09.08.04.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:59:20 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Mon, 8 Sep 2025 13:59:18 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v7 04/21] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <aL7FFpIMmXtzzSL1@pc638.lan>
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
 <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>

On Wed, Sep 03, 2025 at 02:59:46PM +0200, Vlastimil Babka wrote:
> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> addition to main and spare sheaves.
> 
> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> the sheaf is detached and submitted to call_rcu() with a handler that
> will try to put it in the barn, or flush to slab pages using bulk free,
> when the barn is full. Then a new empty sheaf must be obtained to put
> more objects there.
> 
> It's possible that no free sheaves are available to use for a new
> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> kfree_rcu() implementation.
> 
> Expected advantages:
> - batching the kfree_rcu() operations, that could eventually replace the
>   existing batching
> - sheaves can be reused for allocations via barn instead of being
>   flushed to slabs, which is more efficient
>   - this includes cases where only some cpus are allowed to process rcu
>     callbacks (Android)
> 
> Possible disadvantage:
> - objects might be waiting for more than their grace period (it is
>   determined by the last object freed into the sheaf), increasing memory
>   usage - but the existing batching does that too.
> 
> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> implementation favors smaller memory footprint over performance.
> 
> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
> count how many kfree_rcu() used the rcu_free sheaf successfully and how
> many had to fall back to the existing implementation.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h        |   2 +
>  mm/slab_common.c |  24 +++++++
>  mm/slub.c        | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 216 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 206987ce44a4d053ebe3b5e50784d2dd23822cd1..f1866f2d9b211bb0d7f24644b80ef4b50a7c3d24 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -435,6 +435,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>  }
>  
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
>  			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e2b197e47866c30acdbd1fee4159f262a751c5a7..2d806e02568532a1000fd3912db6978e945dcfa8 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1608,6 +1608,27 @@ static void kfree_rcu_work(struct work_struct *work)
>  		kvfree_rcu_list(head);
>  }
>  
> +static bool kfree_rcu_sheaf(void *obj)
> +{
> +	struct kmem_cache *s;
> +	struct folio *folio;
> +	struct slab *slab;
> +
> +	if (is_vmalloc_addr(obj))
> +		return false;
> +
> +	folio = virt_to_folio(obj);
> +	if (unlikely(!folio_test_slab(folio)))
> +		return false;
> +
> +	slab = folio_slab(folio);
> +	s = slab->slab_cache;
> +	if (s->cpu_sheaves)
> +		return __kfree_rcu_sheaf(s, obj);
> +
> +	return false;
> +}
> +
>  static bool
>  need_offload_krc(struct kfree_rcu_cpu *krcp)
>  {
> @@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	if (!head)
>  		might_sleep();
>  
> +	if (kfree_rcu_sheaf(ptr))
> +		return;
> +
Uh.. I have some concerns about this.

This patch introduces a new path which is a collision to the
existing kvfree_rcu() logic. It implements some batching which
we already have.

- kvfree_rcu_barrier() does not know about "sheaf" path. Am i missing
  something? How do you guarantee that kvfree_rcu_barrier() flushes
  sheafs? If it is part of kvfree_rcu() it has to care about this.

- we do not allocate in kvfree_rcu() path because of PREEMMPT_RT, i.e.
  kvfree_rcu() is supposed it can be called from the non-sleeping contexts.
- call_rcu() can be slow, therefore we do not use it in the kvfree_rcu().

IMO, it is worth to reuse existing logic in the kvfree_rcu(). I can help
with it when i have more cycles as part of my RCU work.

--
Uladzislau Rezki
