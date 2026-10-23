Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784379;
	b=KS86BQDkhw+PHepuuZIs/nyUfmzJcB2gk4s7J+rmNVwtS2gq/l/7uRblAqYvTBS+v5u8
	 GvDXRfhH5LYYnwg0KO/lMd4LDtm69fz7icuV8HPR53TwY54qHR3RjOVUSdgPl2HBfouUv
	 Hnu/03vx5ThmQgYzHRenbjDIagl0GeHFf4yOoKXSyZEsMF9WJkc0hn/4/IZosXxj7ADRY
	 fFnJTLP9rzwmbrkrz9KYzaCSpeKXF6/4FtPnKtPAE0gks4alpA8XoLnbFAJPgcoeeqWLL
	 b4BSfiIMypQDAksyUwX1lrDGIS3ANUafhN0u6Vu2QMzjNScoeVOCuSLcPYqruljpR8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784379;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=q/2SS9XQmwic+Dg4Zqt0Jyhl3mLXtly5YAjEKl7UD+4=;
	b=fUy7R7JCZ5bR3FPHaa8OMJ5RXodxH5AI0639oHVGdp6/or19yWPjcu7WUuFU7dGmQHik
	 sLloQ3trvxXt5OCIagVyElwo9XqQv0V7CKvaVCmkndsirEnsH57EPmEx9OUiRzxI6+Kdd
	 kLnnvMI8ZqIWwFQF516hBW4tbbJDkM7TWAPx+aIVhUTqAhS32RWMfIt/srb3HAmw5BN4q
	 IR6J7n+FqAELDhmO+kjeq2QoUr19EfzJk6NlwmYaK2vAY2GwCekWuEck6C7OQ3bG+B0yg
	 GBbbeaJFK8W9+eaby9P3blcZYBWhxywzRiqgTT4lNY86739N1rw0RtdXNYz8KdFdRKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0mDcTSJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1416606A31A;
	Fri, 23 Oct 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0mDcTSJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE921F01825;
	Fri, 23 Oct 2026 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792784378;
	bh=q/2SS9XQmwic+Dg4Zqt0Jyhl3mLXtly5YAjEKl7UD+4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=e0mDcTSJsYEocCfjVfHNi8U6/Sk5rlV9EbKOoDAcjtHOmpbp6DjbD+o2nCCNH1KWy
	 H8TSaiqSPg+6pgz9ONj7cf7Jf3TbouTHoiiy+vCXuXLBXre6vgv66vD1GWt550jLu5
	 EClsQo2KL3UwPjrEa1tNnNh5IGs1qz8W6fShi/5k+IVmqEHQez5BIeS/Li9GYWHCt7
	 pIVlyORlk+PuhAYvxIvJulqCmy4f0rJZrHqeq3SOCalwfSLYrqF3cRrYYbm9e1vxAF
	 VlOPcE+ANk5CJZCZ4H+JYvSDFkUaADmU1ouvFFjxbhFytuKPmyFyRrrGN45xRvECh+
	 cZZb4dG5dARxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6158DCE0811; Fri, 23 Oct 2026 12:39:38 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:39:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 4/9] srcu: Validate callback arguments
Message-ID: <259b7f31-40dd-45eb-965b-8db04a6e7d07@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-5-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023101841.2910719-5-kunwu.chan@gmail.com>

On Fri, Oct 23, 2026 at 06:18:36PM +0800, Kunwu Chan wrote:
> Check callback-head alignment and reject NULL callback
> functions in the SRCU callback registration paths.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

For 4/9-6/9:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/srcutiny.c | 7 +++++++
>  kernel/rcu/srcutree.c | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 3ee28885b96f..98864977bed2 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -291,6 +291,13 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
>  void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  	       rcu_callback_t func)
>  {
> +	/* Misaligned rcu_head! */
> +	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
> +
> +	/* Avoid NULL dereference if callback is NULL. */
> +	if (WARN_ON_ONCE(!func))
> +		return;
> +
>  	/* Record the caller: the irq_work's stack says nothing about it. */
>  	kasan_record_aux_stack(rhp);
>  
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 46fe2f0cef85..1993ddbdb828 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1529,6 +1529,13 @@ static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
>  static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  			rcu_callback_t func, bool do_norm)
>  {
> +	/* Misaligned rcu_head! */
> +	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
> +
> +	/* Avoid NULL dereference if callback is NULL. */
> +	if (WARN_ON_ONCE(!func))
> +		return;
> +
>  	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
>  		return; // Leak the callback rather than corrupt SRCU state.
>  
> -- 
> 2.43.0
> 
