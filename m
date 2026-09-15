Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163B4A49B2;
	Tue, 15 Sep 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473746; cv=none; b=PGERsdSR91cqzbAV0/OmjFWiZfMyWlwM6udfp+1GAQ99c6vyhODi1yfoxIm3jycnWOFzytqBErxBOUOebu4cYCkuFZBllKKlJi7vcMK0DreKC9ztBVwnd0tt41ysC0ygFVyy9qu1D8plAqrkfDNfDVUgtwaojBQtR/7Sb5l6UaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473746; c=relaxed/simple;
	bh=5Q7bKR1kUQkWAcFCYbVvVw5E9gpJvn/9AsCxZHzfDl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clohUmrlmVrtND54ldHZboDGcB6AJ7cuHrAY3AoXJ7mOE1pibU2h6CSG6yUTN8DsWBCcGkx5vf3LIfpCcz1Yr04OO+WdfXTsRXMMeiZV6unsKqBFiSmK2sygZnZlf/r2JsA/I1KNvIIXF1uto4YRuT35p89/o0wGP5+fuRquAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS7H1T4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS7H1T4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45BD1F000FF;
	Tue, 15 Sep 2026 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473744;
	bh=N0PvebQTQvGBPiT349SA2Guqt05+I7WzXNZZfsnSr1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HS7H1T4Qyfy+OkM1pY5/ZT+fLZ9xAd9kDZ4nuvKW0KM78kKsi8OWdXmzLLGQl0lR+
	 /rNwvlM8c6r9IPgIsMTvI6eo5RcnPGn3tH92+s+NJT0g49NVeHMPKCli4qHOfiTEoJ
	 PPdGdpT7/mRU1E3N1umIWkz4BDucN+ls30Me9NXMOH6Q1bBYzSBrj5CZEihqV2CHMP
	 Ozam2IUN4uGUluVixgex6Sda+lcpTwe+mDqHBi8IM51q0A+YdnO9RCnblevxatO+qT
	 kMrJsJiv2Un6cujazGa2VDieBPQD5m5NGlxpwAG6rcrDiNWhaIhMWM3nruLuU16Bp6
	 lRnOOKEg+OPFw==
Date: Tue, 15 Sep 2026 14:02:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Guard deferred QS on kernel exit behind
 need_deferred_qs() check
Message-ID: <aqkzzeXsVd91X4mZ@localhost.localdomain>
References: <20260915102241.1344738-1-mkchauras@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915102241.1344738-1-mkchauras@gmail.com>

Le Tue, Sep 15, 2026 at 03:52:41PM +0530, Mukesh Kumar Chaurasiya (IBM) a écrit :
> ct_kernel_exit() unconditionally calls rcu_preempt_deferred_qs(current)
> on every return to userspace.

When nohz_full is active, right?

> On the common fast path nothing is
> actually deferred, so this is a needless write to
> current->rcu_read_unlock_special

When nothing is to be deferred, rcu_preempt_deferred_qs() does nothing, right?

And if some nohz_full workloads involve rare syscalls, they usually run a single
task, so no preemption that would trigger a deferred qs.


> -- a word that lives on the task_struct
> and is therefore subject to cross-CPU cache-line traffic.
> 
> On weakly-ordered architectures such as ppc64le, rcu_read_lock() and
> rcu_read_unlock() already issue lwsync/isync barriers and touch that
> same cache line in the syscall body.  Bouncing it again at syscall exit
> adds measurable overhead, particularly on workloads with a high syscall
> rate (e.g. SELinux-heavy workloads where every AVC check issues a
> system call).
> 
> Introduce rcu_ct_kernel_exit_qs() which wraps the deferred-QS call with
> a rcu_preempt_need_deferred_qs() guard, matching the pattern already
> used in rcu_flavor_sched_clock_irq():
> 
>   notrace void rcu_ct_kernel_exit_qs(void)
>   {
>           if (rcu_preempt_need_deferred_qs(current))
>                   rcu_preempt_deferred_qs(current);
>   }
> 
> The declaration is added to <linux/rcutree.h> and a stub no-op is added
> to <linux/rcutiny.h> so that TINY_RCU builds are unaffected.
> 
> ct_kernel_exit() is updated to call rcu_ct_kernel_exit_qs() in place of
> the direct rcu_preempt_deferred_qs() call.  Semantics are identical when
> a deferred QS is actually pending; only the unnecessary write on the
> fast path is eliminated.
> 
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  include/linux/rcutiny.h   |  1 +
>  include/linux/rcutree.h   |  1 +
>  kernel/context_tracking.c |  2 +-
>  kernel/rcu/tree.c         | 19 +++++++++++++++++++
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index e56ded733b1b..dcad641eb2c2 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -120,6 +120,7 @@ static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  	return false;
>  }
>  static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
> +static inline void rcu_ct_kernel_exit_qs(void) { }
>  void rcu_scheduler_starting(void);
>  static inline void rcu_end_inkernel_boot(void) { }
>  static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 16a04202888b..d623f2a7d3fc 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -87,6 +87,7 @@ static inline void rcu_irq_exit_check_preempt(void) { }
>  
>  struct task_struct;
>  void rcu_preempt_deferred_qs(struct task_struct *t);
> +void rcu_ct_kernel_exit_qs(void);
>  
>  void exit_rcu(void);
>  
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index a743e7ffa6c0..011018214c6d 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -118,7 +118,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
>  	lockdep_assert_irqs_disabled();
>  	trace_rcu_watching(TPS("End"), ct_nesting(), 0, ct_rcu_watching());
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> -	rcu_preempt_deferred_qs(current);
> +	rcu_ct_kernel_exit_qs();
>  
>  	// instrumentation for the noinstr ct_kernel_exit_state()
>  	instrument_atomic_write(&ct->state, sizeof(ct->state));
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96848fc1f02b..c23478f70c17 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -368,6 +368,25 @@ notrace void rcu_momentary_eqs(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
>  
> +/**
> + * rcu_ct_kernel_exit_qs - report deferred QS on syscall/exception exit if needed
> + *
> + * Called from ct_kernel_exit() on every return to userspace.  Guards the
> + * rcu_preempt_deferred_qs() call with rcu_preempt_need_deferred_qs() so that
> + * on the common fast path -- where nothing is deferred -- we avoid the
> + * cache-line traffic on current->rcu_read_unlock_special that the unconditional
> + * call causes.  This is particularly significant on weakly-ordered architectures
> + * (e.g. ppc64le) where rcu_read_lock/unlock issue lwsync/isync barriers and
> + * already touch that cache line in the syscall body.
> + *
> + * Follows the same pattern used by rcu_flavor_sched_clock_irq().
> + */
> +notrace void rcu_ct_kernel_exit_qs(void)
> +{
> +	if (rcu_preempt_need_deferred_qs(current))
> +		rcu_preempt_deferred_qs(current);
> +}
> +

rcu_preempt_deferred_qs() already has a rcu_preempt_need_deferred_qs() fast
path. Am I missing something?

Thanks.


>  /**
>   * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
>   *
> -- 
> 2.55.0
> 

-- 
Frederic Weisbecker
SUSE Labs
