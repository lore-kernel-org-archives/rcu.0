Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16462931FB;
	Fri, 11 Sep 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144680; cv=none; b=jOjVDnPDKzk4aNUpW0/NX/UR0AGYRPOg7+z/11nWbgtIAeAPrLNlheG07Dhr+XfokxeLbkbpwOkJX2dxpdBB7sGePpuHouBpSsYi6OxsQP0uosMAvT2Ez1SlMYr296J7pSNdwMS/cNpi/z6ANzX05d2y/Lu7t36xAYF0wfKi/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144680; c=relaxed/simple;
	bh=NSebXXqyyCGwxDChOd0wVFSkKiWOEc0YAMjbgU5GqZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfdvTxFUiIzaiPUt6wH5rZeReg439yGZBpG8K+O/PvOIg3A09+lizBkSYpwIfodEK+F2wlrXrL9UZLisRMOSdYywLgR6WxctJeTIios1z8+F1rtR9xQHBkLUaqo7ydyiez/GUwC5wT7YqdtjkCYaFNoZxYnoEedBPWXYo4fQ2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPesIObu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPesIObu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF291F000FF;
	Fri, 11 Sep 2026 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144675;
	bh=8tmHxNsUmwHYfJS7T5Te73IpGSPdrhP2Nq7H/5UODI4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LPesIObucZYAA8WZIDxBB3ODcPqOo24SKfKcAjr9rsGDP1baqa1aACK10vXLctFr3
	 ql9Pye1aLdhDZ+9/EyB6e2ulz8gS2Y4ovM/Nz0CvqPygUlBMCRMzlxUc9xMRInSAth
	 RJQMl6y/LQvLjoW4AQ9dY1xZNLxyOwjEm2CJ9mi1DDDsvQDWHT3DGGFgiUvu1FyHk5
	 iyB6d/4/PuNxVWa6VsuNkzxcMnfnHy18pswU9OevtSK0zniGpFUZ0Pg38UThjgzYTk
	 mqHXA4yC7XRhKJ5AhUh2SWEnljAjP2ON8tDj/GJBFqmAv6ObDsIIY6FifILX1w0t00
	 K60T9PR+WSllA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 311E1CE1902; Fri, 11 Sep 2026 09:37:55 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:37:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] srcutree: Don't transition atomic SRCU to big in
 srcu_gp_end()
Message-ID: <71507136-1439-4ee0-b176-e45ed3f60429@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911072125.2268530-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911072125.2268530-1-kunwu.chan@gmail.com>

On Fri, Sep 11, 2026 at 03:21:25PM +0800, Kunwu Chan wrote:
> Atomic SRCU must remain in the small size state. Warn if this
> invariant is violated and avoid transitioning to big in that case.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Very good, queued for further testing and review, thank you!

I folded the new "if" statement onto one line because some years back the
Linux kernel liberated itself from the 80-column constraint imposed by IBM
back in 1928.  We can now have up to 100 characters in a line of code.  ;-)

							Thanx, Paul

> ---
> Changes since v2:
> - Also prevent the transition when the atomic SRCU size-state
>   invariant is violated, per Paul McKenney's suggestion.
> -v2: https://lore.kernel.org/rcu/20260910084629.3695383-1-kunwu.chan@gmail.com/
> 
> Changes since v1:
> - Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
>   per Paul McKenney's suggestion.
> - v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@linux.dev/
> ---
>  kernel/rcu/srcutree.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 84c022ec8e09..07db4e459b30 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1073,8 +1073,11 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
>  		raw_spin_unlock_irq_rcu_node(sup);
>  	}
>  
> -	/* Transition to big if needed. */
> -	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> +	/* Transition to big if needed, but never for atomic SRCU. */
> +	if (ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC &&
> +	    ss_state != SRCU_SIZE_SMALL) {
> +		WARN_ON_ONCE(1);
> +	} else if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
>  		if (ss_state == SRCU_SIZE_ALLOC)
>  			init_srcu_struct_nodes(ssp, GFP_KERNEL);
>  		else
> -- 
> 2.43.0
> 
> 
