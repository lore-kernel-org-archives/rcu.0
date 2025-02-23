Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDCF15383A
	for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740284865; cv=none; b=DVifKjzbMIWlP8kP/H6n+6qNa/IX6H0b1eIZELUYaxz64DrUiw5X9i0vchzbuIhtF8YbLKcYZfEBI+kTzHABOASlQfNtUUI+yl5zlpSo4HSRxtqbbpfWqOBJBkoQxA9G/QMsICcB5HnuUsxYX798DyMZy977G1/Te5T03hEqGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740284865; c=relaxed/simple;
	bh=8EVSiL99zAeOpD/QvDtBerJcoYAm3xePWOBvFsPwUOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+ITW15DMUw8Kydbrjqtb/bar35TGW6fgCb1RAw3p/8irjQIXYrQlvywDsPiyWTpEl3CMK7Tb1ZjDTmwwoQyt6gO9noyYrxZJ9qXO3CBtM9HU6be6Lt0G1brhUF2jf/P0W8Gau12mLSRnQ0zYn4NHDAxV6t/itKSWYAAcESeaxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgr0MdA6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgr0MdA6"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-472098e6e75so243501cf.1
        for <rcu@vger.kernel.org>; Sat, 22 Feb 2025 20:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740284863; x=1740889663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmm1I+SoVSWD3Lw3CCPR58AX+UVflR4TsL2veWY2GZs=;
        b=zgr0MdA6VWPMuKxUb8SZ2b2mVcUaoR6rkQm/5iduQypJHb1qWNTDyXEllK3j2H+OGh
         NK9K1tLHvHCDoN80IFYgm9SUXG7ZAoUNhx4IxcqC2SEJVPieAOUKfQuySXnnsesTcrdd
         6mJO2HsSzwJKbBwzlS7KT/im5+D0m2IXwQHI4NtUUGIRY/e6el7hyHH1wG+vC4KAPSO4
         jOtmZX+O06R76acquxlfddghZV4A6JHj/sqtZsmE4MSHCDbMdy8VeU0NB7npH10tJJxc
         bKRiSYVUHMg+pV8iln4kAiNkfUTGwFndcTzjq8OyWesrymc6fsb8gTtMXTwz7xIQMCRB
         EJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740284863; x=1740889663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmm1I+SoVSWD3Lw3CCPR58AX+UVflR4TsL2veWY2GZs=;
        b=tD6P10E6yEkQ/sEhRJIup0TrJHJk9x+C81w04KD4eGJVBDdQAg1TMJQKCPY4m7GlN5
         DzEVRkqI5l934vgxWg7+BzGzmzO+5MsF0EtNUzptaI9gec94EPIo4md8MwrcWZdE1m9n
         Pd2V8o7P/cM9XzW/gr2DKmxQoKsWdcNfeMzlkqxEoVsJSxB6da++Ru1Syg7bqr3YhBtL
         QGOB1X28rajy7GKFlX0ORY5KOdUMI3rj8eCyzOI2Y2lyzzOTcvfv23+2XOwJe+FbLNh5
         yXzkQk5JLMp4negYrGNxVyQoRpzEtY09FEHnCbPhaOxHjw/3gY5dyEzY+oqmPkZneiD6
         wMSg==
X-Forwarded-Encrypted: i=1; AJvYcCWdgF4Qh6lsE2Z8wFU4HSexY7Um0WnE/vsjUBvfPP4Sh2STHaz1iLly1RLydsscU5/j/RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpgUQhscMiEoSHty1YW2NReO3k+zDMW2IRMCFRtgq3xRtBYY+
	zG8xijcqrHb1DVQnwMK1qbz5BKxO6W+wTO02/5OfIKUbeJyLXLMFix5Z15fAw1lJiBvvQ35DD6W
	xGo0xUiGVGAPYnBym+zFcBWw22SYrCf5N7uyB
X-Gm-Gg: ASbGnctskUJvGTxqEw9lq/FAiOIseuld/GCchjdKyoD9zidB9yE/UryyZV3hEunJC3C
	+sNRHkpySSdEpzqQ7jL54gcXDsYwy/JNKn5526iaYOHSlgMZt4BDafCqFqjtqh5PKTPiX240I9X
	F6mB/BUlQ=
X-Google-Smtp-Source: AGHT+IFKfxPHgKbPeASJWumHoaXB34NvZ31EQJsUHMALoZH4DiPcJzVNOQgIWlGulYe46FriKG+KJhd2DEw1EVddR1I=
X-Received: by 2002:a05:622a:206:b0:471:812b:508 with SMTP id
 d75a77b69052e-472334f363bmr3276441cf.14.1740284862672; Sat, 22 Feb 2025
 20:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz> <20250214-slub-percpu-caches-v2-10-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-10-88592ee0966a@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 20:27:30 -0800
X-Gm-Features: AWEUYZl6dIhm_eWSWjzkMiAN7GpBCH5Emzl1y5_M1yS7d4skO0MoR1hBC6n3Cog
Message-ID: <CAJuCfpGsAJZrS2HLTpe5mADn9wF6WeO3bxK9L-npCcg_6N9veQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/10] maple_tree: use percpu sheaves for maple_node_cache
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:28=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Setup the maple_node_cache with percpu sheaves of size 32 to hopefully
> improve its performance.

I guess 32 might change in the future based on further testing?

> Change the single node rcu freeing in
> ma_free_rcu() to use kfree_rcu() instead of the custom callback, which
> allows the rcu_free sheaf batching to be used. Note there are other
> users of mt_free_rcu() where larger parts of maple tree are submitted to
> call_rcu() as a whole, and that cannot use the rcu_free sheaf, but it's
> still possible for maple nodes freed this way to be reused via the barn,
> even if only some cpus are allowed to process rcu callbacks.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  lib/maple_tree.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f7153ade1be5f16423f0ca073846a7f3dfa60523..56e7a00f6f0941bff163091c9=
99a873e4273f071 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -208,7 +208,7 @@ static void mt_free_rcu(struct rcu_head *head)
>  static void ma_free_rcu(struct maple_node *node)
>  {
>         WARN_ON(node->parent !=3D ma_parent_ptr(node));
> -       call_rcu(&node->rcu, mt_free_rcu);
> +       kfree_rcu(node, rcu);
>  }
>
>  static void mas_set_height(struct ma_state *mas)
> @@ -6258,9 +6258,14 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>
>  void __init maple_tree_init(void)
>  {
> +       struct kmem_cache_args args =3D {
> +               .align  =3D sizeof(struct maple_node),
> +               .sheaf_capacity =3D 32,
> +       };
> +
>         maple_node_cache =3D kmem_cache_create("maple_node",
> -                       sizeof(struct maple_node), sizeof(struct maple_no=
de),
> -                       SLAB_PANIC, NULL);
> +                       sizeof(struct maple_node), &args,
> +                       SLAB_PANIC);
>  }
>
>  /**
>
> --
> 2.48.1
>
