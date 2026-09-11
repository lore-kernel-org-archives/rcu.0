Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7648371889;
	Fri, 11 Sep 2026 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152385; cv=none; b=Sj5Jj6QTnDN7u5qJBg1ydbivdps1BT7B4mzSmjagHsIDQw91gGJ6pI6NOJFmFHvauO9/mk6PKl5A1AQqh+8MFS8vVrTFxzPjANo6cZQK2JkGj+wX26ICb8rkppT0UW259uVbyXAgR4n2s52g4Oq7tWY0WnbtHaN+DFk/VRMI2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152385; c=relaxed/simple;
	bh=xH88kKB/TWb1etYT/yCGES3CbrdWa7hLAr9ou1VFtHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etiGbeBgj9t4+RuiTU41jCmQtJyewNk0oiU1rAazH5rEp9rpxzhYW0sHb6M2Nt7tsso/KMgNJ+OQg0LpY7Y/wR/qh1Nuv0qbFdZPlnXiUPMwQ+I7x88YP2MK9ixxxnj6cJZyvqmJ1Ku4KUL+87LWwAoQe4utlAKgf7NHwjWl8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9R+fJHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9R+fJHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E991F000FF;
	Fri, 11 Sep 2026 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152384;
	bh=BEH5L0y3LixWWPpE999YsoF8vwfZIA/JtkIUSaMP+LE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=M9R+fJHeZmy6WEfJ+D6CNLH+c3kjB5rut7ErP2+h8nVsKa7j3etNfbwtdp8rS80MS
	 fPhFABuFdrUdvOlZdTQAQCr61orU4wm/RjC2OU7poW1VrwvZyfgZGrC+qE1sarkPq0
	 QuxzQZPObBkWqJyMQach0VVskbIlHcGS9oQDOKxfOvJgnVD5bycCjFRDIgaYdLH17Q
	 UJmHrZwzXcEdIcRWoMRdQtTKfYNAHGRWaw/E2J3Bjse6JBE5JIuSHCfhhwe6AtNnRq
	 Z179pIn76KHvhsX6T+IKzErceu3YloUEBWmwjn5CgynJh7djSuiFdwsOpDYYGmPtoi
	 fH4mBz7X+Zqjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17178CE1902; Fri, 11 Sep 2026 11:46:24 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:46:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [PATCH RFC v2 15/15] rcu-tasks: Kick running holdouts through
 the scheduler
Message-ID: <78c438b0-9c9a-4307-a6f7-19e69adc20c0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-15-eaaa61ed2da4@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-15-eaaa61ed2da4@toxicpanda.com>

On Fri, Sep 11, 2026 at 02:08:53PM +0000, Josef Bacik wrote:
> A holdout that is running on a CPU with nothing else runnable is only
> preempted if the tick acts on rcu_request_urgent_qs_task()'s flag, and
> there may be no tick.  Now that a preemption outside a trampoline is a
> quiescent state, have check_holdout_task() call resched_cpu() on a
> running holdout as well, so the scheduler IPIs it and it goes through
> __schedule() and reports (or, if it is inside a trampoline, does not
> report) its own state with purely local ordering.  Nothing reads a
> running task's rcu_tramp_nesting remotely.
> 
> Only under CONFIG_RCU_TASKS_PREEMPT_QS; other architectures are
> unchanged.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Much better!  But please see below.

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index ba432bd922e2..02d2592ab7a3 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1038,8 +1038,18 @@ static bool rcu_tasks_preempted_qs(struct task_struct *t)
>  {
>  	return task_call_func(t, rcu_tasks_switched_out_clean, NULL);
>  }
> +
> +/* Make a running holdout pass through __schedule() soon, tick or no tick. */
> +static void rcu_tasks_kick_running(struct task_struct *t)
> +{
> +	int cpu = task_cpu(t);
> +
> +	if (task_curr(t) && cpu_online(cpu))
> +		resched_cpu(cpu);
> +}
>  #else
>  static bool rcu_tasks_preempted_qs(struct task_struct *t) { return false; }
> +static void rcu_tasks_kick_running(struct task_struct *t) { }
>  #endif
>  
>  /* Per-task initial processing. */
> @@ -1219,6 +1229,7 @@ static void check_holdout_task(struct task_struct *t,
>  		return;
>  	}
>  	rcu_request_urgent_qs_task(t);
> +	rcu_tasks_kick_running(t);

Something I learned the hard way, though Google paid most of the tuition
for this lesson:  There can be a *lot* of tasks on large systems, as
in hundreds of thousands of them.  If these tasks are consuming CPU in
very short bursts, we could easily repeatedly invoke resched_cpu() on
the same CPU, and all invocations other than the last one are redundant.

I instead suggest doing something similar to force_qs_rnp(), where a
cpumask is accumulated and at the end resched_cpu() is invoked for each
CPU with a bit set in that mask.

Of course, if a CPU appears twice while traversing the tasks list, then
each of those tasks did a context switch, which would have reported a
Tasks RCU quiescent state.  Unless those tasks happened to have non-zero
->rcu_tramp_nesting at that time.

Which suggests that each task have a pair of counters.  Or that
rcu_tasks_trampoline_exit() should check for zero ->rcu_tramp_nesting,
and report a quiescent state at that point.

Either way, if a CPU appears only once in the tasks_list traversal,
hitting it with resched_cpu() makes sense.  Though we might also
need to suppress calls to resched_cpu() for grace periods that are
(say) less than one second old.

Thoughts?

							Thanx, Paul

>  	if (!needreport)
>  		return;
>  	if (*firstreport) {
> 
> -- 
> 2.55.0
> 
> 
