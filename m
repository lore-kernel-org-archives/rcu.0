Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7AD3A63F5;
	Thu, 22 Jan 2026 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119171; cv=none; b=rN8z2LraErkZf3QDm47BQZRN3ZbkJp/Alaygm95qUbaAgrOcuaMX/L730Vxezu+tN/YbTf8bOqM4TDIRJPOTRP9DqIV+3FU7N/ireHj7duSfzW8ndypS1sk3jmd0sz1JwfvCCukdCLxDnBh1eGVnXrdkFpUfB+WCTN3yudirXjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119171; c=relaxed/simple;
	bh=7JS8UxhBTkZNel+kTVz0h/0uXknEn0psUm+gp1f3/Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYEp6eHzJYVqPisaxjl5NM5PWYxXJaA3A9/lns2mmKsBwyfiiZkA9lQ5wiM9beFoWvHN6ExtCeHxd1lQGc3XR0FLRFk4FPaLl7GBrTDcTqUInsZGQ6XJMPAQVNUW92GVa7K6QNiN06EqIc+LtxPdyOvMePyE95U5LDx2jspKCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffztNKEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffztNKEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FCEC116C6;
	Thu, 22 Jan 2026 21:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119170;
	bh=7JS8UxhBTkZNel+kTVz0h/0uXknEn0psUm+gp1f3/Q0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ffztNKEXxE2AAc96cjUdTGytbSFyLFQcL+cbQjejNYQ535NwHWgKxNZhhICtgFV9m
	 zoxaxYbfUZXA1/uGY4UMbIIPXw9FiGoQ+s8GivmD5yB2snjiTggqL1Nm+LRDZGRqk6
	 fYRzUOA+Jc08R0cItw13fnAvRGv7+T8jgo+Zt8S+NZggkoIslGiAcAdMB0X9AoVsou
	 hgjowZlMzSm8iVHIfqn3MEOsmoJW3iEn9RmA3DqiBixLVwdbKHiPnHYuN3kGo2AOvM
	 a+WUzUa57TMnIpUNnMmQI35aHGGaLgGzwNVA8xqODRNS9zeCzK/lBzrjSCdu2a/RTc
	 tsJ65PICQny6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 702B5CE0B94; Thu, 22 Jan 2026 13:59:30 -0800 (PST)
Date: Thu, 22 Jan 2026 13:59:30 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 3/3] rcu/nocb: Extract
 nocb_defer_wakeup_cancel() helper
Message-ID: <cb21423d-6781-45de-84b5-5c1f475848eb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <20260119231223.989409-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119231223.989409-4-joelagnelf@nvidia.com>

On Mon, Jan 19, 2026 at 06:12:23PM -0500, Joel Fernandes wrote:
> The pattern of checking nocb_defer_wakeup and deleting the timer is
> duplicated in __wake_nocb_gp() and nocb_gp_wait(). Extract this into a
> common helper function nocb_defer_wakeup_cancel().
> 
> This removes code duplication and makes it easier to maintain.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Good eyes!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_nocb.h | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 64a8ff350f92..b3337c7231cc 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -190,6 +190,15 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
>  }
>  
> +/* Clear any pending deferred wakeup timer (nocb_gp_lock must be held). */
> +static void nocb_defer_wakeup_cancel(struct rcu_data *rdp_gp)
> +{
> +	if (rdp_gp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
> +		timer_delete(&rdp_gp->nocb_timer);
> +	}
> +}
> +
>  static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
>  			   struct rcu_data *rdp,
>  			   unsigned long flags)
> @@ -204,10 +213,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
>  		return false;
>  	}
>  
> -	if (rdp_gp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
> -		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
> -		timer_delete(&rdp_gp->nocb_timer);
> -	}
> +	nocb_defer_wakeup_cancel(rdp_gp);
>  
>  	if (READ_ONCE(rdp_gp->nocb_gp_sleep)) {
>  		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
> @@ -788,10 +794,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  		if (rdp_toggling)
>  			my_rdp->nocb_toggling_rdp = NULL;
>  
> -		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
> -			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
> -			timer_delete(&my_rdp->nocb_timer);
> -		}
> +		nocb_defer_wakeup_cancel(my_rdp);
>  		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
>  		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
>  	} else {
> -- 
> 2.34.1
> 
