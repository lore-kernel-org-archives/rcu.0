Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712B28FFD6
	for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318057; cv=none; b=c/6EtSmG36LK1GbaOQ6mx/+0xWjx7A2RsEQM7tZ2If/PTqs1EUqJj0iQMJ6TLTEFqwIl2j7Ty8ostAJu9dcIiSeqGxAcNReHMSTVWDUtxtYpbD5+U9zgEN3gM2VLpeEaGcO3YTdcj2VByIZpIZIBn5z1kk+XlhYMFpDhYqoEKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318057; c=relaxed/simple;
	bh=XERTPgFzbifQnmOja56pxfbpSBPkgcaPHKRO+HVlayU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8viaoZzd9DebYzltoHtUgi8vT9NpU9yKfbGlLpBNJMWaqtHCeVENhoGj2Gf7Aq4gbDY4+8xxGcHwA3iUqgLl9FxvWyPT6lL/us6iM7cFsWRBMZrC3T3OZzfBEo1fzOsGkBqeU/yPwp19AZjR2Hvc2fOBNbMoljFuKKPG2B/laA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7NFttAu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7NFttAu"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47681dba807so18411cf.1
        for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744318054; x=1744922854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLefylaHNPZjZhbmzwC8AW0JTp+q1WmJULZshjWPSxc=;
        b=h7NFttAuLTCkwZaYFjt8Fyh7ebS0dvFyGBWt28yo5sxbWvn+v/tShRNDjTvtzjfgCT
         jDiajQpu+iTPrgsH60izbANDDH0n6FCsF0lh387tNHHeHzd70M+UWRWMesJghouVB+XY
         d9sEbxqXVhX6S9sAdpN42NHayTn0ZobkaHArI6HQPlgD3JKuDlxQBY+H4Exx0H6SfjSX
         o+DGDGz0CcjCM9RKShRy+JwuJi8hBFuY+FHRAWLdOqS84Nrr3/o6cQnULGCq1nCq6YW4
         QGYpV7MZ0hW5anUEdMfbRqyBsKqSjvKr7tBWQZgoToQdzJkYIc6k2OOXD3AL19MLcx8h
         KJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744318054; x=1744922854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLefylaHNPZjZhbmzwC8AW0JTp+q1WmJULZshjWPSxc=;
        b=Eifq0G+YSw+JQ6xIKosQSBYMECuoEZblK5nmzOimYhUJDK/0x39IXo7TmwyGCHio/q
         pCy0d95Lkaf4O7f8W4J/nzKxRf0O0EQ4SBpnUaTaDf6SbbRT91FK7t5+ag+DIXvWF8hw
         PMQ/NN7P+A0w3xk+zKCEaeCXX9dmW1Oz6slN6NGdkpwi7ST00/FSz1Ybv7xpvPXqPORF
         3B5DqjYKOVHiMc5sDlaoaiWhKxWlqs2rXli6d8aQzBc1yxz6LVkbJSqS/ccWzLmIj89K
         CbPuevZBpEA7SH26dIMpYJy1OtH8Wvryp/cPC4t2eQ4aBRpd7iyOcTgpSh0/dlXAspVs
         h41Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGCV/YoUIxkhyS0rleKBrtWUZjuVIb84omW0wPc8dHdJID0KInG4F4YrYfPW5w2dExXCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0X7DD6eT7/Cz3tDRoDxExWSCP8ut+0rv2L7tQaTaLfIFqo1Qo
	vmibUfXRqPQbRMzeO2IXUjX1IKoTn4PJDgmkMc5gWH6zrw2txaJbctegQEWTwax0Tu/bp9hMfSS
	lfsJN1dFzPEIFt4JK7UL0wbAuoCW8F2rVp/5U
X-Gm-Gg: ASbGncsHLFdwmYMdYWT1xY/r1VKQW9X7KZeDy83K+TpsbHW2AuX1iaW7Qnd2xvFMSxk
	V+zHlEcPt3vrx2l0XS2oRKBcwryX08rEL7y9Ir2dGsDiI4j4FANS0SxQRUCWlWP52JkK8Tp1xGV
	IGDwdmEkz/IJPsgtKN9TSg2OL1AUTXc9leP+Mpi1hC1MYVwsSiYWSsNJceMtweRwc=
X-Google-Smtp-Source: AGHT+IHcgKwkYFkHKY2qyse+dZdhrcu9SAgJ27cFDv70UKqs77EJkDrZfJ2+rb5jz7kGB25R/XHmwoWZ1Wq58NnaSPk=
X-Received: by 2002:ac8:590f:0:b0:477:86aa:8829 with SMTP id
 d75a77b69052e-47977841118mr155651cf.3.1744318054232; Thu, 10 Apr 2025
 13:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz> <20250317-slub-percpu-caches-v3-4-9d9884d8b643@suse.cz>
In-Reply-To: <20250317-slub-percpu-caches-v3-4-9d9884d8b643@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Apr 2025 13:47:23 -0700
X-Gm-Features: ATxdqUF9tqqoLKC0ZroKiagsiac5bqpK2QtSRrzISJYABmkgH2mtqBUVcyYJlUA
Message-ID: <CAJuCfpEg8bXVy2F61VNfn2AGW-SJBovGf69SEhK9oJeijjVpJA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/8] slab: sheaf prefilling for guaranteed allocations
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
> sheaf_capacity, but it is not efficient - such sheaves are allocated
> fresh in kmem_cache_prefill_sheaf() and flushed and freed immediately by
> kmem_cache_return_sheaf(). kmem_cache_refill_sheaf() might be especially
> ineffective when replacing a sheaf with a new one of a larger capacity.
> It is therefore better to size cache's sheaf_capacity accordingly.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/slab.h |  16 ++++
>  mm/slub.c            | 228 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 244 insertions(+)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0e1b25228c77140d05b5b4433c9d7923de36ec05..dd01b67982e856b1b02f4f0e6=
fc557726e7f02a8 100644
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
> index 83f4395267dccfbc144920baa7d0a85a27fbb1b4..ab3532d5f41045d8268b12ad7=
74541dcd066c4c4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -443,6 +443,8 @@ struct slab_sheaf {
>         union {
>                 struct rcu_head rcu_head;
>                 struct list_head barn_list;
> +               /* only used for prefilled sheafs */
> +               unsigned int capacity;
>         };
>         struct kmem_cache *cache;
>         unsigned int size;
> @@ -2748,6 +2750,30 @@ static int barn_put_full_sheaf(struct node_barn *b=
arn, struct slab_sheaf *sheaf,
>         return ret;
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
> @@ -4844,6 +4870,208 @@ void *kmem_cache_alloc_node_noprof(struct kmem_ca=
che *s, gfp_t gfpflags, int nod
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>
> +/*
> + * returns a sheaf that has least the requested size
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
> +               sheaf =3D kzalloc(struct_size(sheaf, objects, size), gfp)=
;
> +               if (!sheaf)
> +                       return NULL;
> +
> +               sheaf->cache =3D s;
> +               sheaf->capacity =3D size;
> +
> +               if (!__kmem_cache_alloc_bulk(s, gfp, size,
> +                                            &sheaf->objects[0])) {
> +                       kfree(sheaf);
> +                       return NULL;
> +               }
> +
> +               sheaf->size =3D size;
> +
> +               return sheaf;
> +       }
> +
> +       localtry_lock(&s->cpu_sheaves->lock);
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (pcs->spare) {
> +               sheaf =3D pcs->spare;
> +               pcs->spare =3D NULL;
> +       }
> +
> +       if (!sheaf)
> +               sheaf =3D barn_get_full_or_empty_sheaf(pcs->barn);
> +
> +       localtry_unlock(&s->cpu_sheaves->lock);
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
> +       localtry_lock(&s->cpu_sheaves->lock);
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (!pcs->spare) {
> +               pcs->spare =3D sheaf;
> +               sheaf =3D NULL;
> +       } else if (data_race(pcs->barn->nr_full) < MAX_FULL_SHEAVES) {
> +               barn =3D pcs->barn;
> +               refill =3D true;
> +       }
> +
> +       localtry_unlock(&s->cpu_sheaves->lock);
> +
> +       if (!sheaf)
> +               return;
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
> +       barn_put_full_sheaf(barn, sheaf, true);
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

nit: Would returning a refilled sheaf be a slightly better API than
passing pointer to a pointer?

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
>
> --
> 2.48.1
>
