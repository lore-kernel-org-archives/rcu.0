Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8B2EAE6;
	Fri,  3 Jan 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918031; cv=none; b=J3fwhvUO5U+olX3iD2EE5v2TjKSMkUjHCHcs3PQHxjbYdrj1glZEWHu9AZDLHbuauj016J3tIZWxT2XRjeEaefrEgKZcUOqVx9nV9XtIE7ih3GwmY8EcHLPtXHgEPxzYCYgYR3/9LNXRBYKJ0SBfd4nCt+/MS4FqP9kKVjy2Ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918031; c=relaxed/simple;
	bh=jm+iuUOduzHHSUn0ZbawEdCZp5LdTCsIK/f61RTcNIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2toV28d3ih3VjLx2iYFf+q0zRhLN2tCNsMBLg1aLCVtwA/Ybr0UqX+QCtatcLvMR12TEIybcYVlZ36gdVT5YBmWslFv6v5SSXTWchDTgTwGOpryMZuUXGBXcfWUssXGNC0W0q28pRTs880VQ7KtaFPTcG2ejVEKesJHYtkTS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk8ewQCO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk8ewQCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FB5C4CECE;
	Fri,  3 Jan 2025 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735918030;
	bh=jm+iuUOduzHHSUn0ZbawEdCZp5LdTCsIK/f61RTcNIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pk8ewQCOUoK6lTCBkqYoJ9tTE/2XQDH96G/5fXOZHiU3JnJvSUCwxTwelatwR9IYt
	 dK+IkqfKob+vL9RspqI59mhL7kWCzBHQoayMqqtjKIrjI5jnbP967N99QYNTASE586
	 l4PHCOVIoIeN+jpX23yasDEoir5Q4f6QGH5wvL3A+x4r9QCh81mMEqLbBAVROTUcGo
	 YVJ8K+nnXPthr6CkKi0Y7x2Sg6kNJjFccbePLk5wJhICldeBiTntui6qbQ+2inDD8C
	 LOG8yMyYUIY+9TsW+CYO1dO3jgmoLmaUsK6pRNovSIQhSMYwox0mzOT2dgBwALcvCH
	 sGM9ee6AkSwqQ==
Date: Fri, 3 Jan 2025 15:27:03 +0000
From: Will Deacon <will@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 10/19] sched,arm64: Handle CPU isolation on last resort
 fallback rq selection
Message-ID: <20250103152702.GB3816@willie-the-truck>
References: <20241211154035.75565-1-frederic@kernel.org>
 <20241211154035.75565-11-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211154035.75565-11-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 11, 2024 at 04:40:23PM +0100, Frederic Weisbecker wrote:
> When a kthread or any other task has an affinity mask that is fully
> offline or unallowed, the scheduler reaffines the task to all possible
> CPUs as a last resort.
> 
> This default decision doesn't mix up very well with nohz_full CPUs that
> are part of the possible cpumask but don't want to be disturbed by
> unbound kthreads or even detached pinned user tasks.
> 
> Make the fallback affinity setting aware of nohz_full.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/arm64/include/asm/cpufeature.h  |  1 +
>  arch/arm64/include/asm/mmu_context.h |  2 ++
>  arch/arm64/kernel/cpufeature.c       | 11 +++++++++++
>  include/linux/mmu_context.h          |  1 +
>  kernel/sched/core.c                  |  2 +-
>  5 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 8b4e5a3cd24c..cac5efc836c0 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -671,6 +671,7 @@ static inline bool supports_clearbhb(int scope)
>  }
>  
>  const struct cpumask *system_32bit_el0_cpumask(void);
> +const struct cpumask *fallback_32bit_el0_cpumask(void);
>  DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
>  
>  static inline bool system_supports_32bit_el0(void)
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 48b3d9553b67..7883abd6b29a 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -283,6 +283,8 @@ task_cpu_possible_mask(struct task_struct *p)
>  }
>  #define task_cpu_possible_mask	task_cpu_possible_mask
>  
> +const struct cpumask *task_cpu_fallback_mask(struct task_struct *p);
> +
>  void verify_cpu_asid_bits(void);
>  void post_ttbr_update_workaround(void);
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 7ce1b8ab417f..2b7aa32bf436 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1642,6 +1642,17 @@ const struct cpumask *system_32bit_el0_cpumask(void)
>  	return cpu_possible_mask;
>  }
>  
> +const struct cpumask *task_cpu_fallback_mask(struct task_struct *p)
> +{
> +	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
> +		return housekeeping_cpumask(HK_TYPE_TICK);
> +
> +	if (!is_compat_thread(task_thread_info(p)))
> +		return housekeeping_cpumask(HK_TYPE_TICK);
> +
> +	return system_32bit_el0_cpumask();
> +}

I think this is correct, but damn what we really want to ask for is the
intersection of task_cpu_possible_mask(p) and
housekeeping_cpumask(HK_TYPE_TICK). It's a shame to duplicate the logic
in task_cpu_possible_mask() here because we don't want to allocate a
temporary mask.

Maybe we could have a helper to consolidate things a little?

static inline const struct cpumask *
__task_cpu_possible_mask(struct task_struct *p, const struct cpumask *mask)
{
	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
		return mask;

	if (!is_compat_thread(task_thread_info(p)))
		return mask;

	return system_32bit_el0_cpumask();
}

Then we could call that from both task_cpu_possible_mask() and
task_cpu_fallback_mask(), but passing 'cpu_possible_mask' and
housekeeping_cpumask(HK_TYPE_TICK) for the 'mask' argument respectively?

Will
