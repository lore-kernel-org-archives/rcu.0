Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0728EA78
	for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316684; cv=none; b=jmm4nc/G2GZn0lcu7XrBPSwej2LOW6xMxiqxKSh3Bh63O1+3ElHN9eInGuWE6e4CeWkTFeHgRW/0iMTmxDYUWiX/eblTRQ8ODqnHUEuNQTATbZLtBuOkZzVr/AbeN8kcDKOLXkZUsOVu68d0PwDR1sbBXFKl9rYHeGfHCkRdSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316684; c=relaxed/simple;
	bh=ZEv9ki2d30CQw9NfNFVAubSyeE1IGDlDYBFLsIAzEac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTrXvThb1X+oS8Bqr9604ByGz1X9XQFztvo3SZUfi7F8FEcwcmmzjQVKWQ35nlTDwD/qhsuQ94zRkSOd9hrFkRR+RzYXfQJTHNweJktqblb9EUUo6TckWNI6Q7WQNauZ4UN3gUg2YLFb+9Fub8NT/UeJQQfDKqsIWUfxXeF640o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Zgz6YIp; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Zgz6YIp"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769e30af66so19341cf.1
        for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744316681; x=1744921481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19mHqIThm1zf5l4Ua+g+ONu7h+sC9EUDgVJ28stINlg=;
        b=0Zgz6YIpo5QidncvfLIWLwO56ZFjJl8YTuortdb2bOZD06eK6C9kvuTR+a9vwiJN86
         ylLGMhXH37HBClFP1g2P81SynNHEt2afSVLBn5kMpNXFogqvlmAKf5lRaduQ+m+4j/Ma
         sbUGiAVzu3xxtN1lEuJgjCAtdcu7prh69vG573CBRLktz9gArr5oB1v3ljIQI5jPYBw8
         z4Nwo765rAoK3l3swjVce4jpxozk9hZVcax1dzVeshinQ5ikT7BihONlM/NZJHLCiNqU
         uhefGU2ZWwBozDzf+7FXsnaXA0QFnwZkeGNvxUjhQjklYDID4aiKdK4MQRspkaFwffOR
         W+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744316681; x=1744921481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19mHqIThm1zf5l4Ua+g+ONu7h+sC9EUDgVJ28stINlg=;
        b=CPKGoZAQPKECZV6ow19+ttkq1wdOdVeXYo207mt1WAvOo70+WjQvg3vdodRrFnUQuF
         8VyMahihbln137sTVP51Y9zlGbQJBEO8Zbk9NPmz2TuzaitxETA2jgleIWXdvBdDLIXf
         aBkrTyKJ+sEcJZNKO/PZLGjD5W5i2ZPzy0qu8KtrLWP99gb/ndIm7ksRT8H9Q/mgQw98
         txfUKvuetjpe/9rQxRKydtupAWj83qZCtXph8eDukuJfJDohoiH50UyFxe0RDFkrWaWN
         l8n8h50wzoBnfpYgARXmz/6AFpdoXUyGqyktrLfylkKvm0cSl+eYwEJPtaLkJdKnxD3r
         HWfw==
X-Forwarded-Encrypted: i=1; AJvYcCWY7JK8+2ydAbw6bqQVrH/cwlqqguOMom3XUeTVPF/l/lFOaKkZr7aQeDZ5u2kqSI+Jo0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzApi3eMIon5JKbjpEh2ER9DHsKVrYHwm5tyWOCzTlnzumohw5O
	ESPXczKxO6BK3Fb+LT0tsMHaD+zMUCZx+CSobFyPEFf2J73BjLARPbyHG8UnngwFYHHCPMggZ1B
	ju/HzZCLAPhs6mGCbN1CTQfTe6XXihdrV9Fue
X-Gm-Gg: ASbGncsDP2V0shMauQfyLilKLxEGGt+CaLSBcn4QlpLWseCSSWEjCbG+yDdCUK2d505
	OjGTVSJcWdNu8FYcpFVrnL+OQnEo1sG+qazI+IGjyVtbNrWQPLXAJ8C6PmR8Lf8XpB10wk8Ywjd
	Oowqz2fNwW7waFrUYBYAnL0ZWEWvbijCfzvnrdjf8N1Fp/S8ZsGv8uoTfVjAMxWJI=
X-Google-Smtp-Source: AGHT+IHEW6Mbhn8c4rWa0Dx1TYjImixeItfJ87VXSD4PD7Xfg9JMqxMigqQjfBAP3d/DgG2q4j3E01sOTCc0j8GnQNk=
X-Received: by 2002:a05:622a:649:b0:472:915:a200 with SMTP id
 d75a77b69052e-479766a6b4cmr1010801cf.28.1744316681212; Thu, 10 Apr 2025
 13:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz> <20250317-slub-percpu-caches-v3-3-9d9884d8b643@suse.cz>
In-Reply-To: <20250317-slub-percpu-caches-v3-3-9d9884d8b643@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Apr 2025 13:24:30 -0700
X-Gm-Features: ATxdqUHCb6eoYuvkJ03BDipnAyKU-wq4ygZ83CBhGZ7b5h8WgLIG_oQhdERjvMw
Message-ID: <CAJuCfpGOcrTM3PCbdPpEjX--4BkQO=ErHJW_026osqex+LBSxg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 3/8] slab: add sheaf support for batching
 kfree_rcu() operations
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
> kfree_rcu() machinery.
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
>   usage - but the existing batching does that too?
>
> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> implementation favors smaller memory footprint over performance.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/slab.h        |   2 +
>  mm/slab_common.c |  24 ++++++++
>  mm/slub.c        | 165 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 189 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 8daaec53b6ecfc44171191d421adb12e5cba2c58..94e9959e1aefa350d3d74e3f5=
309fde7a5cf2ec8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -459,6 +459,8 @@ static inline bool is_kmalloc_normal(struct kmem_cach=
e *s)
>         return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACC=
OUNT));
>  }
>
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +
>  /* Legal flag mask for kmem_cache_create(), for various configurations *=
/
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ceeefb287899a82f30ad79b403556001c1860311..9496176770ed47491e01ed78e=
060a74771d5541e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1613,6 +1613,27 @@ static void kfree_rcu_work(struct work_struct *wor=
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
> @@ -1957,6 +1978,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *p=
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
> index fa3a6329713a9f45b189f27d4b1b334b54589c38..83f4395267dccfbc144920baa=
7d0a85a27fbb1b4 100644
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
> @@ -442,6 +444,7 @@ struct slab_sheaf {
>                 struct rcu_head rcu_head;
>                 struct list_head barn_list;
>         };
> +       struct kmem_cache *cache;
>         unsigned int size;
>         void *objects[];
>  };
> @@ -450,6 +453,7 @@ struct slub_percpu_sheaves {
>         localtry_lock_t lock;
>         struct slab_sheaf *main; /* never NULL when unlocked */
>         struct slab_sheaf *spare; /* empty or full, may be NULL */
> +       struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
>         struct node_barn *barn;
>  };
>
> @@ -2461,6 +2465,8 @@ static struct slab_sheaf *alloc_empty_sheaf(struct =
kmem_cache *s, gfp_t gfp)
>         if (unlikely(!sheaf))
>                 return NULL;
>
> +       sheaf->cache =3D s;
> +
>         stat(s, SHEAF_ALLOC);
>
>         return sheaf;
> @@ -2585,6 +2591,24 @@ static void sheaf_flush_unused(struct kmem_cache *=
s, struct slab_sheaf *sheaf)
>         sheaf->size =3D 0;
>  }
>
> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> +                                    struct slab_sheaf *sheaf);
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
> @@ -2597,7 +2621,7 @@ static void sheaf_flush_unused(struct kmem_cache *s=
, struct slab_sheaf *sheaf)
>  static void pcs_flush_all(struct kmem_cache *s)
>  {
>         struct slub_percpu_sheaves *pcs;
> -       struct slab_sheaf *spare;
> +       struct slab_sheaf *spare, *rcu_free;
>
>         localtry_lock(&s->cpu_sheaves->lock);
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
> @@ -2605,6 +2629,9 @@ static void pcs_flush_all(struct kmem_cache *s)
>         spare =3D pcs->spare;
>         pcs->spare =3D NULL;
>
> +       rcu_free =3D pcs->rcu_free;
> +       pcs->rcu_free =3D NULL;
> +
>         localtry_unlock(&s->cpu_sheaves->lock);
>
>         if (spare) {
> @@ -2612,6 +2639,9 @@ static void pcs_flush_all(struct kmem_cache *s)
>                 free_empty_sheaf(s, spare);
>         }
>
> +       if (rcu_free)
> +               call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> +
>         sheaf_flush_main(s);
>  }
>
> @@ -2628,6 +2658,11 @@ static void __pcs_flush_all_cpu(struct kmem_cache =
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
> @@ -2644,6 +2679,7 @@ static void pcs_destroy(struct kmem_cache *s)
>                         continue;
>
>                 WARN_ON(pcs->spare);
> +               WARN_ON(pcs->rcu_free);
>
>                 if (!WARN_ON(pcs->main->size)) {
>                         free_empty_sheaf(s, pcs->main);
> @@ -3707,7 +3743,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache=
 *s)
>
>         pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
>
> -       return (pcs->spare || pcs->main->size);
> +       return (pcs->spare || pcs->rcu_free || pcs->main->size);
>  }
>
>  static void pcs_flush_all(struct kmem_cache *s);
> @@ -5240,6 +5276,122 @@ bool free_to_pcs(struct kmem_cache *s, void *obje=
ct)
>         return true;
>  }
>
> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> +                                    struct slab_sheaf *sheaf)
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
> +               if (unlikely(!slab_free_hook(s, p[i], init, false))) {
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
> +       __rcu_free_sheaf_prepare(s, sheaf);
> +
> +       barn =3D get_node(s, numa_mem_id())->barn;
> +
> +       /* due to slab_free_hook() */
> +       if (unlikely(sheaf->size =3D=3D 0))
> +               goto empty;
> +
> +       if (!barn_put_full_sheaf(barn, sheaf, false))
> +               return;
> +
> +       sheaf_flush_unused(s, sheaf);
> +
> +empty:
> +       if (!barn_put_empty_sheaf(barn, sheaf, false))
> +               return;
> +
> +       free_empty_sheaf(s, sheaf);
> +}
> +
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *rcu_sheaf;
> +
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
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
> +               localtry_unlock(&s->cpu_sheaves->lock);
> +
> +               empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> +
> +               if (!empty)
> +                       goto fail;
> +
> +               if (!localtry_trylock(&s->cpu_sheaves->lock))
> +                       goto fail;
> +
> +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +               if (unlikely(pcs->rcu_free))
> +                       barn_put_empty_sheaf(pcs->barn, empty, true);
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
> +       if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
> +               localtry_unlock(&s->cpu_sheaves->lock);
> +               stat(s, FREE_RCU_SHEAF);
> +               return true;
> +       }
> +
> +       pcs->rcu_free =3D NULL;
> +       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +       call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +
> +       stat(s, FREE_RCU_SHEAF);
> +       return true;

nit: I think the above code could be simplified to:

do_free:
        rcu_sheaf =3D pcs->rcu_free;
        rcu_sheaf->objects[rcu_sheaf->size++] =3D obj;
        if (likely(rcu_sheaf->size < s->sheaf_capacity))
                rcu_sheaf =3D NULL;
        else
                pcs->rcu_free =3D NULL;

        localtry_unlock(&s->cpu_sheaves->lock);
        stat(s, FREE_RCU_SHEAF);
        if (rcu_sheaf)
                call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);

        return true;

> +
> +fail:
> +       stat(s, FREE_RCU_SHEAF_FAIL);
> +       return false;
> +}
> +
>  /*
>   * Bulk free objects to the percpu sheaves.
>   * Unlike free_to_pcs() this includes the calls to all necessary hooks
> @@ -6569,6 +6721,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
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
> @@ -7974,6 +8131,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
>  STAT_ATTR(FREE_PCS, free_cpu_sheaf);
> +STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
> +STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>  STAT_ATTR(FREE_FROZEN, free_frozen);
> @@ -8069,6 +8228,8 @@ static struct attribute *slab_attrs[] =3D {
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
> 2.48.1
>
