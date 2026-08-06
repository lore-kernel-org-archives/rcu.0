Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7E3B6C19;
	Thu,  6 Aug 2026 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025082; cv=none; b=CIhBb+BqrSwlGca4lpqFKMqFWcy02VvAT3L4s0xA3lsTcxGmusYHXdz36+NabkFKrhkJMlEgYlPHEy06lu3pca/sETmx3fhaXuveGXY0SugUmpsUc+nbW+rEx7zLgET52ktPjTB0A/0PY7DI6Lw55505OnnT47Je9F/k5mlVDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025082; c=relaxed/simple;
	bh=nYFhLgx06bARm7n2DwZI9J/FXuLZglWh1tT9QZB3JRo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=oQGuOLo1JcuwSaeWDtogZLlHtlJmrQF6RjUcZgnTzvZAnnGxOOFplmnF1cCoDM84ExtG7dq5Oj56UaHOxpuRIGroWniECEFIqcuyf+iHNuT6RVsxNWuGlV6zF8qOOkcoqdqwzeYcLC0vlIn4Il/4PxQDIplmDpYCBkP/w7KIxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LneReIoM; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LneReIoM"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786025061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtguJMYJ6hwNQzhjGD4uCYRJY5p3LxKf0KoesX0k4qE=;
	b=LneReIoMmV1i7OqWCNVH2V1+VkkgtSKsnD7/Tbg17jy8kiKIsCTgm1a4hD7CmSe8WA4pxt
	n4Kh000V+ifMSpV/WNfkLiMBseebrqE9kbPEQGndfixEi89yLZ9rHRy0mhNXRoXQKmKzP3
	S+s/dvKC8c/ANUEhGy79Lx6FejsyWXg=
Date: Thu, 06 Aug 2026 14:04:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <5421cedd8d7372ed4b89836ac19a975226346364@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3 3/6] srcu: Make call_srcu() safe to call from any
 context
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
In-Reply-To: <20260805122346.269445-4-puranjay@kernel.org>
References: <20260805122346.269445-1-puranjay@kernel.org>
 <20260805122346.269445-4-puranjay@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20call_srcu() has the same constraint as call_rcu(): its callback list =
and
> locks are only touched with interrupts disabled. srcu_gp_start_if_neede=
d()
> enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree,=
 as
> do callback invocation and grace-period work. A call_srcu() with
> interrupts disabled can race a list operation in flight on this CPU and
> corrupt the list or deadlock. call_rcu_tasks_trace() is call_srcu() und=
er
> the hood, so a sleepable BPF program freeing an object can reach this.
>=20
>=20Defer as call_rcu() does: stage the callback on the srcu_data's
> ->defer_cbs, chain that srcu_data onto a per-CPU list, and raise a per-=
CPU
> irq_work that re-issues it straight to the enqueue helper, never back
> through __call_srcu(). The common path is unchanged and keeps interrupt=
s
> enabled across srcu_gp_start_if_needed().
>=20
>=20The irq_work is per-CPU rather than per-srcu_struct and statically
> initialized, so deferral never runs check_init_srcu_struct(); it is
> IRQ_WORK_INIT_HARD as for call_rcu(). srcu_barrier() and
> cleanup_srcu_struct() flush it first, and rcutree_migrate_callbacks()
> calls srcu_offline_drain() for an outgoing CPU. ->lock is held across t=
he
> drain so the drainers serialize.
>=20
>=20As in call_rcu(), the re-issue runs with interrupts disabled and can =
be
> re-entered by instrumentation, so a flag on the srcu_data being drained
> drops a deferring call_srcu() seen mid-drain (unless from an NMI). Stag=
ing
> records only the callback, so an expedited request is remembered per
> srcu_data in ->defer_exp and the whole batch is re-issued expedited rat=
her
> than silently downgraded to a normal grace period. A dropped callback c=
an
> also strand state its caller associated with it, not just the callback
> itself.
>=20
>=20Gated by CONFIG_RCU_DEFER. Under CONFIG_PROVE_RCU, warn if the direct
> path is reached from an NMI.
>=20
>=20Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/srcutree.h | 5 ++
>  kernel/rcu/rcu.h | 3 +
>  kernel/rcu/srcutree.c | 171 ++++++++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree.c | 2 +
>  4 files changed, 177 insertions(+), 4 deletions(-)
>=20
>=20diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 75e54e4f963fa..09a9c8f4a6d24 100644
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
> @@ -41,6 +43,9 @@ struct srcu_data {
>  bool srcu_cblist_invoking; /* Invoking these CBs? */
>  struct timer_list delay_work; /* Delay for CB invoking */
>  struct work_struct work; /* Context for CB invoking. */
> + struct llist_head defer_cbs; /* Callbacks deferred on re-entry. */
> + struct llist_node defer_link; /* Links onto the per-CPU deferral drai=
n list */
> + bool defer_exp; /* A deferred callback asked to expedite. */
>  struct rcu_head srcu_barrier_head; /* For srcu_barrier() use. */
>  struct rcu_head srcu_ec_head; /* For srcu_expedite_current() use. */
>  int srcu_ec_state; /* State for srcu_expedite_current(). */
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index fd075d91b80cf..84d74cd5a351c 100644
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
> index 304112674e8a2..35fface51d50b 100644
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
> @@ -79,6 +80,45 @@ static void process_srcu(struct work_struct *work);
>  static void srcu_irq_work(struct irq_work *work);
>  static void srcu_delay_timer(struct timer_list *t);
>=20=20
>=20+struct srcu_defer;
> +static void srcu_defer_drain(struct irq_work *iw);
> +static void __srcu_defer_drain(struct srcu_defer *sndp, bool guard);
> +
> +/*
> + * Per-CPU call_srcu() deferral state, shared by every srcu_struct. A =
deferred
> + * callback is staged on its srcu_data's ->defer_cbs; that srcu_data i=
s chained
> + * via ->defer_link onto ->list, which the irq_work walks.
> + */
> +struct srcu_defer {
> + struct llist_head list;
> + struct irq_work iw;
> + raw_spinlock_t lock;
> + bool draining;
> +};
> +
> +static DEFINE_PER_CPU(struct srcu_defer, srcu_defer) =3D {
> + .lock =3D __RAW_SPIN_LOCK_UNLOCKED(srcu_defer.lock),
> + .iw =3D IRQ_WORK_INIT_HARD(srcu_defer_drain),
> +};
> +
> +/*
> + * Flush pending deferred callbacks so a following srcu_barrier() wait=
s for them.
> + */
> +static void srcu_defer_flush(void)
> +{
> + int cpu;
> +
> + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> + return;
> +
> + for_each_possible_cpu(cpu) {
> + struct srcu_defer *sndp =3D &per_cpu(srcu_defer, cpu);
> +
> + if (!llist_empty(&sndp->list))
> + __srcu_defer_drain(sndp, false);
> + }
> +}
> +
>  /*
>  * Initialize SRCU per-CPU data. Note that statically allocated
>  * srcu_struct structures might already have srcu_read_lock() and
> @@ -107,6 +147,11 @@ static void init_srcu_struct_data(struct srcu_stru=
ct *ssp)
>  sdp->cpu =3D cpu;
>  INIT_WORK(&sdp->work, srcu_invoke_callbacks);
>  timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> + /*
> + * ->defer_cbs, ->defer_link and ->defer_exp are valid when zeroed
> + * and are not reinitialized here, lest we clobber callbacks a
> + * reentrant call_srcu() already staged. See __call_srcu().
> + */
>  sdp->ssp =3D ssp;
>  }
>  }
> @@ -695,7 +740,12 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  return; /* Just leak it! */
>  if (WARN_ON(srcu_readers_active(ssp)))
>  return; /* Just leak it! */
> - /* Wait for irq_work to finish first as it may queue a new work. */
> + /*
> + * Drain deferred callbacks before syncing ->irq_work: re-issuing one =
can
> + * start a grace period and re-queue ->irq_work, which then schedules
> + * ->work, so both must be waited out after the drain.
> + */
> + srcu_defer_flush();
>  irq_work_sync(&sup->irq_work);
>  flush_delayed_work(&sup->work);
>  for_each_possible_cpu(cpu) {
> @@ -1410,8 +1460,8 @@ static unsigned long srcu_gp_start_if_needed(stru=
ct srcu_struct *ssp,
>  * srcu_read_lock(), and srcu_read_unlock() that are all passed the sam=
e
>  * srcu_struct structure.
>  */
> -static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> - rcu_callback_t func, bool do_norm)
> +static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *=
rhp,
> + rcu_callback_t func, bool do_norm)
>  {
>  if (debug_rcu_head_queue(rhp)) {
>  /* Probable double call_srcu(), so leak the callback. */
> @@ -1423,6 +1473,111 @@ static void __call_srcu(struct srcu_struct *ssp=
, struct rcu_head *rhp,
>  (void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
>  }
>=20=20
>=20+/*
> + * The srcu_cblist and srcu_node tree are only accessed with interrupt=
s disabled
> + * (srcu_gp_start_if_needed() enqueues under raw_spin_lock_irqsave() a=
nd may walk
> + * the tree). Like call_rcu(), __call_srcu() defers when interrupts ar=
e already
> + * disabled, so a re-entrant call_srcu() -- e.g. call_rcu_tasks_trace(=
) from a
> + * BPF program -- cannot corrupt the list or deadlock.
> + */
> +static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> + rcu_callback_t func, bool do_norm)
> +{
> + if (should_rcu_defer()) {
> + struct srcu_defer *sndp =3D this_cpu_ptr(&srcu_defer);
> + struct srcu_data *sdp;
> +
> + /*
> + * Instrumentation on the enqueue path can re-enter here from
> + * inside srcu_defer_drain(). Re-queuing would livelock the
> + * drain, so drop the callback; an NMI cannot loop, so let it in.
> + */
> + if (READ_ONCE(sndp->draining) && !in_nmi()) {
> + WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> + "call_srcu() re-entered during callback drain; leaking callback\n");
> + return;
> + }
> + sdp =3D this_cpu_ptr(ssp->sda);
> + rhp->func =3D func;
> + if (!do_norm)
> + WRITE_ONCE(sdp->defer_exp, true);
> + if (llist_add((struct llist_node *)rhp, &sdp->defer_cbs)) {
> + /*
> + * Chain this srcu_data for the drain. ->ssp must be
> + * published here: deferral skips check_init_srcu_struct(),
> + * so on a never-initialized static srcu_struct the
> + * statically zeroed ->sda still has a NULL ->ssp.
> + */
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
> + * Re-issue deferred callbacks straight to srcu_do_enqueue() so they c=
annot defer
> + * again. ->lock serializes the drainers: the irq_work, srcu_defer_flu=
sh() and
> + * srcu_offline_drain().
> + */
> +static void __srcu_defer_drain(struct srcu_defer *sndp, bool guard)
> +{
> + struct llist_node *snode, *snext;
> + unsigned long flags;
> +
> + raw_spin_lock_irqsave(&sndp->lock, flags);
> + if (guard)
> + WRITE_ONCE(sndp->draining, true);
> + llist_for_each_safe(snode, snext, llist_del_all(&sndp->list)) {
> + struct srcu_data *sdp =3D container_of(snode, struct srcu_data, defer=
_link);
> + struct srcu_struct *ssp =3D sdp->ssp;
> + struct llist_node *cnode, *cnext;
> + bool do_norm;
> +
> + cnode =3D llist_del_all(&sdp->defer_cbs);
> + do_norm =3D !READ_ONCE(sdp->defer_exp);
> + if (!do_norm)
> + WRITE_ONCE(sdp->defer_exp, false);
> + llist_for_each_safe(cnode, cnext, cnode) {
> + struct rcu_head *rhp =3D (struct rcu_head *)cnode;
> +
> + rhp->next =3D NULL;
> + srcu_do_enqueue(ssp, rhp, rhp->func, do_norm);
> + }
> + }
> + if (guard)
> + WRITE_ONCE(sndp->draining, false);
> + raw_spin_unlock_irqrestore(&sndp->lock, flags);
> +}
> +
> +/*
> + * Only the irq_work drain can be re-fed by its own re-issue, so only =
it sets
> + * ->draining. A direct drain re-issues onto this CPU, and anything st=
aged
> + * during it is picked up by that CPU's own irq_work.
> + */
> +static void srcu_defer_drain(struct irq_work *iw)
> +{
> + __srcu_defer_drain(container_of(iw, struct srcu_defer, iw), true);
> +}
> +
> +/*
> + * Drain @cpu's deferred call_srcu() callbacks from rcutree_migrate_ca=
llbacks()
> + * once @cpu is dead. One pass covers every srcu_struct, and the re-is=
sue lands
> + * on the current CPU.
> + */
> +void srcu_offline_drain(int cpu)
> +{
> + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> + return;
> + __srcu_defer_drain(&per_cpu(srcu_defer, cpu), false);
> +}
> +
>  /**
>  * call_srcu() - Queue a callback for invocation after an SRCU grace pe=
riod
>  * @ssp: srcu_struct in queue the callback
> @@ -1677,9 +1832,17 @@ void srcu_barrier(struct srcu_struct *ssp)
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

If there are two ssp1 and ssp2 concurrent call srcu_barrier(),
and assuming there are only two CPUs, CPU0->sndp0 and CPU1->sndp1.


srcu_barrier(&ssp1)
->srcu_defer_flush()
  ->llist_empty(&sndp0->list) is not empty
  ->__srcu_defer_drain(sndp0)
    ->raw_spinlock()
    ->llist_for_each_safe(llist_del_all(&sndp0->list))=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
=20                                                                      =
srcu_barrier(&ssp2)
                                                                       ->=
srcu_defer_flush()
                                                                         =
 ->llist_empty(&sndp0->list) is empty
                                                                        .=
..
                                                                       ->=
srcu_barrier_one_cpu()
                                                                         =
 ->sdp0 =3D per_cpu_ptr(ssp2->sda, 0)
                                                                         =
 ->rcu_segcblist_entrain(&sdp0->srcu_cblist, ...)=20
=20                                                                      =
     //the sdp0->srcu_cblist is empty, return false.
                                                                        r=
eturn;

     ->srcu_do_enqueue(ssp2, rhp, rhp->func, do_norm);
       // the srcu_barrier(&ssp2) has already return,
       // miss waiting to current queue ssp2's callback
       // to complete.
=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20

=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
Thanks
Zqiang



>=20+
> + s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_barrier_seq);
>  mutex_lock(&ssp->srcu_sup->srcu_barrier_mutex);
>  if (rcu_seq_done(&ssp->srcu_sup->srcu_barrier_seq, s)) {
>  smp_mb(); /* Force ordering following return. */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6a83408974c2b..227790a87b02f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4646,6 +4646,8 @@ void rcutree_migrate_callbacks(int cpu)
>  * returns; the re-issue lands on this CPU.
>  */
>  __rcu_defer_drain(rdp, false);
> + /* Likewise for the outgoing CPU's deferred call_srcu() callbacks. */
> + srcu_offline_drain(cpu);
>=20=20
>=20 if (rcu_rdp_is_offloaded(rdp))
>  return;
> --=20
>=202.53.0-Meta
>
