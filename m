Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B66EB7C;
	Tue, 22 Oct 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617812; cv=none; b=ad2uFYkXe7j3ObuhGyDrFOZjEXi5nTuRixorxwpXSkKeNhnpTCVXdxRtDNOgY+NtYdmyg7pZBA5eNijVpFaiKx8zE95991oTjqbrO06kiTBMgO81DZbCORtujNGKA0Svkx+f4PiBgcWK4/27R8KKXkylgcPK0mAQMWSbYjAWbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617812; c=relaxed/simple;
	bh=rCnBaxudAE0hJKimJTU73aeC8dWGsSksIH+CQi6HRyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R040xTw08yNA2jA2RQH/EGC+q1gCFybp1SMIb+i6SF1sajmX12AwO+TVOhMVp2Y9Cp4WUgR9P0e62fvxIVaIJgg11fijYicx2Hd2G81eqEmgJZES2VEpHcVgCSrRtLZgGpFXREedJD+oxBo7jKh0u5Gi/yZOdVaaT7P7nkO4yfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yapxj3z7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yapxj3z7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04350C4CEC3;
	Tue, 22 Oct 2024 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729617812;
	bh=rCnBaxudAE0hJKimJTU73aeC8dWGsSksIH+CQi6HRyc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yapxj3z7YU9J3L+oMoXLfarPIAQZv44FDgZER9IC3hX8OANT1i2LN25DVubPhHn3F
	 xH3r2B2YAk2+YsNx5zvwENkpnPHSOMTuVJnAigpO7XHJU060QPR8bK3ywMIvqX4RkB
	 keBy4aF0xpC1PxQ5n/Cp8kFKbQi8LPm/RYSbWLrL2qd9OSLgIke8+ubb/vtzaMCJYM
	 XcMYRWUHCFjTsoipsziVfB6XWiuZQ3TvWzJFA5mSjQtf9hBlC6oeofPT/ETd4mZd5F
	 nc1r/WajVulXEzABX0Eti2uZIzfJGzJ37C2YNCzTJyItIiEMQhGLJ0FrQhMbNoFLox
	 aDs0ydJlnFwBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9FB92CE0A48; Tue, 22 Oct 2024 10:23:31 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:23:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] rcu/nocb: Fix rcuog wake-up from offline softirq
Message-ID: <126f384f-bef4-468b-9082-0e3d47bdfd06@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241010163609.51273-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010163609.51273-1-frederic@kernel.org>

On Thu, Oct 10, 2024 at 06:36:09PM +0200, Frederic Weisbecker wrote:
> After a CPU has set itself offline and before it eventually calls
> rcutree_report_cpu_dead(), there are still opportunities for callbacks
> to be enqueued, for example from a softirq. When that happens on NOCB,
> the rcuog wake-up is deferred through an IPI to an online CPU in order
> not to call into the scheduler and risk arming the RT-bandwidth after
> hrtimers have been migrated out and disabled.
> 
> But performing a synchronized IPI from a softirq is buggy as reported in
> the following scenario:
> 
>         WARNING: CPU: 1 PID: 26 at kernel/smp.c:633 smp_call_function_single
>         Modules linked in: rcutorture torture
>         CPU: 1 UID: 0 PID: 26 Comm: migration/1 Not tainted 6.11.0-rc1-00012-g9139f93209d1 #1
>         Stopper: multi_cpu_stop+0x0/0x320 <- __stop_cpus+0xd0/0x120
>         RIP: 0010:smp_call_function_single
>         <IRQ>
>         swake_up_one_online
>         __call_rcu_nocb_wake
>         __call_rcu_common
>         ? rcu_torture_one_read
>         call_timer_fn
>         __run_timers
>         run_timer_softirq
>         handle_softirqs
>         irq_exit_rcu
>         ? tick_handle_periodic
>         sysvec_apic_timer_interrupt
>         </IRQ>
> 
> Fix this with forcing deferred rcuog wake up through the NOCB timer when
> the CPU is offline. The actual wake up will happen from
> rcutree_report_cpu_dead().
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409231644.4c55582d-lkp@intel.com
> Fixes: 9139f93209d1 ("rcu/nocb: Fix RT throttling hrtimer armed from offline CPU")
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_nocb.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 97b99cd06923..16865475120b 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -554,13 +554,19 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  			rcu_nocb_unlock(rdp);
>  			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
>  					   TPS("WakeLazy"));
> -		} else if (!irqs_disabled_flags(flags)) {
> +		} else if (!irqs_disabled_flags(flags) && cpu_online(rdp->cpu)) {
>  			/* ... if queue was empty ... */
>  			rcu_nocb_unlock(rdp);
>  			wake_nocb_gp(rdp, false);
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  					    TPS("WakeEmpty"));
>  		} else {
> +			/*
> +			 * Don't do the wake-up upfront on fragile paths.
> +			 * Also offline CPUs can't call swake_up_one_online() from
> +			 * (soft-)IRQs. Rely on the final deferred wake-up from
> +			 * rcutree_report_cpu_dead()
> +			 */
>  			rcu_nocb_unlock(rdp);
>  			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
>  					   TPS("WakeEmptyIsDeferred"));
> -- 
> 2.46.0
> 
