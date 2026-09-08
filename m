Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF33AFCED;
	Tue,  8 Sep 2026 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899268; cv=none; b=N5Z3mWWG0mA5t77QfJBaoGE52K5Z8/f/c0/6KrenqYb2iITXJPuInzY3VIFq7BsE/DlVFOSrKFePp2zgIoVp5eAd+LFhRFbSCOISi4ek64P5Fvle9TqzMITo8Wl2ukZRlB4u/ykPqlJS/ahLTnSs4wfZkgO/4uK9c86sG2vC4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899268; c=relaxed/simple;
	bh=mHJ048ISTiTbtm7GpUOzz2KjFkVayNJdSdSy4HybH5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwrB+xZGL+bR5NOpof/yc9SelzjfgCBTfbnP80RUSxjWcL3s8YzSSiOZMxtzRjagOb2sThmN6/KdbbGtp7K7NsxhY1Pun2zS7or2Vr9yoUDyPgqWLEvj0+iuX7w35JFRz+K5bIJG32d6JjE5dHOEtUIp5sS95q+ztPtNlbdbjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glcxTXyp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glcxTXyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EE91F00A3D;
	Tue,  8 Sep 2026 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788899267;
	bh=lJyYqaCbCwdP5bruFpvI//E0+VfS8E4pGAIm1uN9xBM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=glcxTXyprrdRSxHkwCv4/hqX6QAKXG0uN9cjpLftBeDg42whvHY30e/FApdeNk46w
	 /mGRk+nre1OlqQ4us2WQ6ndrtTVfcoQe2KPppr+vdZLgjUkpswSEwgN6KyoQxeVfmN
	 GW7SSxrRf+hmlJbnhmFWjFF/saf5+6I5RahQlWl5X6WRubUprF+K4dwmV+3cY4evkP
	 eWMFRa4Rmak9jh3eDSxDRjX2vCKQyux5HCqRrzxqBVraxIpOeNDWOp0Xo99TDvPX0L
	 nFgijqcjL0hHd7YecL/W5io9e0gzCRAeJgbQ9fCmtti8ryxKhflSRZ3hAtTnkwVo07
	 F1iNybUUJaaCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D779ECE1902; Tue,  8 Sep 2026 13:27:46 -0700 (PDT)
Date: Tue, 8 Sep 2026 13:27:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] srcutree: Honor is_atomic in
 check_init_srcu_struct()
Message-ID: <7807564a-ee83-4c3e-beb7-edf6ad1ce81d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-6-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-6-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:21PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> check_init_srcu_struct() drops its is_atomic argument, passing
> hard-coded false to init_srcu_struct_fields().  Pass is_atomic through
> instead.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Good catch, thank you!

I am folding this one into the following commit with attribution:

4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SRCU")

This avoids potential bisection issues.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 533607de5728..2af36db37fa9 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -522,7 +522,7 @@ static void check_init_srcu_struct(struct srcu_struct *ssp, bool is_atomic)
>  		raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
>  		return;
>  	}
> -	init_srcu_struct_fields(ssp, true, false);
> +	init_srcu_struct_fields(ssp, true, is_atomic);
>  	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
>  }
>  
> -- 
> 2.43.0
> 
