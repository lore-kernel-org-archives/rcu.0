Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46793C4332B
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 19:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6D2072D
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 19:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgCSTmo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgCSTmn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 15:42:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C57820724;
        Thu, 19 Mar 2020 19:42:40 +0000 (UTC)
Date:   Thu, 19 Mar 2020 15:42:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH RFC v2 tip/core/rcu 14/22] rcu-tasks: Add an RCU Tasks
 Trace to simplify protection of tracing hooks
Message-ID: <20200319154239.6d67877d@gandalf.local.home>
In-Reply-To: <20200319001100.24917-14-paulmck@kernel.org>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
        <20200319001100.24917-14-paulmck@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 18 Mar 2020 17:10:52 -0700
paulmck@kernel.org wrote:

> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Because RCU does not watch exception early-entry/late-exit, idle-loop,
> or CPU-hotplug execution, protection of tracing and BPF operations is
> needlessly complicated.  This commit therefore adds a variant of
> Tasks RCU that:
> 
> o	Has explicit read-side markers to allow finite grace periods in
> 	the face of in-kernel loops for PREEMPT=n builds.  These markers
> 	are rcu_read_lock_trace() and rcu_read_unlock_trace().
> 
> o	Protects code in the idle loop, exception entry/exit, and
> 	CPU-hotplug code paths.  In this respect, RCU-tasks trace is
> 	similar to SRCU, but with lighter-weight readers.
> 
> o	Avoids expensive read-side instruction, having overhead similar
> 	to that of Preemptible RCU.
> 
> There are of course downsides:
> 
> o	The grace-period code can send IPIs to CPUs, even when those CPUs
> 	are in the idle loop or in nohz_full userspace.  This will be
> 	addressed by later commits.
> 
> o	It is necessary to scan the full tasklist, much as for Tasks RCU.
> 
> o	There is a single callback queue guarded by a single lock,
> 	again, much as for Tasks RCU.  However, those early use cases
> 	that request multiple grace periods in quick succession are
> 	expected to do so from a single task, which makes the single
> 	lock almost irrelevant.  If needed, multiple callback queues
> 	can be provided using any number of schemes.
> 
> Perhaps most important, this variant of RCU does not affect the vanilla
> flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
> readers can operate from idle, offline, and exception entry/exit in no
> way enables rcu_preempt and rcu_sched readers to do so.
> 
> This effort benefited greatly from off-list discussions of BPF
> requirements with Alexei Starovoitov and Andrii Nakryiko.  At least
> some of the on-list discussions are captured in the Link: tags below.
> In addition, KCSAN was quite helpful in finding some early bugs.

If we have this, do we still need to have RCU Tasks Rude flavor?

> 
> Link: https://lore.kernel.org/lkml/20200219150744.428764577@infradead.org/
> Link: https://lore.kernel.org/lkml/87mu8p797b.fsf@nanos.tec.linutronix.de/
> Link: https://lore.kernel.org/lkml/20200225221305.605144982@linutronix.de/
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andriin@fb.com>
> ---
>  include/linux/rcupdate_trace.h |  84 ++++++++++
>  include/linux/sched.h          |   8 +
>  init/init_task.c               |   4 +
>  kernel/fork.c                  |   4 +
>  kernel/rcu/Kconfig             |  12 +-
>  kernel/rcu/tasks.h             | 359 ++++++++++++++++++++++++++++++++++++++++-
>  6 files changed, 462 insertions(+), 9 deletions(-)
>  create mode 100644 include/linux/rcupdate_trace.h
> 


> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 0d43ec1..187226b 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -71,7 +71,7 @@ config TREE_SRCU
>  	  This option selects the full-fledged version of SRCU.
>  
>  config TASKS_RCU_GENERIC
> -	def_bool TASKS_RCU || TASKS_RUDE_RCU
> +	def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
>  	select SRCU
>  	help
>  	  This option enables generic infrastructure code supporting
> @@ -94,6 +94,16 @@ config TASKS_RUDE_RCU
>  	  switches on all online CPUs, including idle ones, so use
>  	  with caution.  Not for manual selection.
>  
> +config TASKS_TRACE_RCU
> +	def_bool 0
> +	default n

Again, no need for "default n"

> +	help
> +	  This option enables a task-based RCU implementation that uses
> +	  explicit rcu_read_lock_trace() read-side markers, and allows
> +	  these readers to appear in the idle loop as well as on the CPU
> +	  hotplug code paths.  It can force IPIs on online CPUs, including
> +	  idle ones, so use with caution.  Not for manual selection.

And no real need for "Not for manual selection".

> +
>  config RCU_STALL_COMMON
>  	def_bool TREE_RCU
>  	help



> @@ -480,10 +489,10 @@ core_initcall(rcu_spawn_tasks_kthread);
>  //
>  // "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
>  // passing an empty function to schedule_on_each_cpu().  This approach
> -// provides an asynchronous call_rcu_rude() API and batching of concurrent
> -// calls to the synchronous synchronize_rcu_rude() API.  This sends IPIs
> -// far and wide and induces otherwise unnecessary context switches on all
> -// online CPUs, whether online or not.
> +// provides an asynchronous call_rcu_tasks_rude() API and batching
> +// of concurrent calls to the synchronous synchronize_rcu_rude() API.
> +// This sends IPIs far and wide and induces otherwise unnecessary context
> +// switches on all online CPUs, whether online or not.

This looks out of place for this patch. Perhaps you fixed this code and
applied it to the wrong patch?

>  
>  // Empty function to allow workqueues to force a context switch.
>  static void rcu_tasks_be_rude(struct work_struct *work)
> @@ -569,3 +578,337 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
>  core_initcall(rcu_spawn_tasks_rude_kthread);
>  
>  #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
> +
> +////////////////////////////////////////////////////////////////////////
> +//
> +// Tracing variant of Tasks RCU.  This variant is designed to be used
> +// to protect tracing hooks, including those of BPF.  This variant
> +// therefore:
> +//
> +// 1.	Has explicit read-side markers to allow finite grace periods
> +//	in the face of in-kernel loops for PREEMPT=n builds.
> +//
> +// 2.	Protects code in the idle loop, exception entry/exit, and
> +//	CPU-hotplug code paths, similar to the capabilities of SRCU.
> +//
> +// 3.	Avoids expensive read-side instruction, having overhead similar
> +//	to that of Preemptible RCU.
> +//
> +// There are of course downsides.  The grace-period code can send IPIs to
> +// CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
> +// It is necessary to scan the full tasklist, much as for Tasks RCU.  There
> +// is a single callback queue guarded by a single lock, again, much as for
> +// Tasks RCU.  If needed, these downsides can be at least partially remedied.
> +//
> +// Perhaps most important, this variant of RCU does not affect the vanilla
> +// flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
> +// readers can operate from idle, offline, and exception entry/exit in no
> +// way allows rcu_preempt and rcu_sched readers to also do so.
> +
> +// The lockdep state must be outside of #ifdef to be useful.
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +static struct lock_class_key rcu_lock_trace_key;
> +struct lockdep_map rcu_trace_lock_map =
> +	STATIC_LOCKDEP_MAP_INIT("rcu_read_lock_trace", &rcu_lock_trace_key);
> +EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
> +#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> +
> +#ifdef CONFIG_TASKS_TRACE_RCU
> +
> +atomic_t trc_n_readers_need_end;	// Number of waited-for readers.
> +DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
> +
> +// Record outstanding IPIs to each CPU.  No point in sending two...
> +static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
> +
> +/* If we are the last reader, wake up the grace-period kthread. */
> +void rcu_read_unlock_trace_special(struct task_struct *t)
> +{
> +	WRITE_ONCE(t->trc_reader_need_end, false);
> +	if (atomic_dec_and_test(&trc_n_readers_need_end))
> +		wake_up(&trc_wait);

Hmm, this can't be called in places that hold the rq->lock can it?

-- Steve

> +}
> +EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
> +
> +/* Add a task to the holdout list, if it is not already on the list. */
> +static void trc_add_holdout(struct task_struct *t, struct list_head *bhp)
> +{
> +	if (list_empty(&t->trc_holdout_list)) {
> +		get_task_struct(t);
> +		list_add(&t->trc_holdout_list, bhp);
> +	}
> +}
> +ndif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */

