Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D3311C07;
	Fri, 17 Jul 2026 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311213; cv=none; b=E6gq02sG8dCkjNf4ucQLg3GbheJcLh6UBXowmmI+DWUS+vG4IOP9g391t9+oOGs573cINN7O9pxlcUCFyomuUKtbqbjV/qnDfj/w0P5IxJaArtkqnq9xzMZiByMFBM1VZf2xK6Igf6Wk2Fy0hjzcMpe4dV596NLw46vrGGkqbYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311213; c=relaxed/simple;
	bh=Ktp6EhXaHxa1+OaAd5gnVWDlNidSV4RrQkBEcz3IChs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA3Zx7MToNbjmo1RzDNdngSxJgRQjUl4tQj47XVPu100Vi0pXCpiWj5M0dFr8UOjHqPYjI/bWuDr6OUKZP5JAnC3dZX5HkU6TQY8HwZshc+3TjnS1ifFlptgi6ORUBQdkw0GQunzsaWanjVJwoVqa5V490jduHYAX/bWcyylr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCPg2JTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCPg2JTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ED71F000E9;
	Fri, 17 Jul 2026 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311211;
	bh=Gzf6CuwyoTpoCqMhrCnKVzZN3jm/AkER5ueuAKL4rsE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=QCPg2JTqlvKZXrRFO7fH63rhPAlEQHC6Ix8jIgav9k0UGrD9pHDWYx+hcIu79ltZG
	 oKF2WYpyDapZztSXdlX6S8//ODUOME/R/EYDpimvTNDwQ47FGf4jEwqYG3g+VMCGpP
	 wxGdgWXykvim3LmKGUJUVJUt067Db/rKUGtZLYAwJCMnnvjjCXzseLpP12PVfcNWGz
	 igwLzlcP5JydlvtRE9NOuY4lJBAfDP9CB4DpgeoUN6DjhJg7dv3Uz8oFdqoFtv10kI
	 y/YaUzrDemQYzQQVSKfdGWJaCmXI9bDem+XmSKulHcENhJ9MZzrxEQpcZMbZzY1+ON
	 bkNoRPbN4g2bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9DB21CE0992; Fri, 17 Jul 2026 11:00:11 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:00:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Dump rtpcp->lazy_timer status in
 show_rcu_tasks_generic_gp_kthread()
Message-ID: <74b5021e-df37-4d3f-815f-0e9c0b303de7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260716095754.24827-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716095754.24827-1-qiang.zhang@linux.dev>

On Thu, Jul 16, 2026 at 05:57:54PM +0800, Zqiang wrote:
> Add 'P' flag to the diagnostic line to indicate whether any per-cpu
> rtpcp's lazy_timer is pending.  this helps diagnose stalls where
> rcu-task callbacks are queued but the kthread stay sleep because
> the lazy_timer has not yet fired and no grace period has started.
> 
> The output is as follows:
> 
> [   31.319540][   T77] call_rcu_tasks() has failed boot-time tests.
> [   31.320205][   T77] rcu_tasks: RTGS_WAIT_CBS(11) since 7518 g:4 i:0 kCuUP l:150000
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Nice!  Queued for review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 6720dc25cd39..a146d1d98c22 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -723,6 +723,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
>  	bool havecbs = false;
>  	bool haveurgent = false;
>  	bool haveurgentcbs = false;
> +	bool havependtimer = false;
>  
>  	for_each_possible_cpu(cpu) {
>  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
> @@ -733,10 +734,12 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
>  			haveurgent = true;
>  		if (!data_race(rcu_segcblist_empty(&rtpcp->cblist)) && data_race(rtpcp->urgent_gp))
>  			haveurgentcbs = true;
> -		if (havecbs && haveurgent && haveurgentcbs)
> +		if (data_race(timer_pending(&rtpcp->lazy_timer)))
> +			havependtimer = true;
> +		if (havecbs && haveurgent && haveurgentcbs && havependtimer)
>  			break;
>  	}
> -	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c l:%lu %s\n",
> +	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c%c l:%lu %s\n",
>  		rtp->kname,
>  		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
>  		jiffies - data_race(rtp->gp_jiffies),
> @@ -746,6 +749,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
>  		".C"[havecbs],
>  		".u"[haveurgent],
>  		".U"[haveurgentcbs],
> +		".P"[havependtimer],
>  		rtp->lazy_jiffies,
>  		s);
>  }
> -- 
> 2.17.1
> 
> 
