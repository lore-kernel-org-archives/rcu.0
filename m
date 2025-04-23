Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A162D289367
	for <rcu@vger.kernel.org>; Wed, 23 Apr 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428448; cv=none; b=lj+X/khB4Qh37shxKRshnz1H9+exsDNI9srl4KVHxDOXP5dHlU9nAYoz4AYzex1mSydoTiPFOe2lYuYQuXH5ceZAVgFS+vJzrKEpGaL2R5BIXwn9EvNgz6x2UXEwTpbE8GjqFSF4aaHDO+K9z/iwkt8NLtw35sH2wNEWA74m3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428448; c=relaxed/simple;
	bh=u726+L+2oFTMFgN4P3RXRTbhmAIBIw1FdZRgTNCgABE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXWiC85CUGNY8n15wvOP2X1tHj+er8u+7Gzp5V9hiZqIKW6/vHgd0uU8J5KDRFYD2lqhlXg1T1eXzc0AAVoKIGN4ZMcgFHTXstO393Cw3fZDmqSiXK4P93gHH3c6mSXiOOVw8EdL0HRjbdJ+iXCTAg2mPKvTDqLCrt5h2vDVz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgq9NvJ1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgq9NvJ1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4774611d40bso16581cf.0
        for <rcu@vger.kernel.org>; Wed, 23 Apr 2025 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745428445; x=1746033245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZlHk0IEwmTveeH9vxcXCwphmflVIjvR9gZOHVKJlFI=;
        b=mgq9NvJ1JEG+ZvR0VSEPcZjnKR7SXWUusPpBGVZg055may19dWxWdNHf5+/kQFmujv
         vcERZWoAm05rriqG/Uuh5Olmyrn9pgHrwvGiMsl5Z5S0hH/Wpjvub9jnpJrzG6rsmh3g
         buEp3ZeXF9RzAf/KlhfTfA+zjEIMXhdORuQzNjFB+3WE8LI4/PhRUzPWEP3AI57mOS7Y
         ZpJ4nYBT5g8bsoTnwhpctTyJ9SxOWasgs6jr9i4o7eCT6XeMGsqfOO/LhjwVPluyv46I
         kV7bwmV+jX+SH/x4W3o1t5qmfP7TruYJcFeLj4ySWOIe88pFnwRPfxhAgHkYK17VRFL2
         52uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428445; x=1746033245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZlHk0IEwmTveeH9vxcXCwphmflVIjvR9gZOHVKJlFI=;
        b=Kq73HyPRRo16W8OkHbWBQKB27UBx38SQv4TpLABRnksCPHmU1nuRFfL16H57/Q4Slw
         Un3N/2rR8Ky1Mp8vbcTjtTqXiIHCZ7woslK5urdtXzxMr3tPHtEE1T8HK+y5R0Mleu27
         2FQ48+Bsd/phxGiBo2O0dmxhlwIpI9CC2iAWMWUA9NNNbcUrisFsG8nG2pc3yidIJasF
         y2kUDubyKy65JTm+2GzMHtCyWfmcyrO87s54ycFkl1NaZXOSIYUbJB2X7hD5IATfRGub
         PKhqI5eI4iOejZbFUOqXojrtFnmruxZY5HovnVG0JQQ3fMGvHSH79kcyrlOBJnn3JnqX
         KLiw==
X-Forwarded-Encrypted: i=1; AJvYcCUCPf8a6dwcDKcaRD1u1S2Nc3TJ5C4zi7oapmNBlMlDAUy4wl8pBgT3j3GWdQ4xKuYyGDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UVPKXH7Gt0eK96mnZrw2K2/gFe5JO5YN3kABMSoiNHUNkwkn
	aTJNLExx8+g74VWKDVaHFSQFXLRxIOb8nThPxQfN6SQ0XKUIVu2Hc+joyRcfSDw8XeOk3i07AiW
	WzAmjjUz5VcJSjmxeozeUqFDOjl/I46FrtwNV
X-Gm-Gg: ASbGncu2LmPQ4439jTp1HsxSEbpTfzH9+mcdIBD5s9mn3Nx9SKHIX0Iw4M2XzpCpbpG
	svRdsKDiE7gqbRNnn8rvsNQhRebRo2hiSUqVkaezjrVaYqQYs5yBkq/fLKimqe972WSwAEG61o4
	BSb+JO+cDl7dlpF9OK5ur6ScC2r7IZSc6fnrrviMsJwNdX/eyvwg4wRYxmVr8jfzY=
X-Google-Smtp-Source: AGHT+IFemTcKUy6fxMlOI4jhn/Hhuu8/huR+owTvyVraA5YSBg1pXC76xUTvyFCR85NVFf7HslnCsGlciVWVETFFKZ4=
X-Received: by 2002:a05:622a:228c:b0:47b:4be:8572 with SMTP id
 d75a77b69052e-47d13ae63f5mr5126871cf.18.1745428445177; Wed, 23 Apr 2025
 10:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
 <20250317-slub-percpu-caches-v3-4-9d9884d8b643@suse.cz> <CAJuCfpEg8bXVy2F61VNfn2AGW-SJBovGf69SEhK9oJeijjVpJA@mail.gmail.com>
 <7c4fe3af-a38b-4d40-9824-2935b46e1ecd@suse.cz>
In-Reply-To: <7c4fe3af-a38b-4d40-9824-2935b46e1ecd@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Apr 2025 10:13:53 -0700
X-Gm-Features: ATxdqUEzf-fg78GSI15nKo9lP9ML7j0Z7oXB6Y9N1-xuSsNihrXGsraffOmbrPk
Message-ID: <CAJuCfpHV7kewvi9kghPAE_JGCBchDDWxe0_LP8_2QkpQePWyDw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/8] slab: sheaf prefilling for guaranteed allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 6:06=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 4/10/25 22:47, Suren Baghdasaryan wrote:
> >> +/*
> >> + * refill a sheaf previously returned by kmem_cache_prefill_sheaf to =
at least
> >> + * the given size
> >> + *
> >> + * the sheaf might be replaced by a new one when requesting more than
> >> + * s->sheaf_capacity objects if such replacement is necessary, but th=
e refill
> >> + * fails (returning -ENOMEM), the existing sheaf is left intact
> >> + *
> >> + * In practice we always refill to full sheaf's capacity.
> >> + */
> >> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
> >> +                           struct slab_sheaf **sheafp, unsigned int s=
ize)
> >
> > nit: Would returning a refilled sheaf be a slightly better API than
> > passing pointer to a pointer?
>
> I'm not sure it would be simpler to use, since we need to be able to
> indicate -ENOMEM which would presumably become NULL, so the user would ha=
ve
> to store the existing sheaf pointer and not just blindly do "sheaf =3D
> refill(sheaf)".

Ack.

> Or the semantics would have to be that in case of failure
> the existing sheaf is returned and caller is left with nothing. Liam, wha=
t
> do you think?

That sounds confusing. Compared to that alternative, I would prefer
keeping it the way it is now.

>
> >> +{
> >> +       struct slab_sheaf *sheaf;
> >> +
> >> +       /*
> >> +        * TODO: do we want to support *sheaf =3D=3D NULL to be equiva=
lent of
> >> +        * kmem_cache_prefill_sheaf() ?
> >> +        */
> >> +       if (!sheafp || !(*sheafp))
> >> +               return -EINVAL;
> >> +
> >> +       sheaf =3D *sheafp;
> >> +       if (sheaf->size >=3D size)
> >> +               return 0;
> >> +
> >> +       if (likely(sheaf->capacity >=3D size)) {
> >> +               if (likely(sheaf->capacity =3D=3D s->sheaf_capacity))
> >> +                       return refill_sheaf(s, sheaf, gfp);
> >> +
> >> +               if (!__kmem_cache_alloc_bulk(s, gfp, sheaf->capacity -=
 sheaf->size,
> >> +                                            &sheaf->objects[sheaf->si=
ze])) {
> >> +                       return -ENOMEM;
> >> +               }
> >> +               sheaf->size =3D sheaf->capacity;
> >> +
> >> +               return 0;
> >> +       }
> >> +
> >> +       /*
> >> +        * We had a regular sized sheaf and need an oversize one, or w=
e had an
> >> +        * oversize one already but need a larger one now.
> >> +        * This should be a very rare path so let's not complicate it.
> >> +        */
> >> +       sheaf =3D kmem_cache_prefill_sheaf(s, gfp, size);
> >> +       if (!sheaf)
> >> +               return -ENOMEM;
> >> +
> >> +       kmem_cache_return_sheaf(s, gfp, *sheafp);
> >> +       *sheafp =3D sheaf;
> >> +       return 0;
> >> +}
> >> +
> >> +/*
> >> + * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
> >> + *
> >> + * Guaranteed not to fail as many allocations as was the requested si=
ze.
> >> + * After the sheaf is emptied, it fails - no fallback to the slab cac=
he itself.
> >> + *
> >> + * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACC=
OUNT
> >> + * memcg charging is forced over limit if necessary, to avoid failure=
.
> >> + */
> >> +void *
> >> +kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
> >> +                                  struct slab_sheaf *sheaf)
> >> +{
> >> +       void *ret =3D NULL;
> >> +       bool init;
> >> +
> >> +       if (sheaf->size =3D=3D 0)
> >> +               goto out;
> >> +
> >> +       ret =3D sheaf->objects[--sheaf->size];
> >> +
> >> +       init =3D slab_want_init_on_alloc(gfp, s);
> >> +
> >> +       /* add __GFP_NOFAIL to force successful memcg charging */
> >> +       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, ini=
t, s->object_size);
> >> +out:
> >> +       trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf)
> >> +{
> >> +       return sheaf->size;
> >> +}
> >>  /*
> >>   * To avoid unnecessary overhead, we pass through large allocation re=
quests
> >>   * directly to the page allocator. We use __GFP_COMP, because we will=
 need to
> >>
> >> --
> >> 2.48.1
> >>
>
