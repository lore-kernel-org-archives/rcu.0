Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97897202960;
	Thu, 10 Apr 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311253; cv=none; b=imXBBP1A3HJK/B8rjb+RZNSY5ofCX759iQ66L0Dj6RgtmxhIGcYq6ZVW4nPnPoy11F+ALUlQB1uUqBg1Nkjv1IMdtrml/FPwzgrqzAjA2kgcA2dDd2fbgUVpHU0w7JaBGXGQJw2tnPnFmTKIwsgTMaiK7BXtioebMo/WbGMDc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311253; c=relaxed/simple;
	bh=Jb4yUIJqOIvHl2pf5z/5eoqA7lDYaR8VwPBClTFMIcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR5wJjgnhDG/T59qoPl+LvpG/PSWpMu8JYTLI0kWo+nkGgGKYgZEdIsSkBwed/9v5qZpIXUJNLi3RnR8qj32Q5YyZ4ZFORuEbLezej2sudpT8S9tcmm7V3IHvgM4NHYBDipsZfKHp6+5AmQ1EoL5ZXfgTsxR+uDyBO0zWK4VPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwkxU/Xc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwkxU/Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E000C4CEDD;
	Thu, 10 Apr 2025 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744311253;
	bh=Jb4yUIJqOIvHl2pf5z/5eoqA7lDYaR8VwPBClTFMIcg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dwkxU/XcrKhbwQUxQ+Ovzy2wnoZbXNdte7NBGS5M9D+SZXDiRVpCBGlu02WXLGDyw
	 ST7qaqQ5L8RiApskK8/HwKG4DuyNYrHSgiv1AIXVfE5JU3jLjoamyEv6agaVjCah3Q
	 4C3aLIlg0Owqq2tRsKqVuAUpRbyAKNazcRt58Ailu2R7RRLTtsXrQfZY1Ih0q6nIhf
	 VORD60j2hPgZZSXf1B8fUEI9FXQXj23VJrreBVHKzOmQPuENAankrYW8to2Lp+qB3M
	 nhfiXYsQpkxgCVKUT/1v1xFS4svu5fwxLnZY2EMK8C1zu3ot5Zd1JkVyuPS8fyBFFQ
	 GSHqMVHU+ga9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 182D9CE087D; Thu, 10 Apr 2025 11:54:13 -0700 (PDT)
Date: Thu, 10 Apr 2025 11:54:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rcutorture: Perform more frequent testing of
 ->gpwrap
Message-ID: <98e35c90-5df3-4841-b5b9-7e8d18bab4f8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250410150329.3807285-1-joelagnelf@nvidia.com>
 <20250410150329.3807285-2-joelagnelf@nvidia.com>
 <11caaa93-7acf-417c-9223-1b14a76310b2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11caaa93-7acf-417c-9223-1b14a76310b2@paulmck-laptop>

On Thu, Apr 10, 2025 at 11:29:03AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 10, 2025 at 11:03:27AM -0400, Joel Fernandes wrote: >
> Currently, the ->gpwrap is not tested (at all per my testing) due to
> the > requirement of a large delta between a CPU's rdp->gp_seq and its
> node's > rnp->gpseq.  > > This results in no testing of ->gpwrap being
> set. This patch by default > adds 5 minutes of testing with ->gpwrap
> forced by lowering the delta > between rdp->gp_seq and rnp->gp_seq to
> just 8 GPs. All of this is > configurable, including the active time for
> the setting and a full > testing cycle.  > > By default, the first 25
> minutes of a test will have the _default_ > behavior there is right now
> (ULONG_MAX / 4) delta. Then for 5 minutes, > we switch to a smaller delta
> causing 1-2 wraps in 5 minutes. I believe > this is reasonable since we
> at least add a little bit of testing for > usecases where ->gpwrap is set.
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Much better, thank you!
> 
> One potential nit below.  I will run some tests on this version.

And please feel free to apply the following to both:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> > ---
> >  kernel/rcu/rcu.h        |  4 +++
> >  kernel/rcu/rcutorture.c | 67 ++++++++++++++++++++++++++++++++++++++++-
> >  kernel/rcu/tree.c       | 34 +++++++++++++++++++--
> >  kernel/rcu/tree.h       |  1 +
> >  4 files changed, 103 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index eed2951a4962..516b26024a37 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> >  			       unsigned long c_old,
> >  			       unsigned long c);
> >  void rcu_gp_set_torture_wait(int duration);
> > +void rcu_set_gpwrap_lag(unsigned long lag);
> > +int rcu_get_gpwrap_count(int cpu);
> >  #else
> >  static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
> >  {
> > @@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> >  	do { } while (0)
> >  #endif
> >  static inline void rcu_gp_set_torture_wait(int duration) { }
> > +static inline void rcu_set_gpwrap_lag(unsigned long lag) { }
> > +static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
> >  #endif
> >  unsigned long long rcutorture_gather_gp_seqs(void);
> >  void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 4fa7772be183..74de92c3a9ab 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -115,6 +115,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
> >  torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
> >  torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
> >  torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
> > +torture_param(int, gpwrap_lag_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
> > +torture_param(int, gpwrap_lag_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
> > +torture_param(int, gpwrap_lag_gps, 8, "Value to set for set_gpwrap_lag during an active testing period.");
> >  torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
> >  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
> >  torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
> > @@ -413,6 +416,8 @@ struct rcu_torture_ops {
> >  	bool (*reader_blocked)(void);
> >  	unsigned long long (*gather_gp_seqs)(void);
> >  	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
> > +	void (*set_gpwrap_lag)(unsigned long lag);
> > +	int (*get_gpwrap_count)(int cpu);
> >  	long cbflood_max;
> >  	int irq_capable;
> >  	int can_boost;
> > @@ -619,6 +624,8 @@ static struct rcu_torture_ops rcu_ops = {
> >  				  : NULL,
> >  	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
> >  	.format_gp_seqs		= rcutorture_format_gp_seqs,
> > +	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
> > +	.get_gpwrap_count	= rcu_get_gpwrap_count,
> >  	.irq_capable		= 1,
> >  	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
> >  	.extendables		= RCUTORTURE_MAX_EXTEND,
> > @@ -2394,6 +2401,7 @@ rcu_torture_stats_print(void)
> >  	int i;
> >  	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> >  	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> > +	long n_gpwraps = 0;
> >  	struct rcu_torture *rtcp;
> >  	static unsigned long rtcv_snap = ULONG_MAX;
> >  	static bool splatted;
> > @@ -2404,6 +2412,7 @@ rcu_torture_stats_print(void)
> >  			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
> >  			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
> >  		}
> > +		n_gpwraps += cur_ops->get_gpwrap_count(cpu);
> >  	}
> >  	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
> >  		if (pipesummary[i] != 0)
> > @@ -2435,8 +2444,9 @@ rcu_torture_stats_print(void)
> >  		data_race(n_barrier_attempts),
> >  		data_race(n_rcu_torture_barrier_error));
> >  	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
> > -	pr_cont("nocb-toggles: %ld:%ld\n",
> > +	pr_cont("nocb-toggles: %ld:%ld ",
> >  		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
> > +	pr_cont("gpwraps: %ld\n", n_gpwraps);
> >  
> >  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> >  	if (atomic_read(&n_rcu_torture_mberror) ||
> > @@ -3607,6 +3617,54 @@ static int rcu_torture_preempt(void *unused)
> >  
> >  static enum cpuhp_state rcutor_hp;
> >  
> > +static struct hrtimer gpwrap_lag_timer;
> > +static bool gpwrap_lag_active;
> > +
> > +/* Timer handler for toggling RCU grace-period sequence overflow test lag value */
> > +static enum hrtimer_restart rcu_gpwrap_lag_timer(struct hrtimer *timer)
> > +{
> > +	ktime_t next_delay;
> > +
> > +	if (gpwrap_lag_active) {
> > +		pr_alert("rcu-torture: Disabling ovf lag (value=0)\n");
> > +		cur_ops->set_gpwrap_lag(0);
> > +		gpwrap_lag_active = false;
> > +		next_delay = ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0);
> > +	} else {
> > +		pr_alert("rcu-torture: Enabling ovf lag (value=%d)\n", gpwrap_lag_gps);
> > +		cur_ops->set_gpwrap_lag(gpwrap_lag_gps);
> > +		gpwrap_lag_active = true;
> > +		next_delay = ktime_set(gpwrap_lag_active_mins * 60, 0);
> > +	}
> > +
> > +	if (torture_must_stop())
> > +		return HRTIMER_NORESTART;
> > +
> > +	hrtimer_forward_now(timer, next_delay);
> > +	return HRTIMER_RESTART;
> > +}
> > +
> > +static int rcu_gpwrap_lag_init(void)
> > +{
> > +	if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
> > +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
> > +		return -EINVAL;
> 
> When rcutorture is initiated by modprobe, this makes perfect sense.
> 
> But if rcutorture is built in, we have other choices:  (1) Disable gpwrap
> testing and do other testing but splat so that the bogus scripting can
> be fixed, (2) Force default values and splat as before, (3) Splat and
> halt the system.
> 
> The usual approach has been #1, but what makes sense in this case?
> 
> > +	}
> > +
> > +	hrtimer_setup(&gpwrap_lag_timer, rcu_gpwrap_lag_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +	gpwrap_lag_active = false;
> > +	hrtimer_start(&gpwrap_lag_timer,
> > +		      ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0), HRTIMER_MODE_REL);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcu_gpwrap_lag_cleanup(void)
> > +{
> > +	hrtimer_cancel(&gpwrap_lag_timer);
> > +	cur_ops->set_gpwrap_lag(0);
> > +	gpwrap_lag_active = false;
> > +}
> >  static void
> >  rcu_torture_cleanup(void)
> >  {
> > @@ -3776,6 +3834,9 @@ rcu_torture_cleanup(void)
> >  	torture_cleanup_end();
> >  	if (cur_ops->gp_slow_unregister)
> >  		cur_ops->gp_slow_unregister(NULL);
> > +
> > +	if (cur_ops->set_gpwrap_lag)
> > +		rcu_gpwrap_lag_cleanup();
> >  }
> >  
> >  static void rcu_torture_leak_cb(struct rcu_head *rhp)
> > @@ -4275,6 +4336,10 @@ rcu_torture_init(void)
> >  	torture_init_end();
> >  	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
> >  		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
> > +
> > +	if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
> > +		goto unwind;
> > +
> >  	return 0;
> >  
> >  unwind:
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 659f83e71048..6ec30d07759d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -80,6 +80,15 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
> >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> >  	.gpwrap = true,
> >  };
> > +
> > +int rcu_get_gpwrap_count(int cpu)
> > +{
> > +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > +
> > +	return READ_ONCE(rdp->gpwrap_count);
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_get_gpwrap_count);
> > +
> >  static struct rcu_state rcu_state = {
> >  	.level = { &rcu_state.node[0] },
> >  	.gp_state = RCU_GP_IDLE,
> > @@ -757,6 +766,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
> >  	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
> >  }
> >  
> > +/**
> > + * rcu_set_gpwrap_lag - Set RCU GP sequence overflow lag value.
> > + * @lag_gps: Set overflow lag to this many grace period worth of counters
> > + * which is used by rcutorture to quickly force a gpwrap situation.
> > + * @lag_gps = 0 means we reset it back to the boot-time value.
> > + */
> > +static unsigned long seq_gpwrap_lag = ULONG_MAX / 4;
> > +
> > +void rcu_set_gpwrap_lag(unsigned long lag_gps)
> > +{
> > +	unsigned long lag_seq_count;
> > +
> > +	lag_seq_count = (lag_gps == 0)
> > +			? ULONG_MAX / 4
> > +			: lag_gps << RCU_SEQ_CTR_SHIFT;
> > +	WRITE_ONCE(seq_gpwrap_lag, lag_seq_count);
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_set_gpwrap_lag);
> > +
> >  /*
> >   * When trying to report a quiescent state on behalf of some other CPU,
> >   * it is our responsibility to check for and handle potential overflow
> > @@ -767,9 +795,11 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
> >  static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
> >  {
> >  	raw_lockdep_assert_held_rcu_node(rnp);
> > -	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + ULONG_MAX / 4,
> > -			 rnp->gp_seq))
> > +	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + seq_gpwrap_lag,
> > +			 rnp->gp_seq)) {
> >  		WRITE_ONCE(rdp->gpwrap, true);
> > +		WRITE_ONCE(rdp->gpwrap_count, READ_ONCE(rdp->gpwrap_count) + 1);
> > +	}
> >  	if (ULONG_CMP_LT(rdp->rcu_iw_gp_seq + ULONG_MAX / 4, rnp->gp_seq))
> >  		rdp->rcu_iw_gp_seq = rnp->gp_seq + ULONG_MAX / 4;
> >  }
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index a9a811d9d7a3..63bea388c243 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -183,6 +183,7 @@ struct rcu_data {
> >  	bool		core_needs_qs;	/* Core waits for quiescent state. */
> >  	bool		beenonline;	/* CPU online at least once. */
> >  	bool		gpwrap;		/* Possible ->gp_seq wrap. */
> > +	unsigned int	gpwrap_count;	/* Count of GP sequence wrap. */
> >  	bool		cpu_started;	/* RCU watching this onlining CPU. */
> >  	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
> >  	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
> > -- 
> > 2.43.0
> > 
