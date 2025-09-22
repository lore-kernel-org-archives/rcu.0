Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CD21DA23;
	Mon, 22 Sep 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550490; cv=none; b=ifjYdObGKCSKumyY3yO+DZY9Ua0Pr5ljVY46HONFGwqUvLiN65NS4uESGTeUQIAY+t06idxrHuVmKehSQmR/SCzt1tKP9+TlcJs4hsMgq83J9HYRfwd/8eS6pgq7BirS4aNVEmT9wGj+RVD8ciIbhsfB6AOZytdbALmSKvwhFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550490; c=relaxed/simple;
	bh=1Um/7eW64s8ZlVqQRHouhXRbAmqR4c08KCIXT6us7L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdrtavuV3FIUqZX85IbRVx1DCLEzPMpdIn7gqud4ZdoZYaNvG2TvFpfyUjc0KAELwQ+D4i1m8bl3idpxHxcRJ8PGWF3BdOMkCjIiyyYkAu8kDw5eFDnuStRfhvsJ8lmf1KzfNv3aNAVcwc2nCMfGiOLwcG4cj+2VcJTpLcu9Ixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRC/YkZ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRC/YkZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D6AC4CEF0;
	Mon, 22 Sep 2025 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550490;
	bh=1Um/7eW64s8ZlVqQRHouhXRbAmqR4c08KCIXT6us7L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRC/YkZ2hEwdyJaKfspnZczuFMlvTMM9zy+ISaXcxCwnjSGZlW7YaX79yYEabwks0
	 SvD8vQW+W//0qgVAgBoKDD3EaPE9x0uSQj4jNRWn+SLkeQObrn1LuDOPpx/cNOTIp4
	 s8nfNg2ZF+XiP0FaEg7VOe3f6CzBoRYQ0BCrB1rJXYsHj90US3lWl2X0T9Z+NJAhtA
	 bieQ0+vXuH4oclle5VokbneVxbwWc514btvmxPlEIrFDT7VGzeFXs/waZgNYBFWQAT
	 xw8T0b/Y5UDcBXWw3R0p9b4HV/eGTrmwrNle7qLpP4zJuxsBkfQCaeNYx/p21f8Pc7
	 J/CiMkcS4PpqA==
Date: Mon, 22 Sep 2025 16:14:46 +0200
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
Subject: Re: [PATCH v2 3/3] rcu: WQ_UNBOUND added to sync_wq workqueue
Message-ID: <aNFZ1huhgmMkaIWH@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
References: <20250919145040.290214-1-marco.crivellari@suse.com>
 <20250919145040.290214-4-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919145040.290214-4-marco.crivellari@suse.com>

Le Fri, Sep 19, 2025 at 04:50:39PM +0200, Marco Crivellari a écrit :
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
> This change add the WQ_UNBOUND flag to sync_wq, to make explicit this
> workqueue can be unbound and that it does not benefit from per-cpu work.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4f3175df5999..7137723f8f95 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4888,7 +4888,7 @@ void __init rcu_init(void)
>  	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
>  	WARN_ON(!rcu_gp_wq);
>  
> -	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> +	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>  	WARN_ON(!sync_wq);
>  
>  	/* Respect if explicitly disabled via a boot parameter. */
> -- 
> 2.51.0
> 

-- 
Frederic Weisbecker
SUSE Labs
