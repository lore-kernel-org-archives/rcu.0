Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A971A2544;
	Wed,  9 Oct 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494342; cv=none; b=sIvEBFc6ihV+n0E0FYnLsrKODKirTX8qbroFGiebh7Un2Xi8aFCUAx7o9nhDzVKRFdFRgUxqZoMnBBQ/oEs+c8QiYRQbqV9CcZzo4Iql9f+/+Vsuw6v2mFGpKS2XsEoPJsXyxoLJgOCZVOEUQmPwP2Ow+3dimmDl3Jk3Y3M+OO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494342; c=relaxed/simple;
	bh=4ywsws1VqT75eiBREC+WyNrE0uUBPNDQWK/1QExI2Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv+shJQyGWLkW5MHNZ3eGT9ryO5lcxF+p02cbL2x+jicIdeLa0vu661qoSVKO56yYxhdKUCIbnrJho+w0Eta+aP437er3dXyqdofrlOo/zEW5G0yKKmSMRYMkYOcMgsZjkzHcb28JZZTZiz1PAVcVWtYElbfKj8WIFci0HMA8lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAT8UerZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAT8UerZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1357C4CEC3;
	Wed,  9 Oct 2024 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728494341;
	bh=4ywsws1VqT75eiBREC+WyNrE0uUBPNDQWK/1QExI2Hk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tAT8UerZ7MBLWcqnkb7vOqiWzn7JtDD6n4NKfpSTessMQQdXpJ5G8vnPr0n26iVK3
	 jvWR6zGAqJt+6Asv9CnrLcic8ZbGQXZvIu71SrSjt0NDnX1kXX7NLHGgq5ujWaNvvf
	 wK3Dpg9nx5Uo7LIGuMDCuGYIjndpqaDdRzEAC40lWUK1tZI2Qfhc+OcVi5b0ihyw58
	 NXhjo667lWumg3XLUQgfCjpMo8um2zX0zpH80U0oBCLrawtRGyPi0gOpVgwqT2EXWw
	 xhdl/oYgJgm8pmxn2qJkehqU3bfhCcAnxnYkP+4DYkm1mXkGPl9Zw+TNV2ZGS7wgBl
	 +YLlq8mPecUiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7ECBACE08E5; Wed,  9 Oct 2024 10:19:01 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:19:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/srcutiny: don't return before reenabling preemption
Message-ID: <6c9dde7f-271b-4342-8ce9-8f363b341c0d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241007101415.466155-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007101415.466155-1-mschmidt@redhat.com>

On Mon, Oct 07, 2024 at 12:14:15PM +0200, Michal Schmidt wrote:
> Code after the return statement is dead. Enable preemption before
> returning from srcu_drive_gp().
> 
> This will be important when/if PREEMPT_AUTO (lazy resched) gets merged.
> 
> Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Good catch!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/srcutiny.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 549c03336ee9..4dcbf8aa80ff 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -122,8 +122,8 @@ void srcu_drive_gp(struct work_struct *wp)
>  	ssp = container_of(wp, struct srcu_struct, srcu_work);
>  	preempt_disable();  // Needed for PREEMPT_AUTO
>  	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
> -		return; /* Already running or nothing to do. */
>  		preempt_enable();
> +		return; /* Already running or nothing to do. */
>  	}
>  
>  	/* Remove recently arrived callbacks and wait for readers. */
> -- 
> 2.46.2
> 
