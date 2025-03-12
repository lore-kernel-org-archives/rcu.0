Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC817E00E
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792476; cv=none; b=Sk9NqJJT9I2EwgHtTkvS1TMaQPkq1dR2MJKpo2Ms6mzUxHVxFXIAgExmcQoHPRZLJl3hwv2vh9gm2OzzmzFygRB50s8ETUJK8MKsteAY/iZLXjKe9TDz/PAUUeOiqI1/6Jx4n9y7MVnMHZjYbbrex0RWOFCO2KsXqPkbY+f50ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792476; c=relaxed/simple;
	bh=kwP0mU/SszyQ//fIwQoS5QRpev949gdd9T9dbs/S+gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6o44Hn1hjdfjylyFLY2Y3wdEwFtzVRTDBr1mG42vLOJQt+tSb8MEMXeDjF1KjkJYGu/zoUY9PWPwWiHau0HkS75N5ajVo9sXg+GXK4PNmMIGJhK7w6IlgUECaMSE0jQz+JJuhAY0QJqBX1vaaCHHXltjBtHZ0yguk/MkYKpKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6HqVkgD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6HqVkgD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfe808908so55385e9.0
        for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741792472; x=1742397272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n0X3g/8kvM/frR1vvwpQrEhKVq5chumc3tFrZ1kLVc=;
        b=O6HqVkgDUMolpErFtDDNRbsWdujqsJ0WQDLDv2zl+wk4pHLmqgkZIORAWhvrn+Fi9v
         JReF3zIL0XNq8uWsULZXAlCUkLWVrkUB/Xl/gadudQHeyZtl55zhR9EULaRZKJf1dixh
         lgOB0Xyv/7Wzohkd3cgQudNRWqDNJFaXx9cWRELSASJJcLktaek7WeyiAfodKK3WxY31
         dnZWNTna6dElaIvz/6yAF46uDvIl7ni6y4lz3aukNOgYTvWyYHJc1k+RepkxdAUyjqym
         orN46xr+Go5DOBoObu9IyXEMMfoUzpziTAq6juY7RRruQDL7g5GRxJSJmSYJrV+1SKAl
         A8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792472; x=1742397272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5n0X3g/8kvM/frR1vvwpQrEhKVq5chumc3tFrZ1kLVc=;
        b=C5iOXfGJ55p/pOJ4Llc93kdf5wwdMyX9i4YhGh7MZ/VzGKbhmWi/bJrDqO048trFVn
         EY14xb9ZjY3Jc4FOhalPL5eEYbY974waO6UcI5RaE/RXGq+yi/WpffNV9Xo4QZ8rPTc1
         OJk8396f+Gp74W+SxQgvHrQMhaDpVZbmcYKMcij/g9p+tFGmwUCjCVsRy4f4388PBlMP
         TfLx0fdPPZzx5dwdEgn4MbMESrVPN7W/atWEbMjaSk32rF2AILVoad50hn9LRR0fAV/B
         Taggo19bBYzwpce7ffmnDN9Tmb+8kJip72o6WeiKUczhqYN1QDpvW2frli37S+MeYlQi
         C7nw==
X-Forwarded-Encrypted: i=1; AJvYcCVeyGnNa0OfsoufcIJqtL3+zLzkEMgSb9iQ/iFfxLCPQE47SMpoI7H0nrQ+vi6tmKZv/S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFM/jM+rtGD+q12PGcIIWoG5jjCGwKyTgWsnsd5uxuYColHhiB
	xZsEh2uSgjHb8JOk9vhYHpkwxB13QaCjgTGHW1QXoIRlch+vnP0H+80fsOxNePVY7vawHxs1StN
	D3SdPQwnocIuRx9t2+GBugX5ibkGZ6RxUzMjL
X-Gm-Gg: ASbGncvfAsKfXc4wz54MkhQ+UhvBk1b45ZaYRnAy81LCwPAocKzK2mlDHxXaIWmrYSv
	96BEBWeq2rkaZP6MEt1DEfsX/DL7Dibse/wxQ7BALMOceSMZMcX+o+DGxG7hRCD6f0hRQ+bvVvi
	8dt4oVcgC+tMdQgby3MD3JmVOtALYNy8jLzGlxki3v7raO0OkhtRh6EpKNBGHpY8qRn6I=
X-Google-Smtp-Source: AGHT+IHp1U+4XQ6KAayZmuULflGUwRrj9KyoD/4FoUuCc/++eqYNJFxSC/LllGFKI6pJJRxWPF4rpOGx18SJkY2MJRg=
X-Received: by 2002:a7b:c389:0:b0:439:9434:1b6c with SMTP id
 5b1f17b1804b1-43d16042527mr47265e9.3.1741792471917; Wed, 12 Mar 2025 08:14:31
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-1-88592ee0966a@suse.cz> <CAJuCfpG4BYNWM24_Jha-SapfeaGdO0GKuteHwNE1hDdWXRS+1Q@mail.gmail.com>
 <befd17b0-160e-4933-96d9-8d5c4a774162@suse.cz>
In-Reply-To: <befd17b0-160e-4933-96d9-8d5c4a774162@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Mar 2025 08:14:19 -0700
X-Gm-Features: AQ5f1JrjeGAOmsUwxBHV2t5RoC_LoxcisTbFL5bf2WIv6un6pR4tCAcjJLzwCH0
Message-ID: <CAJuCfpHwvAUep6YT3Eu2SCu-dDbUoN=WE8r9aEV4UDWKfHXV+g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/10] slab: add opt-in caching layer of percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 7:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/22/25 23:46, Suren Baghdasaryan wrote:
> > On Fri, Feb 14, 2025 at 8:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> Specifying a non-zero value for a new struct kmem_cache_args field
> >> sheaf_capacity will setup a caching layer of percpu arrays called
> >> sheaves of given capacity for the created cache.
> >>
> >> Allocations from the cache will allocate via the percpu sheaves (main =
or
> >> spare) as long as they have no NUMA node preference. Frees will also
> >> refill one of the sheaves.
> >>
> >> When both percpu sheaves are found empty during an allocation, an empt=
y
> >> sheaf may be replaced with a full one from the per-node barn. If none
> >> are available and the allocation is allowed to block, an empty sheaf i=
s
> >> refilled from slab(s) by an internal bulk alloc operation. When both
> >> percpu sheaves are full during freeing, the barn can replace a full on=
e
> >> with an empty one, unless over a full sheaves limit. In that case a
> >> sheaf is flushed to slab(s) by an internal bulk free operation. Flushi=
ng
> >> sheaves and barns is also wired to the existing cpu flushing and cache
> >> shrinking operations.
> >>
> >> The sheaves do not distinguish NUMA locality of the cached objects. If
> >> an allocation is requested with kmem_cache_alloc_node() with a specifi=
c
> >> node (not NUMA_NO_NODE), sheaves are bypassed.
> >>
> >> The bulk operations exposed to slab users also try to utilize the
> >> sheaves as long as the necessary (full or empty) sheaves are available
> >> on the cpu or in the barn. Once depleted, they will fallback to bulk
> >> alloc/free to slabs directly to avoid double copying.
> >>
> >> Sysfs stat counters alloc_cpu_sheaf and free_cpu_sheaf count objects
> >> allocated or freed using the sheaves. Counters sheaf_refill,
> >> sheaf_flush_main and sheaf_flush_other count objects filled or flushed
> >> from or to slab pages, and can be used to assess how effective the
> >> caching is. The refill and flush operations will also count towards th=
e
> >> usual alloc_fastpath/slowpath, free_fastpath/slowpath and other
> >> counters.
> >>
> >> Access to the percpu sheaves is protected by local_lock_irqsave()
> >> operations, each per-NUMA-node barn has a spin_lock.
> >>
> >> A current limitation is that when slub_debug is enabled for a cache wi=
th
> >> percpu sheaves, the objects in the array are considered as allocated f=
rom
> >> the slub_debug perspective, and the alloc/free debugging hooks occur
> >> when moving the objects between the array and slab pages. This means
> >> that e.g. an use-after-free that occurs for an object cached in the
> >> array is undetected. Collected alloc/free stacktraces might also be le=
ss
> >> useful. This limitation could be changed in the future.
> >>
> >> On the other hand, KASAN, kmemcg and other hooks are executed on actua=
l
> >> allocations and frees by kmem_cache users even if those use the array,
> >> so their debugging or accounting accuracy should be unaffected.
> >>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > Only one possible issue in __pcs_flush_all_cpu(), all other comments
> > are nits and suggestions.
>
> Thanks.
>
> >> +        * Limitations: when slub_debug is enabled for the cache, all =
relevant
> >> +        * actions (i.e. poisoning, obtaining stacktraces) and checks =
happen
> >> +        * when objects move between sheaves and slab pages, which may=
 result in
> >> +        * e.g. not detecting a use-after-free while the object is in =
the array
> >> +        * cache, and the stacktraces may be less useful.
> >
> > I would also love to see a short comparison of sheaves (when objects
> > are freed using kfree_rcu()) vs SLAB_TYPESAFE_BY_RCU. I think both
> > mechanisms rcu-free objects in bulk but sheaves would not reuse an
> > object before RCU grace period is passed. Is that right?
>
> I don't think that's right. SLAB_TYPESAFE_BY_RCU doesn't rcu-free objects=
 in
> bulk, the objects are freed immediately. It only rcu-delays freeing the s=
lab
> folio once all objects are freed.

Yes, you are right.

>
> >> +struct slub_percpu_sheaves {
> >> +       local_lock_t lock;
> >> +       struct slab_sheaf *main; /* never NULL when unlocked */
> >> +       struct slab_sheaf *spare; /* empty or full, may be NULL */
> >> +       struct slab_sheaf *rcu_free;
> >
> > Would be nice to have a short comment for rcu_free as well. I could
> > guess what main and spare are but for rcu_free had to look further.
>
> Added.
>
> >> +static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> >> +                                  size_t size, void **p);
> >> +
> >> +
> >> +static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *shea=
f,
> >> +                        gfp_t gfp)
> >> +{
> >> +       int to_fill =3D s->sheaf_capacity - sheaf->size;
> >> +       int filled;
> >> +
> >> +       if (!to_fill)
> >> +               return 0;
> >> +
> >> +       filled =3D __kmem_cache_alloc_bulk(s, gfp, to_fill,
> >> +                                        &sheaf->objects[sheaf->size])=
;
> >> +
> >> +       if (!filled)
> >> +               return -ENOMEM;
> >> +
> >> +       sheaf->size =3D s->sheaf_capacity;
> >
> > nit: __kmem_cache_alloc_bulk() either allocates requested number of
> > objects or returns 0, so the current code is fine but if at some point
> > the implementation changes so that it can return smaller number of
> > objects than requested (filled < to_fill) then the above assignment
> > will become invalid. I think a safer thing here would be to just:
> >
> >        sheaf->size +=3D filled;
> >
> > which also makes logical sense. Alternatively you could add
> > VM_BUG_ON(filled !=3D to_fill) but the increment I think would be
> > better.
>
> It's useful to indicate the refill was not successful, for patch 6. So I'=
m
> changing this to:
>
>         sheaf->size +=3D filled;
>
>         stat_add(s, SHEAF_REFILL, filled);
>
>         if (filled < to_fill)
>                 return -ENOMEM;
>
>         return 0;

That looks good to me.

>
> >> +
> >> +       stat_add(s, SHEAF_REFILL, filled);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +
> >> +static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_=
t gfp)
> >> +{
> >> +       struct slab_sheaf *sheaf =3D alloc_empty_sheaf(s, gfp);
> >> +
> >> +       if (!sheaf)
> >> +               return NULL;
> >> +
> >> +       if (refill_sheaf(s, sheaf, gfp)) {
> >> +               free_empty_sheaf(s, sheaf);
> >> +               return NULL;
> >> +       }
> >> +
> >> +       return sheaf;
> >> +}
> >> +
> >> +/*
> >> + * Maximum number of objects freed during a single flush of main pcs =
sheaf.
> >> + * Translates directly to an on-stack array size.
> >> + */
> >> +#define PCS_BATCH_MAX  32U
> >> +
> > .> +static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t
> > size, void **p);
> >> +
> >
> > A comment clarifying why you are freeing in PCS_BATCH_MAX batches here
> > would be helpful. My understanding is that you do that to free objects
> > outside of the cpu_sheaves->lock, so you isolate a batch, release the
> > lock and then free the batch.
>
> OK.
>
> >> +static void sheaf_flush_main(struct kmem_cache *s)
> >> +{
> >> +       struct slub_percpu_sheaves *pcs;
> >> +       unsigned int batch, remaining;
> >> +       void *objects[PCS_BATCH_MAX];
> >> +       struct slab_sheaf *sheaf;
> >> +       unsigned long flags;
> >> +
> >> +next_batch:
> >> +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> >> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> >> +       sheaf =3D pcs->main;
> >> +
> >> +       batch =3D min(PCS_BATCH_MAX, sheaf->size);
> >> +
> >> +       sheaf->size -=3D batch;
> >> +       memcpy(objects, sheaf->objects + sheaf->size, batch * sizeof(v=
oid *));
> >> +
> >> +       remaining =3D sheaf->size;
> >> +
> >> +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> >> +
> >> +       __kmem_cache_free_bulk(s, batch, &objects[0]);
> >> +
> >> +       stat_add(s, SHEAF_FLUSH_MAIN, batch);
> >> +
> >> +       if (remaining)
> >> +               goto next_batch;
> >> +}
> >> +
> >
> > This function seems to be used against either isolated sheaves or in
> > slub_cpu_dead() --> __pcs_flush_all_cpu() path where we hold
> > slab_mutex and I think that guarantees that the sheaf is unused. Maybe
> > a short comment clarifying this requirement or rename the function to
> > reflect that? Something like flush_unused_sheaf()?
>
> It's not slab_mutex, but the fact slub_cpu_dead() is executed in a hotplu=
g
> phase when the given cpu is already not executing anymore and thus cannot=
 be
> manipulating its percpu sheaves, so we are the only one that does.
> So I will clarify and rename to sheaf_flush_unused().

I see. Thanks for explaining.

>
> >> +
> >> +static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cp=
u)
> >> +{
> >> +       struct slub_percpu_sheaves *pcs;
> >> +
> >> +       pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> >> +
> >> +       if (pcs->spare) {
> >> +               sheaf_flush(s, pcs->spare);
> >> +               free_empty_sheaf(s, pcs->spare);
> >> +               pcs->spare =3D NULL;
> >> +       }
> >> +
> >> +       // TODO: handle rcu_free
> >> +       BUG_ON(pcs->rcu_free);
> >> +
> >> +       sheaf_flush_main(s);
> >
> > Hmm. sheaf_flush_main() always flushes for this_cpu only, so IIUC this
> > call will not necessarily flush the main sheaf for the cpu passed to
> > __pcs_flush_all_cpu().
>
> Thanks, yes I need to call sheaf_flush_unused(pcs->main). It's ok to do
> given my reply above.
>
> >> +/*
> >> + * Free an object to the percpu sheaves.
> >> + * The object is expected to have passed slab_free_hook() already.
> >> + */
> >> +static __fastpath_inline
> >> +void free_to_pcs(struct kmem_cache *s, void *object)
> >> +{
> >> +       struct slub_percpu_sheaves *pcs;
> >> +       unsigned long flags;
> >> +
> >> +restart:
> >> +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> >> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> >> +
> >> +       if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
> >> +
> >> +               struct slab_sheaf *empty;
> >> +
> >> +               if (!pcs->spare) {
> >> +                       empty =3D barn_get_empty_sheaf(pcs->barn);
> >> +                       if (empty) {
> >> +                               pcs->spare =3D pcs->main;
> >> +                               pcs->main =3D empty;
> >> +                               goto do_free;
> >> +                       }
> >> +                       goto alloc_empty;
> >> +               }
> >> +
> >> +               if (pcs->spare->size < s->sheaf_capacity) {
> >> +                       stat(s, SHEAF_SWAP);
> >> +                       swap(pcs->main, pcs->spare);
> >> +                       goto do_free;
> >> +               }
> >> +
> >> +               empty =3D barn_replace_full_sheaf(pcs->barn, pcs->main=
);
> >> +
> >> +               if (!IS_ERR(empty)) {
> >> +                       pcs->main =3D empty;
> >> +                       goto do_free;
> >> +               }
> >> +
> >> +               if (PTR_ERR(empty) =3D=3D -E2BIG) {
> >> +                       /* Since we got here, spare exists and is full=
 */
> >> +                       struct slab_sheaf *to_flush =3D pcs->spare;
> >> +
> >> +                       pcs->spare =3D NULL;
> >> +                       local_unlock_irqrestore(&s->cpu_sheaves->lock,=
 flags);
> >> +
> >> +                       sheaf_flush(s, to_flush);
> >> +                       empty =3D to_flush;
> >> +                       goto got_empty;
> >> +               }
> >> +
> >> +alloc_empty:
> >> +               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> >> +
> >> +               empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> >> +
> >> +               if (!empty) {
> >> +                       sheaf_flush_main(s);
> >> +                       goto restart;
> >> +               }
> >> +
> >> +got_empty:
> >> +               local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> >> +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> >> +
> >> +               /*
> >> +                * if we put any sheaf to barn here, it's because we r=
aced or
> >> +                * have been migrated to a different cpu, which should=
 be rare
> >> +                * enough so just ignore the barn's limits to simplify
> >> +                */
> >> +               if (unlikely(pcs->main->size < s->sheaf_capacity)) {
> >> +                       if (!pcs->spare)
> >> +                               pcs->spare =3D empty;
> >> +                       else
> >> +                               barn_put_empty_sheaf(pcs->barn, empty,=
 true);
> >> +                       goto do_free;
> >> +               }
> >> +
> >> +               if (!pcs->spare) {
> >> +                       pcs->spare =3D pcs->main;
> >> +                       pcs->main =3D empty;
> >> +                       goto do_free;
> >> +               }
> >> +
> >> +               barn_put_full_sheaf(pcs->barn, pcs->main, true);
> >> +               pcs->main =3D empty;
> >
> > I find the program flow in this function quite complex and hard to
> > follow. I think refactoring the above block starting from "pcs =3D
> > this_cpu_ptr(s->cpu_sheaves)" would somewhat simplify it. That
> > eliminates the need for the "got_empty" label and makes the
> > locking/unlocking sequence of s->cpu_sheaves->lock a bit more clear.
>
> I'm a bit lost, refactoring how exactly?

I thought moving the code above into a function above starting from
"pcs =3D this_cpu_ptr(s->cpu_sheaves)" into its own function would
simplify the flow. But as I said, it's a nit. If you try and don't
like that feel free to ignore this suggestion.

>
> >> +       }
> >> +
> >> +do_free:
> >> +       pcs->main->objects[pcs->main->size++] =3D object;
> >> +
> >> +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> >> +
> >> +       stat(s, FREE_PCS);
> >> +}
