Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00930CD91
	for <rcu@vger.kernel.org>; Wed, 27 Aug 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260242; cv=none; b=dqJaxH9YT1d3rZbfRTlZLKFllasp9yFUMpY32Z/+DkNdOl64SxM+RFHCvO9nx8HK6ZXDaMFF2oV3DWntjMdnCtcLp3nR+YLwJC3XhGiaMKiFfN1oSF5gFQ5qP/MCZb8kOOQGL8/ImFmc5mathXFnQIWHtgzjLK7ASQABFgWEXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260242; c=relaxed/simple;
	bh=GphFMthgSDDmbSJxopXevPsEECgUp1EXbWynI/nyV9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aR4t6iGa3g/56m3443Zeit1N89z00DIo6kjliYgFkSzdYz4vMptY0hPpiNi9vz8zAEMfMGnCO31TragVde5gh/GeZEKieGi9lgAWq5IbaXtwuev+o/ofZSmRNzgAWNITFV9Y7E63lvDIOpoj6yEbD++wVyl6mBIQi+SDp+zL4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aiUEpYj0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiUEpYj0"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b29b714f8cso128431cf.1
        for <rcu@vger.kernel.org>; Tue, 26 Aug 2025 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756260238; x=1756865038; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEVxPCA6kJd9PIc8bhpPohKEpWmPNTYIVsnrA96TQzY=;
        b=aiUEpYj0XH00pwh10rhv65EDM9i0lQjgZW7XHKFP9hEELoKcjCy7+XkQVqodX4LwhM
         X51NSb+84AsddNG8NXH3cL8x2f5hdM7FJJTRCxAkW8xs08w0ub9abbuCyUWv9/NafbY8
         u0pKOTZm134elF7mdjNcQ5dsZRLxIAAm/qaYUibsdJXWPQ7tZ/xZI8ZK8D4ygpa24Fzs
         CQYM5/dU3zu9FH8+aMOD8VoVpF3RYgGTmRbUbsUF2PMGmdJYOSP/rPrq7upSlsKo3S1y
         nD3Frea/8NKynxXcdqXfh1VNkkbLHN9GNg74d+UlvAkMOgQBdUIowF1i7DYPIo2J7zx3
         m5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756260238; x=1756865038;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEVxPCA6kJd9PIc8bhpPohKEpWmPNTYIVsnrA96TQzY=;
        b=Jj0ixnpKLSMWR94oNlQKkkAAFFyGGfXxHxlTUjlkyCDlNmTy3G3NeEGdIbaIIvKgV/
         O9+1VBAcqkXbFqLIE2lMn0UD9187Xo8GPctiy1H9CFJSUcS5bHlPS+mxhUuvNpfgjKAB
         p7XFvSx97RiDYpSotE0bQ9AzhDz4TR3z790e/AkfinF9XFFEc6OvRTArPLzarjiySCSz
         FMrG+edvdC44QWweV12aY12I8XLVixEN2BlCOxMsvVE8tS6+AI3Hr5RpdFOPIQxC4XwH
         83mdjI8HraZ96Wsgfq16fQjjl9/KzQYPrhnZg36q7auHjAfedeaG7pTIkgXwMF2ZJP91
         lb7g==
X-Forwarded-Encrypted: i=1; AJvYcCXCcyDgu6+BKa9hf0EAnf8a+wTC0Xed8r41WysuVXDfiSg+tmMAL8Sc2BsBtfmaxnIjDVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzWubmXosKxF2WZ0oCmegLDkmU28lYo02sLIpvYmmAXGhnamb
	3vYbjB7+eY82tuWyeyuP4SQQfPafLnZ95a9L9DcNQZV0ey5KeOmiE8dtA10MeL97m4gCAyT/WZK
	GJGKyJvqzkMAKGroSMkqW029ITXcIeqzW0V8s8nq+e3O8ILC5trI7E81j
X-Gm-Gg: ASbGncvUVik8bGlnGqGktgE8THvdwnGGcUbWMfdQ0TN+qjZwKHXnY3zH/BdaEaXdsGx
	Vs4fTsAGjU1f1Iz8Qhs7BEMREcm2Sz2pBnjUbgTTnQQNI1om7Pub/pzhyd4pNCB3tMonLsQvy0/
	bn0SLaZoxHM6sKX90yxbi81/bXLRp/GWlF4M9bEiUf+HrZ2lkyNf/8/Jm4kRsD/tXq+vOX93+lb
	aOZJIMLbYERHXA2qfeNwNw=
X-Google-Smtp-Source: AGHT+IGHtlhh0VeckNbHAmlQ5S3gzzBpECXGOQvdXGjlOYoxZxhVip/09NFraMdVHLQbgCey4/aMUVeZBI1/PDbyvZQ=
X-Received: by 2002:a05:622a:4a0c:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4b2eac6a173mr5480691cf.15.1756260238092; Tue, 26 Aug 2025
 19:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-13-b792cd830f5d@suse.cz> <CAJuCfpEjaw+4Ay-Yx=unHev+M4M9FmNmz_PSYmtsFn3EToLBxg@mail.gmail.com>
 <6rvzsp6i6p6kc63acbg7hmqlsfx5htvyg5rax3llrauwwyzg4e@f436k2inorfe>
In-Reply-To: <6rvzsp6i6p6kc63acbg7hmqlsfx5htvyg5rax3llrauwwyzg4e@f436k2inorfe>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Aug 2025 19:03:46 -0700
X-Gm-Features: Ac12FXzSeNiZvXDErfLgt2l37tNkMytOYphilgAYuXMgRYjKC_nzXLjq5XayMtI
Message-ID: <CAJuCfpGPP_fR2KvcmHxFbUkZY8p4GQOt2X-bU+PY7nUeRg489w@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] maple_tree: Add single node allocation support
 to maple state
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:11=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [250822 16:25]:
> > On Wed, Jul 23, 2025 at 6:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >
> > > The fast path through a write will require replacing a single node in
> > > the tree.  Using a sheaf (32 nodes) is too heavy for the fast path, s=
o
> > > special case the node store operation by just allocating one node in =
the
> > > maple state.
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  include/linux/maple_tree.h |  4 +++-
> > >  lib/maple_tree.c           | 47 ++++++++++++++++++++++++++++++++++++=
++++------
> > >  2 files changed, 44 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > > index 3cf1ae9dde7ce43fa20ae400c01fefad048c302e..61eb5e7d09ad0133978e3=
ac4b2af66710421e769 100644
> > > --- a/include/linux/maple_tree.h
> > > +++ b/include/linux/maple_tree.h
> > > @@ -443,6 +443,7 @@ struct ma_state {
> > >         unsigned long min;              /* The minimum index of this =
node - implied pivot min */
> > >         unsigned long max;              /* The maximum index of this =
node - implied pivot max */
> > >         struct slab_sheaf *sheaf;       /* Allocated nodes for this o=
peration */
> > > +       struct maple_node *alloc;       /* allocated nodes */
> > >         unsigned long node_request;
> > >         enum maple_status status;       /* The status of the state (a=
ctive, start, none, etc) */
> > >         unsigned char depth;            /* depth of tree descent duri=
ng write */
> > > @@ -491,8 +492,9 @@ struct ma_wr_state {
> > >                 .status =3D ma_start,                                =
     \
> > >                 .min =3D 0,                                          =
     \
> > >                 .max =3D ULONG_MAX,                                  =
     \
> > > -               .node_request=3D 0,                                  =
     \
> > >                 .sheaf =3D NULL,                                     =
     \
> > > +               .alloc =3D NULL,                                     =
     \
> > > +               .node_request=3D 0,                                  =
     \
> > >                 .mas_flags =3D 0,                                    =
     \
> > >                 .store_type =3D wr_invalid,                          =
     \
> > >         }
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index 3c3c14a76d98ded3b619c178d64099b464a2ca23..9aa782b1497f224e7366e=
bbd65f997523ee0c8ab 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -1101,16 +1101,23 @@ static int mas_ascend(struct ma_state *mas)
> > >   *
> > >   * Return: A pointer to a maple node.
> > >   */
> > > -static inline struct maple_node *mas_pop_node(struct ma_state *mas)
> > > +static __always_inline struct maple_node *mas_pop_node(struct ma_sta=
te *mas)
> > >  {
> > >         struct maple_node *ret;
> > >
> > > +       if (mas->alloc) {
> > > +               ret =3D mas->alloc;
> > > +               mas->alloc =3D NULL;
> > > +               goto out;
> > > +       }
> > > +
> > >         if (WARN_ON_ONCE(!mas->sheaf))
> > >                 return NULL;
> > >
> > >         ret =3D kmem_cache_alloc_from_sheaf(maple_node_cache, GFP_NOW=
AIT, mas->sheaf);
> > > -       memset(ret, 0, sizeof(*ret));
> > >
> > > +out:
> > > +       memset(ret, 0, sizeof(*ret));
> > >         return ret;
> > >  }
> > >
> > > @@ -1121,9 +1128,34 @@ static inline struct maple_node *mas_pop_node(=
struct ma_state *mas)
> > >   */
> > >  static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
> > >  {
> > > -       if (unlikely(mas->sheaf)) {
> > > -               unsigned long refill =3D mas->node_request;
> > > +       if (!mas->node_request)
> > > +               return;
> > > +
> > > +       if (mas->node_request =3D=3D 1) {
> > > +               if (mas->sheaf)
> > > +                       goto use_sheaf;
> > > +
> > > +               if (mas->alloc)
> > > +                       return;
> > >
> > > +               mas->alloc =3D mt_alloc_one(gfp);
> > > +               if (!mas->alloc)
> > > +                       goto error;
> > > +
> > > +               mas->node_request =3D 0;
> > > +               return;
> > > +       }
> > > +
> > > +use_sheaf:
> > > +       if (unlikely(mas->alloc)) {
> >
> > When would this condition happen?
>
>
> This would be the case if we have one node allocated and requested more
> than one node.  That is, a chained request for nodes that ends up having
> the alloc set and requesting a sheaf.

Ah, ok. So this is also a recovery case when we thought we need only
one node and then the situation changed and we need more than one?

>
> > Do we really need to free mas->alloc
> > here or it can be reused for the next 1-node allocation?
>
> Most calls end in mas_destroy() so that won't happen today.
>
> We could reduce the number of allocations requested to the sheaf and let
> the code find the mas->alloc first and use that.
>
> But remember, we are getting into this situation where code did a
> mas_preallocate() then figured they needed to do something else (error
> recovery, or changed the vma flags and now it can merge..) and will now
> need additional nodes.  So this is a rare case, so I figured just free
> it was the safest thing.

Ok, got it. Both situations would be part of the unusual recovery
case. Makes sense then. Thanks!


>
>
> > > +               mt_free_one(mas->alloc);
> > > +               mas->alloc =3D NULL;
> > > +       }
> > > +
> > > +       if (mas->sheaf) {
> > > +               unsigned long refill;
> > > +
> > > +               refill =3D mas->node_request;
> > >                 if(kmem_cache_sheaf_size(mas->sheaf) >=3D refill) {
> > >                         mas->node_request =3D 0;
> > >                         return;
> > > @@ -5386,8 +5418,11 @@ void mas_destroy(struct ma_state *mas)
> > >         mas->node_request =3D 0;
> > >         if (mas->sheaf)
> > >                 mt_return_sheaf(mas->sheaf);
> > > -
> > >         mas->sheaf =3D NULL;
> > > +
> > > +       if (mas->alloc)
> > > +               mt_free_one(mas->alloc);
> > > +       mas->alloc =3D NULL;
> > >  }
> > >  EXPORT_SYMBOL_GPL(mas_destroy);
> > >
> > > @@ -6074,7 +6109,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
> > >                 mas_alloc_nodes(mas, gfp);
> > >         }
> > >
> > > -       if (!mas->sheaf)
> > > +       if (!mas->sheaf && !mas->alloc)
> > >                 return false;
> > >
> > >         mas->status =3D ma_start;
> > >
> > > --
> > > 2.50.1
> > >
