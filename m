Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EA320A1E;
	Wed, 10 Sep 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512550; cv=none; b=mJj8URHubp2Nm4qEkVAg0dKhgclGWgvBPorwBn4PQ48iQSohcLBKpXRDwEfMvHPkhXUWYaBEMqAAxYrMhq/Lt/SqfsysdKvvJFNVlSoIdu//KeLk8HwBVKh4iNpb3BdUMDrTKu6eu2DryvzS/ySv+yuUEZjflLEArJZPPqD99PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512550; c=relaxed/simple;
	bh=GK5FA49bUs3SbDiY7Vwj1tEe+TZCk9dABDYERDNIHng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIEPwgM3MkIGn/Z/XY6llsaEWQMvYAql7aeJA7m0Vn3yXbuA9RKat90ZviC/FtbP3jeHRmiek/JD05FwC//KcEYtrSD8T/AlsiSQ1RcOVqcXQSe7WWadyxh49ixzdihuUCYXeua/8rh2tN/N92lXQO+Vk0FyRTQYUVrlRMXbYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktMAJFS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktMAJFS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C80C4CEF9;
	Wed, 10 Sep 2025 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757512549;
	bh=GK5FA49bUs3SbDiY7Vwj1tEe+TZCk9dABDYERDNIHng=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ktMAJFS6OAFRoUCXcFNNsGhMv+DJCKhd6RJHGgbJTB5G5LgIy9qvvyqnXh9Po3OLk
	 HGAUHrj2dgkhoUsHmTdMmDPcJPp822g0AtyiiLmpHzvM6TDVK/KXmQSPZRJKtTLgkW
	 +hXk7TvLyjCWSDXa9xNNz4nak7HBj1WRDWsNu9blYsieo47+R/h0F8H2DuMjjNZgAy
	 IjmUq8vM9fdYhaZqYjHhcv1GmYVo236ufRHHYN3hDq0DpOejYc8uShd8KlQqXLqNSn
	 PukX8v42cCmWG0OWGzN3v5Y6/9WqdCSGT4sIXPmxrhtOJ0oJD1FnpTlzhWp6EKb823
	 GJDw17Hi5TXLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76F3BCE0B24; Wed, 10 Sep 2025 06:55:48 -0700 (PDT)
Date: Wed, 10 Sep 2025 06:55:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
Message-ID: <4c7d977b-7d09-48e0-9a88-bae93fa5e401@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250909133928.615218-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909133928.615218-1-qiang.zhang@linux.dev>

On Tue, Sep 09, 2025 at 09:39:28PM +0800, Zqiang wrote:
> Currently, the srcu_gp_start_if_needed() is always be invoked in
> preempt disable's critical section, this commit therefore remove
> redundant preempt_disable/enable() in srcu_gp_start_if_needed()
> and adds a call to lockdep_assert_preemption_disabled() in order
> to enable lockdep to diagnose mistaken invocations of this function
> from preempts-enabled code.
> 
> Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Very good, applied for testing and further review, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/srcutiny.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index b52ec45698e8..b2da188133fc 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>  {
>  	unsigned long cookie;
>  
> -	preempt_disable();  // Needed for PREEMPT_LAZY
> +	lockdep_assert_preemption_disabled();
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
