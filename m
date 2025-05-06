Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C84B1E4B
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567289; cv=none; b=r/tzN+7J76rbVQgKY1AvmvyKnEnQa1hN9blSmSszCPLECQ3sDXUetB6+cSR5p5EKFJ64abx+kvCXnoBw3zqSJLaGSpO41izu+7ABPCuXvSJTvsaJOwjkcy/TjaPFsC8hV4C5cY67fF3kZGwbJ5IV1C5QEw5+qmADUd95imys6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567289; c=relaxed/simple;
	bh=w/x6LuzoSjWLFZFEz0QMESkey1sZE8BLCYVmXVN+2Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FarAEFp/pFXeTWMZVWISi5VpAoctfGmGaV1tj4iaoGJARC7EPXCPyiUKSlFFWNqZpmG5RuuT9FYNIVodYwspA2Brkfe3g+5keG72YaaEvJJOXVdgeiyB2raJkC9QIIqwLgr4i94/REuKR3OO8zDIOCOdEzwEMp2PAOBWxNIGD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kucprTwA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kucprTwA"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-48b7747f881so28001cf.1
        for <rcu@vger.kernel.org>; Tue, 06 May 2025 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746567286; x=1747172086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTY0HM/OQV3eIq9dHFagnDhjaDtC565iL3zCcgCqCrM=;
        b=kucprTwAKy53O7qjwAvZnjW+T/r1Ki1YUMTUD1iPcfMIncMndxGcf+gQEKue3Zd5aB
         xMmXS2JvnGfpi/v5tB3OIMZPnc3fl4yXiJkdmQrN5tutzIMmZdHbnam4w98cvi3X5xHc
         +wjEToApsidDmhrhDvFZmAZyMr8O6rPN2ovAv3RZqIpL+DfF/Jwy9OauPfIE3ke4RFHK
         to1Zh8iVwlTSGzs3/MLvEv6+DlgkJ7Ovh7jScI7txcUznaTUWhqgdFHkW3/U5PGT6d7O
         YVlDtvUnoVdsJcHMBSIWxoX1+SWXzrUWbAmvfLNpkYY3R/DuPHC2pSS6NR3zGtc045nQ
         22FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567286; x=1747172086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTY0HM/OQV3eIq9dHFagnDhjaDtC565iL3zCcgCqCrM=;
        b=dUxwYKJmr/3hfcbKr/T+q16O7pFRLvz88oPHzmcZCTjX03BiQl1dV8Wy+CFQWJx/LS
         bCzLCQHqiHufMGNGcqNl9jwww+ufOL4IdtUr9QxsGYRlIjjmISv7lPhanY9leDTkIBVg
         9PjFlTqmO6CSg36q07Nswp7kPnpmpekniilTFGVCItPWpPIM/PRuBYs4aVuik7mN0ude
         q8eZcH7ej7kw/Rge3QBkjoIIL4amyPoge5vKoALgkYy5ZNLTt+P4yBRMEU+QcZ6f+DyA
         DdNXCrvhsA6KDWdLOZDwcz9mAUaLZF9qFfWIkE1K8c0a7M/iq0TYr21jCdItEzgeiF28
         BLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXccDYBlVlCPEjbhT6VW5ajKysauWnDa/ktRMaLNP/sPggfKaxdJRsipO/l3iz5xpeBHOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4mqUvVFLMrbPEDJTLJhJfGuomtXT/nFjLWALZi94m45UN2Fb
	LLCJXftPHyVrzjcxKn64G4YAcdz+kdOhW7hIT5vesodkd4iHxhJLQ4KlGjhmO3OqtlTf1B/Lu0U
	XlSIF9Gf5LLnZq2tLjcFHO2Ta6SmwGaEAwRF8
X-Gm-Gg: ASbGncvQUGFioJvaLy1ssflhnOdtVTH90lpntQ9GoH3u7XW4sikvXzHBAOwSiALq6ht
	kdUGZ2fVchCwvhSCOvhA+C+fnE/P66UyURQuKyisl8YPCnbo57cTjdNmB5SigMdRhq3iGBeBCnR
	wUaezpudVzJsgPSaNGKpA1foi4zmCJpYUb7JRNo/MAemRi1kaEXybidoWKJh/jAQ==
X-Google-Smtp-Source: AGHT+IE47iWdF3PCooLGEAUO7EBuJixpjaL+7+CaNR3SivBwSMbKJFmepi+qI7SvfZMbEsQ8P8lBB5IrpUxHJrd7aLE=
X-Received: by 2002:a05:622a:1483:b0:478:f8ac:8adf with SMTP id
 d75a77b69052e-4924bb8c606mr265011cf.19.1746567286030; Tue, 06 May 2025
 14:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz> <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 6 May 2025 14:34:35 -0700
X-Gm-Features: ATxdqUGSiOBGEDn6zE2SG7X-AsLucq1KRn6XY-3__dSzGYspT3KdMvRW5uhaOA0
Message-ID: <CAJuCfpGVx2jG+S2ch2hqK=sAdmTcs9dW0kOdopxgLtH4V_wNXQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] slab: add sheaf support for batching kfree_rcu() operations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
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
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h        |   3 +
>  mm/slab_common.c |  24 ++++++++
>  mm/slub.c        | 183 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 208 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 1980330c2fcb4a4613a7e4f7efc78b349993fd89..ddf1e4bcba734dccbf67e83bd=
bab3ca7272f540e 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -459,6 +459,9 @@ static inline bool is_kmalloc_normal(struct kmem_cach=
e *s)
>         return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACC=
OUNT));
>  }
>
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +
> +/* Legal flag mask for kmem_cache_create(), for various configurations *=
/
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
>                          SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4f295bdd2d42355af6311a799955301005f8a532..6c3b90f03cb79b57f42682445=
0f576a977d85c53 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1608,6 +1608,27 @@ static void kfree_rcu_work(struct work_struct *wor=
k)
>                 kvfree_rcu_list(head);
>  }
>
> +static bool kfree_rcu_sheaf(void *obj)
> +{
> +       struct kmem_cache *s;
> +       struct folio *folio;
> +       struct slab *slab;
> +
> +       if (is_vmalloc_addr(obj))
> +               return false;
> +
> +       folio =3D virt_to_folio(obj);
> +       if (unlikely(!folio_test_slab(folio)))
> +               return false;
> +
> +       slab =3D folio_slab(folio);
> +       s =3D slab->slab_cache;
> +       if (s->cpu_sheaves)
> +               return __kfree_rcu_sheaf(s, obj);
> +
> +       return false;
> +}
> +
>  static bool
>  need_offload_krc(struct kfree_rcu_cpu *krcp)
>  {
> @@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *p=
tr)
>         if (!head)
>                 might_sleep();
>
> +       if (kfree_rcu_sheaf(ptr))
> +               return;
> +
>         // Queue the object but don't yet schedule the batch.
>         if (debug_rcu_head_queue(ptr)) {
>                 // Probable double kfree_rcu(), just leak.
> diff --git a/mm/slub.c b/mm/slub.c
> index ae3e80ad9926ca15601eef2f2aa016ca059498f8..6f31a27b5d47fa6621fa8af6d=
6842564077d4b60 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -350,6 +350,8 @@ enum stat_item {
>         ALLOC_FASTPATH,         /* Allocation from cpu slab */
>         ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab *=
/
>         FREE_PCS,               /* Free to percpu sheaf */
> +       FREE_RCU_SHEAF,         /* Free to rcu_free sheaf */
> +       FREE_RCU_SHEAF_FAIL,    /* Failed to free to a rcu_free sheaf */
>         FREE_FASTPATH,          /* Free to cpu slab */
>         FREE_SLOWPATH,          /* Freeing not to cpu slab */
>         FREE_FROZEN,            /* Freeing to frozen slab */
> @@ -444,6 +446,7 @@ struct slab_sheaf {
>                 struct rcu_head rcu_head;
>                 struct list_head barn_list;
>         };
> +       struct kmem_cache *cache;
>         unsigned int size;
>         void *objects[];
>  };
> @@ -452,6 +455,7 @@ struct slub_percpu_sheaves {
>         local_trylock_t lock;
>         struct slab_sheaf *main; /* never NULL when unlocked */
>         struct slab_sheaf *spare; /* empty or full, may be NULL */
> +       struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
>         struct node_barn *barn;
>  };
>
> @@ -2507,6 +2511,8 @@ static struct slab_sheaf *alloc_empty_sheaf(struct =
kmem_cache *s, gfp_t gfp)
>         if (unlikely(!sheaf))
>                 return NULL;
>
> +       sheaf->cache =3D s;
> +
>         stat(s, SHEAF_ALLOC);
>
>         return sheaf;
> @@ -2631,6 +2637,24 @@ static void sheaf_flush_unused(struct kmem_cache *=
s, struct slab_sheaf *sheaf)
>         sheaf->size =3D 0;
>  }
>
> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> +                                    struct slab_sheaf *sheaf);

I think you could safely move __rcu_free_sheaf_prepare() here and
avoid the above forward declaration.

> +
> +static void rcu_free_sheaf_nobarn(struct rcu_head *head)
> +{
> +       struct slab_sheaf *sheaf;
> +       struct kmem_cache *s;
> +
> +       sheaf =3D container_of(head, struct slab_sheaf, rcu_head);
> +       s =3D sheaf->cache;
> +
> +       __rcu_free_sheaf_prepare(s, sheaf);
> +
> +       sheaf_flush_unused(s, sheaf);
> +
> +       free_empty_sheaf(s, sheaf);
> +}
> +
>  /*
>   * Caller needs to make sure migration is disabled in order to fully flu=
sh
>   * single cpu's sheaves
> @@ -2643,7 +2667,7 @@ static void sheaf_flush_unused(struct kmem_cache *s=
, struct slab_sheaf *sheaf)
>  static void pcs_flush_all(struct kmem_cache *s)
>  {
>         struct slub_percpu_sheaves *pcs;
> -       struct slab_sheaf *spare;
> +       struct slab_sheaf *spare, *rcu_free;
>
>         local_lock(&s->cpu_sheaves->lock);
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
> @@ -2651,6 +2675,9 @@ static void pcs_flush_all(struct kmem_cache *s)
>         spare =3D pcs->spare;
>         pcs->spare =3D NULL;
>
> +       rcu_free =3D pcs->rcu_free;
> +       pcs->rcu_free =3D NULL;
> +
>         local_unlock(&s->cpu_sheaves->lock);
>
>         if (spare) {
> @@ -2658,6 +2685,9 @@ static void pcs_flush_all(struct kmem_cache *s)
>                 free_empty_sheaf(s, spare);
>         }
>
> +       if (rcu_free)
> +               call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> +
>         sheaf_flush_main(s);
>  }
>
> @@ -2674,6 +2704,11 @@ static void __pcs_flush_all_cpu(struct kmem_cache =
*s, unsigned int cpu)
>                 free_empty_sheaf(s, pcs->spare);
>                 pcs->spare =3D NULL;
>         }
> +
> +       if (pcs->rcu_free) {
> +               call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn)=
;
> +               pcs->rcu_free =3D NULL;
> +       }
>  }
>
>  static void pcs_destroy(struct kmem_cache *s)
> @@ -2699,6 +2734,7 @@ static void pcs_destroy(struct kmem_cache *s)
>                  */
>
>                 WARN_ON(pcs->spare);
> +               WARN_ON(pcs->rcu_free);
>
>                 if (!WARN_ON(pcs->main->size)) {
>                         free_empty_sheaf(s, pcs->main);
> @@ -3755,7 +3791,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache=
 *s)
>
>         pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
>
> -       return (pcs->spare || pcs->main->size);
> +       return (pcs->spare || pcs->rcu_free || pcs->main->size);
>  }
>
>  static void pcs_flush_all(struct kmem_cache *s);
> @@ -5304,6 +5340,140 @@ bool free_to_pcs(struct kmem_cache *s, void *obje=
ct)
>         return true;
>  }
>
> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> +                                    struct slab_sheaf *sheaf)

This function seems to be an almost exact copy of free_to_pcs_bulk()
from your previous patch. Maybe they can be consolidated?

> +{
> +       bool init =3D slab_want_init_on_free(s);
> +       void **p =3D &sheaf->objects[0];
> +       unsigned int i =3D 0;
> +
> +       while (i < sheaf->size) {
> +               struct slab *slab =3D virt_to_slab(p[i]);
> +
> +               memcg_slab_free_hook(s, slab, p + i, 1);
> +               alloc_tagging_slab_free_hook(s, slab, p + i, 1);
> +
> +               if (unlikely(!slab_free_hook(s, p[i], init, true))) {
> +                       p[i] =3D p[--sheaf->size];
> +                       continue;
> +               }
> +
> +               i++;
> +       }
> +}
> +
> +static void rcu_free_sheaf(struct rcu_head *head)
> +{
> +       struct slab_sheaf *sheaf;
> +       struct node_barn *barn;
> +       struct kmem_cache *s;
> +
> +       sheaf =3D container_of(head, struct slab_sheaf, rcu_head);
> +
> +       s =3D sheaf->cache;
> +
> +       /*
> +        * This may reduce the number of objects that the sheaf is no lon=
ger
> +        * technically full, but it's easier to treat it that way (unless=
 it's

I don't understand the sentence above. Could you please clarify and
maybe reword it?

> +        * competely empty), as the code handles it fine, there's just sl=
ightly

s/competely/completely

> +        * worse batching benefit. It only happens due to debugging, whic=
h
> +        * is a performance hit anyway.
> +        */
> +       __rcu_free_sheaf_prepare(s, sheaf);
> +
> +       barn =3D get_node(s, numa_mem_id())->barn;
> +
> +       /* due to slab_free_hook() */
> +       if (unlikely(sheaf->size =3D=3D 0))
> +               goto empty;
> +
> +       /*
> +        * Checking nr_full/nr_empty outside lock avoids contention in ca=
se the
> +        * barn is at the respective limit. Due to the race we might go o=
ver the
> +        * limit but that should be rare and harmless.
> +        */
> +
> +       if (data_race(barn->nr_full) < MAX_FULL_SHEAVES) {
> +               stat(s, BARN_PUT);
> +               barn_put_full_sheaf(barn, sheaf);
> +               return;
> +       }
> +
> +       stat(s, BARN_PUT_FAIL);
> +       sheaf_flush_unused(s, sheaf);
> +
> +empty:
> +       if (data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
> +               barn_put_empty_sheaf(barn, sheaf);
> +               return;
> +       }
> +
> +       free_empty_sheaf(s, sheaf);
> +}
> +
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *rcu_sheaf;
> +
> +       if (!local_trylock(&s->cpu_sheaves->lock))
> +               goto fail;
> +
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (unlikely(!pcs->rcu_free)) {
> +
> +               struct slab_sheaf *empty;
> +
> +               empty =3D barn_get_empty_sheaf(pcs->barn);
> +
> +               if (empty) {
> +                       pcs->rcu_free =3D empty;
> +                       goto do_free;
> +               }
> +
> +               local_unlock(&s->cpu_sheaves->lock);
> +
> +               empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> +
> +               if (!empty)
> +                       goto fail;
> +
> +               if (!local_trylock(&s->cpu_sheaves->lock))

Aren't you leaking `empty` sheaf on this failure?

> +                       goto fail;
> +
> +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +               if (unlikely(pcs->rcu_free))
> +                       barn_put_empty_sheaf(pcs->barn, empty);
> +               else
> +                       pcs->rcu_free =3D empty;
> +       }
> +
> +do_free:
> +
> +       rcu_sheaf =3D pcs->rcu_free;
> +
> +       rcu_sheaf->objects[rcu_sheaf->size++] =3D obj;
> +
> +       if (likely(rcu_sheaf->size < s->sheaf_capacity))
> +               rcu_sheaf =3D NULL;
> +       else
> +               pcs->rcu_free =3D NULL;
> +
> +       local_unlock(&s->cpu_sheaves->lock);
> +
> +       if (rcu_sheaf)
> +               call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +
> +       stat(s, FREE_RCU_SHEAF);
> +       return true;
> +
> +fail:
> +       stat(s, FREE_RCU_SHEAF_FAIL);
> +       return false;
> +}
> +
>  /*
>   * Bulk free objects to the percpu sheaves.
>   * Unlike free_to_pcs() this includes the calls to all necessary hooks
> @@ -6802,6 +6972,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>         struct kmem_cache_node *n;
>
>         flush_all_cpus_locked(s);
> +
> +       /* we might have rcu sheaves in flight */
> +       if (s->cpu_sheaves)
> +               rcu_barrier();
> +
>         /* Attempt to free all objects */
>         for_each_kmem_cache_node(s, node, n) {
>                 if (n->barn)
> @@ -8214,6 +8389,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
>  STAT_ATTR(FREE_PCS, free_cpu_sheaf);
> +STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
> +STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>  STAT_ATTR(FREE_FROZEN, free_frozen);
> @@ -8312,6 +8489,8 @@ static struct attribute *slab_attrs[] =3D {
>         &alloc_fastpath_attr.attr,
>         &alloc_slowpath_attr.attr,
>         &free_cpu_sheaf_attr.attr,
> +       &free_rcu_sheaf_attr.attr,
> +       &free_rcu_sheaf_fail_attr.attr,
>         &free_fastpath_attr.attr,
>         &free_slowpath_attr.attr,
>         &free_frozen_attr.attr,
>
> --
> 2.49.0
>
