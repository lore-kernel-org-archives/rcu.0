Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657372144B5
	for <rcu@vger.kernel.org>; Wed, 22 Jan 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558265; cv=none; b=WjzARQSudKiEJTiHlOTvm4uM/bPRbOQbv39oTvch2u99T1qxvH/AxPNsAyFjO/lO6wfdpGb6a9u8ryJgyk7Qglw/a3LnAOHWIJQVRZhcPMQh6JURS73+37UEL2a0l8tjoZK1CyRuPYz3AMFJDLNEfJAj1XqMOTOTQAUG+Db3v8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558265; c=relaxed/simple;
	bh=CNCLYxwZz9nDFyk3pzg3hIiSsb4pcOM7Z4mOlDXI4Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYhEZO4VMOy445Y/S+dv+RCc0+xEi4pZ3cy2jCg30USYrJYA9uqiVT6+D67uRyI5sbaj/ryUgzIvG5vlAbninptKstYHdi43pY/6Ay1J6j1N0g4ypfA+3NilC4H2ZGDYZTkqDHh4E6tkJac/5+G9ir2HzUdOXNC/FD6Gnc6H8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=D2TY/aiQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="D2TY/aiQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436345cc17bso51021405e9.0
        for <rcu@vger.kernel.org>; Wed, 22 Jan 2025 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737558261; x=1738163061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beq5Dw/Wj94v2uHKhR7RPB2XOGUho+A4hGE+uPW4pNE=;
        b=D2TY/aiQHdBBSLlYRUFnwG/muMEI0xXjIUZ9Z5FMRb32ZjjT1JKOdfI9sLHoVBKNu5
         SARo+/2slvZIGoJtQEIfYA5dn6k7qXKbzFI0RLb+puvTTethmKNRaCemOrLZtJoOWquz
         7zrBlcXlVZgnpOF5kff2NWq+gz1IxXpC6aMZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737558261; x=1738163061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beq5Dw/Wj94v2uHKhR7RPB2XOGUho+A4hGE+uPW4pNE=;
        b=LjNwJDOlqlDQ41EZ7WAt4LEoWGox/ngEbA8Nd5N6Lh4jZcUdjdnjLVDn2PMJ+zul3A
         cvStFQWDe47D0KGyK/vjz4YZAZpG8qdUN+afuvjjzSvGSVIMfuERxKlkRsBrtmPgU1Fm
         3UPlQv0EWIbKKG6RLYwL48t0G2Sb9Ur2/rrvov+ZVdBoIYo78SHduq1dGcxHPbL13h4V
         pfsu/S2KXT+nccGbBVxq26EG64FTLsudQBR4T9pHqSTn2LfXfj1X87j7Cos0S+Th51uh
         Wj1RT/wFbLGbgLbz+3KAhQPotUP2sMk7iNYJE1uBRfMYnPTMCOLOItKiY6/waZrWCb+i
         Dadw==
X-Forwarded-Encrypted: i=1; AJvYcCX2v3qXTMZuzEQF+d+HbSGfYVcFWOTh8vrOc/ETIJYg7sezVsbOxaK9oDe6oRUvBMlbuV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8OhfNyx5NkAspQoBAzlcK7i8Kp99AGvNIyDocNsA/Ceij//l
	pMSAjiDkQdSBkUg/LxucYmp9R0dG+QhJNQwlm1E+YhBQgJys45rN19JVQSvhuewfgnyYJWxE02e
	pENXw56AsN9A/0O+lmJGh1nBJMZLaMvpPxtxW3Q==
X-Gm-Gg: ASbGncuV+/14IMeN7tlWiTm3V5E5R26JO8irHHIYQ1dvl6UeQ3VNB1m60cTAFrS/0wk
	YEOd+527rf99idq5cA60jlrpmIwH0QYgmx7EfC0ysM2jUVot/CyA=
X-Google-Smtp-Source: AGHT+IFqYKI2yTM6/ViaX+n5Ncx78wzlkz5+ir+FuEzBfl0J6daloxJs836ifIXPV53CXeIJv4QLBSpADhXk9JtLJPI=
X-Received: by 2002:a05:600c:510c:b0:434:a1e7:27b0 with SMTP id
 5b1f17b1804b1-438913ccd4amr253225385e9.11.1737558261159; Wed, 22 Jan 2025
 07:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z2AJCI3cIR9ETFFu@pc636> <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>
 <Z2BKLzOGv_Ki_7fj@pc636> <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
 <Z2BNWpkruY6rJv6A@pc636> <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
 <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz> <Z4-iDAONPyf7ljBU@pc636>
 <970317a9-0283-4eec-94ae-63056659d7de@suse.cz> <Z4-ruJ3KVD3PieZi@pc636> <7b7b92a3-780e-4db0-a5cf-3e78d79587a2@paulmck-laptop>
In-Reply-To: <7b7b92a3-780e-4db0-a5cf-3e78d79587a2@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 22 Jan 2025 10:04:08 -0500
X-Gm-Features: AWEUYZnGXh-cy4Fy05kQi-BwXQRu3oDh4MuEhuimfq_L2MOxTXiEhCh0-kaIvl0
Message-ID: <CAEXW_YQQii5061aNCvdCtvoBZra+5PxFWJcDCO0JWjSM3PURTQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
To: paulmck@kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, RCU <rcu@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 3:32=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Jan 21, 2025 at 03:14:16PM +0100, Uladzislau Rezki wrote:
> > On Tue, Jan 21, 2025 at 02:49:13PM +0100, Vlastimil Babka wrote:
> > > On 1/21/25 2:33 PM, Uladzislau Rezki wrote:
> > > > On Mon, Jan 20, 2025 at 11:06:13PM +0100, Vlastimil Babka wrote:
> > > >> On 12/16/24 17:46, Paul E. McKenney wrote:
> > > >>> On Mon, Dec 16, 2024 at 04:55:06PM +0100, Uladzislau Rezki wrote:
> > > >>>> On Mon, Dec 16, 2024 at 04:44:41PM +0100, Vlastimil Babka wrote:
> > > >>>>> On 12/16/24 16:41, Uladzislau Rezki wrote:
> > > >>>>>> On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrot=
e:
> > > >>>>>>> On 12/16/24 12:03, Uladzislau Rezki wrote:
> > > >>>>>>>> On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wr=
ote:
> > > >>>>>>>>
> > > >>>>>>>>> Also how about a followup patch moving the rcu-tiny impleme=
ntation of
> > > >>>>>>>>> kvfree_call_rcu()?
> > > >>>>>>>>>
> > > >>>>>>>> As, Paul already noted, it would make sense. Or just remove =
a tiny
> > > >>>>>>>> implementation.
> > > >>>>>>>
> > > >>>>>>> AFAICS tiny rcu is for !SMP systems. Do they benefit from the=
 "full"
> > > >>>>>>> implementation with all the batching etc or would that be unn=
ecessary overhead?
> > > >>>>>>>
> > > >>>>>> Yes, it is for a really small systems with low amount of memor=
y. I see
> > > >>>>>> only one overhead it is about driving objects in pages. For a =
small
> > > >>>>>> system it can be critical because we allocate.
> > > >>>>>>
> > > >>>>>> From the other hand, for a tiny variant we can modify the norm=
al variant
> > > >>>>>> by bypassing batching logic, thus do not consume memory(for Ti=
ny case)
> > > >>>>>> i.e. merge it to a normal kvfree_rcu() path.
> > > >>>>>
> > > >>>>> Maybe we could change it to use CONFIG_SLUB_TINY as that has si=
milar use
> > > >>>>> case (less memory usage on low memory system, tradeoff for wors=
e performance).
> > > >>>>>
> > > >>>> Yep, i also was thinking about that without saying it :)
> > > >>>
> > > >>> Works for me as well!
> > > >>
> > > >> Hi, so I tried looking at this. First I just moved the code to sla=
b as seen
> > > >> in the top-most commit here [1]. Hope the non-inlined __kvfree_cal=
l_rcu() is
> > > >> not a show-stopper here.
> > > >>
> > > >> Then I wanted to switch the #ifdefs from CONFIG_TINY_RCU to CONFIG=
_SLUB_TINY
> > > >> to control whether we use the full blown batching implementation o=
r the
> > > >> simple call_rcu() implmentation, and realized it's not straightfor=
ward and
> > > >> reveals there are still some subtle dependencies of kvfree_rcu() o=
n RCU
> > > >> internals :)
> > > >>
> > > >> Problem 1: !CONFIG_SLUB_TINY with CONFIG_TINY_RCU
> > > >>
> > > >> AFAICS the batching implementation includes kfree_rcu_scheduler_ru=
nning()
> > > >> which is called from rcu_set_runtime_mode() but only on TREE_RCU. =
Perhaps
> > > >> there are other facilities the batching implementation needs that =
only
> > > >> exists in the TREE_RCU implementation
> > > >>
> > > >> Possible solution: batching implementation depends on both !CONFIG=
_SLUB_TINY
> > > >> and !CONFIG_TINY_RCU. I think it makes sense as both !SMP systems =
and small
> > > >> memory systems are fine with the simple implementation.
> > > >>
> > > >> Problem 2: CONFIG_TREE_RCU with !CONFIG_SLUB_TINY
> > > >>
> > > >> AFAICS I can't just make the simple implementation do call_rcu() o=
n
> > > >> CONFIG_TREE_RCU, because call_rcu() no longer knows how to handle =
the fake
> > > >> callback (__is_kvfree_rcu_offset()) - I see how rcu_reclaim_tiny()=
 does that
> > > >> but no such equivalent exists in TREE_RCU. Am I right?
> > > >>
> > > >> Possible solution: teach TREE_RCU callback invocation to handle
> > > >> __is_kvfree_rcu_offset() again, perhaps hide that branch behind #i=
fndef
> > > >> CONFIG_SLUB_TINY to avoid overhead if the batching implementation =
is used.
> > > >> Downside: we visibly demonstrate how kvfree_rcu() is not purely a =
slab thing
> > > >> but RCU has to special case it still.
> > > >>
> > > >> Possible solution 2: instead of the special offset handling, SLUB =
provides a
> > > >> callback function, which will determine pointer to the object from=
 the
> > > >> pointer to a middle of it without knowing the rcu_head offset.
> > > >> Downside: this will have some overhead, but SLUB_TINY is not meant=
 to be
> > > >> performant anyway so we might not care.
> > > >> Upside: we can remove __is_kvfree_rcu_offset() from TINY_RCU as we=
ll
> > > >>
> > > >> Thoughts?
> > > >>
> > > > For the call_rcu() and to be able to reclaim over it we need to pat=
ch the
> > > > tree.c(please note TINY already works):
> > > >
> > > > <snip>
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index b1f883fcd918..ab24229dfa73 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2559,13 +2559,19 @@ static void rcu_do_batch(struct rcu_data *r=
dp)
> > > >                 debug_rcu_head_unqueue(rhp);
> > > >
> > > >                 rcu_lock_acquire(&rcu_callback_map);
> > > > -               trace_rcu_invoke_callback(rcu_state.name, rhp);
> > > >
> > > >                 f =3D rhp->func;
> > > > -               debug_rcu_head_callback(rhp);
> > > > -               WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> > > > -               f(rhp);
> > > >
> > > > +               if (__is_kvfree_rcu_offset((unsigned long) f)) {
> > > > +                       trace_rcu_invoke_kvfree_callback("", rhp, (=
unsigned long) f);
> > > > +                       kvfree((void *) rhp - (unsigned long) f);
> > > > +               } else {
> > > > +                       trace_rcu_invoke_callback(rcu_state.name, r=
hp);
> > > > +                       debug_rcu_head_callback(rhp);
> > > > +                       WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> > > > +                       f(rhp);
> > > > +               }
> > > >                 rcu_lock_release(&rcu_callback_map);
> > >
> > > Right so that's the first Possible solution, but without the #ifdef. =
So
> > > there's an overhead of checking __is_kvfree_rcu_offset() even if the
> > > batching is done in slab and this function is never called with an of=
fset.
> > >
> > Or fulfilling a missing functionality? TREE is broken in that sense
> > whereas a TINY handles it without any issues.
> >
> > It can be called for SLUB_TINY option, just call_rcu() instead of
> > batching layer. And yes, kvfree_rcu_barrier() switches to rcu_barrier()=
.
>
> Would this make sense?
>
>                 if (IS_ENABLED(CONFIG_TINY_RCU) && __is_kvfree_rcu_offset=
((unsigned long) f)) {
>
> Just to be repetitive, other alternatives include:
>
> 1.      Take advantage of SLOB being no longer with us.
>
> 2.      Get rid of Tiny RCU's special casing of kfree_rcu(), and then
>         eliminate the above "if" statement in favor of its "else" clause.
>
> 3.      Make Tiny RCU implement a trivial version of kfree_rcu() that
>         passes a list through RCU.
>
> I don't have strong feelings, and am happy to defer to your guys'
> decision.

If I may chime in with an opinion, I think the cleanest approach would
be to not special-case the func pointer and instead provide a callback
from the SLAB layer which does the kfree. Then get rid of
__is_kvfree_rcu_offset() and its usage from Tiny. Granted, there is
the overhead of function calling, but I highly doubt that it is going
to be a bottleneck, considering that the __is_kvfree_rcu_offset() path
is a kfree slow-path.  I feel in the long run, this will also be more
maintainable.

Or is there a reason other than the theoretical function call overhead
why this may not work?

thanks,

 - Joel
