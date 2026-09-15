Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD836195E;
	Tue, 15 Sep 2026 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516603; cv=none; b=d1jph/hH8XfNOnxd1svEP8l9VxHarFUCIczzTxWRD0n2mKpvQCVmLZjqonh33hnIkDt5UPtFaKrCBDQF+hUhF5QSF5T6CwU16o6bjmcBi6m2jdPp3o3Lk5HSbVRkbgEAoENZ2IriVPUvLHSizJnATz7paVLektGSO3rnL4mCjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516603; c=relaxed/simple;
	bh=VFzLgxXN3EUkETMyIY97kNaerNYii938pLSpxrIv+1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu0T0p69EfnY6jcOIIIo9h5wXCPt+EKwQCrfudRnVbEnBuH0Sz4mlKzRuEN8l32327/iCB8XPxbC3qRsatzZ7ZGNXTavvN7ZEhq+4CfrEdG/vpiwdqgNzqWO0VfR3qxLP0EirV/SAvHpYQIuFNVMOuk8QtgGsOkPMbbjhIP8aXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPSAp2Lh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPSAp2Lh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23C91F000FF;
	Tue, 15 Sep 2026 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516601;
	bh=6xg/ezatpUxwFU75bwryxIRlQlQYj6Bzwx0rt5taCFU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=FPSAp2LhPJjFgwTsVcW6Cskc9lLNu8x3L7QknsvOQY7de/kwu2pvu320ieHITiaIl
	 tX8Mt0uVX7PBpcVR5g26r1OPAYM2gNcN6NguN4y5nCaHaWbjlERwKrG6kEC2OBkdno
	 pmtKSJeF7AaRTVO73wh5FiIBTTOHqIowzsVi8HhoqnsSNitOHhssiBUrH+Zw4+s/E3
	 wzw6PNnqhTWamoqrF3kAuKqYo9MA2dolu5RZtMGl0M9RLxOEvv3y2jAscoeRcgwnmR
	 QGfm60hJMsTbLASoJYb/IX08DpRAzvbrO8PnF6AebqzWxOV1y0OiFuJzB+t0u7oGxg
	 ip8eNRowueeAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 35753CE0996; Tue, 15 Sep 2026 16:56:41 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:56:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Juergen Gross <jgross@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation
 for reader-marked trampolines
Message-ID: <edc7cca2-a5c5-455c-8969-ea05dbdb08f7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
 <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com>
 <aqlgxKGk_AEKls_1@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqlgxKGk_AEKls_1@localhost.localdomain>

On Tue, Sep 15, 2026 at 05:14:12PM +0200, Frederic Weisbecker wrote:
> Le Tue, Sep 15, 2026 at 01:17:30PM +0000, Josef Bacik a écrit :
> > Tasks RCU waits for every task to pass through a voluntary context
> > switch, usermode or idle, because a preempted task might be sitting in a
> > trampoline that is about to be freed and nothing marks it as such.  With
> > PREEMPT_LAZY that is a poor fit for servers: cond_resched() is a no-op,
> > so a CPU-bound kthread only ever leaves the CPU by preemption, and one
> > such kthread holds every synchronize_rcu_tasks() caller -- ftrace and
> > BPF trampoline teardown under their mutexes, the kprobe jump optimizer
> > under text_mutex and cpus_read_lock() -- hostage for as long as it runs.
> > 
> > Following the discussion on v2, take the other road: let the
> > architecture make its trampolines Tasks Trace RCU readers.  When an
> > architecture selects HAVE_RCU_TRAMPOLINE_READERS it promises that every
> > trampoline whose lifetime Tasks RCU guards enters rcu_read_lock_trace()
> > (or its assembly equivalent) before calling out and leaves it before
> > returning, so a task anywhere inside such a call-out, preempted or not,
> > is an ordinary Tasks Trace reader.
> > 
> > That leaves the few instructions of trampoline text before the reader
> > is entered and after it is left (plus, in a later patch, the bytes a
> > kprobe jump optimization is about to overwrite).  A task can only linger
> > there by being interrupted there, and such text never calls anything
> > that schedules, so instead of tracking tasks we track CPUs: every pass
> > through __schedule() is a per-CPU quiescent event, except that the one
> > context switch that can catch a task at an arbitrary instruction -- a
> > preemption from irq exit -- first records the interrupted IP in the task
> > and parks it on a per-CPU list for the duration (reusing the fields and
> > lists the classic flavor keeps for its exit-path bookkeeping), and, if
> > the IP is inside such "unmarked" text, puts the task on a short holdout
> > list; the task takes itself off at its next context switch outside such
> > a preemption or irq-exit check that finds it elsewhere.  Usermode (the
> > existing tick hook, or a nohz_full CPU in an RCU extended quiescent
> > state) and idle count as well.  rcu_tasks_trampoline_text() does the
> > classification: anything outside core and module text, a new
> > .text..rcu_tramp section for C glue that trampolines call before it has
> > entered the reader (__rcu_trampoline), and an arch hook for things like
> > static ftrace stubs and return thunks.
> > 
> > The grace period, run by the existing rcu_tasks kthread so that
> > call_rcu_tasks(), synchronize_rcu_tasks() and rcu_barrier_tasks() keep
> > their names and callers, is: wait for every online non-idle CPU to
> > context switch (nudging stragglers with resched_cpu() after a jiffy),
> > drain the holdout list as it stood, synchronize_rcu_tasks_trace() for
> > everything inside the readers, then one more CPU pass and drain for
> > tasks that have since left the reader into the trailing instructions.
> > That is bounded by a few jiffies, preempt-off latency and an SRCU grace
> > period rather than by the longest stretch any task runs without
> > sleeping, needs no per-task scan, and makes cond_resched_tasks_rcu_qs()
> > unnecessary on such architectures.  As before, idle tasks are not
> > waited for.  rcu_tasks_wait_irq_preempted() walks the parked lists for
> > the one caller (the kprobe jump optimizer, later in the series) that
> > makes ordinary text unsafe to be parked in and so has to wait out tasks
> > that were preempted there before it said so.
> > 
> > The classic implementation is untouched and remains the default; the
> > new one is built only as CONFIG_TASKS_RCU_TRAMPOLINE_READERS when the
> > architecture opts in and uses the generic irq entry code, whose
> > reschedule check gains the rcu_tasks_irq_resched() call.  Nothing
> > selects it yet.
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Assisted-by: LLM
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h |  11 +
> >  include/linux/rcupdate.h          |  32 ++-
> >  include/linux/sched.h             |   1 +
> >  kernel/entry/common.c             |   8 +-
> >  kernel/fork.c                     |   1 +
> >  kernel/rcu/Kconfig                |  22 ++
> >  kernel/rcu/tasks.h                | 460 +++++++++++++++++++++++++++++++++++++-
> >  kernel/rcu/update.c               |   2 +
> >  8 files changed, 528 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index b2988aa12f66..86e58c4fe370 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -571,6 +571,16 @@
> >  		__cpuidle_text_end = .;					\
> >  		__noinstr_text_end = .;
> >  
> > +/*
> > + * C glue called directly from Tasks-RCU-protected trampolines, bounded so
> > + * that rcu_tasks_trampoline_text() can recognise it; see __rcu_trampoline.
> > + */
> > +#define RCU_TRAMP_TEXT							\
> > +		ALIGN_FUNCTION();					\
> > +		__rcu_tramp_text_start = .;				\
> > +		*(.text..rcu_tramp)					\
> > +		__rcu_tramp_text_end = .;
> > +
> >  #define TEXT_SPLIT							\
> >  		__split_text_start = .;					\
> >  		*(.text.split .text.split.[0-9a-zA-Z_]*)		\
> > @@ -607,6 +617,7 @@
> >  		TEXT_HOT						\
> >  		*(TEXT_MAIN .text.fixup)				\
> >  		NOINSTR_TEXT						\
> > +		RCU_TRAMP_TEXT						\
> >  		*(.ref.text)
> >  
> >  /* sched.text is aling to function alignment to secure we have same
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 44c07a66edff..fb2a3889a696 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -50,6 +50,31 @@ token_context_lock_instance(RCU, RCU_BH);
> >  /* Exported common interfaces */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func);
> >  void rcu_barrier_tasks(void);
> > +
> > +/*
> > + * Trampoline-reader Tasks RCU (CONFIG_TASKS_RCU_TRAMPOLINE_READERS), see
> > + * kernel/rcu/tasks.h.  rcu_tasks_irq_resched_enter()/_exit() bracket the
> > + * irq-exit preemption; rcu_tasks_trampoline_text() and the arch_ override
> > + * classify an interrupted IP; rcu_tasks_wait_irq_preempted() lets a caller
> > + * wait out tasks already preempted somewhere it is about to make unsafe.
> > + * __rcu_trampoline places C code that such trampolines call directly, before
> > + * it has entered its Tasks Trace reader, where that classification can see it.
> > + */
> > +void rcu_tasks_irq_resched_enter(unsigned long ip);
> > +void rcu_tasks_irq_resched_exit(void);
> > +bool rcu_tasks_trampoline_text(unsigned long ip);
> > +bool arch_rcu_tasks_trampoline_text(unsigned long ip);
> > +#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
> > +void rcu_tasks_wait_irq_preempted(bool (*inside)(unsigned long ip));
> > +#else
> > +static inline void rcu_tasks_wait_irq_preempted(bool (*inside)(unsigned long ip)) { }
> > +#endif
> > +#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
> > +/* Also keeps instrumentation calls out of the prologue, ahead of the reader. */
> > +#define __rcu_trampoline	__noinstr_section(".text..rcu_tramp")
> > +#else
> > +#define __rcu_trampoline
> > +#endif
> >  void synchronize_rcu(void);
> >  
> >  /*
> > @@ -180,11 +205,16 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
> >  #ifdef CONFIG_TASKS_RCU_GENERIC
> >  
> >  # ifdef CONFIG_TASKS_RCU
> > -# define rcu_tasks_classic_qs(t, preempt)				\
> > +#  ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
> > +void rcu_tasks_note_qs(struct task_struct *t, bool preempt);
> > +#  define rcu_tasks_classic_qs(t, preempt) rcu_tasks_note_qs((t), (preempt))
> > +#  else
> > +#  define rcu_tasks_classic_qs(t, preempt)				\
> >  	do {								\
> >  		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
> >  			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
> >  	} while (0)
> > +#  endif
> >  void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
> >  void synchronize_rcu_tasks(void);
> >  void rcu_tasks_torture_stats_print(char *tt, char *tf);
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 8b3d47a325cc..15beb44caa2c 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -957,6 +957,7 @@ struct task_struct {
> >  	u8				rcu_tasks_holdout;
> >  	u8				rcu_tasks_idx;
> >  	int				rcu_tasks_idle_cpu;
> > +	unsigned long			rcu_tasks_irq_ip;
> >  	struct list_head		rcu_tasks_holdout_list;
> >  	int				rcu_tasks_exit_cpu;
> >  	struct list_head		rcu_tasks_exit_list;
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index e4acd50bd81a..94318519998c 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/jump_label.h>
> >  #include <linux/kmsan.h>
> >  #include <linux/livepatch.h>
> > +#include <linux/rcupdate.h>
> >  #include <linux/resume_user_mode.h>
> >  #include <linux/tick.h>
> >  
> > @@ -141,8 +142,13 @@ void raw_irqentry_exit_cond_resched(struct pt_regs *regs)
> >  		rcu_irq_exit_check_preempt();
> >  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
> >  			WARN_ON_ONCE(!on_thread_stack());
> > -		if (need_resched() && arch_irqentry_exit_need_resched())
> > +		if (need_resched() && arch_irqentry_exit_need_resched()) {
> > +			if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> > +				rcu_tasks_irq_resched_enter(instruction_pointer(regs));
> >  			preempt_schedule_irq();
> > +			if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> > +				rcu_tasks_irq_resched_exit();
> > +		}
> >  	}
> >  }
> >  #ifdef CONFIG_PREEMPT_DYNAMIC
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 416758c8a3d4..8077336bb136 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1871,6 +1871,7 @@ static inline void rcu_copy_process(struct task_struct *p)
> >  	p->rcu_tasks_holdout = false;
> >  	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
> >  	p->rcu_tasks_idle_cpu = -1;
> > +	p->rcu_tasks_irq_ip = 0;
> >  	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
> >  #endif /* #ifdef CONFIG_TASKS_RCU */
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 332df7a7a634..bbab14bc14c3 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -107,6 +107,28 @@ config TASKS_RCU
> >  	default NEED_TASKS_RCU && PREEMPTION
> >  	select IRQ_WORK
> >  
> > +config HAVE_RCU_TRAMPOLINE_READERS
> > +	bool
> > +	help
> > +	  Select this if the architecture uses the generic irq entry code and
> > +	  every trampoline whose lifetime Tasks RCU guards on it (ftrace
> > +	  trampolines, kprobe out-of-line and optimized-probe slots, BPF
> > +	  trampolines, out-of-line ftrace direct-call trampolines) enters a
> > +	  Tasks Trace RCU read-side critical section before calling out of
> > +	  the trampoline and leaves it before returning, and any core text
> > +	  that runs on behalf of such a trampoline outside that reader is
> > +	  reported by arch_rcu_tasks_trampoline_text().  The assembly readers
> > +	  use the this_cpu_inc() form of SRCU-fast, hence !NEED_SRCU_NMI_SAFE.
> > +
> > +config TASKS_RCU_TRAMPOLINE_READERS
> > +	def_bool TASKS_RCU && HAVE_RCU_TRAMPOLINE_READERS && GENERIC_IRQ_ENTRY && !NEED_SRCU_NMI_SAFE
> > +	select TASKS_TRACE_RCU
> > +	help
> > +	  Implement the Tasks RCU grace period as a per-CPU pass over
> > +	  context switches and irq-exit reschedules outside trampoline text
> > +	  plus a Tasks Trace RCU grace period, instead of waiting for every
> > +	  task to voluntarily context switch.  See kernel/rcu/tasks.h.
> > +
> >  config FORCE_TASKS_RUDE_RCU
> >  	bool "Force selection of Tasks Rude RCU"
> >  	depends on RCU_EXPERT
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 627295396cd9..3a7c092361a6 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -152,7 +152,7 @@ static struct rcu_tasks rt_name =							\
> >  	.kname = #rt_name,								\
> >  }
> >  
> > -#ifdef CONFIG_TASKS_RCU
> > +#if defined(CONFIG_TASKS_RCU) && !defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS)
> >  
> >  /* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
> >  static void tasks_rcu_exit_stall(struct timer_list *unused);
> > @@ -802,7 +802,7 @@ static void rcu_tasks_torture_stats_print_generic(struct rcu_tasks *rtp, char *t
> >  
> >  #endif // #ifndef CONFIG_TINY_RCU
> >  
> > -#if defined(CONFIG_TASKS_RCU)
> > +#if defined(CONFIG_TASKS_RCU) && !defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS)
> >  
> >  ////////////////////////////////////////////////////////////////////////
> >  //
> > @@ -897,10 +897,445 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
> >  	rtp->postgp_func(rtp);
> >  }
> >  
> > -#endif /* #if defined(CONFIG_TASKS_RCU) */
> > +#endif /* #if defined(CONFIG_TASKS_RCU) && !defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS) */
> >  
> >  #ifdef CONFIG_TASKS_RCU
> >  
> > +static int rcu_tasks_lazy_ms = -1;
> > +module_param(rcu_tasks_lazy_ms, int, 0444);
> > +
> > +#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
> > +
> > +////////////////////////////////////////////////////////////////////////
> > +//
> > +// Tasks RCU for architectures whose trampolines are Tasks Trace RCU
> > +// readers (CONFIG_HAVE_RCU_TRAMPOLINE_READERS).
> > +//
> > +// On these architectures every piece of text whose lifetime Tasks RCU
> > +// guards -- ftrace trampolines, kprobe optinsn slots, BPF trampoline
> > +// images, out-of-line ftrace direct-call trampolines -- enters a Tasks
> > +// Trace RCU read-side critical section before calling out of itself and
> > +// leaves it before returning, so a task anywhere inside such a call-out,
> > +// preempted or not, is an ordinary rcu_read_lock_trace() reader and
> > +// synchronize_rcu_tasks_trace() waits for it.
> > +//
> > +// What that cannot cover is the handful of instructions in the trampoline
> > +// before the reader is entered and after it is left, and the one user that
> > +// has no trampoline at all: the bytes after a kprobe that the jump
> > +// optimizer is about to overwrite.  A task can only linger in such
> > +// "unmarked" text by being interrupted there; unmarked text never calls
> > +// anything that could schedule.  So a context switch on a CPU tells us that
> > +// whatever that CPU was running is out of unmarked text, with one
> > +// exception: a preemption from the irq-exit path, which can happen at any
> > +// instruction boundary.  That path has the interrupted pt_regs in hand, so
> > +// just before it preempts it records the IP in the task and checks it
> > +// (rcu_tasks_trampoline_text()); if it is inside unmarked text the task
> > +// goes on a short holdout list first, and takes itself off again at its
> > +// next context switch outside such a preemption or its next irq-exit
> > +// check that finds it elsewhere.  With that, every pass through
> > +// __schedule() is a per-CPU quiescent event, as are usermode and idle.
> > +//
> > +// A grace period is then:
> > +//
> > +//  1. Wait for every online, non-idle CPU to context switch, nudging
> > +//     stragglers with resched_cpu().  Afterwards no task is in the leading
> > +//     unmarked instructions of a dying trampoline unless it is on the
> > +//     holdout list.
> > +//  2. Wait for the holdout list (as it stood) to drain.
> > +//  3. synchronize_rcu_tasks_trace(), for everything inside the readers.
> > +//  4. Repeat 1 and 2 for tasks that have since left the reader and are in
> > +//     the trailing unmarked instructions.
> 
> Alternatively the approach could be generalized to vanilla RCU, it could be
> possible to define a .text.rcu_no_qs section within which code running is
> considered as an RCU reader (with a pause while on the explicit RCU tasks
> section). It would be forbidden to voluntary sleep inside
> and to put explicit preemption points (CONFIG_PROVE_RCU could report misuses).
> 
> Based on IP, RCU could consider those interrupted section as readers. This would
> require PREEMPT_RCU though.
> 
> And then synchronize_rcu() would do the 1, 2, 4 jobs.

If I am following correctly (ha!), sleepable BPF programs rule out use
of RCU in this manner.

But your point is nevertheless valid, in that SRCU could be used.
And because rcu_read_lock_trace() is a thin wrapper around SRCU-fast, we
*might* be able to instead use rcu_read_lock_tasks_trace(), which would
skip the task-struct increment and decrement, saving a few instructions.
Then, instead of waiting for each task's counter to go to zero, instead
just invoke synchronize_rcu_tasks_trace().

Which is pretty close to what Josef is proposing, just with the new RCU
Tasks Trace read-side primitives.  I think.  ;-)

This assumes that we do not need to flatten partially overlapping RCU
Tasks Trace readers into one big reader.

Or am I missing something here?

							Thanx, Paul
