Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FC1EB39;
	Wed,  2 Apr 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743556562; cv=none; b=SnkiyP5sOdgxnzx8ZzbwJmG4IbO4n557U0wp8iAj0VMxBo+JVttR42Jv+Em7XckiLeXADN35hnpCPH2wqPA92CR1HUGPJmzoqlsUVT3JDbAvqUqd4tya6uy+Arw/6Yzbp6Wu9Y4Jy/ss+UlbjWqTz/aAdTu68Z2Rn0wWtSz0Pvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743556562; c=relaxed/simple;
	bh=LYpo0vG3dQ8lYvlY4qVKVbhRU/Q6e2EEmjJrBW+uD2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnXzkknwGwCVyYceh5mc+OmjWaq/s6Co86YrCReYVVG/R8I6zW3KXcTDrQuL5CT+jLhp+A0NMc2/hIlFLQPwusMfskNrHBcLMfE7v9PY9r9wotPBySE6HCWvgcmS2OylNXbalpjorws1xc5Xvl8OF8QU4SlmFXD9Bt7CBn3gODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YurbvMt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YurbvMt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2330C4CEE4;
	Wed,  2 Apr 2025 01:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743556561;
	bh=LYpo0vG3dQ8lYvlY4qVKVbhRU/Q6e2EEmjJrBW+uD2g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YurbvMt9SklN9Fj9fCPkJqumCqkRMWfNIiKBPlKOFpVZByQYUocQX/uMW6GztzlQR
	 I8tXY5arHkfpCtYPhSW33BfZ4R2x1hpD0vQQq3Hg8qfVLPu1X8swoXLUE11Y5g0O0E
	 seSPG2SVCgylePbpCbhSh80wGEZYczYYKslFgxp9ijWvwRWEJn4bCH8bEhFzPCCXBK
	 Zbh6xhiwLGtRpTGcu5K3rxrScmSgGdOnWwrFzU3A0RFA0YOCqb79p4dCsdAOT6SUhW
	 mmIyAe73Oc1y0bbWC8HGOl2rYkRdix896hVVXocuhGMJD7BgLqCV9aertGWbpM96rS
	 nBD2OGAiQAFwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 79CFBCE160D; Tue,  1 Apr 2025 18:16:01 -0700 (PDT)
Date: Tue, 1 Apr 2025 18:16:01 -0700
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
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Perform more frequent testing of ->gpwrap
Message-ID: <c9c19caa-68c1-4012-bd82-38a24c9edb60@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250329230143.62292-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329230143.62292-1-joelagnelf@nvidia.com>

On Sat, Mar 29, 2025 at 07:01:42PM -0400, Joel Fernandes wrote:
> Currently, the ->gpwrap is not tested (at all per my testing) due to the
> requirement of a large delta between a CPU's rdp->gp_seq and its node's
> rnp->gpseq.
> 
> This results in no testing of ->gpwrap being set. This patch by default
> adds 5 minutes of testing with ->gpwrap forced by lowering the delta
> between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
> configurable, including the active time for the setting and a full
> testing cycle.
> 
> By default, the first 25 minutes of a test will have the _default_
> behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
> we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
> this is reasonable since we at least add a little bit of testing for
> usecases where ->gpwrap is set.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

I ran this as follows:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10m --configs "TREE01" --bootargs "rcutorture.ovf_cycle_mins=7" --trust-make

Once I actually applied your patch, I did get this:

[  601.891042] gpwraps: 13745

Which seems to indicate some testing.  ;-)

Additional comments inline.

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h        |  4 +++
>  kernel/rcu/rcutorture.c | 64 +++++++++++++++++++++++++++++++++++++++++
>  kernel/rcu/tree.c       | 34 ++++++++++++++++++++--
>  kernel/rcu/tree.h       |  1 +
>  4 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index eed2951a4962..9a15e9701e02 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>  			       unsigned long c_old,
>  			       unsigned long c);
>  void rcu_gp_set_torture_wait(int duration);
> +void rcu_set_torture_ovf_lag(unsigned long lag);
> +int rcu_get_gpwrap_count(int cpu);
>  #else
>  static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
>  {
> @@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>  	do { } while (0)
>  #endif
>  static inline void rcu_gp_set_torture_wait(int duration) { }
> +static inline void rcu_set_torture_ovf_lag(unsigned long lag) { }
> +static inline int rcu_get_gpwrap_count(int cpu) { return 0; }

Very good, you did remember CONFIG_SMP=n.  And yes, I did try it.  ;-)

But shouldn't these be function pointers in rcu_torture_ops?  That way if
some other flavor of RCU starts doing wrap protection for its grace-period
sequence numbers, this testing can apply directly to that flavor as well.

Then the pointers can simply be NULL in kernels built with CONFIG_SMP=n.

>  #endif
>  unsigned long long rcutorture_gather_gp_seqs(void);
>  void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 895a27545ae1..79a72e70913e 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -118,6 +118,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
>  torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
>  torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
>  torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
> +torture_param(int, ovf_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
> +torture_param(int, ovf_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
> +torture_param(int, ovf_lag_gps, 8, "Value to set for set_torture_ovf_lag during an active testing period.");

Given that "ovf" means just "overflow", would it make sense to get a "gp"
in there?  Maybe just "gpwrap_..."?

"What is in a name?"  ;-)

I could argue with the defaults, but I run long tests often enough that
I am not worried about coverage.  As long as we remember to either run
long tests or specify appropriate rcutorture.ovf_cycle_mins when messing
with ->gpwrap code.

>  torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
>  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
>  torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
> @@ -2629,6 +2632,7 @@ rcu_torture_stats_print(void)
>  	int i;
>  	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
>  	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> +	long n_gpwraps = 0;
>  	struct rcu_torture *rtcp;
>  	static unsigned long rtcv_snap = ULONG_MAX;
>  	static bool splatted;
> @@ -2639,6 +2643,7 @@ rcu_torture_stats_print(void)
>  			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
>  			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
>  		}
> +		n_gpwraps += rcu_get_gpwrap_count(cpu);
>  	}
>  	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
>  		if (pipesummary[i] != 0)
> @@ -2672,6 +2677,7 @@ rcu_torture_stats_print(void)
>  	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
>  	pr_cont("nocb-toggles: %ld:%ld\n",

The "\n" on the above line needs to be deleted.

>  		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
> +	pr_cont("gpwraps: %ld\n", n_gpwraps);
>  
>  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
>  	if (atomic_read(&n_rcu_torture_mberror) ||
> @@ -3842,6 +3848,58 @@ static int rcu_torture_preempt(void *unused)
>  
>  static enum cpuhp_state rcutor_hp;
>  
> +static struct hrtimer ovf_lag_timer;
> +static bool ovf_lag_active;

Same "ovf" naming complaint as before.

> +
> +/* Timer handler for toggling RCU grace-period sequence overflow test lag value */
> +static enum hrtimer_restart rcu_torture_ovf_lag_timer(struct hrtimer *timer)
> +{
> +	ktime_t next_delay;
> +
> +	if (ovf_lag_active) {
> +		pr_alert("rcu-torture: Disabling ovf lag (value=0)\n");
> +		rcu_set_torture_ovf_lag(0);
> +		ovf_lag_active = false;
> +		next_delay = ktime_set((ovf_cycle_mins - ovf_active_mins) * 60, 0);
> +	} else {
> +		pr_alert("rcu-torture: Enabling ovf lag (value=%d)\n", ovf_lag_gps);
> +		rcu_set_torture_ovf_lag(ovf_lag_gps);
> +		ovf_lag_active = true;
> +		next_delay = ktime_set(ovf_active_mins * 60, 0);
> +	}
> +
> +	if (torture_must_stop())
> +		return HRTIMER_NORESTART;
> +
> +	hrtimer_forward_now(timer, next_delay);
> +	return HRTIMER_RESTART;

OK, this does look to do cycles.

> +}
> +
> +static int rcu_torture_ovf_lag_init(void)
> +{
> +	if (ovf_cycle_mins <= 0 || ovf_active_mins <= 0) {
> +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
> +		return -EINVAL;
> +	}

Why not refuse to start this portion of the test when testing CONFIG_SMP=n
or something other than vanilla RCU?  No need to fail the test, just
print something saying that this testing won't be happening.

> +	hrtimer_init(&ovf_lag_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ovf_lag_timer.function = rcu_torture_ovf_lag_timer;
> +	ovf_lag_active = false;
> +	hrtimer_start(&ovf_lag_timer,
> +		      ktime_set((ovf_cycle_mins - ovf_active_mins) * 60, 0), HRTIMER_MODE_REL);
> +
> +	return 0;
> +}

All hrtimers, no kthreads.  Nice!

> +
> +static void rcu_torture_ovf_lag_cleanup(void)
> +{
> +	hrtimer_cancel(&ovf_lag_timer);
> +
> +	if (ovf_lag_active) {
> +		rcu_set_torture_ovf_lag(0);
> +		ovf_lag_active = false;
> +	}
> +}

Did you try the modprobe/rmmod testing to verify that this
cleans up appropriately?  You could use the drgn tool to check.
See tools/rcu//rcu-cbs.py for an example drgn script that digs into the
rcu_data structures.

>  static void
>  rcu_torture_cleanup(void)
>  {
> @@ -4015,6 +4073,8 @@ rcu_torture_cleanup(void)
>  	torture_cleanup_end();
>  	if (cur_ops->gp_slow_unregister)
>  		cur_ops->gp_slow_unregister(NULL);
> +
> +	rcu_torture_ovf_lag_cleanup();
>  }
>  
>  static void rcu_torture_leak_cb(struct rcu_head *rhp)
> @@ -4508,6 +4568,10 @@ rcu_torture_init(void)
>  	torture_init_end();
>  	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
>  		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
> +
> +	if (rcu_torture_ovf_lag_init())
> +		goto unwind;
> +
>  	return 0;
>  
>  unwind:
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b77ccc55557b..7b17b578956a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -80,6 +80,15 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
>  	.gpwrap = true,
>  };
> +
> +int rcu_get_gpwrap_count(int cpu)
> +{
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +
> +	return READ_ONCE(rdp->gpwrap_count);
> +}
> +EXPORT_SYMBOL_GPL(rcu_get_gpwrap_count);
> +
>  static struct rcu_state rcu_state = {
>  	.level = { &rcu_state.node[0] },
>  	.gp_state = RCU_GP_IDLE,
> @@ -778,6 +787,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
>  	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
>  }
>  
> +/**
> + * rcu_set_torture_ovf_lag - Set RCU GP sequence overflow lag value.
> + * @lag_gps: Set overflow lag to this many grace period worth of counters
> + * which is used by rcutorture to quickly force a gpwrap situation.
> + * @lag_gps = 0 means we reset it back to the boot-time value.
> + */
> +static unsigned long seq_ovf_lag = ULONG_MAX / 4;
> +
> +void rcu_set_torture_ovf_lag(unsigned long lag_gps)
> +{
> +	unsigned long lag_seq_count;
> +
> +	lag_seq_count = (lag_gps == 0)
> +			? ULONG_MAX / 4
> +			: lag_gps << RCU_SEQ_CTR_SHIFT;
> +	WRITE_ONCE(seq_ovf_lag, lag_seq_count);
> +}
> +EXPORT_SYMBOL_GPL(rcu_set_torture_ovf_lag);
> +
>  /*
>   * When trying to report a quiescent state on behalf of some other CPU,
>   * it is our responsibility to check for and handle potential overflow
> @@ -788,9 +816,11 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
>  static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
>  {
>  	raw_lockdep_assert_held_rcu_node(rnp);
> -	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + ULONG_MAX / 4,
> -			 rnp->gp_seq))
> +	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + seq_ovf_lag,
> +			 rnp->gp_seq)) {
>  		WRITE_ONCE(rdp->gpwrap, true);
> +		WRITE_ONCE(rdp->gpwrap_count, READ_ONCE(rdp->gpwrap_count) + 1);
> +	}
>  	if (ULONG_CMP_LT(rdp->rcu_iw_gp_seq + ULONG_MAX / 4, rnp->gp_seq))
>  		rdp->rcu_iw_gp_seq = rnp->gp_seq + ULONG_MAX / 4;
>  }

Looks plausible.

> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index a9a811d9d7a3..63bea388c243 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -183,6 +183,7 @@ struct rcu_data {
>  	bool		core_needs_qs;	/* Core waits for quiescent state. */
>  	bool		beenonline;	/* CPU online at least once. */
>  	bool		gpwrap;		/* Possible ->gp_seq wrap. */
> +	unsigned int	gpwrap_count;	/* Count of GP sequence wrap. */
>  	bool		cpu_started;	/* RCU watching this onlining CPU. */
>  	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
>  	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
> -- 
> 2.43.0
> 
