Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE77145348
	for <rcu@vger.kernel.org>; Thu, 18 Jul 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340290; cv=none; b=X7MA/auGsMhi2WAI8x8rasdX8utLg6Dty/xXZcAgpf/ltN5pZwjbxHu9A1Qxkg8anBpt3YgAwHoIkTEaL/qnX44ylHnfjfuf7ALunYaixqsQWSV3rNRzIcnH45sEkR/eqb0ClMLWGa7dha+l2jxMHkZgUhLOWpNVWgmCulaid8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340290; c=relaxed/simple;
	bh=7t5n8E3RpjNIiR2TWgVs4i1UY0DE/SclyRG6fKtH8jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpePK05fkMKLuseOFYlQpc9+4LTwkXHuVYtxn6+sVhhz/IbM2DbJiQnuLfOscHzq5UOcwn01TjUBHN+fTKkrCHwbvFwMWS6vxqQPH0iAm0+JH77yPMtzKi17lQxQ/4rU5WSjF3P1m5cnm3zME7kmw9SJb830hZeRx2V7Veay2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/CbpyHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/CbpyHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7867C116B1;
	Thu, 18 Jul 2024 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721340289;
	bh=7t5n8E3RpjNIiR2TWgVs4i1UY0DE/SclyRG6fKtH8jc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=n/CbpyHuqqXg4IA54Xs6nzeVBRhnXNUeiQI/TA7e5yz0yKYnwMrQvx5/UJaQHhdgv
	 Mhd3T3zh+gO/NvdwWT3EID8q81WqCEPczJCT5hkh9XZ7Ve8t1DqfXx0le6Sp7NZJEA
	 oBHbQYzalwYDlFHyxYV9WL9PWoeZO1t3qkHBm5RjRMGWsuiLW7HhzHkihmga1heko6
	 KkjxSvTS7jIHHQPpuiiGxBliSfjNeMBVEoY4mLr5kie5FUKqe05wDTU2J5Dh6nEtsG
	 PB3AJZ3MGMDt++DKcI2btj2kOlLzC6ZhKGG9qLdxWBg1VA77S/LyRYfSaxMMo52BSx
	 tjNO16aNLjrxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 416C3CE09F6; Thu, 18 Jul 2024 15:04:49 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:04:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Neeraj.Upadhyay@kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] srcu: faster gp seq wrap-around
Message-ID: <62700706-bf21-489b-b956-7947a9b1886f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240715232324.52384-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715232324.52384-1-inwardvessel@gmail.com>

On Mon, Jul 15, 2024 at 04:23:24PM -0700, JP Kobryn wrote:
> Using a higher value for the initial gp sequence counters allows for
> wrapping to occur faster. It can help with surfacing any issues that may
> be happening as a result of the wrap around.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Much nicer, thank you!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/srcutree.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index bc4b58b0204e..907c4a484503 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -30,6 +30,9 @@
>  #include "rcu.h"
>  #include "rcu_segcblist.h"
>  
> +/* Start with a gp sequence value that allows wrapping to occur faster. */
> +#define SRCU_GP_SEQ_INITIAL_VAL ((0UL - 100UL) << RCU_SEQ_CTR_SHIFT)
> +
>  /* Holdoff in nanoseconds for auto-expediting. */
>  #define DEFAULT_SRCU_EXP_HOLDOFF (25 * 1000)
>  static ulong exp_holdoff = DEFAULT_SRCU_EXP_HOLDOFF;
> @@ -247,7 +250,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
>  	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
>  	ssp->srcu_idx = 0;
> -	ssp->srcu_sup->srcu_gp_seq = 0;
> +	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
>  	ssp->srcu_sup->srcu_barrier_seq = 0;
>  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
>  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> @@ -258,7 +261,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	if (!ssp->sda)
>  		goto err_free_sup;
>  	init_srcu_struct_data(ssp);
> -	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
> +	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
>  	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
>  	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
>  		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
> @@ -266,7 +269,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
>  	}
>  	ssp->srcu_sup->srcu_ssp = ssp;
> -	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
> +	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed,
> +			SRCU_GP_SEQ_INITIAL_VAL); /* Init done. */
>  	return 0;
>  
>  err_free_sda:
> -- 
> 2.45.2
> 
