Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540121E091
	for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817664; cv=none; b=PcM+/oENPTy9MS8Wi8u5uphSkmFAotht3XReuW5i7KMIIsN7pAwxDYXrevqGhz19facKXt00+0WjRfIKyQWDyHAjedVpKsL3HkqpCuEkywCKsgzSYY1itsajUx06TN7ZFg3raUvSMhO6sgshrACFt6mDthCV5hWOOIrCiMGbf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817664; c=relaxed/simple;
	bh=SxFf/oqmf8wsFyNShi7os46aSF+pNg5cTkW3tzLLWn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Io1EZpj810tuG6hvfWycYJZWuHhhJb80BQYeI6JtFg1955GSEwSKpjF/VNkEM3VcPwC455DeCH/SlTMasygajKJcLJK78zvTlxgcF2pje2E+tP7nC7UvCSdBg/PgpBDlbvd6IBohwysMo3cP5hg2CNqwJ8tuTcp84DjEIFTS01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvX5voEo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvX5voEo"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b78657a35aso271cf.0
        for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758817661; x=1759422461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8alXX8Vx5P1PMvrrz8A15t1lUKetKpLPe18RveHqZ44=;
        b=NvX5voEojIzHf5dfxL7ylNaTywGL5YBvNap6In8d97Ul3cVzvUcf3AfyisGsIf6z6k
         RniKZ5rTm5EddylBwmwxlK7xxJEAqkwRFnDBdvCIjDWANPinkR3ykaLpCDgXOWQQQUUA
         fprBUt0TjpBXY74KSv3w9wOa4t1BQVJkl4l5+Iim49xPYdcThYtHzSUYE8Dmgszhc8kv
         q2IbVT+uGPdqmMvn12M3ShFGYNfE2XaCHw08QpEZk+g9eOuma+f8La3l/vHkmX3LNe2M
         70z3//WEz7abQr7+2WFMkWdc7EaqBOiARY/7jwYmb/Dk4b05NJMyg13EpVneO02ID+vi
         zt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817661; x=1759422461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8alXX8Vx5P1PMvrrz8A15t1lUKetKpLPe18RveHqZ44=;
        b=gVHG0+df6KN60IdoyelOig6kYmq0kmwmW9+aaAOeKxVYDwYaEGMQmPQbPBsv7f2qkG
         /DMDE2vkHZmm6MaWVcgMRpfF5iAewfiuJTEVsxQdg0KwJCkrmMZdTl378MG1Pey5lBtJ
         e9mE5Sg5g1sg/JLQEDKAI7MAMj/OdWj1k3iaEGXMv3y164hjFLr9x9izyW3ntlryjMQR
         nk9B13Rx44MQlFnKf0poywJdup9OX/ZYTGJifBUIMgwJugBHqDtum/71EQ8r+Bkuq8YH
         SeSX03Cu2M85/QEigZL3/pqd9dK+PHbeev9uun7MYLbATirldj756yCBSIlZDcaimQn2
         9n1A==
X-Forwarded-Encrypted: i=1; AJvYcCVD/KUh4gcE5Aq1FN/kFLY1f2k1wyE6NVb7mrJyVQTuSHp1HZqf6yPTiZzBGBhCS5+6UA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEX5BQTruMZKpGo522xGp0Rpi3YAdnUAAjh0Dx3TtjsW7HuC3
	+1ZIZGY9ex+1d3MgpBdpXWgSUQ3mx0bAuJHKvZazT/Txk7UHbI9kOIJqEoT6aaLrGyeXnCCQngv
	4URhnUkcuspaP9kWoej+ZIQOcAoi4WgUHG5dVYtj6
X-Gm-Gg: ASbGnct3CNaNFgvuLIVdg2Qy5pZrfR6CmRzFkTkjaDgvfpgniB5jltFMVSzkEejosf9
	5XWex8hsgkgd2+LqowHee5Xsrn/Q3T61RIxRwqq12QJ9hv66HYL3bCaKh1esx11Pfa8kxzLKPxl
	Qrmup3OE61dWBl9S8qGza0FepHVEyu1P7p/7M1StT9+lMibh7aOsz9C8Po/RbQwCLUvTHbzFtsQ
	/7lMeMA9a+vzG7Pt8kjoBodZbiJ4HIuLLblHj/qPRvG
X-Google-Smtp-Source: AGHT+IE0U/Akn6KfZdQi3hMHKTNsTfXUBE073v8846IgqYIdAQipp1ZoMFszJSAgEACETdUsriBu3KVMJALctBt0kw0=
X-Received: by 2002:a05:622a:1819:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4da23acea56mr8611721cf.0.1758817660558; Thu, 25 Sep 2025
 09:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-8-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-8-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Sep 2025 09:27:29 -0700
X-Gm-Features: AS18NWDS5gKmUrtto-cMdIoznAg_NnCQ2mSnzIo1N59ebSpUh4KtZjXH7s5mmh0
Message-ID: <CAJuCfpEL1n+yVJDK0UWxP9CYgu28z6yLUzDWXBKyF0Oyukt1XA@mail.gmail.com>
Subject: Re: [PATCH v8 08/23] slab: allow NUMA restricted allocations to use
 percpu sheaves
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
> Currently allocations asking for a specific node explicitly or via
> mempolicy in strict_numa node bypass percpu sheaves. Since sheaves
> contain mostly local objects, we can try allocating from them if the
> local node happens to be the requested node or allowed by the mempolicy.
> If we find the object from percpu sheaves is not from the expected node,
> we skip the sheaves - this should be rare.
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 9699d048b2cd08ee75c4cc3d1e460868704520b1..3746c0229cc2f9658a589416c=
63c21fbf2850c44 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4888,18 +4888,43 @@ __pcs_replace_empty_main(struct kmem_cache *s, st=
ruct slub_percpu_sheaves *pcs,
>  }
>
>  static __fastpath_inline
> -void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
> +void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>  {
>         struct slub_percpu_sheaves *pcs;
> +       bool node_requested;
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
> +       node_requested =3D IS_ENABLED(CONFIG_NUMA) && node !=3D NUMA_NO_N=
ODE;
> +
> +       /*
> +        * We assume the percpu sheaves contain only local objects althou=
gh it's
> +        * not completely guaranteed, so we verify later.
> +        */
> +       if (unlikely(node_requested && node !=3D numa_mem_id()))
> +               return NULL;
> +
>         if (!local_trylock(&s->cpu_sheaves->lock))
>                 return NULL;
>
> @@ -4911,7 +4936,21 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t g=
fp)
>                         return NULL;
>         }
>
> -       object =3D pcs->main->objects[--pcs->main->size];
> +       object =3D pcs->main->objects[pcs->main->size - 1];
> +
> +       if (unlikely(node_requested)) {
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
> @@ -5011,8 +5050,8 @@ static __fastpath_inline void *slab_alloc_node(stru=
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
> 2.51.0
>
