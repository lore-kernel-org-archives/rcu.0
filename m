Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8FC18B46E;
	Wed,  7 May 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635153; cv=none; b=SNJtf2g8yDBT9r3istGlxvmUjFdgNMg+YYcdnnYfs4lVzLRDNMGXeUS1jJnnJyoXxq8k4v+dV7VRDAoCVvgXmszoTjUWHxxeY6KYXddTLjV59iVZCLFpG5KsiLsmOsoqrvU6emjCfbnuP6AIEmnyC0KbLn67eeDtGnBctyxNaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635153; c=relaxed/simple;
	bh=ynMohAvFYk2a5ygZVW3OYUWpvl86XtI1iFnTixant7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHqbDMI32AKO5V2F4CChuEvp724QvmWd2KyGDWu9Ssn3XpjaHsG8Hobgh5mgNVXe72jpVh8DOBakv0Q+U+xZrnxkGWDJiNa5jIA7XavZzk34/hx3mqSAJxXWfQRoyhU9B+Dwh7WNbLamN0/10V9HrAwJ5hbls12VLjChLUG8Iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkRPRQ3s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkRPRQ3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966EFC4CEE2;
	Wed,  7 May 2025 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746635153;
	bh=ynMohAvFYk2a5ygZVW3OYUWpvl86XtI1iFnTixant7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkRPRQ3swJOUGLYg3Du7Hv3kyyX8yET1shHYF5OJJLwK64MGlOMVyXAC19n3iWTs+
	 cUNuyL24H378vN/emgkWbZQBahmBDXbVn4hYr98SVq1m+3qCYpSCgPow6P9PtSnPrV
	 OGIKA2jigC5KIaPCL6rMfU6vz2wmIbTCcr1e2SCqh4YSXygJAQmxPc3drlP4kZkeWU
	 eq7yF2V4NSWLpcGuJdDyKyG4F3572HJPi3+Mi2EjaecwNkRWw8meEotAfjOFnRs0Iu
	 7YOSElhOspecMXPSrXbUoZVd060gMPGmIenVO/2Z6fuSNo07QtqumtKKD6ZA8c3S7n
	 ZByEltWWPPiAQ==
Date: Wed, 7 May 2025 18:25:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
Message-ID: <aBuJi3jhcp4dCbSY@localhost.localdomain>
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-2-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507112605.20910-2-qiang.zhang1211@gmail.com>

Le Wed, May 07, 2025 at 07:26:04PM +0800, Zqiang a écrit :
> For built with CONFIG_PROVE_RCU=y and CONFIG_PREEMPT_RT=y kernels,
> Disable BH does not change the SOFTIRQ corresponding bits in
> preempt_count(), but change current->softirq_disable_cnt, this
> resulted in the following splat:
> 
> WARNING: suspicious RCU usage
> kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
> stack backtrace:
> CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
> Call Trace:
> [    0.407907]  <TASK>
> [    0.407910]  dump_stack_lvl+0xbb/0xd0
> [    0.407917]  dump_stack+0x14/0x20
> [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
> [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
> [    0.407939]  rcu_core+0x471/0x900
> [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
> [    0.407954]  rcu_cpu_kthread+0x25f/0x870
> [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
> [    0.407966]  smpboot_thread_fn+0x34c/0xa50
> [    0.407970]  ? trace_preempt_on+0x54/0x120
> [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [    0.407982]  kthread+0x40e/0x840
> [    0.407990]  ? __pfx_kthread+0x10/0x10
> [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
> [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
> [    0.408000]  ? __pfx_kthread+0x10/0x10
> [    0.408006]  ? __pfx_kthread+0x10/0x10
> [    0.408011]  ret_from_fork+0x40/0x70
> [    0.408013]  ? __pfx_kthread+0x10/0x10
> [    0.408018]  ret_from_fork_asm+0x1a/0x30
> [    0.408042]  </TASK>
> 
> Currently, triggering an rdp offloaded state change need the
> corresponding rdp's CPU goes offline, and at this time the rcuc
> kthreads has already in parking state. this means the corresponding
> rcuc kthreads can safely read offloaded state of rdp while it's
> corresponding cpu is online.
> 
> This commit therefore add softirq_count() check for
> Preempt-RT kernels.
> 
> Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 003e549f6514..a91b2322a0cd 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -29,7 +29,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>  		  lockdep_is_held(&rdp->nocb_lock) ||
>  		  lockdep_is_held(&rcu_state.nocb_mutex) ||
> -		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
> +		  ((!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_count()) &&
>  		   rdp == this_cpu_ptr(&rcu_data)) ||

On a second thought, isn't "rdp == this_cpu_ptr(&rcu_data)" enough?
The offloaded state can only change if the CPU is completely offline.
But if the current CPU is looking at the local rdp, it means it is online
and the rdp can't be concurrently [de]offloaded, right?

Thanks.

>  		  rcu_current_is_nocb_kthread(rdp)),
>  		"Unsafe read of RCU_NOCB offloaded state"
> -- 
> 2.17.1
> 
> 

-- 
Frederic Weisbecker
SUSE Labs
