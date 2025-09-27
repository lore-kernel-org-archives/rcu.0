Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCAB183CA6
	for <rcu@vger.kernel.org>; Sat, 27 Sep 2025 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935842; cv=none; b=OZor0FAPhNHDJcVHoR0NOa4q3ihtweKw3q9rGeIAehR0b4tZ4dZ560E+MrUFmXes+sC/yAUqG2Qv5HYN96AnqX0iLS745V4uOJWyH1gquoAhL62iqb+izamUCMvs5kUj1Y0NVlu5ULeHkekkOrFQWCYAVXJoJtDxMwhXyx5LMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935842; c=relaxed/simple;
	bh=GLQYJhwAyzcEeEfpcAHXQec3Dck6ULc+1afuEMmCptI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHG903DkvfWf5EMepjFcHHEZ7KR27MNxiErSH569vOT9HGLB3UXUw4r7BuMRdLyNfu4Uk5wWegRKGQRpzTEZCet5h8PRL8sB3pQ47XFGpQwcLqRR02qpHdPVTLOTPDkiUBmZnMUNs9pWJU3ag5byLEyUqgAkSnfUXpY6iPHqZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgD4W4VH; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgD4W4VH"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4256ec84b8fso60775ab.0
        for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 18:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758935840; x=1759540640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP6jNuOzuaZrN4jqHuCq7vrrzkS8UserW/hueLrBex8=;
        b=TgD4W4VHvKbd1guKyWz36mHEsB3ZTyfdlKapbRqXj5x2j3Ne7rmVxZn2lx2D6TfUa2
         P8ZpiVfEAYWE6P/JJgsCR10raUyTJ7aKuu/rEYl+ExKOVGGCzGOfcsjStTh5tcPCCfmz
         033L2Hci8tMZeLPKZXHGA9TvR/BZnYguyuGBUdJZbziVfC3GtHKTpViGLyWGByvw7h+t
         m1ZIAM5o9Y/6NXmhsGUhGe3x1RDrDm8tjfpX0GZYxDtwGVJEocXu3fsSzGHOS5Wiba7P
         FxzLi9N6Qsep4o2TltSr4acKgCwfkjq5l2QAvkIwqfMpHxiV+Rn1IU+h00H0tkNkGeBe
         cPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935840; x=1759540640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP6jNuOzuaZrN4jqHuCq7vrrzkS8UserW/hueLrBex8=;
        b=NCRIfu+tOafteJUSJ72E3yJYHyeDTIIyOSEtkuCSosSF2wHq0wxul/k3aaqLQWzwh1
         o+F8JZTm3xWaIl3USUYaM7OKCFd8eQy7T18diiHkdI6ZiZa0RZq0tINwjcyR/84iJlJJ
         G+ITf9D8W0koJzwQ68tnSNO86cNtkEPS/nU26Wbe3K5NdwsWysFh6fG7xfOFe1AOrKH0
         9gyUJBr+xssNnzF4ue1WSwtndxM96qhW/cqwkwErnBdAQUNkKcxi/mCokBLjteCHfcq/
         2+WVYx1SbG0rjgzT02LxEe5RsCrNTL71jagLONs7b/uhRC609asJgIXUdb9Kv8Ha0dVl
         o8zg==
X-Forwarded-Encrypted: i=1; AJvYcCXM8+Vk/+dz/WCeRFvsI9JZF5vPhOP1Ug2ugTHfOBUCGl+ikTqpGyxBcUm+9m6QYhJcoJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFhk6KxHY/CjZigBxAdFPI9j1MeEGf7l2+pAzYQ/3Q4JgxnnC
	GAKtQibIjJFdFMGm6ysb23FyC655GiTzAEnrHQxuxLgNU/yqQfsg2UYld1xQxXpy+VMG+v+U2k/
	FUi+pbWj+nHKH5p+hM675BzGYJb4VQFRdFnWTRXAn
X-Gm-Gg: ASbGncsLJxKuoYr8B9SqUikt3mNWoUcNmrPFdk4m3FFagjc1RyjYvvKfQCjjmV+ano4
	ZQz551W/Lo1CGOUf5pUw96LVBUqx7UhlpcH9CbRGdXArY3Op4qrbwYj6TCokNCsSaTATd60ny81
	fMZ/QZvpsJlN4YeszU/v9I0r4/I8GLs8Ydl9/BFbfusjWEr+XJCVQu5i9QZj3of+kA9Blk6TKY9
	lPq308+cE9F
X-Google-Smtp-Source: AGHT+IGpoONlCIOAmMBpkfhbwwmRo6WPxhB3OyNDNkTIiNF4jxrBqrGuAWP/ZktJKaI8KQeNzgcj6VefKfyiJbBSYPU=
X-Received: by 2002:a05:6e02:2589:b0:425:7759:802b with SMTP id
 e9e14a558f8ab-42865823250mr3145845ab.3.1758935839686; Fri, 26 Sep 2025
 18:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-22-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-22-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 18:17:08 -0700
X-Gm-Features: AS18NWC10t7P1-gbNUaB2koz9Kn412M7cqwnvwuIUDJz-je5B49gAVgPRT2D2pk
Message-ID: <CAJuCfpGhv15YLyAm7X63t5gT9hkw+6PK3GZbWmOTng+AG7rEsg@mail.gmail.com>
Subject: Re: [PATCH v8 22/23] maple_tree: Add single node allocation support
 to maple state
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
>  include/linux/maple_tree.h       |  4 +++-
>  lib/maple_tree.c                 | 47 ++++++++++++++++++++++++++++++++++=
+-----
>  tools/testing/radix-tree/maple.c |  9 ++++++--
>  3 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 166fd67e00d882b1e6de1f80c1b590bba7497cd3..562a1e9e5132b5b1fa8f8402a=
7cadd8abb65e323 100644
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
> index a3fcb20227e506ed209554cc8c041a53f7ef4903..a912e6a1d4378e72b967027b6=
0f8f564476ad14e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1073,16 +1073,23 @@ static int mas_ascend(struct ma_state *mas)
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
> @@ -1093,9 +1100,34 @@ static inline struct maple_node *mas_pop_node(stru=
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

Hmm, I don't get the above logic. One node is requested and instead of
using possibly available mas->alloc, we jump to using mas->sheaf and
freeing mas->alloc... That does not sound efficient. What am I
missing?

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
> +               kfree(mas->alloc);
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
> @@ -5180,8 +5212,11 @@ void mas_destroy(struct ma_state *mas)
>         mas->node_request =3D 0;
>         if (mas->sheaf)
>                 mt_return_sheaf(mas->sheaf);
> -
>         mas->sheaf =3D NULL;
> +
> +       if (mas->alloc)
> +               kfree(mas->alloc);
> +       mas->alloc =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(mas_destroy);
>
> @@ -5816,7 +5851,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>                 mas_alloc_nodes(mas, gfp);
>         }
>
> -       if (!mas->sheaf)
> +       if (!mas->sheaf && !mas->alloc)
>                 return false;
>
>         mas->status =3D ma_start;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/=
maple.c
> index 72a8fe8e832a4150c6567b711768eba6a3fa6768..83260f2efb1990b71093e4569=
50069c24d75560e 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35085,10 +35085,15 @@ static unsigned char get_vacant_height(struct m=
a_wr_state *wr_mas, void *entry)
>
>  static int mas_allocated(struct ma_state *mas)
>  {
> +       int total =3D 0;
> +
> +       if (mas->alloc)
> +               total++;
> +
>         if (mas->sheaf)
> -               return kmem_cache_sheaf_size(mas->sheaf);
> +               total +=3D kmem_cache_sheaf_size(mas->sheaf);
>
> -       return 0;
> +       return total;
>  }
>  /* Preallocation testing */
>  static noinline void __init check_prealloc(struct maple_tree *mt)
>
> --
> 2.51.0
>
