Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B01F09BF
	for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314721; cv=none; b=kXouHjsVeVdjJaxuBj6qFXs/skQSfHwmksi7PAUsWdi/+QAaFr51v+yBsnDapcnZ78CHAn3HV3Gxx4pVzJTZeOW5TGtYs4E92qRQExUC6kBCCqysQ+Ba8m6RCAScogit38K1EjnHmR6vCfdNuKls9TQEX60sOXv9UzeOVLRq7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314721; c=relaxed/simple;
	bh=UZAyPphX6+e+EOUSpXTWNRqzLaDcGGBRt5mKhOmNzlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNcE1fhrmNDOPJdS6IYFf6MkWKoHqgPLriAfl0adTLc/3bb6bjrwNNV8Rbc/yKXcL+9c0T4euwxCIA+3yco7r4fVQpk+nCsvs9YJuL19RQV3yyla5O9UCk8M2w/zm09KkGj/08NKBIuP3svBnQCzncqYufVGv/8J04x9I/2yEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTvAuZdW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTvAuZdW"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47666573242so83721cf.0
        for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744314716; x=1744919516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KBjO6zGTYidKzjMyt8SgaPN7MYBBC+O9Dx8+faJuQk=;
        b=qTvAuZdW62x+qcFNQSxDsZaPWmANv8WGNDB46yR2b8a/qsnT9vcfNmFD5/ILS8rpA6
         YnjHT1fEp/63MEQ0m6yEZ+4nm5gyhAiXYAmY7GAba8mGdV6oH3P7zeYVaAfLxePCEq82
         eIvmSJ4CBM2J6nuW3QeEnsrh1BoRFtS0RLLz7SyDeR9smeweToz6WtjvLjfL3oaRN1Jv
         v+HnsOBqE7KBo0gXRv0awIH/H8HVnRQxz6x7JUSyUq8fclbjElVetKp2emas5pYIHf/U
         Naat0p3JSeo/CSUfUf8J/hYlHGpjAH8HJ01lEGXBJG6aKQzyltJUj4rvRjjm5WXYuuso
         DXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744314716; x=1744919516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KBjO6zGTYidKzjMyt8SgaPN7MYBBC+O9Dx8+faJuQk=;
        b=lFK2jiOio+HsGVjIWLC13s32O1iJn5PYalGGuqHkzL1Vvlj9eWJu3ThMaOlCwKJl8m
         73XwQluFs1CnPFLIOH11IoqurI2zEDvUPfPWCZtiy4nOws1JMwnuL2CTI6PBKLVf3uY4
         2hLT5OiYZza6ByV/RcZ1yEG6REafi4UK1WxJdceeLfvbDqrcGX+eu0wbxFy51V5wCNdv
         oXKeLDcN79etzEOQh4EyCeaUtrv1HfxA5X4dHXpXtqVE9lahQDAyJj/ZbOiHg66a/YfO
         AJvxU0L3Eudx3BjfvMbHiaPfvCXWxBZnX0gx9NtfJ0wxH/n+d4BHWzNMPBmW4DT3fUBW
         jykQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwRMHGqHjTKR7BUO9FIB12u666IJ66wvJ2YykKYJBYmwjqi7Jqu3htcfDSjy0hZi6ja/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiERiUCVRajxynqJLsIskT9zCrLGMZsyiPNc1/19nxS+JyZP+I
	rHXTjqLox8SmiMkNF1Zv5zdEDSpTu86cWrWOf1fUOcdGgVC5I6+wMGyUdFqjzcpxuxaJXQH6yDD
	uuBM8w5ZoFVYrjBO4ciQoOShvuagSr0s9WHI2
X-Gm-Gg: ASbGncsUnzRuav8ys4S6QFWxq4EnL5f9HgNjiJCYlzmzPMhKR3ydQgdDQvwSqXEMTDP
	QeXzz6ct6E6zt1ph/UqIwd0QhPXS+y3rmWkZuRdCGFeM+9rJlQzJTUqI35Y5AFD02oA3De3vRK+
	lCSWEz5Oo1Yl6BNz8PakDobSxABZPWTNDTYBP+a+kiBz3CABHuJF48
X-Google-Smtp-Source: AGHT+IEmPsG1zM8zgp+EcGFaTfRadxMy1Slcu+1qqqp5kEXyA/zo0m2j/mZfQXQ3Yo3nD9EceAGiL/Yl332pnwhqe30=
X-Received: by 2002:a05:622a:130a:b0:477:871c:2db4 with SMTP id
 d75a77b69052e-4797680041cmr699921cf.5.1744314715610; Thu, 10 Apr 2025
 12:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz> <20250317-slub-percpu-caches-v3-2-9d9884d8b643@suse.cz>
In-Reply-To: <20250317-slub-percpu-caches-v3-2-9d9884d8b643@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Apr 2025 12:51:43 -0700
X-Gm-Features: ATxdqUFLH-KiKgOEeyN4a86X9h6nQyucLQqv37h2nMLWnDGDn7bpLgtIr9YvN0s
Message-ID: <CAJuCfpGNcb=TNQx5YB8EruG_Q61crLHCBJ9daC68r19b+S1fJA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/8] slab: add opt-in caching layer of percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Specifying a non-zero value for a new struct kmem_cache_args field
> sheaf_capacity will setup a caching layer of percpu arrays called
> sheaves of given capacity for the created cache.
>
> Allocations from the cache will allocate via the percpu sheaves (main or
> spare) as long as they have no NUMA node preference. Frees will also
> refill one of the sheaves.
>
> When both percpu sheaves are found empty during an allocation, an empty
> sheaf may be replaced with a full one from the per-node barn. If none
> are available and the allocation is allowed to block, an empty sheaf is
> refilled from slab(s) by an internal bulk alloc operation. When both
> percpu sheaves are full during freeing, the barn can replace a full one
> with an empty one, unless over a full sheaves limit. In that case a
> sheaf is flushed to slab(s) by an internal bulk free operation. Flushing
> sheaves and barns is also wired to the existing cpu flushing and cache
> shrinking operations.
>
> The sheaves do not distinguish NUMA locality of the cached objects. If
> an allocation is requested with kmem_cache_alloc_node() with a specific
> node (not NUMA_NO_NODE), sheaves are bypassed.
>
> The bulk operations exposed to slab users also try to utilize the
> sheaves as long as the necessary (full or empty) sheaves are available
> on the cpu or in the barn. Once depleted, they will fallback to bulk
> alloc/free to slabs directly to avoid double copying.
>
> Sysfs stat counters alloc_cpu_sheaf and free_cpu_sheaf count objects
> allocated or freed using the sheaves. Counters sheaf_refill,
> sheaf_flush_main and sheaf_flush_other count objects filled or flushed
> from or to slab pages, and can be used to assess how effective the
> caching is. The refill and flush operations will also count towards the
> usual alloc_fastpath/slowpath, free_fastpath/slowpath and other
> counters.
>
> Access to the percpu sheaves is protected by localtry_trylock() when
> potential callers include irq context, and localtry_lock() otherwise
> (such as when we already know the gfp flags allow blocking). The trylock
> failures should be rare and we can easily fallback. Each per-NUMA-node
> barn has a spin_lock.
>
> A current limitation is that when slub_debug is enabled for a cache with
> percpu sheaves, the objects in the array are considered as allocated from
> the slub_debug perspective, and the alloc/free debugging hooks occur
> when moving the objects between the array and slab pages. This means
> that e.g. an use-after-free that occurs for an object cached in the
> array is undetected. Collected alloc/free stacktraces might also be less
> useful. This limitation could be changed in the future.
>
> On the other hand, KASAN, kmemcg and other hooks are executed on actual
> allocations and frees by kmem_cache users even if those use the array,
> so their debugging or accounting accuracy should be unaffected.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |   34 ++
>  mm/slab.h            |    2 +
>  mm/slab_common.c     |    5 +-
>  mm/slub.c            | 1029 ++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  4 files changed, 1020 insertions(+), 50 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 7686054dd494cc65def7f58748718e03eb78e481..0e1b25228c77140d05b5b4433=
c9d7923de36ec05 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -332,6 +332,40 @@ struct kmem_cache_args {
>          * %NULL means no constructor.
>          */
>         void (*ctor)(void *);
> +       /**
> +        * @sheaf_capacity: Enable sheaves of given capacity for the cach=
e.
> +        *
> +        * With a non-zero value, allocations from the cache go through c=
aching
> +        * arrays called sheaves. Each cpu has a main sheaf that's always
> +        * present, and a spare sheaf thay may be not present. When both =
become
> +        * empty, there's an attempt to replace an empty sheaf with a ful=
l sheaf
> +        * from the per-node barn.
> +        *
> +        * When no full sheaf is available, and gfp flags allow blocking,=
 a
> +        * sheaf is allocated and filled from slab(s) using bulk allocati=
on.
> +        * Otherwise the allocation falls back to the normal operation
> +        * allocating a single object from a slab.
> +        *
> +        * Analogically when freeing and both percpu sheaves are full, th=
e barn
> +        * may replace it with an empty sheaf, unless it's over capacity.=
 In
> +        * that case a sheaf is bulk freed to slab pages.
> +        *
> +        * The sheaves does not distinguish NUMA placement of objects, so
> +        * allocations via kmem_cache_alloc_node() with a node specified =
other
> +        * than NUMA_NO_NODE will bypass them.
> +        *
> +        * Bulk allocation and free operations also try to use the cpu sh=
eaves
> +        * and barn, but fallback to using slab pages directly.
> +        *
> +        * Limitations: when slub_debug is enabled for the cache, all rel=
evant
> +        * actions (i.e. poisoning, obtaining stacktraces) and checks hap=
pen
> +        * when objects move between sheaves and slab pages, which may re=
sult in
> +        * e.g. not detecting a use-after-free while the object is in the=
 array
> +        * cache, and the stacktraces may be less useful.
> +        *
> +        * %0 means no sheaves will be created
> +        */
> +       unsigned int sheaf_capacity;
>  };
>
>  struct kmem_cache *__kmem_cache_create_args(const char *name,
> diff --git a/mm/slab.h b/mm/slab.h
> index 2f01c7317988ce036f0b22807403226a59f0f708..8daaec53b6ecfc44171191d42=
1adb12e5cba2c58 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -259,6 +259,7 @@ struct kmem_cache {
>  #ifndef CONFIG_SLUB_TINY
>         struct kmem_cache_cpu __percpu *cpu_slab;
>  #endif
> +       struct slub_percpu_sheaves __percpu *cpu_sheaves;
>         /* Used for retrieving partial slabs, etc. */
>         slab_flags_t flags;
>         unsigned long min_partial;
> @@ -272,6 +273,7 @@ struct kmem_cache {
>         /* Number of per cpu partial slabs to keep around */
>         unsigned int cpu_partial_slabs;
>  #endif
> +       unsigned int sheaf_capacity;
>         struct kmem_cache_order_objects oo;
>
>         /* Allocation and freeing of slabs */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 46d0a4cd33b5982fd79c307d572f231fdea9514a..ceeefb287899a82f30ad79b40=
3556001c1860311 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -163,6 +163,9 @@ int slab_unmergeable(struct kmem_cache *s)
>                 return 1;
>  #endif
>
> +       if (s->cpu_sheaves)
> +               return 1;
> +
>         /*
>          * We may have set a slab to be unmergeable during bootstrap.
>          */
> @@ -328,7 +331,7 @@ struct kmem_cache *__kmem_cache_create_args(const cha=
r *name,
>                     object_size - args->usersize < args->useroffset))
>                 args->usersize =3D args->useroffset =3D 0;
>
> -       if (!args->usersize)
> +       if (!args->usersize && !args->sheaf_capacity)
>                 s =3D __kmem_cache_alias(name, object_size, args->align, =
flags,
>                                        args->ctor);
>         if (s)
> diff --git a/mm/slub.c b/mm/slub.c
> index e8273f28656936c05d015c53923f8fe69cd161b2..fa3a6329713a9f45b189f27d4=
b1b334b54589c38 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -346,8 +346,10 @@ static inline void debugfs_slab_add(struct kmem_cach=
e *s) { }
>  #endif
>
>  enum stat_item {
> +       ALLOC_PCS,              /* Allocation from percpu sheaf */
>         ALLOC_FASTPATH,         /* Allocation from cpu slab */
>         ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab *=
/
> +       FREE_PCS,               /* Free to percpu sheaf */
>         FREE_FASTPATH,          /* Free to cpu slab */
>         FREE_SLOWPATH,          /* Freeing not to cpu slab */
>         FREE_FROZEN,            /* Freeing to frozen slab */
> @@ -372,6 +374,12 @@ enum stat_item {
>         CPU_PARTIAL_FREE,       /* Refill cpu partial on free */
>         CPU_PARTIAL_NODE,       /* Refill cpu partial from node partial *=
/
>         CPU_PARTIAL_DRAIN,      /* Drain cpu partial to node partial */
> +       SHEAF_FLUSH_MAIN,       /* Objects flushed from main percpu sheaf=
 */
> +       SHEAF_FLUSH_OTHER,      /* Objects flushed from other sheaves */
> +       SHEAF_REFILL,           /* Objects refilled to a sheaf */
> +       SHEAF_SWAP,             /* Swapping main and spare sheaf */
> +       SHEAF_ALLOC,            /* Allocation of an empty sheaf */
> +       SHEAF_FREE,             /* Freeing of an empty sheaf */
>         NR_SLUB_STAT_ITEMS
>  };
>
> @@ -418,6 +426,33 @@ void stat_add(const struct kmem_cache *s, enum stat_=
item si, int v)
>  #endif
>  }
>
> +#define MAX_FULL_SHEAVES       10
> +#define MAX_EMPTY_SHEAVES      10
> +
> +struct node_barn {
> +       spinlock_t lock;
> +       struct list_head sheaves_full;
> +       struct list_head sheaves_empty;
> +       unsigned int nr_full;
> +       unsigned int nr_empty;
> +};
> +
> +struct slab_sheaf {
> +       union {
> +               struct rcu_head rcu_head;
> +               struct list_head barn_list;
> +       };
> +       unsigned int size;
> +       void *objects[];
> +};
> +
> +struct slub_percpu_sheaves {
> +       localtry_lock_t lock;
> +       struct slab_sheaf *main; /* never NULL when unlocked */
> +       struct slab_sheaf *spare; /* empty or full, may be NULL */
> +       struct node_barn *barn;
> +};
> +
>  /*
>   * The slab lists for all objects.
>   */
> @@ -430,6 +465,7 @@ struct kmem_cache_node {
>         atomic_long_t total_objects;
>         struct list_head full;
>  #endif
> +       struct node_barn *barn;
>  };
>
>  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int=
 node)
> @@ -453,12 +489,19 @@ static inline struct kmem_cache_node *get_node(stru=
ct kmem_cache *s, int node)
>   */
>  static nodemask_t slab_nodes;
>
> -#ifndef CONFIG_SLUB_TINY
>  /*
>   * Workqueue used for flush_cpu_slab().
>   */
>  static struct workqueue_struct *flushwq;
> -#endif
> +
> +struct slub_flush_work {
> +       struct work_struct work;
> +       struct kmem_cache *s;
> +       bool skip;
> +};
> +
> +static DEFINE_MUTEX(flush_lock);
> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
>
>  /********************************************************************
>   *                     Core slab cache functions
> @@ -2410,6 +2453,358 @@ static void *setup_object(struct kmem_cache *s, v=
oid *object)
>         return object;
>  }
>
> +static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t =
gfp)
> +{
> +       struct slab_sheaf *sheaf =3D kzalloc(struct_size(sheaf, objects,
> +                                       s->sheaf_capacity), gfp);
> +
> +       if (unlikely(!sheaf))
> +               return NULL;
> +
> +       stat(s, SHEAF_ALLOC);
> +
> +       return sheaf;
> +}
> +
> +static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sh=
eaf)
> +{
> +       kfree(sheaf);
> +
> +       stat(s, SHEAF_FREE);
> +}
> +
> +static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> +                                  size_t size, void **p);
> +
> +
> +static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
> +                        gfp_t gfp)
> +{
> +       int to_fill =3D s->sheaf_capacity - sheaf->size;
> +       int filled;
> +
> +       if (!to_fill)
> +               return 0;
> +
> +       filled =3D __kmem_cache_alloc_bulk(s, gfp, to_fill,
> +                                        &sheaf->objects[sheaf->size]);
> +
> +       sheaf->size +=3D filled;
> +
> +       stat_add(s, SHEAF_REFILL, filled);
> +
> +       if (filled < to_fill)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +
> +static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t g=
fp)
> +{
> +       struct slab_sheaf *sheaf =3D alloc_empty_sheaf(s, gfp);
> +
> +       if (!sheaf)
> +               return NULL;
> +
> +       if (refill_sheaf(s, sheaf, gfp)) {
> +               free_empty_sheaf(s, sheaf);
> +               return NULL;
> +       }
> +
> +       return sheaf;
> +}
> +
> +/*
> + * Maximum number of objects freed during a single flush of main pcs she=
af.
> + * Translates directly to an on-stack array size.
> + */
> +#define PCS_BATCH_MAX  32U
> +
> +static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, vo=
id **p);
> +
> +/*
> + * Free all objects from the main sheaf. In order to perform
> + * __kmem_cache_free_bulk() outside of cpu_sheaves->lock, work in batche=
s where
> + * object pointers are moved to a on-stack array under the lock. To boun=
d the
> + * stack usage, limit each batch to PCS_BATCH_MAX.
> + *
> + * returns true if at least partially flushed
> + */
> +static bool sheaf_flush_main(struct kmem_cache *s)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       unsigned int batch, remaining;
> +       void *objects[PCS_BATCH_MAX];
> +       struct slab_sheaf *sheaf;
> +       bool ret =3D false;
> +
> +next_batch:
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               return ret;
> +
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +       sheaf =3D pcs->main;
> +
> +       batch =3D min(PCS_BATCH_MAX, sheaf->size);
> +
> +       sheaf->size -=3D batch;
> +       memcpy(objects, sheaf->objects + sheaf->size, batch * sizeof(void=
 *));
> +
> +       remaining =3D sheaf->size;
> +
> +       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +       __kmem_cache_free_bulk(s, batch, &objects[0]);
> +
> +       stat_add(s, SHEAF_FLUSH_MAIN, batch);
> +
> +       ret =3D true;
> +
> +       if (remaining)
> +               goto next_batch;
> +
> +       return ret;
> +}
> +
> +/*
> + * Free all objects from a sheaf that's unused, i.e. not linked to any
> + * cpu_sheaves, so we need no locking and batching. The locking is also =
not
> + * necessary when flushing cpu's sheaves (both spare and main) during cp=
u
> + * hotremove as the cpu is not executing anymore.
> + */
> +static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *=
sheaf)
> +{
> +       if (!sheaf->size)
> +               return;
> +
> +       stat_add(s, SHEAF_FLUSH_OTHER, sheaf->size);
> +
> +       __kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
> +
> +       sheaf->size =3D 0;
> +}
> +
> +/*
> + * Caller needs to make sure migration is disabled in order to fully flu=
sh
> + * single cpu's sheaves
> + *
> + * must not be called from an irq
> + *
> + * flushing operations are rare so let's keep it simple and flush to sla=
bs
> + * directly, skipping the barn
> + */
> +static void pcs_flush_all(struct kmem_cache *s)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *spare;
> +
> +       localtry_lock(&s->cpu_sheaves->lock);
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       spare =3D pcs->spare;
> +       pcs->spare =3D NULL;
> +
> +       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +       if (spare) {
> +               sheaf_flush_unused(s, spare);
> +               free_empty_sheaf(s, spare);
> +       }
> +
> +       sheaf_flush_main(s);
> +}
> +
> +static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +
> +       pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> +
> +       /* The cpu is not executing anymore so we don't need pcs->lock */
> +       sheaf_flush_unused(s, pcs->main);

You are flushing pcs->main but sheaf_flush_unused() will account that
in SHEAF_FLUSH_OTHER instead of SHEAF_FLUSH_MAIN. Perhaps
sheaf_flush_unused() needs a parameter to indicate which counter to be
incremented.

> +       if (pcs->spare) {
> +               sheaf_flush_unused(s, pcs->spare);
> +               free_empty_sheaf(s, pcs->spare);
> +               pcs->spare =3D NULL;
> +       }
> +}
> +
> +static void pcs_destroy(struct kmem_cache *s)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct slub_percpu_sheaves *pcs;
> +
> +               pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> +
> +               /* can happen when unwinding failed create */
> +               if (!pcs->main)
> +                       continue;
> +
> +               WARN_ON(pcs->spare);
> +
> +               if (!WARN_ON(pcs->main->size)) {

If pcs->main->size > 0, shouldn't we flush pcs->main? I understand
it's not a normal situation but I think something like this would be
more correct:

              if (WARN_ON(pcs->main->size))
                            sheaf_flush_unused(s, pcs->main);
              free_empty_sheaf(s, pcs->main);
              pcs->main =3D NULL;

> +                       free_empty_sheaf(s, pcs->main);
> +                       pcs->main =3D NULL;
> +               }
> +       }
> +
> +       free_percpu(s->cpu_sheaves);
> +       s->cpu_sheaves =3D NULL;
> +}
> +
> +static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
> +{
> +       struct slab_sheaf *empty =3D NULL;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&barn->lock, flags);
> +
> +       if (barn->nr_empty) {
> +               empty =3D list_first_entry(&barn->sheaves_empty,
> +                                        struct slab_sheaf, barn_list);
> +               list_del(&empty->barn_list);
> +               barn->nr_empty--;
> +       }
> +
> +       spin_unlock_irqrestore(&barn->lock, flags);
> +
> +       return empty;
> +}
> +
> +static int barn_put_empty_sheaf(struct node_barn *barn,
> +                               struct slab_sheaf *sheaf, bool ignore_lim=
it)

This ignore_limit in barn_put_empty_sheaf()/barn_put_full_sheaf() is
sticking out and really used only inside rcu_free_sheaf() in the next
patch. Every time I saw the return value of these functions ignored I
had to remind myself that they pass ignore_limit=3Dtrue, so the function
can't really fail. Maybe we could get rid of this flag and do trimming
of barn lists inside rcu_free_sheaf() separately in one go? IIUC
because we ignore the limits in all other places, at the time of
rcu_free_sheaf() we might end up with a barn having many more sheaves
than the limit allows for, so trimming in bulk might be even more
productive.

> +{
> +       unsigned long flags;
> +       int ret =3D 0;
> +
> +       spin_lock_irqsave(&barn->lock, flags);
> +
> +       if (!ignore_limit && barn->nr_empty >=3D MAX_EMPTY_SHEAVES) {
> +               ret =3D -E2BIG;
> +       } else {
> +               list_add(&sheaf->barn_list, &barn->sheaves_empty);
> +               barn->nr_empty++;
> +       }
> +
> +       spin_unlock_irqrestore(&barn->lock, flags);
> +       return ret;
> +}
> +
> +static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf=
 *sheaf,
> +                              bool ignore_limit)

Can this function be called for partially populated sheaves or only
full ones? I think rcu_free_sheaf() in the next patch might end up
calling it for a partially populated sheaf.

> +{
> +       unsigned long flags;
> +       int ret =3D 0;
> +
> +       spin_lock_irqsave(&barn->lock, flags);
> +
> +       if (!ignore_limit && barn->nr_full >=3D MAX_FULL_SHEAVES) {
> +               ret =3D -E2BIG;
> +       } else {
> +               list_add(&sheaf->barn_list, &barn->sheaves_full);
> +               barn->nr_full++;
> +       }
> +
> +       spin_unlock_irqrestore(&barn->lock, flags);
> +       return ret;
> +}
> +
> +/*
> + * If a full sheaf is available, return it and put the supplied empty on=
e to
> + * barn. We ignore the limit on empty sheaves as the number of sheaves d=
oesn't
> + * change.

I'm unclear why we ignore the limit here but not in
barn_replace_full_sheaf(). Maybe because full sheaves consume more
memory? But then why do we mostly pass ignore_limit=3Dtrue when invoking
barn_put_full_sheaf()? Explanation of this limit logic needs to be
clarified.

> + */
> +static struct slab_sheaf *
> +barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empt=
y)
> +{
> +       struct slab_sheaf *full =3D NULL;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&barn->lock, flags);
> +
> +       if (barn->nr_full) {
> +               full =3D list_first_entry(&barn->sheaves_full, struct sla=
b_sheaf,
> +                                       barn_list);
> +               list_del(&full->barn_list);
> +               list_add(&empty->barn_list, &barn->sheaves_empty);
> +               barn->nr_full--;
> +               barn->nr_empty++;
> +       }
> +
> +       spin_unlock_irqrestore(&barn->lock, flags);
> +
> +       return full;
> +}
> +/*
> + * If a empty sheaf is available, return it and put the supplied full on=
e to
> + * barn. But if there are too many full sheaves, reject this with -E2BIG=
.
> + */
> +static struct slab_sheaf *
> +barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
> +{
> +       struct slab_sheaf *empty;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&barn->lock, flags);
> +
> +       if (barn->nr_full >=3D MAX_FULL_SHEAVES) {
> +               empty =3D ERR_PTR(-E2BIG);
> +       } else if (!barn->nr_empty) {
> +               empty =3D ERR_PTR(-ENOMEM);
> +       } else {
> +               empty =3D list_first_entry(&barn->sheaves_empty, struct s=
lab_sheaf,
> +                                        barn_list);
> +               list_del(&empty->barn_list);
> +               list_add(&full->barn_list, &barn->sheaves_full);
> +               barn->nr_empty--;
> +               barn->nr_full++;
> +       }
> +
> +       spin_unlock_irqrestore(&barn->lock, flags);
> +
> +       return empty;
> +}
> +
> +static void barn_init(struct node_barn *barn)
> +{
> +       spin_lock_init(&barn->lock);
> +       INIT_LIST_HEAD(&barn->sheaves_full);
> +       INIT_LIST_HEAD(&barn->sheaves_empty);
> +       barn->nr_full =3D 0;
> +       barn->nr_empty =3D 0;
> +}
> +
> +static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
> +{
> +       struct list_head empty_list;
> +       struct list_head full_list;
> +       struct slab_sheaf *sheaf, *sheaf2;
> +       unsigned long flags;
> +
> +       INIT_LIST_HEAD(&empty_list);
> +       INIT_LIST_HEAD(&full_list);
> +
> +       spin_lock_irqsave(&barn->lock, flags);
> +
> +       list_splice_init(&barn->sheaves_full, &full_list);
> +       barn->nr_full =3D 0;
> +       list_splice_init(&barn->sheaves_empty, &empty_list);
> +       barn->nr_empty =3D 0;
> +
> +       spin_unlock_irqrestore(&barn->lock, flags);
> +
> +       list_for_each_entry_safe(sheaf, sheaf2, &full_list, barn_list) {
> +               sheaf_flush_unused(s, sheaf);
> +               free_empty_sheaf(s, sheaf);
> +       }
> +
> +       list_for_each_entry_safe(sheaf, sheaf2, &empty_list, barn_list)
> +               free_empty_sheaf(s, sheaf);
> +}
> +
>  /*
>   * Slab allocation and freeing
>   */
> @@ -3280,11 +3675,42 @@ static inline void __flush_cpu_slab(struct kmem_c=
ache *s, int cpu)
>         put_partials_cpu(s, c);
>  }
>
> -struct slub_flush_work {
> -       struct work_struct work;
> -       struct kmem_cache *s;
> -       bool skip;
> -};
> +static inline void flush_this_cpu_slab(struct kmem_cache *s)
> +{
> +       struct kmem_cache_cpu *c =3D this_cpu_ptr(s->cpu_slab);
> +
> +       if (c->slab)
> +               flush_slab(s, c);
> +
> +       put_partials(s);
> +}
> +
> +static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> +{
> +       struct kmem_cache_cpu *c =3D per_cpu_ptr(s->cpu_slab, cpu);
> +
> +       return c->slab || slub_percpu_partial(c);
> +}
> +
> +#else /* CONFIG_SLUB_TINY */
> +static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
> +static inline bool has_cpu_slab(int cpu, struct kmem_cache *s) { return =
false; }
> +static inline void flush_this_cpu_slab(struct kmem_cache *s) { }
> +#endif /* CONFIG_SLUB_TINY */
> +
> +static bool has_pcs_used(int cpu, struct kmem_cache *s)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +
> +       if (!s->cpu_sheaves)
> +               return false;
> +
> +       pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> +
> +       return (pcs->spare || pcs->main->size);
> +}
> +
> +static void pcs_flush_all(struct kmem_cache *s);
>
>  /*
>   * Flush cpu slab.
> @@ -3294,30 +3720,18 @@ struct slub_flush_work {
>  static void flush_cpu_slab(struct work_struct *w)
>  {
>         struct kmem_cache *s;
> -       struct kmem_cache_cpu *c;
>         struct slub_flush_work *sfw;
>
>         sfw =3D container_of(w, struct slub_flush_work, work);
>
>         s =3D sfw->s;
> -       c =3D this_cpu_ptr(s->cpu_slab);
> -
> -       if (c->slab)
> -               flush_slab(s, c);
> -
> -       put_partials(s);
> -}
>
> -static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> -{
> -       struct kmem_cache_cpu *c =3D per_cpu_ptr(s->cpu_slab, cpu);
> +       if (s->cpu_sheaves)
> +               pcs_flush_all(s);
>
> -       return c->slab || slub_percpu_partial(c);
> +       flush_this_cpu_slab(s);
>  }
>
> -static DEFINE_MUTEX(flush_lock);
> -static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
> -
>  static void flush_all_cpus_locked(struct kmem_cache *s)
>  {
>         struct slub_flush_work *sfw;
> @@ -3328,7 +3742,7 @@ static void flush_all_cpus_locked(struct kmem_cache=
 *s)
>
>         for_each_online_cpu(cpu) {
>                 sfw =3D &per_cpu(slub_flush, cpu);
> -               if (!has_cpu_slab(cpu, s)) {
> +               if (!has_cpu_slab(cpu, s) && !has_pcs_used(cpu, s)) {
>                         sfw->skip =3D true;
>                         continue;
>                 }
> @@ -3364,19 +3778,14 @@ static int slub_cpu_dead(unsigned int cpu)
>         struct kmem_cache *s;
>
>         mutex_lock(&slab_mutex);
> -       list_for_each_entry(s, &slab_caches, list)
> +       list_for_each_entry(s, &slab_caches, list) {
>                 __flush_cpu_slab(s, cpu);
> +               __pcs_flush_all_cpu(s, cpu);
> +       }
>         mutex_unlock(&slab_mutex);
>         return 0;
>  }
>
> -#else /* CONFIG_SLUB_TINY */
> -static inline void flush_all_cpus_locked(struct kmem_cache *s) { }
> -static inline void flush_all(struct kmem_cache *s) { }
> -static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
> -static inline int slub_cpu_dead(unsigned int cpu) { return 0; }
> -#endif /* CONFIG_SLUB_TINY */
> -
>  /*
>   * Check if the objects in a per cpu structure fit numa
>   * locality expectations.
> @@ -4126,6 +4535,179 @@ bool slab_post_alloc_hook(struct kmem_cache *s, s=
truct list_lru *lru,
>         return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
>  }
>
> +static __fastpath_inline
> +void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       void *object;
> +
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               return NULL;
> +
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (unlikely(pcs->main->size =3D=3D 0)) {
> +
> +               struct slab_sheaf *empty =3D NULL;
> +               struct slab_sheaf *full;
> +               bool can_alloc;
> +
> +               if (pcs->spare && pcs->spare->size > 0) {
> +                       stat(s, SHEAF_SWAP);
> +                       swap(pcs->main, pcs->spare);
> +                       goto do_alloc;
> +               }
> +
> +               full =3D barn_replace_empty_sheaf(pcs->barn, pcs->main);
> +
> +               if (full) {
> +                       pcs->main =3D full;
> +                       goto do_alloc;
> +               }
> +
> +               can_alloc =3D gfpflags_allow_blocking(gfp);
> +
> +               if (can_alloc) {
> +                       if (pcs->spare) {
> +                               empty =3D pcs->spare;
> +                               pcs->spare =3D NULL;
> +                       } else {
> +                               empty =3D barn_get_empty_sheaf(pcs->barn)=
;
> +                       }
> +               }
> +
> +               localtry_unlock(&s->cpu_sheaves->lock);
> +
> +               if (!can_alloc)
> +                       return NULL;
> +
> +               if (empty) {
> +                       if (!refill_sheaf(s, empty, gfp)) {
> +                               full =3D empty;
> +                       } else {
> +                               /*
> +                                * we must be very low on memory so don't=
 bother
> +                                * with the barn
> +                                */
> +                               free_empty_sheaf(s, empty);
> +                       }
> +               } else {
> +                       full =3D alloc_full_sheaf(s, gfp);
> +               }
> +
> +               if (!full)
> +                       return NULL;
> +
> +               /*
> +                * we can reach here only when gfpflags_allow_blocking
> +                * so this must not be an irq
> +                */
> +               localtry_lock(&s->cpu_sheaves->lock);
> +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +               /*
> +                * If we are returning empty sheaf, we either got it from=
 the
> +                * barn or had to allocate one. If we are returning a ful=
l
> +                * sheaf, it's due to racing or being migrated to a diffe=
rent
> +                * cpu. Breaching the barn's sheaf limits should be thus =
rare
> +                * enough so just ignore them to simplify the recovery.
> +                */
> +
> +               if (pcs->main->size =3D=3D 0) {
> +                       barn_put_empty_sheaf(pcs->barn, pcs->main, true);
> +                       pcs->main =3D full;
> +                       goto do_alloc;
> +               }
> +
> +               if (!pcs->spare) {
> +                       pcs->spare =3D full;
> +                       goto do_alloc;
> +               }
> +
> +               if (pcs->spare->size =3D=3D 0) {
> +                       barn_put_empty_sheaf(pcs->barn, pcs->spare, true)=
;
> +                       pcs->spare =3D full;
> +                       goto do_alloc;
> +               }
> +
> +               barn_put_full_sheaf(pcs->barn, full, true);
> +       }
> +
> +do_alloc:
> +       object =3D pcs->main->objects[--pcs->main->size];
> +
> +       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +       stat(s, ALLOC_PCS);
> +
> +       return object;
> +}
> +
> +static __fastpath_inline
> +unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void=
 **p)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *main;
> +       unsigned int allocated =3D 0;
> +       unsigned int batch;
> +
> +next_batch:
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               return allocated;
> +
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (unlikely(pcs->main->size =3D=3D 0)) {

The above condition is unlikely only for the first batch. I think it's
actually guaranteed on all consecutive batches once you do "goto
next_batch", right?

> +
> +               struct slab_sheaf *full;
> +
> +               if (pcs->spare && pcs->spare->size > 0) {
> +                       stat(s, SHEAF_SWAP);
> +                       swap(pcs->main, pcs->spare);
> +                       goto do_alloc;
> +               }
> +
> +               full =3D barn_replace_empty_sheaf(pcs->barn, pcs->main);
> +
> +               if (full) {
> +                       pcs->main =3D full;
> +                       goto do_alloc;
> +               }
> +
> +               localtry_unlock(&s->cpu_sheaves->lock);
> +
> +               /*
> +                * Once full sheaves in barn are depleted, let the bulk
> +                * allocation continue from slab pages, otherwise we woul=
d just
> +                * be copying arrays of pointers twice.
> +                */
> +               return allocated;
> +       }
> +
> +do_alloc:
> +
> +       main =3D pcs->main;
> +       batch =3D min(size, main->size);
> +
> +       main->size -=3D batch;
> +       memcpy(p, main->objects + main->size, batch * sizeof(void *));
> +
> +       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +       stat_add(s, ALLOC_PCS, batch);
> +
> +       allocated +=3D batch;
> +
> +       if (batch < size) {
> +               p +=3D batch;
> +               size -=3D batch;
> +               goto next_batch;
> +       }
> +
> +       return allocated;
> +}
> +
> +
>  /*
>   * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_al=
loc)
>   * have the fastpath folded into their functions. So no function call
> @@ -4150,7 +4732,11 @@ static __fastpath_inline void *slab_alloc_node(str=
uct kmem_cache *s, struct list
>         if (unlikely(object))
>                 goto out;
>
> -       object =3D __slab_alloc_node(s, gfpflags, node, addr, orig_size);
> +       if (s->cpu_sheaves && (node =3D=3D NUMA_NO_NODE))
> +               object =3D alloc_from_pcs(s, gfpflags);
> +
> +       if (!object)
> +               object =3D __slab_alloc_node(s, gfpflags, node, addr, ori=
g_size);
>
>         maybe_wipe_obj_freeptr(s, object);
>         init =3D slab_want_init_on_alloc(gfpflags, s);
> @@ -4521,6 +5107,232 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
>         discard_slab(s, slab);
>  }
>
> +/*
> + * pcs is locked. We should have get rid of the spare sheaf and obtained=
 an
> + * empty sheaf, while the main sheaf is full. We want to install the emp=
ty sheaf
> + * as a main sheaf, and make the current main sheaf a spare sheaf.
> + *
> + * However due to having relinquished the cpu_sheaves lock when obtainin=
g
> + * the empty sheaf, we need to handle some unlikely but possible cases.
> + *
> + * If we put any sheaf to barn here, it's because we were interrupted or=
 have
> + * been migrated to a different cpu, which should be rare enough so just=
 ignore
> + * the barn's limits to simplify the handling.
> + */
> +static void __pcs_install_empty_sheaf(struct kmem_cache *s,
> +               struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty=
)
> +{
> +       /* this is what we expect to find in nobody interrupted us */

s/in/if in the above comment

> +       if (likely(!pcs->spare)) {
> +               pcs->spare =3D pcs->main;
> +               pcs->main =3D empty;
> +               return;
> +       }
> +
> +       /*
> +        * Unlikely because if the main sheaf had space, we would have ju=
st
> +        * freed to it. Get rid of our empty sheaf.
> +        */
> +       if (pcs->main->size < s->sheaf_capacity) {
> +               barn_put_empty_sheaf(pcs->barn, empty, true);
> +               return;
> +       }
> +
> +       /* Also unlikely for the same reason */
> +       if (pcs->spare->size < s->sheaf_capacity) {
> +               stat(s, SHEAF_SWAP);
> +               swap(pcs->main, pcs->spare);
> +               barn_put_empty_sheaf(pcs->barn, empty, true);
> +               return;
> +       }
> +
> +       barn_put_full_sheaf(pcs->barn, pcs->main, true);
> +       pcs->main =3D empty;
> +}
> +
> +/*
> + * Free an object to the percpu sheaves.
> + * The object is expected to have passed slab_free_hook() already.
> + */
> +static __fastpath_inline
> +bool free_to_pcs(struct kmem_cache *s, void *object)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +
> +restart:
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               return false;
> +
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
> +
> +               struct slab_sheaf *empty;
> +
> +               if (!pcs->spare) {
> +                       empty =3D barn_get_empty_sheaf(pcs->barn);
> +                       if (empty) {
> +                               pcs->spare =3D pcs->main;
> +                               pcs->main =3D empty;
> +                               goto do_free;
> +                       }
> +                       goto alloc_empty;
> +               }
> +
> +               if (pcs->spare->size < s->sheaf_capacity) {
> +                       stat(s, SHEAF_SWAP);
> +                       swap(pcs->main, pcs->spare);
> +                       goto do_free;
> +               }
> +
> +               empty =3D barn_replace_full_sheaf(pcs->barn, pcs->main);

This function reads easier now but if barn_replace_full_sheaf() could
ignore the MAX_FULL_SHEAVES and barn list trimming could be done
later, it would simplify this function even further.

> +
> +               if (!IS_ERR(empty)) {
> +                       pcs->main =3D empty;
> +                       goto do_free;
> +               }
> +
> +               if (PTR_ERR(empty) =3D=3D -E2BIG) {
> +                       /* Since we got here, spare exists and is full */
> +                       struct slab_sheaf *to_flush =3D pcs->spare;
> +
> +                       pcs->spare =3D NULL;
> +                       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +                       sheaf_flush_unused(s, to_flush);
> +                       empty =3D to_flush;
> +                       goto got_empty;
> +               }
> +
> +alloc_empty:
> +               localtry_unlock(&s->cpu_sheaves->lock);
> +
> +               empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> +
> +               if (!empty) {
> +                       if (sheaf_flush_main(s))
> +                               goto restart;
> +                       else
> +                               return false;
> +               }
> +
> +got_empty:
> +               if (!localtry_trylock(&s->cpu_sheaves->lock)) {
> +                       struct node_barn *barn;
> +
> +                       barn =3D get_node(s, numa_mem_id())->barn;
> +
> +                       barn_put_empty_sheaf(barn, empty, true);
> +                       return false;
> +               }
> +
> +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +               __pcs_install_empty_sheaf(s, pcs, empty);
> +       }
> +
> +do_free:
> +       pcs->main->objects[pcs->main->size++] =3D object;
> +
> +       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +       stat(s, FREE_PCS);
> +
> +       return true;
> +}
> +
> +/*
> + * Bulk free objects to the percpu sheaves.
> + * Unlike free_to_pcs() this includes the calls to all necessary hooks
> + * and the fallback to freeing to slab pages.
> + */
> +static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p=
)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *main;
> +       unsigned int batch, i =3D 0;
> +       bool init;
> +
> +       init =3D slab_want_init_on_free(s);
> +
> +       while (i < size) {
> +               struct slab *slab =3D virt_to_slab(p[i]);
> +
> +               memcg_slab_free_hook(s, slab, p + i, 1);
> +               alloc_tagging_slab_free_hook(s, slab, p + i, 1);
> +
> +               if (unlikely(!slab_free_hook(s, p[i], init, false))) {
> +                       p[i] =3D p[--size];
> +                       if (!size)
> +                               return;
> +                       continue;
> +               }
> +
> +               i++;
> +       }
> +
> +next_batch:

nit: I think the section below would be more readable if structured
with fail handling blocks at the end. Something like this:

next_batch:
        if (!localtry_trylock(&s->cpu_sheaves->lock))
                goto fallback;

        pcs =3D this_cpu_ptr(s->cpu_sheaves);

        if (likely(pcs->main->size < s->sheaf_capacity))
                goto do_free;

        if (!pcs->spare) {
                empty =3D barn_get_empty_sheaf(pcs->barn);
                if (!empty)
                        goto no_empty;

                pcs->spare =3D pcs->main;
                pcs->main =3D empty;
                goto do_free;
        }

        if (pcs->spare->size < s->sheaf_capacity) {
                stat(s, SHEAF_SWAP);
                swap(pcs->main, pcs->spare);
                goto do_free;
        }

        empty =3D barn_replace_full_sheaf(pcs->barn, pcs->main);
        if (IS_ERR(empty))
                goto no_empty;

        pcs->main =3D empty;

do_free:
        main =3D pcs->main;
        batch =3D min(size, s->sheaf_capacity - main->size);

        memcpy(main->objects + main->size, p, batch * sizeof(void *));
        main->size +=3D batch;

        localtry_unlock(&s->cpu_sheaves->lock);

        stat_add(s, FREE_PCS, batch);

        if (batch < size) {
                p +=3D batch;
                size -=3D batch;
                goto next_batch;
        }

        return;
no_empty:
        localtry_unlock(&s->cpu_sheaves->lock);

        /*
         * if we depleted all empty sheaves in the barn or there are too
         * many full sheaves, free the rest to slab pages
         */
fallback:
        __kmem_cache_free_bulk(s, size, p);
}

> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               goto fallback;
> +
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
> +
> +               struct slab_sheaf *empty;
> +
> +               if (!pcs->spare) {
> +                       empty =3D barn_get_empty_sheaf(pcs->barn);
> +                       if (empty) {
> +                               pcs->spare =3D pcs->main;
> +                               pcs->main =3D empty;
> +                               goto do_free;
> +                       }
> +                       goto no_empty;
> +               }
> +
> +               if (pcs->spare->size < s->sheaf_capacity) {
> +                       stat(s, SHEAF_SWAP);
> +                       swap(pcs->main, pcs->spare);
> +                       goto do_free;
> +               }
> +
> +               empty =3D barn_replace_full_sheaf(pcs->barn, pcs->main);
> +
> +               if (!IS_ERR(empty)) {
> +                       pcs->main =3D empty;
> +                       goto do_free;
> +               }
> +
> +no_empty:
> +               localtry_unlock(&s->cpu_sheaves->lock);
> +
> +               /*
> +                * if we depleted all empty sheaves in the barn or there =
are too
> +                * many full sheaves, free the rest to slab pages
> +                */
> +fallback:
> +               __kmem_cache_free_bulk(s, size, p);
> +               return;
> +       }
> +
> +do_free:
> +       main =3D pcs->main;
> +       batch =3D min(size, s->sheaf_capacity - main->size);
> +
> +       memcpy(main->objects + main->size, p, batch * sizeof(void *));
> +       main->size +=3D batch;
> +
> +       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +       stat_add(s, FREE_PCS, batch);
> +
> +       if (batch < size) {
> +               p +=3D batch;
> +               size -=3D batch;
> +               goto next_batch;
> +       }
> +}
> +
>  #ifndef CONFIG_SLUB_TINY
>  /*
>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free =
that
> @@ -4607,7 +5419,10 @@ void slab_free(struct kmem_cache *s, struct slab *=
slab, void *object,
>         memcg_slab_free_hook(s, slab, &object, 1);
>         alloc_tagging_slab_free_hook(s, slab, &object, 1);
>
> -       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), f=
alse)))
> +       if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s)=
, false)))
> +               return;
> +
> +       if (!s->cpu_sheaves || !free_to_pcs(s, object))
>                 do_slab_free(s, slab, object, object, 1, addr);
>  }
>
> @@ -5033,6 +5848,15 @@ void kmem_cache_free_bulk(struct kmem_cache *s, si=
ze_t size, void **p)
>         if (!size)
>                 return;
>
> +       /*
> +        * freeing to sheaves is so incompatible with the detached freeli=
st so
> +        * once we go that way, we have to do everything differently
> +        */
> +       if (s && s->cpu_sheaves) {
> +               free_to_pcs_bulk(s, size, p);
> +               return;
> +       }
> +
>         do {
>                 struct detached_freelist df;
>
> @@ -5151,7 +5975,7 @@ static int __kmem_cache_alloc_bulk(struct kmem_cach=
e *s, gfp_t flags,
>  int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size=
_t size,
>                                  void **p)
>  {
> -       int i;
> +       unsigned int i =3D 0;
>
>         if (!size)
>                 return 0;
> @@ -5160,9 +5984,21 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache=
 *s, gfp_t flags, size_t size,
>         if (unlikely(!s))
>                 return 0;
>
> -       i =3D __kmem_cache_alloc_bulk(s, flags, size, p);
> -       if (unlikely(i =3D=3D 0))
> -               return 0;
> +       if (s->cpu_sheaves)
> +               i =3D alloc_from_pcs_bulk(s, size, p);
> +
> +       if (i < size) {
> +               unsigned int j =3D __kmem_cache_alloc_bulk(s, flags, size=
 - i, p + i);
> +               /*
> +                * If we ran out of memory, don't bother with freeing bac=
k to
> +                * the percpu sheaves, we have bigger problems.
> +                */
> +               if (unlikely(j =3D=3D 0)) {
> +                       if (i > 0)
> +                               __kmem_cache_free_bulk(s, i, p);
> +                       return 0;
> +               }
> +       }
>
>         /*
>          * memcg and kmem_cache debug support and memory initialization.
> @@ -5172,11 +6008,11 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cach=
e *s, gfp_t flags, size_t size,
>                     slab_want_init_on_alloc(flags, s), s->object_size))) =
{
>                 return 0;
>         }
> -       return i;
> +
> +       return size;
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
>
> -
>  /*
>   * Object placement in a slab is made very easy because we always start =
at
>   * offset 0. If we tune the size of the object to the alignment then we =
can
> @@ -5309,8 +6145,8 @@ static inline int calculate_order(unsigned int size=
)
>         return -ENOSYS;
>  }
>
> -static void
> -init_kmem_cache_node(struct kmem_cache_node *n)
> +static bool
> +init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
>  {
>         n->nr_partial =3D 0;
>         spin_lock_init(&n->list_lock);
> @@ -5320,6 +6156,11 @@ init_kmem_cache_node(struct kmem_cache_node *n)
>         atomic_long_set(&n->total_objects, 0);
>         INIT_LIST_HEAD(&n->full);
>  #endif
> +       n->barn =3D barn;
> +       if (barn)
> +               barn_init(barn);
> +
> +       return true;
>  }
>
>  #ifndef CONFIG_SLUB_TINY
> @@ -5350,6 +6191,30 @@ static inline int alloc_kmem_cache_cpus(struct kme=
m_cache *s)
>  }
>  #endif /* CONFIG_SLUB_TINY */
>
> +static int init_percpu_sheaves(struct kmem_cache *s)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct slub_percpu_sheaves *pcs;
> +               int nid;
> +
> +               pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> +
> +               localtry_lock_init(&pcs->lock);
> +
> +               nid =3D cpu_to_mem(cpu);
> +
> +               pcs->barn =3D get_node(s, nid)->barn;
> +               pcs->main =3D alloc_empty_sheaf(s, GFP_KERNEL);
> +
> +               if (!pcs->main)
> +                       return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
>  static struct kmem_cache *kmem_cache_node;
>
>  /*
> @@ -5385,7 +6250,7 @@ static void early_kmem_cache_node_alloc(int node)
>         slab->freelist =3D get_freepointer(kmem_cache_node, n);
>         slab->inuse =3D 1;
>         kmem_cache_node->node[node] =3D n;
> -       init_kmem_cache_node(n);
> +       init_kmem_cache_node(n, NULL);
>         inc_slabs_node(kmem_cache_node, node, slab->objects);
>
>         /*
> @@ -5401,6 +6266,13 @@ static void free_kmem_cache_nodes(struct kmem_cach=
e *s)
>         struct kmem_cache_node *n;
>
>         for_each_kmem_cache_node(s, node, n) {
> +               if (n->barn) {
> +                       WARN_ON(n->barn->nr_full);
> +                       WARN_ON(n->barn->nr_empty);
> +                       kfree(n->barn);
> +                       n->barn =3D NULL;
> +               }
> +
>                 s->node[node] =3D NULL;
>                 kmem_cache_free(kmem_cache_node, n);
>         }
> @@ -5409,6 +6281,8 @@ static void free_kmem_cache_nodes(struct kmem_cache=
 *s)
>  void __kmem_cache_release(struct kmem_cache *s)
>  {
>         cache_random_seq_destroy(s);
> +       if (s->cpu_sheaves)
> +               pcs_destroy(s);
>  #ifndef CONFIG_SLUB_TINY
>         free_percpu(s->cpu_slab);
>  #endif
> @@ -5421,20 +6295,27 @@ static int init_kmem_cache_nodes(struct kmem_cach=
e *s)
>
>         for_each_node_mask(node, slab_nodes) {
>                 struct kmem_cache_node *n;
> +               struct node_barn *barn =3D NULL;
>
>                 if (slab_state =3D=3D DOWN) {
>                         early_kmem_cache_node_alloc(node);
>                         continue;
>                 }
> +
> +               if (s->cpu_sheaves) {
> +                       barn =3D kmalloc_node(sizeof(*barn), GFP_KERNEL, =
node);
> +
> +                       if (!barn)
> +                               return 0;
> +               }
> +
>                 n =3D kmem_cache_alloc_node(kmem_cache_node,
>                                                 GFP_KERNEL, node);
> -
> -               if (!n) {
> -                       free_kmem_cache_nodes(s);
> +               if (!n)
>                         return 0;
> -               }
>
> -               init_kmem_cache_node(n);
> +               init_kmem_cache_node(n, barn);
> +
>                 s->node[node] =3D n;
>         }
>         return 1;
> @@ -5690,6 +6571,8 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>         flush_all_cpus_locked(s);
>         /* Attempt to free all objects */
>         for_each_kmem_cache_node(s, node, n) {
> +               if (n->barn)
> +                       barn_shrink(s, n->barn);
>                 free_partial(s, n);
>                 if (n->nr_partial || node_nr_slabs(n))
>                         return 1;
> @@ -5893,6 +6776,9 @@ static int __kmem_cache_do_shrink(struct kmem_cache=
 *s)
>                 for (i =3D 0; i < SHRINK_PROMOTE_MAX; i++)
>                         INIT_LIST_HEAD(promote + i);
>
> +               if (n->barn)
> +                       barn_shrink(s, n->barn);
> +
>                 spin_lock_irqsave(&n->list_lock, flags);
>
>                 /*
> @@ -6005,12 +6891,24 @@ static int slab_mem_going_online_callback(void *a=
rg)
>          */
>         mutex_lock(&slab_mutex);
>         list_for_each_entry(s, &slab_caches, list) {
> +               struct node_barn *barn =3D NULL;
> +
>                 /*
>                  * The structure may already exist if the node was previo=
usly
>                  * onlined and offlined.
>                  */
>                 if (get_node(s, nid))
>                         continue;
> +
> +               if (s->cpu_sheaves) {
> +                       barn =3D kmalloc_node(sizeof(*barn), GFP_KERNEL, =
nid);
> +
> +                       if (!barn) {
> +                               ret =3D -ENOMEM;
> +                               goto out;
> +                       }
> +               }
> +
>                 /*
>                  * XXX: kmem_cache_alloc_node will fallback to other node=
s
>                  *      since memory is not yet available from the node t=
hat
> @@ -6021,7 +6919,9 @@ static int slab_mem_going_online_callback(void *arg=
)
>                         ret =3D -ENOMEM;
>                         goto out;
>                 }
> -               init_kmem_cache_node(n);
> +
> +               init_kmem_cache_node(n, barn);
> +
>                 s->node[nid] =3D n;
>         }
>         /*
> @@ -6240,6 +7140,16 @@ int do_kmem_cache_create(struct kmem_cache *s, con=
st char *name,
>
>         set_cpu_partial(s);
>
> +       if (args->sheaf_capacity) {
> +               s->cpu_sheaves =3D alloc_percpu(struct slub_percpu_sheave=
s);
> +               if (!s->cpu_sheaves) {
> +                       err =3D -ENOMEM;
> +                       goto out;
> +               }
> +               // TODO: increase capacity to grow slab_sheaf up to next =
kmalloc size?
> +               s->sheaf_capacity =3D args->sheaf_capacity;
> +       }
> +
>  #ifdef CONFIG_NUMA
>         s->remote_node_defrag_ratio =3D 1000;
>  #endif
> @@ -6256,6 +7166,12 @@ int do_kmem_cache_create(struct kmem_cache *s, con=
st char *name,
>         if (!alloc_kmem_cache_cpus(s))
>                 goto out;
>
> +       if (s->cpu_sheaves) {
> +               err =3D init_percpu_sheaves(s);
> +               if (err)
> +                       goto out;
> +       }
> +
>         err =3D 0;
>
>         /* Mutex is not taken during early boot */
> @@ -6277,7 +7193,6 @@ int do_kmem_cache_create(struct kmem_cache *s, cons=
t char *name,
>                 __kmem_cache_release(s);
>         return err;
>  }
> -
>  #ifdef SLAB_SUPPORTS_SYSFS
>  static int count_inuse(struct slab *slab)
>  {
> @@ -7055,8 +7970,10 @@ static ssize_t text##_store(struct kmem_cache *s, =
               \
>  }                                                              \
>  SLAB_ATTR(text);                                               \
>
> +STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
> +STAT_ATTR(FREE_PCS, free_cpu_sheaf);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>  STAT_ATTR(FREE_FROZEN, free_frozen);
> @@ -7081,6 +7998,12 @@ STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
>  STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
>  STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
>  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
> +STAT_ATTR(SHEAF_FLUSH_MAIN, sheaf_flush_main);
> +STAT_ATTR(SHEAF_FLUSH_OTHER, sheaf_flush_other);
> +STAT_ATTR(SHEAF_REFILL, sheaf_refill);
> +STAT_ATTR(SHEAF_SWAP, sheaf_swap);
> +STAT_ATTR(SHEAF_ALLOC, sheaf_alloc);
> +STAT_ATTR(SHEAF_FREE, sheaf_free);
>  #endif /* CONFIG_SLUB_STATS */
>
>  #ifdef CONFIG_KFENCE
> @@ -7142,8 +8065,10 @@ static struct attribute *slab_attrs[] =3D {
>         &remote_node_defrag_ratio_attr.attr,
>  #endif
>  #ifdef CONFIG_SLUB_STATS
> +       &alloc_cpu_sheaf_attr.attr,
>         &alloc_fastpath_attr.attr,
>         &alloc_slowpath_attr.attr,
> +       &free_cpu_sheaf_attr.attr,
>         &free_fastpath_attr.attr,
>         &free_slowpath_attr.attr,
>         &free_frozen_attr.attr,
> @@ -7168,6 +8093,12 @@ static struct attribute *slab_attrs[] =3D {
>         &cpu_partial_free_attr.attr,
>         &cpu_partial_node_attr.attr,
>         &cpu_partial_drain_attr.attr,
> +       &sheaf_flush_main_attr.attr,
> +       &sheaf_flush_other_attr.attr,
> +       &sheaf_refill_attr.attr,
> +       &sheaf_swap_attr.attr,
> +       &sheaf_alloc_attr.attr,
> +       &sheaf_free_attr.attr,
>  #endif
>  #ifdef CONFIG_FAILSLAB
>         &failslab_attr.attr,
>
> --
> 2.48.1
>
