Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB2254879;
	Mon, 28 Apr 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745835257; cv=none; b=GLxeMc1RdFdEjU/+HRY7qNFXfEH0QrQ7pedUGLzG251eGuy6CdAs40VA/g8oCT2kXOBNPeNp4rkRDtQIUxnBkI9jUI0IoM9rOJwebW93qPfwPO0nye3JgTHwVNkRdu6OoFvMZZUx/zI+0PD5iXfxxWcA+ES2sGCF0v8By1On/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745835257; c=relaxed/simple;
	bh=cO7Tg6haOhSZ9heSi1IY0OcBr+NiJRQt7NeKbzMWWmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQxSeJMML/ISZ6ZD/CwnwcVyxIgGtgByybJLS3wUBpO0ZXCLIJlYSQ7grP2mNDq0wZfMw1H3UhDLV4zdxfqmTYqd7jQoykBKn6MBmyRjyPwf4eMw9xPxn0e7t9KNMXMDrzGFRlpxf0aOx2DZ1I7WHqWIVJeBki/vaiQVWITvg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzw0n9Gc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzw0n9Gc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBF2C4CEE4;
	Mon, 28 Apr 2025 10:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745835256;
	bh=cO7Tg6haOhSZ9heSi1IY0OcBr+NiJRQt7NeKbzMWWmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nzw0n9GcgT5Fbx+XhjHugEd/2EqfYnxi7XasvWM5DU+bAZ03DqipoLsxlFUvDV66h
	 3QKCnLDFPRjM5taZkG8spldhQ7V2xGwLX9sP+fVBfwUK03STXHWSQOfQEqZH/X7z10
	 MyDPKpQcxoY4yz19Pz+y+DQ509GK3aX630qFVnYEv85r8F4KHNzd4G3lu0oZ31yQO3
	 dCzVq48QuHydSoix7/vx4baTt9sAPDP8AJETpErJvSeVI3a5ajbSzIgv42ehGVhq9O
	 66lIdsCBCCHA+zRsLAaMzubh+0dtuaE7G/CIIyghfEuLSopkh3pQWXs4+mdSws4YZ3
	 2t+hWLNmxePjg==
Date: Mon, 28 Apr 2025 12:14:13 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
Message-ID: <aA9U9QvB2t2MLuU2@pavilion.home>
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250428095403.22889-1-qiang.zhang1211@gmail.com>

Le Mon, Apr 28, 2025 at 05:54:03PM +0800, Zqiang a écrit :
> For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
> disable local bh in rcuc kthreads will not affect preempt_count(),
> this resulted in the following splat:
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
> This commit therefore add rdp->rcu_cpu_kthread_task check for
> Preempt-RT kernels.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tree_plugin.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 003e549f6514..fe728eded36e 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>  		  lockdep_is_held(&rcu_state.nocb_mutex) ||
>  		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>  		   rdp == this_cpu_ptr(&rcu_data)) ||
> -		  rcu_current_is_nocb_kthread(rdp)),
> +		  rcu_current_is_nocb_kthread(rdp) ||
> +		  (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +		   current == rdp->rcu_cpu_kthread_task)),

Isn't it safe also on !CONFIG_PREEMPT_RT ?

Thanks.

>  		"Unsafe read of RCU_NOCB offloaded state"
>  	);
>  
> -- 
> 2.17.1
> 

-- 
Frederic Weisbecker
SUSE Labs
