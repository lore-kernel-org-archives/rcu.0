Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27DC2E0;
	Wed, 23 Jul 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288779; cv=none; b=Vib424tbrdITzh2gRn4mLPngIZEHgDrBnf0UOiHIAUOi4U+7deRclNjDHGrBvGiAFyy7TAIjysCr48PdCIfbGHWpmwyMMZNiiu0COc6N7vcbpfEbgk6rf2BMwt8cgGxm0bB6xjocpTbwdbpHYXNnfJBS96IHH9JF8QUoikNkKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288779; c=relaxed/simple;
	bh=aDyxC3W2rvQATRR7l4FI3WjA8cRNUQ+GIeoRZM/gTmI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5bNkfVgv31vwH8uy0igKqd1rC3Jp6qqmTty8+Ym9MYt4DuAq3zCl18DIEOoBcw4ALtdVLPX76TmsGJB4OFszqfl6ouw0SxeUpiqXA3X5XR7f8fF5wsWxIIftIlFZhB5isR8gH3ovbmCfJtyRSJk3lufS750qTqPY5eoVpw3B6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnmYcpf/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnmYcpf/"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so47828e87.0;
        Wed, 23 Jul 2025 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753288775; x=1753893575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iy6jNmLi0JGKHOOGtS88CNydGBMknaXlFXJUCshIh+g=;
        b=FnmYcpf/5ZFa0n7dzWUD4ZqzE1wXfmyI3mS4eXHSdSt4GMP5noxjSFTf5uus2R3h/n
         u/KsQ2ZjiV+PrTtDyBizU0MQAHZkNKKLQ4DH4el+uuJ5sAuf6jz7HrZAfO9w4QTvavtQ
         tA3KldnvFhUSy9kBsv7WnaTmLZKtmLEwfzwzRFkLyxY4otqNBCP80e6P8qO6PszzLB3R
         Hp7YE2bTzaHiuIsej2Q8XdRwMUCjo783HjHU+jYldjcQBF7i9AR8CJIujsCcVt5+XEhM
         c4kXcCQ70pktZ+mr7DM72GCgUaggDV+8QhDl9yvyNIob4V6WHIDuU0yCelLOv8cHWDFJ
         TJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288775; x=1753893575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy6jNmLi0JGKHOOGtS88CNydGBMknaXlFXJUCshIh+g=;
        b=uC5R1Q84ir3iBhbbOy9ChY3Jm47gn6QjT3OuPyYdWBzdEjfJ4cAetattPLUcyYXrE5
         HRsrylgVIIRdKa1eA6b7CdS0xwy50OVDIY0waasBScu14kRLvE6YQPXb5YGz+HEJmolD
         uy/jcQlbMDqW3IQnQcCXaTbUUXbHPcmABehbpNZsaLgknlrMyywoW0ghvUz9bDPiU6X4
         3mBr+1koeGw6z62vlu2d65x6+k/ZYRbDKkTwPv3jZ7n7EWxVe9dWho67kwFENViFbAIl
         Bvy5HS1yAzF1hpw4C7OPQRyMqqua+XZZBSyk1qxKBoDlYiiBksQEu8bZG2QydaDaq5WP
         lC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGjYRlSiTgs9oeLr9ZlAaKZDxEDHzXXMWAMXSxRAcNQhd+Fz72/+HMKln/4miF1nMNwL/6@vger.kernel.org, AJvYcCXz7ItKoeBIB+eS8XhUpLBdfDFPNmNvHhPaYESCeZzFrReoHwf0fcIkcHPopdPYWaRBJe/YpOwf5XO5YVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHOCNhVgjn7fbxzJY230pw04k5BGNnxD7mhitifbwLb7aGIl8
	Wo15LzzlDpwsQ98B1kK3hufsCOSRqnX3vMC7j/IHbAAtgjk+c9+XglmA
X-Gm-Gg: ASbGnctBmfnS/mhbvi3j8stoi+i5SrHyrGQHAPcI3tC/nGhBnmXvTBfhPh/WAN/HFpA
	LtrQ4kV2enhY9ooUToFTDyPhb8b0J5XGyymSN2QAmTmOqwHcOutNJ3US7mgwWTkARyjjr7XiXLU
	3gieyss8dlTJDiz5XFIroGgM+3j6IACqezpu96g0p+9KTE4UtPal5uaLx1wRxIbZNd6QTnpg4f5
	mgX/Uzb4EWIJLo0OcWoz5HgcclZDY/mrSrB4Az12vTO9k9CHEITJH4W5qYct7MIfBFarSRCfm2R
	arzOmS4udO+OuD7VUzuYZJcYtjKdqr+hUzIJkUtkl13tOg2fLCQ8c0Gidvfx06cjXdTrdntrTQD
	G2hf4CS9WllqNA13zvstlWf8piU+w+kP0Td6n6rRClpdiH5IdtQ==
X-Google-Smtp-Source: AGHT+IEgFsYIaDXXpqqSqg+UF+6+ocCr6tbdAt8s4+lhPV4mEf+DdO3yWqJnpAxEIZYMblVLFLudNw==
X-Received: by 2002:a05:6512:239c:b0:55a:2735:fe6a with SMTP id 2adb3069b0e04-55a5126993emr1340990e87.0.1753288774791;
        Wed, 23 Jul 2025 09:39:34 -0700 (PDT)
Received: from pc636 (host-95-203-21-188.mobileonline.telia.com. [95.203.21.188])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d9fb6bsm2379029e87.167.2025.07.23.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:39:34 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 23 Jul 2025 18:39:31 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v5 02/14] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <aIEQQ0MW5e8KMvVL@pc636>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-2-b792cd830f5d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-slub-percpu-caches-v5-2-b792cd830f5d@suse.cz>

On Wed, Jul 23, 2025 at 03:34:35PM +0200, Vlastimil Babka wrote:
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
>  mm/slub.c        | 193 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 214 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 1980330c2fcb4a4613a7e4f7efc78b349993fd89..44c9b70eaabbd87c06fb39b79dfb791d515acbde 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -459,6 +459,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
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
>
I have a question here. kfree_rcu_sheaf(ptr) tries to revert freeing
an object over one more newly introduced path. This patch adds infra
for such purpose whereas we already have a main path over which we
free memory.

Why do not we use existing logic? As i see you can do:

   if (unlikely(!slab_free_hook(s, p[i], init, true))) {
        p[i] = p[--sheaf->size];
        continue;
   }

in the kfree_rcu_work() function where we process all ready to free objects.
I mean, for slab objects we can replace kfree_bulk() and scan all pointers
and free them over slab_free_hook().

Also we do use a pooled API and other improvements to speed up freeing.

Thanks!

--
Uladzislau Rezki
