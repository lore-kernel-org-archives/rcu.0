Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936219DF75;
	Mon, 18 Nov 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935646; cv=none; b=eMfPWF071Vu7b+UJUXiirBeNMbkVyWdijK3VPJWrvFpQ0rgCgntJ+n9SYSAsMO+4sFwZUNP4NjpywF+fyhSCG+4HnSCnMYcVBeRWoJIOeQVEbU2ZgT4WbCEokwC+7bzmfn/5T2ywWwrntJeDTf6+DTykEkdSPaNZLz893EaMzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935646; c=relaxed/simple;
	bh=fhhmaJHU04moJHFYYU1sSibfF6v5D2x9wWOFvR4GGy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EM4VYuwv4AVIeaiagpYYm9/WFhQg6uPnlIa/mleIn+XTVUlMBtQSZmH8D7nHomNQFqgUgZBBi/VrmxZHq/nZBijFmnvwwnzBswHs5WcliBIOW6awYYNAkfWPpaRxe9De93HxQ1U2JgAcLRBwvDyTU8km7iw0WJGkwW84oP1weDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1RWmucf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1RWmucf"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso35751781fa.1;
        Mon, 18 Nov 2024 05:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731935642; x=1732540442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8vUOATTSQCg4EagntX8WxKpBYFrnGu2LTsiskBXNkU=;
        b=Z1RWmucfU8KCDpqbzieB0gso+yJqGF5DLJSZUNoFcS4mc701ce80WufHGBuCLXLYZw
         sWmzApDz63VnFY2D1O6IUgkcTFehG7jCY0Ssf3e2KW1AxcXZma1AhBcq525szX52hDOG
         vB20IGsToRPsQ78Dj7hwAlFno4xCubW+t+Ao8yQaBvXEjtFFhXQBqOQHFlsK9wCzgmGb
         QGbD4r6E1m/AUKUnzGbi/kBoRclqnQt3uErzDr8YKvunG1tHnFF5gl+1isBh0n4gWV8n
         aIoQmiXHmNhlHtJDKkmej6wLyCqq4weYbn6BGF7EtTKt5kgtEnWYxbsVGLutelu9gHM7
         IwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731935642; x=1732540442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8vUOATTSQCg4EagntX8WxKpBYFrnGu2LTsiskBXNkU=;
        b=q9X53C2nWCitEPM3xKO4WssVA0rYY3EX6trvoSm9xFp80/keLVRz3M+R4nEexoLv0J
         BF5DiAkId/ZqwzKqSK+k5Mg65jnkIuwYD33gyxwFWui9UaU/lkaVnTjATq+0nc2G/dfE
         /qaOKIZl0wuE5jjFy2pxn9Ww3A4Npe4SPOefDOJCoHsvdshTyYezMesZI2oCTTNv0KZK
         wh5WRcL8MOi6NgMDggVyv0B1RVcmMqXA7Cl8UC5E9fg67LzmQ3leodujiQUeTLaJ54BJ
         3fdOL5xVpQmtAij+NA5SMN/8uOXLph8HX/DzuhrLyTgzlOZXtA136f0emdLn1UXET3R4
         6phA==
X-Forwarded-Encrypted: i=1; AJvYcCU43o4LFGF5KHHglnaJGOXw6URCzPP8h7usFfuP3kug6Ef3Hhh94XJHlrKctL1C49riMeouaB68JQ+gtSI=@vger.kernel.org, AJvYcCXrvSdwMIMff3b2Q4mUw68IftzjENDHoXZitKU5PplXOyEW9eDkVrUoGqMaVu3gCXFMkUQ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2lpePxCwoO0UOgqEVGmIpWhs69wwX2vB3h8Sg24B42JHwyJi1
	2/JfItd/fNpShytXMV5e7/sYDT3QSU4vaxif90uD1pZpiR2Ku2K3TRtej+fuU+4rI1ceMmmxJjP
	K5bndJD622lD+C5WqXpnuZbrvTBc=
X-Google-Smtp-Source: AGHT+IGRXbCOadoDXFTX1FRfSdaATe1H9mmUBJ3su9Mywu8Hgpb/IM2wLQgbCq5tcHKFeKVYqh8N2rwn7WnmYmGg1mI=
X-Received: by 2002:a2e:a9a4:0:b0:2fb:5014:c941 with SMTP id
 38308e7fff4ca-2ff60917f01mr56388391fa.14.1731935642054; Mon, 18 Nov 2024
 05:14:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz> <20241112-slub-percpu-caches-v1-6-ddc0bdc27e05@suse.cz>
In-Reply-To: <20241112-slub-percpu-caches-v1-6-ddc0bdc27e05@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Mon, 18 Nov 2024 22:13:49 +0900
Message-ID: <CAB=+i9QoavVWZ6HxiOb8ypqov0rM+HAK4ge7nKHdQRPUaNPmkw@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] mm, slub: sheaf prefilling for guaranteed allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Add three functions for efficient guaranteed allocations in a critical
> section (that cannot sleep) when the exact number of allocations is not
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
> TODO: the current implementation is limited to cache's sheaf_capacity
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |  11 ++++
>  mm/slub.c            | 149 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 160 insertions(+)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 23904321992ad2eeb9389d0883cf4d5d5d71d896..a87dc3c6392fe235de2eabe17=
92df86d40c3bbf9 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -820,6 +820,17 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache=
 *s, gfp_t flags,
>                                    int node) __assume_slab_alignment __ma=
lloc;
>  #define kmem_cache_alloc_node(...)     alloc_hooks(kmem_cache_alloc_node=
_noprof(__VA_ARGS__))
>
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int c=
ount);
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
>  /*
>   * These macros allow declaring a kmem_buckets * parameter alongside siz=
e, which
>   * can be compiled out with CONFIG_SLAB_BUCKETS=3Dn so that a large numb=
er of call
> diff --git a/mm/slub.c b/mm/slub.c
> index 1900afa6153ca6d88f9df7db3ce84d98629489e7..a0e2cb7dfb5173f39f36bea1e=
b9760c3c1b99dd7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -444,6 +444,7 @@ struct slab_sheaf {
>         union {
>                 struct rcu_head rcu_head;
>                 struct list_head barn_list;
> +               bool oversize;
>         };
>         struct kmem_cache *cache;
>         unsigned int size;
> @@ -2819,6 +2820,30 @@ static int barn_put_full_sheaf(struct node_barn *b=
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
> +       if (barn->nr_empty) {
> +               sheaf =3D list_first_entry(&barn->sheaves_empty,
> +                                        struct slab_sheaf, barn_list);
> +               list_del(&sheaf->barn_list);
> +               barn->nr_empty--;
> +       } else if (barn->nr_full) {
> +               sheaf =3D list_first_entry(&barn->sheaves_full, struct sl=
ab_sheaf,
> +                                       barn_list);
> +               list_del(&sheaf->barn_list);
> +               barn->nr_full--;
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
> @@ -4893,6 +4918,130 @@ void *kmem_cache_alloc_node_noprof(struct kmem_ca=
che *s, gfp_t gfpflags, int nod
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>
> +
> +/*
> + * returns a sheaf that has least the given count of objects
> + * when prefilling is needed, do so with given gfp flags
> + *
> + * return NULL if prefilling failed, or when the requested count is
> + * above cache's sheaf_capacity (TODO: lift this limitation)
> + */
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int c=
ount)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *sheaf =3D NULL;
> +
> +       //TODO: handle via oversize sheaf
> +       if (count > s->sheaf_capacity)
> +               return NULL;
> +
> +       pcs =3D cpu_sheaves_lock(s->cpu_sheaves);
> +
> +       if (pcs->spare && pcs->spare->size > 0) {
> +               sheaf =3D pcs->spare;
> +               pcs->spare =3D NULL;
> +       }
> +
> +       if (!sheaf)
> +               sheaf =3D barn_get_full_or_empty_sheaf(pcs->barn);
> +
> +       cpu_sheaves_unlock(s->cpu_sheaves);
> +
> +       if (!sheaf)
> +               sheaf =3D alloc_empty_sheaf(s, gfp);
> +
> +       if (sheaf && sheaf->size < count) {
> +               if (refill_sheaf(s, sheaf, gfp)) {
> +                       sheaf_flush(s, sheaf);
> +                       free_empty_sheaf(s, sheaf);
> +                       sheaf =3D NULL;
> +               }
> +       }
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
> + */
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                            struct slab_sheaf *sheaf)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       bool refill =3D false;
> +       struct node_barn *barn;
> +
> +       //TODO: handle oversize sheaf
> +
> +       pcs =3D cpu_sheaves_lock(s->cpu_sheaves);
> +
> +       if (!pcs->spare) {
> +               pcs->spare =3D sheaf;
> +               sheaf =3D NULL;
> +       }
> +
> +       /* racy check */
> +       if (!sheaf && pcs->barn->nr_full >=3D MAX_FULL_SHEAVES) {
> +               barn =3D pcs->barn;
> +               refill =3D true;
> +       }
> +
> +       cpu_sheaves_unlock(s->cpu_sheaves);
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
> + * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
> + *
> + * Guaranteed not to fail as many allocations as was the requested count=
.
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

Maybe I'm missing something, but how can this be used for non-sleepable con=
texts
if __GFP_NOFAIL is used? I think we have to charge them when the sheaf
is returned
via kmem_cache_prefill_sheaf(), just like users of bulk alloc/free?

Best,
Hyeonggon

> +out:
> +       trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
> +
> +       return ret;
> +}
> +
>  /*
>   * To avoid unnecessary overhead, we pass through large allocation reque=
sts
>   * directly to the page allocator. We use __GFP_COMP, because we will ne=
ed to
>
> --
> 2.47.0
>
