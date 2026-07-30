Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8302421EF8;
	Thu, 30 Jul 2026 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423333; cv=none; b=RCdaVCIqwql7FFXiDU7Eig28HgSIM99daKo+vbZvvKHVO5FP4zI3/WJ+ehZxK5BNGLJv/YZReTui89O+nrTgExqx395o2SHsflKWB1N5qyS9TUMv5MrDjUFSndfzdSx7Bo7d3YyE0VryG0QvMWv+EXO49LrXTyKI966HUDnGJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423333; c=relaxed/simple;
	bh=H5xJKMJtvIAUGdplaRLYCYJgcLxSel4ZrZS2BpXjFkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiuXHcxvOMKj/RvKJ3+L/3yXlBoxlOgbQ5oV75e8oqJaF0uwUzlaah3gaofLonf+4g5RrUK8zViRHrSwmj3MBounObgZj/Jxv2YXR6Zr6ZWdOpt6EXWm90aR/W8/okpx9RgrONTEzYz457bv9FasbTY5k9mJl/Ka6Vth5ZnSCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAJuPYcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAJuPYcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6253E1F00A3A;
	Thu, 30 Jul 2026 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785423331;
	bh=wxY1UORz9Z9qI4tDkmz2wbLfrA6pC/3rtE0kKTtPu54=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mAJuPYcR0ST+MCShDDyc7KfGT+z0EmbBkia6w/aBOL/N1mk9KU6kT6w5il8jeuetV
	 Xc08E/A8Rh7bv+1cW5JJ32YlDyak6I2pDVMajsTssb0QaxWPey5kwEumExJcT4E5rR
	 3/8/A2tG0GsBcKF1NBAOV5sDSa0UDhA65jaOVR554Z+w0JisFt5Q864mE1kPb/U84p
	 shHZEX0cn+66m87ftzFxCQsIqxwUvSAGH0zFXrVG8ON6aUWT8TJme6cL6X4s+81CK6
	 E9vHefY/e+B/nsZX0yV7OOrTndCNmvWabApyikglmI+ACU1uM+3ooKTeaepVn1kPOj
	 hYoK9AHRiQaIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1F887CE0B67; Thu, 30 Jul 2026 07:55:31 -0700 (PDT)
Date: Thu, 30 Jul 2026 07:55:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/6] rcu: Make call_rcu() safe to call from any context
Message-ID: <26382afc-4dde-4d2e-ba62-39f12010a3e1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260729162207.1567770-1-puranjay@kernel.org>
 <20260729162207.1567770-2-puranjay@kernel.org>
 <6ad0805c551a62283dca666fbace7302e2236e3a@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad0805c551a62283dca666fbace7302e2236e3a@linux.dev>

On Thu, Jul 30, 2026 at 12:20:54PM +0000, Zqiang wrote:
> > 
> > call_rcu() touches its per-CPU callback list only with interrupts
> > disabled: the enqueue runs under local_irq_save() (plus the nocb locks
> > when offloaded), as do callback invocation and grace-period work. A
> > call_rcu() that arrives with interrupts already disabled may be
> > interrupting one of those, so enqueuing directly could corrupt the list
> > or deadlock -- as an NMI or re-entrant instrumentation can.
> > 
> > Defer in that case: stage the callback on a per-CPU llist and kick an
> > irq_work that re-issues it once interrupts are back on, going straight to
> > the enqueue so it cannot defer again. Callers that merely hold interrupts
> > off are deferred too, which is harmless. Skip the gate while the
> > scheduler is down (RCU_SCHEDULER_INACTIVE): irq_work is not usable until
> > init_IRQ(), yet rcu_init() already calls call_rcu().
> > 
> > rcu_barrier() flushes pending deferred callbacks first: it waits out each
> > online CPU's irq_work and drains an offline CPU's list directly, as that
> > irq_work may never run again. rcutree_migrate_callbacks() also drains an
> > outgoing CPU's ->defer_head, so a callback deferred late in the offline
> > path runs even without an rcu_barrier(). The irq_work is
> > IRQ_WORK_INIT_HARD so the re-issue runs promptly and callbacks do not back
> > up; on PREEMPT_RT a non-HARD irq_work would run in a kthread that can be
> > delayed under load. A new hidden CONFIG_RCU_DEFER gates the code and the
> > IRQ_WORK dependency; without it call_rcu() enqueues directly as before.
> > 
> > Under CONFIG_PROVE_RCU, warn if the direct path is reached from NMI, which
> > would mean interrupts were enabled on NMI entry.
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/rcu/Kconfig | 6 +++
> >  kernel/rcu/rcu.h | 15 ++++++
> >  kernel/rcu/tree.c | 120 +++++++++++++++++++++++++++++++++++++++++----
> >  kernel/rcu/tree.h | 5 ++
> >  4 files changed, 136 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index f15da8038d0ba..1a5fb3156c062 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -175,6 +175,12 @@ config RCU_STALL_COMMON
> >  config RCU_NEED_SEGCBLIST
> >  def_bool ( TREE_RCU || TREE_SRCU || TASKS_RCU_GENERIC )
> >  
> > +# The deferral (and the IRQ_WORK it uses) is only needed where call_rcu() /
> > +# call_srcu() can be invoked while a callback-list operation is in flight.
> > +config RCU_DEFER
> > + def_bool HAVE_NMI || KPROBES || FUNCTION_TRACER || TRACEPOINTS
> > + select IRQ_WORK
> > +
> >  config RCU_FANOUT
> >  int "Tree-based hierarchical RCU fanout value"
> >  range 2 64 if 64BIT
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 39a9f6fa9a7b2..ed6604445f2ac 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -572,6 +572,21 @@ static inline void tasks_cblist_init_generic(void) { }
> >  #define RCU_SCHEDULER_INIT 1
> >  #define RCU_SCHEDULER_RUNNING 2
> >  
> > +/*
> > + * Should a call_rcu()/call_srcu() callback be deferred rather than enqueued
> > + * now? Defer whenever interrupts are disabled: a callback-list operation may
> > + * be in flight on this CPU, so enqueuing now could corrupt it. But not while
> > + * the scheduler is down -- early boot is single-threaded and can call this
> > + * before init_IRQ() makes irq_work usable (e.g. rcu_init()'s self-tests).
> > + */
> > +static inline bool should_rcu_defer(void)
> > +{
> > + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > + return false;
> > +
> > + return irqs_disabled() && rcu_scheduler_active != RCU_SCHEDULER_INACTIVE;
> > +}
> > +
> >  enum rcutorture_type {
> >  RCU_FLAVOR,
> >  RCU_TASKS_FLAVOR,
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 21b6ce1dffb63..93c4242345e67 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/smp.h>
> >  #include <linux/rcupdate_wait.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/llist.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/debug.h>
> >  #include <linux/nmi.h>
> > @@ -3148,21 +3149,27 @@ static void check_cb_ovld(struct rcu_data *rdp)
> >  raw_spin_unlock_rcu_node(rnp);
> >  }
> >  
> > -static void
> > -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > +/*
> > + * The callback list is only ever accessed with interrupts disabled (enqueue,
> > + * callback invocation, grace-period work). A call_rcu() with interrupts already
> > + * disabled may interrupt one of those, so __call_rcu_common() defers: the
> > + * callback is staged on a per-CPU llist that an irq_work re-issues once
> > + * interrupts are on. Only CONFIG_RCU_DEFER kernels can hit this.
> > + */
> > +static void rcu_defer_drain(struct irq_work *iw);
> > +
> > +/*
> > + * Enqueue @head on this CPU's rcu_segcblist. Also called by rcu_defer_drain()
> > + * to re-issue a deferred callback, so it must not re-check the deferral
> > + * condition. Either caller may have interrupts already disabled.
> > + */
> > +static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >  {
> >  static atomic_t doublefrees;
> >  unsigned long flags;
> >  bool lazy;
> >  struct rcu_data *rdp;
> >  
> > - /* Misaligned rcu_head! */
> > - WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > -
> > - /* Avoid NULL dereference if callback is NULL. */
> > - if (WARN_ON_ONCE(!func))
> > - return;
> > -
> >  if (debug_rcu_head_queue(head)) {
> >  /*
> >  * Probable double call_rcu(), so leak the callback.
> > @@ -3206,6 +3213,83 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >  local_irq_restore(flags);
> >  }
> >  
> > +/*
> > + * Re-issue deferred callbacks, going straight to the enqueue so they cannot
> > + * defer again. defer_lock is held across llist_del_all() and the re-issue so
> > + * the drainers -- this CPU's irq_work, rcu_defer_flush() and
> > + * rcutree_migrate_callbacks() -- serialize and never leave a callback off
> > + * ->defer_head yet not on a callback list.
> > + */
> > +static void rcu_defer_drain(struct irq_work *iw)
> > +{
> > + struct rcu_data *rdp = container_of(iw, struct rcu_data, defer_work);
> > + struct llist_node *node, *next;
> > + unsigned long flags;
> > +
> > + raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> > + llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)) {
> > + struct rcu_head *head = (struct rcu_head *)node;
> > +
> > + rcu_do_enqueue(head, head->func, false);
> > + }
> > + raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> > +}
> > +
> > +/* Stage @head for this CPU's irq_work when call_rcu() cannot enqueue now. */
> > +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> > +{
> > + struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > +
> > + head->func = func;
> > + if (llist_add((struct llist_node *)head, &rdp->defer_head))
> > + irq_work_queue(&rdp->defer_work);
> 
> If current CPU is isolation and nozh_full, maybe we should avoid to
> queue irq_work to current CPUs(include srcu, tasks-rcu) ?
> 
> Maybe can wrap a helper function:
> 
> bool rcu_irq_work_queue(struct irq_work *iw) 
> {
> if (in_nmi())
>     return irq_work_queue(iw);
> 
> int cpu = smp_processor_id();
> if (!housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE))
>    cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
> 
> return irq_work_queue_on(iw, cpu);
> }

You lost me on this one.  We cannot invoke call_rcu() and friends unless
we are running in kernel context, so usermode operation has already
been interrupted, perhaps due to a configuration error that failed to
direct interrupts away from the current CPU.  In that case, is the added
disruption of the irq-work really worth worrying about?

What am I missing here?

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> 
> > +}
> > +
> > +/*
> > + * Register pending deferred callbacks into the callback lists so a following
> > + * rcu_barrier() waits for them. This runs before rcu_barrier() scans the
> > + * lists. An online CPU's own irq_work re-issues its callbacks, so wait it out;
> > + * an offline CPU's irq_work may never run again, so drain its list directly
> > + * onto this CPU instead.
> > + */
> > +static void rcu_defer_flush(void)
> > +{
> > + int cpu;
> > +
> > + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > + return;
> > +
> > + for_each_possible_cpu(cpu) {
> > + struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > +
> > + if (cpu_online(cpu))
> > + irq_work_sync(&rdp->defer_work);
> > + else
> > + rcu_defer_drain(&rdp->defer_work);
> > + }
> > +}
> > +
> > +static void
> > +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > +{
> > + /* Misaligned rcu_head! */
> > + WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > +
> > + /* Avoid NULL dereference if callback is NULL. */
> > + if (WARN_ON_ONCE(!func))
> > + return;
> > +
> > + if (should_rcu_defer()) {
> > + call_rcu_defer(head, func);
> > + return;
> > + }
> > +
> > + /* An NMI reaching here entered with irqs enabled, so the enqueue can race. */
> > + WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
> > +
> > + rcu_do_enqueue(head, func, lazy_in);
> > +}
> > +
> >  #ifdef CONFIG_RCU_LAZY
> >  static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
> >  module_param(enable_rcu_lazy, bool, 0444);
> > @@ -3896,8 +3980,12 @@ void rcu_barrier(void)
> >  unsigned long flags;
> >  unsigned long gseq;
> >  struct rcu_data *rdp;
> > - unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
> > + unsigned long s;
> > +
> > + /* Register any deferred callbacks before snapshotting the sequence. */
> > + rcu_defer_flush();
> >  
> > + s = rcu_seq_snap(&rcu_state.barrier_sequence);
> >  rcu_barrier_trace(TPS("Begin"), -1, s);
> >  
> >  /* Take mutex to serialize concurrent rcu_barrier() requests. */
> > @@ -4231,6 +4319,10 @@ rcu_boot_init_percpu_data(int cpu)
> >  rdp->rcu_onl_gp_state = RCU_GP_CLEANED;
> >  rdp->last_sched_clock = jiffies;
> >  rdp->cpu = cpu;
> > + init_llist_head(&rdp->defer_head);
> > + raw_spin_lock_init(&rdp->defer_lock);
> > + /* Hard irq_work so the re-issue runs promptly. */
> > + rdp->defer_work = IRQ_WORK_INIT_HARD(rcu_defer_drain);
> >  rcu_boot_init_nocb_percpu_data(rdp);
> >  }
> >  
> > @@ -4528,6 +4620,14 @@ void rcutree_migrate_callbacks(int cpu)
> >  struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >  bool needwake;
> >  
> > + /*
> > + * Callbacks the outgoing CPU deferred late in the offline path (past the
> > + * point its irq_work can run) sit on ->defer_head, which the ->cblist
> > + * migration below does not cover. Drain them here, before the early
> > + * returns; the re-issue lands on this CPU.
> > + */
> > + rcu_defer_drain(&rdp->defer_work);
> > +
> >  if (rcu_rdp_is_offloaded(rdp))
> >  return;
> >  
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index eedfa43059e80..3a8e17136c5a7 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -229,6 +229,11 @@ struct rcu_data {
> >  struct rcu_head barrier_head;
> >  int exp_watching_snap; /* Double-check need for IPI. */
> >  
> > + /* Deferral of an NMI/reentrant call_rcu(); see __call_rcu_common(). */
> > + struct llist_head defer_head;
> > + struct irq_work defer_work;
> > + raw_spinlock_t defer_lock;
> > +
> >  /* 5) Callback offloading. */
> >  #ifdef CONFIG_RCU_NOCB_CPU
> >  struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
> > -- 
> > 2.53.0-Meta
> >
