Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50326D4E8
	for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774921; cv=none; b=iy4QBFL422Fbmmi0q7DD+P3N297eCzvHWaCUXtYxqgx6jiF/LmZcTBYsD5mQaJ4sIGK9q4X9EIA+sR+fRAMMf/aG/fp8EIzNbdjT1uQshom21e4WcYSuyBaH7PsW0xfF/RWxAqWB2MP+Ce7IVLRwX7c+yJunZgu7u3FWKcICtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774921; c=relaxed/simple;
	bh=UVYbQlmQYkGJgk0Gcme3AcpVzvQpaDAZNr7i2ICQwt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXTfOUfDM0gp0uDjXJG7Pka61vEd97VP4F7SWtqlNsvr73GpC2MKwnReYN0nbqMk9D1c1Px7YZC3djoJvano/Cc2/Zqci3rH3jGzVYK/N/Oq7/1XbB91rN8HzjaChBqBxH0XYOz0YtTQBZ+Zl3F9Ib+Fz8ChbEyg1yDEvYS9k9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sYDEmjGw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sYDEmjGw"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4bb7209ec97so896011cf.1
        for <rcu@vger.kernel.org>; Wed, 24 Sep 2025 21:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758774917; x=1759379717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kzY7CwUVXANdLNDgqP+ogxGfetQO/MqEeAF5hYWfFE=;
        b=sYDEmjGw1Kb4tS1PdVS3adXMn8jHsbOqxP61xdS9wv8xw03nddKVaNCh61VcLlR2XC
         WsmomGIqESpYzNQOYLRdt8OAtTuu3dYg9WPRAU1G2VFy+gQDsBygRDFzVqwx1cTmyn9k
         DuolBaMIllPwF4H84zkM9vVeLsM+Wt+Z47ySIAXrE50BfbOSegmrRLjS9mWlU6kDvzBB
         i8glewvF+3EOXIoOTISVSv3sr+POecJSvhWksrKkpt3PhOoIGGbAUkcnGDjSwkGnIG80
         Z05/evpoufJTp1KAh7vwo2iooZ3dtgBb1Oe5MS552wHXQojBM/GPR85tQ+xgqP6swdf5
         QnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758774917; x=1759379717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kzY7CwUVXANdLNDgqP+ogxGfetQO/MqEeAF5hYWfFE=;
        b=SMalZ1/Vx4fc+L2IlPNIk2PGX9ynJgDyWowANm4tLZzP9SjTuzx8zP9dbFJ230d9JQ
         +xaqh6KbxLQn0WgsVyz5X+71WZQnMy/X5HhGDtSVrV6GhW38W/0S2Lng5G0OdkgdEc29
         y9Ca+wDgxTghkuGbPwBHYW9ZR6a0oj1Hi6dz5agcIXBplrcP8WVgkeunLHQAEg5OS3+Y
         RSJGu0uF2BT99+n1ZAOUeO5XMANBu7gRvQnQzyKqov9kIcFDJ91EaaMrqhHklEdvO+06
         dgG+5rtIKjuLZ3s1okgFsh0etn7oxWC7C8MIXvpIPFGcGnaqkJjfptFgirqo7+Mwzmin
         3QcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+qF/u2fmKTBGqPiJa3UXGHs6OUQcNKkYYvd1Nf67w9TH58fQEt77UzxkT76Fvo4O93Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0iBDMrzGfS30OmFYcqkTD6EL/O34BI7Z72Jgxekaxu7BYecED
	jMg9tIHJRuf8XfNj8fCDPeQtPizcPKgvjQqbCX1i+dUCZAgLMk6NtYMu9+5M39hXWu/i6Dzf/tT
	+2UTYeMY6N0YQ0xEVaB9pG8PavEb5JjbgsCc5Q17N
X-Gm-Gg: ASbGncv2h2olqb4ksjDUgWvK41D/+3UO162g92eBe3XWrIad2kdNVn+p1nDI0DmaUVZ
	B68rm+c59k0fF6oV17dUhe5OUujbNgiRJE4XeLWzkwSt2eZRrXIdkLCnhU1JjDK1yLADJFbe1+5
	z1/CLcr9Zs/Tu5JUtBiJhZ6uf+vznPCziixuczZTwBmSXneqrATYP6sXDNKXKh6kXmaW0w/+UCS
	xckGJ7uj1Ih
X-Google-Smtp-Source: AGHT+IG2Wb4HjFvOv8a6AG2zR5eenW3JgqvDgAiLmpgs1ur/WRho1KcgKXqa3h838KFDGw4qBzVjvcxYxhIB91pQ1/k=
X-Received: by 2002:ac8:58c6:0:b0:4b7:a203:259f with SMTP id
 d75a77b69052e-4da2c4c3cdamr3847801cf.6.1758774916900; Wed, 24 Sep 2025
 21:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz> <aMpxnACqmsQl-lp0@hyeyoo>
 <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz> <aMqcXyKRlZggLxu_@hyeyoo>
 <6f92eca3-863e-4b77-b2df-dc2752c0ff4e@suse.cz> <aMqyn6nenR8V_p1y@hyeyoo>
 <bf8b4741-1025-4cc8-b9ed-5b566bdcb2d7@suse.cz> <aMq40h5iOjj8K7cc@hyeyoo>
 <a32bd837-2597-43d0-9da3-1ce5a53b15f4@suse.cz> <40461105-a344-444f-834b-9559b6644710@suse.cz>
In-Reply-To: <40461105-a344-444f-834b-9559b6644710@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Sep 2025 21:35:05 -0700
X-Gm-Features: AS18NWC2YAn9BnNHl94nFx70tYY9EGEqBv6dDxgACbFs-JBHOscSattKo4c2eH4
Message-ID: <CAJuCfpG6CSm2iZ3jrwLQA4vVbTMvC=B37q10OL+wLzm-DSRhFw@mail.gmail.com>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu() operations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/17/25 16:14, Vlastimil Babka wrote:
> > On 9/17/25 15:34, Harry Yoo wrote:
> >> On Wed, Sep 17, 2025 at 03:21:31PM +0200, Vlastimil Babka wrote:
> >>> On 9/17/25 15:07, Harry Yoo wrote:
> >>> > On Wed, Sep 17, 2025 at 02:05:49PM +0200, Vlastimil Babka wrote:
> >>> >> On 9/17/25 13:32, Harry Yoo wrote:
> >>> >> > On Wed, Sep 17, 2025 at 11:55:10AM +0200, Vlastimil Babka wrote:
> >>> >> >> On 9/17/25 10:30, Harry Yoo wrote:
> >>> >> >> > On Wed, Sep 10, 2025 at 10:01:06AM +0200, Vlastimil Babka wro=
te:
> >>> >> >> >> +                          sfw->skip =3D true;
> >>> >> >> >> +                          continue;
> >>> >> >> >> +                  }
> >>> >> >> >>
> >>> >> >> >> +                  INIT_WORK(&sfw->work, flush_rcu_sheaf);
> >>> >> >> >> +                  sfw->skip =3D false;
> >>> >> >> >> +                  sfw->s =3D s;
> >>> >> >> >> +                  queue_work_on(cpu, flushwq, &sfw->work);
> >>> >> >> >> +                  flushed =3D true;
> >>> >> >> >> +          }
> >>> >> >> >> +
> >>> >> >> >> +          for_each_online_cpu(cpu) {
> >>> >> >> >> +                  sfw =3D &per_cpu(slub_flush, cpu);
> >>> >> >> >> +                  if (sfw->skip)
> >>> >> >> >> +                          continue;
> >>> >> >> >> +                  flush_work(&sfw->work);
> >>> >> >> >> +          }
> >>> >> >> >> +
> >>> >> >> >> +          mutex_unlock(&flush_lock);
> >>> >> >> >> +  }
> >>> >> >> >> +
> >>> >> >> >> +  mutex_unlock(&slab_mutex);
> >>> >> >> >> +  cpus_read_unlock();
> >>> >> >> >> +
> >>> >> >> >> +  if (flushed)
> >>> >> >> >> +          rcu_barrier();
> >>> >> >> >
> >>> >> >> > I think we need to call rcu_barrier() even if flushed =3D=3D =
false?
> >>> >> >> >
> >>> >> >> > Maybe a kvfree_rcu()'d object was already waiting for the rcu=
 callback to
> >>> >> >> > be processed before flush_all_rcu_sheaves() is called, and
> >>> >> >> > in flush_all_rcu_sheaves() we skipped all (cache, cpu) pairs,
> >>> >> >> > so flushed =3D=3D false but the rcu callback isn't processed =
yet
> >>> >> >> > by the end of the function?
> >>> >> >> >
> >>> >> >> > That sounds like a very unlikely to happen in a realistic sce=
nario,
> >>> >> >> > but still possible...
> >>> >> >>
> >>> >> >> Yes also good point, will flush unconditionally.
> >>> >> >>
> >>> >> >> Maybe in __kfree_rcu_sheaf() I should also move the call_rcu(..=
.) before
> >>> >> >> local_unlock().
> >>> >> >>
> >>> >> >> So we don't end up seeing a NULL pcs->rcu_free in
> >>> >> >> flush_all_rcu_sheaves() because __kfree_rcu_sheaf() already set=
 it to NULL,
> >>> >> >> but didn't yet do the call_rcu() as it got preempted after loca=
l_unlock().
> >>> >> >
> >>> >> > Makes sense to me.
> >>> >
> >>> > Wait, I'm confused.
> >>> >
> >>> > I think the caller of kvfree_rcu_barrier() should make sure that it=
's invoked
> >>> > only after a kvfree_rcu(X, rhs) call has returned, if the caller ex=
pects
> >>> > the object X to be freed before kvfree_rcu_barrier() returns?
> >>>
> >>> Hmm, the caller of kvfree_rcu(X, rhs) might have returned without fil=
ling up
> >>> the rcu_sheaf fully and thus without submitting it to call_rcu(), the=
n
> >>> migrated to another cpu. Then it calls kvfree_rcu_barrier() while ano=
ther
> >>> unrelated kvfree_rcu(X, rhs) call on the previous cpu is for the same
> >>> kmem_cache (kvfree_rcu_barrier() is not only for cache destruction), =
fills
> >>> up the rcu_sheaf fully and is about to call_rcu() on it. And since th=
at
> >>> sheaf also contains the object X, we should make sure that is flushed=
.
> >>
> >> I was going to say "but we queue and wait for the flushing work to
> >> complete, so the sheaf containing object X should be flushed?"
> >>
> >> But nah, that's true only if we see pcs->rcu_free !=3D NULL in
> >> flush_all_rcu_sheaves().
> >>
> >> You are right...
> >>
> >> Hmm, maybe it's simpler to fix this by never skipping queueing the wor=
k
> >> even when pcs->rcu_sheaf =3D=3D NULL?
> >
> > I guess it's simpler, yeah.
>
> So what about this? The unconditional queueing should cover all races wit=
h
> __kfree_rcu_sheaf() so there's just unconditional rcu_barrier() in the en=
d.
>
> From 0722b29fa1625b31c05d659d1d988ec882247b38 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 3 Sep 2025 14:59:46 +0200
> Subject: [PATCH] slab: add sheaf support for batching kfree_rcu() operati=
ons
>
> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> addition to main and spare sheaves.
>
> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> the sheaf is detached and submitted to call_rcu() with a handler that
> will try to put it in the barn, or flush to slab pages using bulk free,
> when the barn is full. Then a new empty sheaf must be obtained to put
> more objects there.
>
> It's possible that no free sheaves are available to use for a new
> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> kfree_rcu() implementation.
>
> Expected advantages:
> - batching the kfree_rcu() operations, that could eventually replace the
>   existing batching
> - sheaves can be reused for allocations via barn instead of being
>   flushed to slabs, which is more efficient
>   - this includes cases where only some cpus are allowed to process rcu
>     callbacks (Android)

nit: I would say it's more CONFIG_RCU_NOCB_CPU related. Android is
just an instance of that.

>
> Possible disadvantage:
> - objects might be waiting for more than their grace period (it is
>   determined by the last object freed into the sheaf), increasing memory
>   usage - but the existing batching does that too.
>
> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> implementation favors smaller memory footprint over performance.
>
> Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as the
> contexts where kfree_rcu() is called might not be compatible with taking
> a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
> spinlock - the current kfree_rcu() implementation avoids doing that.
>
> Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all caches
> that have them. This is not a cheap operation, but the barrier usage is
> rare - currently kmem_cache_destroy() or on module unload.
>
> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
> count how many kfree_rcu() used the rcu_free sheaf successfully and how
> many had to fall back to the existing implementation.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h        |   3 +
>  mm/slab_common.c |  26 +++++
>  mm/slub.c        | 267 ++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 294 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 206987ce44a4..e82e51c44bd0 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -435,6 +435,9 @@ static inline bool is_kmalloc_normal(struct kmem_cach=
e *s)
>         return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACC=
OUNT));
>  }
>
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +void flush_all_rcu_sheaves(void);
> +
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
>                          SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e2b197e47866..005a4319c06a 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1608,6 +1608,27 @@ static void kfree_rcu_work(struct work_struct *wor=
k)
>                 kvfree_rcu_list(head);
>  }
>
> +static bool kfree_rcu_sheaf(void *obj)
> +{
> +       struct kmem_cache *s;
> +       struct folio *folio;
> +       struct slab *slab;
> +
> +       if (is_vmalloc_addr(obj))
> +               return false;
> +
> +       folio =3D virt_to_folio(obj);
> +       if (unlikely(!folio_test_slab(folio)))
> +               return false;
> +
> +       slab =3D folio_slab(folio);
> +       s =3D slab->slab_cache;
> +       if (s->cpu_sheaves)
> +               return __kfree_rcu_sheaf(s, obj);
> +
> +       return false;
> +}
> +
>  static bool
>  need_offload_krc(struct kfree_rcu_cpu *krcp)
>  {
> @@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *p=
tr)
>         if (!head)
>                 might_sleep();
>
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
> +               return;
> +
>         // Queue the object but don't yet schedule the batch.
>         if (debug_rcu_head_queue(ptr)) {
>                 // Probable double kfree_rcu(), just leak.
> @@ -2026,6 +2050,8 @@ void kvfree_rcu_barrier(void)
>         bool queued;
>         int i, cpu;
>
> +       flush_all_rcu_sheaves();
> +
>         /*
>          * Firstly we detach objects and queue them over an RCU-batch
>          * for all CPUs. Finally queued works are flushed for each CPU.
> diff --git a/mm/slub.c b/mm/slub.c
> index cba188b7e04d..171273f90efd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -367,6 +367,8 @@ enum stat_item {
>         ALLOC_FASTPATH,         /* Allocation from cpu slab */
>         ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab *=
/
>         FREE_PCS,               /* Free to percpu sheaf */
> +       FREE_RCU_SHEAF,         /* Free to rcu_free sheaf */
> +       FREE_RCU_SHEAF_FAIL,    /* Failed to free to a rcu_free sheaf */
>         FREE_FASTPATH,          /* Free to cpu slab */
>         FREE_SLOWPATH,          /* Freeing not to cpu slab */
>         FREE_FROZEN,            /* Freeing to frozen slab */
> @@ -461,6 +463,7 @@ struct slab_sheaf {
>                 struct rcu_head rcu_head;
>                 struct list_head barn_list;
>         };
> +       struct kmem_cache *cache;
>         unsigned int size;
>         void *objects[];
>  };
> @@ -469,6 +472,7 @@ struct slub_percpu_sheaves {
>         local_trylock_t lock;
>         struct slab_sheaf *main; /* never NULL when unlocked */
>         struct slab_sheaf *spare; /* empty or full, may be NULL */
> +       struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
>  };
>
>  /*
> @@ -2531,6 +2535,8 @@ static struct slab_sheaf *alloc_empty_sheaf(struct =
kmem_cache *s, gfp_t gfp)
>         if (unlikely(!sheaf))
>                 return NULL;
>
> +       sheaf->cache =3D s;
> +
>         stat(s, SHEAF_ALLOC);
>
>         return sheaf;
> @@ -2655,6 +2661,43 @@ static void sheaf_flush_unused(struct kmem_cache *=
s, struct slab_sheaf *sheaf)
>         sheaf->size =3D 0;
>  }
>
> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> +                                    struct slab_sheaf *sheaf)
> +{
> +       bool init =3D slab_want_init_on_free(s);
> +       void **p =3D &sheaf->objects[0];
> +       unsigned int i =3D 0;
> +
> +       while (i < sheaf->size) {
> +               struct slab *slab =3D virt_to_slab(p[i]);
> +
> +               memcg_slab_free_hook(s, slab, p + i, 1);
> +               alloc_tagging_slab_free_hook(s, slab, p + i, 1);
> +
> +               if (unlikely(!slab_free_hook(s, p[i], init, true))) {
> +                       p[i] =3D p[--sheaf->size];
> +                       continue;
> +               }
> +
> +               i++;
> +       }
> +}
> +
> +static void rcu_free_sheaf_nobarn(struct rcu_head *head)
> +{
> +       struct slab_sheaf *sheaf;
> +       struct kmem_cache *s;
> +
> +       sheaf =3D container_of(head, struct slab_sheaf, rcu_head);
> +       s =3D sheaf->cache;
> +
> +       __rcu_free_sheaf_prepare(s, sheaf);
> +
> +       sheaf_flush_unused(s, sheaf);
> +
> +       free_empty_sheaf(s, sheaf);
> +}
> +
>  /*
>   * Caller needs to make sure migration is disabled in order to fully flu=
sh
>   * single cpu's sheaves
> @@ -2667,7 +2710,7 @@ static void sheaf_flush_unused(struct kmem_cache *s=
, struct slab_sheaf *sheaf)
>  static void pcs_flush_all(struct kmem_cache *s)
>  {
>         struct slub_percpu_sheaves *pcs;
> -       struct slab_sheaf *spare;
> +       struct slab_sheaf *spare, *rcu_free;
>
>         local_lock(&s->cpu_sheaves->lock);
>         pcs =3D this_cpu_ptr(s->cpu_sheaves);
> @@ -2675,6 +2718,9 @@ static void pcs_flush_all(struct kmem_cache *s)
>         spare =3D pcs->spare;
>         pcs->spare =3D NULL;
>
> +       rcu_free =3D pcs->rcu_free;
> +       pcs->rcu_free =3D NULL;
> +
>         local_unlock(&s->cpu_sheaves->lock);
>
>         if (spare) {
> @@ -2682,6 +2728,9 @@ static void pcs_flush_all(struct kmem_cache *s)
>                 free_empty_sheaf(s, spare);
>         }
>
> +       if (rcu_free)
> +               call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> +
>         sheaf_flush_main(s);
>  }
>
> @@ -2698,6 +2747,11 @@ static void __pcs_flush_all_cpu(struct kmem_cache =
*s, unsigned int cpu)
>                 free_empty_sheaf(s, pcs->spare);
>                 pcs->spare =3D NULL;
>         }
> +
> +       if (pcs->rcu_free) {
> +               call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn)=
;
> +               pcs->rcu_free =3D NULL;
> +       }
>  }
>
>  static void pcs_destroy(struct kmem_cache *s)
> @@ -2723,6 +2777,7 @@ static void pcs_destroy(struct kmem_cache *s)
>                  */
>
>                 WARN_ON(pcs->spare);
> +               WARN_ON(pcs->rcu_free);
>
>                 if (!WARN_ON(pcs->main->size)) {
>                         free_empty_sheaf(s, pcs->main);
> @@ -3780,7 +3835,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache=
 *s)
>
>         pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
>
> -       return (pcs->spare || pcs->main->size);
> +       return (pcs->spare || pcs->rcu_free || pcs->main->size);
>  }
>
>  /*
> @@ -3840,6 +3895,77 @@ static void flush_all(struct kmem_cache *s)
>         cpus_read_unlock();
>  }
>
> +static void flush_rcu_sheaf(struct work_struct *w)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *rcu_free;
> +       struct slub_flush_work *sfw;
> +       struct kmem_cache *s;
> +
> +       sfw =3D container_of(w, struct slub_flush_work, work);
> +       s =3D sfw->s;
> +
> +       local_lock(&s->cpu_sheaves->lock);
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       rcu_free =3D pcs->rcu_free;
> +       pcs->rcu_free =3D NULL;
> +
> +       local_unlock(&s->cpu_sheaves->lock);
> +
> +       if (rcu_free)
> +               call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> +}
> +
> +
> +/* needed for kvfree_rcu_barrier() */
> +void flush_all_rcu_sheaves(void)
> +{
> +       struct slub_flush_work *sfw;
> +       struct kmem_cache *s;
> +       unsigned int cpu;
> +
> +       cpus_read_lock();
> +       mutex_lock(&slab_mutex);
> +
> +       list_for_each_entry(s, &slab_caches, list) {
> +               if (!s->cpu_sheaves)
> +                       continue;
> +
> +               mutex_lock(&flush_lock);
> +
> +               for_each_online_cpu(cpu) {
> +                       sfw =3D &per_cpu(slub_flush, cpu);
> +
> +                       /*
> +                        * we don't check if rcu_free sheaf exists - raci=
ng
> +                        * __kfree_rcu_sheaf() might have just removed it=
.
> +                        * by executing flush_rcu_sheaf() on the cpu we m=
ake
> +                        * sure the __kfree_rcu_sheaf() finished its call=
_rcu()
> +                        */
> +
> +                       INIT_WORK(&sfw->work, flush_rcu_sheaf);
> +                       sfw->skip =3D false;

I think you don't need this sfw->skip flag since you never skip anymore, ri=
ght?

> +                       sfw->s =3D s;
> +                       queue_work_on(cpu, flushwq, &sfw->work);
> +               }
> +
> +               for_each_online_cpu(cpu) {
> +                       sfw =3D &per_cpu(slub_flush, cpu);
> +                       if (sfw->skip)
> +                               continue;
> +                       flush_work(&sfw->work);

I'm sure I'm missing something but why can't we execute call_rcu()
from here instead of queuing the work which does call_rcu() and then
flushing all the queued work? I'm sure you have a good reason which
I'm missing.

> +               }
> +
> +               mutex_unlock(&flush_lock);
> +       }
> +
> +       mutex_unlock(&slab_mutex);
> +       cpus_read_unlock();
> +
> +       rcu_barrier();
> +}
> +
>  /*
>   * Use the cpu notifier to insure that the cpu slabs are flushed when
>   * necessary.
> @@ -5413,6 +5539,134 @@ bool free_to_pcs(struct kmem_cache *s, void *obje=
ct)
>         return true;
>  }
>
> +static void rcu_free_sheaf(struct rcu_head *head)
> +{
> +       struct slab_sheaf *sheaf;
> +       struct node_barn *barn;
> +       struct kmem_cache *s;
> +
> +       sheaf =3D container_of(head, struct slab_sheaf, rcu_head);
> +
> +       s =3D sheaf->cache;
> +
> +       /*
> +        * This may remove some objects due to slab_free_hook() returning=
 false,
> +        * so that the sheaf might no longer be completely full. But it's=
 easier
> +        * to handle it as full (unless it became completely empty), as t=
he code
> +        * handles it fine. The only downside is that sheaf will serve fe=
wer
> +        * allocations when reused. It only happens due to debugging, whi=
ch is a
> +        * performance hit anyway.
> +        */
> +       __rcu_free_sheaf_prepare(s, sheaf);
> +
> +       barn =3D get_node(s, numa_mem_id())->barn;
> +
> +       /* due to slab_free_hook() */
> +       if (unlikely(sheaf->size =3D=3D 0))
> +               goto empty;
> +
> +       /*
> +        * Checking nr_full/nr_empty outside lock avoids contention in ca=
se the
> +        * barn is at the respective limit. Due to the race we might go o=
ver the
> +        * limit but that should be rare and harmless.
> +        */
> +
> +       if (data_race(barn->nr_full) < MAX_FULL_SHEAVES) {
> +               stat(s, BARN_PUT);
> +               barn_put_full_sheaf(barn, sheaf);
> +               return;
> +       }
> +
> +       stat(s, BARN_PUT_FAIL);
> +       sheaf_flush_unused(s, sheaf);
> +
> +empty:
> +       if (data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
> +               barn_put_empty_sheaf(barn, sheaf);
> +               return;
> +       }
> +
> +       free_empty_sheaf(s, sheaf);
> +}
> +
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *rcu_sheaf;
> +
> +       if (!local_trylock(&s->cpu_sheaves->lock))
> +               goto fail;
> +
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (unlikely(!pcs->rcu_free)) {
> +
> +               struct slab_sheaf *empty;
> +               struct node_barn *barn;
> +
> +               if (pcs->spare && pcs->spare->size =3D=3D 0) {
> +                       pcs->rcu_free =3D pcs->spare;
> +                       pcs->spare =3D NULL;
> +                       goto do_free;
> +               }
> +
> +               barn =3D get_barn(s);
> +
> +               empty =3D barn_get_empty_sheaf(barn);
> +
> +               if (empty) {
> +                       pcs->rcu_free =3D empty;
> +                       goto do_free;
> +               }
> +
> +               local_unlock(&s->cpu_sheaves->lock);
> +
> +               empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> +
> +               if (!empty)
> +                       goto fail;
> +
> +               if (!local_trylock(&s->cpu_sheaves->lock)) {
> +                       barn_put_empty_sheaf(barn, empty);
> +                       goto fail;
> +               }
> +
> +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +               if (unlikely(pcs->rcu_free))
> +                       barn_put_empty_sheaf(barn, empty);
> +               else
> +                       pcs->rcu_free =3D empty;
> +       }
> +
> +do_free:
> +
> +       rcu_sheaf =3D pcs->rcu_free;
> +
> +       rcu_sheaf->objects[rcu_sheaf->size++] =3D obj;

nit: The above would result in OOB write if we ever reached here with
a full rcu_sheaf (rcu_sheaf->size =3D=3D rcu_sheaf->sheaf_capacity) but I
think it's impossible. You always start with an empty rcu_sheaf and
objects are added only here with a following check for a full
rcu_sheaf. I think a short comment clarifying that would be nice.

> +
> +       if (likely(rcu_sheaf->size < s->sheaf_capacity))
> +               rcu_sheaf =3D NULL;
> +       else
> +               pcs->rcu_free =3D NULL;
> +
> +       /*
> +        * we flush before local_unlock to make sure a racing
> +        * flush_all_rcu_sheaves() doesn't miss this sheaf
> +        */
> +       if (rcu_sheaf)
> +               call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +
> +       local_unlock(&s->cpu_sheaves->lock);
> +
> +       stat(s, FREE_RCU_SHEAF);
> +       return true;
> +
> +fail:
> +       stat(s, FREE_RCU_SHEAF_FAIL);
> +       return false;
> +}
> +
>  /*
>   * Bulk free objects to the percpu sheaves.
>   * Unlike free_to_pcs() this includes the calls to all necessary hooks
> @@ -6909,6 +7163,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>         struct kmem_cache_node *n;
>
>         flush_all_cpus_locked(s);
> +
> +       /* we might have rcu sheaves in flight */
> +       if (s->cpu_sheaves)
> +               rcu_barrier();
> +
>         /* Attempt to free all objects */
>         for_each_kmem_cache_node(s, node, n) {
>                 if (n->barn)
> @@ -8284,6 +8543,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
>  STAT_ATTR(FREE_PCS, free_cpu_sheaf);
> +STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
> +STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>  STAT_ATTR(FREE_FROZEN, free_frozen);
> @@ -8382,6 +8643,8 @@ static struct attribute *slab_attrs[] =3D {
>         &alloc_fastpath_attr.attr,
>         &alloc_slowpath_attr.attr,
>         &free_cpu_sheaf_attr.attr,
> +       &free_rcu_sheaf_attr.attr,
> +       &free_rcu_sheaf_fail_attr.attr,
>         &free_fastpath_attr.attr,
>         &free_slowpath_attr.attr,
>         &free_frozen_attr.attr,
> --
> 2.51.0
>
>
