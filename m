Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9691A76DE;
	Mon,  8 Sep 2025 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294947; cv=none; b=L40Vm5HCzxC1SfZQn7jVrnEJwNvU+uD5bnrGevMwHn3Xh1TgY4u0hAYlb1TcGi2ANX/KopYBVoSaIO/J5FW/uDn9tt1p9W+EuDJ9vzX7LlTHw+Mc6RbzpnZaxpuYzseoTbM5fJKF5mLGkfKbuAi33eWTunF63mWwiTaW92xsmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294947; c=relaxed/simple;
	bh=5Z/FF6pET2UtcziqsLv1hcVFfVvtqwK/QtWa5mE6XGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEIiyIJ4HXM+hLbNgRJyMgZG9vEDRspzXoMIXhsQTNw5ULdVmuQDec4HmhQ4voxZFdeqZl3NpvxnsKGnh6ZS465nDQB/5wHlnTRMHB90aFWdeEfn8tW7yrOdt1OYdXbQAe+BOPAsz6OTj/tZQsDkBeKFYOVPdaBc8LrnQhXH2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIxRZkt5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIxRZkt5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F4FC4CEF0;
	Mon,  8 Sep 2025 01:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757294946;
	bh=5Z/FF6pET2UtcziqsLv1hcVFfVvtqwK/QtWa5mE6XGU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PIxRZkt53otjBTVAEc/6ZmTRulJ5DLl17FSCpkjbEBwqENNGZQtIDIT9ZzmMUgdJb
	 MIDwXWEnIdEIJJ7JjIazOoVzHJXpWQsgpLuFOAeQolHJqVLIh8oii/dx/OaNNxWBVX
	 HFK9Gs30PwAhC7FDgsxV9xwLREgV283pbfDTw9EYup8Ogz20a7UZmImJlfsn82l+kH
	 DfP9SjnBvkgEP9kYjvLVJwyOVWJwMOG9LSeBZbmmoKpw/e4HWGZWyD+hBfXWJPD9Ks
	 eqbTiWaneD50z4O9GpTUGZrkRAWvrJrwzpCPWnVjITLwDAO/j0qzYRdtmZfcZobOu7
	 kay71iH25fDgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50CB2CE0877; Sun,  7 Sep 2025 18:29:06 -0700 (PDT)
Date: Sun, 7 Sep 2025 18:29:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
Message-ID: <9dfa7d4f-6e3f-4084-a14f-beb1db06f817@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250908003155.557070-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908003155.557070-1-qiang.zhang@linux.dev>

On Mon, Sep 08, 2025 at 08:31:55AM +0800, Zqiang wrote:
> Currently, the srcu_gp_start_if_needed() is always be invoked in
> preempt disable's critical section, this commit therefore remove
> redundant preempt_disable/enable() in srcu_gp_start_if_needed().
> 
> Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Looks good, but what would be a good way to make this code defend itself
against being invoked from someplace else that did have preemption
enabled?  Especially given that the Tree SRCU version of this function
does get invoked with preemption enabled?

							Thanx, Paul

> ---
>  kernel/rcu/srcutiny.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index b52ec45698e8..417bd0e4457c 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -181,10 +181,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>  {
>  	unsigned long cookie;
>  
> -	preempt_disable();  // Needed for PREEMPT_LAZY
>  	cookie = get_state_synchronize_srcu(ssp);
>  	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> -		preempt_enable();
>  		return;
>  	}
>  	WRITE_ONCE(ssp->srcu_idx_max, cookie);
> @@ -194,7 +192,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
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
