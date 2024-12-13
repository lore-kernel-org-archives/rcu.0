Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEE1B3931;
	Fri, 13 Dec 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131325; cv=none; b=UE6okEYheRY4Vss92YISzg2BvZyxL12KyE888rsTGghsqXPLUzd1RqKRGysrpjdfjFBVBHfw7TV8LlfSTqZpDTSJ1T1gPSkO3rJKKddkVWsOMrdn627cagw1hxeV9OJ0IXQlvvn8TPgUfB58n3ozN5XWcv6iLvvajrtFOqPRQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131325; c=relaxed/simple;
	bh=6+cPR9eBHLpkUUg7WipONtqTType85yW8E6MJO2HpOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGDFdbD6bek8obL/itPCPi9VFk7uXTJjSNmDJ4Hq7nZPg1U2XGPo8rWWpE+LtbszMSShgZwWJySBorVsRIRLCXsNxv3zgNJybLxQeAYq0CiFNSXJlm4YMB7U20c0wMohxIee0Szecmcmvzlbb6LrxDFaLUsslDbrWdQWFmtvbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpZgD7D2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpZgD7D2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1FAC4CED4;
	Fri, 13 Dec 2024 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734131325;
	bh=6+cPR9eBHLpkUUg7WipONtqTType85yW8E6MJO2HpOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpZgD7D2mVEFuc54tXaH8qGjEi+05SpRQwBX6Y0ZYHUBnu7lE3QVItquOwB2wYE2e
	 SlbEQtaLjS2X5EkyQPCIvqIbZLn78SNWpWNZMb0hUfJEgzbMxGPOYRjKexIEFrtLut
	 F+gW0lVOM5AE3+JVAYJEGl3lKZctAVlRQTnBQg0rxsrkzE4FnTROLRX4XZ2t+YuPlF
	 WPTfZdfirqAjxcI4Jjcg2AHYkz/7oEfqBR7qKfcbjALlUESvsv9I39vOviULuyAuRX
	 YsrN0znWm+evs6C4F9BOLiR6e53c8iR4Ikx+CbkR3BXhqjZhHj+UJ8ttMNGmcgt16e
	 1oldTzyNIybwA==
Date: Sat, 14 Dec 2024 00:08:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 1/2] rcu/nocb: Use switch/case on NOCB timer state
 machine
Message-ID: <Z1y-egJlaH9IWKsV@pavilion.home>
References: <c0daba35-f647-40cd-b556-3a04e03da93c@paulmck-laptop>
 <20241212184214.2018411-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212184214.2018411-1-paulmck@kernel.org>

Le Thu, Dec 12, 2024 at 10:42:13AM -0800, Paul E. McKenney a écrit :
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> It's more convenient to benefit from the fallthrough feature of
> switch / case to handle the timer state machine. Also a new state is
> about to be added that will take advantage of it.
> 
> No intended functional change.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Please drop this one too. It introduced a subtle (yet desired) behaviour
change as Boqun noted. I'll resend a better version.

Thanks!

> ---
>  kernel/rcu/tree_nocb.h | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 2605dd234a13c..0923d60c5a338 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -271,22 +271,35 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  
>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>  
> -	/*
> -	 * Bypass wakeup overrides previous deferments. In case of
> -	 * callback storms, no need to wake up too early.
> -	 */
> -	if (waketype == RCU_NOCB_WAKE_LAZY &&
> -	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
> -		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
> -		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> -	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
> +	switch (waketype) {
> +	case RCU_NOCB_WAKE_BYPASS:
> +		/*
> +		 * Bypass wakeup overrides previous deferments. In case of
> +		 * callback storms, no need to wake up too early.
> +		 */
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> -	} else {
> +		break;
> +	case RCU_NOCB_WAKE_LAZY:
> +		if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
> +			mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
> +			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +		}
> +		/*
> +		 * If the timer is already armed, a non-lazy enqueue may have happened
> +		 * in-between. Don't delay it and fall-through.
> +		 */
> +		break;
> +	case RCU_NOCB_WAKE:
> +		fallthrough;
> +	case RCU_NOCB_WAKE_FORCE:
>  		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
>  			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
>  		if (rdp_gp->nocb_defer_wakeup < waketype)
>  			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
>  	}
>  
>  	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
> -- 
> 2.40.1
> 
