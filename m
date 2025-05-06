Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE4A32
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746573128; cv=none; b=jsmh8NYRLY4X5hxmXBc4uA0b+40Og4xbTq/cV1eqllh4anUfN/N09/M0dVJIDQrDlCFTkW0rLFDupm8Fcgf5ZlDl/m4PnJ/CbwOfiolhGXfjtV1NeFB2yXETABzhoiT6MNWTr8FD8AJCtTdPUyfCywBWs9uqIMaX7uGKMK6izFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746573128; c=relaxed/simple;
	bh=NklbnTW9ka1z4DaaLUPpmOjvLjs4MlCelfJnAoNK3ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiLzLun8zcwyyCFjLZSaabXZ8qmNqku6W0OD17b9Ugyu/+GUoDnz5AClIRKxGeU8kQ9Ma1cD/jKM9+8hhVJ2dewNGSpGyzBq4Ku5WOSgusX/E/kcPlIqBNqCuilt+ZQ9Fpo3RqXrHYLR1Va4/SoirzodYmM9iMUEBUXC3yghJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEJe9VaW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEJe9VaW"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774611d40bso142861cf.0
        for <rcu@vger.kernel.org>; Tue, 06 May 2025 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746573125; x=1747177925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agorwzOKkNl2bLSeF/7IlmE+V7phw2XUQ0HMypfaz54=;
        b=gEJe9VaW5y/Hmb0jEoWWnOzO7v1F5dbzlo9Z6IK02phhv/FVVqfEp2Qo8dJGMS79kE
         Hd5vlamURwVmkh1z1RXt1c42wKmOtMnQJNWmsj3+RcbmDT/gGDlMi7wQMbB8seN/Gccx
         jPicvSansCdcXAH60I8MkYknWYB9ELL0lvF0o7jCs8LCk7/wwHmrExcBdbqf0RpiOSdm
         xYQMxNs0+F173Kwoq1vTU/T5puwFm77ZeW842RqskUnso+xCh7GT/Bb2D1sNXa8B+/Fm
         KAGRF7DbsrrJ3f3HG/goJ+2MPCiLXKCM9EHlMoqu3WxdDvNh9wtUNSiJ/GandkF7IIWe
         F2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746573125; x=1747177925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agorwzOKkNl2bLSeF/7IlmE+V7phw2XUQ0HMypfaz54=;
        b=VK3JgRhkqib9+I2O4eXz2WfpDA/JHBop5vbFaGN0qTjwKY1kTQ7SzCms0uyUsQfAgQ
         JTzrUpq2MPYl/UZr1zfsLg4DFRDbcEIPPu6/sFh8RVgGviqS37CY6yll2gBj/F0Bj1mG
         ul7Cf91hRfqdKYao1HI0W/RoUSzCeAoYjNE4F0Terxp6EwdPzaZQ/cn820y34GigtCeo
         UmwHQOVm4IRsY/jw/SbX06nnxBtOfcmQ5g5sqypVZbXwHPlmiRlgTzSiVyOrTh974NJw
         SYved3hX5UgfudI3gB1hZTcRTVj1daYWuoPO02dWg+asrbwM0F3sdcPkhgOiqSxjmi5k
         dTYw==
X-Forwarded-Encrypted: i=1; AJvYcCWJHMJ0zCXtRAiuIU+cauX4ud9CJBAbqHFSPK2fveaJHkPNrP03bPYJK7CpENtG3EDptS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQLo9iFlr18N16lD7gNd1B/tp09VhYC+nHUCbVCEs/3UUIlYz
	XmhATRALhNQl0bgk4xBrcDFy1FVS3ZwQHp61FcbVDpSkVLrE7FCknjEREA1eYLKpEPKlEtTCGCC
	hi79ciEtZ560dsCRM1ivQ/2x0ddGbz5Hw/AkK
X-Gm-Gg: ASbGncutyTH13vxO82OHSjTasAX1zZfmgWIFm6FDShB9XOaOIa3c18ImdQlwRkeAS+v
	2aJfZh1EhFQVnkGNLfs7ODETd230Dgy9+joLfcfHBD75V0Hd9B2CAeRbP1RFK0V5ODdAtu/vAIz
	I/8/E/dxpIXduwLH2/z4G2AEHldmbZNFwXtuoYDgvkm2eo1nHapk4=
X-Google-Smtp-Source: AGHT+IFbShZZZfIuHrP7fApmJ/NglX0mCvq3s9SyH/Sw0oPfpX4vgFb/BiEV9JWcUUZinJzgBg+6BBFWxj+jR27k190=
X-Received: by 2002:a05:622a:198d:b0:476:63cc:70bb with SMTP id
 d75a77b69052e-4924b698c82mr491171cf.9.1746573125152; Tue, 06 May 2025
 16:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz> <142aeeb5-d6d8-84ca-e7a2-ba564185c565@gentwo.org>
 <4fa1f4fb-4148-45e8-930c-1175ce212cab@suse.cz> <CAJuCfpFe3SeY1EX=X4+wAm33Z3a0d_SoynK-86s5JWjsK80t_A@mail.gmail.com>
In-Reply-To: <CAJuCfpFe3SeY1EX=X4+wAm33Z3a0d_SoynK-86s5JWjsK80t_A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 6 May 2025 16:11:54 -0700
X-Gm-Features: ATxdqUHiBt_fLF1XOJoh8fErb-NdUH14-IsSD5sl-jtrxzK5ph7sOZjNCwaKlJQ
Message-ID: <CAJuCfpFgFLFhuhWCiWOc1yDZz=YGD8Rf99LznnkL_1dimwoYxQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] slab: add opt-in caching layer of percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:32=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Apr 28, 2025 at 12:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >
> > On 4/25/25 19:31, Christoph Lameter (Ampere) wrote:
> > > On Fri, 25 Apr 2025, Vlastimil Babka wrote:
> > >
> > >> @@ -4195,7 +4793,11 @@ static __fastpath_inline void *slab_alloc_nod=
e(struct kmem_cache *s, struct list
> > >>      if (unlikely(object))
> > >>              goto out;
> > >>
> > >> -    object =3D __slab_alloc_node(s, gfpflags, node, addr, orig_size=
);
> > >> +    if (s->cpu_sheaves && node =3D=3D NUMA_NO_NODE)
> > >> +            object =3D alloc_from_pcs(s, gfpflags);
> > >
> > > The node to use is determined in __slab_alloc_node() only based on th=
e
> > > memory policy etc. NUMA_NO_NODE allocations can be redirected by memo=
ry
> > > policies and this check disables it.
> >
> > To handle that, alloc_from_pcs() contains this:
> >
> > #ifdef CONFIG_NUMA
> >         if (static_branch_unlikely(&strict_numa)) {
> >                 if (current->mempolicy)
> >                         return NULL;
> >         }
> > #endif
> >
> > And so there will be a fallback. It doesn't (currently) try to evaluate=
 if
> > the local node is compatible as this is before taking the local lock (a=
nd
> > thus preventing migration).
> >
> >
> > >> @@ -4653,7 +5483,10 @@ void slab_free(struct kmem_cache *s, struct s=
lab *slab, void *object,
> > >>      memcg_slab_free_hook(s, slab, &object, 1);
> > >>      alloc_tagging_slab_free_hook(s, slab, &object, 1);
> > >>
> > >> -    if (likely(slab_free_hook(s, object, slab_want_init_on_free(s),=
 false)))
> > >> +    if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(=
s), false)))
> > >> +            return;
> > >> +
> > >> +    if (!s->cpu_sheaves || !free_to_pcs(s, object))
> > >>              do_slab_free(s, slab, object, object, 1, addr);
> > >>  }
> > >
> > > We free to pcs even if the object is remote?
>
> Overall the patch LGTM but I would like to hear the answer to this
> question too, please.

Ah, I reached the last patch and found the answer there:
https://lore.kernel.org/all/c60ae681-6027-0626-8d4e-5833982bf1f0@gentwo.org=
/

>
> > >
> >
