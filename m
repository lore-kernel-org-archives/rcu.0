Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903799;
	b=T70lI6wIawnnlTWLm/YZq3iAbQk+9gXXZxakon4R9OxyK/uWvqZz7Svsqr0y1MGdoA38
	 kCh+XAO48isz3inLI5aIFQFq5FWNC0nyO/wSnC596C47uzi27GmpP/QG0qxCXgEJ9bMdm
	 18aENVb6ONwRu18Sd5pA7Tz6QmyK/vDObaTAkN8nLojZu+PfXwiqpULqaxcoamL8Ml4RI
	 5GqvdDbrqZTRHpzlj8XsVD4i8VkRJe/LJwLUzfvyEuahb/6+b5e4A/wbDqZWe43ooy0P4
	 QWPD3x3aUdJE2dYdFDeM2pb2G0dhozjvrA1pp7IxDRvnPUQRussz9qimyJhtXmguGSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903799;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=PQzQLYj3/4QpqtgyftolbBjLZgttgpD6Pbn7rRisaHQ=;
	b=tD4fguDkJnsSnZFfijQNAz46eG/etTfsPumlUA1BzmP+fTExLS2vCpqsqwLGnw2V4RmN
	 mZ4XfPDGzS3DwaSI95jK7E6aufd/H+BpaN+m7N1EGGVmB5hMOSWhwMuwfMFx8ut6G/RAd
	 8IV8l50WoZiuOkNmzj18iBE7vNRSwyI+yRaWf2QlfGlHA6YA2fBXcSJS4ha6iVVyS/Bra
	 WxcAHG05/VSfaO/wCaNZzw7Q8+zx4uTSXgiSTDu9ejFqOiwMcUpjfn7wT+JYaU2NiYF+V
	 f2EEylHNSupn4AHECOahP4JQkBBvRsE7Vuk1JbzmziL6yqBqIjl452T4hr95ZhsX/fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avu+02Si;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C7606A326;
	Thu,  5 Nov 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avu+02Si
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C270E1F000C1;
	Thu,  5 Nov 2026 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903798;
	bh=PQzQLYj3/4QpqtgyftolbBjLZgttgpD6Pbn7rRisaHQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=avu+02Si1yeJGBhjpFIzCtiuyP/WhQtsiq2Z0xT6rwWX3QDqR98arrUmvovu08JIL
	 Otl5yhBi/CgDzFyW9vi1Qui4bKmKhJT518A3HmnDIk/qTXZ5ef3G7D3ekS2TLCWgmR
	 hRpbTY5/hSHDcLq6XbJ9fX2NdVa1/nwMpZwD59NGZwglyBVLjV8mWkCTdyH/gC6NHl
	 bmHoh+cg+6jPuiosVygwgC76EMEDArjNgzchZ2zzXXF5U4THH/vwOkkehzfZmwVZ2k
	 5mf5mPXB91vAtoY02JaQ6jIt7dbxVWPGS9q+AfRjk84aj8QoHDEGvwbf8hXIig9fEC
	 f5/U+zK2ZfsYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D961CE0897; Thu,  5 Nov 2026 10:36:38 -0800 (PST)
Date: Thu, 5 Nov 2026 10:36:38 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261105165113.82N-rPMG@linutronix.de>
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
In-Reply-To: <20261105165113.82N-rPMG@linutronix.de>

On Thu, Nov 05, 2026 at 05:51:13PM +0100, Sebastian Andrzej Siewior wrote:
> Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
> tests") added the ability to disable RT throttling while rcutorture was
> run.
> 
> Since v6.12 the DL fair_server takes control of throttling and this
> interface no longer serves this purpose. That sysctl control still
> exists but serves a different cause.
> 
> There is no in-kernel interface to provide this feature, one needs to
> echo -1 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.
> 
> Since sysctl_sched_rt_runtime does not do what it once did, remove it
> from rcutorture.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you, but ouch...  Does this mean that there is no longer any useful
in-kernel way to test RCU priority boosting?

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h        |  2 --
>  kernel/rcu/rcutorture.c | 35 -----------------------------------
>  2 files changed, 37 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index d60444bf3a02d..6d1034e49d411 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -69,8 +69,6 @@
>  /* A complete grace period count */
>  #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
>  
> -extern int sysctl_sched_rt_runtime;
> -
>  /*
>   * Return the counter portion of a sequence number previously returned
>   * by rcu_seq_snap() or rcu_seq_current().
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 968343be4e0d1..acab425e72ad5 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1333,39 +1333,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
>  	return cur_ops->gp_diff(new, old);
>  }
>  
> -/*
> - * RCU torture priority-boost testing.  Runs one real-time thread per
> - * CPU for moderate bursts, repeatedly starting grace periods and waiting
> - * for them to complete.  If a given grace period takes too long, we assume
> - * that priority inversion has occurred.
> - */
> -
> -static int old_rt_runtime = -1;
> -
> -static void rcu_torture_disable_rt_throttle(void)
> -{
> -	/*
> -	 * Disable RT throttling so that rcutorture's boost threads don't get
> -	 * throttled. Only possible if rcutorture is built-in otherwise the
> -	 * user should manually do this by setting the sched_rt_period_us and
> -	 * sched_rt_runtime sysctls.
> -	 */
> -	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
> -		return;
> -
> -	old_rt_runtime = sysctl_sched_rt_runtime;
> -	sysctl_sched_rt_runtime = -1;
> -}
> -
> -static void rcu_torture_enable_rt_throttle(void)
> -{
> -	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
> -		return;
> -
> -	sysctl_sched_rt_runtime = old_rt_runtime;
> -	old_rt_runtime = -1;
> -}
> -
>  static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
>  {
>  	int cpu;
> @@ -3390,7 +3357,6 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
>  	mutex_lock(&boost_mutex);
>  	t = boost_tasks[cpu];
>  	boost_tasks[cpu] = NULL;
> -	rcu_torture_enable_rt_throttle();
>  	mutex_unlock(&boost_mutex);
>  
>  	/* This must be outside of the mutex, otherwise deadlock! */
> @@ -3428,7 +3394,6 @@ static int rcutorture_booster_init(unsigned int cpu)
>  
>  	/* Don't allow time recalculation while creating a new task. */
>  	mutex_lock(&boost_mutex);
> -	rcu_torture_disable_rt_throttle();
>  	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
>  	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
>  					      cpu, "rcu_torture_boost_%u");
> -- 
> 2.55.0
> 
