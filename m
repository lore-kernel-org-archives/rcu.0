Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D51DED5B
	for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894568; cv=none; b=L6v+odzMm+NDwfg8pfD8kLQB2rkDFu9VATA13BGaPXURQoMTipTAA4qBOv6zD/cIexgeEpoLBpCEhglxkHfmxxMO4PderrVgwKUZa1KmVjSB1kwvfm3hys0FOmQjJXxwQb8timvXuAxvxcclFPxZOfAddduZTLz/SMiAHOzpYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894568; c=relaxed/simple;
	bh=ZOYp+nzOPwe14p1kxWcd+s70VP8w17e+NwdUa4bTpr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZIpF9PG4sDUpD7eJDmxflwl2R8agWm2UBFYbz9KYu4K45nDlouOItlNuHIFsD96w029Cb04sY7ywIxpxHpqZSQshO1R9Io4fVBdES965Mx6HbFy+2uCPpW5Zj31z5MkZM5SP6uTzJsIMeRTMvTZeuWf2U0LLdKvc7w2mosIWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdsElT3O; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdsElT3O"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso68871cf.0
        for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755894566; x=1756499366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFW/ka6qBc+ExLqD+f/nxo2YH7Yq8nmI0R2bjFCfWYs=;
        b=VdsElT3OiaZzv1/vT1FwQ/3G7iur0/JJOvLMrc/u69UqcpeX+Jt8dNxd2VMf2KRjrs
         l16TGmFx9/qTRPLpovpuxHvOe8rwaxFuNJLmsW4/iF/dzf90If5nF1wrYDat1CzGozX+
         VQR19uC0n6D8W8HPfEec+sUHwNI+KCOVD36KpdMPoou6x9F5L7N5e0kmg7skoPs4K9CQ
         cgDu7Xmj3kQlyikB2o1EbK4YSi8JIEls2s/zZ6YfLSGiXYC62L3/8ESlopFXrFTcsJbA
         Szp2saNnqshEtE31oqJfznZCN2U6cPL2kVhnjqEUFwqyr94R2Ozd6PgQPLaxj+xxh9qS
         Kv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894566; x=1756499366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFW/ka6qBc+ExLqD+f/nxo2YH7Yq8nmI0R2bjFCfWYs=;
        b=GunjoYY/+/9pi0IFD+XNEorTUJedRykpYFUxbOgNDDSKupo+d11twGC124pmPnACaX
         HQrwj+PS3HOGa2jD7tOeaExqtB+3q46l7GiRkrFgOnWs9rLExquekmJoFK50DxUt/GVQ
         r/8hrTwlxWj+BcQvrD2OPafPGmP/qthw1QXVVXiKhMcYHqvjv7ScrngsrgCN0vBqFfn3
         z3Evx/vBOQdpSGuS0/ZZ/U9jz7+BMtw/iYOwPLGnmH3/7Ka/a3JrPlw66dAbjxKGmYLo
         GDQOIMJRCcKBbAUv5ZGqP5pWRLP9tW8vrXNQiPHGuKfwlEJ1kWeROzZPBHQHhaIzT3mB
         ewuw==
X-Forwarded-Encrypted: i=1; AJvYcCUNPhhLN1ka6kP0AMV1vDXiQtzbO/PuOnHJK3uDU7BAoVjIo05p1KX0liM5Fuf4aBh/+Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQqkAxchSJF4JN8sUs4geWpGuuI2TWQOSNhnUKR7Nk5Y/CeLRW
	sEOJOGqcarsHMDf0IbKLxmm2HKx4Kzs8EVk2rJDGDC9KrvwvBNW4yWW8pIfkLwrXCMp6IAyGPDL
	AgTl72sYYMNrbT2R1GYvQPW8WqB+g+m+FV6YuCGKh
X-Gm-Gg: ASbGncupqs/dtlsRMtgsSgtA5ok7v1G0vVH4bfelGXuryh7YKQLrDyRvBY6Zp1NZh+C
	AVe2L8iCQly7Oj8FOQFI/PAQWy/mwSqaavxK/4xo981qNXkXvPdAw1pY1sRObz/WCQdaDXHFiRg
	rSdN+v5zHafhxE+oTsrnKMSa0Lq5ijYC9OC34XUIjjGqgdEjyLSnvY9RCWXqMEM4sXtys8Hg8Ma
	e/BSq9sHG2t
X-Google-Smtp-Source: AGHT+IE4pKQt99yfD8phfxzg64h26jRgQtXjKYToOS/x0NhTO00qhgEpbXPpJ20CmT3cAcOxNgN3tfWpuWfg/a8bQMc=
X-Received: by 2002:a05:622a:253:b0:4a5:9b0f:a150 with SMTP id
 d75a77b69052e-4b2ba82db6fmr837361cf.16.1755894565605; Fri, 22 Aug 2025
 13:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-14-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-14-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 13:29:14 -0700
X-Gm-Features: Ac12FXzd89CHC2aRvtwVoiHY-2WtL8K1s3anAhQP19TUMIyfZkmLWoeYPfL7oE8
Message-ID: <CAJuCfpH4PNCaMQ4k3iOvt7BK-+nDzVV1p3PcH++7DFGGvg9=fA@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] maple_tree: Convert forking to use the sheaf interface
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
> Use the generic interface which should result in less bulk allocations
> during a forking.
>
> A part of this is to abstract the freeing of the sheaf or maple state
> allocations into its own function so mas_destroy() and the tree
> duplication code can use the same functionality to return any unused
> resources.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  lib/maple_tree.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 9aa782b1497f224e7366ebbd65f997523ee0c8ab..180d5e2ea49440248aaae04a0=
66276406b2537ed 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1178,6 +1178,19 @@ static inline void mas_alloc_nodes(struct ma_state=
 *mas, gfp_t gfp)
>         mas_set_err(mas, -ENOMEM);
>  }
>
> +static inline void mas_empty_nodes(struct ma_state *mas)
> +{
> +       mas->node_request =3D 0;
> +       if (mas->sheaf) {
> +               mt_return_sheaf(mas->sheaf);
> +               mas->sheaf =3D NULL;
> +       }
> +
> +       if (mas->alloc) {
> +               mt_free_one(mas->alloc);
> +               mas->alloc =3D NULL;
> +       }
> +}
>
>  /*
>   * mas_free() - Free an encoded maple node
> @@ -5414,15 +5427,7 @@ void mas_destroy(struct ma_state *mas)
>                 mas->mas_flags &=3D ~MA_STATE_REBALANCE;
>         }
>         mas->mas_flags &=3D ~(MA_STATE_BULK|MA_STATE_PREALLOC);
> -
> -       mas->node_request =3D 0;
> -       if (mas->sheaf)
> -               mt_return_sheaf(mas->sheaf);
> -       mas->sheaf =3D NULL;
> -
> -       if (mas->alloc)
> -               mt_free_one(mas->alloc);
> -       mas->alloc =3D NULL;
> +       mas_empty_nodes(mas);
>  }
>  EXPORT_SYMBOL_GPL(mas_destroy);
>
> @@ -6499,7 +6504,7 @@ static inline void mas_dup_alloc(struct ma_state *m=
as, struct ma_state *new_mas,
>         struct maple_node *node =3D mte_to_node(mas->node);
>         struct maple_node *new_node =3D mte_to_node(new_mas->node);
>         enum maple_type type;
> -       unsigned char request, count, i;
> +       unsigned char count, i;
>         void __rcu **slots;
>         void __rcu **new_slots;
>         unsigned long val;
> @@ -6507,20 +6512,17 @@ static inline void mas_dup_alloc(struct ma_state =
*mas, struct ma_state *new_mas,
>         /* Allocate memory for child nodes. */
>         type =3D mte_node_type(mas->node);
>         new_slots =3D ma_slots(new_node, type);
> -       request =3D mas_data_end(mas) + 1;
> -       count =3D mt_alloc_bulk(gfp, request, (void **)new_slots);
> -       if (unlikely(count < request)) {
> -               memset(new_slots, 0, request * sizeof(void *));
> -               mas_set_err(mas, -ENOMEM);
> +       count =3D mas->node_request =3D mas_data_end(mas) + 1;
> +       mas_alloc_nodes(mas, gfp);
> +       if (unlikely(mas_is_err(mas)))
>                 return;
> -       }
>
> -       /* Restore node type information in slots. */
>         slots =3D ma_slots(node, type);
>         for (i =3D 0; i < count; i++) {
>                 val =3D (unsigned long)mt_slot_locked(mas->tree, slots, i=
);
>                 val &=3D MAPLE_NODE_MASK;
> -               ((unsigned long *)new_slots)[i] |=3D val;
> +               new_slots[i] =3D ma_mnode_ptr((unsigned long)mas_pop_node=
(mas) |
> +                                           val);
>         }
>  }
>
> @@ -6574,7 +6576,7 @@ static inline void mas_dup_build(struct ma_state *m=
as, struct ma_state *new_mas,
>                         /* Only allocate child nodes for non-leaf nodes. =
*/
>                         mas_dup_alloc(mas, new_mas, gfp);
>                         if (unlikely(mas_is_err(mas)))
> -                               return;
> +                               goto empty_mas;
>                 } else {
>                         /*
>                          * This is the last leaf node and duplication is
> @@ -6607,6 +6609,8 @@ static inline void mas_dup_build(struct ma_state *m=
as, struct ma_state *new_mas,
>         /* Make them the same height */
>         new_mas->tree->ma_flags =3D mas->tree->ma_flags;
>         rcu_assign_pointer(new_mas->tree->ma_root, root);
> +empty_mas:
> +       mas_empty_nodes(mas);
>  }
>
>  /**
>
> --
> 2.50.1
>
