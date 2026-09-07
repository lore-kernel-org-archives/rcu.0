Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08C4477F3;
	Mon,  7 Sep 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783669; cv=none; b=fdBtlXL6K0oOGJvN/nGWT9mpwlGuPIWoH/xwKp9mIKPsiGz28iNryviY0KfchF3prxW7LUzrC7piP4rZPEvk1nenCfVGQ9Bs8aAIKXJ0iI/X1BrnfPl/t84v3iW6x5FPTtFt2LkLi2r1xxLcYM3CyW8VQsvN/l9qhfuJGXbG4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783669; c=relaxed/simple;
	bh=gYA6TYCQy+IowALVVWgfWYeHy3EWwDv6JbVI6FqxPc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiJ+NN4aQKwEb3USR5e2tQdqUnWe2S+T6yNEzQIWI1iCz4nEarblNfYOdRSAiaTDj4SGY6ONcckJqD545ULnb73K8xpsB3LukxnRvhKBikg39sT6TRa5aIrewI4j4yqna+z8m6iIBNkcTBtVw27wMaHgFdubc5gsEpCsJah/kV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHCkg4gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHCkg4gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71C81F00A3A;
	Mon,  7 Sep 2026 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788783667;
	bh=6RafqFe1zOQfVX4I3+CvQ7y72wqiedDGCRPziRNypvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bHCkg4gbtV4fR2YXJbmLmuc4792CiiwMkkiRBQHsBe3wK55pXp+8DhreyLDcaIbMw
	 +XMz1qywEjymPY3Ej4XpuBzolt+eJO+nukbZ7CXCsQNU26wwPA1iXIhTSrRLpbGDix
	 fwWR2FArhe/UEy7m95AYiCBVgXqtLK4g9V7jnUSj20xaBegsmmoK4Eg5QF6p25qKod
	 FvDJ/mDhse/p+LJ4rbaxHYb1QC5RLLos4JcnAt7VH2IvwsAiCyGi4lzj9mRyvxW/JA
	 h+bvh9R1HO3HUjIq8DKQveOiIQHs0vc3Dpq6Hwle2VPzfsPQD/3qCXSkt6Tz4Wm3Zg
	 Y31OxqU9Ezkow==
Date: Mon, 7 Sep 2026 13:20:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, 
	Michal Hocko <mhocko@suse.com>, mic@digikod.net, oleg@redhat.com, david@kernel.org, 
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, gnoack3000@gmail.com, sj@kernel.org, 
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap6d3zuVsJiLkrpr@gremlin>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907081334.1152889-6-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:31PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
> pairs combined with for_each_process(), for_each_thread() and
> for_each_process_thread() loops across kernel/ with the
> for_each_*_rculock() macros, which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Changes in v2:
>   - Rename *_rcu to *_rculock
>   - Rename stale 'unlock:' label to 'out:' in hung_task.c (Günther Noack)
>  kernel/cpu.c             |  4 +---
>  kernel/freezer.c         |  4 +---
>  kernel/hung_task.c       | 11 ++++-------
>  kernel/locking/lockdep.c |  4 +---
>  kernel/rcu/update.c      |  4 +---
>  kernel/sched/core.c      |  3 +--
>  kernel/sched/debug.c     |  4 +---
>  kernel/trace/fgraph.c    |  8 ++------
>  kernel/unwind/deferred.c |  3 +--
>  9 files changed, 13 insertions(+), 32 deletions(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index b3c8553d7bd6..00638d2abc0f 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1254,8 +1254,7 @@ void clear_tasks_mm_cpumask(int cpu)
>  	 * full-fledged tasklist_lock.
>  	 */
>  	WARN_ON(cpu_online(cpu));
> -	rcu_read_lock();
> -	for_each_process(p) {
> +	for_each_process_rculock(p) {
>  		struct task_struct *t;
>
>  		/*
> @@ -1268,7 +1267,6 @@ void clear_tasks_mm_cpumask(int cpu)
>  		arch_clear_mm_cpumask_cpu(cpu, t->mm);
>  		task_unlock(t);
>  	}
> -	rcu_read_unlock();
>  }
>
>  /* Take this CPU down. */
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index a76bf957fb32..7a870f71dcf6 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -217,11 +217,9 @@ void thaw_process(struct task_struct *p)
>  {
>  	struct task_struct *t;
>
> -	rcu_read_lock();
> -	for_each_thread(p, t) {
> +	for_each_thread_rculock(p, t) {
>  		__thaw_task(t);
>  	}
> -	rcu_read_unlock();
>  }
>
>  /**
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 6fcc94ce4ca9..73a5ad3be9a8 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -315,13 +315,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  		return;
>
>  	this_round_count = 0;
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> +	for_each_process_thread_rculock(g, t) {
>  		if (!max_count--)
> -			goto unlock;
> +			goto out;
>  		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
>  			if (!rcu_lock_break(g, t))
> -				goto unlock;
> +				goto out;
>  			last_break = jiffies;
>  		}
>
> @@ -337,9 +336,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  			hung_task_info(t, timeout, this_round_count);
>  		}
>  	}
> - unlock:
> -	rcu_read_unlock();
> -
> +out:
>  	if (!this_round_count)
>  		return;
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c56a7f91d72e..ea218dc75ad5 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6834,15 +6834,13 @@ void debug_show_all_locks(void)
>  	}
>  	pr_warn("\nShowing all locks held in the system:\n");
>
> -	rcu_read_lock();
> -	for_each_process_thread(g, p) {
> +	for_each_process_thread_rculock(g, p) {
>  		if (!p->lockdep_depth)
>  			continue;
>  		lockdep_print_held_locks(p);
>  		touch_nmi_watchdog();
>  		touch_all_softlockup_watchdogs();
>  	}
> -	rcu_read_unlock();
>
>  	pr_warn("\n");
>  	pr_warn("=============================================\n\n");
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 2a778b8ab4ad..d8e0b5896db9 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -548,15 +548,13 @@ void synchronize_rcu_trivial_preempt(void)
>  	struct task_struct *t;
>
>  	smp_mb(); // Order prior accesses before grace-period start.
> -	rcu_read_lock(); // Protect task list.
> -	for_each_process_thread(g, t) {
> +	for_each_process_thread_rculock(g, t) {
>  		if (t == current)
>  			continue;  // Don't deadlock on ourselves!
>  		// Order later rcu_read_lock() on other tasks after QS.
>  		while (smp_load_acquire(&t->rcu_trivial_preempt_nesting))
>  			continue;
>  	}
> -	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu_trivial_preempt);
>  #endif // #if IS_ENABLED(CONFIG_TRIVIAL_PREEMPT_RCU)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0697ed0f1c3d..fd5bdd2cb798 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2005,8 +2005,7 @@ static void uclamp_sync_util_min_rt_default(void)
>  	smp_mb__after_spinlock();
>  	read_unlock(&tasklist_lock);
>
> -	guard(rcu)();
> -	for_each_process_thread(g, p)
> +	for_each_process_thread_rculock(g, p)
>  		uclamp_update_util_min_rt_default(p);
>  }
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 72236db67983..cdae165b98f7 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1029,14 +1029,12 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
>  #endif
>  		   "\n");
>
> -	rcu_read_lock();
> -	for_each_process_thread(g, p) {
> +	for_each_process_thread_rculock(g, p) {
>  		if (task_cpu(p) != rq_cpu)
>  			continue;
>
>  		print_task(m, rq, p);
>  	}
> -	rcu_read_unlock();
>  }
>
>  void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 40d373d65f9b..f797ce119223 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1057,11 +1057,10 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  		}
>  	}
>
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> +	for_each_process_thread_rculock(g, t) {
>  		if (start == end) {
>  			ret = -EAGAIN;
> -			goto unlock;
> +			goto free;
>  		}
>
>  		if (t->ret_stack == NULL) {
> @@ -1074,9 +1073,6 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  			t->ret_stack = ret_stack_list[start++];
>  		}
>  	}
> -
> -unlock:
> -	rcu_read_unlock();
>  free:
>  	for (i = start; i < end; i++)
>  		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index 5bea47314254..ecfe1336095e 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -319,9 +319,8 @@ void unwind_deferred_cancel(struct unwind_work *work)
>
>  	synchronize_srcu(&unwind_srcu);
>
> -	guard(rcu)();
>  	/* Clear this bit from all threads */
> -	for_each_process_thread(g, t) {
> +	for_each_process_thread_rculock(g, t) {
>  		atomic_long_andnot(BIT(bit),
>  				   &t->unwind_info.unwind_mask);
>  		if (t->unwind_info.cache)
> --
> 2.25.1
>

--
Cheers, Lorenzo
