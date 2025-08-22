Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80927298CA2
	for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892734; cv=none; b=qnWHafZow/Ryd/26xmkhyxSc0DXNgb71I2nNQ4d5exSsLGm7gwDaoesG6OeW98K7nJzpNW+PnYXotLhHyP3QpGYW0WVUEqxrHOlc7RNxg30rhLwqZKIhBmbakzoALIazVR8dFA8jUc5VYRhltvFbWxXx6yx8OqSFsdvAfnJl1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892734; c=relaxed/simple;
	bh=0bpzj0cYUX4ZSa6GcaVCsPrhX/HSDbWBDDsp5llwFEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOnwLoF0a1OzlBnFB7IanhlZDp8Hwp3f6KSa7eOtyXAUxgF07ANAyEtILyRLtYY64KuQiTFVv/XOHet32ER5rkrA3Y5p9DwdKK+6B9Ixgp60ioCJWRGtcfic3PaeV/LFOwr9pcOOTdOwybANrWwIc0D8+C8lB8/aQUa/oJxrdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hm25WOZF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hm25WOZF"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b29b715106so15231cf.1
        for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755892731; x=1756497531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zbL7KxWZEdFtClBa6fqt36ZA0mgbM0HT/V3o4VWa5g=;
        b=Hm25WOZFTRTvoa9Gz2sWojo93xy07l8AfCl8PndB3lSL63E+maR6gitr0Xdu0Cb5Qq
         lwCycTaM7H8YSBPfRbBqj8nZWP+O7CtD3Uau3T67LVOgecxYG67sxxgZ/KGYzlGxOJMX
         R7gmvGZqggKb/OcmqEF2Hma+oImdX693TY7RpL3xue/foHk3h+LOYKbzaYlai+7AfSj9
         vv8eGb1lwRoq7iFs1BrsLFHQP9EmUrImTYMuCSn9vNguZyRpOghAMPqdaO09Pu0Xfu7p
         mawad1umpmPmmHklJZLfCM/eK9jtFklQ1k9kbGyOgfrLKldcdlH9+mQUWyuFpQaorWef
         t4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892731; x=1756497531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zbL7KxWZEdFtClBa6fqt36ZA0mgbM0HT/V3o4VWa5g=;
        b=OdZM6kZ0sxvmwdRFS6Gcv3wTaPoVe+r1i1Kue5IABXuReT0JLZO/o2nUEuC83MVTPT
         7aimGELnC2Vpk9eknpNx2jVzpwOFCqUectV5O1Aer1MyjIGojcaY6PrUNUVWnWf7VR5M
         An2GqdE/RPwvJVeamVyGaDAcQz1to3KJ2ZB/cXhAOjgQgEcHLwwbyEWJrdgc0RY42eMu
         X/JDOqLl7CD0Ucck4YZCVs1SVlBchucyVe5ovOZawUOoqYh9m0ImNkE3sXKIAm8PFsfV
         iqL7Roa6kcmAhvKigvOneqzvLkw21QSzFvbZhk5FoN+75q/ukUXod3LD8Jgfac1Jh/kA
         oQxw==
X-Forwarded-Encrypted: i=1; AJvYcCVvMwFlNJQFO+PXvT72q5Z0oZduj2ouqh4S+L7U1wA4iA41KIUZrjRWLzLfbNVewBBabo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfjrGlJInE3hhftyTivSedRETe3htg0XyiY+aabakKj2iS48R
	f5Km5vzSJiMgkzhUopdC/k5avr2e72KA071vnVn+lRChcX9E1qMFmXEVX06OvfqHT2cZDM/xqR7
	EKol6MH0m0cWDc03hFW9eTntmoYjKCHraXLDoYl/e
X-Gm-Gg: ASbGncsNB+DKNwTdGjXO/2FhVDv2ZQfWHZQo9TSxGfyfFuv6Gdq1t+IaHJPWp2p7gMs
	D0TIO5Bei7SLozpf9fFrUHQJNnx0qAiYhiW9t4ZwHBC3wWXZHE3XMJPh5lQtWee7SPM9G3tK7GL
	SU+rGOBM3RSa9kiJu9ySk93Sa64J2MLf1GqBxoqM98K6KmkoRivCLpaAPunmQqrMY8FI+PcTfM9
	yXlj2riFnrTCBnaQCh6Qd0=
X-Google-Smtp-Source: AGHT+IFkGBfHZ2+PDQQ6XW2JA5HA4716qCgCxznra7rjS8t9rVJmfjNGxXpArpYN4u40i4cniAw7m/bxlDqhU+rScjw=
X-Received: by 2002:ac8:7f47:0:b0:4a9:e17a:6287 with SMTP id
 d75a77b69052e-4b2ba9faaefmr646441cf.7.1755892730905; Fri, 22 Aug 2025
 12:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-10-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-10-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 12:58:40 -0700
X-Gm-Features: Ac12FXxtiMpVk0VN-fqcAsXzDvd7uIQeiITE8KpMBbIe5MvmOPVwZb-kbSUcaTc
Message-ID: <CAJuCfpHdBJ+9zkT+8AbTkV+cGx4td5t9-Gdtf-jUW8G0RZHKHg@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] mm, slab: allow NUMA restricted allocations to
 use percpu sheaves
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
> Currently allocations asking for a specific node explicitly or via
> mempolicy in strict_numa node bypass percpu sheaves. Since sheaves
> contain mostly local objects, we can try allocating from them if the
> local node happens to be the requested node or allowed by the mempolicy.
> If we find the object from percpu sheaves is not from the expected node,
> we skip the sheaves - this should be rare.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 50fc35b8fc9b3101821c338e9469c134677ded51..b98983b8d2e3e04ea256d91ef=
cf0215ff0ae7e38 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4765,18 +4765,42 @@ __pcs_handle_empty(struct kmem_cache *s, struct s=
lub_percpu_sheaves *pcs, gfp_t
>  }
>
>  static __fastpath_inline
> -void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
> +void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>  {
>         struct slub_percpu_sheaves *pcs;
>         void *object;
>
>  #ifdef CONFIG_NUMA
> -       if (static_branch_unlikely(&strict_numa)) {
> -               if (current->mempolicy)
> -                       return NULL;
> +       if (static_branch_unlikely(&strict_numa) &&
> +                        node =3D=3D NUMA_NO_NODE) {
> +
> +               struct mempolicy *mpol =3D current->mempolicy;
> +
> +               if (mpol) {
> +                       /*
> +                        * Special BIND rule support. If the local node
> +                        * is in permitted set then do not redirect
> +                        * to a particular node.
> +                        * Otherwise we apply the memory policy to get
> +                        * the node we need to allocate on.
> +                        */
> +                       if (mpol->mode !=3D MPOL_BIND ||
> +                                       !node_isset(numa_mem_id(), mpol->=
nodes))
> +
> +                               node =3D mempolicy_slab_node();
> +               }
>         }
>  #endif
>
> +       if (unlikely(node !=3D NUMA_NO_NODE)) {

Should this and later (node !=3D NUMA_NO_NODE) checks be still under
#ifdef CONFIG_NUMA ?

> +               /*
> +                * We assume the percpu sheaves contain only local object=
s
> +                * although it's not completely guaranteed, so we verify =
later.
> +                */
> +               if (node !=3D numa_mem_id())
> +                       return NULL;
> +       }
> +
>         if (!local_trylock(&s->cpu_sheaves->lock))
>                 return NULL;
>
> @@ -4788,7 +4812,21 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t g=
fp)
>                         return NULL;
>         }
>
> -       object =3D pcs->main->objects[--pcs->main->size];
> +       object =3D pcs->main->objects[pcs->main->size - 1];
> +
> +       if (unlikely(node !=3D NUMA_NO_NODE)) {
> +               /*
> +                * Verify that the object was from the node we want. This=
 could
> +                * be false because of cpu migration during an unlocked p=
art of
> +                * the current allocation or previous freeing process.
> +                */
> +               if (folio_nid(virt_to_folio(object)) !=3D node) {
> +                       local_unlock(&s->cpu_sheaves->lock);
> +                       return NULL;
> +               }
> +       }
> +
> +       pcs->main->size--;
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> @@ -4888,8 +4926,8 @@ static __fastpath_inline void *slab_alloc_node(stru=
ct kmem_cache *s, struct list
>         if (unlikely(object))
>                 goto out;
>
> -       if (s->cpu_sheaves && node =3D=3D NUMA_NO_NODE)
> -               object =3D alloc_from_pcs(s, gfpflags);
> +       if (s->cpu_sheaves)
> +               object =3D alloc_from_pcs(s, gfpflags, node);
>
>         if (!object)
>                 object =3D __slab_alloc_node(s, gfpflags, node, addr, ori=
g_size);
>
> --
> 2.50.1
>
