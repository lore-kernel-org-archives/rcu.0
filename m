Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69942CAF3
	for <rcu@vger.kernel.org>; Fri, 31 Jul 2026 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507985; cv=pass; b=Z6Jrl8rlZeXVvUm98E0/YQtADoK/FWHE2Rt0Yfx7xyIf3oSCTc8M64N9ds0Vtp/ocxskt/pYIe+HRc8xKzIr/O/63SQ3vpedvMAyemM0IxEKEtQerE+f66BHByvmeQYN4ji7diMZK2i0BuIUM8rDWV9nguE8dPMKbFjr758yzJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507985; c=relaxed/simple;
	bh=OJEjYqZXR6D8o5i1tKss18NEHMG/oQmxzQk/ihg2t8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA//8pQ1YPhoojdqwNbdjUTGgef6F4E+Aqq6Oc7t+jDgE+bI67e3YHRsN0j2E6HQTEiQguhtt5k0fKPFg4NdFxmI2GMsdPwxO+KAosGSH6LUUxq0pRNSMNJOrSbPv6PDB+lH8JId3gCCMcICw4uij9434BYLta4Oxl8J5c3Jv5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWp0GOaD; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWp0GOaD"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69fc6a09b5aso1895441a12.3
        for <rcu@vger.kernel.org>; Fri, 31 Jul 2026 07:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785507981; cv=none;
        d=google.com; s=arc-20260327;
        b=GSh9Gd93+r5ow7rhnzVEqmWLC5Fl7+fb9m+AU/IFpE6Xf7DV4vrNOVGUCLRNXE2gZF
         lcVZ7ZKPErldZ84Qo1G9wdG34Gh31VXZ2hgCJwwTiA264+omvPQ8MZm4dtOzHEsBCpmV
         GMUFaGWkCC1bHVQQiBO9D3LMjyiCy05MDkm1dr4k05D8V1YRxJH0jfxijInMFy+KkCLy
         6tj9gDJ4tTosqVZYNQ+EAXXwZNdfGtaNc27RdYSqNPPNbWLcsP/kATsWWRjDRnn3oU/o
         B6NZwmupIuuEXpNKT+0U0Q+Furp2UCV23gC1zNBAEHbB774WeEinfc8ccIfrOP8G+tTY
         Yp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W2yZkXeMTFenp1C/Q3jIxXtZxx8SXWBO8BbuefERWdA=;
        fh=c4TZ2LlFmrUMKbj9OltaN1SxIcp0+AUb5PRZydLxLjQ=;
        b=CKfznLpdckEuUQ5xwBJYADT9h49NN6b5J+HnDiqpXTOd0h+/+wveGFCYhRH2tggHdz
         eGBWwJ/8P4aMzi4vQaKWSP0IlbDD9Hko7dCOErbQabOaIVxwewWaynzsTPSFk1aKkfhc
         IlfgL4DrfrAoIMnTyI6m2/PC8DxX/M95rV+V2lBZzHEObI/rMdLd5FVh8EQv2sY3Zumm
         9pbfql/ySSimphJtv+o7boaxzB/ZQWULpBf+rcOthgZoH5A7qw0RzrzkATUvhOfXtkVy
         /IY6fQsjEO/eLPiSdi7AZPMm9Sqq7NwB6vA2jCMWjau6CFTFJK8lP5oeqa8Hs/3d482a
         Okfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785507981; x=1786112781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W2yZkXeMTFenp1C/Q3jIxXtZxx8SXWBO8BbuefERWdA=;
        b=iWp0GOaD5erQisRDNhuWCBlrkqK6r0pWR4IukL5OFykox9viEQ1rQODvK0TPPtDKmJ
         DD+VwZ84vJuVhf2Yive6v+aTzQ0RtmYYh/1dngF5VVbfb+rytkRgBzU9U89q39EeVpOw
         FA/+307bAim+5RKknj5ZOQJu6MJaOV0Af1uhyrsR7FaaA0HQYCtmatQraD4HiDL9Okox
         cYkOzDDoE/4v3TB7VqP0G7LV1cu02lU5w8iLV+OCymdxJjBEh4Awq7Dx9hgaaOF8+Z0Y
         HcD9TUyRziUTMdLdF9lHxicx+cEIvalMvtnQ7LA9FWv1lCLcV0LtGICCPEJyz8vQqsNz
         DqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507981; x=1786112781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2yZkXeMTFenp1C/Q3jIxXtZxx8SXWBO8BbuefERWdA=;
        b=MUA0QX2rTLB9SdsGTGZiQ3lSBzUMynbJ4nVEY5b1X05XfVelNg94baGKUms0sHQcsV
         UOtG200+9IjNLAgOtJcstPW7MIrAzsH0IFKtVCwPHMfnBLLvkMYpC5OitiuB9g/Zdrf+
         ds+OCxLylIWhNsSeXuYyngA/rDHrZ+cB+wqmexPYFDATRh0efqlMMDsq/oY9/inCfbtI
         IOGA3hkQSc/opzW6AJRj6L/LIL0mvcxA+RsLikoYmRj0BaG1S20PdT/KPS2UxQ5koQFL
         9bfv1q7gfucsEJ1axp+oKrIpq6jIF0s2hSoVju4AotJ8RkcfNF6o4SdqQlQDCAWSO6Yp
         jvHw==
X-Forwarded-Encrypted: i=1; AHgh+Rr06M+4WW8M8c5CG0E6qQFaLRj72bcPtboyRa5Jh2DKr8VS1GJWvo6yjFeGn2bMyfT1H2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiAlY9b3zX0rG9w8Hv+jg7/KGSqzNYeJzQ/lr97BxMtAjmOtg
	Y/10ICNlZEIYTZ83VotGfV3NH7VcFeVUC9veEQkskNNKdSrdOJaSaU8Z0/aGN+FJwhbpnpcHgLU
	4T2iPDtZ5snxiqi3l9Duxz7S8W/Y4K1o=
X-Gm-Gg: AR+sD12HyFux6+itUhggjLci3XqvOKezXPKM+64RmBFABMvV7O76qQIqaM7nEFFHl3f
	9+TKylnKzgG7znjQ0t6WHtV3zgUFyzRbKDGXsVuCVoEEpzLC3MJwBCnF8p/chcoUJn+SpGnN0+m
	AJBHN0aN6kM1qwWH+FBatgn+TIxc+6mvVD4IT94fAjF2HLkKgfFHxGrqowbgBD4vnGKX21s0WYK
	cY1emzg1+SsTeIDyz3ZzW7dvfHlhKzVRdZhTEorD2Yhyw3zkZoQ2h72HsqnMGLASVBvRJtSlZGW
	vksoZXBwgLFIuN/uqHCR54Drfs/cQjiLwBI02qzwDmx1iHlEgFtrH6L9OfkP
X-Received: by 2002:a17:907:3f8f:b0:c12:4cb8:a826 with SMTP id
 a640c23a62f3a-c1fd238bfb3mr118334566b.6.1785507980912; Fri, 31 Jul 2026
 07:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729162207.1567770-1-puranjay@kernel.org> <20260729162207.1567770-4-puranjay@kernel.org>
 <96a07fd8d37018b005de85a0eac6045fa426e892@linux.dev>
In-Reply-To: <96a07fd8d37018b005de85a0eac6045fa426e892@linux.dev>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 31 Jul 2026 15:26:07 +0100
X-Gm-Features: AUfX_myqCfx8h0yHc581WwWjTLagnsHorHWGgwfxqIRoqW5qkV1Oj9THSsqRF-8
Message-ID: <CANk7y0g3tE7YJMV4nokqjiaMVeENVKxSv3zjLinXWF4GD4zzxw@mail.gmail.com>
Subject: Re: [PATCH 3/6] srcu: Make call_srcu() safe to call from any context
To: Zqiang <qiang.zhang@linux.dev>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Fleming <mfleming@cloudflare.com>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:03=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > call_srcu() has the same constraint as call_rcu(): its callback list an=
d
> > locks are only touched with interrupts disabled. srcu_gp_start_if_neede=
d()
> > enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree,
> > and callback invocation and grace-period work do likewise. So a
> > call_srcu() with interrupts disabled may be racing a list operation in
> > flight on this CPU, and enqueuing directly could corrupt the list or
> > deadlock.
> >
> > Defer as call_rcu() does: stage the callback on the srcu_data's
> > ->defer_cbs, chain that srcu_data onto a per-CPU list, and kick a per-C=
PU
> > irq_work that re-issues it straight to the enqueue helper -- never back
> > through __call_srcu(), so it cannot defer again.
> >
> > The irq_work is global (per CPU, not per srcu_struct) and statically
> > initialized, so the deferral never runs check_init_srcu_struct(). It is
> > IRQ_WORK_INIT_HARD to re-issue promptly, as for call_rcu(). srcu_barrie=
r()
> > and cleanup_srcu_struct() flush it first, and rcutree_migrate_callbacks=
()
> > calls srcu_offline_drain() to drain an outgoing CPU's deferred callback=
s.
> > Gated by CONFIG_RCU_DEFER, as for call_rcu().
> >
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  include/linux/srcutree.h | 4 ++
> >  kernel/rcu/rcu.h | 3 +
> >  kernel/rcu/srcutree.c | 138 ++++++++++++++++++++++++++++++++++++++-
> >  kernel/rcu/tree.c | 2 +
> >  4 files changed, 144 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 75e54e4f963fa..1ce759fb70948 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -13,6 +13,8 @@
> >
> >  #include <linux/rcu_node_tree.h>
> >  #include <linux/completion.h>
> > +#include <linux/irq_work_types.h>
> > +#include <linux/llist.h>
> >
> >  struct srcu_node;
> >  struct srcu_struct;
> > @@ -41,6 +43,8 @@ struct srcu_data {
> >  bool srcu_cblist_invoking; /* Invoking these CBs? */
> >  struct timer_list delay_work; /* Delay for CB invoking */
> >  struct work_struct work; /* Context for CB invoking. */
> > + struct llist_head defer_cbs; /* Callbacks deferred on re-entry. */
> > + struct llist_node defer_link; /* Links onto the per-CPU deferral drai=
n list */
> >  struct rcu_head srcu_barrier_head; /* For srcu_barrier() use. */
> >  struct rcu_head srcu_ec_head; /* For srcu_expedite_current() use. */
> >  int srcu_ec_state; /* State for srcu_expedite_current(). */
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index ed6604445f2ac..036d28516e92d 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -587,6 +587,9 @@ static inline bool should_rcu_defer(void)
> >  return irqs_disabled() && rcu_scheduler_active !=3D RCU_SCHEDULER_INAC=
TIVE;
> >  }
> >
> > +/* Drain an outgoing CPU's deferred SRCU callbacks; see rcutree_migrat=
e_callbacks(). */
> > +void srcu_offline_drain(int cpu);
> > +
> >  enum rcutorture_type {
> >  RCU_FLAVOR,
> >  RCU_TASKS_FLAVOR,
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 304112674e8a2..b9fe57ff91000 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/preempt.h>
> >  #include <linux/irq_work.h>
> > +#include <linux/llist.h>
> >  #include <linux/rcupdate_wait.h>
> >  #include <linux/sched.h>
> >  #include <linux/smp.h>
> > @@ -79,6 +80,46 @@ static void process_srcu(struct work_struct *work);
> >  static void srcu_irq_work(struct irq_work *work);
> >  static void srcu_delay_timer(struct timer_list *t);
> >
> > +static void srcu_defer_drain(struct irq_work *iw);
> > +
> > +/*
> > + * Per-CPU call_srcu() deferral state. The irq_work is global (shared =
by every
> > + * srcu_struct), so it must find which srcu_structs deferred callbacks=
: a
> > + * callback is staged on its srcu_data's ->defer_cbs, and that srcu_da=
ta is
> > + * chained (->defer_link) onto this per-CPU ->list that the irq_work w=
alks.
> > + */
> > +struct srcu_defer {
> > + struct llist_head list;
> > + struct irq_work iw;
> > + raw_spinlock_t lock;
> > +};
> > +
> > +static DEFINE_PER_CPU(struct srcu_defer, srcu_defer) =3D {
> > + .lock =3D __RAW_SPIN_LOCK_UNLOCKED(srcu_defer.lock),
> > + .iw =3D IRQ_WORK_INIT_HARD(srcu_defer_drain),
> > +};
> > +
> > +/*
> > + * Register pending deferred call_srcu() callbacks so a following srcu=
_barrier()
> > + * waits for them. An online CPU's own irq_work re-issues its callback=
s, so wait
> > + * it out; an offline CPU's irq_work may never run again, so drain its=
 list
> > + * directly onto this CPU instead.
> > + */
> > +static void srcu_defer_flush(void)
> > +{
> > + int cpu;
> > +
> > + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > + return;
> > +
> > + for_each_possible_cpu(cpu) {
> > + if (cpu_online(cpu))
> > + irq_work_sync(&per_cpu(srcu_defer, cpu).iw);
> > + else
> > + srcu_defer_drain(&per_cpu(srcu_defer, cpu).iw);
> > + }
> > +}
> > +
> >  /*
> >  * Initialize SRCU per-CPU data. Note that statically allocated
> >  * srcu_struct structures might already have srcu_read_lock() and
> > @@ -107,6 +148,11 @@ static void init_srcu_struct_data(struct srcu_stru=
ct *ssp)
> >  sdp->cpu =3D cpu;
> >  INIT_WORK(&sdp->work, srcu_invoke_callbacks);
> >  timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> > + /*
> > + * ->defer_cbs and ->defer_link are valid when zeroed and are not
> > + * reinitialized here, lest we clobber callbacks a reentrant
> > + * call_srcu() already staged. See __call_srcu().
> > + */
> >  sdp->ssp =3D ssp;
> >  }
> >  }
> > @@ -697,6 +743,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> >  return; /* Just leak it! */
> >  /* Wait for irq_work to finish first as it may queue a new work. */
> >  irq_work_sync(&sup->irq_work);
> > + /* Drain any deferred callbacks (shared irq_work) before freeing ->sd=
a. */
> > + srcu_defer_flush();
>
> 1. Should we move srcu_defer_flush() before irq_work_sync(&sup->irq_work)=
 ?

Will fix it in next version.

>
> 2. Will the following scenario trigger soft/hard_lockup ?
>
>     In irq_work context, irq disbaled:
>     srcu_defer_drain
>     ->srcu_do_enqueue
>       ->srcu_gp_start_if_needed
>         ->rcu_segcblist_enqueue
>           fentry ebpf prog
>              call_rcu_tasks_trace()
>              ->__call_srcu()
>                ->should_rcu_defer() =3D true
>                  ->llist_add() + irq_work_queue()
>                    the ipi send and irq_work run again -> srcu_defer_drai=
n()->srcu_do_enqueue
>
> Did I miss something?

BPF programs don't allow recursion on the same CPU for the same BPF
program, but your scenario can still occur because here the BPF
program doesn't recurse rather it keeps enqueueing and firing IPIs.
Before this patch it would have been a deadlock.

So, this is expected behaviour and to fix it we have following options:

1. Make stuff under call_srcu() notrace or keep the normal enqueue
traceable (so the outer reentry still happens once and the deadlock
fix is still exercised), but have srcu_defer_drain() re-issue through
a notrace copy of the enqueue chain so the prog can't fire during
  the drain.
2. Accept it and document it, and correct BPF programs like the
selftest in last patch will work because they detect reently.
3. Have a per-cpu in-drain flag set in srcu_defer_drain() and if in
call_srcu should_rcu_defer() returns true and this flag is set +
in_nmi() returns false, this means we are in this refeeding loop, so
we can just leak that callback with a warning.

I prefer option 3 but let's wait for Paul for his feedback.

Thanks,
Puranjay
