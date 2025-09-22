Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F8192B7D;
	Mon, 22 Sep 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550106; cv=none; b=IUFQ2tNmiqPIcFvJAyR0Tu3yn3/UWpnpDXaEZ6qWWFS/iJcIIH/I5r9FY6y5PLHVjn/HekGrmttNLBydt7A5TUtu6tyXotaAUAsKHtg+bKaQPBhlFOMlTUJFB5b+72XJZlInYKS9gXYCSwgaAfY2rtelvFt6grNtGQEtWMfhbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550106; c=relaxed/simple;
	bh=EuwguCrlvnQz2b1jp7+qs/Utu8Msk16IYpcUFGzQ9uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH31TQNUjqj1dxGO+xrvkt+KDGlun/UpTyUtLvHOFKLsGwHFuZ8nVK1kWWF7E0PZ3vqmbNE3ut+VfZmZkmGfJ7Jbh9O/pJ83OBg+EZwuGeAU0uX9xkdb165G40hXUCmBRkioWwc9KE+a0Uhn6rxN3vbP9pMM8gZff+Eo5Ed8RI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cILS3pRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cILS3pRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B68AC4CEF7;
	Mon, 22 Sep 2025 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550106;
	bh=EuwguCrlvnQz2b1jp7+qs/Utu8Msk16IYpcUFGzQ9uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cILS3pRGMnHwlp0GdrjlqpLeDE6IDkqOPmw0AVcHiDnx2rFT4CXr2UzmbctgD3evW
	 KR+5VsIp+4nQ3NamEb2RljGuK4cpjpziuKRZnxZwXKg9wYyu6vFZ6gP2NgefjVVfB0
	 RmaRYpVTJwQZeROF6/pG1aS5a6pCIAFfK3FFR4YxMmP42rPXDGgscvmy0YT/qlPMRa
	 uXYRwSxK2iH4vmYd0K95f2uwDsw1yISHu9gYgvoS73UjZ+/SidqFg6gIEpUbHAK6Q7
	 fqKVCzIOFrKLgdVq4GXL7d7kRPNLm7/W/Y/vrC6LYiPDak4NqTdJfbnInU6D9HFcgh
	 aw7r29q1mxgCw==
Date: Mon, 22 Sep 2025 16:08:22 +0200
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
Subject: Re: [PATCH v2 1/3] rcu: replace use of system_wq with
 system_percpu_wq
Message-ID: <aNFYVlroMXv5MAOm@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
References: <20250919145040.290214-1-marco.crivellari@suse.com>
 <20250919145040.290214-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919145040.290214-2-marco.crivellari@suse.com>

Le Fri, Sep 19, 2025 at 04:50:37PM +0200, Marco Crivellari a écrit :
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue, yet nothing in its name tells about that
> CPU affinity constraint, which is very often not required by users. Make
> it clear by adding a system_percpu_wq.
> 
> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  kernel/rcu/tasks.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index f92443561d36..2dc044fd126e 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -553,13 +553,13 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
>  		rtpcp_next = rtp->rtpcp_array[index];
>  		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
>  			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
> -			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> +			queue_work_on(cpuwq, system_percpu_wq, &rtpcp_next->rtp_work);
>  			index++;
>  			if (index < num_possible_cpus()) {
>  				rtpcp_next = rtp->rtpcp_array[index];
>  				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
>  					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
> -					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> +					queue_work_on(cpuwq, system_percpu_wq, &rtpcp_next->rtp_work);
>  				}
>  			}
>  		}
> -- 
> 2.51.0
> 

-- 
Frederic Weisbecker
SUSE Labs
