Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA61B394B;
	Tue, 21 Jan 2025 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479282; cv=none; b=J69boLB5oKfbQqZLhHz0jHvMdxslMxbpIkXVmyNhXBezlL3afy6eRLWshZqRvWkouUJHP81KEIwFPixppKd3ClYz4Va/gvk3z1odLzSKhlspCPrv35NrN9cqcwLXTcmRlxVPBcklgazJVSdOSVfHSeOvFARkqaa8KQlX9u8nLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479282; c=relaxed/simple;
	bh=i/t7Viv9ocepCP4YmoEudPmDhuT1QTiMPp1fVdgKKyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8TKHCHx6iYVmA2ZbKGeQB58TY5UQdLPkJNVVyRWaFp6Ze61W6kSXIIetC83HG9obEOLhCK51bAGWKPf71Ndaoz3LetLYzldUXEmx7hVKZ55JuWDOxkmnLC/MEHyhSSthy6xNT6wZz1wI775uydId/5J4PSe+LDdanFIwTDEWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKrCIJoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKrCIJoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428D8C4CEE0;
	Tue, 21 Jan 2025 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737479282;
	bh=i/t7Viv9ocepCP4YmoEudPmDhuT1QTiMPp1fVdgKKyw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PKrCIJoPDXdPo6f5eaAofQgE6GcIScNFF13keZVVlalI56HPP6TKyqNivlQnGncI7
	 9LSE8C27AW8d0ZshP7eOYM1io2ocxdEVj+HFoSiHgz1PozcH5UIYY/QCtDmrETTThb
	 gnfI0ykAh+rlcpjz1ItPPFqS4G5zJZ3mvs0WarpnUY5UbEAZ1rZ0MnbyumQexUezce
	 vN4ZVNcx0Z2FGOUdPcfhxo1FjXBqLeTjyZbh+BSsnbmaOc0bipIOlawVKrnlE18Gge
	 9zdZy7FSnzuFlPP1Sz/waCesjRXTd0nA19ukbmn4Doru75fd5s43SF+90Ib8OIA3Fz
	 omp1w6wwfTYwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DA1ECCE0F22; Tue, 21 Jan 2025 09:08:01 -0800 (PST)
Date: Tue, 21 Jan 2025 09:08:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
	rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org, kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Message-ID: <a7cb64fb-1c17-4316-abf8-e6a7e07ba4d1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250117232433.24027-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117232433.24027-1-frederic@kernel.org>

On Sat, Jan 18, 2025 at 12:24:33AM +0100, Frederic Weisbecker wrote:
> hrtimers are migrated away from the dying CPU to any online target at
> the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
> handling tasks involved in the CPU hotplug forward progress.
> 
> However wake ups can still be performed by the outgoing CPU after
> CPUHP_AP_HRTIMERS_DYING. Those can result again in bandwidth timers
> being armed. Depending on several considerations (crystal ball
> power management based election, earliest timer already enqueued, timer
> migration enabled or not), the target may eventually be the current
> CPU even if offline. If that happens, the timer is eventually ignored.
> 
> The most notable example is RCU which had to deal with each and every of
> those wake-ups by deferring them to an online CPU, along with related
> workarounds:
> 
> _ e787644caf76 (rcu: Defer RCU kthreads wakeup when CPU is dying)
> _ 9139f93209d1 (rcu/nocb: Fix RT throttling hrtimer armed from offline CPU)
> _ f7345ccc62a4 (rcu/nocb: Fix rcuog wake-up from offline softirq)
> 
> The problem isn't confined to RCU though as the stop machine kthread
> (which runs CPUHP_AP_HRTIMERS_DYING) reports its completion at the end
> of its work through cpu_stop_signal_done() and performs a wake up that
> eventually arms the deadline server timer:
> 
>            WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
>            CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
>            Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
>            RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
>            Call Trace:
>             <TASK>
>             ? hrtimer_start_range_ns
>             start_dl_timer
>             enqueue_dl_entity
>             dl_server_start
>             enqueue_task_fair
>             enqueue_task
>             ttwu_do_activate
>             try_to_wake_up
>             complete
>             cpu_stopper_thread
>             smpboot_thread_fn
>             kthread
>             ret_from_fork
>             ret_from_fork_asm
>             </TASK>
> 
> Instead of providing yet another bandaid to work around the situation,
> fix it from hrtimers infrastructure instead: always migrate away a
> timer to an online target whenever it is enqueued from an offline CPU.
> 
> This will also allow to revert all the above RCU disgraceful hacks.
> 
> Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
> Reported-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

This passes over-holiday testing rcutorture, so, perhaps redundantly:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/hrtimer_defs.h |  1 +
>  kernel/time/hrtimer.c        | 92 +++++++++++++++++++++++++++++-------
>  2 files changed, 75 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
> index c3b4b7ed7c16..84a5045f80f3 100644
> --- a/include/linux/hrtimer_defs.h
> +++ b/include/linux/hrtimer_defs.h
> @@ -125,6 +125,7 @@ struct hrtimer_cpu_base {
>  	ktime_t				softirq_expires_next;
>  	struct hrtimer			*softirq_next_timer;
>  	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
> +	call_single_data_t		csd;
>  } ____cacheline_aligned;
>  
>  
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 030426c8c944..082d4b687fa1 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -58,6 +58,8 @@
>  #define HRTIMER_ACTIVE_SOFT	(HRTIMER_ACTIVE_HARD << MASK_SHIFT)
>  #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
>  
> +static void retrigger_next_event(void *arg);
> +
>  /*
>   * The timer bases:
>   *
> @@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
>  			.clockid = CLOCK_TAI,
>  			.get_time = &ktime_get_clocktai,
>  		},
> -	}
> +	},
> +	.csd = CSD_INIT(retrigger_next_event, NULL)
>  };
>  
>  static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
> @@ -124,6 +127,14 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
>  	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
>  };
>  
> +static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
> +{
> +	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +		return true;
> +	else
> +		return likely(base->online);
> +}
> +
>  /*
>   * Functions and macros which are different for UP/SMP systems are kept in a
>   * single place
> @@ -183,27 +194,58 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
>  }
>  
>  /*
> - * We do not migrate the timer when it is expiring before the next
> - * event on the target cpu. When high resolution is enabled, we cannot
> - * reprogram the target cpu hardware and we would cause it to fire
> - * late. To keep it simple, we handle the high resolution enabled and
> - * disabled case similar.
> + * Check if the elected target is suitable considering its next
> + * event and the hotplug state of the current CPU.
> + *
> + * If the elected target is remote and its next event is after the timer
> + * to queue, then a remote reprogram is necessary. However there is no
> + * guarantee the IPI handling the operation would arrive in time to meet
> + * the high resolution deadline. In this case the local CPU becomes a
> + * preferred target, unless it is offline.
> + *
> + * High and low resolution modes are handled the same way for simplicity.
>   *
>   * Called with cpu_base->lock of target cpu held.
>   */
> -static int
> -hrtimer_check_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base)
> +static bool
> +hrtimer_suitable_target(struct hrtimer *timer,
> +			struct hrtimer_clock_base *new_base,
> +			struct hrtimer_cpu_base *new_cpu_base,
> +			struct hrtimer_cpu_base *this_cpu_base)
>  {
>  	ktime_t expires;
>  
> +	/*
> +	 * The local CPU clockevent can be reprogrammed. Also get_target_base()
> +	 * guarantees it is online.
> +	 */
> +	if (new_cpu_base == this_cpu_base)
> +		return true;
> +
> +	/*
> +	 * The offline local CPU can't be the default target if the
> +	 * next remote target event is after this timer. Keep the
> +	 * elected new base. An IPI will we issued to reprogram
> +	 * it as a last resort.
> +	 */
> +	if (!hrtimer_base_is_online(this_cpu_base))
> +		return true;
> +
>  	expires = ktime_sub(hrtimer_get_expires(timer), new_base->offset);
> -	return expires < new_base->cpu_base->expires_next;
> +
> +	return expires >= new_base->cpu_base->expires_next;
>  }
>  
>  static inline
>  struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
>  					 int pinned)
>  {
> +	if (!hrtimer_base_is_online(base)) {
> +		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));
> +
> +		return &per_cpu(hrtimer_bases, cpu);
> +	}
> +
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>  	if (static_branch_likely(&timers_migration_enabled) && !pinned)
>  		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
> @@ -254,8 +296,8 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
>  		raw_spin_unlock(&base->cpu_base->lock);
>  		raw_spin_lock(&new_base->cpu_base->lock);
>  
> -		if (new_cpu_base != this_cpu_base &&
> -		    hrtimer_check_target(timer, new_base)) {
> +		if (!hrtimer_suitable_target(timer, new_base, new_cpu_base,
> +					     this_cpu_base)) {
>  			raw_spin_unlock(&new_base->cpu_base->lock);
>  			raw_spin_lock(&base->cpu_base->lock);
>  			new_cpu_base = this_cpu_base;
> @@ -264,8 +306,8 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
>  		}
>  		WRITE_ONCE(timer->base, new_base);
>  	} else {
> -		if (new_cpu_base != this_cpu_base &&
> -		    hrtimer_check_target(timer, new_base)) {
> +		if (!hrtimer_suitable_target(timer, new_base,  new_cpu_base,
> +					     this_cpu_base)) {
>  			new_cpu_base = this_cpu_base;
>  			goto again;
>  		}
> @@ -716,8 +758,6 @@ static inline int hrtimer_is_hres_enabled(void)
>  	return hrtimer_hres_enabled;
>  }
>  
> -static void retrigger_next_event(void *arg);
> -
>  /*
>   * Switch to high resolution mode
>   */
> @@ -1206,6 +1246,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  				    u64 delta_ns, const enum hrtimer_mode mode,
>  				    struct hrtimer_clock_base *base)
>  {
> +	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
>  	struct hrtimer_clock_base *new_base;
>  	bool force_local, first;
>  
> @@ -1217,9 +1258,15 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  	 * and enforce reprogramming after it is queued no matter whether
>  	 * it is the new first expiring timer again or not.
>  	 */
> -	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
> +	force_local = base->cpu_base == this_cpu_base;
>  	force_local &= base->cpu_base->next_timer == timer;
>  
> +	/*
> +	 * Don't force local queuing if this enqueue happens on a unplugged
> +	 * CPU after hrtimer_cpu_dying() has been invoked.
> +	 */
> +	force_local &= this_cpu_base->online;
> +
>  	/*
>  	 * Remove an active timer from the queue. In case it is not queued
>  	 * on the current CPU, make sure that remove_hrtimer() updates the
> @@ -1249,8 +1296,17 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  	}
>  
>  	first = enqueue_hrtimer(timer, new_base, mode);
> -	if (!force_local)
> -		return first;
> +	if (!force_local) {
> +		if (hrtimer_base_is_online(this_cpu_base))
> +			return first;
> +
> +		if (first) {
> +			struct hrtimer_cpu_base *new_cpu_base = new_base->cpu_base;
> +
> +			smp_call_function_single_async(new_cpu_base->cpu, &new_cpu_base->csd);
> +		}
> +		return 0;
> +	}
>  
>  	/*
>  	 * Timer was forced to stay on the current CPU to avoid
> -- 
> 2.46.0
> 
