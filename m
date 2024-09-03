Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046F1A0BD1
	for <rcu@vger.kernel.org>; Tue,  3 Sep 2024 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359290; cv=none; b=lp0HIVjFuIvnXlMCzjYzDUeN+p3qsRiFMRIZerOH3hpq6/8nqa72GrXR10dP8gMlMqiEJrptBKmY/tVldOEsjKkkksVorFwIPKA0t327v2uIWkNvQx09fBp6fQw+TBTLrisi5w0GEMnqwHmI8CXEGAS+zaN3wERcJOU2HY2W1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359290; c=relaxed/simple;
	bh=t8rynAs4j0rl0ydR6lnDtnhh7CphXBeArRMMUcqVOcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFCRQwkFce4ObWzn1VaLVbsnmsx7G1ALIrSGqXkt+5AJnAdwBQ3pPcBWQ+e7z/KwfRLcYiHhogPBEVCFDoAR4+WxOsNrjECFbcfZpjzwA4Ca37LalQru6vOwel5VIGYCZ2Z12bHe3stvmg78rxXunjXvGHAF9OX6pd/q3FxAU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGtCOwi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGtCOwi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A77C4CEC4;
	Tue,  3 Sep 2024 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725359289;
	bh=t8rynAs4j0rl0ydR6lnDtnhh7CphXBeArRMMUcqVOcg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oGtCOwi6fvEaZ+smeQb+fftTyTkZOuVVK4NpaK0nzjVQivMLE8aiad03U5RblIfOZ
	 xl97x9IL7yOZLYKO4D2fTm5QmQcovfDEQzWmc1SbHfSAh1anFl+83vYDNyD20+jgG/
	 PNx2/2Dtx5rMtKppdBMVPIHyHzXvG0bcc5Z6tHDQk8yocrwrTQQYF9KPfube/1Pa5q
	 tR7XIj7wpmxjSGxpQUZTAAo5bS3f9zbXsce7hAEmHx0byJbOigAS+mkSICBlzkMoD3
	 BXZL4r7HotysSdJYawp2XdPINccyHuleYWglLIIl5UCLIiaiKM3RY2+bJTJUYx5ubK
	 pCmZGL1syF14Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F2AACE14C5; Tue,  3 Sep 2024 03:28:09 -0700 (PDT)
Date: Tue, 3 Sep 2024 03:28:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH -next] rcu: Use the BITS_PER_LONG macro
Message-ID: <67f4075d-d157-40e9-9f22-2ee24563eb79@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240902110654.2685917-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902110654.2685917-1-ruanjinjie@huawei.com>

On Mon, Sep 02, 2024 at 07:06:54PM +0800, Jinjie Ruan wrote:
> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
> variable, replace it with BITS_PER_LONG macro to make it simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Either Jinjie's or Mathieu's formulation works for me.  But Jinjie was
here first, so:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a60616e69b66..b48864df415c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -5579,8 +5579,7 @@ void rcu_init_geometry(void)
>  	 * Complain and fall back to the compile-time values if this
>  	 * limit is exceeded.
>  	 */
> -	if (rcu_fanout_leaf < 2 ||
> -	    rcu_fanout_leaf > sizeof(unsigned long) * 8) {
> +	if (rcu_fanout_leaf < 2 || rcu_fanout_leaf > BITS_PER_LONG) {
>  		rcu_fanout_leaf = RCU_FANOUT_LEAF;
>  		WARN_ON(1);
>  		return;
> -- 
> 2.34.1
> 
