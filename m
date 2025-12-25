Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B5137930;
	Thu, 25 Dec 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766687745; cv=none; b=Stq4Q+MhgQmAkIXxcooGOYbe70WBWNVals1oCxy/UEJ9sx+RRJ7FAgAh+uN8sZ3Lx71w9P5oytZ86LuGGWbI0l3n5pnxrdYPhqtKOivKdBiXr/ElQ1ob7/BAviZLx4UXFCyP+7FzhYJfJZDMc8fuAgxi+h+RkdHZOqn+KTmc7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766687745; c=relaxed/simple;
	bh=PRhikm05dCR4z9L2B3NjzLylHhYY97Chlw2ZpGrjFTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4XjpZP3+2SMTHOVWKRh1hRrebkJ9TKQy6rvsuckQJ5erBmzIg20Fn0J2T5FkqfE5LDFZvprG5t2zW0YI6EEOU+jOE3BBOfzhyWD2BpfJWtdZTtzsbQpbbNRQU3mPxSyDyyzb1kQ9OE8rD1S1Q8aWIS1YDzkOjTEml01hKKLx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeNZfwCS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeNZfwCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1436C4CEF1;
	Thu, 25 Dec 2025 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766687744;
	bh=PRhikm05dCR4z9L2B3NjzLylHhYY97Chlw2ZpGrjFTk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GeNZfwCSnAN3YJ1HcHGHhxmf9Gj3TrqshXMDfONMOO6bjIZtXmg/BEP65TjydQhUE
	 cHrkjrz6So6NYvmV6tG+DZeOHU7fmiSsMuqkjSgE7CyIfLfo27gUbvB4x3toHP9k9M
	 YQDgMjLxDnR5+Jp+e2lZWKvzU7ZTFR93LwEsgeTy3CeS3Hlhg5G3XGY7IF7D1AgYwr
	 /uqH0dQwK8ROaPEpiAucJ7iULWMWbcRPi1TCYIF/uhKytyZVH4q1q/vXkln4bKFjkN
	 w9cXH9fCBusIvMoINCU+p9p664mFytpPeFiF7ifZ0H9+woSttZfasjbYld/UaRE41Q
	 xXsScFAbVYCiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F3F6CE0D19; Thu, 25 Dec 2025 10:35:44 -0800 (PST)
Date: Thu, 25 Dec 2025 10:35:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Message-ID: <b355f3ed-3916-4419-951b-33e3788427f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251223034630.1092719-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223034630.1092719-1-joelagnelf@nvidia.com>

On Mon, Dec 22, 2025 at 10:46:29PM -0500, Joel Fernandes wrote:
> The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> State) design where the first FQS saves dyntick-idle snapshots and
> the second FQS compares them. This results in long and unnecessary latency
> for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
> 1000HZ) whenever one FQS wait sufficed.
> 
> Some investigations showed that the GP kthread's CPU is the holdout CPU
> a lot of times after the first FQS as - it cannot be detected as "idle"
> because it's actively running the FQS scan in the GP kthread.
> 
> Therefore, at the end of rcu_gp_init(), immediately report a quiescent
> state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> GP kthread cannot be in an RCU read-side critical section while running
> GP initialization, so this is safe and results in significant latency
> improvements.
> 
> I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
> showing significant latency improvements (default settings for fqs jiffies):
> 
> Baseline (without fix):
> | Run | Mean      | Min      | Max       |
> |-----|-----------|----------|-----------|
> | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
> | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
> | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
> | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
> | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
> | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
> | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
> | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
> | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
> | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
> 
> With fix:
> | Run | Mean     | Min      | Max       |
> |-----|----------|----------|-----------|
> | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
> | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
> | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
> | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
> | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
> | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
> | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
> | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
> | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
> | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
> 
> Summary:
> - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
> - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
> 
> Tested rcutorture TREE and SRCU configurations.
> 
> [apply paulmck feedack on moving logic to rcu_gp_init()]

If anything, these numbers look better, so good show!!!

Are there workloads that might be hurt by some side effect such
as increased CPU utilization by the RCU grace-period kthread?  One
non-mainstream hypothetical situation that comes to mind is a kernel
built with SMP=y but running on a single-CPU system with a high-frequence
periodic interrupt that does call_rcu().  Might that result in the RCU
grace-period kthread chewing up the entire CPU?

For a non-hypothetical case, could you please see if one of the
battery-powered embedded guys would be willing to test this?

							Thanx, Paul

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8293bae1dec1..0c7710caf041 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -160,6 +160,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
>  			      unsigned long gps, unsigned long flags);
>  static void invoke_rcu_core(void);
>  static void rcu_report_exp_rdp(struct rcu_data *rdp);
> +static void rcu_report_qs_rdp(struct rcu_data *rdp);
>  static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
>  static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
> @@ -1983,6 +1984,17 @@ static noinline_for_stack bool rcu_gp_init(void)
>  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>  		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
>  
> +	/*
> +	 * Immediately report QS for the GP kthread's CPU. The GP kthread
> +	 * cannot be in an RCU read-side critical section while running
> +	 * the FQS scan. This eliminates the need for a second FQS wait
> +	 * when all CPUs are idle.
> +	 */
> +	preempt_disable();
> +	rcu_qs();
> +	rcu_report_qs_rdp(this_cpu_ptr(&rcu_data));
> +	preempt_enable();
> +
>  	return true;
>  }
>  
> -- 
> 2.34.1
> 
