Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEE366075;
	Thu, 27 Aug 2026 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850137; cv=none; b=SgMeXim+NSFEO6wl8CuNYCXLNh23DcgSUplp3IIrEqD2zsOgmB6dNq7+Y/oQfbFPDOil+N4rXoy53X/MPQupWwWC/yb2UtKn9uQGzvkm8KJAB9CB2XNe8gRgAlY0vvwXLuJIF9uG2ZcNuFRF99siQuo5osA6YrhVdybj8nozkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850137; c=relaxed/simple;
	bh=GhwDhOuJ5iCdI0aTMkGOuDyqy51ao91JlyyVXgOfHhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac8lMd4OrhvtfIJbL4rbY6dW4LL1xJwpHIYYcL6ccZeIEf4Xc5DnI7QdkkvR7zkQGxzu46QHfBmYG4wQdlyT6JJmG5QFOOFmqsuu/HSDhAciJZ+XjqE1RF+3BFSjfsxGVsrL2+DXHO4Xyf8ykHKo7gliVKIwslfLDvU9uUZppI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwCptYRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwCptYRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EFE1F000E9;
	Thu, 27 Aug 2026 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850127;
	bh=WWuAugr4GhZS+rygnajCG04VHmetYx6vEJc+8qt5BAs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=IwCptYRJDqA4cnGVlHa/18IrggpI6ek3E1bLH/s891nWjZvMTJtcJgI/B3JHSLyvU
	 cNcAOFHogeVuanhlWWHmPxbmUHX5mfMwYODA9MeihVPTJK6l1Ylj1atZigVKqkca6P
	 2YVkX2AxEZmVVy2TbE9h2XEX3GHwWNkZBLdk9oi3XS8upQoOWnIELiYELpA3oRYEY+
	 CjHtIQ4jGIXIeLeW/H87+VpOvhWtS8QPCsfAWAuTSo54XGghl1Vu961qntJL0olFPH
	 jqLR7nybgdYRAZZiZVvZ+qUbaMeEuP/kLHaR6qW761gzq9ka1hclcOsn7hIu+nz2Zg
	 vVeCP5zNrJVbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC620CE1496; Thu, 27 Aug 2026 10:02:06 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:02:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, boqun@kernel.org,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix divide-by-zero with fwd_progress_div=1
Message-ID: <3837e540-13dd-4723-bd5f-a109ce6733a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260820094228.540304-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820094228.540304-1-kunwu.chan@linux.dev>

On Thu, Aug 20, 2026 at 05:42:28PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> When fwd_progress_div=1, the forward-progress test computes:
>   sd4 = (sd + div - 1) / div = sd
>   dur = sd4 + torture_random(&trs) % (sd - sd4) = sd4 + % 0
> 
> The modulo operation with a zero divisor triggers an integer
> division by zero (undefined behavior at the C level, #DE trap on x86),
> causing a kernel Oops and panic. On x86_64, this manifests as:
> 
>   rcu_torture_fwd_prog_nr: Starting forward-progress test 0
>   Oops: divide error: 0000 [#1] SMP PTI
>   RIP: 0010:rcu_torture_fwd_prog+0x90b/0x1160
>   R12: 0000000000000000
> 
> The existing guard only handles non-positive values. However,
> fwd_progress_div=1 also makes the random range empty because
> sd4 == sd.
> 
> Change the guard to reject values below 2. The forward-progress test
> only reaches this calculation when stall_dur() is positive, so
> sd = stall_dur() + 1 >= 2. For fwd_progress_div >= 2, sd4 < sd,
> ensuring that sd - sd4 is at least 1.
> 
> Keep the existing fallback to the default value of 4 for invalid
> values.
> 
> Verified with QEMU/KVM: a 138-second run with fwd_progress_div=1
> completed 81 forward-progress test cycles without a crash.
> 
> Fixes: 1b27291b1ea4f ("rcutorture: Add forward-progress tests for RCU grace periods")
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Good eyes!  Queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 54bec8e21e71..ed2407e888b4 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -3990,7 +3990,7 @@ static int __init rcu_torture_fwd_prog_init(void)
>  	}
>  	if (fwd_progress_holdoff <= 0)
>  		fwd_progress_holdoff = 1;
> -	if (fwd_progress_div <= 0)
> +	if (fwd_progress_div < 2)
>  		fwd_progress_div = 4;
>  	rfp = kzalloc_objs(*rfp, fwd_progress);
>  	fwd_prog_tasks = kzalloc_objs(*fwd_prog_tasks, fwd_progress);
> 
> base-commit: c68271c3f83a46de3fca48d3aa9e27c4dec8e58a
> -- 
> 2.43.0
> 
