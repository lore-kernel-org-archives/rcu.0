Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB2249F9
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572084; cv=none; b=Sbysip23VIk37vESv3yKzcIbRnZvAqCj4Hs1hDkeg4LlcDKwkBHosYIIpzJP85da1mEHC0m6KTQgCJG1iG9YRNjaVi1hFmPV54yYdFWCLBWItP06c3w99NDmFsz5Q5aGXA2cU/Jh9eDf8nqTrFJqno318wu94GZrdsoOKEgkVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572084; c=relaxed/simple;
	bh=/+ix3Pq2uYhdN+j2hpC6em/Diot5cnHxj+QxMPGSsRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMR1+zfK46gq60r0nQw75ySCLRzj8PuSJ7/5lFVFsjCaQHyDWz4uLL0yTx7cQ4fm3fkDWEffpp3wXD2zEkLF+zIs3hISmTSokcCDGuWNFXUV3ZhM35kDTFLw88MpWIksKtKDk7M5U7KXR9fHHwHkrKkoCoWmHsDOuGXj9tFDjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0yFZ6zXI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0yFZ6zXI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47666573242so133651cf.0
        for <rcu@vger.kernel.org>; Tue, 06 May 2025 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746572081; x=1747176881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKQ6yiNVTWPU/DZWNkZDesRSM5y6q6RX3UqRnzdMZCI=;
        b=0yFZ6zXI9HPeMuu9KqI0QgwOGR2vT3v56J2HF0edEesfiktAOPQerHe3jz+1/6wTrp
         QArAy7hTeAa/b3vGOgePryQa27sf7OysYtsaVEcgz4KR77wEb0RkbTsR0B9P8ThjRPvB
         zoJDdbGKntVfxPuYUtE3SsZoaYeM9BdG4gK1QwpGPnG6N5uSUhY88cEZef94Dd1mG8Kb
         9spBlVoQDWHrESsJHGZrXLf253TUYdDFZ3Ns4wMH44Ukto8Q9gxWjY5FFnnhmFuxffL3
         qjN4AdLzdC0EbvyicfohIAq4hayucannPZ8EuUesVxGgkXlqeX5G3Kkh05pvdQv9BQo7
         8ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746572081; x=1747176881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKQ6yiNVTWPU/DZWNkZDesRSM5y6q6RX3UqRnzdMZCI=;
        b=HuK2q2dlJ7qbyvLCuG9TpCey0B3EVLMNvLQtmD4Z7Y71qBcIdYh8xsfCyK9xPL9ECv
         zWUuTh8hoisiMm0QyH1GEyFDN+2xRRzB7aef0qJLFCtGOggp/Yb1Z3F/sR/70v4Rqy+7
         AmiRSHmR6Jw7me/moQPhKyZFNG23lPX9Zb7RDgHQ6fa/PNAzxRKg+iz963zg8Lk26NFz
         1OqfYgGs+JRQJf7yaYTi1RS2vXjGIVfOsZBi+7L5jVO2/pESbgrKB7FWDsQHCMfJ4aBT
         BIzloaNT2fFFFkUqpzwP+Bprv9kSXKi8FfEwG2WJu/EWWPB08OiO0fEFAlt+iAnHPyCw
         u10Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCQUm3NM1ydLl9WTJ1yTOwOqfK6NsigxG74nIFwAPhOT3mn1wLUQReFlRpHordVNpbLxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpEB1WmYgAkSbOG+0SsSIXc5sYlGzCKZ6ZF9Mu6dlV7DryyJI
	BTl9syURUnsvIwWfFuXIc2apYAZsKKYisVSUsfSe4sr2PgAgBimpM1sqfkZ/RwBU5x7JxsYmfNk
	RNc5bmNBDBVD9xnpzLwzvPf0N0k8Pb660HVbE
X-Gm-Gg: ASbGncvkbYQMaeh5rvMATxduWs31zxypkQGs+ZfmsxPdyK1EAjbl94zYtUYPTzvkSS/
	HBYiNLdT2wxo5+QQP7xcxFcgRHd4yan335hefDcbcfUNsLWyu5cOusnxNiID6d/8ugF2cU3q4Ik
	W2s1U3zPYL2YSL6dFiN41O736KRrvWbdPI2ScisL4jIzjPjwqSx7w=
X-Google-Smtp-Source: AGHT+IHWgr+hppOse+w3u3yod535BQGoGZtLe43/Rj7MD2qdUEX9xXBBbgaIjFDv8BHbJlDmXv59UlEP1HYwEd67HOg=
X-Received: by 2002:a05:622a:118a:b0:47a:e803:da1 with SMTP id
 d75a77b69052e-4924a25ceacmr638221cf.5.1746572081091; Tue, 06 May 2025
 15:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz> <20250425-slub-percpu-caches-v4-3-8a636982b4a4@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-3-8a636982b4a4@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 6 May 2025 15:54:29 -0700
X-Gm-Features: ATxdqUFbeCzCvKikWstKiVxernySVW49EvMpXeyJgYkKr3oyNEC7twqsDjI08io
Message-ID: <CAJuCfpHF3xHiDqzSMLUiR+RTG0Y-D+s0TfPchu8bOOyT4K-9TA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] slab: sheaf prefilling for guaranteed allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:28=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Add functions for efficient guaranteed allocations e.g. in a critical
> section that cannot sleep, when the exact number of allocations is not
> known beforehand, but an upper limit can be calculated.
>
> kmem_cache_prefill_sheaf() returns a sheaf containing at least given
> number of objects.
>
> kmem_cache_alloc_from_sheaf() will allocate an object from the sheaf
> and is guaranteed not to fail until depleted.
>
> kmem_cache_return_sheaf() is for giving the sheaf back to the slab
> allocator after the critical section. This will also attempt to refill
> it to cache's sheaf capacity for better efficiency of sheaves handling,
> but it's not stricly necessary to succeed.
>
> kmem_cache_refill_sheaf() can be used to refill a previously obtained
> sheaf to requested size. If the current size is sufficient, it does
> nothing. If the requested size exceeds cache's sheaf_capacity and the
> sheaf's current capacity, the sheaf will be replaced with a new one,
> hence the indirect pointer parameter.
>
> kmem_cache_sheaf_size() can be used to query the current size.
>
> The implementation supports requesting sizes that exceed cache's
> sheaf_capacity, but it is not efficient - such "oversize" sheaves are
> allocated fresh in kmem_cache_prefill_sheaf() and flushed and freed
> immediately by kmem_cache_return_sheaf(). kmem_cache_refill_sheaf()
> might be especially ineffective when replacing a sheaf with a new one of
> a larger capacity. It is therefore better to size cache's
> sheaf_capacity accordingly to make oversize sheaves exceptional.
>
> CONFIG_SLUB_STATS counters are added for sheaf prefill and return
> operations. A prefill or return is considered _fast when it is able to
> grab or return a percpu spare sheaf (even if the sheaf needs a refill to
> satisfy the request, as those should amortize over time), and _slow
> otherwise (when the barn or even sheaf allocation/freeing has to be
> involved). sheaf_prefill_oversize is provided to determine how many
> prefills were oversize (counter for oversize returns is not necessary as
> all oversize refills result in oversize returns).
>
> When slub_debug is enabled for a cache with sheaves, no percpu sheaves
> exist for it, but the prefill functionality is still provided simply by
> all prefilled sheaves becoming oversize. If percpu sheaves are not
> created for a cache due to not passing the sheaf_capacity argument on
> cache creation, the prefills also work through oversize sheaves, but
> there's a WARN_ON_ONCE() to indicate the omission.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/slab.h |  16 ++++
>  mm/slub.c            | 265 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 281 insertions(+)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 4cb495d55fc58c70a992ee4782d7990ce1c55dc6..b0a9ba33abae22bf38cbf1689=
e3c08bb0b05002f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -829,6 +829,22 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache=
 *s, gfp_t flags,
>                                    int node) __assume_slab_alignment __ma=
lloc;
>  #define kmem_cache_alloc_node(...)     alloc_hooks(kmem_cache_alloc_node=
_noprof(__VA_ARGS__))
>
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int s=
ize);
> +
> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf **sheafp, unsigned int size);
> +
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                                      struct slab_sheaf *sheaf);
> +
> +void *kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *cachep, gfp_=
t gfp,
> +                       struct slab_sheaf *sheaf) __assume_slab_alignment=
 __malloc;
> +#define kmem_cache_alloc_from_sheaf(...)       \
> +                       alloc_hooks(kmem_cache_alloc_from_sheaf_noprof(__=
VA_ARGS__))
> +
> +unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf);
> +
>  /*
>   * These macros allow declaring a kmem_buckets * parameter alongside siz=
e, which
>   * can be compiled out with CONFIG_SLAB_BUCKETS=3Dn so that a large numb=
er of call
> diff --git a/mm/slub.c b/mm/slub.c
> index 6f31a27b5d47fa6621fa8af6d6842564077d4b60..724266fdd996c091f1f0b3401=
2c5179f17dfa422 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -384,6 +384,11 @@ enum stat_item {
>         BARN_GET_FAIL,          /* Failed to get full sheaf from barn */
>         BARN_PUT,               /* Put full sheaf to barn */
>         BARN_PUT_FAIL,          /* Failed to put full sheaf to barn */
> +       SHEAF_PREFILL_FAST,     /* Sheaf prefill grabbed the spare sheaf =
*/
> +       SHEAF_PREFILL_SLOW,     /* Sheaf prefill found no spare sheaf */
> +       SHEAF_PREFILL_OVERSIZE, /* Allocation of oversize sheaf for prefi=
ll */
> +       SHEAF_RETURN_FAST,      /* Sheaf return reattached spare sheaf */
> +       SHEAF_RETURN_SLOW,      /* Sheaf return could not reattach spare =
*/
>         NR_SLUB_STAT_ITEMS
>  };
>
> @@ -445,6 +450,8 @@ struct slab_sheaf {
>         union {
>                 struct rcu_head rcu_head;
>                 struct list_head barn_list;
> +               /* only used for prefilled sheafs */
> +               unsigned int capacity;
>         };
>         struct kmem_cache *cache;
>         unsigned int size;
> @@ -2795,6 +2802,30 @@ static void barn_put_full_sheaf(struct node_barn *=
barn, struct slab_sheaf *sheaf
>         spin_unlock_irqrestore(&barn->lock, flags);
>  }
>
> +static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn =
*barn)
> +{
> +       struct slab_sheaf *sheaf =3D NULL;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&barn->lock, flags);
> +
> +       if (barn->nr_full) {
> +               sheaf =3D list_first_entry(&barn->sheaves_full, struct sl=
ab_sheaf,
> +                                       barn_list);
> +               list_del(&sheaf->barn_list);
> +               barn->nr_full--;
> +       } else if (barn->nr_empty) {
> +               sheaf =3D list_first_entry(&barn->sheaves_empty,
> +                                        struct slab_sheaf, barn_list);
> +               list_del(&sheaf->barn_list);
> +               barn->nr_empty--;
> +       }
> +
> +       spin_unlock_irqrestore(&barn->lock, flags);
> +
> +       return sheaf;
> +}
> +
>  /*
>   * If a full sheaf is available, return it and put the supplied empty on=
e to
>   * barn. We ignore the limit on empty sheaves as the number of sheaves d=
oesn't
> @@ -4905,6 +4936,230 @@ void *kmem_cache_alloc_node_noprof(struct kmem_ca=
che *s, gfp_t gfpflags, int nod
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>
> +/*
> + * returns a sheaf that has least the requested size

s/least/at least ?

> + * when prefilling is needed, do so with given gfp flags
> + *
> + * return NULL if sheaf allocation or prefilling failed
> + */
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int s=
ize)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *sheaf =3D NULL;
> +
> +       if (unlikely(size > s->sheaf_capacity)) {
> +
> +               /*
> +                * slab_debug disables cpu sheaves intentionally so all
> +                * prefilled sheaves become "oversize" and we give up on
> +                * performance for the debugging.
> +                * Creating a cache without sheaves and then requesting a
> +                * prefilled sheaf is however not expected, so warn.
> +                */
> +               WARN_ON_ONCE(s->sheaf_capacity =3D=3D 0 &&
> +                            !(s->flags & SLAB_DEBUG_FLAGS));
> +
> +               sheaf =3D kzalloc(struct_size(sheaf, objects, size), gfp)=
;
> +               if (!sheaf)
> +                       return NULL;
> +
> +               stat(s, SHEAF_PREFILL_OVERSIZE);
> +               sheaf->cache =3D s;
> +               sheaf->capacity =3D size;
> +
> +               if (!__kmem_cache_alloc_bulk(s, gfp, size,
> +                                            &sheaf->objects[0])) {
> +                       kfree(sheaf);

Not sure if we should have SHEAF_PREFILL_OVERSIZE_FAIL accounting as well h=
ere.


> +                       return NULL;
> +               }
> +
> +               sheaf->size =3D size;
> +
> +               return sheaf;
> +       }
> +
> +       local_lock(&s->cpu_sheaves->lock);
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (pcs->spare) {
> +               sheaf =3D pcs->spare;
> +               pcs->spare =3D NULL;
> +               stat(s, SHEAF_PREFILL_FAST);
> +       } else {
> +               stat(s, SHEAF_PREFILL_SLOW);
> +               sheaf =3D barn_get_full_or_empty_sheaf(pcs->barn);
> +               if (sheaf && sheaf->size)
> +                       stat(s, BARN_GET);
> +               else
> +                       stat(s, BARN_GET_FAIL);
> +       }
> +
> +       local_unlock(&s->cpu_sheaves->lock);
> +
> +
> +       if (!sheaf)
> +               sheaf =3D alloc_empty_sheaf(s, gfp);
> +
> +       if (sheaf && sheaf->size < size) {
> +               if (refill_sheaf(s, sheaf, gfp)) {
> +                       sheaf_flush_unused(s, sheaf);
> +                       free_empty_sheaf(s, sheaf);
> +                       sheaf =3D NULL;
> +               }
> +       }
> +
> +       if (sheaf)
> +               sheaf->capacity =3D s->sheaf_capacity;
> +
> +       return sheaf;
> +}
> +
> +/*
> + * Use this to return a sheaf obtained by kmem_cache_prefill_sheaf()
> + *
> + * If the sheaf cannot simply become the percpu spare sheaf, but there's=
 space
> + * for a full sheaf in the barn, we try to refill the sheaf back to the =
cache's
> + * sheaf_capacity to avoid handling partially full sheaves.
> + *
> + * If the refill fails because gfp is e.g. GFP_NOWAIT, or the barn is fu=
ll, the
> + * sheaf is instead flushed and freed.
> + */
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                            struct slab_sheaf *sheaf)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       bool refill =3D false;
> +       struct node_barn *barn;
> +
> +       if (unlikely(sheaf->capacity !=3D s->sheaf_capacity)) {
> +               sheaf_flush_unused(s, sheaf);
> +               kfree(sheaf);
> +               return;
> +       }
> +
> +       local_lock(&s->cpu_sheaves->lock);
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (!pcs->spare) {
> +               pcs->spare =3D sheaf;
> +               sheaf =3D NULL;
> +               stat(s, SHEAF_RETURN_FAST);
> +       } else if (data_race(pcs->barn->nr_full) < MAX_FULL_SHEAVES) {
> +               barn =3D pcs->barn;
> +               refill =3D true;
> +       }
> +
> +       local_unlock(&s->cpu_sheaves->lock);
> +
> +       if (!sheaf)
> +               return;
> +
> +       stat(s, SHEAF_RETURN_SLOW);
> +
> +       /*
> +        * if the barn is full of full sheaves or we fail to refill the s=
heaf,
> +        * simply flush and free it
> +        */
> +       if (!refill || refill_sheaf(s, sheaf, gfp)) {
> +               sheaf_flush_unused(s, sheaf);
> +               free_empty_sheaf(s, sheaf);
> +               return;
> +       }
> +
> +       /* we racily determined the sheaf would fit, so now force it */
> +       barn_put_full_sheaf(barn, sheaf);
> +       stat(s, BARN_PUT);
> +}
> +
> +/*
> + * refill a sheaf previously returned by kmem_cache_prefill_sheaf to at =
least
> + * the given size
> + *
> + * the sheaf might be replaced by a new one when requesting more than
> + * s->sheaf_capacity objects if such replacement is necessary, but the r=
efill
> + * fails (returning -ENOMEM), the existing sheaf is left intact
> + *
> + * In practice we always refill to full sheaf's capacity.
> + */
> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                           struct slab_sheaf **sheafp, unsigned int size=
)
> +{
> +       struct slab_sheaf *sheaf;
> +
> +       /*
> +        * TODO: do we want to support *sheaf =3D=3D NULL to be equivalen=
t of
> +        * kmem_cache_prefill_sheaf() ?
> +        */
> +       if (!sheafp || !(*sheafp))
> +               return -EINVAL;
> +
> +       sheaf =3D *sheafp;
> +       if (sheaf->size >=3D size)
> +               return 0;
> +
> +       if (likely(sheaf->capacity >=3D size)) {
> +               if (likely(sheaf->capacity =3D=3D s->sheaf_capacity))
> +                       return refill_sheaf(s, sheaf, gfp);
> +
> +               if (!__kmem_cache_alloc_bulk(s, gfp, sheaf->capacity - sh=
eaf->size,
> +                                            &sheaf->objects[sheaf->size]=
)) {
> +                       return -ENOMEM;
> +               }
> +               sheaf->size =3D sheaf->capacity;
> +
> +               return 0;
> +       }
> +
> +       /*
> +        * We had a regular sized sheaf and need an oversize one, or we h=
ad an
> +        * oversize one already but need a larger one now.
> +        * This should be a very rare path so let's not complicate it.
> +        */
> +       sheaf =3D kmem_cache_prefill_sheaf(s, gfp, size);
> +       if (!sheaf)
> +               return -ENOMEM;
> +
> +       kmem_cache_return_sheaf(s, gfp, *sheafp);
> +       *sheafp =3D sheaf;
> +       return 0;
> +}
> +
> +/*
> + * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
> + *
> + * Guaranteed not to fail as many allocations as was the requested size.
> + * After the sheaf is emptied, it fails - no fallback to the slab cache =
itself.
> + *
> + * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUN=
T
> + * memcg charging is forced over limit if necessary, to avoid failure.
> + */
> +void *
> +kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
> +                                  struct slab_sheaf *sheaf)
> +{
> +       void *ret =3D NULL;
> +       bool init;
> +
> +       if (sheaf->size =3D=3D 0)
> +               goto out;
> +
> +       ret =3D sheaf->objects[--sheaf->size];
> +
> +       init =3D slab_want_init_on_alloc(gfp, s);
> +
> +       /* add __GFP_NOFAIL to force successful memcg charging */
> +       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, init, =
s->object_size);
> +out:
> +       trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
> +
> +       return ret;
> +}
> +
> +unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf)
> +{
> +       return sheaf->size;
> +}
>  /*
>   * To avoid unnecessary overhead, we pass through large allocation reque=
sts
>   * directly to the page allocator. We use __GFP_COMP, because we will ne=
ed to
> @@ -8423,6 +8678,11 @@ STAT_ATTR(BARN_GET, barn_get);
>  STAT_ATTR(BARN_GET_FAIL, barn_get_fail);
>  STAT_ATTR(BARN_PUT, barn_put);
>  STAT_ATTR(BARN_PUT_FAIL, barn_put_fail);
> +STAT_ATTR(SHEAF_PREFILL_FAST, sheaf_prefill_fast);
> +STAT_ATTR(SHEAF_PREFILL_SLOW, sheaf_prefill_slow);
> +STAT_ATTR(SHEAF_PREFILL_OVERSIZE, sheaf_prefill_oversize);
> +STAT_ATTR(SHEAF_RETURN_FAST, sheaf_return_fast);
> +STAT_ATTR(SHEAF_RETURN_SLOW, sheaf_return_slow);
>  #endif /* CONFIG_SLUB_STATS */
>
>  #ifdef CONFIG_KFENCE
> @@ -8523,6 +8783,11 @@ static struct attribute *slab_attrs[] =3D {
>         &barn_get_fail_attr.attr,
>         &barn_put_attr.attr,
>         &barn_put_fail_attr.attr,
> +       &sheaf_prefill_fast_attr.attr,
> +       &sheaf_prefill_slow_attr.attr,
> +       &sheaf_prefill_oversize_attr.attr,
> +       &sheaf_return_fast_attr.attr,
> +       &sheaf_return_slow_attr.attr,
>  #endif
>  #ifdef CONFIG_FAILSLAB
>         &failslab_attr.attr,
>
> --
> 2.49.0
>
