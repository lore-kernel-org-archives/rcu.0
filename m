Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D418EB0
	for <rcu@vger.kernel.org>; Sat, 22 Feb 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740265026; cv=none; b=DdBtx8LtKWL8cbHj1TiBuVFtCAhcUw12q8bK8eKHwOLmfKEHBKxfgswLZGeyEuloaXv1rjcW1jRwMOYn9w1unDY9HruX4JFo9USFNZF94Mj39sFcAnTY49vi2+vI1z2PbZtqq+EFeMpWSMmLfaG7EWAJOmlvM0L9SeKPKwLZQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740265026; c=relaxed/simple;
	bh=iw92YqZMJv33fgVWGNzx8EI7hXiaqZrXypZ3WGqQvlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/eY4z8aezvim41whwLbmFc7ok5Id0uKOx4iwvaOS/JTiVS2qdWJ5aNdMJqPa/Vynck389cyoQXfVkMeV+2817UQOhP3n3JNE4u41bEtytDvOZeTWc+9CZOYHBEPW/1J+EAUNBE0WMPcQlCYlOHSJlQVOnNsoTj/M3n1CLTMsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMK5Y9zJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMK5Y9zJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471fa3b19bcso182311cf.0
        for <rcu@vger.kernel.org>; Sat, 22 Feb 2025 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740265022; x=1740869822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gge3vQYVWXfS/0Tum75HlVEoZkZOJUKageveDtxDc1M=;
        b=MMK5Y9zJRpYRlJbMJe2uX1JszS1Ac0eJaA3vFy3x8oiMiqxHk8M9RDb1pc3bxppoQr
         rjnoJlwL5hpBAZxHcZQcyhXu6lKNgPMDe1kesnVvvht0A6dL1Rmf/lA15Vq10doCWLOa
         2QplQWbMEYHKiZXL1xo65drm/5cIfQQ+uSQbQyWJqNKZk9VVXCM2UT4iMlPaYUepe+os
         YOQzhvTptBvihlkSE1ygOFzXsPA9BxV2sXWcoDyLVdrfp2+jnjyC4Gr42APJL8Rj5va/
         2inwlkFeV2Sr1ANMBfm17RWyHr4gDQ1SxudxB5rORfp+q+V5zVwF9kSwz0XHGzaYw2+p
         /09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740265022; x=1740869822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gge3vQYVWXfS/0Tum75HlVEoZkZOJUKageveDtxDc1M=;
        b=exWZaiDdlQi4Eqk8j1heA7AG6znB4JynZPCLp0FzOuuH9j5zMb8U+7YA0gWz4Tjn3v
         3PCRsryv9O56y32VX1DekdYw0VJQxXD92KgzY/Js8XRn/5m782fpyRJHafQPtHKXaWpu
         /qCcH4DXYarmvKUVd3tOkorlKanBGxiB/pIF8q0QerweoumoSOnzf+T3yzRgwxGI26nE
         nUH27BjY3ki+lLW19lZTpJukDqGlfkElbkesh9T7XHQubtLHv/reCxli7WkvHwLaLdEE
         vttVMw06+/7VQ5uOJKrkgUEwVakVW7fMB5PMSzqu/Q4BIj7xv6GHunRnKsaQMLrS4AGy
         Cr8w==
X-Forwarded-Encrypted: i=1; AJvYcCUkXKq2OSC29K1wGJiolBo1uzvJJFBK42P5I2+65K5WdYFm/fZdouyTlBNr7nyTJwTPuKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyihW5txDrSPVy4mHdxRKTtSjBmZMy0zmoQ3IRgce03+z7g+gN
	2dtuVdSFthVk/3cvLS3UM2OUOAcNcevFRR9Hip59B9Ums9p4P0+TV5wNr1S2kyoVxab5awJIY8w
	O7U7KZuwOCjINW6vfieRBBhDB/Fayk00QyfD/
X-Gm-Gg: ASbGncv56bTbjnh3Y/4ZvhPpioLRIpeWVjpjSB7Kfm6wBLizzsNK1mrvqc5Il5BlSdt
	pJZJV+huiB+T65nHCe7g6Sf220G2qxJXIGMaXoEXH2kQCwytAX2IB/vNwgccSXSi0U4Eqe9MN0c
	FhZ9VEC5s=
X-Google-Smtp-Source: AGHT+IF9sEAONwmLjntksfGSQ9qafSkOmtMZyxLBjdwAd0MJMRiSt08GuyEsKZieSg/bFpYJ0X0v06UnO7XxiIqWNkw=
X-Received: by 2002:a05:622a:1a86:b0:471:e982:c73d with SMTP id
 d75a77b69052e-47234bc0cf7mr2224281cf.11.1740265021529; Sat, 22 Feb 2025
 14:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-1-88592ee0966a@suse.cz> <CAJuCfpG4BYNWM24_Jha-SapfeaGdO0GKuteHwNE1hDdWXRS+1Q@mail.gmail.com>
In-Reply-To: <CAJuCfpG4BYNWM24_Jha-SapfeaGdO0GKuteHwNE1hDdWXRS+1Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 14:56:50 -0800
X-Gm-Features: AWEUYZkOshr7LRXif6AbLn_YJz7SaZp03CYbZ7f8Z7fk_AsHBrkfsWbM3tE3G08
Message-ID: <CAJuCfpE0tpLLR3gA0iW6NscyEHZHs-0YSeLKqLxSnYReZxEnKg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/10] slab: add opt-in caching layer of percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 2:46=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Feb 14, 2025 at 8:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > Specifying a non-zero value for a new struct kmem_cache_args field
> > sheaf_capacity will setup a caching layer of percpu arrays called
> > sheaves of given capacity for the created cache.
> >
> > Allocations from the cache will allocate via the percpu sheaves (main o=
r
> > spare) as long as they have no NUMA node preference. Frees will also
> > refill one of the sheaves.
> >
> > When both percpu sheaves are found empty during an allocation, an empty
> > sheaf may be replaced with a full one from the per-node barn. If none
> > are available and the allocation is allowed to block, an empty sheaf is
> > refilled from slab(s) by an internal bulk alloc operation. When both
> > percpu sheaves are full during freeing, the barn can replace a full one
> > with an empty one, unless over a full sheaves limit. In that case a
> > sheaf is flushed to slab(s) by an internal bulk free operation. Flushin=
g
> > sheaves and barns is also wired to the existing cpu flushing and cache
> > shrinking operations.
> >
> > The sheaves do not distinguish NUMA locality of the cached objects. If
> > an allocation is requested with kmem_cache_alloc_node() with a specific
> > node (not NUMA_NO_NODE), sheaves are bypassed.
> >
> > The bulk operations exposed to slab users also try to utilize the
> > sheaves as long as the necessary (full or empty) sheaves are available
> > on the cpu or in the barn. Once depleted, they will fallback to bulk
> > alloc/free to slabs directly to avoid double copying.
> >
> > Sysfs stat counters alloc_cpu_sheaf and free_cpu_sheaf count objects
> > allocated or freed using the sheaves. Counters sheaf_refill,
> > sheaf_flush_main and sheaf_flush_other count objects filled or flushed
> > from or to slab pages, and can be used to assess how effective the
> > caching is. The refill and flush operations will also count towards the
> > usual alloc_fastpath/slowpath, free_fastpath/slowpath and other
> > counters.
> >
> > Access to the percpu sheaves is protected by local_lock_irqsave()
> > operations, each per-NUMA-node barn has a spin_lock.
> >
> > A current limitation is that when slub_debug is enabled for a cache wit=
h
> > percpu sheaves, the objects in the array are considered as allocated fr=
om
> > the slub_debug perspective, and the alloc/free debugging hooks occur
> > when moving the objects between the array and slab pages. This means
> > that e.g. an use-after-free that occurs for an object cached in the
> > array is undetected. Collected alloc/free stacktraces might also be les=
s
> > useful. This limitation could be changed in the future.
> >
> > On the other hand, KASAN, kmemcg and other hooks are executed on actual
> > allocations and frees by kmem_cache users even if those use the array,
> > so their debugging or accounting accuracy should be unaffected.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> Only one possible issue in __pcs_flush_all_cpu(), all other comments
> are nits and suggestions.
>
> > ---
> >  include/linux/slab.h |  34 ++
> >  mm/slab.h            |   2 +
> >  mm/slab_common.c     |   5 +-
> >  mm/slub.c            | 982 +++++++++++++++++++++++++++++++++++++++++++=
+++++---
> >  4 files changed, 973 insertions(+), 50 deletions(-)
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 7686054dd494cc65def7f58748718e03eb78e481..0e1b25228c77140d05b5b44=
33c9d7923de36ec05 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -332,6 +332,40 @@ struct kmem_cache_args {
> >          * %NULL means no constructor.
> >          */
> >         void (*ctor)(void *);
> > +       /**
> > +        * @sheaf_capacity: Enable sheaves of given capacity for the ca=
che.
> > +        *
> > +        * With a non-zero value, allocations from the cache go through=
 caching
> > +        * arrays called sheaves. Each cpu has a main sheaf that's alwa=
ys
> > +        * present, and a spare sheaf thay may be not present. When bot=
h become
> > +        * empty, there's an attempt to replace an empty sheaf with a f=
ull sheaf
> > +        * from the per-node barn.
> > +        *
> > +        * When no full sheaf is available, and gfp flags allow blockin=
g, a
> > +        * sheaf is allocated and filled from slab(s) using bulk alloca=
tion.
> > +        * Otherwise the allocation falls back to the normal operation
> > +        * allocating a single object from a slab.
> > +        *
> > +        * Analogically when freeing and both percpu sheaves are full, =
the barn
> > +        * may replace it with an empty sheaf, unless it's over capacit=
y. In
> > +        * that case a sheaf is bulk freed to slab pages.
> > +        *
> > +        * The sheaves does not distinguish NUMA placement of objects, =
so
> > +        * allocations via kmem_cache_alloc_node() with a node specifie=
d other
> > +        * than NUMA_NO_NODE will bypass them.
> > +        *
> > +        * Bulk allocation and free operations also try to use the cpu =
sheaves
> > +        * and barn, but fallback to using slab pages directly.
> > +        *
> > +        * Limitations: when slub_debug is enabled for the cache, all r=
elevant
> > +        * actions (i.e. poisoning, obtaining stacktraces) and checks h=
appen
> > +        * when objects move between sheaves and slab pages, which may =
result in
> > +        * e.g. not detecting a use-after-free while the object is in t=
he array
> > +        * cache, and the stacktraces may be less useful.
>
> I would also love to see a short comparison of sheaves (when objects
> are freed using kfree_rcu()) vs SLAB_TYPESAFE_BY_RCU. I think both
> mechanisms rcu-free objects in bulk but sheaves would not reuse an
> object before RCU grace period is passed. Is that right?
>
> > +        *
> > +        * %0 means no sheaves will be created
> > +        */
> > +       unsigned int sheaf_capacity;
> >  };
> >
> >  struct kmem_cache *__kmem_cache_create_args(const char *name,
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 2f01c7317988ce036f0b22807403226a59f0f708..8daaec53b6ecfc44171191d=
421adb12e5cba2c58 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -259,6 +259,7 @@ struct kmem_cache {
> >  #ifndef CONFIG_SLUB_TINY
> >         struct kmem_cache_cpu __percpu *cpu_slab;
> >  #endif
> > +       struct slub_percpu_sheaves __percpu *cpu_sheaves;
> >         /* Used for retrieving partial slabs, etc. */
> >         slab_flags_t flags;
> >         unsigned long min_partial;
> > @@ -272,6 +273,7 @@ struct kmem_cache {
> >         /* Number of per cpu partial slabs to keep around */
> >         unsigned int cpu_partial_slabs;
> >  #endif
> > +       unsigned int sheaf_capacity;
> >         struct kmem_cache_order_objects oo;
> >
> >         /* Allocation and freeing of slabs */
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 46d0a4cd33b5982fd79c307d572f231fdea9514a..ceeefb287899a82f30ad79b=
403556001c1860311 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -163,6 +163,9 @@ int slab_unmergeable(struct kmem_cache *s)
> >                 return 1;
> >  #endif
> >
> > +       if (s->cpu_sheaves)
> > +               return 1;
> > +
> >         /*
> >          * We may have set a slab to be unmergeable during bootstrap.
> >          */
> > @@ -328,7 +331,7 @@ struct kmem_cache *__kmem_cache_create_args(const c=
har *name,
> >                     object_size - args->usersize < args->useroffset))
> >                 args->usersize =3D args->useroffset =3D 0;
> >
> > -       if (!args->usersize)
> > +       if (!args->usersize && !args->sheaf_capacity)
> >                 s =3D __kmem_cache_alias(name, object_size, args->align=
, flags,
> >                                        args->ctor);
> >         if (s)
> > diff --git a/mm/slub.c b/mm/slub.c
> > index e8273f28656936c05d015c53923f8fe69cd161b2..c06734912972b799f537359=
f7fe6a750918ffe9e 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -346,8 +346,10 @@ static inline void debugfs_slab_add(struct kmem_ca=
che *s) { }
> >  #endif
> >
> >  enum stat_item {
> > +       ALLOC_PCS,              /* Allocation from percpu sheaf */
> >         ALLOC_FASTPATH,         /* Allocation from cpu slab */
> >         ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab=
 */
> > +       FREE_PCS,               /* Free to percpu sheaf */
> >         FREE_FASTPATH,          /* Free to cpu slab */
> >         FREE_SLOWPATH,          /* Freeing not to cpu slab */
> >         FREE_FROZEN,            /* Freeing to frozen slab */
> > @@ -372,6 +374,12 @@ enum stat_item {
> >         CPU_PARTIAL_FREE,       /* Refill cpu partial on free */
> >         CPU_PARTIAL_NODE,       /* Refill cpu partial from node partial=
 */
> >         CPU_PARTIAL_DRAIN,      /* Drain cpu partial to node partial */
> > +       SHEAF_FLUSH_MAIN,       /* Objects flushed from main percpu she=
af */
> > +       SHEAF_FLUSH_OTHER,      /* Objects flushed from other sheaves *=
/
> > +       SHEAF_REFILL,           /* Objects refilled to a sheaf */
> > +       SHEAF_SWAP,             /* Swapping main and spare sheaf */
> > +       SHEAF_ALLOC,            /* Allocation of an empty sheaf */
> > +       SHEAF_FREE,             /* Freeing of an empty sheaf */
> >         NR_SLUB_STAT_ITEMS
> >  };
> >
> > @@ -418,6 +426,35 @@ void stat_add(const struct kmem_cache *s, enum sta=
t_item si, int v)
> >  #endif
> >  }
> >
> > +#define MAX_FULL_SHEAVES       10
> > +#define MAX_EMPTY_SHEAVES      10
> > +
> > +struct node_barn {
> > +       spinlock_t lock;
> > +       struct list_head sheaves_full;
> > +       struct list_head sheaves_empty;
> > +       unsigned int nr_full;
> > +       unsigned int nr_empty;
> > +};
> > +
> > +struct slab_sheaf {
> > +       union {
> > +               struct rcu_head rcu_head;
> > +               struct list_head barn_list;
> > +       };
> > +       struct kmem_cache *cache;
> > +       unsigned int size;
> > +       void *objects[];
> > +};
> > +
> > +struct slub_percpu_sheaves {
> > +       local_lock_t lock;
> > +       struct slab_sheaf *main; /* never NULL when unlocked */
> > +       struct slab_sheaf *spare; /* empty or full, may be NULL */
> > +       struct slab_sheaf *rcu_free;
>
> Would be nice to have a short comment for rcu_free as well. I could
> guess what main and spare are but for rcu_free had to look further.
>
> > +       struct node_barn *barn;
> > +};
> > +
> >  /*
> >   * The slab lists for all objects.
> >   */
> > @@ -430,6 +467,7 @@ struct kmem_cache_node {
> >         atomic_long_t total_objects;
> >         struct list_head full;
> >  #endif
> > +       struct node_barn *barn;
> >  };
> >
> >  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, i=
nt node)
> > @@ -453,12 +491,19 @@ static inline struct kmem_cache_node *get_node(st=
ruct kmem_cache *s, int node)
> >   */
> >  static nodemask_t slab_nodes;
> >
> > -#ifndef CONFIG_SLUB_TINY
> >  /*
> >   * Workqueue used for flush_cpu_slab().
> >   */
> >  static struct workqueue_struct *flushwq;
> > -#endif
> > +
> > +struct slub_flush_work {
> > +       struct work_struct work;
> > +       struct kmem_cache *s;
> > +       bool skip;
> > +};
> > +
> > +static DEFINE_MUTEX(flush_lock);
> > +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
> >
> >  /********************************************************************
> >   *                     Core slab cache functions
> > @@ -2410,6 +2455,349 @@ static void *setup_object(struct kmem_cache *s,=
 void *object)
> >         return object;
> >  }
> >
> > +static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_=
t gfp)
> > +{
> > +       struct slab_sheaf *sheaf =3D kzalloc(struct_size(sheaf, objects=
,
> > +                                       s->sheaf_capacity), gfp);
> > +
> > +       if (unlikely(!sheaf))
> > +               return NULL;
> > +
> > +       sheaf->cache =3D s;

Forgot to mention. I don't see sheaf->cache being used anywhere here.
I'll assume it's used in later patches...

> > +
> > +       stat(s, SHEAF_ALLOC);
> > +
> > +       return sheaf;
> > +}
> > +
> > +static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *=
sheaf)
> > +{
> > +       kfree(sheaf);
> > +
> > +       stat(s, SHEAF_FREE);
> > +}
> > +
> > +static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> > +                                  size_t size, void **p);
> > +
> > +
> > +static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf=
,
> > +                        gfp_t gfp)
> > +{
> > +       int to_fill =3D s->sheaf_capacity - sheaf->size;
> > +       int filled;
> > +
> > +       if (!to_fill)
> > +               return 0;
> > +
> > +       filled =3D __kmem_cache_alloc_bulk(s, gfp, to_fill,
> > +                                        &sheaf->objects[sheaf->size]);
> > +
> > +       if (!filled)
> > +               return -ENOMEM;
> > +
> > +       sheaf->size =3D s->sheaf_capacity;
>
> nit: __kmem_cache_alloc_bulk() either allocates requested number of
> objects or returns 0, so the current code is fine but if at some point
> the implementation changes so that it can return smaller number of
> objects than requested (filled < to_fill) then the above assignment
> will become invalid. I think a safer thing here would be to just:
>
>        sheaf->size +=3D filled;
>
> which also makes logical sense. Alternatively you could add
> VM_BUG_ON(filled !=3D to_fill) but the increment I think would be
> better.
>
> > +
> > +       stat_add(s, SHEAF_REFILL, filled);
> > +
> > +       return 0;
> > +}
> > +
> > +
> > +static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t=
 gfp)
> > +{
> > +       struct slab_sheaf *sheaf =3D alloc_empty_sheaf(s, gfp);
> > +
> > +       if (!sheaf)
> > +               return NULL;
> > +
> > +       if (refill_sheaf(s, sheaf, gfp)) {
> > +               free_empty_sheaf(s, sheaf);
> > +               return NULL;
> > +       }
> > +
> > +       return sheaf;
> > +}
> > +
> > +/*
> > + * Maximum number of objects freed during a single flush of main pcs s=
heaf.
> > + * Translates directly to an on-stack array size.
> > + */
> > +#define PCS_BATCH_MAX  32U
> > +
> .> +static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t
> size, void **p);
> > +
>
> A comment clarifying why you are freeing in PCS_BATCH_MAX batches here
> would be helpful. My understanding is that you do that to free objects
> outside of the cpu_sheaves->lock, so you isolate a batch, release the
> lock and then free the batch.
>
> > +static void sheaf_flush_main(struct kmem_cache *s)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +       unsigned int batch, remaining;
> > +       void *objects[PCS_BATCH_MAX];
> > +       struct slab_sheaf *sheaf;
> > +       unsigned long flags;
> > +
> > +next_batch:
> > +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> > +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > +       sheaf =3D pcs->main;
> > +
> > +       batch =3D min(PCS_BATCH_MAX, sheaf->size);
> > +
> > +       sheaf->size -=3D batch;
> > +       memcpy(objects, sheaf->objects + sheaf->size, batch * sizeof(vo=
id *));
> > +
> > +       remaining =3D sheaf->size;
> > +
> > +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +       __kmem_cache_free_bulk(s, batch, &objects[0]);
> > +
> > +       stat_add(s, SHEAF_FLUSH_MAIN, batch);
> > +
> > +       if (remaining)
> > +               goto next_batch;
> > +}
> > +
>
> This function seems to be used against either isolated sheaves or in
> slub_cpu_dead() --> __pcs_flush_all_cpu() path where we hold
> slab_mutex and I think that guarantees that the sheaf is unused. Maybe
> a short comment clarifying this requirement or rename the function to
> reflect that? Something like flush_unused_sheaf()?
>
> > +static void sheaf_flush(struct kmem_cache *s, struct slab_sheaf *sheaf=
)
> > +{
> > +       if (!sheaf->size)
> > +               return;
> > +
> > +       stat_add(s, SHEAF_FLUSH_OTHER, sheaf->size);
> > +
> > +       __kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
> > +
> > +       sheaf->size =3D 0;
> > +}
> > +
> > +/*
> > + * Caller needs to make sure migration is disabled in order to fully f=
lush
> > + * single cpu's sheaves
> > + *
> > + * flushing operations are rare so let's keep it simple and flush to s=
labs
> > + * directly, skipping the barn
> > + */
> > +static void pcs_flush_all(struct kmem_cache *s)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +       struct slab_sheaf *spare, *rcu_free;
> > +       unsigned long flags;
> > +
> > +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> > +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > +
> > +       spare =3D pcs->spare;
> > +       pcs->spare =3D NULL;
> > +
> > +       rcu_free =3D pcs->rcu_free;
> > +       pcs->rcu_free =3D NULL;
> > +
> > +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +       if (spare) {
> > +               sheaf_flush(s, spare);
> > +               free_empty_sheaf(s, spare);
> > +       }
> > +
> > +       // TODO: handle rcu_free
> > +       BUG_ON(rcu_free);
> > +
> > +       sheaf_flush_main(s);
> > +}
> > +
> > +static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu=
)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +
> > +       pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> > +
> > +       if (pcs->spare) {
> > +               sheaf_flush(s, pcs->spare);
> > +               free_empty_sheaf(s, pcs->spare);
> > +               pcs->spare =3D NULL;
> > +       }
> > +
> > +       // TODO: handle rcu_free
> > +       BUG_ON(pcs->rcu_free);
> > +
> > +       sheaf_flush_main(s);
>
> Hmm. sheaf_flush_main() always flushes for this_cpu only, so IIUC this
> call will not necessarily flush the main sheaf for the cpu passed to
> __pcs_flush_all_cpu().
>
> > +}
> > +
> > +static void pcs_destroy(struct kmem_cache *s)
> > +{
> > +       int cpu;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               struct slub_percpu_sheaves *pcs;
> > +
> > +               pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> > +
> > +               /* can happen when unwinding failed create */
> > +               if (!pcs->main)
> > +                       continue;
> > +
> > +               WARN_ON(pcs->spare);
> > +               WARN_ON(pcs->rcu_free);
> > +
> > +               if (!WARN_ON(pcs->main->size)) {
> > +                       free_empty_sheaf(s, pcs->main);
> > +                       pcs->main =3D NULL;
> > +               }
> > +       }
> > +
> > +       free_percpu(s->cpu_sheaves);
> > +       s->cpu_sheaves =3D NULL;
> > +}
> > +
> > +static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
> > +{
> > +       struct slab_sheaf *empty =3D NULL;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&barn->lock, flags);
> > +
> > +       if (barn->nr_empty) {
> > +               empty =3D list_first_entry(&barn->sheaves_empty,
> > +                                        struct slab_sheaf, barn_list);
> > +               list_del(&empty->barn_list);
> > +               barn->nr_empty--;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&barn->lock, flags);
> > +
> > +       return empty;
> > +}
> > +
> > +static int barn_put_empty_sheaf(struct node_barn *barn,
> > +                               struct slab_sheaf *sheaf, bool ignore_l=
imit)
> > +{
> > +       unsigned long flags;
> > +       int ret =3D 0;
> > +
> > +       spin_lock_irqsave(&barn->lock, flags);
> > +
> > +       if (!ignore_limit && barn->nr_empty >=3D MAX_EMPTY_SHEAVES) {
> > +               ret =3D -E2BIG;
> > +       } else {
> > +               list_add(&sheaf->barn_list, &barn->sheaves_empty);
> > +               barn->nr_empty++;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&barn->lock, flags);
> > +       return ret;
> > +}
> > +
> > +static int barn_put_full_sheaf(struct node_barn *barn, struct slab_she=
af *sheaf,
> > +                              bool ignore_limit)
> > +{
> > +       unsigned long flags;
> > +       int ret =3D 0;
> > +
> > +       spin_lock_irqsave(&barn->lock, flags);
> > +
> > +       if (!ignore_limit && barn->nr_full >=3D MAX_FULL_SHEAVES) {
> > +               ret =3D -E2BIG;
> > +       } else {
> > +               list_add(&sheaf->barn_list, &barn->sheaves_full);
> > +               barn->nr_full++;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&barn->lock, flags);
> > +       return ret;
> > +}
> > +
> > +/*
> > + * If a full sheaf is available, return it and put the supplied empty =
one to
> > + * barn. We ignore the limit on empty sheaves as the number of sheaves=
 doesn't
> > + * change.
> > + */
> > +static struct slab_sheaf *
> > +barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *em=
pty)
> > +{
> > +       struct slab_sheaf *full =3D NULL;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&barn->lock, flags);
> > +
> > +       if (barn->nr_full) {
> > +               full =3D list_first_entry(&barn->sheaves_full, struct s=
lab_sheaf,
> > +                                       barn_list);
> > +               list_del(&full->barn_list);
> > +               list_add(&empty->barn_list, &barn->sheaves_empty);
> > +               barn->nr_full--;
> > +               barn->nr_empty++;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&barn->lock, flags);
> > +
> > +       return full;
> > +}
> > +/*
> > + * If a empty sheaf is available, return it and put the supplied full =
one to
> > + * barn. But if there are too many full sheaves, reject this with -E2B=
IG.
> > + */
> > +static struct slab_sheaf *
> > +barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *ful=
l)
> > +{
> > +       struct slab_sheaf *empty;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&barn->lock, flags);
> > +
> > +       if (barn->nr_full >=3D MAX_FULL_SHEAVES) {
> > +               empty =3D ERR_PTR(-E2BIG);
> > +       } else if (!barn->nr_empty) {
> > +               empty =3D ERR_PTR(-ENOMEM);
> > +       } else {
> > +               empty =3D list_first_entry(&barn->sheaves_empty, struct=
 slab_sheaf,
> > +                                        barn_list);
> > +               list_del(&empty->barn_list);
> > +               list_add(&full->barn_list, &barn->sheaves_full);
> > +               barn->nr_empty--;
> > +               barn->nr_full++;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&barn->lock, flags);
> > +
> > +       return empty;
> > +}
> > +
> > +static void barn_init(struct node_barn *barn)
> > +{
> > +       spin_lock_init(&barn->lock);
> > +       INIT_LIST_HEAD(&barn->sheaves_full);
> > +       INIT_LIST_HEAD(&barn->sheaves_empty);
> > +       barn->nr_full =3D 0;
> > +       barn->nr_empty =3D 0;
> > +}
> > +
> > +static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
> > +{
> > +       struct list_head empty_list;
> > +       struct list_head full_list;
> > +       struct slab_sheaf *sheaf, *sheaf2;
> > +       unsigned long flags;
> > +
> > +       INIT_LIST_HEAD(&empty_list);
> > +       INIT_LIST_HEAD(&full_list);
> > +
> > +       spin_lock_irqsave(&barn->lock, flags);
> > +
> > +       list_splice_init(&barn->sheaves_full, &full_list);
> > +       barn->nr_full =3D 0;
> > +       list_splice_init(&barn->sheaves_empty, &empty_list);
> > +       barn->nr_empty =3D 0;
> > +
> > +       spin_unlock_irqrestore(&barn->lock, flags);
> > +
> > +       list_for_each_entry_safe(sheaf, sheaf2, &full_list, barn_list) =
{
> > +               sheaf_flush(s, sheaf);
> > +               list_move(&sheaf->barn_list, &empty_list);
> > +       }
> > +
> > +       list_for_each_entry_safe(sheaf, sheaf2, &empty_list, barn_list)
> > +               free_empty_sheaf(s, sheaf);
> > +}
> > +
> >  /*
> >   * Slab allocation and freeing
> >   */
> > @@ -3280,11 +3668,42 @@ static inline void __flush_cpu_slab(struct kmem=
_cache *s, int cpu)
> >         put_partials_cpu(s, c);
> >  }
> >
> > -struct slub_flush_work {
> > -       struct work_struct work;
> > -       struct kmem_cache *s;
> > -       bool skip;
> > -};
> > +static inline void flush_this_cpu_slab(struct kmem_cache *s)
> > +{
> > +       struct kmem_cache_cpu *c =3D this_cpu_ptr(s->cpu_slab);
> > +
> > +       if (c->slab)
> > +               flush_slab(s, c);
> > +
> > +       put_partials(s);
> > +}
> > +
> > +static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> > +{
> > +       struct kmem_cache_cpu *c =3D per_cpu_ptr(s->cpu_slab, cpu);
> > +
> > +       return c->slab || slub_percpu_partial(c);
> > +}
> > +
> > +#else /* CONFIG_SLUB_TINY */
> > +static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
> > +static inline bool has_cpu_slab(int cpu, struct kmem_cache *s) { retur=
n false; }
> > +static inline void flush_this_cpu_slab(struct kmem_cache *s) { }
> > +#endif /* CONFIG_SLUB_TINY */
> > +
> > +static bool has_pcs_used(int cpu, struct kmem_cache *s)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +
> > +       if (!s->cpu_sheaves)
> > +               return false;
> > +
> > +       pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> > +
> > +       return (pcs->spare || pcs->rcu_free || pcs->main->size);
> > +}
> > +
> > +static void pcs_flush_all(struct kmem_cache *s);
> >
> >  /*
> >   * Flush cpu slab.
> > @@ -3294,30 +3713,18 @@ struct slub_flush_work {
> >  static void flush_cpu_slab(struct work_struct *w)
> >  {
> >         struct kmem_cache *s;
> > -       struct kmem_cache_cpu *c;
> >         struct slub_flush_work *sfw;
> >
> >         sfw =3D container_of(w, struct slub_flush_work, work);
> >
> >         s =3D sfw->s;
> > -       c =3D this_cpu_ptr(s->cpu_slab);
> >
> > -       if (c->slab)
> > -               flush_slab(s, c);
> > -
> > -       put_partials(s);
> > -}
> > -
> > -static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> > -{
> > -       struct kmem_cache_cpu *c =3D per_cpu_ptr(s->cpu_slab, cpu);
> > +       if (s->cpu_sheaves)
> > +               pcs_flush_all(s);
> >
> > -       return c->slab || slub_percpu_partial(c);
> > +       flush_this_cpu_slab(s);
> >  }
> >
> > -static DEFINE_MUTEX(flush_lock);
> > -static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
> > -
> >  static void flush_all_cpus_locked(struct kmem_cache *s)
> >  {
> >         struct slub_flush_work *sfw;
> > @@ -3328,7 +3735,7 @@ static void flush_all_cpus_locked(struct kmem_cac=
he *s)
> >
> >         for_each_online_cpu(cpu) {
> >                 sfw =3D &per_cpu(slub_flush, cpu);
> > -               if (!has_cpu_slab(cpu, s)) {
> > +               if (!has_cpu_slab(cpu, s) && !has_pcs_used(cpu, s)) {
> >                         sfw->skip =3D true;
> >                         continue;
> >                 }
> > @@ -3364,19 +3771,14 @@ static int slub_cpu_dead(unsigned int cpu)
> >         struct kmem_cache *s;
> >
> >         mutex_lock(&slab_mutex);
> > -       list_for_each_entry(s, &slab_caches, list)
> > +       list_for_each_entry(s, &slab_caches, list) {
> >                 __flush_cpu_slab(s, cpu);
> > +               __pcs_flush_all_cpu(s, cpu);
> > +       }
> >         mutex_unlock(&slab_mutex);
> >         return 0;
> >  }
> >
> > -#else /* CONFIG_SLUB_TINY */
> > -static inline void flush_all_cpus_locked(struct kmem_cache *s) { }
> > -static inline void flush_all(struct kmem_cache *s) { }
> > -static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
> > -static inline int slub_cpu_dead(unsigned int cpu) { return 0; }
> > -#endif /* CONFIG_SLUB_TINY */
> > -
> >  /*
> >   * Check if the objects in a per cpu structure fit numa
> >   * locality expectations.
> > @@ -4126,6 +4528,173 @@ bool slab_post_alloc_hook(struct kmem_cache *s,=
 struct list_lru *lru,
> >         return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
> >  }
> >
> > +static __fastpath_inline
> > +void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +       unsigned long flags;
> > +       void *object;
> > +
> > +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> > +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > +
> > +       if (unlikely(pcs->main->size =3D=3D 0)) {
> > +
> > +               struct slab_sheaf *empty =3D NULL;
> > +               struct slab_sheaf *full;
> > +               bool can_alloc;
> > +
> > +               if (pcs->spare && pcs->spare->size > 0) {
> > +                       stat(s, SHEAF_SWAP);
> > +                       swap(pcs->main, pcs->spare);
> > +                       goto do_alloc;
> > +               }
> > +
> > +               full =3D barn_replace_empty_sheaf(pcs->barn, pcs->main)=
;
> > +
> > +               if (full) {
> > +                       pcs->main =3D full;
> > +                       goto do_alloc;
> > +               }
> > +
> > +               can_alloc =3D gfpflags_allow_blocking(gfp);
> > +
> > +               if (can_alloc) {
> > +                       if (pcs->spare) {
> > +                               empty =3D pcs->spare;
> > +                               pcs->spare =3D NULL;
> > +                       } else {
> > +                               empty =3D barn_get_empty_sheaf(pcs->bar=
n);
> > +                       }
> > +               }
> > +
> > +               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +               if (!can_alloc)
> > +                       return NULL;
> > +
> > +               if (empty) {
> > +                       if (!refill_sheaf(s, empty, gfp)) {
> > +                               full =3D empty;
> > +                       } else {
> > +                               /*
> > +                                * we must be very low on memory so don=
't bother
> > +                                * with the barn
> > +                                */
> > +                               free_empty_sheaf(s, empty);
> > +                       }
> > +               } else {
> > +                       full =3D alloc_full_sheaf(s, gfp);
> > +               }
> > +
> > +               if (!full)
> > +                       return NULL;
> > +
> > +               local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> > +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > +
> > +               /*
> > +                * If we are returning empty sheaf, we either got it fr=
om the
> > +                * barn or had to allocate one. If we are returning a f=
ull
> > +                * sheaf, it's due to racing or being migrated to a dif=
ferent
> > +                * cpu. Breaching the barn's sheaf limits should be thu=
s rare
> > +                * enough so just ignore them to simplify the recovery.
> > +                */
> > +
> > +               if (pcs->main->size =3D=3D 0) {
> > +                       barn_put_empty_sheaf(pcs->barn, pcs->main, true=
);
> > +                       pcs->main =3D full;
> > +                       goto do_alloc;
> > +               }
> > +
> > +               if (!pcs->spare) {
> > +                       pcs->spare =3D full;
> > +                       goto do_alloc;
> > +               }
> > +
> > +               if (pcs->spare->size =3D=3D 0) {
> > +                       barn_put_empty_sheaf(pcs->barn, pcs->spare, tru=
e);
> > +                       pcs->spare =3D full;
> > +                       goto do_alloc;
> > +               }
> > +
> > +               barn_put_full_sheaf(pcs->barn, full, true);
> > +       }
> > +
> > +do_alloc:
> > +       object =3D pcs->main->objects[--pcs->main->size];
> > +
> > +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +       stat(s, ALLOC_PCS);
> > +
> > +       return object;
> > +}
> > +
> > +static __fastpath_inline
> > +unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, vo=
id **p)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +       struct slab_sheaf *main;
> > +       unsigned long flags;
> > +       unsigned int allocated =3D 0;
> > +       unsigned int batch;
> > +
> > +next_batch:
> > +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> > +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > +
> > +       if (unlikely(pcs->main->size =3D=3D 0)) {
> > +
> > +               struct slab_sheaf *full;
> > +
> > +               if (pcs->spare && pcs->spare->size > 0) {
> > +                       stat(s, SHEAF_SWAP);
> > +                       swap(pcs->main, pcs->spare);
> > +                       goto do_alloc;
> > +               }
> > +
> > +               full =3D barn_replace_empty_sheaf(pcs->barn, pcs->main)=
;
> > +
> > +               if (full) {
> > +                       pcs->main =3D full;
> > +                       goto do_alloc;
> > +               }
> > +
> > +               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +               /*
> > +                * Once full sheaves in barn are depleted, let the bulk
> > +                * allocation continue from slab pages, otherwise we wo=
uld just
> > +                * be copying arrays of pointers twice.
> > +                */
> > +               return allocated;
> > +       }
> > +
> > +do_alloc:
> > +
> > +       main =3D pcs->main;
> > +       batch =3D min(size, main->size);
> > +
> > +       main->size -=3D batch;
> > +       memcpy(p, main->objects + main->size, batch * sizeof(void *));
> > +
> > +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +       stat_add(s, ALLOC_PCS, batch);
> > +
> > +       allocated +=3D batch;
> > +
> > +       if (batch < size) {
> > +               p +=3D batch;
> > +               size -=3D batch;
> > +               goto next_batch;
> > +       }
> > +
> > +       return allocated;
> > +}
> > +
> > +
> >  /*
> >   * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_=
alloc)
> >   * have the fastpath folded into their functions. So no function call
> > @@ -4150,7 +4719,11 @@ static __fastpath_inline void *slab_alloc_node(s=
truct kmem_cache *s, struct list
> >         if (unlikely(object))
> >                 goto out;
> >
> > -       object =3D __slab_alloc_node(s, gfpflags, node, addr, orig_size=
);
> > +       if (s->cpu_sheaves && (node =3D=3D NUMA_NO_NODE))
> > +               object =3D alloc_from_pcs(s, gfpflags);
> > +
> > +       if (!object)
> > +               object =3D __slab_alloc_node(s, gfpflags, node, addr, o=
rig_size);
> >
> >         maybe_wipe_obj_freeptr(s, object);
> >         init =3D slab_want_init_on_alloc(gfpflags, s);
> > @@ -4521,6 +5094,196 @@ static void __slab_free(struct kmem_cache *s, s=
truct slab *slab,
> >         discard_slab(s, slab);
> >  }
> >
> > +/*
> > + * Free an object to the percpu sheaves.
> > + * The object is expected to have passed slab_free_hook() already.
> > + */
> > +static __fastpath_inline
> > +void free_to_pcs(struct kmem_cache *s, void *object)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +       unsigned long flags;
> > +
> > +restart:
> > +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> > +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > +
> > +       if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
> > +
> > +               struct slab_sheaf *empty;
> > +
> > +               if (!pcs->spare) {
> > +                       empty =3D barn_get_empty_sheaf(pcs->barn);
> > +                       if (empty) {
> > +                               pcs->spare =3D pcs->main;
> > +                               pcs->main =3D empty;
> > +                               goto do_free;
> > +                       }
> > +                       goto alloc_empty;
> > +               }
> > +
> > +               if (pcs->spare->size < s->sheaf_capacity) {
> > +                       stat(s, SHEAF_SWAP);
> > +                       swap(pcs->main, pcs->spare);
> > +                       goto do_free;
> > +               }
> > +
> > +               empty =3D barn_replace_full_sheaf(pcs->barn, pcs->main)=
;
> > +
> > +               if (!IS_ERR(empty)) {
> > +                       pcs->main =3D empty;
> > +                       goto do_free;
> > +               }
> > +
> > +               if (PTR_ERR(empty) =3D=3D -E2BIG) {
> > +                       /* Since we got here, spare exists and is full =
*/
> > +                       struct slab_sheaf *to_flush =3D pcs->spare;
> > +
> > +                       pcs->spare =3D NULL;
> > +                       local_unlock_irqrestore(&s->cpu_sheaves->lock, =
flags);
> > +
> > +                       sheaf_flush(s, to_flush);
> > +                       empty =3D to_flush;
> > +                       goto got_empty;
> > +               }
> > +
> > +alloc_empty:
> > +               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +               empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> > +
> > +               if (!empty) {
> > +                       sheaf_flush_main(s);
> > +                       goto restart;
> > +               }
> > +
> > +got_empty:
> > +               local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> > +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > +
> > +               /*
> > +                * if we put any sheaf to barn here, it's because we ra=
ced or
> > +                * have been migrated to a different cpu, which should =
be rare
> > +                * enough so just ignore the barn's limits to simplify
> > +                */
> > +               if (unlikely(pcs->main->size < s->sheaf_capacity)) {
> > +                       if (!pcs->spare)
> > +                               pcs->spare =3D empty;
> > +                       else
> > +                               barn_put_empty_sheaf(pcs->barn, empty, =
true);
> > +                       goto do_free;
> > +               }
> > +
> > +               if (!pcs->spare) {
> > +                       pcs->spare =3D pcs->main;
> > +                       pcs->main =3D empty;
> > +                       goto do_free;
> > +               }
> > +
> > +               barn_put_full_sheaf(pcs->barn, pcs->main, true);
> > +               pcs->main =3D empty;
>
> I find the program flow in this function quite complex and hard to
> follow. I think refactoring the above block starting from "pcs =3D
> this_cpu_ptr(s->cpu_sheaves)" would somewhat simplify it. That
> eliminates the need for the "got_empty" label and makes the
> locking/unlocking sequence of s->cpu_sheaves->lock a bit more clear.
>
> > +       }
> > +
> > +do_free:
> > +       pcs->main->objects[pcs->main->size++] =3D object;
> > +
> > +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +       stat(s, FREE_PCS);
> > +}
> > +
> > +/*
> > + * Bulk free objects to the percpu sheaves.
> > + * Unlike free_to_pcs() this includes the calls to all necessary hooks
> > + * and the fallback to freeing to slab pages.
> > + */
> > +static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void *=
*p)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +       struct slab_sheaf *main;
> > +       unsigned long flags;
> > +       unsigned int batch, i =3D 0;
> > +       bool init;
> > +
> > +       init =3D slab_want_init_on_free(s);
> > +
> > +       while (i < size) {
> > +               struct slab *slab =3D virt_to_slab(p[i]);
> > +
> > +               memcg_slab_free_hook(s, slab, p + i, 1);
> > +               alloc_tagging_slab_free_hook(s, slab, p + i, 1);
> > +
> > +               if (unlikely(!slab_free_hook(s, p[i], init, false))) {
> > +                       p[i] =3D p[--size];
> > +                       if (!size)
> > +                               return;
> > +                       continue;
> > +               }
> > +
> > +               i++;
> > +       }
> > +
> > +next_batch:
> > +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> > +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > +
> > +       if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
> > +
> > +               struct slab_sheaf *empty;
> > +
> > +               if (!pcs->spare) {
> > +                       empty =3D barn_get_empty_sheaf(pcs->barn);
> > +                       if (empty) {
> > +                               pcs->spare =3D pcs->main;
> > +                               pcs->main =3D empty;
> > +                               goto do_free;
> > +                       }
> > +                       goto no_empty;
> > +               }
> > +
> > +               if (pcs->spare->size < s->sheaf_capacity) {
> > +                       stat(s, SHEAF_SWAP);
> > +                       swap(pcs->main, pcs->spare);
> > +                       goto do_free;
> > +               }
> > +
> > +               empty =3D barn_replace_full_sheaf(pcs->barn, pcs->main)=
;
> > +
> > +               if (!IS_ERR(empty)) {
> > +                       pcs->main =3D empty;
> > +                       goto do_free;
> > +               }
> > +
> > +no_empty:
> > +               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +               /*
> > +                * if we depleted all empty sheaves in the barn or ther=
e are too
> > +                * many full sheaves, free the rest to slab pages
> > +                */
> > +
> > +               __kmem_cache_free_bulk(s, size, p);
> > +               return;
> > +       }
> > +
> > +do_free:
> > +       main =3D pcs->main;
> > +       batch =3D min(size, s->sheaf_capacity - main->size);
> > +
> > +       memcpy(main->objects + main->size, p, batch * sizeof(void *));
> > +       main->size +=3D batch;
> > +
> > +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> > +
> > +       stat_add(s, FREE_PCS, batch);
> > +
> > +       if (batch < size) {
> > +               p +=3D batch;
> > +               size -=3D batch;
> > +               goto next_batch;
> > +       }
> > +}
> > +
> >  #ifndef CONFIG_SLUB_TINY
> >  /*
> >   * Fastpath with forced inlining to produce a kfree and kmem_cache_fre=
e that
> > @@ -4607,7 +5370,12 @@ void slab_free(struct kmem_cache *s, struct slab=
 *slab, void *object,
> >         memcg_slab_free_hook(s, slab, &object, 1);
> >         alloc_tagging_slab_free_hook(s, slab, &object, 1);
> >
> > -       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s),=
 false)))
> > +       if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(=
s), false)))
> > +               return;
> > +
> > +       if (s->cpu_sheaves)
> > +               free_to_pcs(s, object);
> > +       else
> >                 do_slab_free(s, slab, object, object, 1, addr);
> >  }
> >
> > @@ -5033,6 +5801,15 @@ void kmem_cache_free_bulk(struct kmem_cache *s, =
size_t size, void **p)
> >         if (!size)
> >                 return;
> >
> > +       /*
> > +        * freeing to sheaves is so incompatible with the detached free=
list so
> > +        * once we go that way, we have to do everything differently
> > +        */
> > +       if (s && s->cpu_sheaves) {
> > +               free_to_pcs_bulk(s, size, p);
> > +               return;
> > +       }
> > +
> >         do {
> >                 struct detached_freelist df;
> >
> > @@ -5151,7 +5928,7 @@ static int __kmem_cache_alloc_bulk(struct kmem_ca=
che *s, gfp_t flags,
> >  int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, si=
ze_t size,
> >                                  void **p)
> >  {
> > -       int i;
> > +       unsigned int i =3D 0;
> >
> >         if (!size)
> >                 return 0;
> > @@ -5160,9 +5937,21 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cac=
he *s, gfp_t flags, size_t size,
> >         if (unlikely(!s))
> >                 return 0;
> >
> > -       i =3D __kmem_cache_alloc_bulk(s, flags, size, p);
> > -       if (unlikely(i =3D=3D 0))
> > -               return 0;
> > +       if (s->cpu_sheaves)
> > +               i =3D alloc_from_pcs_bulk(s, size, p);
> > +
> > +       if (i < size) {
> > +               unsigned int j =3D __kmem_cache_alloc_bulk(s, flags, si=
ze - i, p + i);
> > +               /*
> > +                * If we ran out of memory, don't bother with freeing b=
ack to
> > +                * the percpu sheaves, we have bigger problems.
> > +                */
> > +               if (unlikely(j =3D=3D 0)) {
> > +                       if (i > 0)
> > +                               __kmem_cache_free_bulk(s, i, p);
> > +                       return 0;
> > +               }
> > +       }
> >
> >         /*
> >          * memcg and kmem_cache debug support and memory initialization=
.
> > @@ -5172,11 +5961,11 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_ca=
che *s, gfp_t flags, size_t size,
> >                     slab_want_init_on_alloc(flags, s), s->object_size))=
) {
> >                 return 0;
> >         }
> > -       return i;
> > +
> > +       return size;
> >  }
> >  EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
> >
> > -
> >  /*
> >   * Object placement in a slab is made very easy because we always star=
t at
> >   * offset 0. If we tune the size of the object to the alignment then w=
e can
> > @@ -5309,8 +6098,8 @@ static inline int calculate_order(unsigned int si=
ze)
> >         return -ENOSYS;
> >  }
> >
> > -static void
> > -init_kmem_cache_node(struct kmem_cache_node *n)
> > +static bool
> > +init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn=
)
> >  {
> >         n->nr_partial =3D 0;
> >         spin_lock_init(&n->list_lock);
> > @@ -5320,6 +6109,11 @@ init_kmem_cache_node(struct kmem_cache_node *n)
> >         atomic_long_set(&n->total_objects, 0);
> >         INIT_LIST_HEAD(&n->full);
> >  #endif
> > +       n->barn =3D barn;
> > +       if (barn)
> > +               barn_init(barn);
> > +
> > +       return true;
> >  }
> >
> >  #ifndef CONFIG_SLUB_TINY
> > @@ -5350,6 +6144,30 @@ static inline int alloc_kmem_cache_cpus(struct k=
mem_cache *s)
> >  }
> >  #endif /* CONFIG_SLUB_TINY */
> >
> > +static int init_percpu_sheaves(struct kmem_cache *s)
> > +{
> > +       int cpu;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               struct slub_percpu_sheaves *pcs;
> > +               int nid;
> > +
> > +               pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> > +
> > +               local_lock_init(&pcs->lock);
> > +
> > +               nid =3D cpu_to_mem(cpu);
> > +
> > +               pcs->barn =3D get_node(s, nid)->barn;
> > +               pcs->main =3D alloc_empty_sheaf(s, GFP_KERNEL);
> > +
> > +               if (!pcs->main)
> > +                       return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static struct kmem_cache *kmem_cache_node;
> >
> >  /*
> > @@ -5385,7 +6203,7 @@ static void early_kmem_cache_node_alloc(int node)
> >         slab->freelist =3D get_freepointer(kmem_cache_node, n);
> >         slab->inuse =3D 1;
> >         kmem_cache_node->node[node] =3D n;
> > -       init_kmem_cache_node(n);
> > +       init_kmem_cache_node(n, NULL);
> >         inc_slabs_node(kmem_cache_node, node, slab->objects);
> >
> >         /*
> > @@ -5401,6 +6219,13 @@ static void free_kmem_cache_nodes(struct kmem_ca=
che *s)
> >         struct kmem_cache_node *n;
> >
> >         for_each_kmem_cache_node(s, node, n) {
> > +               if (n->barn) {
> > +                       WARN_ON(n->barn->nr_full);
> > +                       WARN_ON(n->barn->nr_empty);
> > +                       kfree(n->barn);
> > +                       n->barn =3D NULL;
> > +               }
> > +
> >                 s->node[node] =3D NULL;
> >                 kmem_cache_free(kmem_cache_node, n);
> >         }
> > @@ -5409,6 +6234,8 @@ static void free_kmem_cache_nodes(struct kmem_cac=
he *s)
> >  void __kmem_cache_release(struct kmem_cache *s)
> >  {
> >         cache_random_seq_destroy(s);
> > +       if (s->cpu_sheaves)
> > +               pcs_destroy(s);
> >  #ifndef CONFIG_SLUB_TINY
> >         free_percpu(s->cpu_slab);
> >  #endif
> > @@ -5421,20 +6248,27 @@ static int init_kmem_cache_nodes(struct kmem_ca=
che *s)
> >
> >         for_each_node_mask(node, slab_nodes) {
> >                 struct kmem_cache_node *n;
> > +               struct node_barn *barn =3D NULL;
> >
> >                 if (slab_state =3D=3D DOWN) {
> >                         early_kmem_cache_node_alloc(node);
> >                         continue;
> >                 }
> > +
> > +               if (s->cpu_sheaves) {
> > +                       barn =3D kmalloc_node(sizeof(*barn), GFP_KERNEL=
, node);
> > +
> > +                       if (!barn)
> > +                               return 0;
> > +               }
> > +
> >                 n =3D kmem_cache_alloc_node(kmem_cache_node,
> >                                                 GFP_KERNEL, node);
> > -
> > -               if (!n) {
> > -                       free_kmem_cache_nodes(s);
> > +               if (!n)
> >                         return 0;
> > -               }
> >
> > -               init_kmem_cache_node(n);
> > +               init_kmem_cache_node(n, barn);
> > +
> >                 s->node[node] =3D n;
> >         }
> >         return 1;
> > @@ -5690,6 +6524,8 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
> >         flush_all_cpus_locked(s);
> >         /* Attempt to free all objects */
> >         for_each_kmem_cache_node(s, node, n) {
> > +               if (n->barn)
> > +                       barn_shrink(s, n->barn);
> >                 free_partial(s, n);
> >                 if (n->nr_partial || node_nr_slabs(n))
> >                         return 1;
> > @@ -5893,6 +6729,9 @@ static int __kmem_cache_do_shrink(struct kmem_cac=
he *s)
> >                 for (i =3D 0; i < SHRINK_PROMOTE_MAX; i++)
> >                         INIT_LIST_HEAD(promote + i);
> >
> > +               if (n->barn)
> > +                       barn_shrink(s, n->barn);
> > +
> >                 spin_lock_irqsave(&n->list_lock, flags);
> >
> >                 /*
> > @@ -6005,12 +6844,24 @@ static int slab_mem_going_online_callback(void =
*arg)
> >          */
> >         mutex_lock(&slab_mutex);
> >         list_for_each_entry(s, &slab_caches, list) {
> > +               struct node_barn *barn =3D NULL;
> > +
> >                 /*
> >                  * The structure may already exist if the node was prev=
iously
> >                  * onlined and offlined.
> >                  */
> >                 if (get_node(s, nid))
> >                         continue;
> > +
> > +               if (s->cpu_sheaves) {
> > +                       barn =3D kmalloc_node(sizeof(*barn), GFP_KERNEL=
, nid);
> > +
> > +                       if (!barn) {
> > +                               ret =3D -ENOMEM;
> > +                               goto out;
> > +                       }
> > +               }
> > +
> >                 /*
> >                  * XXX: kmem_cache_alloc_node will fallback to other no=
des
> >                  *      since memory is not yet available from the node=
 that
> > @@ -6021,7 +6872,9 @@ static int slab_mem_going_online_callback(void *a=
rg)
> >                         ret =3D -ENOMEM;
> >                         goto out;
> >                 }
> > -               init_kmem_cache_node(n);
> > +
> > +               init_kmem_cache_node(n, barn);
> > +
> >                 s->node[nid] =3D n;
> >         }
> >         /*
> > @@ -6240,6 +7093,16 @@ int do_kmem_cache_create(struct kmem_cache *s, c=
onst char *name,
> >
> >         set_cpu_partial(s);
> >
> > +       if (args->sheaf_capacity) {
> > +               s->cpu_sheaves =3D alloc_percpu(struct slub_percpu_shea=
ves);
> > +               if (!s->cpu_sheaves) {
> > +                       err =3D -ENOMEM;
> > +                       goto out;
> > +               }
> > +               // TODO: increase capacity to grow slab_sheaf up to nex=
t kmalloc size?
> > +               s->sheaf_capacity =3D args->sheaf_capacity;
> > +       }
> > +
> >  #ifdef CONFIG_NUMA
> >         s->remote_node_defrag_ratio =3D 1000;
> >  #endif
> > @@ -6256,6 +7119,12 @@ int do_kmem_cache_create(struct kmem_cache *s, c=
onst char *name,
> >         if (!alloc_kmem_cache_cpus(s))
> >                 goto out;
> >
> > +       if (s->cpu_sheaves) {
> > +               err =3D init_percpu_sheaves(s);
> > +               if (err)
> > +                       goto out;
> > +       }
> > +
> >         err =3D 0;
> >
> >         /* Mutex is not taken during early boot */
> > @@ -6277,7 +7146,6 @@ int do_kmem_cache_create(struct kmem_cache *s, co=
nst char *name,
> >                 __kmem_cache_release(s);
> >         return err;
> >  }
> > -
> >  #ifdef SLAB_SUPPORTS_SYSFS
> >  static int count_inuse(struct slab *slab)
> >  {
> > @@ -7055,8 +7923,10 @@ static ssize_t text##_store(struct kmem_cache *s=
,                \
> >  }                                                              \
> >  SLAB_ATTR(text);                                               \
> >
> > +STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
> >  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
> >  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
> > +STAT_ATTR(FREE_PCS, free_cpu_sheaf);
> >  STAT_ATTR(FREE_FASTPATH, free_fastpath);
> >  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
> >  STAT_ATTR(FREE_FROZEN, free_frozen);
> > @@ -7081,6 +7951,12 @@ STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
> >  STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
> >  STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
> >  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
> > +STAT_ATTR(SHEAF_FLUSH_MAIN, sheaf_flush_main);
> > +STAT_ATTR(SHEAF_FLUSH_OTHER, sheaf_flush_other);
> > +STAT_ATTR(SHEAF_REFILL, sheaf_refill);
> > +STAT_ATTR(SHEAF_SWAP, sheaf_swap);
> > +STAT_ATTR(SHEAF_ALLOC, sheaf_alloc);
> > +STAT_ATTR(SHEAF_FREE, sheaf_free);
> >  #endif /* CONFIG_SLUB_STATS */
> >
> >  #ifdef CONFIG_KFENCE
> > @@ -7142,8 +8018,10 @@ static struct attribute *slab_attrs[] =3D {
> >         &remote_node_defrag_ratio_attr.attr,
> >  #endif
> >  #ifdef CONFIG_SLUB_STATS
> > +       &alloc_cpu_sheaf_attr.attr,
> >         &alloc_fastpath_attr.attr,
> >         &alloc_slowpath_attr.attr,
> > +       &free_cpu_sheaf_attr.attr,
> >         &free_fastpath_attr.attr,
> >         &free_slowpath_attr.attr,
> >         &free_frozen_attr.attr,
> > @@ -7168,6 +8046,12 @@ static struct attribute *slab_attrs[] =3D {
> >         &cpu_partial_free_attr.attr,
> >         &cpu_partial_node_attr.attr,
> >         &cpu_partial_drain_attr.attr,
> > +       &sheaf_flush_main_attr.attr,
> > +       &sheaf_flush_other_attr.attr,
> > +       &sheaf_refill_attr.attr,
> > +       &sheaf_swap_attr.attr,
> > +       &sheaf_alloc_attr.attr,
> > +       &sheaf_free_attr.attr,
> >  #endif
> >  #ifdef CONFIG_FAILSLAB
> >         &failslab_attr.attr,
> >
> > --
> > 2.48.1
> >
