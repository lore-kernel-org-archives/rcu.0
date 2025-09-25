Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF0304BA9
	for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816905; cv=none; b=rnoIhfUjmV/9y3eQDwRJVnRDFoT0lZzH/z/0YXhN3xVyplbW9L9UIe6mFWa1oduexeU4/tgFGakyDMLY6vRyce+uHiHk8r+m+MXC0lL2DSno8+pxEoFQCQIQiMx59nxkkIamXvFCZlskUBDNKpFELhZdJ6cmW3CjaIF1uCS8rmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816905; c=relaxed/simple;
	bh=LpXpEcX1YloRoPLbNwuhCN5sMHwc34Rvmm0DEwBJvLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyRDnaZ+3Mq7jQs43eZGRBTB8TQT2P9/hkPep45oczCCoXET7wMg13sGXfdzEkJLEdKIj0rfSda+7EB/dZf4y12teA0EPWAqQIYNSUGegnOCYSlNJ8QkiM5Vm25zQaAZZsoFPMOI+c1Tt2F0cnfq1JZQR/xQTGwb7Jgo/Q+jUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uRjd80Ac; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRjd80Ac"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4c73047a75cso427661cf.1
        for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758816902; x=1759421702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvr92HsSMV0G5ym3tjKs8WEbL98VD0E3AvAM53My1hg=;
        b=uRjd80Acu8oc+k80I2DnyCmeGX8b5gcr6tzTbgn7TOL3ZrhcNwEif6TFL3ENLm5sex
         drE2Ny1t3FNwSPEQCKf0QAE8cgQkAd5PM5Zvxd565HnzHr6vYV3fgU4kyv5fuU7rqwzx
         0B9xAvEZlaD07T9zEbseCiNDKRqemihw+6It40mNbxzTdmmXLmm2bfZN4+u+fPyeG3pL
         GFYl0hv9pPvKpA13svHtt4s0xRIw+z61oLo5Rgfdq+cLRhWsphYB5d/Q6v0l26IX7NBh
         2tEq6CCYeuESDY6AKkEuS1c44elLgSKlGZMh3h5sOOi5GbmLIyfnJIS1xljbrz37SKRv
         ChzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816902; x=1759421702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvr92HsSMV0G5ym3tjKs8WEbL98VD0E3AvAM53My1hg=;
        b=JwUupMdO3EKS1YJCayy517oz4g6mpL3njMsRgdZAThVSQg1PMYMocYRIzIPTowG99w
         ukc4Q++tNRznbYq//26gGEMhX/f4tTGjNAe/6p/V7YA9fy4nilsUHDgtJPmX/V+Snyhv
         +O7+ceS3ZDmDKTycQLm5iBA0mrvzVNHsRCiIJrWeTvqk1AV/uOK0Jne2vekRc9FKW53m
         XfiNgNxi9JrcxegKTSTUKQaOVjZZ9iioL2jBCQInGgyyH8T9XKtGOSlO4ltTbAIM37/f
         fmF6RZA9hlam3YNWWGcdgXNA0lcSZ6blWe5DXD8S/cbscfrigTuWMED+OFxDEv94FTmk
         ptJA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5cq76hrAxK4poSZXo1WLndjfAn4dFNjf16FI17DaGvq7fju9jmMH4lGwgrBb9QWMTHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7z45wGBNgSBsS0RA0/SchMbUHwuNocL35dZcQ6Ry0qQWERcy
	9eQgFR6a3hj6747XDSyMtDyMMJTpmXZyonrkeXqPXd1NympSnBUXwSxZ9lTDiTwxxA5tzTcym2Q
	8KJ0IP1e4jlk4rKinYmUBaemjrpMPZr/FtY/sdxYL
X-Gm-Gg: ASbGnctzg8hn/bX5UIiq9Dgg968sfPZaVWXcM1EpQDbyl6TrFsiJE0lK+2iljO0j4IO
	I2aKz17oLLf+3gDBsj5F49aHFHl0D3Tfe6f4NxTs7cjlc4PpEHTbgey8Q+43lYMGkgemrgPHFWU
	8vf2jimsvD1LC5VkuypGrz2VD266kGMHtEQcJH6jmfJQYlYDnMQAP2SkE/0n2P4O4SqirM0Oylv
	5JDvT00PAYmedgLlhpg9DWfHasKnwGGxLpjQ0s4+dcg/DpAcTQsgQY=
X-Google-Smtp-Source: AGHT+IEZX3AIsjneqU2jkzMxfJ1rwKeMkyXol2y5mWE/WbUduMbZkhlHGcC/mN/j9JEB5vlP4XKLW47PV44WdfJ9t1E=
X-Received: by 2002:a05:622a:38c:b0:4b7:9b7a:1cfc with SMTP id
 d75a77b69052e-4da2d8fb31emr8186661cf.10.1758816901473; Thu, 25 Sep 2025
 09:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-7-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-7-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Sep 2025 09:14:50 -0700
X-Gm-Features: AS18NWAvEId5a1XW0xii0HqSmARldJg6moJt7e5uwfO2hVBiihb1I0PmhdfuWc8
Message-ID: <CAJuCfpHmDxgFj+Jh9+qK1nwnnGWGBvPYEFrLSdooCUy5ODRboA@mail.gmail.com>
Subject: Re: [PATCH v8 07/23] slab: skip percpu sheaves for remote object freeing
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Since we don't control the NUMA locality of objects in percpu sheaves,
> allocations with node restrictions bypass them. Allocations without
> restrictions may however still expect to get local objects with high
> probability, and the introduction of sheaves can decrease it due to
> freed object from a remote node ending up in percpu sheaves.
>
> The fraction of such remote frees seems low (5% on an 8-node machine)
> but it can be expected that some cache or workload specific corner cases
> exist. We can either conclude that this is not a problem due to the low
> fraction, or we can make remote frees bypass percpu sheaves and go
> directly to their slabs. This will make the remote frees more expensive,
> but if if's only a small fraction, most frees will still benefit from

s/if's/it's

> the lower overhead of percpu sheaves.
>
> This patch thus makes remote object freeing bypass percpu sheaves,
> including bulk freeing, and kfree_rcu() via the rcu_free sheaf. However
> it's not intended to be 100% guarantee that percpu sheaves will only
> contain local objects. The refill from slabs does not provide that
> guarantee in the first place, and there might be cpu migrations
> happening when we need to unlock the local_lock. Avoiding all that could
> be possible but complicated so we can leave it for later investigation
> whether it would be worth it. It can be expected that the more selective
> freeing will itself prevent accumulation of remote objects in percpu
> sheaves so any such violations would have only short-term effects.
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slab_common.c |  7 +++++--
>  mm/slub.c        | 42 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 005a4319c06a01d2b616a75396fcc43766a62ddb..b6601e0fe598e24bd8d456dce=
4fc82c65b342bfd 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1623,8 +1623,11 @@ static bool kfree_rcu_sheaf(void *obj)
>
>         slab =3D folio_slab(folio);
>         s =3D slab->slab_cache;
> -       if (s->cpu_sheaves)
> -               return __kfree_rcu_sheaf(s, obj);
> +       if (s->cpu_sheaves) {
> +               if (likely(!IS_ENABLED(CONFIG_NUMA) ||
> +                          slab_nid(slab) =3D=3D numa_mem_id()))
> +                       return __kfree_rcu_sheaf(s, obj);
> +       }
>
>         return false;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index 35274ce4e709c9da7ac8f9006c824f28709e923d..9699d048b2cd08ee75c4cc3d1=
e460868704520b1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -472,6 +472,7 @@ struct slab_sheaf {
>         };
>         struct kmem_cache *cache;
>         unsigned int size;
> +       int node; /* only used for rcu_sheaf */
>         void *objects[];
>  };
>
> @@ -5828,7 +5829,7 @@ static void rcu_free_sheaf(struct rcu_head *head)
>          */
>         __rcu_free_sheaf_prepare(s, sheaf);
>
> -       barn =3D get_node(s, numa_mem_id())->barn;
> +       barn =3D get_node(s, sheaf->node)->barn;
>
>         /* due to slab_free_hook() */
>         if (unlikely(sheaf->size =3D=3D 0))
> @@ -5914,10 +5915,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void=
 *obj)
>
>         rcu_sheaf->objects[rcu_sheaf->size++] =3D obj;
>
> -       if (likely(rcu_sheaf->size < s->sheaf_capacity))
> +       if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>                 rcu_sheaf =3D NULL;
> -       else
> +       } else {
>                 pcs->rcu_free =3D NULL;
> +               rcu_sheaf->node =3D numa_mem_id();
> +       }
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> @@ -5944,7 +5947,11 @@ static void free_to_pcs_bulk(struct kmem_cache *s,=
 size_t size, void **p)
>         bool init =3D slab_want_init_on_free(s);
>         unsigned int batch, i =3D 0;
>         struct node_barn *barn;
> +       void *remote_objects[PCS_BATCH_MAX];
> +       unsigned int remote_nr =3D 0;
> +       int node =3D numa_mem_id();
>
> +next_remote_batch:
>         while (i < size) {
>                 struct slab *slab =3D virt_to_slab(p[i]);
>
> @@ -5954,7 +5961,15 @@ static void free_to_pcs_bulk(struct kmem_cache *s,=
 size_t size, void **p)
>                 if (unlikely(!slab_free_hook(s, p[i], init, false))) {
>                         p[i] =3D p[--size];
>                         if (!size)
> -                               return;
> +                               goto flush_remote;
> +                       continue;
> +               }
> +
> +               if (unlikely(IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) !=
=3D node)) {
> +                       remote_objects[remote_nr] =3D p[i];
> +                       p[i] =3D p[--size];
> +                       if (++remote_nr >=3D PCS_BATCH_MAX)
> +                               goto flush_remote;
>                         continue;
>                 }
>
> @@ -6024,6 +6039,15 @@ static void free_to_pcs_bulk(struct kmem_cache *s,=
 size_t size, void **p)
>          */
>  fallback:
>         __kmem_cache_free_bulk(s, size, p);
> +
> +flush_remote:
> +       if (remote_nr) {
> +               __kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
> +               if (i < size) {
> +                       remote_nr =3D 0;
> +                       goto next_remote_batch;
> +               }
> +       }
>  }
>
>  #ifndef CONFIG_SLUB_TINY
> @@ -6115,8 +6139,14 @@ void slab_free(struct kmem_cache *s, struct slab *=
slab, void *object,
>         if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s)=
, false)))
>                 return;
>
> -       if (!s->cpu_sheaves || !free_to_pcs(s, object))
> -               do_slab_free(s, slab, object, object, 1, addr);
> +       if (s->cpu_sheaves && likely(!IS_ENABLED(CONFIG_NUMA) ||
> +                                    slab_nid(slab) =3D=3D numa_mem_id())=
) {
> +               if (likely(free_to_pcs(s, object))) {

nit: no need for curly braces here.

> +                       return;
> +               }
> +       }
> +
> +       do_slab_free(s, slab, object, object, 1, addr);
>  }
>
>  #ifdef CONFIG_MEMCG
>
> --
> 2.51.0
>
