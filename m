Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CA2CCC6;
	Wed, 16 Sep 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517202; cv=none; b=SlMlaloWT4hmFdawSgD3ZWl+0LJR9wFWzReBs5PFSDpPvKLAgZJDC36SA5E7ic9VRk/ZlPqPXvZmOJ0GIBlLTYilkKV7X8zxcWs5jWz74E8vUVjkY6tijHffdoMf8eGOdiMS5VWAyqE87z5EE4xdD8U3Ybz6hdGguDMWPiilK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517202; c=relaxed/simple;
	bh=ZZFWUFdLyLqX+KEF08cNtW9NQR9zr9Srp7duV1tD33w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dieBpREuIQ3s+E+eAJZ+1JZq5MK0euEqGehvhg5eCVydw6PWLsr8QiSmEn3p6DKKzujf9O0sGFt4yP0jUvEHjziN0FWQSlxQavy4yNMoOko4WZYXazKX/qKvlp62OZAZ8tTjdKbNJRzk/9KvEVGODanA9Z5LCmNe1PExfZCA2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXbeVBl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXbeVBl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0E81F000FF;
	Wed, 16 Sep 2026 00:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517199;
	bh=DAyopLKcKO7QlC84xkEPKTL4N3PEHjcMPO96WpWVREY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jXbeVBl6XPmlqxZujBviJ2BI0qZUOJlXpqxNVbcmup3UtYFLlUIlbEckNyv3M4n75
	 CdRKB6BMdCvWzgs6s5TB+HdpWXkQ9EOT+0x4K4iSnRxvroVptryhXW8KNIyqQ9RO+g
	 caY4z6JwEhUY4QzMfm7EiWgEjpzB9V/KmTyYLMp7lPvlGXO3xCfUwfEcyS8G5VMogh
	 QkeAH4Nu03wZTS5mGW/UQDeyR5kWTf/52pFhXT/kUK3yH2g7sUNUfwlFhI5TC+PIk3
	 ff8ppPEregbQ+AIuka1ZpX7MWTMosSvfFIPFvC94IGOmpT9DuQ7jTyj47qbTO8P0Eb
	 igyJn6TrJdZWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 615A9CE0996; Tue, 15 Sep 2026 17:06:39 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:06:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Guard deferred QS on kernel exit behind
 need_deferred_qs() check
Message-ID: <dc328ed5-12fd-4e52-b340-d4a5adb575d2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260915102241.1344738-1-mkchauras@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915102241.1344738-1-mkchauras@gmail.com>

On Tue, Sep 15, 2026 at 03:52:41PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> ct_kernel_exit() unconditionally calls rcu_preempt_deferred_qs(current)
> on every return to userspace.  On the common fast path nothing is
> actually deferred, so this is a needless write to
> current->rcu_read_unlock_special -- a word that lives on the task_struct
> and is therefore subject to cross-CPU cache-line traffic.
> 
> On weakly-ordered architectures such as ppc64le, rcu_read_lock() and
> rcu_read_unlock() already issue lwsync/isync barriers and touch that
> same cache line in the syscall body.

You lost me on this one.  The non-debugging operations in preemptible
rcu_read_lock() are:

	WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) + 1);
	barrier(); // Empty as with the "memory" clobber.

I don't see how this emits lwsync or isync instructions.

Now I do agree that rcu_read_unlock() will emit all sorts of heavyweight
instructions in the case where there are deferred quiescent states,
which is the only case where rcu_preempt_need_deferred_qs() is important.
But I don't see how rcu_read_unlock() emits isync or lwsync in the normal
case where the preceding RCU read-side critical section was not preempted.

But on rcu_read_lock(), what am I missing?

>                                       Bouncing it again at syscall exit
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

You also lost me here.  The rcu_preempt_deferred_qs() function is as
follows:

notrace void rcu_preempt_deferred_qs(struct task_struct *t)
{
	unsigned long flags;

	if (!rcu_preempt_need_deferred_qs(t))
		return;
	local_irq_save(flags);
	rcu_preempt_deferred_qs_irqrestore(t, flags);
}

So the only savings is the local_irq_save(), and even then only in the
uncommon case where rcu_preempt_need_deferred_qs() returns true.

So again, what am I missing here?

							Thanx, Paul

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
>  /**
>   * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
>   *
> -- 
> 2.55.0
> 
