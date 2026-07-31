Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532242FCD0
	for <rcu@vger.kernel.org>; Fri, 31 Jul 2026 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503008; cv=none; b=Ezg75HKBL9wu06C9mds0aup8r9kyPb9X7PFkbhRNSnPA9V3nlT3ZCxyA0+40H9ZPqgYWgF9+Qdl+vgPoJ0/X4uSm5fmwEPb3tvfwRdaj5g178HrbejmHvX8/1zJzfB9cjz2AdbY3uBMR0QSLQc+gpIpxawYZSgKDIa1WlnWP2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503008; c=relaxed/simple;
	bh=49H4hc6po78A3zMcH1D5/y3LMwzKbp4z6Oq+2QIDtz4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HyW4F4oiGWmWZVKHKBrI2T61WaYYoEqXGBkgyA4WD59k/5+DYRu5kP+Ye4+9gf9YcfIAVabFeiotWq+u/FfY8ypHyVSdBlJBjuOFENcBo4wlse3mgl9bKJuMMsQYla4skT1I8KPH5KWtDRSc8WggJBgKqjHPi6g5to+UV6d7J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTsZNXbo; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTsZNXbo"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785502993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+ZXA6LBN6fxmZC6fUqwcD6rxFRvoGNYEagaRyOxc74=;
	b=jTsZNXbopyUF3v5jPCBAR07culpzBKe/1LYRnUaAabxs50YZvxz0loPCfGbOuWbU1fD+Ro
	IbjT8x20457oYPRezbm5zWIC1OudDAK07uZlkzIpo9/4tnkLlv25TT6Sbt1PyKKHlmoApV
	O0G2mROfFmSMTs6/hgQW4Frec8WhBsg=
Date: Fri, 31 Jul 2026 13:03:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <96a07fd8d37018b005de85a0eac6045fa426e892@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 3/6] srcu: Make call_srcu() safe to call from any context
To: "Puranjay Mohan" <puranjay@kernel.org>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Josh
 Triplett" <josh@joshtriplett.org>, "=?utf-8?B?T251ciDDlnprYW4=?="
 <work@onurozkan.dev>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Davidlohr Bueso" <dave@stgolabs.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Matt Fleming"
 <mfleming@cloudflare.com>, "Harry Yoo (Oracle)" <harry@kernel.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
In-Reply-To: <20260729162207.1567770-4-puranjay@kernel.org>
References: <20260729162207.1567770-1-puranjay@kernel.org>
 <20260729162207.1567770-4-puranjay@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20call_srcu() has the same constraint as call_rcu(): its callback list =
and
> locks are only touched with interrupts disabled. srcu_gp_start_if_neede=
d()
> enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree,
> and callback invocation and grace-period work do likewise. So a
> call_srcu() with interrupts disabled may be racing a list operation in
> flight on this CPU, and enqueuing directly could corrupt the list or
> deadlock.
>=20
>=20Defer as call_rcu() does: stage the callback on the srcu_data's
> ->defer_cbs, chain that srcu_data onto a per-CPU list, and kick a per-C=
PU
> irq_work that re-issues it straight to the enqueue helper -- never back
> through __call_srcu(), so it cannot defer again.
>=20
>=20The irq_work is global (per CPU, not per srcu_struct) and statically
> initialized, so the deferral never runs check_init_srcu_struct(). It is
> IRQ_WORK_INIT_HARD to re-issue promptly, as for call_rcu(). srcu_barrie=
r()
> and cleanup_srcu_struct() flush it first, and rcutree_migrate_callbacks=
()
> calls srcu_offline_drain() to drain an outgoing CPU's deferred callback=
s.
> Gated by CONFIG_RCU_DEFER, as for call_rcu().
>=20
>=20Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/srcutree.h | 4 ++
>  kernel/rcu/rcu.h | 3 +
>  kernel/rcu/srcutree.c | 138 ++++++++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree.c | 2 +
>  4 files changed, 144 insertions(+), 3 deletions(-)
>=20
>=20diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 75e54e4f963fa..1ce759fb70948 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -13,6 +13,8 @@
>=20=20
>=20 #include <linux/rcu_node_tree.h>
>  #include <linux/completion.h>
> +#include <linux/irq_work_types.h>
> +#include <linux/llist.h>
>=20=20
>=20 struct srcu_node;
>  struct srcu_struct;
> @@ -41,6 +43,8 @@ struct srcu_data {
>  bool srcu_cblist_invoking; /* Invoking these CBs? */
>  struct timer_list delay_work; /* Delay for CB invoking */
>  struct work_struct work; /* Context for CB invoking. */
> + struct llist_head defer_cbs; /* Callbacks deferred on re-entry. */
> + struct llist_node defer_link; /* Links onto the per-CPU deferral drai=
n list */
>  struct rcu_head srcu_barrier_head; /* For srcu_barrier() use. */
>  struct rcu_head srcu_ec_head; /* For srcu_expedite_current() use. */
>  int srcu_ec_state; /* State for srcu_expedite_current(). */
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index ed6604445f2ac..036d28516e92d 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -587,6 +587,9 @@ static inline bool should_rcu_defer(void)
>  return irqs_disabled() && rcu_scheduler_active !=3D RCU_SCHEDULER_INAC=
TIVE;
>  }
>=20=20
>=20+/* Drain an outgoing CPU's deferred SRCU callbacks; see rcutree_migr=
ate_callbacks(). */
> +void srcu_offline_drain(int cpu);
> +
>  enum rcutorture_type {
>  RCU_FLAVOR,
>  RCU_TASKS_FLAVOR,
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 304112674e8a2..b9fe57ff91000 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -20,6 +20,7 @@
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
>  #include <linux/irq_work.h>
> +#include <linux/llist.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/sched.h>
>  #include <linux/smp.h>
> @@ -79,6 +80,46 @@ static void process_srcu(struct work_struct *work);
>  static void srcu_irq_work(struct irq_work *work);
>  static void srcu_delay_timer(struct timer_list *t);
>=20=20
>=20+static void srcu_defer_drain(struct irq_work *iw);
> +
> +/*
> + * Per-CPU call_srcu() deferral state. The irq_work is global (shared =
by every
> + * srcu_struct), so it must find which srcu_structs deferred callbacks=
: a
> + * callback is staged on its srcu_data's ->defer_cbs, and that srcu_da=
ta is
> + * chained (->defer_link) onto this per-CPU ->list that the irq_work w=
alks.
> + */
> +struct srcu_defer {
> + struct llist_head list;
> + struct irq_work iw;
> + raw_spinlock_t lock;
> +};
> +
> +static DEFINE_PER_CPU(struct srcu_defer, srcu_defer) =3D {
> + .lock =3D __RAW_SPIN_LOCK_UNLOCKED(srcu_defer.lock),
> + .iw =3D IRQ_WORK_INIT_HARD(srcu_defer_drain),
> +};
> +
> +/*
> + * Register pending deferred call_srcu() callbacks so a following srcu=
_barrier()
> + * waits for them. An online CPU's own irq_work re-issues its callback=
s, so wait
> + * it out; an offline CPU's irq_work may never run again, so drain its=
 list
> + * directly onto this CPU instead.
> + */
> +static void srcu_defer_flush(void)
> +{
> + int cpu;
> +
> + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> + return;
> +
> + for_each_possible_cpu(cpu) {
> + if (cpu_online(cpu))
> + irq_work_sync(&per_cpu(srcu_defer, cpu).iw);
> + else
> + srcu_defer_drain(&per_cpu(srcu_defer, cpu).iw);
> + }
> +}
> +
>  /*
>  * Initialize SRCU per-CPU data. Note that statically allocated
>  * srcu_struct structures might already have srcu_read_lock() and
> @@ -107,6 +148,11 @@ static void init_srcu_struct_data(struct srcu_stru=
ct *ssp)
>  sdp->cpu =3D cpu;
>  INIT_WORK(&sdp->work, srcu_invoke_callbacks);
>  timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> + /*
> + * ->defer_cbs and ->defer_link are valid when zeroed and are not
> + * reinitialized here, lest we clobber callbacks a reentrant
> + * call_srcu() already staged. See __call_srcu().
> + */
>  sdp->ssp =3D ssp;
>  }
>  }
> @@ -697,6 +743,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  return; /* Just leak it! */
>  /* Wait for irq_work to finish first as it may queue a new work. */
>  irq_work_sync(&sup->irq_work);
> + /* Drain any deferred callbacks (shared irq_work) before freeing ->sd=
a. */
> + srcu_defer_flush();

1. Should we move srcu_defer_flush() before irq_work_sync(&sup->irq_work)=
 ?

2. Will the following scenario trigger soft/hard_lockup ?
=20=20=20=20=20=20=20
=20   In irq_work context, irq disbaled:
    srcu_defer_drain
    ->srcu_do_enqueue
      ->srcu_gp_start_if_needed
        ->rcu_segcblist_enqueue
          fentry ebpf prog
             call_rcu_tasks_trace()
             ->__call_srcu()
               ->should_rcu_defer() =3D true
                 ->llist_add() + irq_work_queue()=20
=20                  the ipi send and irq_work run again -> srcu_defer_dr=
ain()->srcu_do_enqueue
=20
Did=20I miss something?

Thanks
Zqiang


>  flush_delayed_work(&sup->work);
>  for_each_possible_cpu(cpu) {
>  struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
> @@ -1410,8 +1458,18 @@ static unsigned long srcu_gp_start_if_needed(str=
uct srcu_struct *ssp,
>  * srcu_read_lock(), and srcu_read_unlock() that are all passed the sam=
e
>  * srcu_struct structure.
>  */
> -static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> - rcu_callback_t func, bool do_norm)
> +/*
> + * The srcu_cblist and the srcu_node tree are only ever accessed with =
interrupts
> + * disabled (srcu_gp_start_if_needed() enqueues under raw_spin_lock_ir=
qsave() and
> + * may walk the tree; callback invocation and grace-period work likewi=
se). So
> + * like call_rcu(), enqueuing while a list operation is in flight on t=
his CPU
> + * would corrupt it or deadlock -- e.g. call_rcu_tasks_trace(), which =
is
> + * call_srcu() on a dedicated srcu_struct, from a BPF program. __call_=
srcu()
> + * defers whenever interrupts are disabled, via a per-CPU irq_work; on=
ly kernels
> + * where that can happen (CONFIG_RCU_DEFER) need this.
> + */
> +static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *=
rhp,
> + rcu_callback_t func, bool do_norm)
>  {
>  if (debug_rcu_head_queue(rhp)) {
>  /* Probable double call_srcu(), so leak the callback. */
> @@ -1423,6 +1481,72 @@ static void __call_srcu(struct srcu_struct *ssp,=
 struct rcu_head *rhp,
>  (void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
>  }
>=20=20
>=20+static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rh=
p,
> + rcu_callback_t func, bool do_norm)
> +{
> + if (should_rcu_defer()) {
> + struct srcu_data *sdp =3D this_cpu_ptr(ssp->sda);
> +
> + rhp->func =3D func;
> + if (llist_add((struct llist_node *)rhp,=20&sdp->defer_cbs)) {
> + /* First deferral on this srcu_data: chain it for the drain. */
> + struct srcu_defer *sndp =3D this_cpu_ptr(&srcu_defer);
> +
> + sdp->ssp =3D ssp;
> + if (llist_add(&sdp->defer_link, &sndp->list))
> + irq_work_queue(&sndp->iw);
> + }
> + return;
> + }
> +
> + /* An NMI reaching here entered with irqs enabled, so the enqueue can=
 race. */
> + WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
> +
> + srcu_do_enqueue(ssp, rhp, func, do_norm);
> +}
> +
> +/*
> + * Re-issue this CPU's deferred callbacks, going straight to srcu_do_e=
nqueue() so
> + * they cannot defer again. The irq_work walks its ->list of srcu_data=
, each
> + * carrying its own ->defer_cbs. ->lock is held across the drain so dr=
ainers
> + * (irq_work, srcu_defer_flush() and srcu_offline_drain()) serialize a=
nd never
> + * leave a callback off the lists yet not on a callback list.
> + */
> +static void srcu_defer_drain(struct irq_work *iw)
> +{
> + struct srcu_defer *sndp =3D container_of(iw, struct srcu_defer, iw);
> + struct llist_node *snode, *snext;
> + unsigned long flags;
> +
> + raw_spin_lock_irqsave(&sndp->lock, flags);
> + llist_for_each_safe(snode, snext, llist_del_all(&sndp->list)) {
> + struct srcu_data *sdp =3D container_of(snode, struct srcu_data, defer=
_link);
> + struct srcu_struct *ssp =3D sdp->ssp;
> + struct llist_node *cnode, *cnext;
> +
> + cnode =3D llist_del_all(&sdp->defer_cbs);
> + llist_for_each_safe(cnode, cnext, cnode) {
> + struct rcu_head *rhp =3D (struct rcu_head *)cnode;
> +
> + srcu_do_enqueue(ssp, rhp, rhp->func, true);
> + }
> + }
> + raw_spin_unlock_irqrestore(&sndp->lock, flags);
> +}
> +
> +/*
> + * Drain @cpu's deferred call_srcu() callbacks; called from
> + * rcutree_migrate_callbacks() once @cpu is dead. One pass covers ever=
y
> + * srcu_struct, as the per-CPU srcu_defer list chains them all, and th=
e
> + * re-issue lands on the current CPU's srcu_data.
> + */
> +void srcu_offline_drain(int cpu)
> +{
> + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> + return;
> + srcu_defer_drain(&per_cpu(srcu_defer, cpu).iw);
> +}
> +
>  /**
>  * call_srcu() - Queue a callback for invocation after an SRCU grace pe=
riod
>  * @ssp: srcu_struct in queue the callback
> @@ -1677,9 +1801,17 @@ void srcu_barrier(struct srcu_struct *ssp)
>  {
>  int cpu;
>  int idx;
> - unsigned long s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_barrier_seq);
> + unsigned long s;
>=20=20
>=20 check_init_srcu_struct(ssp);
> +
> + /*
> + * Register any deferred callbacks before snapshotting the sequence. T=
he
> + * shared irq_work may also drain other srcu_structs', which is harmle=
ss.
> + */
> + srcu_defer_flush();
> +
> + s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_barrier_seq);
>  mutex_lock(&ssp->srcu_sup->srcu_barrier_mutex);
>  if (rcu_seq_done(&ssp->srcu_sup->srcu_barrier_seq, s)) {
>  smp_mb(); /* Force ordering following return. */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 93c4242345e67..f8c6930041746 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4627,6 +4627,8 @@ void rcutree_migrate_callbacks(int cpu)
>  * returns; the re-issue lands on this CPU.
>  */
>  rcu_defer_drain(&rdp->defer_work);
> + /* Likewise for the outgoing CPU's deferred call_srcu() callbacks. */
> + srcu_offline_drain(cpu);
>=20=20
>=20 if (rcu_rdp_is_offloaded(rdp))
>  return;
> --=20
>=202.53.0-Meta
>
