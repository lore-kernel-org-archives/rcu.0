Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2A19C54F;
	Mon, 22 Sep 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550214; cv=none; b=q6h0p05LTc+KX6dtvRbcKphaaTSoUhCLDypWlHEKR2ozKez8b6YnKZdF+FeCbJ3TYsCC0E/cuXWzGCoBggcvhXdMzeZ1wfZTaZDd7LWEIgTh5GRckfIw2vhefmXT+1sbfMFn8VpierI3ydM/p5unOSdbQ1YIqx9PJY21pmkvDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550214; c=relaxed/simple;
	bh=lNY8IOlQ0ucdOhyfAW96EhiJUA7raagfOpQ0kY3BnFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqdOgF9N8RWJwu7FdUpbH3mKS0RYyf4du830Adl5omWC3tOngJYhbdICJRuRcKKLk9GRSvE4KC6SXy5IaSk38/8Ezvj4Frg4ccapu1bEWT0VJramprrGJNxk2HKKWqnvk6Q7upwz8/vi0jzTk8lzbEoT93Jxhw75eOJPYSfZKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKdA/9Ej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKdA/9Ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BF0C4CEF0;
	Mon, 22 Sep 2025 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550214;
	bh=lNY8IOlQ0ucdOhyfAW96EhiJUA7raagfOpQ0kY3BnFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKdA/9EjN7vHg6vIcXFBnOibLpvCnux/8R4zvG2QI8MBqW23s/t5SJ4w2xxY3qEok
	 LVWKp5bVyf3WMHC6EaWeCvmMxJDqZnCVhSyhKBtBnnKhfrINPtv8TZvYbnHhHnZ80/
	 FmdRXHlxdOIqYpZkywaYxXaaes5Om17NBZE1PtaSA04SX6ANgi26HSz6Q9PnQefZr8
	 seThyijlFiGI5Ah5XR9x6P+Uw28fexUPplJaZdw0+d3GXoeKwxZ5QHzac3EokTrcLl
	 vu3hyq63AjBTR4QSGdyhzleoQIvcuFoHSowmnyku9chr7fj6xolAdj4yVKYIK8rywh
	 xMuWdyhIDYoZw==
Date: Mon, 22 Sep 2025 16:10:10 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2 2/3] rcu: WQ_PERCPU added to alloc_workqueue users
Message-ID: <aNFYwpNHTjXvHUVX@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
References: <20250919145040.290214-1-marco.crivellari@suse.com>
 <20250919145040.290214-3-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919145040.290214-3-marco.crivellari@suse.com>

Le Fri, Sep 19, 2025 at 04:50:38PM +0200, Marco Crivellari a écrit :
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This patch adds a new WQ_PERCPU flag to explicitly request the use of
> the per-CPU behavior. Both flags coexist for one release cycle to allow
> callers to transition their calls.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> All existing users have been updated accordingly.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8eff357b0436..4f3175df5999 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4885,7 +4885,7 @@ void __init rcu_init(void)
>  	rcutree_online_cpu(cpu);
>  
>  	/* Create workqueue for Tree SRCU and for expedited GPs. */
> -	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
> +	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
>  	WARN_ON(!rcu_gp_wq);
>  
>  	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> -- 
> 2.51.0
> 
> 

-- 
Frederic Weisbecker
SUSE Labs
