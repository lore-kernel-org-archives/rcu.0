Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD52D7810
	for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894345; cv=none; b=A9nyfPUbKNK16YfriuDh/ALO54Rh9ClmXE2JECQIIQxieXlaBPp3+2w+HCpu78eIQO/eyMp7UP+xez940kaNyqSvS0HGbBSQVl5vAlHPY4B6Eebyy0f/0chtxB0YB7bA3uIl5OHmOkh1odGE/HzkUyuKfuZfp0E8T5vnKf8KcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894345; c=relaxed/simple;
	bh=VAV7N4y5pNAS0jZ5TBhEfldqKhwyq7wrJhDdA6aeLjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJkgtQCBUfjVU9Soja2Lb84ER608Z2wd4ga0YEsOU5Zd6hLNBjekR/hKTeAtjwaAkZ3o1y7DSj+t5gjsaxfx/pYp/Pt/VYH1WTCOmaVyYlRMUf0yoQrxTVfriM+h/2pllocsXh2rLpTri3jV+SJg24HLpqbuU972praJKwjLlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yylgeXSC; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yylgeXSC"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b29b715106so24231cf.1
        for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755894342; x=1756499142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnLeUyDCv69RBYB1LT6B3iM9eFzgxTxAmCOD+3zz5xw=;
        b=yylgeXSCBGiER90ZvH4GURxtNZjKy/IEKDb27fUneh1VBK9R6jUdTVoIQkpDJ9qx18
         Nm81zyWuzPZXbVQnVrp+kbIyKB8gFMiGAiD5TFCcjpsbebYRtZC8Ss0ieNTppzxyA+Zg
         +IaG+FH8lOB79qJeee8KLn2sjpuXCmBFbK24vc1+ZCaBFQVErCT06rmVwOcd54Ml/gL6
         ot3TanAJNi+D89F3EkRS0IKo6k7EZsIiQrgHMUQtoWYNLJiTqKMnWgEqbIQturnw7kA0
         7r3MfseguCwIy0kxatEOKNPgq6zENec+lNMtOWVcBaXlTyzZMEufLnB2XL+ESsPW6FlM
         klMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894342; x=1756499142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnLeUyDCv69RBYB1LT6B3iM9eFzgxTxAmCOD+3zz5xw=;
        b=Q6J/M4v2BdlVHWtbxmmTYs9JOOVW0+jWJQ6fAz4GWVQ4K5sYGvEcuYTcuKLgVkiN93
         U1/aSg/GA1IOFvOvt4+gGxSvo9oOnrpWn/cS6kGl3IBvoagjjAfZerOJzCcG+Vn+u7iy
         fMyM2DGQkQMyx5t4JOVAY+Mz5BjWbPxE03KdvAf+CzjMwBy+FMeC0Q1PW2q5a4UF34bv
         b/BaS98b9Hu80R8INnDqfWaevSg3IBrgdFfmQYFl0qv49bLCsL9BbNj+5QPs4C1Xuluv
         jLgg/84wt4c52sLrVQ9cVT25InT26piNlm7uTx+5F67etiONYSzlV0h0h4s45QR0T7mi
         dLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTAOJYY0LCJeJ1GwOJkToR+98Kosf7r4OqTvGIPwCJf5ecwBmtWW4iGd99AOIcfNPnXDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzweuEWI6e3YwwnAnnGmNgZzzgrzI123T2fifgN9s95sUHIoTY
	5l1N6Orro0Gv6SaDPHD+KuRT/HFG9N7tUszmO0+Kclrfuk+fd7U2Q9xChim9sFCaW5CUTY5pEg6
	hV7c4HHw3PEU7v2BO8P6srYitJwE6ki9HUqZf04lc
X-Gm-Gg: ASbGncuPtQqy8V5/vBXKA8UWm4WOwHMPef1mqyzO4XAh++viVQ7mj0wsbckbeJX8rne
	tuycWLG4/aes8eBY/vq3azLFh5Q/ck2/Hiv2n3Jvj7TsWIDo/KCCiv6iTOGQz1zUWnXwEkKMlbs
	JZYHAE9EWq9oQcMX4GDFuTQI/lPy9UQXJyyEwqJyay/hCPm+Qq+LHWj7QULxXsz3kmd9la7UHwC
	w2f7YVyoknO
X-Google-Smtp-Source: AGHT+IHpcbSNYEbG4dMf2Ur+EvgyoAGIN6Q8D39CISAhHgiGDM6Pv/YSxa4huZIle8BMgUbZsNIx8jQJ2T56bctuf1U=
X-Received: by 2002:ac8:5885:0:b0:4b2:9b79:e700 with SMTP id
 d75a77b69052e-4b2ba6f09bdmr904771cf.4.1755894342112; Fri, 22 Aug 2025
 13:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-13-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-13-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 13:25:31 -0700
X-Gm-Features: Ac12FXwIfUzsXFwXr2_zQQKQgHFazg_c-46Y0QfxCWOo6vu0LHzTb5q0mxFp2Dg
Message-ID: <CAJuCfpEjaw+4Ay-Yx=unHev+M4M9FmNmz_PSYmtsFn3EToLBxg@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] maple_tree: Add single node allocation support
 to maple state
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
> The fast path through a write will require replacing a single node in
> the tree.  Using a sheaf (32 nodes) is too heavy for the fast path, so
> special case the node store operation by just allocating one node in the
> maple state.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/maple_tree.h |  4 +++-
>  lib/maple_tree.c           | 47 ++++++++++++++++++++++++++++++++++++++++=
------
>  2 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 3cf1ae9dde7ce43fa20ae400c01fefad048c302e..61eb5e7d09ad0133978e3ac4b=
2af66710421e769 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -443,6 +443,7 @@ struct ma_state {
>         unsigned long min;              /* The minimum index of this node=
 - implied pivot min */
>         unsigned long max;              /* The maximum index of this node=
 - implied pivot max */
>         struct slab_sheaf *sheaf;       /* Allocated nodes for this opera=
tion */
> +       struct maple_node *alloc;       /* allocated nodes */
>         unsigned long node_request;
>         enum maple_status status;       /* The status of the state (activ=
e, start, none, etc) */
>         unsigned char depth;            /* depth of tree descent during w=
rite */
> @@ -491,8 +492,9 @@ struct ma_wr_state {
>                 .status =3D ma_start,                                    =
 \
>                 .min =3D 0,                                              =
 \
>                 .max =3D ULONG_MAX,                                      =
 \
> -               .node_request=3D 0,                                      =
 \
>                 .sheaf =3D NULL,                                         =
 \
> +               .alloc =3D NULL,                                         =
 \
> +               .node_request=3D 0,                                      =
 \
>                 .mas_flags =3D 0,                                        =
 \
>                 .store_type =3D wr_invalid,                              =
 \
>         }
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3c3c14a76d98ded3b619c178d64099b464a2ca23..9aa782b1497f224e7366ebbd6=
5f997523ee0c8ab 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1101,16 +1101,23 @@ static int mas_ascend(struct ma_state *mas)
>   *
>   * Return: A pointer to a maple node.
>   */
> -static inline struct maple_node *mas_pop_node(struct ma_state *mas)
> +static __always_inline struct maple_node *mas_pop_node(struct ma_state *=
mas)
>  {
>         struct maple_node *ret;
>
> +       if (mas->alloc) {
> +               ret =3D mas->alloc;
> +               mas->alloc =3D NULL;
> +               goto out;
> +       }
> +
>         if (WARN_ON_ONCE(!mas->sheaf))
>                 return NULL;
>
>         ret =3D kmem_cache_alloc_from_sheaf(maple_node_cache, GFP_NOWAIT,=
 mas->sheaf);
> -       memset(ret, 0, sizeof(*ret));
>
> +out:
> +       memset(ret, 0, sizeof(*ret));
>         return ret;
>  }
>
> @@ -1121,9 +1128,34 @@ static inline struct maple_node *mas_pop_node(stru=
ct ma_state *mas)
>   */
>  static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  {
> -       if (unlikely(mas->sheaf)) {
> -               unsigned long refill =3D mas->node_request;
> +       if (!mas->node_request)
> +               return;
> +
> +       if (mas->node_request =3D=3D 1) {
> +               if (mas->sheaf)
> +                       goto use_sheaf;
> +
> +               if (mas->alloc)
> +                       return;
>
> +               mas->alloc =3D mt_alloc_one(gfp);
> +               if (!mas->alloc)
> +                       goto error;
> +
> +               mas->node_request =3D 0;
> +               return;
> +       }
> +
> +use_sheaf:
> +       if (unlikely(mas->alloc)) {

When would this condition happen? Do we really need to free mas->alloc
here or it can be reused for the next 1-node allocation?

> +               mt_free_one(mas->alloc);
> +               mas->alloc =3D NULL;
> +       }
> +
> +       if (mas->sheaf) {
> +               unsigned long refill;
> +
> +               refill =3D mas->node_request;
>                 if(kmem_cache_sheaf_size(mas->sheaf) >=3D refill) {
>                         mas->node_request =3D 0;
>                         return;
> @@ -5386,8 +5418,11 @@ void mas_destroy(struct ma_state *mas)
>         mas->node_request =3D 0;
>         if (mas->sheaf)
>                 mt_return_sheaf(mas->sheaf);
> -
>         mas->sheaf =3D NULL;
> +
> +       if (mas->alloc)
> +               mt_free_one(mas->alloc);
> +       mas->alloc =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(mas_destroy);
>
> @@ -6074,7 +6109,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>                 mas_alloc_nodes(mas, gfp);
>         }
>
> -       if (!mas->sheaf)
> +       if (!mas->sheaf && !mas->alloc)
>                 return false;
>
>         mas->status =3D ma_start;
>
> --
> 2.50.1
>
