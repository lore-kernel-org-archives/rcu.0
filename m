Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F441E0DCC;
	Wed, 19 Feb 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971341; cv=none; b=V60Gwn3okyEPMld3Ct9c/SKDKF+GSwpvMGSK8jofXCX9iseNG+qapNzLwWSi0+bJmmJfkws0LUrQCn0HrvPtK6DCWsvieqHm6XqPfcfwchM2SR3VDHGgY/ni/ZN3wN0rCkGmqHSLjOemAnv7JDv2y+hxjMwD+KNO46TIJB2JscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971341; c=relaxed/simple;
	bh=8w5RYSxrkoei/wIltaYVpEawt0WugVkUCNlqdUYlFfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udgIYC374zAqxdKSWk03ReeTLouEG+Ej6Vp/ljaIGJRpJyCzJOwoODcOxPnLWVPOkSP+FTaxxdy/MaLxYU//Rl4bxCzqljP0IgCePA0CN+yehWhoOLYY7O/zQhvIgUp8Z2uWJZgo4QgLLluWpp9vCFZQ9qpjf4BAB/ye6fOCdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7GUutww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7GUutww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26F2C4CED1;
	Wed, 19 Feb 2025 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739971341;
	bh=8w5RYSxrkoei/wIltaYVpEawt0WugVkUCNlqdUYlFfk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=l7GUutwwyAfl8o1n6obqY0Yxdhv7x+sklvMpUHAdL11f3yEVXNaIM8PV2rqQ9IaTU
	 FNEeuVJesYqN6c5ulQLecjDpoDEH7iUfaidXiX9h2STGa7x96r6fa4HcQzdgQGDSgv
	 zlfJ2D/RKgUjyiBZza12VyUwcNKene0650Qq+Kc/JCZAObmKdP0qDIBeLFAq/5FjIF
	 mRazZzzORV1RmZdGg+tVtH8mOS6rF3ekD0A0tBBJLvRTYYbwuU0ik2YA1f7KF5AoTs
	 FqoMTb5FD62A+XSfEKreKvdIB4wLpehbt8t5USCgEQ8x8zSktHgnWgH8LeCDYU8bPA
	 1KS8iQUSiBs6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 408E2CE092C; Wed, 19 Feb 2025 05:22:21 -0800 (PST)
Date: Wed, 19 Feb 2025 05:22:21 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 -rcu] srcu: Use rcu_seq_done_exact() for polling API
Message-ID: <dde0f073-c3d9-44c9-bd85-cf0e8a0fd628@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250219124309.463702-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219124309.463702-1-joelagnelf@nvidia.com>

On Wed, Feb 19, 2025 at 07:43:08AM -0500, Joel Fernandes wrote:
> poll_state_synchronize_srcu() uses rcu_seq_done() unlike
> poll_state_synchronize_rcu() which uses rcu_seq_done_exact().
> 
> The  rcu_seq_done_exact() makes more sense for polling API, as with
> this API, there is a higher chance that there is a significant delay
> between the get_state..() and poll_state..() calls since a cookie
> can be stored and reused at a later time. During such a delay, if
> the gp_seq counter progresses more than ULONG_MAX/2 distance, then
> poll_state..() may return false for a long time unwantedly.
> 
> Fix by using the more accurate rcu_seq_done_exact() API which is
> exactly what straight RCU's polling does.
> 
> It may make sense, as future work, to add debug code here as well, where
> we compare a physical timestamp between get_state..() and poll_state()
> calls and yell if significant time has past but the grace period has
> still not progressed.
> 
> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

But we should also run this by Kent Overstreet, given that bcachefs
uses this.  Should be OK, given that bcachefs uses this API in the same
way that it does poll_state_synchronize_rcu(), but still...

							Thanx, Paul

> ---
> v1->v2: Resend with Neeraj review tag. Rebased on rcu/dev.
> 
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d2a694944553..591371d62e89 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1589,7 +1589,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
>  bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
>  {
>  	if (cookie != SRCU_GET_STATE_COMPLETED &&
> -	    !rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
> +	    !rcu_seq_done_exact(&ssp->srcu_sup->srcu_gp_seq, cookie))
>  		return false;
>  	// Ensure that the end of the SRCU grace period happens before
>  	// any subsequent code that the caller might execute.
> -- 
> 2.34.1
> 
