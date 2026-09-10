Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860A3D9549;
	Thu, 10 Sep 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059503; cv=none; b=l/zlBXIheSJ8dMT8aj0u3fV/ac02/aJnYDx40X4OFU5jiLTsMEFO5k5OCrN2WdMwk5Lve7ijoqL93puqOMxTN/ZHbhxCKAJtq47+qaBfuvUWAGWQEMck5e9Z/Vch7GvK4iSJ37NYWWa2f5nJbZ7V2mZcvdIJhkELucZC4BRvWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059503; c=relaxed/simple;
	bh=BzZJSjIuyGXLWzPj2Rfe1QLd5VAJxrndxiWXjXMv0a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCcB2wvTgNA186lUjIcmjs0PCyz2IM3XWrf7n2/lBQ0uKGadskqYQux2dHSp/ZNeRa56sTDolxNS6gxfFKXruXJKYuk5CBfdgnv5xX4au0c8ZFEGuAIj9VpFYz9S9bYyMFrZioqIVslW+BicGwSJPAi4niMb25f+L7Lp5o4mKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Vf41CA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Vf41CA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411D91F000FF;
	Thu, 10 Sep 2026 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059500;
	bh=uQ9Z76diTPpbcOLgsY33fOM3q6PtV9hbrRW14or5nmE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=H5Vf41CAs54zudqOZMQd86DIu18nmM9o+3YGLzIpgXB8S8M1e9Bzb2/Cu9LDeshC+
	 PdAJCjVVZN81ZrV8BtphKQPyMLY0kv0K4bTj84O8n1Wqxnc/BNcLBCkPMG63cyvRro
	 AHhTLrJyib4Pn/NE/8o2S/EBfHSb0C5OE3uTpevuOHs9wasKIeaWwD0YVzdpZf1T9T
	 TsAb7v9dwhqmecA3BEj5vhwrCN4ydYK1mJkzueJfnlXnAu1xYxFJ0LvlEKhRKRUXeD
	 fF5IEn5eg3qNYPWANVej4CyQokg0aDOy7pt6/jtTCvIcLzEK12BcZrp/GWIkudyyDG
	 ml4ipXSjQEUwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 08E57CE1580; Thu, 10 Sep 2026 09:58:20 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:58:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcutree: Add WARN_ON_ONCE() for atomic SRCU in
 srcu_gp_end()
Message-ID: <d1bf830e-8755-4eef-a8f6-35612640a478@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260910084629.3695383-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910084629.3695383-1-kunwu.chan@gmail.com>

On Thu, Sep 10, 2026 at 04:46:29PM +0800, Kunwu Chan wrote:
> Atomic SRCU remain in the small size state, so add a
> WARN_ON_ONCE() before the transition check to catch any future
> code path that might violate this invariant.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
> Changes since v1:
> - Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
>   per Paul McKenney's suggestion.
> - v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@linux.dev/
> ---
>  kernel/rcu/srcutree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 84c022ec8e09..68441c32cebf 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1074,6 +1074,8 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
>  	}
>  
>  	/* Transition to big if needed. */
> +	WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC &&
> +			ss_state != SRCU_SIZE_SMALL);

Also much better, but we also need to avoid doing the transition in this
case, because doing that transition breaks atomic SRCU.  On way to make
this happen is something like this:

	if (ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC && ss_state != SRCU_SIZE_SMALL) {
		WARN_ON_ONCE(1);
	} else if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
		if (ss_state == SRCU_SIZE_ALLOC)
			init_srcu_struct_nodes(ssp, GFP_KERNEL);

Other approaches might take advantage of the fact that WARN_ON_ONCE()
returns the value of its argument, allowing WARN_ON_ONCE() to be used
as a condition in an "if" statement.

							Thanx, Paul

>  	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
>  		if (ss_state == SRCU_SIZE_ALLOC)
>  			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> -- 
> 2.43.0
> 
