Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE7286D76
	for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880117; cv=none; b=P3zCndaafOecRoad6zAtkLE2j4c6RTlKMXh2RPsbW0yky5NY1+q1evsIrTC4bnwuiE1kIZXlVpBOH7aDRzspXRnmWpS+jYHeERU88aZdLFAObA4D0TsEpFXuUaG6M/+tSZtZme4MMbJgj4VrAK+HFlUhnJCzHJEi2WlGIWxaT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880117; c=relaxed/simple;
	bh=lbFjMjAiva+RnH+MObTcNPysxHEPqtxiyvAjO7g8pIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtHNQIbMDrfWkq1n0gb62l77v6X4OfHQ3clBOBX2qZScm2xq94I2fFaF96DRDgp65xd78qkylXrmIGnKeW+4FCkE1/vIYBXuercETC4JSQASPoiN0hS9It0mBuoFiY7PLWdlSol/EtdkH+nVGz5XMAbz5KLRn0kxSUxcmI0diXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPpGaxul; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPpGaxul"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b29b714f8cso329411cf.1
        for <rcu@vger.kernel.org>; Fri, 22 Aug 2025 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755880114; x=1756484914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf+lgLCtUqo6j13pKWPsvYiNR6tNGJ0wVHF5rG3wEgE=;
        b=dPpGaxullA2BT5F1Q7j4E/fBAfjQaCKbBPrN5ZopIHspEgffzVR0nuOJs+JyaNyrMX
         dhT8UOoCkIgCB6YOiBcuOQo3ej6wc+08jA1wvhnfdcdDhMPk1YmMXEoLQ3ll62K0/8Wo
         JqyRC9MC/Sj1VjI4Hi0JYpuZIa81MTnJkT+LWP2pvN1+FHn+KlPwRxdntzQwuC+TQBj3
         cFu6JNbKQHNSMV9BUlz3gULxAknpdOXqX+A7Z3t9aOB5haqCmutdWecaCrb+oVCj+7Vm
         grxIKdGGZLO8aYm9cSkTsx2dc8hDs2si4IdokX8Q2FOM13HdDIUP9A7weMVoxmoIkh5e
         i39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755880114; x=1756484914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf+lgLCtUqo6j13pKWPsvYiNR6tNGJ0wVHF5rG3wEgE=;
        b=UrmM2xyU0QXN8s4pF0FXtoYZ2pPXuKi804Lb/ayPTBYNpX92JY6IlxKMWPT/h2OAjd
         6gaSlXU7q3ZHEeV8Wa0Oz4sTWjKgRYsAps7kA2hTyVC8+6m1/4W4q2/KGFp9edS+mn9y
         wBNzk0KfQqE9/5z/wmNO/dyghTGskDhjjAI3HWis29FXmodBkLIUVdTlK9NqbNF9nfZn
         1yKrEtGJdwB3MELqR++ntv6y0JXZf3ZZ8APJGSUgJrOi0M9yoiX4RCnQigY9Ei9MSryR
         3CQyW5z91ZXPPm0zhyCwrj5P0DjExXxDDkESN4bj4ifPQRU+MrQKQXLlw5fXQJ4fkhq9
         jrKg==
X-Forwarded-Encrypted: i=1; AJvYcCWTDmSumSlgycxFY1Hq5Ml8zEhC4m/kH4O9yPYB03QTJDOBvGxliP4XJfNrcH5GUbaD+kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNfQkJMnmUCAboJhq5dC2cb2CgGQ6JHFVJKKSoCjsh5g5Zj10
	4/P+obxWrTIvWn3D2M7c9RtuizPGET6w7CO6JIpTk3jqEYZe3W3RB6IGrd/IYu9K+7wf0Al3611
	qTvWFlr2UvoZdScTaesI5lkl1T6ip1wi775wySbSo
X-Gm-Gg: ASbGncsGvKYh5z+mLYoarVtpoxJ+yP7O+ku49FyQcJTUsIeclEV0EZGry/xAR4mtjeK
	sJYETa0+W0lGx7yFbsWtnqq02WkP4v+qPHqdGxHtEum/F6qu5qBA3CjRGq4NFytOmJ66wONy1JW
	i7jIlTabLEcEt+oTcB9hDUgLIiMiAf3ZmtVtNTF5JViZxxo4mDr88G0KiBLLo8Xsod4UPsis0td
	ClWkWjW7p1J
X-Google-Smtp-Source: AGHT+IEeB9T4qbL+UK0u9FG3kDDzOikNRJHFqBW5WtIsltP7tBFpOKmY+dFwDmwerpPmhmqCXCSRQaTv+MbAq/hPPUs=
X-Received: by 2002:a05:622a:180b:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4b2ac5b8096mr6202121cf.15.1755880113114; Fri, 22 Aug 2025
 09:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-5-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-5-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 09:28:21 -0700
X-Gm-Features: Ac12FXwI69etioIK7mYTuyWUpdhOHZOX0stE9nJoaN7MNJhvTMXHGKoJ0u9Mnow
Message-ID: <CAJuCfpHR=hceuAcnaCr3Hg-3mknvsmYy7jSScA8SATn7iwoN_w@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] tools: Add testing support for changes to rcu
 and slab for sheaves
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
> Make testing work for the slab and rcu changes that have come in with
> the sheaves work.
>
> This only works with one kmem_cache, and only the first one used.
> Subsequent setting of kmem_cache will not update the active kmem_cache
> and will be silently dropped because there are other tests which happen
> after the kmem_cache of interest is set.
>
> The saved active kmem_cache is used in the rcu callback, which passes
> the object to be freed.
>
> The rcu call takes the rcu_head, which is passed in as the field in the
> struct (in this case rcu in the maple tree node), which is calculated by
> pointer math.  The offset of which is saved (in a global variable) for
> restoring the node pointer on the callback after the rcu grace period
> expires.
>
> Don't use any of this outside of testing, please.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Couple nits but otherwise LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  tools/include/linux/slab.h            | 41 +++++++++++++++++++++++++++++=
+++---
>  tools/testing/shared/linux.c          | 24 ++++++++++++++++----
>  tools/testing/shared/linux/rcupdate.h | 22 +++++++++++++++++++
>  3 files changed, 80 insertions(+), 7 deletions(-)
>
> diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
> index c87051e2b26f5a7fee0362697fae067076b8e84d..d1444e79f2685edb828adbce8=
b3fbb500c0f8844 100644
> --- a/tools/include/linux/slab.h
> +++ b/tools/include/linux/slab.h
> @@ -23,6 +23,12 @@ enum slab_state {
>         FULL
>  };
>
> +struct kmem_cache_args {
> +       unsigned int align;
> +       unsigned int sheaf_capacity;
> +       void (*ctor)(void *);
> +};
> +
>  static inline void *kzalloc(size_t size, gfp_t gfp)
>  {
>         return kmalloc(size, gfp | __GFP_ZERO);
> @@ -37,9 +43,38 @@ static inline void *kmem_cache_alloc(struct kmem_cache=
 *cachep, int flags)
>  }
>  void kmem_cache_free(struct kmem_cache *cachep, void *objp);
>
> -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size=
,
> -                       unsigned int align, unsigned int flags,
> -                       void (*ctor)(void *));
> +
> +struct kmem_cache *
> +__kmem_cache_create_args(const char *name, unsigned int size,
> +               struct kmem_cache_args *args, unsigned int flags);
> +
> +/* If NULL is passed for @args, use this variant with default arguments.=
 */
> +static inline struct kmem_cache *
> +__kmem_cache_default_args(const char *name, unsigned int size,
> +               struct kmem_cache_args *args, unsigned int flags)
> +{
> +       struct kmem_cache_args kmem_default_args =3D {};
> +
> +       return __kmem_cache_create_args(name, size, &kmem_default_args, f=
lags);
> +}
> +
> +static inline struct kmem_cache *
> +__kmem_cache_create(const char *name, unsigned int size, unsigned int al=
ign,
> +               unsigned int flags, void (*ctor)(void *))
> +{
> +       struct kmem_cache_args kmem_args =3D {
> +               .align  =3D align,
> +               .ctor   =3D ctor,
> +       };
> +
> +       return __kmem_cache_create_args(name, size, &kmem_args, flags);
> +}
> +
> +#define kmem_cache_create(__name, __object_size, __args, ...)           =
\
> +       _Generic((__args),                                              \
> +               struct kmem_cache_args *: __kmem_cache_create_args,     \
> +               void *: __kmem_cache_default_args,                      \
> +               default: __kmem_cache_create)(__name, __object_size, __ar=
gs, __VA_ARGS__)
>
>  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void *=
*list);
>  int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t s=
ize,
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 0f97fb0d19e19c327aa4843a35b45cc086f4f366..f998555a1b2af4a899a468a65=
2b04622df459ed3 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -20,6 +20,7 @@ struct kmem_cache {
>         pthread_mutex_t lock;
>         unsigned int size;
>         unsigned int align;
> +       unsigned int sheaf_capacity;
>         int nr_objs;
>         void *objs;
>         void (*ctor)(void *);
> @@ -31,6 +32,8 @@ struct kmem_cache {
>         void *private;
>  };
>
> +static struct kmem_cache *kmem_active =3D NULL;
> +
>  void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)=
(void *))
>  {
>         cachep->callback =3D callback;
> @@ -147,6 +150,14 @@ void kmem_cache_free(struct kmem_cache *cachep, void=
 *objp)
>         pthread_mutex_unlock(&cachep->lock);
>  }
>
> +void kmem_cache_free_active(void *objp)
> +{
> +       if (!kmem_active)
> +               printf("WARNING: No active kmem_cache\n");
> +
> +       kmem_cache_free(kmem_active, objp);
> +}
> +
>  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void *=
*list)
>  {
>         if (kmalloc_verbose)
> @@ -234,23 +245,28 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep=
, gfp_t gfp, size_t size,
>  }
>
>  struct kmem_cache *
> -kmem_cache_create(const char *name, unsigned int size, unsigned int alig=
n,
> -               unsigned int flags, void (*ctor)(void *))
> +__kmem_cache_create_args(const char *name, unsigned int size,
> +                         struct kmem_cache_args *args,
> +                         unsigned int flags)
>  {
>         struct kmem_cache *ret =3D malloc(sizeof(*ret));
>
>         pthread_mutex_init(&ret->lock, NULL);
>         ret->size =3D size;
> -       ret->align =3D align;
> +       ret->align =3D args->align;
> +       ret->sheaf_capacity =3D args->sheaf_capacity;
>         ret->nr_objs =3D 0;
>         ret->nr_allocated =3D 0;
>         ret->nr_tallocated =3D 0;
>         ret->objs =3D NULL;
> -       ret->ctor =3D ctor;
> +       ret->ctor =3D args->ctor;
>         ret->non_kernel =3D 0;
>         ret->exec_callback =3D false;
>         ret->callback =3D NULL;
>         ret->private =3D NULL;
> +       if (!kmem_active)
> +               kmem_active =3D ret;
> +
>         return ret;
>  }
>
> diff --git a/tools/testing/shared/linux/rcupdate.h b/tools/testing/shared=
/linux/rcupdate.h
> index fed468fb0c78db6f33fb1900c7110ab5f3c19c65..c95e2f0bbd93798e544d7d34e=
0823ed68414f924 100644
> --- a/tools/testing/shared/linux/rcupdate.h
> +++ b/tools/testing/shared/linux/rcupdate.h
> @@ -9,4 +9,26 @@
>  #define rcu_dereference_check(p, cond) rcu_dereference(p)
>  #define RCU_INIT_POINTER(p, v) do { (p) =3D (v); } while (0)
>
> +void kmem_cache_free_active(void *objp);
> +static unsigned long kfree_cb_offset =3D 0;
> +
> +static inline void kfree_rcu_cb(struct rcu_head *head)
> +{
> +       void *objp =3D (void *) ((unsigned long)head - kfree_cb_offset);
> +
> +       kmem_cache_free_active(objp);
> +}
> +
> +#ifndef offsetof
> +#define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
> +#endif
> +

We need a comment here that concurrent kfree_rcu() calls are not
supported because they would override each other's kfree_cb_offset.
Kinda obvious but I think unusual limitations should be explicitly
called out.

> +#define kfree_rcu(ptr, rhv)                                            \
> +do {                                                                   \
> +       if (!kfree_cb_offset)                                           \
> +               kfree_cb_offset =3D offsetof(typeof(*(ptr)), rhv);       =
 \
> +                                                                       \
> +       call_rcu(&ptr->rhv, kfree_rcu_cb);                              \
> +} while (0)

Any specific reason kfree_rcu() is a macro and not a static inline function=
?

> +
>  #endif
>
> --
> 2.50.1
>
