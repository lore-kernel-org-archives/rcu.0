Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0B216A0C;
	Thu, 24 Oct 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801704; cv=none; b=uTE9OgK6+lINY3X8Vcl7THCYrCQijvLq5UMfzbhsOMz2pQH0DRfJncume4K4cMe8VUvUP13NM2E9dh6KsFGUgje+TImBGXNqFvmyng8ug2q3RPluAIZ/eDJS24wAh5j2TzWYc3uhFdB/IMZwpOOwHGzmlDy0d9GL2IFIuK/Jz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801704; c=relaxed/simple;
	bh=oowk6seRJ6717d9XxCE+gg+EDwstr4833dYoKnYVTjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq35TXWwH7w6ifkp0CMbs1BnbvSx6oSGMTwQtnLBtGgXjr9ntHf7mcrACysO1zzWhoWM/EqoSn/AQYM6GUdwoj8XJgvEo1D1gk+cor5G+fIHwhnt+UGw++XVfXa7BQ4KNNoKocQNdIE0tP2HI03G/sisMkGEjhddZfFrxV9D91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4Xrqimz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4Xrqimz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749CEC4CEC7;
	Thu, 24 Oct 2024 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729801704;
	bh=oowk6seRJ6717d9XxCE+gg+EDwstr4833dYoKnYVTjY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=s4XrqimzAJeSNkUw0dV/hjrGVTGPif+C03heLE9ToIEWCukAmv4k/1dJKDAftzV1p
	 YOXtxdmqR0lSgZUseWrPiPms1gHSuVt63VlNmk4bCkLL9TZu8V5NLD+5PKTgYmvPzP
	 E4Spqz698LASoPs8enaMRCdCdcYa00NPvdomwr1FvlzGfdZVqef0MokdtyhfU5bK33
	 pTbHipqQ/9IijELfL0uMRYNxJ44VpFlLfl8cBgKqcX8TSJ8aKBgC6emOHnwFZulniS
	 rxq/ICoGkbrL6cH8vT74Q6zaSM7wxjqgWJkRjtpwnSkqeepJ5mzR5abQwk2ofotusr
	 hoaEUKihtn+ZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1E1ABCE0F74; Thu, 24 Oct 2024 13:28:24 -0700 (PDT)
Date: Thu, 24 Oct 2024 13:28:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcuscale: Remove redundant WARN_ON_ONCE() splat
Message-ID: <640af17a-958c-4321-89d4-8ab1f12986fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241024164558.715296-1-urezki@gmail.com>
 <20241024164558.715296-2-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024164558.715296-2-urezki@gmail.com>

On Thu, Oct 24, 2024 at 06:45:58PM +0200, Uladzislau Rezki (Sony) wrote:
> There are two places where WARN_ON_ONCE() is called two times
> in the error paths. One which is encapsulated into if() condition
> and another one, which is unnecessary, is placed in the brackets.
> 
> Remove an extra WARN_ON_ONCE() splat which is in brackets.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

For both:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcuscale.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index de7d511e6be4..1d8bb603c289 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -889,13 +889,11 @@ kfree_scale_init(void)
>  
>  		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
>  			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
> -			WARN_ON_ONCE(1);
>  			goto unwind;
>  		}
>  
>  		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
>  			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
> -			WARN_ON_ONCE(1);
>  			goto unwind;
>  		}
>  	}
> -- 
> 2.39.5
> 
