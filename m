Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E3225390;
	Mon,  3 Mar 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032651; cv=none; b=fVQlp92pEmPbVGHY2F5JvaXXSdX7vJ9c1T9UL1XEyjgdDbgl2Gi8hiwAuAqWflQUd4N/Ix39NfEk4P4aGTRn+faXt3pYAhiaZ5icgJtRTjaBtHEgYt3Wlum6TvTdgSBSWt8tX2qtziqY/j7jSgRI92D4y6gdA/fligWa09M2cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032651; c=relaxed/simple;
	bh=+KX+34F2ldGuSVeu1kzV0Q0HZsBwxquhH6wfWX0N7yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7Ep818q5oIomxU6z4F2bVUe9hgG/KZY9BFxYEZS4eNIkNnauINBCY042zqvTQnhJtKVpL/xkzVWVQLpQQ0TG2Z1lLf0Qu/y10ETbEf36sQcziXW9vZSU4zk3lA/uf0HhuQI3aQKkv2cxjJvonej5yMiuxNhqc7HLaxneukX3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7HfCcUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7HfCcUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339C0C4CED6;
	Mon,  3 Mar 2025 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741032651;
	bh=+KX+34F2ldGuSVeu1kzV0Q0HZsBwxquhH6wfWX0N7yU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=t7HfCcUgb2CJw8NZVbKA+90Xi08GvXHsCRQEdvPMru1OHAiuKXxOp+EmK3CDJztwv
	 Q78qbfrZlq7bs38LjKFymYIjWu+zsS8Y+P5Je/6RoKTNPWuffHXf2zh+m/ygfKOolO
	 uyS10hzaTcdcciqJez91OlrN2vYGcGmJrndpXoteoewHiVFk3+lWIKfPGtZlUxCtZ7
	 19NET81nOYQR79rSO9kjU9HsmCBwcuiTXxhPRHlxKr86Ob7rzLaSC5DSIrUAH1UQmY
	 /Y1pqlyE8ksRlH31DsJWNJ9VUvNdx+VxCf5K/FT5AcimCQFpEGxf4MmTBQ4E8U7yjf
	 x2OE68aC1waPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D3EE0CE0DCA; Mon,  3 Mar 2025 12:10:50 -0800 (PST)
Date: Mon, 3 Mar 2025 12:10:50 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <332cc3da-55fa-4729-81bf-625afa5290bd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213232559.34163-4-frederic@kernel.org>

On Fri, Feb 14, 2025 at 12:25:59AM +0100, Frederic Weisbecker wrote:
> A CPU coming online checks for an ongoing grace period and reports
> a quiescent state accordingly if needed. This special treatment that
> shortcuts the expedited IPI finds its origin as an optimization purpose
> on the following commit:
> 
> 	338b0f760e84 (rcu: Better hotplug handling for synchronize_sched_expedited()
> 
> The point is to avoid an IPI while waiting for a CPU to become online
> or failing to become offline.
> 
> However this is pointless and even error prone for several reasons:
> 
> * If the CPU has been seen offline in the first round scanning offline
>   and idle CPUs, no IPI is even tried and the quiescent state is
>   reported on behalf of the CPU.
> 
> * This means that if the IPI fails, the CPU just became offline. So
>   it's unlikely to become online right away, unless the cpu hotplug
>   operation failed and rolled back, which is a rare event that can
>   wait a jiffy for a new IPI to be issued.
> 
> * But then the "optimization" applying on failing CPU hotplug down only
>   applies to !PREEMPT_RCU.
> 
> * This force reports a quiescent state even if ->cpu_no_qs.b.exp is not
>   set. As a result it can race with remote QS reports on the same rdp.
>   Fortunately it happens to be OK but an accident is waiting to happen.
> 
> For all those reasons, remove this optimization that doesn't look worthy
> to keep around.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Based on discussions:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

If it was still just me doing RCU, I would skip this one, just out of an
abundance of caution.  But you break it, you buy it!  ;-)

> ---
>  kernel/rcu/tree.c     |  2 --
>  kernel/rcu/tree_exp.h | 45 ++-----------------------------------------
>  2 files changed, 2 insertions(+), 45 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8625f616c65a..86935fe00397 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -151,7 +151,6 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
>  			      unsigned long gps, unsigned long flags);
>  static void invoke_rcu_core(void);
>  static void rcu_report_exp_rdp(struct rcu_data *rdp);
> -static void sync_sched_exp_online_cleanup(int cpu);
>  static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
>  static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
> @@ -4259,7 +4258,6 @@ int rcutree_online_cpu(unsigned int cpu)
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>  		return 0; /* Too early in boot for scheduler work. */
> -	sync_sched_exp_online_cleanup(cpu);
>  
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index caff16e441d1..a3f962eb7057 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -751,12 +751,8 @@ static void rcu_exp_handler(void *unused)
>  	struct task_struct *t = current;
>  
>  	/*
> -	 * First, is there no need for a quiescent state from this CPU,
> -	 * or is this CPU already looking for a quiescent state for the
> -	 * current grace period?  If either is the case, just leave.
> -	 * However, this should not happen due to the preemptible
> -	 * sync_sched_exp_online_cleanup() implementation being a no-op,
> -	 * so warn if this does happen.
> +	 * WARN if the CPU is unexpectedly already looking for a
> +	 * QS or has already reported one.
>  	 */
>  	ASSERT_EXCLUSIVE_WRITER_SCOPED(rdp->cpu_no_qs.b.exp);
>  	if (WARN_ON_ONCE(!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
> @@ -803,11 +799,6 @@ static void rcu_exp_handler(void *unused)
>  	WARN_ON_ONCE(1);
>  }
>  
> -/* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
> -static void sync_sched_exp_online_cleanup(int cpu)
> -{
> -}
> -
>  /*
>   * Scan the current list of tasks blocked within RCU read-side critical
>   * sections, printing out the tid of each that is blocking the current
> @@ -885,38 +876,6 @@ static void rcu_exp_handler(void *unused)
>  	rcu_exp_need_qs();
>  }
>  
> -/* Send IPI for expedited cleanup if needed at end of CPU-hotplug operation. */
> -static void sync_sched_exp_online_cleanup(int cpu)
> -{
> -	unsigned long flags;
> -	int my_cpu;
> -	struct rcu_data *rdp;
> -	int ret;
> -	struct rcu_node *rnp;
> -
> -	rdp = per_cpu_ptr(&rcu_data, cpu);
> -	rnp = rdp->mynode;
> -	my_cpu = get_cpu();
> -	/* Quiescent state either not needed or already requested, leave. */
> -	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
> -	    READ_ONCE(rdp->cpu_no_qs.b.exp)) {
> -		put_cpu();
> -		return;
> -	}
> -	/* Quiescent state needed on current CPU, so set it up locally. */
> -	if (my_cpu == cpu) {
> -		local_irq_save(flags);
> -		rcu_exp_need_qs();
> -		local_irq_restore(flags);
> -		put_cpu();
> -		return;
> -	}
> -	/* Quiescent state needed on some other CPU, send IPI. */
> -	ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> -	put_cpu();
> -	WARN_ON_ONCE(ret);
> -}
> -
>  /*
>   * Because preemptible RCU does not exist, we never have to check for
>   * tasks blocked within RCU read-side critical sections that are
> -- 
> 2.46.0
> 
