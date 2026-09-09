Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E9584947
	for <rcu@vger.kernel.org>; Wed,  9 Sep 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964266; cv=pass; b=QTZYoTPS+cGVL0zs/AXdhlyuzQ9T63tAHeU2axvCGWXT69MVwK3Aa6AOOWYkBkppPjCj7lTuW+ZQkajhv80a7HPewZdBG79RpW3IROad+elRk0/acyDQeh1ZPJ564CY0RGf+HP6Y5pfgtIh1gEpUl8k7cQAK2eOqosg6JOzqvD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964266; c=relaxed/simple;
	bh=bL3FhBHPAN/gO0KYh+II+j6VXDmseoWIh8krisyD6DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZl/EeCR2FwLwVCZ2MkrBj4lbwJ2tVz5F46yvHUE5zmf2GsJ45r0GJxXjxgckU2XMBkFrMhTtvDo6RWZZZNasmEHL3t3M34lraCvDNCVbQrAfCRjpbJJ/9O/XW2NGh4sytb197dDCTz8BLyHeagQHl6f4Bh3Bo1Nc74n98VNO7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVK46is5; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVK46is5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c255c58156bso1218317766b.3
        for <rcu@vger.kernel.org>; Wed, 09 Sep 2026 07:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788964263; cv=none;
        d=google.com; s=arc-20260327;
        b=n0k+eLAeKqXcoGui5roBou6CU+2FFKpe+7b0iXVGaweWJJhCbK+/+KZwZSnwdQ8/1a
         G46tQhsQbRdItuyUuuf5+O5RI2Sg1pRhnKNx7pD6WIorVzSWgHkXhO/xW6CYpVIwXgJv
         cbAsc1oKlM0H9RCXO4LPy8WDGFMxBfgMRpB5BGx3S7BGRWy7negg4JwCQHNpOIvFg/BA
         eIcaYcMp6xj9Lep3VrV6Jfmq0kJbykQ4yZnlhPzIFXH2Wn9etZYBRIRV7rxaYge0eZoY
         2pZgHiRHWrtsC2btr1/ChMI57rRjbhQ/+niNWUnosxBcEf6T3BIel7EHE+0+TxPK1CDz
         p2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        fh=VhDqG3wNSw29uLY5UfBNRD9yCY+67FlSnqle5HJRpLs=;
        b=QR2+AJeVF9N2kBTN+2SziXD8CL0HUNuW0rX2asgPqDuhBa5Re7yKqL/gQVw2VIYvgn
         ekrjDNGia0rUQNU50Jqea0NmzUSExhZco7sOFJbwKkUjGh+RlsfBMmYLoXXdsk+8WV4I
         JFSbmE/xq7Pc7xJLv2MCgrwNwPPKfD4b/V7eAWKBrSRdLyOSK30QDVPhWw2b64v9qt8n
         4ss2orxVwePYJ2si3XObewDLwQLfnLJgWEo+oinVeF9+52IyMbUS6LHEGglnPrkEAytX
         d2rSnmNHIZpsTwhNBxiyr/LYwUxQxmYau8WzwzVNjtPaGHMr7alcWO4ywVlD4xpiKZbr
         GKuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788964263; x=1789569063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        b=oVK46is54PUpLYbpIBMQLOINYV2JcYG9PO+ngMV/f40+xJBaeGXWpS1X43BK+GMXz2
         QvTce6LZx4Ji6fP5Ao3OdSGfvaxBuY2MdAoXfdiKcnaEetOAM9Tuv0CE4E9/gylO9I/l
         Ot0/SbWgcZ/qGRbxDY7mpmLJX7ZJLJFde8xTkwYc7LW8dR0VQ/PbXl3fA3Cq0J/i1ebT
         wVQpCU/9H6mJh3kgW3h/SWvtwQxAtnGaQAS10RvvCaSUnJVIrnWfEhJ8gFZY+ABVUJEb
         6Jzn7DjLnHWilz25cHyw95ndg3389UCx96nII7kME8AjDCrnB2jiFlAA3N+gBHBB8Abk
         bmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788964263; x=1789569063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        b=oIz5fNFat5izZnRbHM5KQM4Ld1vtZB2racnKi7xUdr3GYgPX7mjpUqg8mpo9RBEm8z
         5/wIUNFqe6xl0Tq4YxTw+BCB/7L4uZBZSi+3Forr8lJGaF2qFogBqOkLMhxmREzO3bSl
         pIoVBkzEW7IvDscKZi/qUnql73FXcCQpfbZN7LkbIAmfu0JMyWJOV94h3tT67dZO/jzy
         kkeJuxNMN0PlgHSR57kkdh5T4EjP7Dyg3ZRIJsl80g+QzETzyEMj2OfuZY3s1H1x0sgT
         zyth1cL+awrnpALDtIjtwoaEwdnL1rHWlj/8EI7QgYtJ3fQIDnzsW5sJwEF/zZKGrwEn
         tQRA==
X-Forwarded-Encrypted: i=1; AKwUvBxDrE+XOYqbPgxBwtNYsEdARfvtTHr23nroTGE4BtuZ1Es/2ZVZIrJEsNnrWGIQuZB/9E8=@vger.kernel.org
X-Gm-Message-State: AFuF++kns4fjuY52M6L4M4pDteRvQV7tgYo2heSUZGFY0g9Lnsk/PF7P
	G0Rf8zldNbxdee61niqjFjIw3lKz4S7QlSi6jxnKt0KBILZZVBNfvOIQj9UChhLtI23W0wOYL+K
	ooz5Zcl0hZbZRgViin15QXRHLUwmLiXs=
X-Gm-Gg: AYBFou2iSb8VUAKY8d5gnmxy5Zm0yA4KL3eI150JYxwP+ylF9e0pGqiDuo/UryYD0Hy
	T1lha7J3g/NPDuu//EyXyAlyZ18WAiNR5rTCjOIMqrLlkSsvJoIpYpfH7v/+HUBfLecBFbiuE90
	xYYKS7ouWJPedDp/0KdQVmm34+h1AGDG4IUiCBurp6UdQNCAVeey2VVkIAGMsYX9pbNquySPGc+
	WSFOq4zqtz1YD6MP9jAZsDVauJQOZtID7frMMpUQgFCwtg/bi+89K6UIR/v9Y/ZQ0kGLoQXZ06S
	x1rvnTBmApE50RMExT0qnUwe1Q9j94x9KCTM1q6nXFKcDuVGrVWT6IP8wDSEttDsLH2Y7oQ=
X-Received: by 2002:a17:907:3f2a:b0:c28:fb3f:fe20 with SMTP id
 a640c23a62f3a-c28fb400053mr726589666b.30.1788964261711; Wed, 09 Sep 2026
 07:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <aqFebI06nXUccuwt@thinkstation>
In-Reply-To: <aqFebI06nXUccuwt@thinkstation>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 9 Sep 2026 15:30:48 +0100
X-Gm-Features: AcwNN1XiH3nsxsI43wM30YdmALjDY-XF6jmsUMiyceN_7aAAFdPSS0ZgK9KjeOs
Message-ID: <CANk7y0htDA4zC6tK=Fi5H9bbFvQzOEJ57NtxDYhRLuMAxgEe3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
To: Harry Yoo <harry@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Fleming <mfleming@cloudflare.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:26=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
> On Mon, Aug 10, 2026 at 05:27:50AM -0700, Puranjay Mohan wrote:
> > ---
> >  kernel/rcu/Kconfig |   6 +++
> >  kernel/rcu/rcu.h   |  11 ++++
> >  kernel/rcu/tree.c  | 131 +++++++++++++++++++++++++++++++++++++++++----
> >  kernel/rcu/tree.h  |   6 +++
> >  4 files changed, 143 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index f15da8038d0ba..1a5fb3156c062 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -175,6 +175,12 @@ config RCU_STALL_COMMON
> >  config RCU_NEED_SEGCBLIST
> >       def_bool ( TREE_RCU || TREE_SRCU || TASKS_RCU_GENERIC )
> >
> > +# The deferral (and the IRQ_WORK it uses) is only needed where call_rc=
u() /
> > +# call_srcu() can be invoked while a callback-list operation is in fli=
ght.
> > +config RCU_DEFER
> > +     def_bool HAVE_NMI || KPROBES || FUNCTION_TRACER || TRACEPOINTS
> > +     select IRQ_WORK
>
> nit: I don't think this config belongs to RCU.
> Do we really need this when majority of kernels enable those?

Paul was worried about some embedded systems paying a performance
penalty as they might not enable these but would still use RCU.

>
> >  config RCU_FANOUT
> >       int "Tree-based hierarchical RCU fanout value"
> >       range 2 64 if 64BIT
> > @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_ca=
llback_t func, bool lazy_in)
> >       local_irq_restore(flags);
> >  }
> >
> > +/*
> > + * Stage @head for this CPU's irq_work to re-issue once interrupts are=
 on.  Only
> > + * the drain side takes a lock, so this stays safe from NMI.
> > + */
> > +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +     struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> > +
> > +     /*
> > +      * Instrumentation on the enqueue path can re-enter here from ins=
ide the
> > +      * drain.  Re-queuing would livelock it, so drop the callback; an=
 NMI
> > +      * cannot loop, so let it through.
> > +
> > +      */
> > +     if (READ_ONCE(rdp->defer_draining) && !in_nmi()) {
> > +             WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> > +                       "call_rcu() re-entered during callback drain; l=
eaking callback\n");
> > +             return;
> > +     }
> > +     head->func =3D func;
> > +     if (llist_add((struct llist_node *)head, &rdp->defer_head))
> > +             irq_work_queue(&rdp->defer_work);
>
> Should RCU wait for the IRQ work to be processed during e.g.)
> rcu_barrier()?

Yes it should and it does, rcu_barrier() now enqueues these deferred
callbacks from this list before doing the other barrier logic.

Thanks
