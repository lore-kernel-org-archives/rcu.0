Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75FF21D5AA;
	Thu,  8 May 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746738843; cv=none; b=ehwKXfx6C4m1DZruugGgfR9RlHHEN6Xet6eNEHyxnSmAty2DaxkaPO9jszvNLzPXZh22svIhGHaUkzP8RB7mPAIOudWDmkykUdUKqxLJgNKSNaV+j66LCZdi5OCJ+fJ48dUr6vTNapYVh+JWXCVkQtryY1hbSPrNMdfzJxwVW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746738843; c=relaxed/simple;
	bh=fNe8Mm+hSQalygb6YYRSWyFmkSH/mSmdHjMuBS0PLQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtxS7n/pWotWyCpFaFFOqG+4pX27BjWCvtuOcTmw9fM6SEGaD4EH0MkVnRJAOjkXGmJVySDjsCNFOnqN2TILZrnafZ5ebRKkdpJ5pP1Mc+c2TvWmVFL6PIdUllwlmASpQBWjoLmY4zFRB3uXoDcvM2o8wUh7TBaWIVm299WfLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc4fWAPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc4fWAPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12836C4CEE7;
	Thu,  8 May 2025 21:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746738843;
	bh=fNe8Mm+hSQalygb6YYRSWyFmkSH/mSmdHjMuBS0PLQI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Oc4fWAPESl8FZkvivrZxQpH4nymKKVt8t26kJCkwT32kq/O9NgrGj/IcfhrCrIDqO
	 oLWYh9i0fFxAdR2lizCOEsFpto0+eODCSXV9qSliBxHwCAYGUM2sVo1j2q49IZ/G0Q
	 I/09oMrGyY1QhFQvOVZ4RiUWCFxIyVRMzFdhb+kXOL7/XWagkEJFBsLrJ1WcNNMXyp
	 8j7TzeQVAtjh/O+7uP4NxMPKSngiTyn8Dhhbm+gN1DrNvQCQS+WS0JOb9IjrNJ/AYe
	 EBnK5udSX9QxnfIqoDbxfp+L3+Mh1kF6OglbFrfFrISsr8hrp/C2ZU6uc698XMFVau
	 Bzqzt1xXJHogg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A7A3BCE078D; Thu,  8 May 2025 14:14:02 -0700 (PDT)
Date: Thu, 8 May 2025 14:14:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
 pointer access
Message-ID: <b23a7caa-a548-4691-badc-4122907ea688@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-3-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507112605.20910-3-qiang.zhang1211@gmail.com>

On Wed, May 07, 2025 at 07:26:05PM +0800, Zqiang wrote:
> In the preparation stage of CPU online, if the corresponding
> the rdp's->nocb_cb_kthread does not exist, will be created,
> there is a situation where the rdp's rcuop kthreads creation fails,
> and then de-offload this CPU's rdp, does not assign this CPU's
> rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
> rdp's->rdp_gp->nocb_gp_kthread is still valid.
> 
> This will cause the subsequent re-offload operation of this offline
> CPU, which will pass the conditional check and the kthread_unpark()
> will access invalid rdp's->nocb_cb_kthread pointer.
> 
> This commit therefore use rdp's->nocb_gp_kthread instead of
> rdp_gp's->nocb_gp_kthread for safety check.

Let's see...

The rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() functions invoke
cpus_read_lock(), and thus exclude all the CPU-hotplug notifiers,
including the one that invokes rcutree_prepare_cpu().  There is also
rcu_spawn_gp_kthread(), but that is an early_initcall() that happens
before CPU hotplug can happen, at least for non-boot CPUs.

So rcu_spawn_cpu_nocb_kthread() cannot run concurrently with either
rcu_nocb_cpu_offload() or rcu_nocb_cpu_deoffload(), correct?

It appears that all CPUs (try to) create their rcuoc and rcuog kthreads
when they come online, regardless of the nohz_full and rcu_nocbs kernel
boot parameters, some old tree_nocb.h comments notwithstanding.  ;-) The
rcu_organize_nocb_kthreads() function looks to cover all CPUs as well,
so ->nocb_gp_rdp will always be set after very early boot (give or take
alloc_bootmem_cpumask_var() failure in rcu_nocb_setup() and checked for
by the cpumask_available() in rcu_organize_nocb_kthreads()).

The rcu_spawn_cpu_nocb_kthread() can fail to spawn the GP kthread,
in which case both ->nocb_cb_kthread and ->nocb_gp_kthread remain
NULL.

If so, LGTM.

							Thanx, Paul

> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tree_nocb.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1596812f7f12..6679140bb0b5 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1146,7 +1146,6 @@ static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
>  static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>  {
>  	int wake_gp;
> -	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>  
>  	WARN_ON_ONCE(cpu_online(rdp->cpu));
>  	/*
> @@ -1156,7 +1155,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>  	if (!rdp->nocb_gp_rdp)
>  		return -EINVAL;
>  
> -	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
> +	if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
>  		return -EINVAL;
>  
>  	pr_info("Offloading %d\n", rdp->cpu);
> @@ -1166,7 +1165,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>  
>  	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
>  	if (wake_gp)
> -		wake_up_process(rdp_gp->nocb_gp_kthread);
> +		wake_up_process(rdp->nocb_gp_kthread);
>  
>  	swait_event_exclusive(rdp->nocb_state_wq,
>  			      rcu_nocb_rdp_offload_wait_cond(rdp));
> -- 
> 2.17.1
> 
