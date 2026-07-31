Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB3355819;
	Fri, 31 Jul 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525147; cv=none; b=D1mP+2awKK7PMvCwkUZPSkwWKqy205oKXc14yqFlI6mXJcnbs4s8aOv64TJUrUD7YEmRdXf7vh/CdiCa5aBmEPWiKOVXvur0AvYz8pp/CKpYRkHJ3ZBZ4NOkkVLtoq8ObPKQv8dRjvAB2Dev1a7JD9fPtT22YDpMLgCCoDp5++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525147; c=relaxed/simple;
	bh=yFuDe2naHJ8IMdrK2U/v9VBXUqubW7KnlQUSQfViRv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCjAs/OLm8BsWnlWgA/aXbpHjJNeC9/Pz/VlsyGZPPo5dENz7J6XBOT3lR43xww/0pHtpwlKQmUFqC83xotnxphs21/HTEGhGLNAlFB+UPn6fmW/g5cUnaHijxG7C2fx2sLUW2zR3BhqOVNb5xLVUEXzwm3sgGT1bC4dVbM0lZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+96/IdX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+96/IdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD5A1F00AC4;
	Fri, 31 Jul 2026 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785525145;
	bh=oxtKVcMWnLp+7mkK8edrdex3rXLPKQA9LrtQrTnWZ5c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=L+96/IdXTdIA7KnckQLPFdTMceiDIpHjDwJdmaKkj45QRObZc1piejK+RLN9S4RNm
	 WeTY/Qg7SgcJrRATCk1/+EabzTPMXs60X0YnrsfchjCjlIwYB2ZaAw1cuZNReqB0Dt
	 26R5J2OTObnvTPwBxhJR2/oE6Y+0wyjCyZBQ4ARMnmvLycFlJ/fi0rbmyY0u2NJrXh
	 wUL53ewPANbaK9xTARpOsoIT6ai4PmJUV0Wu9rrQHm27pgg6HR/T3Sty7jg7wpzgp6
	 5uatrEqWGeEsnifSj3omhcV/2mGq9+6EiqeBEqQR9YEv/nGKNx8hXpbqKLCZBVztRj
	 tGx/y725SFHAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30659CE11BE; Fri, 31 Jul 2026 12:12:25 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:12:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Zqiang <qiang.zhang@linux.dev>, Lai Jiangshan <jiangshanlai@gmail.com>,
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
Subject: Re: [PATCH 3/6] srcu: Make call_srcu() safe to call from any context
Message-ID: <ff720366-c537-46a0-bae1-a6dbe3bde7d7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260729162207.1567770-1-puranjay@kernel.org>
 <20260729162207.1567770-4-puranjay@kernel.org>
 <96a07fd8d37018b005de85a0eac6045fa426e892@linux.dev>
 <CANk7y0g3tE7YJMV4nokqjiaMVeENVKxSv3zjLinXWF4GD4zzxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0g3tE7YJMV4nokqjiaMVeENVKxSv3zjLinXWF4GD4zzxw@mail.gmail.com>

On Fri, Jul 31, 2026 at 03:26:07PM +0100, Puranjay Mohan wrote:
> On Fri, Jul 31, 2026 at 2:03 PM Zqiang <qiang.zhang@linux.dev> wrote:
> >
> > >
> > > call_srcu() has the same constraint as call_rcu(): its callback list and
> > > locks are only touched with interrupts disabled. srcu_gp_start_if_needed()
> > > enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree,
> > > and callback invocation and grace-period work do likewise. So a
> > > call_srcu() with interrupts disabled may be racing a list operation in
> > > flight on this CPU, and enqueuing directly could corrupt the list or
> > > deadlock.
> > >
> > > Defer as call_rcu() does: stage the callback on the srcu_data's
> > > ->defer_cbs, chain that srcu_data onto a per-CPU list, and kick a per-CPU
> > > irq_work that re-issues it straight to the enqueue helper -- never back
> > > through __call_srcu(), so it cannot defer again.
> > >
> > > The irq_work is global (per CPU, not per srcu_struct) and statically
> > > initialized, so the deferral never runs check_init_srcu_struct(). It is
> > > IRQ_WORK_INIT_HARD to re-issue promptly, as for call_rcu(). srcu_barrier()
> > > and cleanup_srcu_struct() flush it first, and rcutree_migrate_callbacks()
> > > calls srcu_offline_drain() to drain an outgoing CPU's deferred callbacks.
> > > Gated by CONFIG_RCU_DEFER, as for call_rcu().
> > >
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> > >  include/linux/srcutree.h | 4 ++
> > >  kernel/rcu/rcu.h | 3 +
> > >  kernel/rcu/srcutree.c | 138 ++++++++++++++++++++++++++++++++++++++-
> > >  kernel/rcu/tree.c | 2 +
> > >  4 files changed, 144 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index 75e54e4f963fa..1ce759fb70948 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -13,6 +13,8 @@
> > >
> > >  #include <linux/rcu_node_tree.h>
> > >  #include <linux/completion.h>
> > > +#include <linux/irq_work_types.h>
> > > +#include <linux/llist.h>
> > >
> > >  struct srcu_node;
> > >  struct srcu_struct;
> > > @@ -41,6 +43,8 @@ struct srcu_data {
> > >  bool srcu_cblist_invoking; /* Invoking these CBs? */
> > >  struct timer_list delay_work; /* Delay for CB invoking */
> > >  struct work_struct work; /* Context for CB invoking. */
> > > + struct llist_head defer_cbs; /* Callbacks deferred on re-entry. */
> > > + struct llist_node defer_link; /* Links onto the per-CPU deferral drain list */
> > >  struct rcu_head srcu_barrier_head; /* For srcu_barrier() use. */
> > >  struct rcu_head srcu_ec_head; /* For srcu_expedite_current() use. */
> > >  int srcu_ec_state; /* State for srcu_expedite_current(). */
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index ed6604445f2ac..036d28516e92d 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -587,6 +587,9 @@ static inline bool should_rcu_defer(void)
> > >  return irqs_disabled() && rcu_scheduler_active != RCU_SCHEDULER_INACTIVE;
> > >  }
> > >
> > > +/* Drain an outgoing CPU's deferred SRCU callbacks; see rcutree_migrate_callbacks(). */
> > > +void srcu_offline_drain(int cpu);
> > > +
> > >  enum rcutorture_type {
> > >  RCU_FLAVOR,
> > >  RCU_TASKS_FLAVOR,
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 304112674e8a2..b9fe57ff91000 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/percpu.h>
> > >  #include <linux/preempt.h>
> > >  #include <linux/irq_work.h>
> > > +#include <linux/llist.h>
> > >  #include <linux/rcupdate_wait.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/smp.h>
> > > @@ -79,6 +80,46 @@ static void process_srcu(struct work_struct *work);
> > >  static void srcu_irq_work(struct irq_work *work);
> > >  static void srcu_delay_timer(struct timer_list *t);
> > >
> > > +static void srcu_defer_drain(struct irq_work *iw);
> > > +
> > > +/*
> > > + * Per-CPU call_srcu() deferral state. The irq_work is global (shared by every
> > > + * srcu_struct), so it must find which srcu_structs deferred callbacks: a
> > > + * callback is staged on its srcu_data's ->defer_cbs, and that srcu_data is
> > > + * chained (->defer_link) onto this per-CPU ->list that the irq_work walks.
> > > + */
> > > +struct srcu_defer {
> > > + struct llist_head list;
> > > + struct irq_work iw;
> > > + raw_spinlock_t lock;
> > > +};
> > > +
> > > +static DEFINE_PER_CPU(struct srcu_defer, srcu_defer) = {
> > > + .lock = __RAW_SPIN_LOCK_UNLOCKED(srcu_defer.lock),
> > > + .iw = IRQ_WORK_INIT_HARD(srcu_defer_drain),
> > > +};
> > > +
> > > +/*
> > > + * Register pending deferred call_srcu() callbacks so a following srcu_barrier()
> > > + * waits for them. An online CPU's own irq_work re-issues its callbacks, so wait
> > > + * it out; an offline CPU's irq_work may never run again, so drain its list
> > > + * directly onto this CPU instead.
> > > + */
> > > +static void srcu_defer_flush(void)
> > > +{
> > > + int cpu;
> > > +
> > > + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > > + return;
> > > +
> > > + for_each_possible_cpu(cpu) {
> > > + if (cpu_online(cpu))
> > > + irq_work_sync(&per_cpu(srcu_defer, cpu).iw);
> > > + else
> > > + srcu_defer_drain(&per_cpu(srcu_defer, cpu).iw);
> > > + }
> > > +}
> > > +
> > >  /*
> > >  * Initialize SRCU per-CPU data. Note that statically allocated
> > >  * srcu_struct structures might already have srcu_read_lock() and
> > > @@ -107,6 +148,11 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
> > >  sdp->cpu = cpu;
> > >  INIT_WORK(&sdp->work, srcu_invoke_callbacks);
> > >  timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> > > + /*
> > > + * ->defer_cbs and ->defer_link are valid when zeroed and are not
> > > + * reinitialized here, lest we clobber callbacks a reentrant
> > > + * call_srcu() already staged. See __call_srcu().
> > > + */
> > >  sdp->ssp = ssp;
> > >  }
> > >  }
> > > @@ -697,6 +743,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> > >  return; /* Just leak it! */
> > >  /* Wait for irq_work to finish first as it may queue a new work. */
> > >  irq_work_sync(&sup->irq_work);
> > > + /* Drain any deferred callbacks (shared irq_work) before freeing ->sda. */
> > > + srcu_defer_flush();
> >
> > 1. Should we move srcu_defer_flush() before irq_work_sync(&sup->irq_work) ?
> 
> Will fix it in next version.
> 
> >
> > 2. Will the following scenario trigger soft/hard_lockup ?
> >
> >     In irq_work context, irq disbaled:
> >     srcu_defer_drain
> >     ->srcu_do_enqueue
> >       ->srcu_gp_start_if_needed
> >         ->rcu_segcblist_enqueue
> >           fentry ebpf prog
> >              call_rcu_tasks_trace()
> >              ->__call_srcu()
> >                ->should_rcu_defer() = true
> >                  ->llist_add() + irq_work_queue()
> >                    the ipi send and irq_work run again -> srcu_defer_drain()->srcu_do_enqueue
> >
> > Did I miss something?
> 
> BPF programs don't allow recursion on the same CPU for the same BPF
> program, but your scenario can still occur because here the BPF
> program doesn't recurse rather it keeps enqueueing and firing IPIs.
> Before this patch it would have been a deadlock.
> 
> So, this is expected behaviour and to fix it we have following options:
> 
> 1. Make stuff under call_srcu() notrace or keep the normal enqueue
> traceable (so the outer reentry still happens once and the deadlock
> fix is still exercised), but have srcu_defer_drain() re-issue through
> a notrace copy of the enqueue chain so the prog can't fire during
>   the drain.
> 2. Accept it and document it, and correct BPF programs like the
> selftest in last patch will work because they detect reently.
> 3. Have a per-cpu in-drain flag set in srcu_defer_drain() and if in
> call_srcu should_rcu_defer() returns true and this flag is set +
> in_nmi() returns false, this means we are in this refeeding loop, so
> we can just leak that callback with a warning.
> 
> I prefer option 3 but let's wait for Paul for his feedback.

I am getting a bit nervous about all these special checks piling up,
but let's start with #3 and see how it goes.

							Thanx, Paul
