Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092053B3BFE;
	Tue,  8 Sep 2026 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910701; cv=none; b=Uikbv+iBmelpBwspynCuxAJQocN+4uM5uu8uf1eQy9JSZE+B/KpTmA7t9gAzd5F+UE1NJy/nSa7DdbONBGcGOHJBj5e6fedxrrHcnJ//gJO1m9dSxU1X2M6RpKAlR/bwlBHExjoKMCF8jkRoo9/sQqO5MUjm0qLJ/wpZYkafol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910701; c=relaxed/simple;
	bh=BOG0XU4Hi/kX0mtdmmwmyPys4GuKYg7UEEQuDcp0EY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQAq4e4D4RODNqjZ3e0/Li4IxjgOrx2545qcbp3jdOM4km5Tm4xg+uASzYj2czxLA8/x2oPIgirofmIgyXOMt4hQVTzHFUAA+FcOt9gnIkckH8oyXDaCRrHmVPIpXxjvHCS4lYPwjq4oS0584edCemAWttB5yBzuXSfGrd9YMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYQffycH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYQffycH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDE81F00A3A;
	Tue,  8 Sep 2026 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910699;
	bh=dDB7Fvs1o7toUW5Jbc3zZdDrrkdeVpiPhTfCkTQU7Qw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=SYQffycHOSMLOsMzcuUebcCDt0SPaZdkG3F1+pF4YoUzpd7XWYk5WOMZSA1k43uRO
	 dxFSEH3BOes0pDbLNZ6ks2VHrzn8CI2EXR1BnwX6B0FGo9mUcM5Q4nhj0H4xi6/+Kd
	 X4A5kWMV3Qew7sCEihfmPRrQ+rf+a4nckvbjHIhyAOAer/W8F4GjyEOhI8ILXp9izl
	 dUA3V+hqPoPK5jCV/NycunPf8OJV/jT6OlgR+Dm7OBRk4t7poTPJx42LYX4RDjbXFs
	 drrXxvlSg6SSN1/tHdqYs95H+zJQv6VhsTLRgswSM22v5uBpjU+ff1XUf7CZ02a8qC
	 o1S3R8xfcBr5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 75A3DCE18F4; Tue,  8 Sep 2026 16:38:19 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:38:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] srcutree: Don't transition atomic SRCU to big in
 srcu_gp_end()
Message-ID: <cb71412b-a688-4c70-9365-3f6bd40c9244@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-8-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-8-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:23PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> The transition-to-big code path in srcu_gp_end() calls
> init_srcu_struct_nodes() with GFP_KERNEL, which is illegal in the
> atomic context reachable from synchronize_srcu_atomic().  Atomic SRCU
> has no use for the srcu_node combining tree: it has neither callbacks
> nor srcu_barrier() operations, and its grace periods are serialized
> by ->srcu_atomic_gp_flag instead.
> 
> Skip this transition entirely for atomic SRCU, which is also defense
> in depth against any path that might wrongly set ->srcu_size_state for
> an atomic srcu_struct.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Again, given that we have this commit, is this patch needed?

4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SRCU")

And again, if so, please tell me what I am missing.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 01f224a56b41..74acd5645d4c 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1074,8 +1074,9 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
>  		raw_spin_unlock_irq_rcu_node(sup);
>  	}
>  
> -	/* Transition to big if needed. */
> -	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> +	/* Transition to big if needed, but never for atomic SRCU. */
> +	if (!is_atomic && ss_state != SRCU_SIZE_SMALL &&
> +	    ss_state != SRCU_SIZE_BIG) {
>  		if (ss_state == SRCU_SIZE_ALLOC)
>  			init_srcu_struct_nodes(ssp, GFP_KERNEL);
>  		else
> -- 
> 2.43.0
> 
