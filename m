Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783914;
	b=SPSczcoEgGQnKyw4BlO3EzALOlwNYzIAVVR7HcCCU2a08kAjGaZVAEZOgOXleUfp5R2A
	 p2yW/4THrRRv+wYDzMr0TvRIrDTT/mABWv9/NzJK1rn0hV4dXT9gVMHFGq4tZWzP/NBrQ
	 5Rqj0rBd0Mtb1Hfe7FZK8KLo0U8walU9MWCos6mi8xyaIzOFdoQ6DVLoPlhAigbw9QdTx
	 ekI6dyAtV49unexSCbCls3hDOy0hGFbioKQ0QjXXFfM6F6QzDa0OBrmiJYvT1K3Xm260X
	 JggBjnHwf0EmYPIvQWfQjgkFP0ztFTsLAx4eii4JmeWREO1KdKBoBQHgQmcod55Y8+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783914;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3CryQ98FB0zsKVMP+f0NQWUVWZUEey+knWpwTLfFEdQ=;
	b=3TOgjpCSkHb8z38haAn3dI/AhnAxJugAGxVUyJEUxv9JDRGDL9vh6GqOP9A838anDCC3
	 7AG2qFlbC81sdXHoI7lHofvH/0E4ARosGMU0oB4DyDMA59kfBSNbd6dnThPoJUFEXZNua
	 E6me37T6m+Hg3FkTC+eL35bkKqbW+vTWgNSAITOlh66pY/Yl/0BkXWG3kfqllYmopXYee
	 /dPGWLr04FomJ2cxfhdE3yKJ00qs/MiJV+QZjOQotgewsq0o/eJUowq4tlsjAKAXJmZsw
	 jqThZx4Mk0iJs0XU1SmhwjGeQ6E0LQNE8k7hBtwzQUDQV4pv7snOHBntFAUbkIWcr2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mvezgo1Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70099606A32C;
	Fri, 23 Oct 2026 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mvezgo1Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175421F031E3;
	Fri, 23 Oct 2026 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783914;
	bh=3CryQ98FB0zsKVMP+f0NQWUVWZUEey+knWpwTLfFEdQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Mvezgo1Z4cWBEQEsp9xJH35d6mS+RxC/g8BpjJnqyizGKU0SiSVC52CwC2XQ70k1e
	 4QCP7Z8PtsGdf/nuJY4sxRCrGiQkmfcT9rdHmBBR+a6YLkxbNLO//p6C5qTcC7IjZ9
	 ClAWZgF6rOo8nZKtk6JnPADItxmsz5gJF4nbkDaSJzL8rgelNldP5UYQjlN7Qm8drI
	 otmNBUHdRd+d6C4Si41QJ35EqYroH9uk2kDlVg0uX/rZTGgT4Hs0YlN3x9jlJyGC1J
	 kCze+X5VBA/yStoF3N61kSb6NiNODf/Ro195Q8UDPbKqbP8h7tN9EXXT+QwwDOxLi0
	 keOd2Vspk9Czg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7C0CCE0811; Fri, 23 Oct 2026 12:31:53 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:31:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 9/9] rcu-tasks: Detect duplicate callback enqueue
Message-ID: <cdd3f35d-9e9a-4b87-bea7-59ff3e1a7390@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-10-kunwu.chan@gmail.com>
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
In-Reply-To: <20261023101841.2910719-10-kunwu.chan@gmail.com>

On Fri, Oct 23, 2026 at 06:18:41PM +0800, Kunwu Chan wrote:
> Detect duplicate callback enqueue attempts in the generic
> RCU Tasks callback registration path.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

And the same questions for this patch as well.  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 5d7f234795b4..49b716feb31d 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -6,6 +6,7 @@
>   */
>  
>  #ifdef CONFIG_TASKS_RCU_GENERIC
> +#include <linux/mm.h>
>  #include "rcu_segcblist.h"
>  
>  ////////////////////////////////////////////////////////////////////////
> @@ -339,9 +340,12 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
>  }
>  
>  // Enqueue a callback for the specified flavor of Tasks RCU.
> +static void rcu_tasks_leak_callback(struct rcu_head *rhp) { }
> +
>  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  				   struct rcu_tasks *rtp)
>  {
> +	static atomic_t doublefrees;
>  	int chosen_cpu;
>  	unsigned long flags;
>  	bool havekthread = smp_load_acquire(&rtp->kthread_ptr);
> @@ -358,6 +362,16 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  	if (WARN_ON_ONCE(!func))
>  		return;
>  
> +	if (debug_rcu_head_queue(rhp)) {
> +		if (atomic_inc_return(&doublefrees) < 4) {
> +			pr_err("%s(): Duplicate call_rcu_%s() CB %p->%pS()\n",
> +			       __func__, rtp->name, rhp, rhp->func);
> +			mem_dump_obj(rhp);
> +		}
> +		WRITE_ONCE(rhp->func, rcu_tasks_leak_callback);
> +		return;
> +	}
> +
>  	rhp->next = NULL;
>  	rhp->func = func;
>  	local_irq_save(flags);
> @@ -586,6 +600,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>  	len = rcl.len;
>  	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> +		debug_rcu_head_unqueue(rhp);
>  		debug_rcu_head_callback(rhp);
>  		local_bh_disable();
>  		rhp->func(rhp);
> -- 
> 2.43.0
> 
