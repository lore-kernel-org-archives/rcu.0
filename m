Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2EC3FFABE;
	Mon, 15 Jun 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535951; cv=none; b=JldpV5+hEZ2aedXlT9+pOrssWZ2yCiPGM4ja2JV0K2wepc+fvUPrL614HHpAGjCLsuwjO0DQJefTPKCQrHJQKKGY5R+fRcFAudeJolkmu8zt+PJv/DvLwDWJ62kpKHpcU59ZKVEYhwLha1QxNmd9P1gZZCyvTNw3YlZ6g1O3gKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535951; c=relaxed/simple;
	bh=l/QAVGhk8W4bETvPokZivQ/u3r8qUAb4ep1iM0jb9X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTyxEhz4CY5d4pCB1E8n63dBgbAPrijTO/CpLhhRxDgJKNEQvEXXRNHVcFFy9OwX6/pyl2rnS5DZkMarIYC+EZHVk9x2Rjj8dx1AjwHu2eHbV1tdPF0ycIpwZMsHXca8Fex2YZMm8twStea6jKdWJqgif4PGMFq2gidvqBDa2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX38N2fP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX38N2fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986D11F000E9;
	Mon, 15 Jun 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781535949;
	bh=Inyp+qZ7yPCmrvUKapgAAMQgMbfzVh/POEo0wtHFAG8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=MX38N2fPfecraql1sSFB93p3t+rALDP6Ob4J5XBkGR9GEV++7rAnAtn0EXkHECSWM
	 bMK1r8QPkjdFt1pMmEEH8g8aIXNWxrWcP1FwgVidosLJGTfRiNGu5icn0ox7wtw5RM
	 WKCsGBUmRNukLPo7PKoFn0dFrA3eGgt6qFjukXLNixcAIkkDGm7BxPzEEZvE+RMIrk
	 va+aZX8LOIpsEnuxIh9I8jOruAVnF7cGXqmm0KCbixycFkWr8gSwCV6w53THnP0Pbm
	 7ohPtzkWmVNqszIGirQ9i6EA0lr1aIplEqcBjDfzxZTKq/ZG/xfWP1a0fAK6q1cjpI
	 uGiGg/vw1V2tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 594FECE0077; Mon, 15 Jun 2026 08:05:49 -0700 (PDT)
Date: Mon, 15 Jun 2026 08:05:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	aboorvad@linux.ibm.com, peterz@infradead.org, boqun.feng@gmail.com,
	frederic@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org,
	neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
	srikar@linux.ibm.com, sshegde@linux.ibm.com, tglx@linutronix.de,
	urezki@gmail.com, samir@linux.ibm.com
Subject: Re: [PATCH v5 1/1] cpuhp: Expedite RCU when toggling system-wide SMT
 mode
Message-ID: <f1a04d2f-367e-4be8-b313-31a73e15bcd0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260615042514.694993-2-vishalc@linux.ibm.com>
 <20260615042514.694993-4-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615042514.694993-4-vishalc@linux.ibm.com>

On Mon, Jun 15, 2026 at 09:55:16AM +0530, Vishal Chourasia wrote:
> On large idle systems, changing system-wide SMT level using the sysfs
> control interface still takes approximately 40-55 minutes. Changing SMT
> levels is an user triggered operation generally done when systems are
> fairly idle. This causes users to be blocked from doing other subsequent
> work.
> 
> Analyzing the collected profile data during SMT level switch, showed
> that CPU hotplug machinery was blocked on synchronize_rcu() calls.
> 
> Expedite RCU grace periods for the entire duration of triggered SMT
> switch operation via the sysfs control interface. Individual CPU hotplug
> operations via the online/offline interface are not affected.
> 
> On a PPC64 system with 400 CPUs:
> 
>   SMT8 to SMT1:
>     before:  1m14s
>     after:   3.2s   (~23x faster)
> 
>   SMT1 to SMT8:
>     before:  2m27s
>     after:   2.5s   (~58x faster)
> 
> On a large config system with 1920 CPUs, completion time improves from
> ~1 hour to 5-6 minutes.
> 
> Tested-by: Samir <samir@linux.ibm.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

From an RCU viewpoint:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

I am guessing that you will be taking this up some other path, but if
you would like it to to via RCU, please let me know.

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 8 ++++++++
>  kernel/cpu.c             | 4 ++++
>  kernel/rcu/rcu.h         | 4 ----
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index bfa765132de8..b6bccf131f1c 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1178,6 +1178,14 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>  extern int rcu_expedited;
>  extern int rcu_normal;
>  
> +#ifdef CONFIG_TINY_RCU
> +static inline void rcu_expedite_gp(void) { }
> +static inline void rcu_unexpedite_gp(void) { }
> +#else
> +void rcu_expedite_gp(void);
> +void rcu_unexpedite_gp(void);
> +#endif
> +
>  DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
>  DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
>  
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bc4f7a9ba64e..6351da9dffdc 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2658,6 +2658,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  	int cpu, ret = 0;
>  
>  	cpu_maps_update_begin();
> +	rcu_expedite_gp();
>  	for_each_online_cpu(cpu) {
>  		if (topology_is_primary_thread(cpu))
>  			continue;
> @@ -2687,6 +2688,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  	}
>  	if (!ret)
>  		cpu_smt_control = ctrlval;
> +	rcu_unexpedite_gp();
>  	cpu_maps_update_done();
>  	return ret;
>  }
> @@ -2704,6 +2706,7 @@ int cpuhp_smt_enable(void)
>  	int cpu, ret = 0;
>  
>  	cpu_maps_update_begin();
> +	rcu_expedite_gp();
>  	cpu_smt_control = CPU_SMT_ENABLED;
>  	for_each_present_cpu(cpu) {
>  		/* Skip online CPUs and CPUs on offline nodes */
> @@ -2717,6 +2720,7 @@ int cpuhp_smt_enable(void)
>  		/* See comment in cpuhp_smt_disable() */
>  		cpuhp_online_cpu_device(cpu);
>  	}
> +	rcu_unexpedite_gp();
>  	cpu_maps_update_done();
>  	return ret;
>  }
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index fa6d30ce73d1..d6a63ee60bc0 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -521,8 +521,6 @@ do {									\
>  static inline bool rcu_gp_is_normal(void) { return true; }
>  static inline bool rcu_gp_is_expedited(void) { return false; }
>  static inline bool rcu_async_should_hurry(void) { return false; }
> -static inline void rcu_expedite_gp(void) { }
> -static inline void rcu_unexpedite_gp(void) { }
>  static inline void rcu_async_hurry(void) { }
>  static inline void rcu_async_relax(void) { }
>  static inline bool rcu_cpu_online(int cpu) { return true; }
> @@ -530,8 +528,6 @@ static inline bool rcu_cpu_online(int cpu) { return true; }
>  bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>  bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
>  bool rcu_async_should_hurry(void);  /* Internal RCU use. */
> -void rcu_expedite_gp(void);
> -void rcu_unexpedite_gp(void);
>  void rcu_async_hurry(void);
>  void rcu_async_relax(void);
>  void rcupdate_announce_bootup_oddness(void);
> -- 
> 2.54.0
> 
