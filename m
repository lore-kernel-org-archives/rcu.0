Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A5426405
	for <rcu@vger.kernel.org>; Thu, 30 Jul 2026 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414077; cv=none; b=XbZX3FvyYzNwY8faC1jOMuVZqSr9WavuaqqaTWFV//GKUL1dALYmF7xin6gu5OGLRyMfJc6v0Cuw/luI46jjucTtoUiNC0jWPG9i2xkd/dmb8oKK3LwGzpvXxGCvXRZ8mvnPRmX+E2A9bxO2d25h1nEwZ5ZyKCCddCJPwZxRNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414077; c=relaxed/simple;
	bh=3OtBGzLq7Au7XDBeKqSZoTUK2lm2G+CF/9yGoi3k0Nk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dP5Dcba5VgfB0yMdkLeXXxbSrMpqlemDc72G4YUeuXAhqpeK7tuevMq7hwnD6QDFN0CJZxnaaZ7ldf7XWngbGZeQ0+y3MT+yF+a5WQH1qb1/EQkJgeOZU4YLVuDCv+bj+kbtoEtLmStqgsEeY5IdtaW8bIHahQrt6jMf2Qkvfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J2yJ1kN2; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J2yJ1kN2"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785414063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdnV+STjCcSFt0BxaFxswBZ1saTn5xSv0HRk7NgUSHY=;
	b=J2yJ1kN2oB1AwwC0vP8Ikzpe5fOkExoHpjONKCs6QSNUMrKTvJEUWZNw1CDdAOfQNqxSu8
	MSUupQ/2t3g/aqs6fvjUui7S31aJTV0JS8oJg0ASAnV2sf+pFO+GaVVnnEE4jxJr1Xpp/U
	QtUxIDgj4KY0H8qSozDxIlXq4PF3XWU=
Date: Thu, 30 Jul 2026 12:20:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <6ad0805c551a62283dca666fbace7302e2236e3a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/6] rcu: Make call_rcu() safe to call from any context
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
In-Reply-To: <20260729162207.1567770-2-puranjay@kernel.org>
References: <20260729162207.1567770-1-puranjay@kernel.org>
 <20260729162207.1567770-2-puranjay@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20call_rcu() touches its per-CPU callback list only with interrupts
> disabled: the enqueue runs under local_irq_save() (plus the nocb locks
> when offloaded), as do callback invocation and grace-period work. A
> call_rcu() that arrives with interrupts already disabled may be
> interrupting one of those, so enqueuing directly could corrupt the list
> or deadlock -- as an NMI or re-entrant instrumentation can.
>=20
>=20Defer in that case: stage the callback on a per-CPU llist and kick an
> irq_work that re-issues it once interrupts are back on, going straight =
to
> the enqueue so it cannot defer again. Callers that merely hold interrup=
ts
> off are deferred too, which is harmless. Skip the gate while the
> scheduler is down (RCU_SCHEDULER_INACTIVE): irq_work is not usable unti=
l
> init_IRQ(), yet rcu_init() already calls call_rcu().
>=20
>=20rcu_barrier() flushes pending deferred callbacks first: it waits out =
each
> online CPU's irq_work and drains an offline CPU's list directly, as tha=
t
> irq_work may never run again. rcutree_migrate_callbacks() also drains a=
n
> outgoing CPU's ->defer_head, so a callback deferred late in the offline
> path runs even without an rcu_barrier(). The irq_work is
> IRQ_WORK_INIT_HARD so the re-issue runs promptly and callbacks do not b=
ack
> up; on PREEMPT_RT a non-HARD irq_work would run in a kthread that can b=
e
> delayed under load. A new hidden CONFIG_RCU_DEFER gates the code and th=
e
> IRQ_WORK dependency; without it call_rcu() enqueues directly as before.
>=20
>=20Under CONFIG_PROVE_RCU, warn if the direct path is reached from NMI, =
which
> would mean interrupts were enabled on NMI entry.
>=20
>=20Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/rcu/Kconfig | 6 +++
>  kernel/rcu/rcu.h | 15 ++++++
>  kernel/rcu/tree.c | 120 +++++++++++++++++++++++++++++++++++++++++----
>  kernel/rcu/tree.h | 5 ++
>  4 files changed, 136 insertions(+), 10 deletions(-)
>=20
>=20diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index f15da8038d0ba..1a5fb3156c062 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -175,6 +175,12 @@ config RCU_STALL_COMMON
>  config RCU_NEED_SEGCBLIST
>  def_bool ( TREE_RCU || TREE_SRCU || TASKS_RCU_GENERIC )
>=20=20
>=20+# The deferral (and the IRQ_WORK it uses) is only needed where call_=
rcu() /
> +# call_srcu() can be invoked while a callback-list operation is in fli=
ght.
> +config RCU_DEFER
> + def_bool HAVE_NMI || KPROBES || FUNCTION_TRACER || TRACEPOINTS
> + select IRQ_WORK
> +
>  config RCU_FANOUT
>  int "Tree-based hierarchical RCU fanout value"
>  range 2 64 if 64BIT
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 39a9f6fa9a7b2..ed6604445f2ac 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -572,6 +572,21 @@ static inline void tasks_cblist_init_generic(void)=
 { }
>  #define RCU_SCHEDULER_INIT 1
>  #define RCU_SCHEDULER_RUNNING 2
>=20=20
>=20+/*
> + * Should a call_rcu()/call_srcu() callback be deferred rather than en=
queued
> + * now? Defer whenever interrupts are disabled: a callback-list operat=
ion may
> + * be in flight on this CPU, so enqueuing now could corrupt it. But no=
t while
> + * the scheduler is down -- early boot is single-threaded and can call=
 this
> + * before init_IRQ() makes irq_work usable (e.g. rcu_init()'s self-tes=
ts).
> + */
> +static inline bool should_rcu_defer(void)
> +{
> + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> + return false;
> +
> + return irqs_disabled() && rcu_scheduler_active !=3D RCU_SCHEDULER_INA=
CTIVE;
> +}
> +
>  enum rcutorture_type {
>  RCU_FLAVOR,
>  RCU_TASKS_FLAVOR,
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 21b6ce1dffb63..93c4242345e67 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -24,6 +24,7 @@
>  #include <linux/smp.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/interrupt.h>
> +#include <linux/llist.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/nmi.h>
> @@ -3148,21 +3149,27 @@ static void check_cb_ovld(struct rcu_data *rdp)
>  raw_spin_unlock_rcu_node(rnp);
>  }
>=20=20
>=20-static void
> -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool laz=
y_in)
> +/*
> + * The callback list is only ever accessed with interrupts disabled (e=
nqueue,
> + * callback invocation, grace-period work). A call_rcu() with interrup=
ts already
> + * disabled may interrupt one of those, so __call_rcu_common() defers:=
 the
> + * callback is staged on a per-CPU llist that an irq_work re-issues on=
ce
> + * interrupts are on. Only CONFIG_RCU_DEFER kernels can hit this.
> + */
> +static void rcu_defer_drain(struct irq_work *iw);
> +
> +/*
> + * Enqueue @head on this CPU's rcu_segcblist. Also called by rcu_defer=
_drain()
> + * to re-issue a deferred callback, so it must not re-check the deferr=
al
> + * condition. Either caller may have interrupts already disabled.
> + */
> +static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func,=
 bool lazy_in)
>  {
>  static atomic_t doublefrees;
>  unsigned long flags;
>  bool lazy;
>  struct rcu_data *rdp;
>=20=20
>=20- /* Misaligned rcu_head! */
> - WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> -
> - /* Avoid NULL dereference if callback is NULL. */
> - if (WARN_ON_ONCE(!func))
> - return;
> -
>  if (debug_rcu_head_queue(head)) {
>  /*
>  * Probable double call_rcu(), so leak the callback.
> @@ -3206,6 +3213,83 @@ __call_rcu_common(struct rcu_head *head, rcu_cal=
lback_t func, bool lazy_in)
>  local_irq_restore(flags);
>  }
>=20=20
>=20+/*
> + * Re-issue deferred callbacks, going straight to the enqueue so they =
cannot
> + * defer again. defer_lock is held across llist_del_all() and the re-i=
ssue so
> + * the drainers -- this CPU's irq_work, rcu_defer_flush() and
> + * rcutree_migrate_callbacks() -- serialize and never leave a callback=
 off
> + * ->defer_head yet not on a callback list.
> + */
> +static void rcu_defer_drain(struct irq_work *iw)
> +{
> + struct rcu_data *rdp =3D container_of(iw, struct rcu_data, defer_work=
);
> + struct llist_node *node, *next;
> + unsigned long flags;
> +
> + raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> + llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)) {
> + struct rcu_head *head =3D (struct rcu_head *)node;
> +
> + rcu_do_enqueue(head, head->func, false);
> + }
> + raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> +}
> +
> +/* Stage @head for this CPU's irq_work when call_rcu() cannot enqueue =
now. */
> +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> +{
> + struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> +
> + head->func =3D func;
> + if (llist_add((struct llist_node *)head, &rdp->defer_head))
> + irq_work_queue(&rdp->defer_work);


If current CPU is isolation and nozh_full, maybe we should avoid to
queue irq_work to current CPUs(include srcu, tasks-rcu) ?

Maybe can wrap a helper function:

bool rcu_irq_work_queue(struct irq_work *iw)=20
{
if=20(in_nmi())
    return irq_work_queue(iw);

int cpu =3D smp_processor_id();
if (!housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE))
   cpu =3D housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);

return irq_work_queue_on(iw, cpu);
}


Thanks
Zqiang



> +}
> +
> +/*
> + * Register pending deferred callbacks into the callback lists so a fo=
llowing
> + * rcu_barrier() waits for them. This runs before rcu_barrier() scans =
the
> + * lists. An online CPU's own irq_work re-issues its callbacks, so wai=
t it out;
> + * an offline CPU's irq_work may never run again, so drain its list di=
rectly
> + * onto this CPU instead.
> + */
> +static void rcu_defer_flush(void)
> +{
> + int cpu;
> +
> + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> + return;
> +
> + for_each_possible_cpu(cpu) {
> + struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> +
> + if (cpu_online(cpu))
> + irq_work_sync(&rdp->defer_work);
> + else
> + rcu_defer_drain(&rdp->defer_work);
> + }
> +}
> +
> +static void
> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool laz=
y_in)
> +{
> + /* Misaligned rcu_head! */
> + WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> +
> + /* Avoid NULL dereference if callback is NULL. */
> + if (WARN_ON_ONCE(!func))
> + return;
> +
> + if (should_rcu_defer()) {
> + call_rcu_defer(head, func);
> + return;
> + }
> +
> + /* An NMI reaching here entered with irqs enabled, so the enqueue can=
 race. */
> + WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
> +
> + rcu_do_enqueue(head, func, lazy_in);
> +}
> +
>  #ifdef CONFIG_RCU_LAZY
>  static bool enable_rcu_lazy __read_mostly =3D !IS_ENABLED(CONFIG_RCU_L=
AZY_DEFAULT_OFF);
>  module_param(enable_rcu_lazy, bool, 0444);
> @@ -3896,8 +3980,12 @@ void rcu_barrier(void)
>  unsigned long flags;
>  unsigned long gseq;
>  struct rcu_data *rdp;
> - unsigned long s =3D rcu_seq_snap(&rcu_state.barrier_sequence);
> + unsigned long s;
> +
> + /* Register any deferred callbacks before snapshotting the sequence. =
*/
> + rcu_defer_flush();
>=20=20
>=20+ s =3D rcu_seq_snap(&rcu_state.barrier_sequence);
>  rcu_barrier_trace(TPS("Begin"), -1, s);
>=20=20
>=20 /* Take mutex to serialize concurrent rcu_barrier() requests. */
> @@ -4231,6 +4319,10 @@ rcu_boot_init_percpu_data(int cpu)
>  rdp->rcu_onl_gp_state =3D RCU_GP_CLEANED;
>  rdp->last_sched_clock =3D jiffies;
>  rdp->cpu =3D cpu;
> + init_llist_head(&rdp->defer_head);
> + raw_spin_lock_init(&rdp->defer_lock);
> + /* Hard irq_work so the re-issue runs promptly. */
> + rdp->defer_work =3D IRQ_WORK_INIT_HARD(rcu_defer_drain);
>  rcu_boot_init_nocb_percpu_data(rdp);
>  }
>=20=20
>=20@@ -4528,6 +4620,14 @@ void rcutree_migrate_callbacks(int cpu)
>  struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
>  bool needwake;
>=20=20
>=20+ /*
> + * Callbacks the outgoing CPU deferred late in the offline path (past =
the
> + * point its irq_work can run) sit on ->defer_head, which the ->cblist
> + * migration below does not cover. Drain them here, before the early
> + * returns; the re-issue lands on this CPU.
> + */
> + rcu_defer_drain(&rdp->defer_work);
> +
>  if (rcu_rdp_is_offloaded(rdp))
>  return;
>=20=20
>=20diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index eedfa43059e80..3a8e17136c5a7 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -229,6 +229,11 @@ struct rcu_data {
>  struct rcu_head barrier_head;
>  int exp_watching_snap; /* Double-check need for IPI. */
>=20=20
>=20+ /* Deferral of an NMI/reentrant call_rcu(); see __call_rcu_common()=
. */
> + struct llist_head defer_head;
> + struct irq_work defer_work;
> + raw_spinlock_t defer_lock;
> +
>  /* 5) Callback offloading. */
>  #ifdef CONFIG_RCU_NOCB_CPU
>  struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. =
*/
> --=20
>=202.53.0-Meta
>
