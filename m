Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C82310645;
	Fri, 11 Sep 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144829; cv=none; b=iB90O3rfnqh7Yjvf9HC4RKMWja6BtCBSsdT3iZ1Eundo/AA0osBwH9Ss1AxK+490IqDLny5EAEcEa6nQ7utTEO60vyJHkLp5lVveRKtPNHNWcfqWSmeqv1ZsR7YCpTjUxtqU1s0FKkx1dJnRYC2tfRFpSfwuOsy0wXT/+mX6jus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144829; c=relaxed/simple;
	bh=VIhEce5lvBsBBt6I0w3GqfJd4+m4wrIZFReO17foSGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm9gsnhknp4doiHPPg3lgadUWvHrpEizQXgGr8ddOYYZu+Q6+GCjljXHunQgnHZ1z2t0w4FqoN+QDSjGDGmLkbApLJ7L5GqwLWyrGaSVjvahF1CuGimNvXtYAyP71eiQGqN1oFm1z9x2XEuknbcL1A8xqxr22YH+G1EhO7C+hTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEAAiDZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEAAiDZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC7F1F000FF;
	Fri, 11 Sep 2026 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144827;
	bh=OA0i/kBHnkoajcnH37M80fYwsnLdmhWQ9PKyv6erE5Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=TEAAiDZMYWilpwEo1TsYSgNuYWYdo/ixWZV7GZ8MlkaRqPc8Xo5asLvMLgcAblpJ2
	 YSULJaynNiBFRAqaPAArgazKU2Rzwu/00GUkVhgNS0gaKoJGKBDWXxzrrTEqkVAG3v
	 IhCfhZCr0/SM7zvJlrw8PGEM2yyHPoznOR21rPr1xG9Hl3lvxD7UoZJ1tUDXoPx6z7
	 +9LUXSYE+1GXf/zbl1pcjz5nMtb4+FlzRdlPkM1qHCyO0WTSgaQkxH0hN8pA/YrG/a
	 g9hxY+Qva2DgvkwxyyKQLucT8WnfRhddSrM6UB3Gx2K1g6g/LOxfaX4Oy7vfWnwy1Y
	 /b8TlNs+Rfo9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 27186CE1902; Fri, 11 Sep 2026 09:40:27 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:40:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcutree: Skip torture to-big transition for atomic
 SRCU
Message-ID: <a57d7d28-ff5b-4db6-8353-8cec10c8ba5d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911040251.618430-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911040251.618430-1-kunwu.chan@gmail.com>

On Fri, Sep 11, 2026 at 12:02:51PM +0800, Kunwu Chan wrote:
> Atomic SRCU does not use the srcu_node combining tree. Exclude it
> from the SRCU_SIZING_IS_TORTURE() transition in
> srcu_torture_stats_print(), and warn if such a transition is requested.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Queued for testing and review, thank you!

							Thanx, Paul

> ---
> Changes:
> -add warn on an invalid atomic SRCU sizing configuration.
> -v1: https://lore.kernel.org/rcu/20260910041427.3579817-1-kunwu.chan@gmail.com/
> ---
>  kernel/rcu/srcutree.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 68441c32cebf..60c102a4d057 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -2422,8 +2422,10 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
>  		}
>  		pr_cont(" T(%ld,%ld)\n", s0, s1);
>  	}
> -	if (SRCU_SIZING_IS_TORTURE())
> -		srcu_transition_to_big(ssp);
> +	if (SRCU_SIZING_IS_TORTURE()) {
> +		if (!WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
> +			srcu_transition_to_big(ssp);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
>  
> -- 
> 2.43.0
> 
