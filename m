Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6734107F;
	Mon,  5 Jan 2026 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628116; cv=none; b=kjsZuqdYZED/jqAcZVlOgWhf9wPWaxZdYWZWxjuiFPeHwR3AWOS4MyPNTJVa9JViygL36YDktQsIzbYPnGBZbYqxcUEbg66RR7xBJBc4/1KdikfKJUImr81G7axk1uUgg381yjvSj9sBhx/H+RZCbGr53X1F1vyts/onrgEQnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628116; c=relaxed/simple;
	bh=OucqBVGqgb1hbLp9tLWFpIB81+/FvjY5AVXM0nwpN3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLkvDtv+mBL72nItekoMRxdxKQhcO88KNc5iuKuJoQUt5kp/PimffZIF1sc3uI3SItSBwYJkl0tPxwGkUv70CONeI4++EhPn8BdRQC4GVqPpITHGryG4Oze6FpivnSi4U8AdEqrvJp93a/xqOKVwZl91yqOi9ueiFGfrHofF3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DD9821AB6C;
	Mon,  5 Jan 2026 15:48:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 6886520025;
	Mon,  5 Jan 2026 15:48:28 +0000 (UTC)
Date: Mon, 5 Jan 2026 10:48:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
 joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 02/14] rcu: Add per-CPU blocked task lists for
 PREEMPT_RCU
Message-ID: <20260105104849.752efb04@gandalf.local.home>
In-Reply-To: <20260103002343.6599-3-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
	<20260103002343.6599-3-joelagnelf@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dszoeoh7i7g5d8w7o48t1xdymhc3t54c
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 6886520025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19rOGnLA+w8iTuiBQY4EKl4E4O4mHP4D+s=
X-HE-Tag: 1767628108-330019
X-HE-Meta: U2FsdGVkX18bkDMYICk2fU/lpajAz11gExQhFFWI8iJ+QE1RBNHPqHtpfKIfS2sotul61RbZL/mFXBr/utWltxrw3NJdz0ihtKlI9FDTVBZfsCFgvDsupj9mjGtpeF7hG91zwEzg7Ew4HSler7DWeHrVZ5qyNByKF6kzzx95EgGns3aFtJezt+UuxJK1UU0TJ4ri76L8kXh2li8Qm99IOo7VS6z2g4Oj+LA11R4i0Z9PoXqW9vahaIQeXYELv150FLpbcmHdNMecodsrlPV3GwbAHP2j9WT3wGdZaMacJCHOL7jO4TREdaAD1kvcPU9k6r06OIJ6mGy0BnBjNHY4HwTGt+MqZxKxjWSJB8kwmoVol/HrR9aYlHnYL3wWusF7

On Fri,  2 Jan 2026 19:23:31 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -248,6 +248,18 @@ config RCU_EXP_KTHREAD
>  
>  	  Accept the default if unsure.
>  
> +config RCU_PER_CPU_BLOCKED_LISTS
> +	bool "Use per-CPU blocked task lists in PREEMPT_RCU"
> +	depends on PREEMPT_RCU

> +	default n

nit, you don't need "default n". The default for options without defining a
default setting is "n".

> +	help
> +	  Enable per-CPU tracking of tasks blocked in RCU read-side
> +	  critical sections. This allows to quickly toggle the feature.
> +	  Eventually the config will be removed, in favor of always keeping
> +	  the optimization enabled.
> +
> +	  Accept the default if unsure.

Hmm, RCU is the only place that says "Accept the default". That would
usually be for non boolean values (for numbers). But it should say either
"Say N if unsure" or "Say Y if unsure".

> +
>  config RCU_NOCB_CPU
>  	bool "Offload RCU callback processing from boot-selected CPUs"
>  	depends on TREE_RCU
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 293bbd9ac3f4..e2b6a4579086 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1809,6 +1809,14 @@ static noinline_for_stack bool rcu_gp_init(void)
>  	struct rcu_node *rnp = rcu_get_root();
>  	bool start_new_poll;
>  	unsigned long old_gp_seq;
> +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> +	struct task_struct *t_verify;
> +	int cpu_verify;
> +	int rnp_count;
> +	int rdp_total;
> +	struct rcu_data *rdp_cpu;
> +	struct task_struct *t_rdp;
> +#endif
>  
>  	WRITE_ONCE(rcu_state.gp_activity, jiffies);
>  	raw_spin_lock_irq_rcu_node(rnp);
> @@ -1891,6 +1899,26 @@ static noinline_for_stack bool rcu_gp_init(void)
>  		 */
>  		arch_spin_lock(&rcu_state.ofl_lock);
>  		raw_spin_lock_rcu_node(rnp);
> +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> +		/*
> +		 * Verify rdp lists consistent with rnp list. Since the unlock
> +		 * path removes from rdp before rnp, we can have tasks that are
> +		 * on rnp but not on rdp (in the middle of being removed).
> +		 * Therefore rnp_count >= rdp_total is the expected invariant.
> +		 */
> +		rnp_count = 0;
> +		rdp_total = 0;
> +		list_for_each_entry(t_verify, &rnp->blkd_tasks, rcu_node_entry)
> +			rnp_count++;
> +		for (cpu_verify = rnp->grplo; cpu_verify <= rnp->grphi; cpu_verify++) {
> +			rdp_cpu = per_cpu_ptr(&rcu_data, cpu_verify);
> +			raw_spin_lock(&rdp_cpu->blkd_lock);
> +			list_for_each_entry(t_rdp, &rdp_cpu->blkd_list, rcu_rdp_entry)
> +				rdp_total++;
> +			raw_spin_unlock(&rdp_cpu->blkd_lock);
> +		}
> +		WARN_ON_ONCE(rnp_count < rdp_total);

This only happens at boot right? This isn't something that executes at
normal run time right? Otherwise I would be worried about loops like this
under raw spin locks that could affect RT.

> +#endif
>  		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
>  		    !rnp->wait_blkd_tasks) {
>  			/* Nothing to do on this leaf rcu_node structure. */
> @@ -4143,6 +4171,10 @@ rcu_boot_init_percpu_data(int cpu)
>  	rdp->rcu_onl_gp_state = RCU_GP_CLEANED;
>  	rdp->last_sched_clock = jiffies;
>  	rdp->cpu = cpu;
> +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> +	raw_spin_lock_init(&rdp->blkd_lock);
> +	INIT_LIST_HEAD(&rdp->blkd_list);
> +#endif
>  	rcu_boot_init_nocb_percpu_data(rdp);
>  }
>  
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index b8bbe7960cda..13d5649a80fb 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -294,6 +294,12 @@ struct rcu_data {
>  
>  	long lazy_len;			/* Length of buffered lazy callbacks. */
>  	int cpu;
> +
> +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> +	/* 8) Per-CPU blocked task tracking. */
> +	raw_spinlock_t blkd_lock;	/* Protects blkd_list. */
> +	struct list_head blkd_list;	/* Tasks blocked on this CPU. */
> +#endif
>  };
>  
>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 73ba5f4a968d..5d2bde19131a 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -338,6 +338,12 @@ void rcu_note_context_switch(bool preempt)
>  		raw_spin_lock_rcu_node(rnp);
>  		t->rcu_read_unlock_special.b.blocked = true;
>  		t->rcu_blocked_node = rnp;
> +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> +		t->rcu_blocked_cpu = rdp->cpu;
> +		raw_spin_lock(&rdp->blkd_lock);
> +		list_add(&t->rcu_rdp_entry, &rdp->blkd_list);
> +		raw_spin_unlock(&rdp->blkd_lock);

Should we use scoped_guard?

		scoped_guard(raw_spinlock, &rdp->blkd_lock) {
			list_add(&t->rcu_rdp_entry, &rdp->blkd_list);
		}

> +#endif
>  
>  		/*
>  		 * Verify the CPU's sanity, trace the preemption, and
> @@ -485,6 +491,10 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  	union rcu_special special;
> +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> +	int blocked_cpu;
> +	struct rcu_data *blocked_rdp;
> +#endif
>  
>  	rdp = this_cpu_ptr(&rcu_data);
>  	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> @@ -530,6 +540,17 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  		 * to loop.  Retain a WARN_ON_ONCE() out of sheer paranoia.
>  		 */
>  		rnp = t->rcu_blocked_node;
> +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> +		/* Remove from per-CPU list if task was added to it. */
> +		blocked_cpu = t->rcu_blocked_cpu;


And use guard here?

		if (blocked_cpu != -1) {
			blocked_rdp = per_cpu_ptr(&rcu_data, blocked_cpu);
			guard(raw_spin_lock)(&blocked_rdp->blkd_lock);
			list_del_init(&t->rcu_rdp_entry);
			t->rcu_blocked_cpu = -1;
		}

-- Steve


> +		}
> +#endif
>  		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
>  		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
>  		WARN_ON_ONCE(!rcu_is_leaf_node(rnp));

