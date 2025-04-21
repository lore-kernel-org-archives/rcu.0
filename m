Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7EC266EE6;
	Mon, 21 Apr 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243395; cv=none; b=OKYFSntwwsixHqzdSx7WXp8uJC0oCtluDyeWcxxTwhpUrjrp+hwDLtZXT+oiiSr+eGIu16DsWxwtMK1Ho3o69R3p7np3rPQ3wZ6Ms8Cf5mM4ira0VlHcf4I1AkbC2cMZa1vpO6CguXLg9M0rYXIuxrx249+Lhc+hcKmILg28nhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243395; c=relaxed/simple;
	bh=cubivyFb3a2dV2acrHyigzWPBje2uqMIe3Okd1jxvWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXhru8na4LyqsbYTpOE5KHf45dYY5MzDrZA2UhvCXT7yoQwqpC0EdUJzLulojJubQNqXe2HXswZA32pAFUpsXtNXL0Kv7jQE3Xfu9U4NXCGpp5dqa17+JORweNlq7MaCJ3d5l7kvahoPSgOHPMlhDiXGZ49m86UnrnDQnzmY8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRgRIBaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRgRIBaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60A6C4CEF1;
	Mon, 21 Apr 2025 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745243395;
	bh=cubivyFb3a2dV2acrHyigzWPBje2uqMIe3Okd1jxvWM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jRgRIBafaGpO7KBbN/+6ZxGfnjB9f1doUkB9wT2yvvm8y/phAhRpVOSrF+WUGfFJt
	 lEkAWsIzdyk8Qw0aqp5JYu/duO0RL/DBEPj4R7us/KJ3ZonNctF0mt1jmqBwEtREts
	 +plaBoq8U4Yx5kmAGCZbPZAanxmJBqH+/z2GT5itDLVwIxLzRuyqLFAji59uDssnAQ
	 eLjriP9MyeOjghyp4j/WPk9bKkIdF7F3N/tgEcjga77uDikq7/MTpnIC6SzOkkPBCT
	 pRxUXvLdvjOsV6vTxdA2oCYKG/MsGyFU7FV5uqoa1aNhxD4WfJZN6YmJI2+32wO8E0
	 pdX+MfrG8I3sA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 902FCCE0855; Mon, 21 Apr 2025 06:49:54 -0700 (PDT)
Date: Mon, 21 Apr 2025 06:49:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rcuscale: using kmalloc_array() to relpace kmalloc()
Message-ID: <7743ff8a-1492-4191-95ec-abcb53001b83@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250421061508.718752-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421061508.718752-1-suhui@nfschina.com>

On Mon, Apr 21, 2025 at 02:15:09PM +0800, Su Hui wrote:
> It's safer to using kmalloc_array() because it can prevent overflow
> problem.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Thank you!

But isn't kcalloc just a wrapper around kmalloc_array() anyway?

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 0f3059b1b80d..cbe2195f08d6 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -762,7 +762,7 @@ kfree_scale_thread(void *arg)
>  		}
>  
>  		for (i = 0; i < kfree_alloc_num; i++) {
> -			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> +			alloc_ptr = kmalloc_array(kfree_mult, sizeof(struct kfree_obj), GFP_KERNEL);
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> -- 
> 2.30.2
> 
> 
