Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4372594BC;
	Wed,  8 Jan 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351445; cv=none; b=POO9Go+ulzIngTkvl8q5xBP1mD+GuhiHfP5EKlIzZx6yS6sg7ZPAL56BKaG3i7u2PhBNZspRLIdT8R36AqCtCQD4ZQD/Czz/s3+XLveDfZ2dK1JaU2A9P2meTPRdI2AvmuTOdnUYI7Rg+wyhgEmfJLbgq5vkeqJ4kHqgpzgvAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351445; c=relaxed/simple;
	bh=YUIHR5lD1ZZPlBRdH+E4qKEFSQ9n/9PZuS1r+2JHdHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDhTQbf/zKyClvThok3RWCZsTW6h1oUZD4u1iOhTlwzEIhUT5+4pIIcOkdfXzZ7iXtLqc6PLifHcnTEknU3bomBJVRgSpyBbbxVW2GExs33HNNIBHkc2442fyPkvlWIPrNTvZwnSEMqHO8QupeCejnMQFzwnUdgYE2IF4BtKs8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/MnK0xi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/MnK0xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA2EC4CED3;
	Wed,  8 Jan 2025 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351444;
	bh=YUIHR5lD1ZZPlBRdH+E4qKEFSQ9n/9PZuS1r+2JHdHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/MnK0xinlPRLCM6GZvAZGICLXgK44VNSQGqCMd/Q0wKK3+ZIVQ+1UIII13aGaGLS
	 OxqUk5hhyQ6+d54DdYQpTxaPFhCe5Wqn+O4Uppr0Z241g4NILAgK/oh7jHJWxMK/66
	 cqaqrTWght9hvgKzlImFB8E8+KNSU46shx+PrgYF8MN8gDVu4VTUFvFw8VooiohhNH
	 eFpY/LbvpiDZLyGG8RWTx43srbHVa5IK9AsaFD45laCdVcVUIfAI/nXUdxy+lr0gCh
	 Bk0qmZG88ITmif2Qw99dqtGRi43wtOM2KtlUbkM3k+Oqqsk0eLmkbXmHn48H3uB3QI
	 zrrunCMI3o1MA==
Date: Wed, 8 Jan 2025 15:50:38 +0000
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
Message-ID: <20250108155036.GB9662@willie-the-truck>
References: <20241211154035.75565-1-frederic@kernel.org>
 <20241211154035.75565-11-frederic@kernel.org>
 <20250103152702.GB3816@willie-the-truck>
 <Z3nCuQwP4qA66bcd@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3nCuQwP4qA66bcd@pavilion.home>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jan 05, 2025 at 12:22:33AM +0100, Frederic Weisbecker wrote:
> Le Fri, Jan 03, 2025 at 03:27:03PM +0000, Will Deacon a écrit :
> > Maybe we could have a helper to consolidate things a little?
> > 
> > static inline const struct cpumask *
> > __task_cpu_possible_mask(struct task_struct *p, const struct cpumask *mask)
> > {
> > 	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
> > 		return mask;
> > 
> > 	if (!is_compat_thread(task_thread_info(p)))
> > 		return mask;
> > 
> > 	return system_32bit_el0_cpumask();
> > }
> > 
> > Then we could call that from both task_cpu_possible_mask() and
> > task_cpu_fallback_mask(), but passing 'cpu_possible_mask' and
> > housekeeping_cpumask(HK_TYPE_TICK) for the 'mask' argument respectively?
> 
> Good point! How is the following updated version?

That's exactly what I had in mind, thanks!

Acked-by: Will Deacon <will@kernel.org>

Will

> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Fri, 27 Sep 2024 00:48:59 +0200
> Subject: [PATCH 2/2] sched,arm64: Handle CPU isolation on last resort fallback
>  rq selection
> 
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
>  arch/arm64/include/asm/mmu_context.h | 14 +++++++++++---
>  arch/arm64/kernel/cpufeature.c       |  5 +++++
>  include/linux/mmu_context.h          |  1 +
>  kernel/sched/core.c                  |  2 +-
>  5 files changed, 19 insertions(+), 4 deletions(-)
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
> index 48b3d9553b67..0dbe3b29049b 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -271,18 +271,26 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  }
>  
>  static inline const struct cpumask *
> -task_cpu_possible_mask(struct task_struct *p)
> +__task_cpu_possible_mask(struct task_struct *p, const struct cpumask *mask)
>  {
>  	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
> -		return cpu_possible_mask;
> +		return mask;
>  
>  	if (!is_compat_thread(task_thread_info(p)))
> -		return cpu_possible_mask;
> +		return mask;
>  
>  	return system_32bit_el0_cpumask();
>  }
> +
> +static inline const struct cpumask *
> +task_cpu_possible_mask(struct task_struct *p)
> +{
> +	return __task_cpu_possible_mask(p, cpu_possible_mask);
> +}
>  #define task_cpu_possible_mask	task_cpu_possible_mask
>  
> +const struct cpumask *task_cpu_fallback_mask(struct task_struct *p);
> +
>  void verify_cpu_asid_bits(void);
>  void post_ttbr_update_workaround(void);
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 3c87659c14db..a983e8660987 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1642,6 +1642,11 @@ const struct cpumask *system_32bit_el0_cpumask(void)
>  	return cpu_possible_mask;
>  }
>  
> +const struct cpumask *task_cpu_fallback_mask(struct task_struct *p)
> +{
> +	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_TICK));
> +}
> +
>  static int __init parse_32bit_el0_param(char *str)
>  {
>  	allow_mismatched_32bit_el0 = true;
> diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
> index bbaec80c78c5..ac01dc4eb2ce 100644
> --- a/include/linux/mmu_context.h
> +++ b/include/linux/mmu_context.h
> @@ -24,6 +24,7 @@ static inline void leave_mm(void) { }
>  #ifndef task_cpu_possible_mask
>  # define task_cpu_possible_mask(p)	cpu_possible_mask
>  # define task_cpu_possible(cpu, p)	true
> +# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK)
>  #else
>  # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 95e40895a519..233b50b0e123 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3534,7 +3534,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
>  			 *
>  			 * More yuck to audit.
>  			 */
> -			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
> +			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
>  			state = fail;
>  			break;
>  		case fail:
> -- 
> 2.46.0
> 
