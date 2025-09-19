Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629A237707;
	Fri, 19 Sep 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288747; cv=none; b=N04r+iTIVb5xM1hJqMLg/SLtoeuj/LSaUX5QN1nDHnZNwRp8cz1Efc3pC93AfKWFwW9EdONib5Wka5GhjfE5WXAZ59vOvdwseJFxhETh+SXS0spLycs8y8TwldWrEDNax+rKENLH9niXS/AA4gM9aFGn79vZj/aavFwMJhYJvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288747; c=relaxed/simple;
	bh=FmizBsDFUFSEab9WKBpHkLsCxOgOeoIn8dPl+YHJ+zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuumVaNoHUNOSu5YxWFx/njRiaZa7Iu/aRgZfPdeMI2/G4jFNMvRU92S5pqMC7LSPz4K4lgFqwnzI74nZV8H0I321IPZRXee4/s0Zt/Va9GPaaf/Aiq9rS7XuYyP2NRvuMFiTMMHFLcgjl/UvJXZI8KhJecEpxI5F/Pb55qCnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHkM9dM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHkM9dM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071FDC4CEF0;
	Fri, 19 Sep 2025 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758288747;
	bh=FmizBsDFUFSEab9WKBpHkLsCxOgOeoIn8dPl+YHJ+zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHkM9dM3IksAHaJFyYGr2XAI3+2PZfE+/HbvuHd2ROp6mXWroSS5o0z1VBqM0q+Xr
	 8Gz7RD8ERaOp5aUdLWdxKJ2QakhRJxUWKIxWVRN7AiPW/ATp6WLkaeS+olDCGqTQvI
	 5TU6Ov67ejSV95nU3I9l7KRA6csWwq7T5EBRgOfUACY6OGEPRXIhCJBg1y0VtUJPGa
	 xN02AQxR7PieZ4XrEQWqbhxbesu1H6STee4ZPKS43p0c0Ju7M68ObomYWo9v853Oxe
	 mmdNRMghta4oNWnP/Lk0s09xOs3EO+nNxVRt0YaGnHBfEQU7xyqJI92l2M5wwFr0nF
	 f9e7cWnmnhd8w==
Date: Fri, 19 Sep 2025 15:32:24 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 5/5] rcu: WQ_PERCPU added to alloc_workqueue users
Message-ID: <aM1baMg5MDOQ37lp@localhost.localdomain>
References: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
 <20250918101752.2592512-5-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918101752.2592512-5-paulmck@kernel.org>

Le Thu, Sep 18, 2025 at 03:17:52AM -0700, Paul E. McKenney a écrit :
> From: Marco Crivellari <marco.crivellari@suse.com>
> 
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
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1291e0761d70ab..c51c4a0af6aa5e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4890,10 +4890,10 @@ void __init rcu_init(void)
>  	rcutree_online_cpu(cpu);
>  
>  	/* Create workqueue for Tree SRCU and for expedited GPs. */
> -	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
> +	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
>  	WARN_ON(!rcu_gp_wq);
>  
> -	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> +	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
>  	WARN_ON(!sync_wq);

sync_wq could be unbound as it's not dealing with per-cpu data.

Thanks.

>  
>  	/* Respect if explicitly disabled via a boot parameter. */
> -- 
> 2.40.1
> 
> 

-- 
Frederic Weisbecker
SUSE Labs
