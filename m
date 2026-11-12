Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443958;
	b=xON0IJJiRzxidGbgm8KLU+1kzDeOZ57JkpF+MD9GUTymCEqd7AEXNv/B2kpQY39GPOMy
	 l7KhjroYhb9p4TzbraRGtQfdH2rCC7LlZDHDChKu06nXDloB8qxxaDiZsSwLaRyTAL/We
	 WctE8omeUY38NI9aZHxLXk9ujL2UW4JzXvdnf/1mc0dVOIyeKpUhkeY/83GW3TZtmCnoF
	 K3aSJVk47VDYkg7g5QPJE7QzX1I6BBbXj2iW/Sbp1Egme8bU2sxXPznBA+vzcehyp78JB
	 76CHLFq7uqXZZdVzSot1lpmgfpj3yBYGDyFv1b2eUy1MQzE8TuPS7hgoQajRyeTi3UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443958;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=uvEWgR7ATia0M5dQY073lYc03zBM7FX3OBlrhR1bbFA=;
	b=uvGa7nqq/s7OgDop+w55GCWsHrTstnKFf9QV4iSE/rv9z2LVIhZic+a907vG9rs2g5lk
	 ZgjzT04exgLWv0OTjWjeHalk03xxuPPQLP5T5ALhASHEXM4Pa84nsC9n9n9m7AnEnV44t
	 kGp7AgT+AUfmazbM12K2VTm6JZgzbxyHCEIENTKvBpBOlo8E+gZ0Us+x3LXiIbpcGgaEx
	 hlxqs24m3FVb/jaL67Vki+WBEUzaBM77gjuTsW9XGN5FZb1Cgt1sbqiKq5iWLDSoyqlaw
	 90URmVaBh0LvsmjlYvTrPS1tG97BTXhbED/7k7hMsGi23S3Ky3ZKCiJ5bXZ4FQ9U0hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDU8lPI9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2528606A324;
	Thu, 12 Nov 2026 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDU8lPI9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DAE1F00A05;
	Thu, 12 Nov 2026 00:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443958;
	bh=uvEWgR7ATia0M5dQY073lYc03zBM7FX3OBlrhR1bbFA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NDU8lPI9ahNYNXGT7IJ1ZC5oQ3tI58Z0ZVgBiJl0ahKrgfFw+49YWjTaDRu2fUOwe
	 nD2M7Ei/o5X9hfWrOBfNZsJDGsi2AyNoHDiJ75Dg4wQ8CnWEeUsKgaQrUQkiXc4WmE
	 8L7tFTqAGkVN6fM20+zbIhttwittDMGtLKkvOQx/h4D9uHQAgfX40PloRX07OwzhMq
	 g+jN0kqBOeWWFBTIYlxOpOG49A/5G1Ts4oGSfgtHwiOY7g7Wwcc8+DBq4OoqpF8s8u
	 k9r0S7MSFZqGqWwdVshJ5QiRYo+COxOBDp/NJ3e2DDqMRSdmS7Cr8Pg4qY+fZVbiDz
	 EKHHYmSi1WMtg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F39EACE08D0; Wed, 11 Nov 2026 16:39:17 -0800 (PST)
Date: Wed, 11 Nov 2026 16:39:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rcutorture: Run NMI-safe SRCU readers from NMI
Message-ID: <ef372ecb-48e4-4ce2-8c37-c52ae66b4901@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-6-mathieu.desnoyers@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111145949.70845-6-mathieu.desnoyers@efficios.com>

On Wed, Nov 11, 2026 at 09:59:47AM -0500, Mathieu Desnoyers wrote:
> rcutorture exercises ->call() from NMI, but never runs a reader there.
> So nothing tests the NMI-safe reader flavors where it matters most: in
> an NMI that interrupts another reader during its counter update.
> 
> Run a reader from the same per-CPU perf-counter NMI, when every reader
> flavor in use is NMI-safe. These flavors are srcu_read_lock_nmisafe(),
> srcu_read_lock_fast() and srcu_read_lock_atomic(). A new ops hook,
> ->nmi_reader_capable(), reports whether the reader flavors in use are
> all NMI-safe. A new nmi_readers module parameter, on by default, enables
> these NMI readers. The statistics count these readers as nmi-reads.
> 
> The reader loads rcu_torture_current and checks its element as the
> other readers do. The element must not be freed before the reader ends.
> It must not go through two grace periods either.
> 
> The other readers count their pipe and batch values with this_cpu_inc().
> On some architectures, an NMI may interrupt it. So the NMI reader counts
> its values in arrays of atomic counters of its own. The statistics print
> them as "NMI Reader Pipe:" and "NMI Reader Batch:". A too-short grace
> period seen in NMI gets the same "!!!" and the same warning as for the
> other readers.
> 
> The NMI may interrupt lockdep, which then does not record the reader.
> So the reader loads the pointer with rcu_dereference_raw().
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Much improved, thank you!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcutorture.c | 96 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 90 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 93ca7f06371e..9889293c968b 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -117,6 +117,7 @@ torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testin
>  torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
>  torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
>  torture_param(bool, nmi_calls, true, "Exercise ->call() from NMI on nmi_capable flavors");
> +torture_param(bool, nmi_readers, true, "Run readers from NMI with NMI-safe reader flavors");
>  torture_param(int, nreaders, -1, "Number of RCU reader threads");
>  torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)");
>  torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
> @@ -220,6 +221,11 @@ static atomic_long_t n_rcu_torture_timers;
>  static atomic_long_t n_rcu_torture_irqs;
>  static atomic_long_t n_rcu_torture_nmi_call;
>  static atomic_long_t n_rcu_torture_nmi_cb;
> +static atomic_long_t n_rcu_torture_nmi_read;
> +// Pipe and batch counts of the readers in NMI, as rcu_torture_count and
> +// rcu_torture_batch for the others.  An NMI may interrupt this_cpu_inc().
> +static atomic_long_t rcu_torture_nmi_pipe[RCU_TORTURE_PIPE_LEN + 1];
> +static atomic_long_t rcu_torture_nmi_batch[RCU_TORTURE_PIPE_LEN + 1];
>  static long n_barrier_attempts;
>  static long n_barrier_successes; /* did rcu_barrier test succeed? */
>  static unsigned long n_read_exits;
> @@ -438,6 +444,7 @@ struct rcu_torture_ops {
>  	long cbflood_max;
>  	int irq_capable;
>  	int nmi_capable;
> +	bool (*nmi_reader_capable)(void); // Are ->readlock() and ->readunlock() NMI-safe?
>  	int can_boost;
>  	int extendables;
>  	int slow_gps;
> @@ -790,6 +797,14 @@ static int srcu_torture_read_lock(void)
>  	return ret;
>  }
>  
> +// Only these reader flavors may be used from NMI.
> +static bool srcu_torture_nmi_reader_capable(void)
> +{
> +	return reader_flavor &&
> +	       !(reader_flavor & ~(SRCU_READ_FLAVOR_NMI | SRCU_READ_FLAVOR_FAST |
> +				   SRCU_READ_FLAVOR_ATOMIC));
> +}
> +
>  static void
>  srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
>  {
> @@ -981,6 +996,7 @@ static struct rcu_torture_ops srcu_ops = {
>  	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
>  				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
>  	.nmi_capable	= 1,
> +	.nmi_reader_capable = srcu_torture_nmi_reader_capable,
>  	.name		= "srcu"
>  };
>  
> @@ -1049,6 +1065,7 @@ static struct rcu_torture_ops srcud_ops = {
>  	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
>  				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
>  	.nmi_capable	= 1,
> +	.nmi_reader_capable = srcu_torture_nmi_reader_capable,
>  	.name		= "srcud"
>  };
>  
> @@ -2711,6 +2728,10 @@ static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
>   * per-CPU hardware perf counter overflows into an NMI, and its handler submits
>   * a preallocated callback via ->call().  One callback per CPU is in flight at a
>   * time (guarded by an atomic) to avoid allocating in NMI.
> + *
> + * The same handler also runs a reader, for flavors whose ->nmi_reader_capable()
> + * says that their readers are NMI-safe.  The reader may interrupt another
> + * reader on its CPU, in the middle of its counter update.
>   */
>  #ifdef CONFIG_PERF_EVENTS
>  static struct perf_event_attr rcu_torture_nmi_attr = {
> @@ -2735,6 +2756,8 @@ struct rcu_torture_nmi_cb {
>  
>  static struct perf_event **rcu_torture_nmi_events;
>  static int rcu_torture_nmi_hp_state;
> +static bool rcu_torture_nmi_do_calls;
> +static bool rcu_torture_nmi_do_reads;
>  static DEFINE_PER_CPU(struct rcu_torture_nmi_cb, rcu_torture_nmi_cb);
>  
>  static void rcu_torture_nmi_invoked(struct rcu_head *rhp)
> @@ -2745,6 +2768,34 @@ static void rcu_torture_nmi_invoked(struct rcu_head *rhp)
>  	atomic_set(&rtncp->inuse, 0);
>  }
>  
> +/*
> + * A reader in NMI.  The NMI may interrupt lockdep, which then does not record
> + * the reader, so the pointer is loaded without a lockdep check.  The element
> + * must not go through two grace periods before the reader ends.
> + * rcu_torture_stats_print() checks this in the pipe counts.
> + */
> +static void rcu_torture_nmi_read(void)
> +{
> +	unsigned long started, completed;
> +	struct rcu_torture *p;
> +	int idx, pipe_count;
> +
> +	idx = cur_ops->readlock();
> +	started = cur_ops->get_gp_seq();
> +	p = rcu_dereference_raw(rcu_torture_current);
> +	if (p) {
> +		if (!READ_ONCE(p->rtort_mbtest))
> +			atomic_inc(&n_rcu_torture_mberror);
> +		pipe_count = min(READ_ONCE(p->rtort_pipe_count), RCU_TORTURE_PIPE_LEN);
> +		completed = rcutorture_seq_diff(cur_ops->get_gp_seq(), started);
> +		completed = min_t(unsigned long, completed, RCU_TORTURE_PIPE_LEN);
> +		atomic_long_inc(&rcu_torture_nmi_pipe[pipe_count]);
> +		atomic_long_inc(&rcu_torture_nmi_batch[completed]);
> +	}
> +	cur_ops->readunlock(idx);
> +	atomic_long_inc(&n_rcu_torture_nmi_read);
> +}
> +
>  static void rcu_torture_nmi_overflow(struct perf_event *event,
>  				     struct perf_sample_data *data,
>  				     struct pt_regs *regs)
> @@ -2753,10 +2804,12 @@ static void rcu_torture_nmi_overflow(struct perf_event *event,
>  
>  	if (!in_nmi())
>  		return;
> -	if (cur_ops->call && !atomic_xchg(&rtncp->inuse, 1)) {
> +	if (rcu_torture_nmi_do_calls && !atomic_xchg(&rtncp->inuse, 1)) {
>  		atomic_long_inc(&n_rcu_torture_nmi_call);
>  		cur_ops->call(&rtncp->rh, rcu_torture_nmi_invoked);
>  	}
> +	if (rcu_torture_nmi_do_reads)
> +		rcu_torture_nmi_read();
>  }
>  
>  static int rcu_torture_nmi_online(unsigned int cpu)
> @@ -2789,7 +2842,10 @@ static void rcu_torture_nmi_init(void)
>  {
>  	int ret;
>  
> -	if (!nmi_calls || !cur_ops->nmi_capable || !cur_ops->call)
> +	rcu_torture_nmi_do_calls = nmi_calls && cur_ops->nmi_capable && cur_ops->call;
> +	rcu_torture_nmi_do_reads = nmi_readers && cur_ops->nmi_reader_capable &&
> +				   cur_ops->nmi_reader_capable();
> +	if (!rcu_torture_nmi_do_calls && !rcu_torture_nmi_do_reads)
>  		return;
>  	rcu_torture_nmi_events = kzalloc_objs(*rcu_torture_nmi_events,
>  					      nr_cpu_ids);
> @@ -2815,9 +2871,12 @@ static void rcu_torture_nmi_cleanup(void)
>  	}
>  	kfree(rcu_torture_nmi_events);
>  	rcu_torture_nmi_events = NULL;
> -	if (!atomic_long_read(&n_rcu_torture_nmi_call))
> +	if (rcu_torture_nmi_do_calls && !atomic_long_read(&n_rcu_torture_nmi_call))
>  		pr_alert("%s: nmi_calls set but no ->call() ever issued from NMI, so NMI ->call() went untested (no PMU, or NMIs unavailable here).\n",
>  			 __func__);
> +	if (rcu_torture_nmi_do_reads && !atomic_long_read(&n_rcu_torture_nmi_read))
> +		pr_alert("%s: nmi_readers set but no reader ever ran in NMI, so NMI readers went untested (no PMU, or NMIs unavailable here).\n",
> +			 __func__);
>  }
>  #else /* #ifdef CONFIG_PERF_EVENTS */
>  static void rcu_torture_nmi_init(void) { }
> @@ -3152,6 +3211,7 @@ rcu_torture_stats_print(void)
>  	int cpu;
>  	int i;
>  	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> +	int j;
>  	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
>  	long n_gpwraps = 0;
>  	unsigned long ndowns = 0;
> @@ -3183,6 +3243,10 @@ rcu_torture_stats_print(void)
>  		if (pipesummary[i] != 0)
>  			break;
>  	} // The value of variable "i" is used later, so don't clobber it!
> +	for (j = RCU_TORTURE_PIPE_LEN; j >= 0; j--) {
> +		if (atomic_long_read(&rcu_torture_nmi_pipe[j]))
> +			break;
> +	} // Same for "j", for the readers in NMI.
>  
>  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
>  	rtcp = rcu_access_pointer(rcu_torture_current);
> @@ -3212,9 +3276,10 @@ rcu_torture_stats_print(void)
>  		data_race(n_barrier_attempts),
>  		data_race(n_rcu_torture_barrier_error));
>  	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
> -	pr_cont("nmi-calls: %ld nmi-cbs: %ld ",
> +	pr_cont("nmi-calls: %ld nmi-cbs: %ld nmi-reads: %ld ",
>  		atomic_long_read(&n_rcu_torture_nmi_call),
> -		atomic_long_read(&n_rcu_torture_nmi_cb));
> +		atomic_long_read(&n_rcu_torture_nmi_cb),
> +		atomic_long_read(&n_rcu_torture_nmi_read));
>  	pr_cont("nocb-toggles: %ld:%ld ",
>  		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
>  	pr_cont("gpwraps: %ld\n", n_gpwraps);
> @@ -3223,7 +3288,7 @@ rcu_torture_stats_print(void)
>  	if (atomic_read(&n_rcu_torture_mberror) ||
>  	    atomic_read(&n_rcu_torture_mbchk_fail) ||
>  	    n_rcu_torture_barrier_error || n_rcu_torture_boost_ktrerror ||
> -	    n_rcu_torture_boost_failure || i > 1) {
> +	    n_rcu_torture_boost_failure || i > 1 || j > 1) {
>  		pr_cont("%s", "!!! ");
>  		atomic_inc(&n_rcu_torture_error);
>  		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mberror));
> @@ -3232,6 +3297,7 @@ rcu_torture_stats_print(void)
>  		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
>  		WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost failed (TIMER_SOFTIRQ RT prio?)
>  		WARN_ON_ONCE(i > 1); // Too-short grace period
> +		WARN_ON_ONCE(j > 1); // Too-short grace period, reader in NMI
>  	}
>  	pr_cont("Reader Pipe: ");
>  	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
> @@ -3244,6 +3310,20 @@ rcu_torture_stats_print(void)
>  		pr_cont(" %ld", batchsummary[i]);
>  	pr_cont("\n");
>  
> +	if (atomic_long_read(&n_rcu_torture_nmi_read)) {
> +		pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> +		pr_cont("NMI Reader Pipe: ");
> +		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
> +			pr_cont(" %ld", atomic_long_read(&rcu_torture_nmi_pipe[i]));
> +		pr_cont("\n");
> +
> +		pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> +		pr_cont("NMI Reader Batch: ");
> +		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
> +			pr_cont(" %ld", atomic_long_read(&rcu_torture_nmi_batch[i]));
> +		pr_cont("\n");
> +	}
> +
>  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
>  	pr_cont("Free-Block Circulation: ");
>  	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
> @@ -5049,6 +5129,10 @@ rcu_torture_init(void)
>  			per_cpu(rcu_torture_batch, cpu)[i] = 0;
>  		}
>  	}
> +	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
> +		atomic_long_set(&rcu_torture_nmi_pipe[i], 0);
> +		atomic_long_set(&rcu_torture_nmi_batch[i], 0);
> +	}
>  	err_segs_recorded = 0;
>  	rt_read_nsegs = 0;
>  
> -- 
> 2.47.3
> 
