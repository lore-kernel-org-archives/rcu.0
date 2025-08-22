Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDE3126B3
	for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881815; cv=none; b=dQdtbKwF9IVr1/4qT/jqZDzSIMnnykSovO71s9RNXz69XwzGygo6eOVPuODSnfooNn2z8b8TXcX2cy6ca5AfNMLoBTr4ZI6mcAO+xYhbGcHT/UVdkIheouMkXPDbBPxoRVH1oer9E6GmTYHBRm+C6ARwvwRY+5bxjlc9avMlp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881815; c=relaxed/simple;
	bh=K05aXzlURLhkW124leoe2bLJaZuJFdfYu3qH+zEKcLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfJb546uWSpR2ySVphI2cn3K3jN+4s9VsuAhv1k+LThmc8yXEHKW9Ek5wZoqN4RqSzRxoCuQIvjh4+IhzkZwnQEKZxD+mnUZwPfdOFaJLLrTF6IBwEgqjCoRDy0MhuU2LmoUU5fLulKi7kN7FYEy1cZFXxOR8pQjTL0a94jakqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpKFzXqs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpKFzXqs"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b29b714f8cso6751cf.1
        for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755881813; x=1756486613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7+mb346Ky9SrnqlMzxSuOIuQ43DVNmx39imjsZeCx8=;
        b=UpKFzXqsKT/UFbyOxtHYMXOqwSgEuGVBFq+Pcr7vRmUBPq45HojYGF/d8wSlWMnzPW
         6+EkXjdm9p7YuWv87OJBageq5YwRmBVfdRMUFJp78eL/E3eln+uC+o7nf9d0vgk1Og9Z
         nQFJAoVgso1pEFKgkkMqY7GDi/K+lQ3KWWKAzWt85IY8xlh43rHv/YBeD69AW6Ik05iV
         u7LQmKdWbw3wrFPQtDOXObPAJQm5TEjlIZJGv+k0IYiGvu09IpsddsHR313sVDKWP2uR
         oSu1TSjk6cKkaKJbGnZbYBHOjqIh0JGzzdw4HItnIAPlUspB94+GVqs20mxvHY+DhzEt
         Q25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755881813; x=1756486613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7+mb346Ky9SrnqlMzxSuOIuQ43DVNmx39imjsZeCx8=;
        b=MTd6eY/fN0mgvBCs8VS4+VVDmugHgYAaZprxkkJ30uc21A3YZBZ62O4dCn7hi+ArFk
         bEwqMLMto1oia6OffR1jrV0Y/uRbvRwtlxkoE/sZil/84LAijOwdX0zLnGMdUEGHYtcQ
         IJjaogi/vaLAJPs9Ce2iJS0lxuL3SjislBNJoGV1wrI0MCxy1Q3VaT166zsW5X5ZuMxy
         8qPZ8QiBDquxjO9s91gwtRkR6YLUZpS+oAOud320LJ0kpY6Z2qJYbXIqR6DiP7DEObmn
         S8ptoMtcE3MwBj+TKVmDrEHwrYMVyO9gqXmoesxV50j9XGIZ5aU8Ud0qL5Zdai9d85Yg
         UAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDlxclD9ZZSsPcN6CecCHRDom/YsuciQ1IHhBIqz2q8OUmPgyrG/3M7UbtgtjQ0HGmCNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmmujZqD15pUbsyRi9QH2I6buxVL1UUzmD2e91p1skymqckO+
	BlIorOLqWcPjiof31Wilq0L4UquNlSdzTHTJPFCzJ74xs2PuXWvn5iLaZzteXShDqt20M4sF2a1
	UAy1xD9F5clwMAkroNvqLeO3ix7Pq1CtVhqHFHspr
X-Gm-Gg: ASbGncsPJvDL29iLQ98zvdzvytRRXIS4d/n6duxthJ8UH6j0Ot5/BGf7/d0geE9arSh
	1uMCGAxWjENPCuJgpQWgtK4PGmM3Fvdk8bIYUyGPjd8VcU9kH4bPh00xuKB/MYA4JLoFrqeD+Hg
	g7pLjFrZZcpBQWsezA7qck5nSJLujkKkEuOeBTSc3twoB/Fzulqw2CPKD6AGq+bO4H88vFp21c6
	T7umsodU0DHOneoKmYESq4=
X-Google-Smtp-Source: AGHT+IGw7Pkt+nPa5BqQmI3rSxIkNU+66I2ZSYPqvhJbttn+d3hLj7BStxnMej4LA7KUyYMX/ZtTCnEAprY29Edcnos=
X-Received: by 2002:a05:622a:28a:b0:4a7:bed9:5251 with SMTP id
 d75a77b69052e-4b2ac55b35cmr5874671cf.9.1755881812465; Fri, 22 Aug 2025
 09:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-6-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-6-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 09:56:41 -0700
X-Gm-Features: Ac12FXx75l6CZ6aDpuoDjkLGCAv-mu9WsReIJ33ovw1NXAgsqe14IMrJ0Uqvw-s
Message-ID: <CAJuCfpEsVE7Jae7PqWvgTtm38C5MPFx43+dDyYzfKLMQFuE_3A@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] tools: Add sheaves support to testing infrastructure
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 6:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Allocate a sheaf and fill it to the count amount.  Does not fill to the
> sheaf limit to detect incorrect allocation requests.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  tools/include/linux/slab.h   | 24 +++++++++++++
>  tools/testing/shared/linux.c | 84 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 108 insertions(+)
>
> diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
> index d1444e79f2685edb828adbce8b3fbb500c0f8844..1962d7f1abee154e1cda5dba2=
8aef213088dd198 100644
> --- a/tools/include/linux/slab.h
> +++ b/tools/include/linux/slab.h
> @@ -23,6 +23,13 @@ enum slab_state {
>         FULL
>  };
>
> +struct slab_sheaf {
> +       struct kmem_cache *cache;
> +       unsigned int size;
> +       unsigned int capacity;
> +       void *objects[];
> +};
> +
>  struct kmem_cache_args {
>         unsigned int align;
>         unsigned int sheaf_capacity;
> @@ -80,4 +87,21 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, s=
ize_t size, void **list);
>  int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t s=
ize,
>                           void **list);
>
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int s=
ize);
> +
> +void *
> +kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf *sheaf);
> +
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf *sheaf);
> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf **sheafp, unsigned int size);
> +
> +static inline unsigned int kmem_cache_sheaf_size(struct slab_sheaf *shea=
f)
> +{
> +       return sheaf->size;
> +}
> +
>  #endif         /* _TOOLS_SLAB_H */
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index f998555a1b2af4a899a468a652b04622df459ed3..e0255f53159bd3a1325d49192=
283dd6790a5e3b8 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -181,6 +181,12 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep,=
 gfp_t gfp, size_t size,
>         if (kmalloc_verbose)
>                 pr_debug("Bulk alloc %zu\n", size);
>
> +       if (cachep->exec_callback) {
> +               if (cachep->callback)
> +                       cachep->callback(cachep->private);
> +               cachep->exec_callback =3D false;
> +       }
> +
>         pthread_mutex_lock(&cachep->lock);
>         if (cachep->nr_objs >=3D size) {
>                 struct radix_tree_node *node;
> @@ -270,6 +276,84 @@ __kmem_cache_create_args(const char *name, unsigned =
int size,
>         return ret;
>  }
>
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int s=
ize)
> +{
> +       struct slab_sheaf *sheaf;
> +       unsigned int capacity;
> +
> +       if (size > s->sheaf_capacity)
> +               capacity =3D size;
> +       else
> +               capacity =3D s->sheaf_capacity;

nit:
capacity =3D max(size, s->sheaf_capacity);

> +
> +       sheaf =3D malloc(sizeof(*sheaf) + sizeof(void *) * s->sheaf_capac=
ity * capacity);

Should this really be `sizeof(void *) * s->sheaf_capacity * capacity`
or just `sizeof(void *) * capacity` ?


> +       if (!sheaf) {
> +               return NULL;
> +       }
> +
> +       memset(sheaf, 0, size);
> +       sheaf->cache =3D s;
> +       sheaf->capacity =3D capacity;
> +       sheaf->size =3D kmem_cache_alloc_bulk(s, gfp, size, sheaf->object=
s);
> +       if (!sheaf->size) {
> +               free(sheaf);
> +               return NULL;
> +       }
> +
> +       return sheaf;
> +}
> +
> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                struct slab_sheaf **sheafp, unsigned int size)
> +{
> +       struct slab_sheaf *sheaf =3D *sheafp;
> +       int refill;
> +
> +       if (sheaf->size >=3D size)
> +               return 0;
> +
> +       if (size > sheaf->capacity) {
> +               sheaf =3D kmem_cache_prefill_sheaf(s, gfp, size);
> +               if (!sheaf)
> +                       return -ENOMEM;
> +
> +               kmem_cache_return_sheaf(s, gfp, *sheafp);
> +               *sheafp =3D sheaf;
> +               return 0;
> +       }
> +
> +       refill =3D kmem_cache_alloc_bulk(s, gfp, size - sheaf->size,
> +                                      &sheaf->objects[sheaf->size]);
> +       if (!refill)
> +               return -ENOMEM;
> +
> +       sheaf->size +=3D refill;
> +       return 0;
> +}
> +
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                struct slab_sheaf *sheaf)
> +{
> +       if (sheaf->size) {
> +               //s->non_kernel +=3D sheaf->size;

Above comment seems obsolete.

> +               kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
> +       }
> +       free(sheaf);
> +}
> +
> +void *
> +kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf *sheaf)
> +{
> +       if (sheaf->size =3D=3D 0) {
> +               printf("Nothing left in sheaf!\n");
> +               return NULL;
> +       }
> +

Should we clear sheaf->objects[sheaf->size] for additional safety?

> +       return sheaf->objects[--sheaf->size];
> +}
> +
>  /*
>   * Test the test infrastructure for kem_cache_alloc/free and bulk counte=
rparts.
>   */
>
> --
> 2.50.1
>
