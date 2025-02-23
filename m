Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC753BE
	for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740278015; cv=none; b=qdH3DenqFaugA+8MP4iMZMLcUpku9p0rkPJ6xJbEJA8JMtf5LssCHxN427hq0xTfO9f4hNRGNz7ioDagubtuoQ4bbJmcE7bEdCi8uzzkl34VOZ2mjU1pd3qCPimN7BdgKzUtX0+aaOC6eN5D3CKH7vRASg3eYBJ+d1rAszOVNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740278015; c=relaxed/simple;
	bh=tmAyXGex6RhU4wP0NDzfInOTk+r2jAUWvsBVSgMuNeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9UnhS2Kr99swU80KOTv8BNJsd6bZR/5cZ82+3A78uU7QeqlOJbwCwPSrd3zoFTTntuSDBd4ibrkfvQ7+43bUwnFM3yCsnNZPWK6fmDr0IHguLRuPGx2BHUV9ABbQZ4XY+XqWuze6ruqXv6EVnWO/jkXCJJlB8wY/JVr1O5mTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmrATjMR; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmrATjMR"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-472098e6e75so235651cf.1
        for <rcu@vger.kernel.org>; Sat, 22 Feb 2025 18:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740278012; x=1740882812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSj9GP1d8XWYgpE9Ac+Ecoi7aYqhEle0Xlq1f/D5dZE=;
        b=MmrATjMRyQ47Dj8mUEfVju8bIk20YAIFy058Fy8kEohRCqIdHl2O32rGLm3C/RqO84
         N8DLC2y1CYRqXQKsENYW21dFQSHtmcIyzafXOwScO9n2sPgA4HTAx1I3oVN7iGJ6p85V
         54921LnoXsoFzWDV+3YG+CSmscXpTeTCxI6pMi+kKgWTKH/wQPMq9u84WFFJaW72zPQP
         eOneUMkRz4pDewjyaWbt7j559hUkueV3wkbTLEZ1RLSTx1oGHOdDNgqN7VndTQIk+4G1
         0KS8Eqhu6c3dtsXJQT255lXaZ9FcXhcV+aA8eE1cOIcIgRyV6T5zuqwVwDy+QRd0QLnj
         ZiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740278012; x=1740882812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSj9GP1d8XWYgpE9Ac+Ecoi7aYqhEle0Xlq1f/D5dZE=;
        b=fEKJKTgH+WRX9pUXmWRFXsngG9gq10hO+WmSfg/fSI13WgdSSLJ/OHMYOFhb4PxPvI
         XX6I3/2A++f76Kqp/prWMFzYugotCZyuqkoZJWRSZo7fU9G0BoxbO+Mr9yQvKmk+RE/e
         6wE+vvJgRYUPFzv7DpEUEJDAZIaBRXc4AqDdqItvZp4Bn9WrNUv3Hm4GdxWEylueb2wH
         PeN/qor/YQQrTuGltOWCK24ylSTaFHh6IykCDhIojGdwtRXasLGpzV+dmHfEA79whdHt
         s7qmaPh4OBB6G9A2F1sjiNvVbVwwyAqzRzQhfHbSt0sbTNDvnqpeMEBCTrLaRvyVsNXZ
         Ub4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXABVTlOTSCerfxgX8DWlGA9qNmKD9lMRItBbVmRNGRtGXYwHq6m2AOS9gjSYHslBiSN1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygtx8lmqSlNgujACJZaxYFicwFAKpYW/egl3gnQSSyGd1mzNs5
	b2+3fTPdCtJJ3Tq7K9QOyDp+t+70LT066YNfILxsWPPbnm9VzfRS/Rk8qnbVgGHNEzCb8Y8ILSh
	QeyT/X4JcwAYcqV/Pr0iW4amBJqvvBOoenw6a
X-Gm-Gg: ASbGncuZdrkj2E2Z7rMTjL3pqX1rVHGtb4ndkY72odlxNL9wdiS40bw5cLcoFaH/it9
	TCnfTMqBPzGA0imtFndawf981ylaJBSObXLpQsMTxlk72gDjeMxUb36MTOzvodjZcyjskTYtLPn
	QTMnnqy3A=
X-Google-Smtp-Source: AGHT+IEppLjtYdAFjvlkukOC/jwGq/ljjBXjwRnu2q+hPcfFhpmhwybwFTynciwADSRgXkd7A3tpPjJlBLJkmbijUh0=
X-Received: by 2002:a05:622a:3cd:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-47234b4f60amr2676031cf.1.1740278011571; Sat, 22 Feb 2025
 18:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz> <20250214-slub-percpu-caches-v2-5-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-5-88592ee0966a@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 18:33:20 -0800
X-Gm-Features: AWEUYZnP93sWzD1RjU5sHg7X_s4QtECm9lIkbUx8vkBfv4DWYmyuj81qIuEQ_lM
Message-ID: <CAJuCfpHW02L=uZkfpPz_-L4Em6DoTHQVC36+=c7ymgPHRu2Njg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 05/10] slab: switch percpu sheaves locking to localtry_lock
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
> Instead of local_lock_irqsave(), use localtry_trylock() when potential
> callers include irq context, and localtry_lock() otherwise (such as when
> we already know the gfp flags allow blocking).
>
> This should reduce the locking (due to irq disabling/enabling) overhead.
> Failing to use percpu sheaves in an irq due to preempting an already
> locked user of sheaves should be rare so it's a favorable tradeoff.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 122 ++++++++++++++++++++++++++++++++++++++------------------=
------
>  1 file changed, 76 insertions(+), 46 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 40175747212fefb27137309b27571abe8d0966e2..3d7345e7e938d53950ed0d6ab=
e8eb0e93cf8f5b1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -450,7 +450,7 @@ struct slab_sheaf {
>  };
>
>  struct slub_percpu_sheaves {
> -       local_lock_t lock;
> +       localtry_lock_t lock;
>         struct slab_sheaf *main; /* never NULL when unlocked */
>         struct slab_sheaf *spare; /* empty or full, may be NULL */
>         struct slab_sheaf *rcu_free;
> @@ -2529,16 +2529,19 @@ static struct slab_sheaf *alloc_full_sheaf(struct=
 kmem_cache *s, gfp_t gfp)
>
>  static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, vo=
id **p);
>
> -static void sheaf_flush_main(struct kmem_cache *s)
> +/* returns true if at least partially flushed */
> +static bool sheaf_flush_main(struct kmem_cache *s)
>  {
>         struct slub_percpu_sheaves *pcs;
>         unsigned int batch, remaining;
>         void *objects[PCS_BATCH_MAX];
>         struct slab_sheaf *sheaf;
> -       unsigned long flags;
> +       bool ret =3D false;
>
>  next_batch:
> -       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               return ret;
> +
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
>         sheaf =3D pcs->main;
>
> @@ -2549,14 +2552,18 @@ static void sheaf_flush_main(struct kmem_cache *s=
)
>
>         remaining =3D sheaf->size;
>
> -       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +       localtry_unlock(&s->cpu_sheaves->lock);
>
>         __kmem_cache_free_bulk(s, batch, &objects[0]);
>
>         stat_add(s, SHEAF_FLUSH_MAIN, batch);
>
> +       ret =3D true;
> +
>         if (remaining)
>                 goto next_batch;
> +
> +       return ret;
>  }
>
>  static void sheaf_flush(struct kmem_cache *s, struct slab_sheaf *sheaf)
> @@ -2593,6 +2600,8 @@ static void rcu_free_sheaf_nobarn(struct rcu_head *=
head)
>   * Caller needs to make sure migration is disabled in order to fully flu=
sh
>   * single cpu's sheaves
>   *
> + * must not be called from an irq
> + *
>   * flushing operations are rare so let's keep it simple and flush to sla=
bs
>   * directly, skipping the barn
>   */
> @@ -2600,9 +2609,8 @@ static void pcs_flush_all(struct kmem_cache *s)
>  {
>         struct slub_percpu_sheaves *pcs;
>         struct slab_sheaf *spare, *rcu_free;
> -       unsigned long flags;
>
> -       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +       localtry_lock(&s->cpu_sheaves->lock);
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>         spare =3D pcs->spare;
> @@ -2611,7 +2619,7 @@ static void pcs_flush_all(struct kmem_cache *s)
>         rcu_free =3D pcs->rcu_free;
>         pcs->rcu_free =3D NULL;
>
> -       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +       localtry_unlock(&s->cpu_sheaves->lock);
>
>         if (spare) {
>                 sheaf_flush(s, spare);
> @@ -4554,10 +4562,11 @@ static __fastpath_inline
>  void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
>  {
>         struct slub_percpu_sheaves *pcs;
> -       unsigned long flags;
>         void *object;
>
> -       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               return NULL;
> +
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>         if (unlikely(pcs->main->size =3D=3D 0)) {
> @@ -4590,7 +4599,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gf=
p)
>                         }
>                 }
>
> -               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +               localtry_unlock(&s->cpu_sheaves->lock);
>
>                 if (!can_alloc)
>                         return NULL;
> @@ -4612,7 +4621,11 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t g=
fp)
>                 if (!full)
>                         return NULL;
>
> -               local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +               /*
> +                * we can reach here only when gfpflags_allow_blocking
> +                * so this must not be an irq
> +                */
> +               localtry_lock(&s->cpu_sheaves->lock);
>                 pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>                 /*
> @@ -4646,7 +4659,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gf=
p)
>  do_alloc:
>         object =3D pcs->main->objects[--pcs->main->size];
>
> -       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +       localtry_unlock(&s->cpu_sheaves->lock);
>
>         stat(s, ALLOC_PCS);
>
> @@ -4658,12 +4671,13 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cach=
e *s, size_t size, void **p)
>  {
>         struct slub_percpu_sheaves *pcs;
>         struct slab_sheaf *main;
> -       unsigned long flags;
>         unsigned int allocated =3D 0;
>         unsigned int batch;
>
>  next_batch:
> -       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               return allocated;
> +
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>         if (unlikely(pcs->main->size =3D=3D 0)) {
> @@ -4683,7 +4697,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache =
*s, size_t size, void **p)
>                         goto do_alloc;
>                 }
>
> -               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +               localtry_unlock(&s->cpu_sheaves->lock);
>
>                 /*
>                  * Once full sheaves in barn are depleted, let the bulk
> @@ -4701,7 +4715,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache =
*s, size_t size, void **p)
>         main->size -=3D batch;
>         memcpy(p, main->objects + main->size, batch * sizeof(void *));
>
> -       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +       localtry_unlock(&s->cpu_sheaves->lock);
>
>         stat_add(s, ALLOC_PCS, batch);
>
> @@ -5121,13 +5135,14 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
>   * The object is expected to have passed slab_free_hook() already.
>   */
>  static __fastpath_inline
> -void free_to_pcs(struct kmem_cache *s, void *object)
> +bool free_to_pcs(struct kmem_cache *s, void *object)
>  {
>         struct slub_percpu_sheaves *pcs;
> -       unsigned long flags;
>
>  restart:
> -       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               return false;
> +
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>         if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
> @@ -5162,7 +5177,7 @@ void free_to_pcs(struct kmem_cache *s, void *object=
)
>                         struct slab_sheaf *to_flush =3D pcs->spare;
>
>                         pcs->spare =3D NULL;
> -                       local_unlock_irqrestore(&s->cpu_sheaves->lock, fl=
ags);
> +                       localtry_unlock(&s->cpu_sheaves->lock);
>
>                         sheaf_flush(s, to_flush);
>                         empty =3D to_flush;
> @@ -5170,17 +5185,27 @@ void free_to_pcs(struct kmem_cache *s, void *obje=
ct)
>                 }
>
>  alloc_empty:
> -               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +               localtry_unlock(&s->cpu_sheaves->lock);
>
>                 empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
>
>                 if (!empty) {
> -                       sheaf_flush_main(s);
> -                       goto restart;
> +                       if (sheaf_flush_main(s))
> +                               goto restart;
> +                       else
> +                               return false;
>                 }
>
>  got_empty:
> -               local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +               if (!localtry_trylock(&s->cpu_sheaves->lock)) {
> +                       struct node_barn *barn;
> +
> +                       barn =3D get_node(s, numa_mem_id())->barn;
> +
> +                       barn_put_empty_sheaf(barn, empty, true);
> +                       return false;
> +               }
> +
>                 pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>                 /*
> @@ -5209,9 +5234,11 @@ void free_to_pcs(struct kmem_cache *s, void *objec=
t)
>  do_free:
>         pcs->main->objects[pcs->main->size++] =3D object;
>
> -       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +       localtry_unlock(&s->cpu_sheaves->lock);
>
>         stat(s, FREE_PCS);
> +
> +       return true;
>  }
>
>  static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> @@ -5270,9 +5297,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void =
*obj)
>  {
>         struct slub_percpu_sheaves *pcs;
>         struct slab_sheaf *rcu_sheaf;
> -       unsigned long flags;
>
> -       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               goto fail;
> +
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>         if (unlikely(!pcs->rcu_free)) {
> @@ -5286,16 +5314,16 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void=
 *obj)
>                         goto do_free;
>                 }
>
> -               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +               localtry_unlock(&s->cpu_sheaves->lock);
>
>                 empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
>
> -               if (!empty) {
> -                       stat(s, FREE_RCU_SHEAF_FAIL);
> -                       return false;
> -               }
> +               if (!empty)
> +                       goto fail;
> +
> +               if (!localtry_trylock(&s->cpu_sheaves->lock))
> +                       goto fail;
>
> -               local_lock_irqsave(&s->cpu_sheaves->lock, flags);
>                 pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>                 if (unlikely(pcs->rcu_free))
> @@ -5311,19 +5339,22 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void=
 *obj)
>         rcu_sheaf->objects[rcu_sheaf->size++] =3D obj;
>
>         if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
> -               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +               localtry_unlock(&s->cpu_sheaves->lock);
>                 stat(s, FREE_RCU_SHEAF);
>                 return true;
>         }
>
>         pcs->rcu_free =3D NULL;
> -       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +       localtry_unlock(&s->cpu_sheaves->lock);
>
>         call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
>
>         stat(s, FREE_RCU_SHEAF);
> -
>         return true;
> +
> +fail:
> +       stat(s, FREE_RCU_SHEAF_FAIL);
> +       return false;
>  }
>
>  /*
> @@ -5335,7 +5366,6 @@ static void free_to_pcs_bulk(struct kmem_cache *s, =
size_t size, void **p)
>  {
>         struct slub_percpu_sheaves *pcs;
>         struct slab_sheaf *main;
> -       unsigned long flags;
>         unsigned int batch, i =3D 0;
>         bool init;
>
> @@ -5358,7 +5388,9 @@ static void free_to_pcs_bulk(struct kmem_cache *s, =
size_t size, void **p)
>         }
>
>  next_batch:
> -       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
> +               goto fallback;
> +
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
>
>         if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
> @@ -5389,13 +5421,13 @@ static void free_to_pcs_bulk(struct kmem_cache *s=
, size_t size, void **p)
>                 }
>
>  no_empty:
> -               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +               localtry_unlock(&s->cpu_sheaves->lock);
>
>                 /*
>                  * if we depleted all empty sheaves in the barn or there =
are too
>                  * many full sheaves, free the rest to slab pages
>                  */
> -
> +fallback:
>                 __kmem_cache_free_bulk(s, size, p);
>                 return;
>         }
> @@ -5407,7 +5439,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, =
size_t size, void **p)
>         memcpy(main->objects + main->size, p, batch * sizeof(void *));
>         main->size +=3D batch;
>
> -       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +       localtry_unlock(&s->cpu_sheaves->lock);
>
>         stat_add(s, FREE_PCS, batch);
>
> @@ -5507,9 +5539,7 @@ void slab_free(struct kmem_cache *s, struct slab *s=
lab, void *object,
>         if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s)=
, false)))
>                 return;
>
> -       if (s->cpu_sheaves)
> -               free_to_pcs(s, object);
> -       else
> +       if (!s->cpu_sheaves || !free_to_pcs(s, object))
>                 do_slab_free(s, slab, object, object, 1, addr);
>  }
>
> @@ -6288,7 +6318,7 @@ static int init_percpu_sheaves(struct kmem_cache *s=
)
>
>                 pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
>
> -               local_lock_init(&pcs->lock);
> +               localtry_lock_init(&pcs->lock);
>
>                 nid =3D cpu_to_mem(cpu);
>
>
> --
> 2.48.1
>
