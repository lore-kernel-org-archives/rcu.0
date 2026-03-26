Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BE2F4A14;
	Thu, 26 Mar 2026 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522736; cv=none; b=WZVF9l8LXLvamWM+sQ35QdH3iqJEHIFP8yqIpgBdhHL7WpltyDWJPrpaZPbF66nr1SZbJdOH7GASwbidNUlUGJpRsGYlmYEZ8QxyjDVB+C1soR3T2Dq2ElY7HhDa5nGrcpUNVSx8ZkgY7qC8bKNJ+WYHJCDHN53RD7zI05t0/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522736; c=relaxed/simple;
	bh=Quv47jCMQyrrUKK6psCcT8WgLWEnTdPOyX4ryKPGxLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCtDZ3+30aG1yff4FJhdV6Jc7OzdvUd68z5pTkR0KGkLwUHT9jLuQNciJb27trEzWdr3bmlc9PpY7+xGKpk/tdnryk5IvxZResfy3HdK7iIYf7TFQv/cjSAAgghE23owEWHZNey5PL2xUwQs7LbTUacYXHUPUswTOfdiFmeWjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmLFgT+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmLFgT+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31EEC116C6;
	Thu, 26 Mar 2026 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774522735;
	bh=Quv47jCMQyrrUKK6psCcT8WgLWEnTdPOyX4ryKPGxLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmLFgT+QxU81Nq82+LOyBxa376w3EMZkEoSto76WYDik/MTPzMBebJdH1vPIIzkfK
	 YZYNABttU63QaTCAGJR0VPeeAq6Kf9WwWmO+G76ARf70G0U/buxlL6S03CeCdJNYer
	 diCoQ35e6e0OkbeTMkg9mYl7m+d0VjYv0tpvT96nf/HvYbOgCNSXLKLn41oZJ9VK+I
	 bGPLyabI9plqATdNaQS3HPOKpaQZavbDrpvUv/Jk0SXpm0TFcfWS2NB4RBLlLgRl/A
	 ss8Q7wVMCPXyN7SWcKFPO4CxDxw88G5OMIA8+8xy+Qu6qhQq1Lo6dXuj/vr96REi1A
	 cck/daV/82vag==
Date: Thu, 26 Mar 2026 10:58:50 +0000
From: Will Deacon <will@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Optimize SRCU-fast per-CPU counter increments on
 arm64
Message-ID: <acURahmSDqFYgcIz@willie-the-truck>
References: <20260326102608.1855088-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326102608.1855088-1-puranjay@kernel.org>

On Thu, Mar 26, 2026 at 03:26:07AM -0700, Puranjay Mohan wrote:
> On architectures like arm64, this_cpu_inc() wraps the underlying atomic
> instruction (ldadd) with preempt_disable/enable to prevent migration
> between the per-CPU address calculation and the atomic operation.
> However, SRCU does not need this protection because it sums counters
> across all CPUs for grace-period detection, so operating on a "stale"
> CPU's counter after migration is harmless.
> 
> This commit therefore introduces srcu_percpu_counter_inc(), which
> consolidates the SRCU-fast reader counter updates into a single helper,
> replacing the if/else dispatch between this_cpu_inc() and
> atomic_long_inc(raw_cpu_ptr(...)) that was previously open-coded at
> each call site.
> 
> On arm64, this helper uses atomic_long_fetch_add_relaxed(), which
> compiles to the value-returning ldadd instruction.  This is preferred
> over atomic_long_inc()'s non-value-returning stadd because ldadd is
> resolved in L1 cache whereas stadd may be resolved further out in the
> memory hierarchy [1].
> 
> On x86, where this_cpu_inc() compiles to a single "incl %gs:offset"
> instruction with no preempt wrappers, the helper falls through to
> this_cpu_inc(), so there is no change.  Architectures with
> NEED_SRCU_NMI_SAFE continue to use atomic_long_inc(raw_cpu_ptr(...)),
> again with no change.  All remaining architectures also use the
> this_cpu_inc() path, again with no change.
> 
> refscale measurements on a 72-CPU arm64 Neoverse-V2 system show ~11%
> improvement in SRCU-fast reader duration:
> 
>   Unpatched: median 9.273 ns, avg 9.319 ns (min 9.219, max 9.853)
>     Patched: median 8.275 ns, avg 8.411 ns (min 8.186, max 9.183)
> 
>   Command: kvm.sh --torture refscale --duration 1 --cpus 72 \
>            --configs NOPREEMPT --trust-make --bootargs \
>            "refscale.scale_type=srcu-fast refscale.nreaders=72 \
>            refscale.nruns=100"
> 
> [1] https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/srcutree.h | 51 +++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index fd1a9270cb9a..4ff18de3edfd 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -286,15 +286,43 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
>   * on architectures that support NMIs but do not supply NMI-safe
>   * implementations of this_cpu_inc().
>   */
> +
> +/*
> + * Atomically increment a per-CPU SRCU counter.
> + *
> + * On most architectures, this_cpu_inc() is optimal (e.g., on x86 it is
> + * a single "incl %gs:offset" instruction).  However, on architectures
> + * like arm64, s390, and loongarch, this_cpu_inc() wraps the underlying
> + * atomic instruction with preempt_disable/enable to prevent migration
> + * between the per-CPU address calculation and the atomic operation.
> + * SRCU does not need this protection because it sums counters across
> + * all CPUs for grace-period detection, so operating on a "stale" CPU's
> + * counter after migration is harmless.
> + *
> + * On arm64, use atomic_long_fetch_add_relaxed() which compiles to the
> + * value-returning ldadd instruction instead of atomic_long_inc()'s
> + * non-value-returning stadd, because ldadd is resolved in L1 cache
> + * whereas stadd may be resolved further out in the memory hierarchy.
> + * https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop
> + */
> +static __always_inline void
> +srcu_percpu_counter_inc(atomic_long_t __percpu *v)
> +{
> +#ifdef CONFIG_ARM64
> +	(void)atomic_long_fetch_add_relaxed(1, raw_cpu_ptr(v));
> +#elif IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE)
> +	atomic_long_inc(raw_cpu_ptr(v));
> +#else
> +	this_cpu_inc(v->counter);
> +#endif
> +}

No, this is a hack. arm64 shouldn't be treated specially here.

The ldadd issue was already fixed properly in
git.kernel.org/linus/535fdfc5a2285. If you want to improve our preempt
disable/enable code or add helpers that don't require that, then patches
are welcome, but bodging random callers with arch-specific code for a
micro-benchmark is completely the wrong approach.

Will
