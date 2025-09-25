Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077A26E6E1
	for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807532; cv=none; b=cON9/ixdwE4bMURiq0DOwJTdtztO4Q82P/bJGmXYhZRaCq086tQhAz3y227jGyBUfWBpax/S1osV5WbsmzaW3/mP+5QlwJ6mNcDJRkk5Z1MDQeFSczlPUxKHwueD3UiZSOlFQ40vK4yy+Gb7ARU0SOp7iqMQA9tG0jFKgTqergw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807532; c=relaxed/simple;
	bh=csJRT5xunesRdwJxhIB4Di7/2fMyxj2pWonicuMRLgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwhVLMaK2SKlm8PXn7g0tXaGnuG+M0pAajCvF0pMjvtc5fcQ2RmkzSg8qveRtCdcfAo1zdCDQz0wG9+DuRBz4UYyDzSSVqi8RGutUzbfSjI8YsEVht24uuG8JI2t8AuIQSy3w8NVc1+F2yjn6jXuwL9/6kogWHl9ZZszVACizl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2I0vBmO; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2I0vBmO"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b78657a35aso1194191cf.0
        for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758807530; x=1759412330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zdfa0TYqPEtG9KFxyYyvCSe3whEmUvkm9OuNg2EF/Q=;
        b=f2I0vBmODLm0kT91X81wzQ0rT7bAyyy90I0oEPF7YaZSl1f2b9SwusUKv38QYNWX9d
         EgJ1gtL6Vnp8WK/moALp4XHMm8JESQztBX2khZsDb4YL/W+Vr5bKgOvzMVcjy1cntYsP
         O1VX3d9ctYaaVSUvV/MAxP8qgcEkhsFSx7iQqN/NinRJjy+Upo0zECkNf+aQcTFk8QmH
         ASBgF0S3cOy+D1JgQhd+fF2L9tIo+8+RK11fZvp6vzF3nyVOo/rjf1f+DSGgySip4uqk
         KfdB8oDnNCIi9H9P1ju3ex3S0feVYyankskeqQTSS9M7WXiWPYSN/NDPxsaBAUslEbE5
         7b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807530; x=1759412330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zdfa0TYqPEtG9KFxyYyvCSe3whEmUvkm9OuNg2EF/Q=;
        b=IOSicE41nyPy39N7jAMzx6cVo0gfUbTX4dF+OGqH18dq6oFGqi+gORF6A0TOzO5mYZ
         dDmXdCB/jVB3S2uyBd8UEl4S5DrJ1+dHToJbWEHn7ilazVxjG7JSLMZe1sZ0Ou5w1Mgp
         /WjnLsM53vmXbpX9DO3epFGO2Gluu5XB+bsN9Ke1ww2evXTQ8FRZuJ220APNh0QL8sZq
         mx3LPhzdSJZv/trmYUY7d6HSLKGU7ANq1KVyW3DvqGVsJ3KamgWS0JQvz7cuR3uICjER
         Dh/7lXctVtgHyuJGZzM5hv7ZpT0GLMOKfn0KOrwffpQ7/XqniBeBqV60YX73O7EZZaYP
         vv+g==
X-Forwarded-Encrypted: i=1; AJvYcCXhQ5jUrFMeqXe2GY08YG0N5Cxlk7bkttvn5xSV10uCYTnM4H7tXm5Wwwogd5rC8MIVuIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsYraG/iOZh+J7M1Z3oWVZVXJvpPM1waLk/e+KjgH052xRI55G
	58Tq2XcxAi/vf0LWvRpn9sllS7ZmfIBG3u9qLmwTz7zdUKli04Sy9+YJRw8eX4uHmdqbY01rBJf
	xFs5lS5gpUh+HZbyM3BC56BoEjG+fxBVhK77J+Wfa
X-Gm-Gg: ASbGncuOZofKY3VmZWYhsuVXqizXDoEmG2RlCZvURHVShvBhmGoS6j3Hu/2B8tF2VAo
	5e+k9lvJm4/J1IZSoKtQJL8f+elhLMwSJWh5Irmf8GP2NqOawtOQmPIDFyRDyiG6ANDK9ikmZdC
	xwIQyhQuJgMlBCrRZ6KYV8BA2o1gzBkdobBfgvSs0VUenBTVlKWIkqoX3sNmCtXewMqzXIQ6J+K
	q2NJC8GQTsL
X-Google-Smtp-Source: AGHT+IEgTKlFsxeZ6dECfIA8vaYS9lbWVQA8rwJ3bK+8a8wFRVfZ3eyxhkv/iJk2SxzK25JGLvnA23eNuxNHoASLYoE=
X-Received: by 2002:ac8:5ac4:0:b0:4b3:19b2:d22 with SMTP id
 d75a77b69052e-4da2e581313mr7284511cf.13.1758807529088; Thu, 25 Sep 2025
 06:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMpxnACqmsQl-lp0@hyeyoo> <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>
 <aMqcXyKRlZggLxu_@hyeyoo> <6f92eca3-863e-4b77-b2df-dc2752c0ff4e@suse.cz>
 <aMqyn6nenR8V_p1y@hyeyoo> <bf8b4741-1025-4cc8-b9ed-5b566bdcb2d7@suse.cz>
 <aMq40h5iOjj8K7cc@hyeyoo> <a32bd837-2597-43d0-9da3-1ce5a53b15f4@suse.cz>
 <40461105-a344-444f-834b-9559b6644710@suse.cz> <CAJuCfpG6CSm2iZ3jrwLQA4vVbTMvC=B37q10OL+wLzm-DSRhFw@mail.gmail.com>
 <aNUCuvUh5Ugdnyxr@hyeyoo>
In-Reply-To: <aNUCuvUh5Ugdnyxr@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Sep 2025 06:38:36 -0700
X-Gm-Features: AS18NWA102fuUtgXI8FPHz-QxY1spX_4bosczi6wDVyCIxfHncVuKfAyhq5adzc
Message-ID: <CAJuCfpFG0wzY24xyXBjdRsHK3zxbVskU3raoQXF9k-gfnZEntQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu() operations
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:52=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Wed, Sep 24, 2025 at 09:35:05PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Sep 18, 2025 at 1:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > On 9/17/25 16:14, Vlastimil Babka wrote:
> > > > On 9/17/25 15:34, Harry Yoo wrote:
> > > >> On Wed, Sep 17, 2025 at 03:21:31PM +0200, Vlastimil Babka wrote:
> > > >>> On 9/17/25 15:07, Harry Yoo wrote:
> > > >>> > On Wed, Sep 17, 2025 at 02:05:49PM +0200, Vlastimil Babka wrote=
:
> > > >>> >> On 9/17/25 13:32, Harry Yoo wrote:
> > > >>> >> > On Wed, Sep 17, 2025 at 11:55:10AM +0200, Vlastimil Babka wr=
ote:
> > > >>> >> >> On 9/17/25 10:30, Harry Yoo wrote:
> > > >>> >> >> > On Wed, Sep 10, 2025 at 10:01:06AM +0200, Vlastimil Babka=
 wrote:
> > > >>> >> >> >> +                          sfw->skip =3D true;
> > > >>> >> >> >> +                          continue;
> > > >>> >> >> >> +                  }
> > > >>> >> >> >>
> > > >>> >> >> >> +                  INIT_WORK(&sfw->work, flush_rcu_sheaf=
);
> > > >>> >> >> >> +                  sfw->skip =3D false;
> > > >>> >> >> >> +                  sfw->s =3D s;
> > > >>> >> >> >> +                  queue_work_on(cpu, flushwq, &sfw->wor=
k);
> > > >>> >> >> >> +                  flushed =3D true;
> > > >>> >> >> >> +          }
> > > >>> >> >> >> +
> > > >>> >> >> >> +          for_each_online_cpu(cpu) {
> > > >>> >> >> >> +                  sfw =3D &per_cpu(slub_flush, cpu);
> > > >>> >> >> >> +                  if (sfw->skip)
> > > >>> >> >> >> +                          continue;
> > > >>> >> >> >> +                  flush_work(&sfw->work);
> > > >>> >> >> >> +          }
> > > >>> >> >> >> +
> > > >>> >> >> >> +          mutex_unlock(&flush_lock);
> > > >>> >> >> >> +  }
> > > >>> >> >> >> +
> > > >>> >> >> >> +  mutex_unlock(&slab_mutex);
> > > >>> >> >> >> +  cpus_read_unlock();
> > > >>> >> >> >> +
> > > >>> >> >> >> +  if (flushed)
> > > >>> >> >> >> +          rcu_barrier();
> > > >>> >> >> >
> > > >>> >> >> > I think we need to call rcu_barrier() even if flushed =3D=
=3D false?
> > > >>> >> >> >
> > > >>> >> >> > Maybe a kvfree_rcu()'d object was already waiting for the=
 rcu callback to
> > > >>> >> >> > be processed before flush_all_rcu_sheaves() is called, an=
d
> > > >>> >> >> > in flush_all_rcu_sheaves() we skipped all (cache, cpu) pa=
irs,
> > > >>> >> >> > so flushed =3D=3D false but the rcu callback isn't proces=
sed yet
> > > >>> >> >> > by the end of the function?
> > > >>> >> >> >
> > > >>> >> >> > That sounds like a very unlikely to happen in a realistic=
 scenario,
> > > >>> >> >> > but still possible...
> > > >>> >> >>
> > > >>> >> >> Yes also good point, will flush unconditionally.
> > > >>> >> >>
> > > >>> >> >> Maybe in __kfree_rcu_sheaf() I should also move the call_rc=
u(...) before
> > > >>> >> >> local_unlock().
> > > >>> >> >>
> > > >>> >> >> So we don't end up seeing a NULL pcs->rcu_free in
> > > >>> >> >> flush_all_rcu_sheaves() because __kfree_rcu_sheaf() already=
 set it to NULL,
> > > >>> >> >> but didn't yet do the call_rcu() as it got preempted after =
local_unlock().
> > > >>> >> >
> > > >>> >> > Makes sense to me.
> > > >>> >
> > > >>> > Wait, I'm confused.
> > > >>> >
> > > >>> > I think the caller of kvfree_rcu_barrier() should make sure tha=
t it's invoked
> > > >>> > only after a kvfree_rcu(X, rhs) call has returned, if the calle=
r expects
> > > >>> > the object X to be freed before kvfree_rcu_barrier() returns?
> > > >>>
> > > >>> Hmm, the caller of kvfree_rcu(X, rhs) might have returned without=
 filling up
> > > >>> the rcu_sheaf fully and thus without submitting it to call_rcu(),=
 then
> > > >>> migrated to another cpu. Then it calls kvfree_rcu_barrier() while=
 another
> > > >>> unrelated kvfree_rcu(X, rhs) call on the previous cpu is for the =
same
> > > >>> kmem_cache (kvfree_rcu_barrier() is not only for cache destructio=
n), fills
> > > >>> up the rcu_sheaf fully and is about to call_rcu() on it. And sinc=
e that
> > > >>> sheaf also contains the object X, we should make sure that is flu=
shed.
> > > >>
> > > >> I was going to say "but we queue and wait for the flushing work to
> > > >> complete, so the sheaf containing object X should be flushed?"
> > > >>
> > > >> But nah, that's true only if we see pcs->rcu_free !=3D NULL in
> > > >> flush_all_rcu_sheaves().
> > > >>
> > > >> You are right...
> > > >>
> > > >> Hmm, maybe it's simpler to fix this by never skipping queueing the=
 work
> > > >> even when pcs->rcu_sheaf =3D=3D NULL?
> > > >
> > > > I guess it's simpler, yeah.
> > >
> > > So what about this? The unconditional queueing should cover all races=
 with
> > > __kfree_rcu_sheaf() so there's just unconditional rcu_barrier() in th=
e end.
> > >
> > > From 0722b29fa1625b31c05d659d1d988ec882247b38 Mon Sep 17 00:00:00 200=
1
> > > From: Vlastimil Babka <vbabka@suse.cz>
> > > Date: Wed, 3 Sep 2025 14:59:46 +0200
> > > Subject: [PATCH] slab: add sheaf support for batching kfree_rcu() ope=
rations
> > >
> > > Extend the sheaf infrastructure for more efficient kfree_rcu() handli=
ng.
> > > For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> > > addition to main and spare sheaves.
> > >
> > > kfree_rcu() operations will try to put objects on this sheaf. Once fu=
ll,
> > > the sheaf is detached and submitted to call_rcu() with a handler that
> > > will try to put it in the barn, or flush to slab pages using bulk fre=
e,
> > > when the barn is full. Then a new empty sheaf must be obtained to put
> > > more objects there.
> > >
> > > It's possible that no free sheaves are available to use for a new
> > > rcu_free sheaf, and the allocation in kfree_rcu() context can only us=
e
> > > GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> > > kfree_rcu() implementation.
> > >
> > > Expected advantages:
> > > - batching the kfree_rcu() operations, that could eventually replace =
the
> > >   existing batching
> > > - sheaves can be reused for allocations via barn instead of being
> > >   flushed to slabs, which is more efficient
> > >   - this includes cases where only some cpus are allowed to process r=
cu
> > >     callbacks (Android)
> >
> > nit: I would say it's more CONFIG_RCU_NOCB_CPU related. Android is
> > just an instance of that.
> >
> > >
> > > Possible disadvantage:
> > > - objects might be waiting for more than their grace period (it is
> > >   determined by the last object freed into the sheaf), increasing mem=
ory
> > >   usage - but the existing batching does that too.
> > >
> > > Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> > > implementation favors smaller memory footprint over performance.
> > >
> > > Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as the
> > > contexts where kfree_rcu() is called might not be compatible with tak=
ing
> > > a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
> > > spinlock - the current kfree_rcu() implementation avoids doing that.
> > >
> > > Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all cac=
hes
> > > that have them. This is not a cheap operation, but the barrier usage =
is
> > > rare - currently kmem_cache_destroy() or on module unload.
> > >
> > > Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail=
 to
> > > count how many kfree_rcu() used the rcu_free sheaf successfully and h=
ow
> > > many had to fall back to the existing implementation.
> > >
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  mm/slab.h        |   3 +
> > >  mm/slab_common.c |  26 +++++
> > >  mm/slub.c        | 267 +++++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  3 files changed, 294 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index cba188b7e04d..171273f90efd 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
>
> [...snip...]
>
> > > @@ -3840,6 +3895,77 @@ static void flush_all(struct kmem_cache *s)
> > >         cpus_read_unlock();
> > >  }
> > >
> > > +static void flush_rcu_sheaf(struct work_struct *w)
> > > +{
> > > +       struct slub_percpu_sheaves *pcs;
> > > +       struct slab_sheaf *rcu_free;
> > > +       struct slub_flush_work *sfw;
> > > +       struct kmem_cache *s;
> > > +
> > > +       sfw =3D container_of(w, struct slub_flush_work, work);
> > > +       s =3D sfw->s;
> > > +
> > > +       local_lock(&s->cpu_sheaves->lock);
> > > +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > > +
> > > +       rcu_free =3D pcs->rcu_free;
> > > +       pcs->rcu_free =3D NULL;
> > > +
> > > +       local_unlock(&s->cpu_sheaves->lock);
> > > +
> > > +       if (rcu_free)
> > > +               call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> > > +}
> > > +
> > > +
> > > +/* needed for kvfree_rcu_barrier() */
> > > +void flush_all_rcu_sheaves(void)
> > > +{
> > > +       struct slub_flush_work *sfw;
> > > +       struct kmem_cache *s;
> > > +       unsigned int cpu;
> > > +
> > > +       cpus_read_lock();
> > > +       mutex_lock(&slab_mutex);
> > > +
> > > +       list_for_each_entry(s, &slab_caches, list) {
> > > +               if (!s->cpu_sheaves)
> > > +                       continue;
> > > +
> > > +               mutex_lock(&flush_lock);
> > > +
> > > +               for_each_online_cpu(cpu) {
> > > +                       sfw =3D &per_cpu(slub_flush, cpu);
> > > +
> > > +                       /*
> > > +                        * we don't check if rcu_free sheaf exists - =
racing
> > > +                        * __kfree_rcu_sheaf() might have just remove=
d it.
> > > +                        * by executing flush_rcu_sheaf() on the cpu =
we make
> > > +                        * sure the __kfree_rcu_sheaf() finished its =
call_rcu()
> > > +                        */
> > > +
> > > +                       INIT_WORK(&sfw->work, flush_rcu_sheaf);
> > > +                       sfw->skip =3D false;
> >
> > I think you don't need this sfw->skip flag since you never skip anymore=
, right?
>
> Yes, at least in flush_all_rcu_sheaves().
> I'm fine with or without sfw->skip in this function.
>
> > > +                       sfw->s =3D s;
> > > +                       queue_work_on(cpu, flushwq, &sfw->work);
> > > +               }
> > > +
> > > +               for_each_online_cpu(cpu) {
> > > +                       sfw =3D &per_cpu(slub_flush, cpu);
> > > +                       if (sfw->skip)
> > > +                               continue;
> > > +                       flush_work(&sfw->work);
> >
> > I'm sure I'm missing something but why can't we execute call_rcu()
> > from here instead of queuing the work which does call_rcu() and then
> > flushing all the queued work? I'm sure you have a good reason which
> > I'm missing.
>
> Because a local lock cannot be held by other CPUs, you can't take off the
> rcu_free sheaf remotely and call call_rcu(). That's why the work is
> queued on each CPU, ensuring the rcu_free sheaf is flushed by its local C=
PU.

Ah, yes, of course. I knew it was something obvious but my brain was
too tired. Thanks for the explanation, Harry!

>
> > > +               }
> > > +
> > > +               mutex_unlock(&flush_lock);
> > > +       }
> > > +
> > > +       mutex_unlock(&slab_mutex);
> > > +       cpus_read_unlock();
> > > +
> > > +       rcu_barrier();
> > > +}
> > > +
> > >  /*
> > >   * Use the cpu notifier to insure that the cpu slabs are flushed whe=
n
> > >   * necessary.
> > > +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> > > +{
> > > +       struct slub_percpu_sheaves *pcs;
> > > +       struct slab_sheaf *rcu_sheaf;
> > > +
> > > +       if (!local_trylock(&s->cpu_sheaves->lock))
> > > +               goto fail;
> > > +
> > > +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > > +
> > > +       if (unlikely(!pcs->rcu_free)) {
> > > +
> > > +               struct slab_sheaf *empty;
> > > +               struct node_barn *barn;
> > > +
> > > +               if (pcs->spare && pcs->spare->size =3D=3D 0) {
> > > +                       pcs->rcu_free =3D pcs->spare;
> > > +                       pcs->spare =3D NULL;
> > > +                       goto do_free;
> > > +               }
> > > +
> > > +               barn =3D get_barn(s);
> > > +
> > > +               empty =3D barn_get_empty_sheaf(barn);
> > > +
> > > +               if (empty) {
> > > +                       pcs->rcu_free =3D empty;
> > > +                       goto do_free;
> > > +               }
> > > +
> > > +               local_unlock(&s->cpu_sheaves->lock);
> > > +
> > > +               empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> > > +
> > > +               if (!empty)
> > > +                       goto fail;
> > > +
> > > +               if (!local_trylock(&s->cpu_sheaves->lock)) {
> > > +                       barn_put_empty_sheaf(barn, empty);
> > > +                       goto fail;
> > > +               }
> > > +
> > > +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> > > +
> > > +               if (unlikely(pcs->rcu_free))
> > > +                       barn_put_empty_sheaf(barn, empty);
> > > +               else
> > > +                       pcs->rcu_free =3D empty;
> > > +       }
> > > +
> > > +do_free:
> > > +
> > > +       rcu_sheaf =3D pcs->rcu_free;
> > > +
> > > +       rcu_sheaf->objects[rcu_sheaf->size++] =3D obj;
> >
> > nit: The above would result in OOB write if we ever reached here with
> > a full rcu_sheaf (rcu_sheaf->size =3D=3D rcu_sheaf->sheaf_capacity) but=
 I
> > think it's impossible. You always start with an empty rcu_sheaf and
> > objects are added only here with a following check for a full
> > rcu_sheaf. I think a short comment clarifying that would be nice.
>
> Sounds good to me.
>
> --
> Cheers,
> Harry / Hyeonggon
>
> > > +
> > > +       if (likely(rcu_sheaf->size < s->sheaf_capacity))
> > > +               rcu_sheaf =3D NULL;
> > > +       else
> > > +               pcs->rcu_free =3D NULL;
> > > +
> > > +       /*
> > > +        * we flush before local_unlock to make sure a racing
> > > +        * flush_all_rcu_sheaves() doesn't miss this sheaf
> > > +        */
> > > +       if (rcu_sheaf)
> > > +               call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> > > +
> > > +       local_unlock(&s->cpu_sheaves->lock);
> > > +
> > > +       stat(s, FREE_RCU_SHEAF);
> > > +       return true;
> > > +
> > > +fail:
> > > +       stat(s, FREE_RCU_SHEAF_FAIL);
> > > +       return false;
> > > +}
