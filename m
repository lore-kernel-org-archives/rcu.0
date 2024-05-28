Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE4018AF9;
	Tue, 28 May 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922987; cv=none; b=jRQnbv26nc5irBClxZRePkcnKhmCauRbJFZHr6/yCWZQrTnYq3+3GjnXGAhiLjH8bBMjHBgNo2njGOj2bhZ8U2ONc14DN0Kry4KRZO1N7yhF/f8eqV/cT7DJq33aSWFp3y0pU5YzCJ2PJYfgxNmuA0dvtg1Enb5jp2WSdOtxOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922987; c=relaxed/simple;
	bh=WZ7+oO+PxWnZZbzdRvQ0XELaG7BanaIc2Y6P8/ergOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDwAQZlM2Xvle99WEBH/EX2BGo++2IaH+5JFwA+HmAIy0Hols5gEhC/7lw+D5T7wfQvEuUiimLP7H77W1zq1a1sjAcpBXHM73700D4yQt9r19fLsPiFMYtzYNpynU5MNHon4FbfB7+Yc0YEmdmoBZZS93VKuAEH6EcZPg8VAVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZusZzBP0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZusZzBP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B90C3277B;
	Tue, 28 May 2024 19:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716922987;
	bh=WZ7+oO+PxWnZZbzdRvQ0XELaG7BanaIc2Y6P8/ergOc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZusZzBP0XK0tVGafQCGlq1zoKOn0GKtEvaRMnq6yKZlyYxCRk14zuzhB0BsA6munc
	 R9yc97lq72jh6JEEkg64G6NCUYQVvsToAV43PsvbwLcBfMJetCx4VA38qRJNW3gGLX
	 SDs9fyvStIV2/FR3OaXg0His7IkAXW6nFt0x0J7ErZXEGp0ZcJz1boa4bvhtV8gYMB
	 4pVo++N6ne176e0pD93ilEhiVJC9xFlIa9fDvJav0VJ8rhErVKGfiowQI19wQDjY9J
	 T2rA60U+8VF4fMSiqaMFUVkuNDTC4Wsfj4PfTnv1RG/ffM2kltJv80Bn0JfsKm5N3P
	 DXy95nTeQuqvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A7D1CE0F8F; Tue, 28 May 2024 12:03:06 -0700 (PDT)
Date: Tue, 28 May 2024 12:03:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Skip debug object testing for cur_ops
 without ->debug_objects set
Message-ID: <1195a9a3-db87-465d-a3b0-ee92d67da954@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528030054.4525-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528030054.4525-1-qiang.zhang1211@gmail.com>

On Tue, May 28, 2024 at 11:00:54AM +0800, Zqiang wrote:
> This commit make rcu_test_debug_objects() early return when the
> specified cur_ops not set the ->debug_objects.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 08bf7c669dd3..9b8c277ab91a 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -3495,8 +3495,9 @@ static void rcu_test_debug_objects(void)
>  		return;
>  	}
>  
> -	if (WARN_ON_ONCE(cur_ops->debug_objects &&
> -			(!cur_ops->call || !cur_ops->cb_barrier)))
> +	if (!cur_ops->debug_objects ||
> +			WARN_ON_ONCE(cur_ops->debug_objects &&

You lost me here.  Given that we have "!cur_ops->debug_objects" before
that WARN_ON_ONCE(), why do we need "cur_ops->debug_objects" inside of it?

Also, we don't get here unless the rcutorture.object_debug kernel boot
parameter is specified, don't we really want to WARN_ON_ONCE if the
current flavor does not support that?

Or do you have a use case that needs to silence these warnings?

							Thanx, Paul

> +				(!cur_ops->call || !cur_ops->cb_barrier)))
>  		return;
>  
>  	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> -- 
> 2.17.1
> 
