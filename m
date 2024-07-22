Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A6D2F5;
	Mon, 22 Jul 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657846; cv=none; b=HueVdsezqa4RDrQ7P8at6cqU8VCQES6z62iRDGb8aA1pe9yLCiBngs1K41JGrP+RPorUKGN7+3452DHzxkh34F9OIWybBvTdMiw4h+obaCCCP1/b7fu7/mbSUe2/m5rU9TECQgEl7rX6nWKJmQKcWjY5Bjee9Ff2wWuLoRBX75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657846; c=relaxed/simple;
	bh=VfqZmPrxgFWi3ICc6QSbvnRoFNYv4J02mommYUC1yAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emu7ZCLacY3dwN/lFy89qQkssqmUnYP2JSzwf7HzSDIkIBEfGyLdNG9zQk0uf/HDwokzRSjFCSh5POzcnFuAtl9YmX2wbO9ZR4BEZXBtiuhTa/fJE7k0I/b0u/rNMi9uIpZWGICW+94jgwD25ETinIgXSP4QiftvWml8SZoihLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8hCuCig; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8hCuCig"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5cebd3bd468so2329582eaf.1;
        Mon, 22 Jul 2024 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721657844; x=1722262644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw3eisWLuZeGgaILJkXtnC5IGcenu22gbT3S7Hw254U=;
        b=g8hCuCigJsEoFRQV9xII0aDNPI1oT/zFEki24ws4sNiV/m174jCL+jlShCMswBjRDA
         ZtDpfpp7DBsnGu89zAy8CoEljeYXlJNJSjBdRKV3p9ghb05GRcHNQXjv9Gqzl9ZiecHf
         qCs7GoiPOUIqNleW0v8PzRB7O570goyjVLsy7no9wgmpL7lQEK8pEMFNrRkRKW05XTXr
         I52jz8+tfYcWDUAOH07/rwht13Hh8AN+gw9kcgoD2DpmT6STcWFFmM0+ysZEGhGdSwEb
         Gcsv3lkvVwMhRAc3/LrU4p6q9Z0Ob1E5lWrBAq8gL4wPsXPzd+1AC+twfeBZE97f5/HR
         qYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721657844; x=1722262644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw3eisWLuZeGgaILJkXtnC5IGcenu22gbT3S7Hw254U=;
        b=LmXmo+RGs4PJ/TGnbv7xYJlHuJkVqk/rFfnaP87c5vuMnNM09uJJBZNtlU3dvB/wlx
         7sHe86v1AT/Z8YOSNMzejl4ccRdH1xEaSFtfbGh+f7U1qiZODhVJHzIJNAZwr7D5UaK+
         SAQCj2oXr0ozcFI8sEupzQPBbap7PfplwCOb3A6hU0ZD6lnU1pM3kkWiUAInsbzmrxWj
         q8VmxvtIOIjZqZ6pKeVUDd3oQPhq/JSFVMTrsYcr/ZQ1oQRkotOBjQJpaOAmK73er2Qi
         KtltOTbsC5QkxegCZGiu9VXLH87Wss4WU0I/y4c2+H3Ob/F4r0fHg0eHk377yu9OiWLW
         D+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUuI0OOcG2DfGWuRrsNtaMNtzonScbzA1AIXGU0yVeiVShnFnc9DjoeCWXNlaAvX9c09Q3npNP62y3Ab4Ms35xsUwcmiS99l6T1A27SvgDkCAIMj57IvZetJzwUAKp3MnnV
X-Gm-Message-State: AOJu0YwRZlof2njLm89onma74gLo6NY6pqMdh33qsYKfim874KgMr7DD
	LNwCVaunINQyrV9w6TXLFK1D+n0JsSQQO6EyG/WOwjaBvPoCuJXTd/UnaiYw2NCse14tVG3ryGR
	HzkUeuJ/sUP+Zup4v4hVU+F5gMSgs7GuVNNMXR442ZSw=
X-Google-Smtp-Source: AGHT+IEYbzAdfQwz+pnDUObwz1euCWA5YSl30VMPQDT2VyKSZHWAgM5vxnUyWtD+pLWMKNVbgdYu45VPZujze8LTiXc=
X-Received: by 2002:a05:6871:5c8:b0:260:71c4:f33a with SMTP id
 586e51a60fabf-263ab67df6fmr6093251fac.39.1721657840080; Mon, 22 Jul 2024
 07:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz> <20240715-b4-slab-kfree_rcu-destroy-v1-2-46b2984c2205@suse.cz>
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-2-46b2984c2205@suse.cz>
From: Xiongwei Song <sxwjean@gmail.com>
Date: Mon, 22 Jul 2024 22:16:54 +0800
Message-ID: <CAEVVKH_XRmPUEJmo7xXwuNV3mCA8=SHxLdY9EjC9XFZsuqAXJw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] mm, slab: always maintain per-node slab and
 object count
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Don't we need the following changes for this patch?

diff --git a/mm/slub.c b/mm/slub.c
index c1222467c346..e6beb6743342 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4967,9 +4967,9 @@ init_kmem_cache_node(struct kmem_cache_node *n)
        n->nr_partial =3D 0;
        spin_lock_init(&n->list_lock);
        INIT_LIST_HEAD(&n->partial);
-#ifdef CONFIG_SLUB_DEBUG
        atomic_long_set(&n->nr_slabs, 0);
        atomic_long_set(&n->total_objects, 0);
+#ifdef CONFIG_SLUB_DEBUG
        INIT_LIST_HEAD(&n->full);
 #endif
 }

Thanks,
Xiongwei


On Tue, Jul 16, 2024 at 4:29=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Currently SLUB counts per-node slabs and total objects only with
> CONFIG_SLUB_DEBUG, in order to minimize overhead. However, the detection
> in __kmem_cache_shutdown() whether there are no outstanding object
> relies on the per-node slab count (node_nr_slabs()) so it may be
> unreliable without CONFIG_SLUB_DEBUG. Thus we might be failing to warn
> about such situations, and instead destroy a cache while leaving its
> slab(s) around (due to a buggy slab user creating such a scenario, not
> in normal operation).
>
> We will also need node_nr_slabs() to be reliable in the following work
> to gracefully handle kmem_cache_destroy() with kfree_rcu() objects in
> flight. Thus make the counting of per-node slabs and objects
> unconditional.
>
> Note that CONFIG_SLUB_DEBUG is the default anyway, and the counting is
> done only when allocating or freeing a slab page, so even in
> !CONFIG_SLUB_DEBUG configs the overhead should be negligible.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 49 +++++++++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 829a1f08e8a2..aa4d80109c49 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -426,9 +426,9 @@ struct kmem_cache_node {
>         spinlock_t list_lock;
>         unsigned long nr_partial;
>         struct list_head partial;
> -#ifdef CONFIG_SLUB_DEBUG
>         atomic_long_t nr_slabs;
>         atomic_long_t total_objects;
> +#ifdef CONFIG_SLUB_DEBUG
>         struct list_head full;
>  #endif
>  };
> @@ -438,6 +438,26 @@ static inline struct kmem_cache_node *get_node(struc=
t kmem_cache *s, int node)
>         return s->node[node];
>  }
>
> +static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
> +{
> +       return atomic_long_read(&n->nr_slabs);
> +}
> +
> +static inline void inc_slabs_node(struct kmem_cache *s, int node, int ob=
jects)
> +{
> +       struct kmem_cache_node *n =3D get_node(s, node);
> +
> +       atomic_long_inc(&n->nr_slabs);
> +       atomic_long_add(objects, &n->total_objects);
> +}
> +static inline void dec_slabs_node(struct kmem_cache *s, int node, int ob=
jects)
> +{
> +       struct kmem_cache_node *n =3D get_node(s, node);
> +
> +       atomic_long_dec(&n->nr_slabs);
> +       atomic_long_sub(objects, &n->total_objects);
> +}
> +
>  /*
>   * Iterator over all nodes. The body will be executed for each node that=
 has
>   * a kmem_cache_node structure allocated (which is true for all online n=
odes)
> @@ -1511,26 +1531,6 @@ static void remove_full(struct kmem_cache *s, stru=
ct kmem_cache_node *n, struct
>         list_del(&slab->slab_list);
>  }
>
> -static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
> -{
> -       return atomic_long_read(&n->nr_slabs);
> -}
> -
> -static inline void inc_slabs_node(struct kmem_cache *s, int node, int ob=
jects)
> -{
> -       struct kmem_cache_node *n =3D get_node(s, node);
> -
> -       atomic_long_inc(&n->nr_slabs);
> -       atomic_long_add(objects, &n->total_objects);
> -}
> -static inline void dec_slabs_node(struct kmem_cache *s, int node, int ob=
jects)
> -{
> -       struct kmem_cache_node *n =3D get_node(s, node);
> -
> -       atomic_long_dec(&n->nr_slabs);
> -       atomic_long_sub(objects, &n->total_objects);
> -}
> -
>  /* Object debug checks for alloc/free paths */
>  static void setup_object_debug(struct kmem_cache *s, void *object)
>  {
> @@ -1871,13 +1871,6 @@ slab_flags_t kmem_cache_flags(slab_flags_t flags, =
const char *name)
>
>  #define disable_higher_order_debug 0
>
> -static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
> -                                                       { return 0; }
> -static inline void inc_slabs_node(struct kmem_cache *s, int node,
> -                                                       int objects) {}
> -static inline void dec_slabs_node(struct kmem_cache *s, int node,
> -                                                       int objects) {}
> -
>  #ifndef CONFIG_SLUB_TINY
>  static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>                                void **freelist, void *nextfree)
>
> --
> 2.45.2
>
>
