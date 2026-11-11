Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423089;
	b=T19lwAijl/P0yN4fm1ylSc5IdtwKfcgUPypanoX6QbSe+ShR0qBckmzn2wY5r/xd3fxD
	 QDt0c+CDIeimBWkptWLhUTA4sWePWkB9NUKANRgKk1eYBi8Oo3DLtuFI5a9mxCwsmWsoq
	 bsqd/wb8zO+b3WGDgkTQv+Xz1gKCB9JfKLC+sZwIBpLs3u30PVTQEyHOIlvddw292ueu/
	 TjT2/gFSqktN7v8KnpBOoPs2aAJaV4HbR6l2QGb7wkEGLJ8S5x0cws6w0+1ymu6fV+/yN
	 Bovx0lbdGv43oe5djTPf+S1r08xYr4buutXxI38VIPHCLwtG1qvoC6GdWEZgIDgdKYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423089;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=f4bvjKyGGW7LYi9Wi0u6NoBT6lJr9jDxOjSufAj5kjA=;
	b=EKGurJ8RJ0wkdyKp0CxqOxPj2MyNXwGTBtnCX7sWNRcX1zAUbOGbP3vs0MTH/1LdyZ5i
	 0yTfAG06anGD4AjUimLZ9+6VYGguqoz9cMdOz7dz3/5n1WKS4TiV3xOkbwTQ+gwm9z5xM
	 COfhA78Ii/53T1dot12riKZ2kNiN7oqBFa2XY81Ry4f84NRlU9FAt0l5ydsQvYtdA2SAY
	 75vuoh5ZvhHBY6JcTJMGKmnL8GjeWnvTwWb7//6hityeSe9SUnh+FfZLG/3ey9/eG5LgL
	 hw0VCooPN5sbtcSTdkjs7HatF+fBTHFLBXugf4+D8ec2dhRB3gyB+yt745pqMQ8iJjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/RZNUAt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55729606A321;
	Wed, 11 Nov 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/RZNUAt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38FE1F00A06;
	Wed, 11 Nov 2026 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423088;
	bh=f4bvjKyGGW7LYi9Wi0u6NoBT6lJr9jDxOjSufAj5kjA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=V/RZNUAt5e61roHVGUqZTjp8d4FpVn7OH9QglKyo1GxtSzC8dOWp/MSSFbhEmGq3V
	 qeV2ELlINFZQSRZjeilO0Oz5yNSzulqdwcprizT3X2WESvI2GT5fx4OiuOAXr8ZXqI
	 tfOt3772A0YPURm9Bm2JCQALhlptYKRsdT+ZGhPiMCcWBipSRyGXzDZtu+aPCaZ8jA
	 xRlunQwWhiCxkepNbsJ1KrfLIcEurlgxxhEHEOCWesU9zqVxCUX6AtsIP86XmtkZvh
	 QjAfgnUBS6vOClK8JqZONmXot/XPH7nMXVL4zj4boZUrq0VtJIHaJO0biL5cRzQxfA
	 YNiSmBdhNCaXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A71D1CE0840; Wed, 11 Nov 2026 10:51:28 -0800 (PST)
Date: Wed, 11 Nov 2026 10:51:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Song Liu <song@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, leitao@debian.org, david.dai@linux.dev
Subject: Re: [PATCH] rcu-tasks: Use pr_debug() for callback contend/collapse
 messages
Message-ID: <b8b61147-2446-4843-b5f4-a8f845a748f6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111053551.3367903-1-song@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111053551.3367903-1-song@kernel.org>

On Tue, Nov 10, 2026 at 09:35:51PM -0800, Song Liu wrote:
> Commit 5de907d24919 ("rcu-tasks: Disable callback contend/collapse
> messages by default") added the rcupdate.rcu_task_collapse_debug module
> parameter to gate the three pr_info() messages that report RCU Tasks
> switching between CPU-0 and per-CPU callback queuing.
> 
> The kernel already has a mechanism for debug-only messages that are off
> by default: pr_debug().  Use pr_debug() for these messages, and remove
> the rcu_task_collapse_debug module parameter, its documentation, and
> its boot-time announcement.
> 
> The messages stay off by default.  On CONFIG_DYNAMIC_DEBUG=y kernels,
> they can be enabled at boot with:
> 
>   dyndbg="file kernel/rcu/tasks.h +p"
> 
> or at runtime with:
> 
>   echo 'file kernel/rcu/tasks.h +p' > /proc/dynamic_debug/control
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Song Liu <song@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 -------
>  kernel/rcu/tasks.h                              | 15 +++------------
>  2 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b3c140babd9..176648941aec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6369,13 +6369,6 @@ Kernel parameters
>  			period to instead use normal non-expedited
>  			grace-period processing.
>  
> -	rcupdate.rcu_task_collapse_debug= [KNL]
> -			Enable debugging prints that record when RCU Tasks
> -			and RCU Tasks Trace expand to per-CPU callback
> -			queuing and collapse back to CPU-0 queuing.
> -			This is default-disabled due to the fact that
> -			some workloads can make it quite noisy.
> -
>  	rcupdate.rcu_task_collapse_lim= [KNL]
>  			Set the maximum number of callbacks present
>  			at the beginning of a grace period that allows
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index fcac7361ec51..743f777b4c18 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -178,8 +178,6 @@ static int rcu_task_contend_lim __read_mostly = 100;
>  module_param(rcu_task_contend_lim, int, 0444);
>  static int rcu_task_collapse_lim __read_mostly = 10;
>  module_param(rcu_task_collapse_lim, int, 0444);
> -static bool rcu_task_collapse_debug __read_mostly;
> -module_param(rcu_task_collapse_debug, bool, 0644);
>  static int rcu_task_lazy_lim __read_mostly = 32;
>  module_param(rcu_task_lazy_lim, int, 0444);
>  
> @@ -392,8 +390,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
>  			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
>  			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
> -			if (data_race(rcu_task_collapse_debug))
> -				pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
> +			pr_debug("Switching %s to per-CPU callback queuing.\n", rtp->name);
>  		}
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  	}
> @@ -514,9 +511,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  			smp_store_release(&rtp->percpu_enqueue_lim, 1);
>  			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
>  			gpdone = false;
> -			if (data_race(rcu_task_collapse_debug))
> -				pr_info("Starting switch %s to CPU-0 callback queuing.\n",
> -					rtp->name);
> +			pr_debug("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
>  		}
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  	}
> @@ -524,9 +519,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>  		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
>  			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
> -			if (data_race(rcu_task_collapse_debug))
> -				pr_info("Completing switch %s to CPU-0 callback queuing.\n",
> -					rtp->name);
> +			pr_debug("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
>  		}
>  		if (rtp->percpu_dequeue_lim == 1) {
>  			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
> @@ -711,8 +704,6 @@ static void __init rcu_tasks_bootup_oddness(void)
>  		pr_info("\tTasks-RCU CPU stall info multiplier clamped to %d (rcu_task_stall_info_mult).\n", rtsimc);
>  		rcu_task_stall_info_mult = rtsimc;
>  	}
> -	if (rcu_task_collapse_debug)
> -		pr_info("\tTasks-RCU callback contend/collapse debug enabled.\n");
>  #endif /* #ifdef CONFIG_TASKS_RCU */
>  #ifdef CONFIG_TASKS_RCU
>  	pr_info("\tTrampoline variant of Tasks RCU enabled.\n");
> -- 
> 2.53.0-Meta
> 
