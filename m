Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350785;
	b=NdFKWKVmKP5f0H4gvTRjmvJ/CPfNQ0CHbtCmJpPPZf+ImBCHE53kRdF4eGEBBMCkjO1n
	 DHwXw66HesRvwxim1UppzjZ6nKNCgGZN5/cfMXpLeSiVRXsm8qg3pLDsaRTE1TRYVvF5U
	 Zrcxf9lAN7Cauwi98oaScEDoaPLYK17euLfPL6bk/snAGxh2tfSuxe2JDPAfy5WKMd+sZ
	 j+28RNMC8vvFO2ZQEi8YeV0+nUBFypgO+7t6JNLz5al0+5AueXnZMo2fqS/tIj0lKOsUm
	 RWwe2wTHjx6NacqGOek17evHQVFcHQ4atmj9wpH+L+jJuA+mM0xC7i3TXxj3KvzwqAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350785;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=lEj15H99kgOc31r/1P/dL3/dkxrGaSx+nMeoaCzfsQQ=;
	b=RGJmC55fATb2d/UAns9PYcY+68TJyY5pXtoxxu9B7r5Wc2ylXUZg/X2gJdML0QYCPHcd
	 JaxT5PGH6DDRyw6GBsnoUScXWhtFVXitUHS0f2I+tnSgg5diCDx3mTO7SstNA/c251L1O
	 pr8sqdMiO5C3THqGeJT0WFhUQPh3z+E0MdIUTPLysJpKfudgwk+XnnGAbuzT2OjJTwM4V
	 eo85h53ayQfeieKPACj6v+GSvHOHbAr4NzgxkHA/ERwOpmS2eKL2jZDxnsSBoALWDJotZ
	 9F0AXw84SIvucLatc+FE7BynSvzt2+ZayIZlcCeQS/3SC6rLrspElo79EG6kN2A28Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJVMWi3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A982606A31C;
	Tue, 10 Nov 2026 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJVMWi3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA2E1F0093C;
	Tue, 10 Nov 2026 22:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350785;
	bh=lEj15H99kgOc31r/1P/dL3/dkxrGaSx+nMeoaCzfsQQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=dJVMWi3MmsxtpjCmBk2tFZWukrqy45m5aOaH5NyjvcA3VB2rBGWpaQ+YpPNDVfkqX
	 +EHdQE/l1bG5e315+A4hUn6PGYmHRIjHa1kUgZq67rGrQidYLdl8XKChvhsgVoBd9o
	 PWkPvIV0KPXiTb4qasHv6ugupUQWBk/q2blbmaRyXQNIPNOKIV2NEwPWlDqK8Fzgmr
	 nMfAofqXTuCvok8lbBgs0rzWdSTmtxC9leVvcD8pObCFmWQ5+otDaK+VaCcCr2UwcT
	 ZyBiUOQbrhjU+o5YZlKlyieoHy5DRbMige6loOTJUtGhbtYDlHxfu+qKZ0NQX66D1h
	 mbHHvFI/9Q31w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D54A1CE0AD8; Tue, 10 Nov 2026 14:46:24 -0800 (PST)
Date: Tue, 10 Nov 2026 14:46:24 -0800
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
Subject: Re: [PATCH 3/4] rcutorture: Run NMI-safe SRCU readers from NMI
Message-ID: <9fbcb43b-ddea-44bf-b339-d01ba723d5a2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
 <20261110192844.44713-4-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261110192844.44713-4-mathieu.desnoyers@efficios.com>

On Tue, Nov 10, 2026 at 02:28:43PM -0500, Mathieu Desnoyers wrote:
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
> The NMI may interrupt lockdep, which then does not record the reader.
> So the reader loads the pointer with rcu_dereference_raw().
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

A good addition!  Vanilla RCU could benefit from this as well, but that
can be done later.

A few questions below.

						Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 60 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 55 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 968343be4e0d..3b9c08a094cd 100644
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
> @@ -220,6 +221,7 @@ static atomic_long_t n_rcu_torture_timers;
>  static atomic_long_t n_rcu_torture_irqs;
>  static atomic_long_t n_rcu_torture_nmi_call;
>  static atomic_long_t n_rcu_torture_nmi_cb;
> +static atomic_long_t n_rcu_torture_nmi_read;
>  static long n_barrier_attempts;
>  static long n_barrier_successes; /* did rcu_barrier test succeed? */
>  static unsigned long n_read_exits;
> @@ -438,6 +440,7 @@ struct rcu_torture_ops {
>  	long cbflood_max;
>  	int irq_capable;
>  	int nmi_capable;
> +	bool (*nmi_reader_capable)(void); // Are ->readlock() and ->readunlock() NMI-safe?
>  	int can_boost;
>  	int extendables;
>  	int slow_gps;
> @@ -790,6 +793,14 @@ static int srcu_torture_read_lock(void)
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
> @@ -981,6 +992,7 @@ static struct rcu_torture_ops srcu_ops = {
>  	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
>  				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
>  	.nmi_capable	= 1,
> +	.nmi_reader_capable = srcu_torture_nmi_reader_capable,
>  	.name		= "srcu"
>  };
>  
> @@ -1049,6 +1061,7 @@ static struct rcu_torture_ops srcud_ops = {
>  	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
>  				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
>  	.nmi_capable	= 1,
> +	.nmi_reader_capable = srcu_torture_nmi_reader_capable,
>  	.name		= "srcud"
>  };
>  
> @@ -2711,6 +2724,10 @@ static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
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
> @@ -2735,6 +2752,8 @@ struct rcu_torture_nmi_cb {
>  
>  static struct perf_event **rcu_torture_nmi_events;
>  static int rcu_torture_nmi_hp_state;
> +static bool rcu_torture_nmi_do_calls;
> +static bool rcu_torture_nmi_do_reads;
>  static DEFINE_PER_CPU(struct rcu_torture_nmi_cb, rcu_torture_nmi_cb);
>  
>  static void rcu_torture_nmi_invoked(struct rcu_head *rhp)
> @@ -2745,6 +2764,28 @@ static void rcu_torture_nmi_invoked(struct rcu_head *rhp)
>  	atomic_set(&rtncp->inuse, 0);
>  }
>  
> +/*
> + * A reader in NMI.  The NMI may interrupt lockdep, which then does not record
> + * the reader, so the pointer is loaded without a lockdep check.  The element
> + * must not go through two grace periods before the reader ends.
> + */
> +static void rcu_torture_nmi_read(void)
> +{
> +	struct rcu_torture *p;
> +	int idx;
> +
> +	idx = cur_ops->readlock();
> +	p = rcu_dereference_raw(rcu_torture_current);
> +	if (p) {
> +		if (!READ_ONCE(p->rtort_mbtest))
> +			atomic_inc(&n_rcu_torture_mberror);
> +		if (READ_ONCE(p->rtort_pipe_count) > 1)
> +			atomic_inc(&n_rcu_torture_error);

Doesn't this miss doing a splat on RCU too-short grace period?

One way to handle this is to have a separate n_rcu_torture_nmi_error
counter and then have rcu_torture_stats_print() sample this counter before
the "for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--)" loop and apply it there.

But that loses the visible count in the "Reader Pipe:" line.  Which
would be *really* confusing.  And we don't need atomic operations
slowing up non-NMI RCU readers, either.

Maybe a separate global array for NMIs, parallel to the "Reader Pipe:"
and "Reader Batch:" arrays, that is atomically updated and printed
separately, maybe "NMI Reader Pipe:" or similar?

Or is there a better way?

> +	}
> +	cur_ops->readunlock(idx);
> +	atomic_long_inc(&n_rcu_torture_nmi_read);
> +}
> +
>  static void rcu_torture_nmi_overflow(struct perf_event *event,
>  				     struct perf_sample_data *data,
>  				     struct pt_regs *regs)
> @@ -2753,10 +2794,12 @@ static void rcu_torture_nmi_overflow(struct perf_event *event,
>  
>  	if (!in_nmi())
>  		return;
> -	if (cur_ops->call && !atomic_xchg(&rtncp->inuse, 1)) {
> +	if (rcu_torture_nmi_do_calls && !atomic_xchg(&rtncp->inuse, 1)) {
>  		atomic_long_inc(&n_rcu_torture_nmi_call);
>  		cur_ops->call(&rtncp->rh, rcu_torture_nmi_invoked);

OK, the invocation of ->call() without testing ->call() is OK because
rcu_torture_nmi_do_calls never gets set if ->call() is NULL.

>  	}
> +	if (rcu_torture_nmi_do_reads)
> +		rcu_torture_nmi_read();
>  }
>  
>  static int rcu_torture_nmi_online(unsigned int cpu)
> @@ -2789,7 +2832,10 @@ static void rcu_torture_nmi_init(void)
>  {
>  	int ret;
>  
> -	if (!nmi_calls || !cur_ops->nmi_capable || !cur_ops->call)
> +	rcu_torture_nmi_do_calls = nmi_calls && cur_ops->nmi_capable && cur_ops->call;
> +	rcu_torture_nmi_do_reads = nmi_readers && cur_ops->nmi_reader_capable &&
> +				   cur_ops->nmi_reader_capable();
> +	if (!rcu_torture_nmi_do_calls && !rcu_torture_nmi_do_reads)
>  		return;
>  	rcu_torture_nmi_events = kcalloc(nr_cpu_ids, sizeof(*rcu_torture_nmi_events),
>  					 GFP_KERNEL);
> @@ -2815,9 +2861,12 @@ static void rcu_torture_nmi_cleanup(void)
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
> @@ -3212,9 +3261,10 @@ rcu_torture_stats_print(void)
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
> -- 
> 2.47.3
> 
