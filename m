Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8F4A0921
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358478; cv=pass; b=e7gltrG+Qgun+jNAatD3xM841rxPFrv5qavvpOYVRIBNVOGU0SjWxfM8IXWyCdKOG16LRRfkbo9C8p4I222b9bp/oZ3wzqtjaGRkUdVX6VsooYmKpY5PaYX9eg1Hab+69pCeLgQ0V+HzydOdoNpu+EePCrdaP1eAkXvfj1SGnMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358478; c=relaxed/simple;
	bh=cdAE1a6vG9C5ULJiRkOdqZgP3psLeL7eFGyxPIwl2S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUbpPSP8dA9ma34unPDs+Zk+jquHnd1pxMzM5z8NigBtnb0BW/TIxbbofv61IZKeo1bQ1lxS6lSfBo2/d0ixYiSQb4VeKVVic+ZE3ZfEHBO9j2jFaeijHVZOOldz6rg7aMD8Q4Ns0zLBv39wdRFTNr7OGMPUXR8jmpIh1GmJLyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJF0mgP8; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJF0mgP8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so2028632a12.0
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 07:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788358474; cv=none;
        d=google.com; s=arc-20260327;
        b=HqJHuO2j104w8AuwmzJvEZFohq2v8c+RSdRSOU7opJdIGEpqHc/4TRfhsrLdWQ3mTV
         zGelwdl0qkI6mm5L5nToMig8fB9HpPkjTQyoo3vAFhmk27Ct6MSMMy2ufFHRYbhV5HMP
         XGA801yYTP0SEkRtaX4YsJmPA1mb+XmmNBtAbKZ6PyduPfGd0jgRnYLTLxwBJ/OxhtTN
         Q47VBMpEIqVmMkgc7ShVEeTfUjcykUfqzntb2a14RjQAgvjoscWt980Zv/n2tHx2/Xxo
         hc8GiIJyBTGxzDhciKf9bm9VBwwQAFkF8Ad8ZLKFx8QXmrDdtpZUylZq2nrsl8TuaEwV
         KSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z1Gb9svefZexXgI3MSllPyHbPKRof4ikpCQHMZNBOag=;
        fh=IsHzSwI7dFKiYLixS5tMT8sf9Pjxa1PgQbsIeJgX3gU=;
        b=byq3NPmGha+QLLvThUw3yH2r/LmOEop7uuiWjtGfrtcG0RjKZ2jJfVaoQ4MmTnopt6
         XL71sDMiZyQbvvhrg3NkyD7ySiTlQ3EVWxhwGtxSdxB5o0AGXYMbV/pmlnrZ4/4K0JpY
         CYJsSE61Qm30GBdsgxpIJf8OvBsfCjdw+wvWCQhLRrdSFwgtGFagicwKg87rF9BX9GDz
         o71ngbpKBIPbW6JtTV7n8n01FrGO2UYowHZcjz2adbzjp4fPMeXaYgt3B0WGCEsyNzXG
         aCmjM1cs6IFE5HsE3v/j8umMHvDOBFtF61/2oqflqG8Xh2tHkE6ctJYMUH0ulbbupuRd
         ollw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788358474; x=1788963274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z1Gb9svefZexXgI3MSllPyHbPKRof4ikpCQHMZNBOag=;
        b=sJF0mgP8xNI2Q8N/WkXuyZcnO0CBDtRhtL01R4ujdEFMdPpBGx80H5Y7UyQYmgYNCC
         H+aM0MsE+h+zNpKeIZg94gcuQ0xG19JEaf7bNeUMsrcEV0BjMEYG+Cuyfk2XtIwJ1fT+
         bVe821pA3DVx3zxCOQF39rkVjK9AvnoRqxrrIfAYM2+M4C9prei1PF4WWtBGdb4/DizB
         vTNt1N5Tb9zm0N51NyO+qisNNqRYq7a0bkUdzvRBa5VZmj5psqlVWz3+ss+H03CiGoyw
         uHA9tykX8+i/gFPoqK4iDgt5MZKvYbRQEsBf+JqlGs4dXrT+tE0qoLwFDcv8IdFV7dbC
         F+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358474; x=1788963274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1Gb9svefZexXgI3MSllPyHbPKRof4ikpCQHMZNBOag=;
        b=YVL3c4lnE9Re1x29K98PCMR78tDo2t1c/fuPdLFiZY3MQDc8O/fatFe9bUFmK2PGUr
         bI464MSMDX2SjtHBbNOXAshjMJwyFGxaGPGAjRn+yrnrWevXuK2cghbUrcNuD5OK7sR8
         UBiUP12pYuZPLAj6o5SufktDkr5uQa3Pt0pALWS8lVvm/pQWDTFL4IcNn4cVRT3J74dF
         lx6vyacSytHkn8dL3um37c2l0XNhWsfBr2ROKK9UFRytfeloty06vsvw5SAZ/JFJDKTr
         Tes95aPDJDkqZfMMmSxV81c6Okm2UrKon1uVP/t9dqaksF0ABoDcKH68qr3EHjgt/q3O
         nKzw==
X-Forwarded-Encrypted: i=1; AKwUvBxazaGBOKPrXK8HmdTGVD4GqhNE3vxbfKAXW3guFAiZnmZuGkx42qU3TG/RpUbHiMjtro4=@vger.kernel.org
X-Gm-Message-State: AFuF++nf/ZxLmHo78JS5owOqd/bH5QHTM1nveIDFDb1rSfndy9CdSGuM
	DCabzLQ6vo5hvquHlXWOKCL/pvLLihBuXYFq/hql5ya011KuWddjS8Dc6wCZww8TXlap8ex40MW
	11m5j3ZsYzh46vRr2hm59gyFu+i/AgS8=
X-Gm-Gg: AYBFou3fwDyGnDCPXmF5Uh0BEZWzhy+SV3iNaQOuEjDOCDxUpYUsA/CXBkfLscc+pmi
	/1IkK2XRs+l/MV8/Dib7DuoVo2gSqTwdcpWmkfQ7P+ssLhgH2buJ+YBe1UdQxOQNAA2/LAo9bEu
	0MBDX87NRCUQ6EPwS3rSTtCoprpoE+85soS4WRDLUN+ANsAS822Se8cRkobeFpkTkMpiH4EzEeZ
	tdPDPKiDDkI81ju9csLZbf7F51ZlqkruATb4FmIBTaorc20op+WWBreCKkdeIw3xQTR4V++hcKk
	AaHrN+6HzR1+d6fi6d46TEkC15/kiSCGXYBvf5eKx8SgUvfqOK05RWSzgvoZ
X-Received: by 2002:a05:6402:20c6:20b0:6a6:8b46:4973 with SMTP id
 4fb4d7f45d1cf-6a68b464ac4mr1842114a12.7.1788358473392; Wed, 02 Sep 2026
 07:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <20260826144636.3IRUXeFV@linutronix.de> <CANk7y0hbwXL7nBDgjTgrneBejEgGrsZnc02RztG-aSBEEvAcwQ@mail.gmail.com>
 <20260902082657.yPEhNFlo@linutronix.de>
In-Reply-To: <20260902082657.yPEhNFlo@linutronix.de>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 2 Sep 2026 15:14:20 +0100
X-Gm-Features: AcwNN1VcZ0Pb1fdH9gP2Tb1Pv8VYUhDajHrWJ9SzT4ipxs3lXYiu2AFNy3-3ems
Message-ID: <CANk7y0gMh6McuLnFwxGO-nH_g3TnstwTK2rtT5pq=b8qq9ykKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
	"Harry Yoo (Oracle)" <harry@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:26=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-09-01 14:53:56 [+0200], Puranjay Mohan wrote:
> > On Wed, Aug 26, 2026 at 3:46=E2=80=AFPM Sebastian Andrzej Siewior
> > > > +/*
> > > > + * Defer whenever interrupts are disabled, since a callback-list o=
peration may
> > > > + * be in flight on this CPU.  Not before the scheduler is up: irq_=
work is not
> > > > + * usable that early, and rcu_init() itself calls call_rcu().
> > > > + */
> > > > +static inline bool should_rcu_defer(void)
> > > > +{
> > > > +     return IS_ENABLED(CONFIG_RCU_DEFER) && irqs_disabled() &&
> > > > +            rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE;
> > > > +}
> > >
> > > Why does the description say that the defer part is for usage from NM=
I
> > > and the test here has irqs_disabled() instead of in_nmi()?
> >
> > We defer for both irq disabled sections, hard irq, and in_nmi() and
> > checking for irqs_disabled() covers all three.
>
> But it is wrong to talk about NMI and do this for other reasons not
> mentioning why this was needed/ made sense.
> Can this be fixed?
> Also what is the reasoning for doing it from any IRQ disabled region?

So, the main reason for this patchset is to make call_(s)rcu() work
from BPF programs, and these BPF programs can run from any context
like an NMI perf event interrupt or maybe attached to a function
through ftrace which is in the call chain of call_rcu() itself.
call_rcu() takes locks with irqs disabled or it modifies lists
non-atomically with irqs disabled. This means that a BPF program that
runs from NMI with the lock already taken will deadlock, or if it runs
between these non-atomic list modifications, it will corrupt the
lists. A BPF program can also synchronously re-enter call_rcu() if it
is attached to a function in the call chain of call_rcu() that is
called with a lock taken. So, all these cases are detected with
irqs_disabled() and on detection we do stuff that doesn't require
taking any locks and is safe even if re-entered.

> > >
> > > > +
> > > >  enum rcutorture_type {
> > > >       RCU_FLAVOR,
> > > >       RCU_TASKS_FLAVOR,
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 21b6ce1dffb63..3bf3a250f9de8 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rc=
u_callback_t func, bool lazy_in)
> > > >       local_irq_restore(flags);
> > > >  }
> > > >
> > > > +/*
> > > > + * Re-issue deferred callbacks straight to the enqueue so they can=
not defer
> > > > + * again.  ->defer_lock serializes the drainers: this CPU's irq_wo=
rk,
> > > > + * rcu_defer_flush() and rcutree_migrate_callbacks().
> > > > + */
> > > > +static void __rcu_defer_drain(struct rcu_data *rdp)
> > > > +{
> > > > +     struct llist_node *node, *next;
> > > > +     unsigned long flags;
> > > > +
> > > > +     if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > > > +             return;
> > > > +
> > > > +     raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> > > > +     llist_for_each_safe(node, next, llist_del_all(&rdp->defer_hea=
d)) {
> > > > +             struct rcu_head *head =3D (struct rcu_head *)node;
> > >
> > > Why do you need the lock. This is still not clear to me despite the
> > > comment. You can do llist_del_all() towards another list and then fee=
d
> > > it into rcu_do_enqueue() one by one. And you use the LAZY part.
> >
> > Because rcu_barrier() can call this for each cpu and at the same time
> > rcu_defer_drain() can call it too, so this would cause a race where
> > the irq work can remove the callbacks (llist_del_all) and before it
> > can enqueue them, rcu_barrier will see that the list is already empty
> > and will not wait for these callbacks. We want the llist_del_all() and
> > rcu_do_enqueue() to happen atomically so rcu_barrier() can work
> > correctly.
>
> So you collect a bunch of callbacks and spent time re-arranging
> everything with irqs off.
> What is wrong with keeping it in the llist and consuming it like the
> regular rcu_segcblist?

I don't understand your last point, all the collection and delayed
addition into rcu_segcblist is because it is not safe to do it
directly as I explained above.

>
> > >
> > > > +
> > > > +             /* Bounds a node self-linked by a double call_rcu(). =
*/
> > > > +             head->next =3D NULL;
> > > > +             rcu_do_enqueue(head, head->func, false);
> > > > +     }
> > > > +     raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> > > > +}
> > > =E2=80=A6
> > > > @@ -4231,6 +4330,9 @@ rcu_boot_init_percpu_data(int cpu)
> > > >       rdp->rcu_onl_gp_state =3D RCU_GP_CLEANED;
> > > >       rdp->last_sched_clock =3D jiffies;
> > > >       rdp->cpu =3D cpu;
> > > > +     init_llist_head(&rdp->defer_head);
> > > > +     raw_spin_lock_init(&rdp->defer_lock);
> > > > +     rdp->defer_work =3D IRQ_WORK_INIT_HARD(rcu_defer_drain);
> > >
> > > Why is this IRQ_WORK_INIT_HARD() instead, say, IRQ_WORK_INIT_LAZY()? =
Is
> > > there a requirement that the RCU callback needs to complete asap and =
not
> > > be delayed to the next tick? This would give kind of the LAZY part.
> > >
> >
> > In discussions with Paul, we concluded that we need HARD because in
> > low memory situations delaying rcu callbacks can be problematic. Given
> > that we are already deferring the callbacks, it would be nice to have
> > them enqueued asap. But if there are downsides to this we may change
> > it later.
>
> It does not look like you defer them for long at all. Every callback
> enqueued in an IRQ-off region will be immediately re-enqueued to the
> regular list the moment interrupts are enabled again.
> Except on architectures which don't implement irq-work interrupts where
> it will be delayed to the next HZ tick. And the next HZ tick does not
> sound like a long time either.

Yeah, I get your point, and when a CPU goes offline will its LAZY irq
works be drained or left in the queue? Because we want to make sure
this irq work is executed before a CPU goes offline.
