Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6941917CD;
	Fri, 23 Jan 2026 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146893; cv=none; b=RIM4IF+90vuc/BazQAkmSDQJ0rh6qjVwllVH2BTtAMEa1Jlxvy7fOOYx5p5aKojZreGJVAELmgowma7tT684SvuOOxCB7r0gS1oqDEntjr4Z/kzs3vX6CqLKilrCHyVHfUUYEf7pcGNwmyh1RxokhC141V86931Ouuea7/5sNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146893; c=relaxed/simple;
	bh=AV2eyIydo82FCCQ2LHhSYNfi+cDf3BGUBkLTc7RXxVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxIPCh89Vi9ultE9Qzfxkm6NWYvRW7h+VPIeYVXTUzs7aLwkBXKLdUfhOlIn+TDW+4ObOKtPZTYAhM98n1xCpSF3kwpYKVx+2UcViOG/sLgLgxmbnOntZpPyyoZ/zmfUfkyJmPEY2LqBFTp2TqlwubJeDwOVBU1ziAuVKiO3Dx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/DQM5bY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/DQM5bY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B35DC4CEF1;
	Fri, 23 Jan 2026 05:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769146891;
	bh=AV2eyIydo82FCCQ2LHhSYNfi+cDf3BGUBkLTc7RXxVo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=e/DQM5bYMOrbnf7Mo+xw7J9fHESbK+s/mQ+Gft1c0xTWeOvaFRbLoOlkAdx4IjkNK
	 fBni0rz8SosKikqmYT3rMFXEvZU2WDl46bscfUEPzmkddmpTT32pv1pBCP6sb0j4c2
	 /3k5Tg+tSxE49q7lqemy4T9zcLexvl8ct7zBXmwVwpkagmvjr3GCfNl1lDYB13fn6M
	 gg9rn4jtGAOO4iSd1og424zpfw+yQXDK4snXDyE1z7CHcgQqXHU/RZvrZ236pblymq
	 H0zuc9vM+Axh6R8oPaoh+P9LJ1uydMsOo1krUYPgg9Ai6/A00vBQuDj358ArzPrG0X
	 08G9HfM2tYYdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1B5C7CE0B94; Thu, 22 Jan 2026 21:41:31 -0800 (PST)
Date: Thu, 22 Jan 2026 21:41:31 -0800
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
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
Message-ID: <ec825c7c-01eb-4348-a3a6-e464c51ad22e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <20260119231223.989409-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119231223.989409-3-joelagnelf@nvidia.com>

On Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes wrote:
> During callback overload (exceeding qhimark), the NOCB code attempts
> opportunistic advancement via rcu_advance_cbs_nowake(). Analysis shows
> this entire code path is dead:
> 
> - 30 overload conditions triggered with 300,000 callback flood
> - 0 advancements actually occurred
> - 100% of time blocked because current GP not done
> 
> The overload condition triggers when callbacks are coming in at a high
> rate with GPs not completing as fast. But the advancement requires the
> GP to be complete - a logical contradiction. Even if the GP did complete
> in time, nocb_gp_wait() has to wake up anyway to do the advancement, so
> it is pointless.
> 
> Since the advancement is dead code, the entire overload handling block
> serves no purpose. Remove it entirely.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_nocb.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f525e4f7985b..64a8ff350f92 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -526,8 +526,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  				 __releases(rdp->nocb_lock)
>  {
>  	long bypass_len;
> -	unsigned long cur_gp_seq;
> -	unsigned long j;
>  	long lazy_len;
>  	long len;
>  	struct task_struct *t;
> @@ -562,16 +560,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  		}
>  
>  		return;
> -	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
> -		/* ... or if many callbacks queued. */
> -		rdp->qlen_last_fqs_check = len;
> -		j = jiffies;
> -		if (j != rdp->nocb_gp_adv_time &&
> -		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> -		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
> -			rcu_advance_cbs_nowake(rdp->mynode, rdp);
> -			rdp->nocb_gp_adv_time = j;
> -		}
>  	}
>  
>  	rcu_nocb_unlock(rdp);
> -- 
> 2.34.1
> 
