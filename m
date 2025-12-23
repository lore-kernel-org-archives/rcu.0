Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8B258CD7;
	Tue, 23 Dec 2025 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452907; cv=none; b=pbg4Jg/sYPC92VfG2EKPOJgdA3iSisZ7nQH5O6D3KSFUbB/PdW9C4GQL6m9pgttc0nI5goUktIhe1M8VXJTqqPVqkFlrGuX6YsYtCzxBpmSu2MYepT6N+j2A0DE/BNcCAlJs55dioNJhLvSxNgWv5DoiWbjJxvPDOQcX4GxE7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452907; c=relaxed/simple;
	bh=YcbovmSTPqQXvXDguDgl2Q5TgzxFOsFn3y5GkWWkWW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxe5pjID4nEpua3D/n5sHxby9YnVLnUvZT2wtwkHb8N1+anFC4Age00zqEMDxQCX70oxVoVf2qN3AZwMGxx0S2vbGTfVBc2sjT1F2pf+xUIxRJMpUvyHE/akKm5w2YwVgmlNTD8/eKfCn6poGLwxr3QSCCWIhPigUBIdqIXh+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2Ybhio1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2Ybhio1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D33C19422;
	Tue, 23 Dec 2025 01:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452907;
	bh=YcbovmSTPqQXvXDguDgl2Q5TgzxFOsFn3y5GkWWkWW8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f2Ybhio1/mGebHZfdrIHZom2tdr1pQBmDq48cCVWieGKlwrT2BtQ/wwcVVfU6R8ex
	 1+D4qtBXpSYCng890wx/5C6Ygds5aKIBF1+JW1sOPtK5CzpWSlHDIje7BmwJ68iton
	 BZN3iI0cL+d0bagGfzkF/AzaKFI1hryFsWnG9BCXl1DImKBJMQ5PUIOZ3VgIk/aDPQ
	 R1J5H3gGB0nQSnI4UlHY6Dss9mTNR8TdEqErnQ9jz23j3ik7Rcn7OBJ8dkIIu1o9Gj
	 pcq9Kd1OPLcvujtNk+UjI48Uin5X1uV0XbllCC5xNM8eVhLXRFX20oWXqhivCJ2fz7
	 NYuHAYNskHMMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8B43ACE0B06; Mon, 22 Dec 2025 17:21:46 -0800 (PST)
Date: Mon, 22 Dec 2025 17:21:46 -0800
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
Subject: Re: [PATCH RFC] rcu: Reduce synchronize_rcu() latency by reporting
 GP kthread's CPU QS early
Message-ID: <1d184772-9d39-4c9c-a26e-d6332f630cc1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251223003039.59161-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223003039.59161-1-joelagnelf@nvidia.com>

On Mon, Dec 22, 2025 at 07:30:39PM -0500, Joel Fernandes wrote:
> The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> State) design where the first FQS saves dyntick-idle snapshots and
> the second FQS compares them. This results in long and unncessary latency for
> synchronize_rcu() on idle systems (two FQS waits of ~3ms each with 1000HZ)
> whenever one FQS wait sufficed.
> 
> Some investigations showed that the GP kthread's CPU is the holdout CPU
> a lot of times after the first FQS as - it cannot be detected as "idle"
> because it's actively running the FQS scan in the GP kthread.
> 
> Therefore, at the start of the first FQS, immediately report a quiescent
> state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> GP kthread cannot be in an RCU read-side critical section while running
> the FQS scan, so this is safe and results in significant tail latency
> improvements.
> 
> I benchmarked 100 synchronize_rcu() calls, 6 runs each showing good tail
> latency improvements per synchronize_rcu() call (default settings for fqs
> jiffies):
> 
> Baseline (without fix):
> | Run | Mean     | Min      | Max       |
> |-----|----------|----------|-----------|
> | 1   | 4.036 ms | 3.509 ms | 7.973 ms  |
> | 2   | 4.049 ms | 3.904 ms | 8.003 ms  |
> | 3   | 4.033 ms | 1.160 ms | 10.083 ms |
> | 4   | 3.993 ms | 3.145 ms | 4.093 ms  |
> | 5   | 3.988 ms | 2.675 ms | 4.123 ms  |
> | 6   | 4.019 ms | 3.894 ms | 5.845 ms  |
> 
> With fix:
> | Run | Mean     | Min      | Max      |
> |-----|----------|----------|----------|
> | 1   | 3.991 ms | 2.953 ms | 4.125 ms |
> | 2   | 3.995 ms | 3.439 ms | 4.081 ms |
> | 3   | 3.989 ms | 2.974 ms | 4.079 ms |
> | 4   | 3.997 ms | 3.667 ms | 4.072 ms |
> | 5   | 4.027 ms | 2.550 ms | 7.928 ms |
> | 6   | 3.989 ms | 2.886 ms | 4.076 ms |
> 
> The fix reduces worst-case latency due to the second FQS wait not
> running when not needed.
> 
> Tested rcutorture TREE and SRCU configurations.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Nice results!!!

But why not do this at the end of rcu_gp_init()?

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8293bae1dec1..c116ed7633d3 100644
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
> @@ -2032,6 +2033,17 @@ static void rcu_gp_fqs(bool first_time)
>  	}
>  
>  	if (first_time) {
> +		/*
> +		 * Immediately report QS for the GP kthread's CPU. The GP kthread
> +		 * cannot be in an RCU read-side critical section while running
> +		 * the FQS scan. This eliminates the need for a second FQS wait
> +		 * when all CPUs are idle.
> +		 */
> +		preempt_disable();
> +		rcu_qs();
> +		rcu_report_qs_rdp(this_cpu_ptr(&rcu_data));
> +		preempt_enable();
> +
>  		/* Collect dyntick-idle snapshots. */
>  		force_qs_rnp(rcu_watching_snap_save);
>  	} else {
> -- 
> 2.34.1
> 
