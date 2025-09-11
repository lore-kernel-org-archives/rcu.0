Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147B2E401;
	Thu, 11 Sep 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596897; cv=none; b=nj/ZzLJMgFFax0tNZhXKyMRNGaJb2Lz5aVepcduGBHHzBgm/adSnGIzumRFD6fmsEZOA6b9QX/gKd7XQIjqdDrxwwdb/AivhJ0jdrDywrK8U0H8u5vhonq8WXHOXflpHVwe1WGzg+N7nt2FN3MijyC1LAmHI2xvI49CPirYBw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596897; c=relaxed/simple;
	bh=6c9klDt18jl+gFohRDLXSrL2yCShjZ47v03Qi/9pmS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DITPR7ntJuhMVHB2sdMoWUuvikGlLMciCC9lx/QnKBk5cbRL3leweN7ElnatLQlESjcsBZ1q4623Rkb3J2V5bmn+L4mVw7NvHWganoqUVEbWY8y9tulQ2+7NG91J5hCyiMMUcnOE4rU0A48BW2FWd1G0ntmpfWb+88TZey6D47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toLlK021; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toLlK021"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816C5C4CEF0;
	Thu, 11 Sep 2025 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757596896;
	bh=6c9klDt18jl+gFohRDLXSrL2yCShjZ47v03Qi/9pmS0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=toLlK021c1qJ4yxeR/x0qHYqssmduqfIK9nKjp3XQ7MobLvRvCCB7ZsWvkmDBed5Y
	 1fQajHYj/zzOuyI2tlUKQ7+xvYV93vegfuRr7zjNIBap1UTN+oTg3uNWZsQFycX88T
	 AMLXjglGZJAmByDs7vAKFiiIBnc0YWbi0d5ZBYbDiTcQqatwFxr4eDDhNXcu2tx5kZ
	 iH6goQAaTcyvF6HJwAoB+rswzW60/ryqTOngUqTooz9ZNyezSVcfzgxg0tD0KzWG8M
	 +wSYX0Sg+Zm/kauSvk02uNnlhpJhE+MfSV1073gDSpf1hr/eXANAnvbSC5+waUKSVD
	 EWxEOKP2Fd4WQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59D6ECE0DDA; Thu, 11 Sep 2025 06:21:35 -0700 (PDT)
Date: Thu, 11 Sep 2025 06:21:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
Message-ID: <b2ed5820-e82c-4997-a1ff-109516a96524@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250911125155.680960-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911125155.680960-1-qiang.zhang@linux.dev>

On Thu, Sep 11, 2025 at 08:51:55PM +0800, Zqiang wrote:
> Currently, the srcu_gp_start_if_needed() is always be invoked in
> preempt disable's critical section, this commit therefore remove
> redundant preempt_disable/enable() in srcu_gp_start_if_needed()
> and adds a call to lockdep_assert_preemption_disabled() in order
> to enable lockdep to diagnose mistaken invocations of this function
> from preempts-enabled code.
> 
> Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

I replaced your v2 with this v3, thank you both!

							Thanx, Paul

> ---
>  kernel/rcu/srcutiny.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index b52ec45698e8..3450c3751ef7 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>  {
>  	unsigned long cookie;
>  
> -	preempt_disable();  // Needed for PREEMPT_LAZY
> +	lockdep_assert_preemption_disabled(); // Needed for PREEMPT_LAZY
>  	cookie = get_state_synchronize_srcu(ssp);
>  	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> -		preempt_enable();
>  		return;
>  	}
>  	WRITE_ONCE(ssp->srcu_idx_max, cookie);
> @@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>  		else if (list_empty(&ssp->srcu_work.entry))
>  			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
>  	}
> -	preempt_enable();
>  }
>  
>  /*
> -- 
> 2.48.1
> 
