Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6721096F
	for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 03:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740282871; cv=none; b=WbiX9KMf1+pbyO4D8YmLmqCVBFXFClCXnXavFr1EVV4fNLjyf94dNbAN+iUY/5XNWGUR0K+RQrRJn73Dx5/8FY3i1UM1lrT9AILdv15zu70sKWujZvF9KfZD9C9MHQtK19Qg10hlYx8Zu+4bSATgVMR7QoGld7ed0X/RzF6Or58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740282871; c=relaxed/simple;
	bh=ike0CfGi5urRmFh3JV9PFznqmWVdj47h1rGQ0qcsCJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8pt+4tj/UCzzFg7tVfEVD7xJZYg72VDs1n0I+nPR+M1a3oTXDPaKdMjS27GYDQZnIwBpSzfNlsN2m892ZrtbhACl3YjiJhfXgWRoMupn0h+yN2BsMHWkVN7f4uBlGdE3mzQp9rLOgsBX7mkBggmGRMpJDgwFB3wWeSZBwgVU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J5fMxjjo; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5fMxjjo"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471f1dd5b80so162851cf.1
        for <rcu@vger.kernel.org>; Sat, 22 Feb 2025 19:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740282868; x=1740887668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0nSO1c3fd2Ur1OxULz13YnVJpfc0yq8AOQyEMdJoK4=;
        b=J5fMxjjo0uc1n9TvrtMvYMGdoPx1IPa5dxWYk61XqujS8g/Y03jAXYEvXIDB++kFNa
         TiCDhMTHM4986RqnWbxEE2eLKj58PCU+kaIu/NHUNY5vJOgJKHd9QKq6UQ2nJ7+diEZP
         neD5pvpqwewx0o5TBYs1RbrGLCTNrF54/cQegqLPYpz81UPLkRno3UqtbNOXXUkl4MJE
         sPr3lctQk0eQ4NSQlDf6j9Po1dqcPZWXvTZ0RI4TQSHCuhU8qN/GUZ/LHxhFCHn//TBh
         slwijnZydquDW6nmSMD47Ick+rnfeUxXRUIKriyVhfmdw8TohXRwHhqkG3rxSpE5JiuU
         TccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740282868; x=1740887668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0nSO1c3fd2Ur1OxULz13YnVJpfc0yq8AOQyEMdJoK4=;
        b=UJ+uw21m3dk8ZKZYPQ9Gu0aDw31UFqVnOgU8d6nj+JehCp+pSOiiVBV7Wu3q2a45Gw
         73qgEjY5aIFJw5d8pw8hxaMRc8ESGWn5Pe0c5He1xy/8VXpw0HcwVo6SBVMVVYpve5lL
         gxfAOQJwiNh6PitFJh9UvKt6hkYBb37JxiXz22SqIiZkrg9OBIa4bT27g/FqStTBXvDL
         Vrlp+c08RFGxV6cNkQnRFF1CAxOUmJr0qZ0XNfGMfoFqN8olYKw7D03tYYTXcRUZVy49
         98eXZ3nE9UwqWaBmw71ivSmC4bSGbBMQ6h6Ao6l6b5XEKy3hk2Fq0cTfIFMlp/uG0L6u
         cjwg==
X-Forwarded-Encrypted: i=1; AJvYcCWKJQtwiP2ZIz6ZmiIJ1chge5raD1w/XxSw7Pj9u48fzxeSKAJwyHUQZvJk3CDt9fNsmtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwqHPmuVBHIIRZksqsh7BGe8XXKG5t1rIakF2k87kb2zDuCm2
	PviinG0nXNKCTmF675mKhMW5N/ASpemcqlnJgrtB/NCOkiRO79Jfs0DHbvzvMDTE4jzVQpeuQwJ
	NPJwN1wQwjpaMoEKqAFtS5gtb+msScTpLcDZN
X-Gm-Gg: ASbGnct7q2bNyNubWqc/xTC7PojQp2SS3ZdWJn+haAIonvEdRUktq9gjspsv0xYxPRT
	82aqZBBGNWdG8IiXHMXJqbQrmrmXcP4rr2gFPCGu28WQsFkCysyyo7F4YZfVv6tW+ySonf8Worq
	WpJUdae7c=
X-Google-Smtp-Source: AGHT+IHCvJLsK6BH1IIT3R+ZUJXiZdlmR5iea+Se/wuqlM+1bRMx3iydASbGDGvT0dMZePrd1j4z9L+7A9Um7FBSS8M=
X-Received: by 2002:a05:622a:2c3:b0:467:8416:d99e with SMTP id
 d75a77b69052e-47234ccbea7mr2852941cf.21.1740282867599; Sat, 22 Feb 2025
 19:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz> <20250214-slub-percpu-caches-v2-6-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-6-88592ee0966a@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 19:54:16 -0800
X-Gm-Features: AWEUYZkbYKX9QYk3tUuMLicF1BLkdly-1ypdQcA3Vjgwc1PDjcQUVaRf-l4aB_A
Message-ID: <CAJuCfpEBqfhaCQnZFKFkNRhXe0z1k0ZBTDw5BXr=Zu9_s0TfkQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 06/10] slab: sheaf prefilling for guaranteed allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
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
> kmem_cache_return_sheaf(). kmem_cache_refill_sheaf() might be expecially

s/expecially/especially

> ineffective when replacing a sheaf with a new one of a larger capacity.
> It is therefore better to size cache's sheaf_capacity accordingly.

If support for sizes exceeding sheaf_capacity adds much complexity
with no performance benefits, I think it would be ok not to support
them at all. Users know the capacity of a particular kmem_cache, so
they can use this API only when their needs are within sheaf_capacity,
otherwise either size the sheaf appropriately or use slab bulk
allocation.

>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/slab.h |  16 ++++
>  mm/slub.c            | 227 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 243 insertions(+)
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
> index 3d7345e7e938d53950ed0d6abe8eb0e93cf8f5b1..c1df7cf22267f28f743404531=
bef921e25fac086 100644
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
> @@ -2735,6 +2737,30 @@ static int barn_put_full_sheaf(struct node_barn *b=
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
> @@ -4831,6 +4857,207 @@ void *kmem_cache_alloc_node_noprof(struct kmem_ca=
che *s, gfp_t gfpflags, int nod
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>
> +
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

After reviewing the code I would advocate that we support only shaves
of s->sheaf_capacity, unless we have a real usecase requiring
sheaf->capacity !=3D s->sheaf_capacity.

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
> +       if (!sheaf) {
> +               sheaf =3D alloc_empty_sheaf(s, gfp);
> +       }
> +
> +       if (sheaf && sheaf->size < size) {
> +               if (refill_sheaf(s, sheaf, gfp)) {
> +                       sheaf_flush(s, sheaf);
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
> + * It tries to refill the sheaf back to the cache's sheaf_capacity
> + * to avoid handling partially full sheaves.
> + *
> + * If the refill fails because gfp is e.g. GFP_NOWAIT, the sheaf is
> + * instead dissolved

Refilling the sheaf here assumes that in the future we are more likely
to allocate than to free objects or shrink the slab. If the reverse is
true then it would make sense to flush the sheaf and add it as an
empty one into the barn. The fact that flushing can't fail would be
another advantage... We don't know the future but should we be
predicting a more costly case?

> + */
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                            struct slab_sheaf *sheaf)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       bool refill =3D false;
> +       struct node_barn *barn;
> +
> +       if (unlikely(sheaf->capacity !=3D s->sheaf_capacity)) {
> +               sheaf_flush(s, sheaf);
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
> +       } else if (pcs->barn->nr_full >=3D MAX_FULL_SHEAVES) {
> +               /* racy check */
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
> +               sheaf_flush(s, sheaf);
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
> + * fails (with -ENOMEM), the existing sheaf is left intact
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

WIth all the above I think you always end up refilling up to
sheaf->capacity. Not sure if we should mention that in the comment for
this function because your statement about refilling to at least the
given size is still correct.

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
