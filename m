Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B28BFF
	for <rcu@vger.kernel.org>; Sat, 13 Jul 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720879666; cv=none; b=upR72R8tHMmNxOa+grHw/M6LEUkTp2PNwY5FylGfQx+1X7GXJAMxDwK56sllOoM2DQBAuMKgQ0L9RQctHkrxtbJ+kqOtrX0epRMph2LnChQpwNtQ18Xj4W58JtH349scc4Q+b/bRbr/z4DEkEP6vgNW2aenjb6Bz+1uAxCZr8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720879666; c=relaxed/simple;
	bh=RioQiY7v+Pob1xmc0oDtN8cBrFxzOrUrI82X1bx712E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edN0IO8CQ7chwHmpAV+7Zdaixx95xI6EExg74xqAfH2k4JHk1reYRgZt8FcVnpwVTPYO2o7ctxozd3er/z+6kZOS7KqTekekOTDLgtt7IhWjYWRw0vcYs95hv34YRRRPauk3YqcEmqcKqaWPrpVAyOqKY04vaE5YA5sLpdim/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPABCNY0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPABCNY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE42AC32781;
	Sat, 13 Jul 2024 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720879666;
	bh=RioQiY7v+Pob1xmc0oDtN8cBrFxzOrUrI82X1bx712E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPABCNY0gzrN1AmzsnjE7303pB4ccF9Cr/Fvy2j7zs3i7i348rQXK7G5+UK2L378P
	 ykc75flaf4CgzrhPB9e75IkxXPdMVTCLHKYXuR2raxaGHrNkkqpV+R1f3HtVAJplLb
	 5JpZwbEJwMW3YZuZrN+N67zRc0VDKc76Ct3CX44k/LBAcQ7fgLhPp/WmYFZmbot7yX
	 SsboQ9oPTa+spfsesSDbLqBUThQluF5A2jsVAHijaCeYf3TRPsiBEoZ9qGOuA1w3SQ
	 Vh/vtIwsXxvXN42PFqcKnyIMTl1TbhM6G5YC8uZ3LZwbzoCVp3IW5n8/70ggp7LYVL
	 tUzRNDPldrH9A==
Date: Sat, 13 Jul 2024 19:37:41 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] srcu: faster srcu gp seq wrap-around
Message-ID: <20240713140741.GB163340@neeraj.linux>
References: <20240712005629.2980-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712005629.2980-1-inwardvessel@gmail.com>

Hi,
 
On Thu, Jul 11, 2024 at 05:56:29PM -0700, JP Kobryn wrote:
> Using a higher value for the initial gp sequence counter values allows for
> wrapping to occur faster. It can help with surfacing any issues that may be
> happening as a result of the wrap around.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  include/linux/rcupdate.h |  3 +++
>  include/linux/srcutree.h | 15 ++++++++++++++-
>  kernel/rcu/rcu.h         |  3 ---
>  kernel/rcu/srcutree.c    |  6 ++++--
>  4 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index dfd2399f2cde..c148674b9e09 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -35,6 +35,9 @@
>  #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
>  #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
>  
> +#define RCU_SEQ_CTR_SHIFT    2
> +#define RCU_SEQ_STATE_MASK   ((1 << RCU_SEQ_CTR_SHIFT) - 1)
> +
>  /* Exported common interfaces */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func);
>  void rcu_barrier_tasks(void);
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 8f3f72480e78..ed57598394de 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -129,10 +129,23 @@ struct srcu_struct {
>  #define SRCU_STATE_SCAN1	1
>  #define SRCU_STATE_SCAN2	2
>  
> +/*
> + * Values for initializing gp sequence fields. Higher values allow wrap arounds to
> + * occur earlier.
> + * The second value with state is useful in the case of static initialization of
> + * srcu_usage where srcu_gp_seq_needed is expected to have some state value in its
> + * lower bits (or else it will appear to be already initialized within
> + * the call check_init_srcu_struct()).
> + */
> +#define SRCU_GP_SEQ_INITIAL_VAL ((0UL - 100UL) << RCU_SEQ_CTR_SHIFT)
> +#define SRCU_GP_SEQ_INITIAL_VAL_WITH_STATE (SRCU_GP_SEQ_INITIAL_VAL - 1)
> +
>  #define __SRCU_USAGE_INIT(name)									\
>  {												\
>  	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
> -	.srcu_gp_seq_needed = -1UL,								\

As srcu_gp_seq* counters are initialized before first use, if we do
not modify this file, we can move the SRCU_GP_SEQ_INITIAL_VAL and
SRCU_GP_SEQ_INITIAL_VAL_WITH_STATE macros to srcutree.c. We then
also don't need to move RCU_SEQ_CTR_SHIFT and RCU_SEQ_STATE_MASK
from rcu.h (keeping them internal to RCU). Is there a scenario
where that won't work?


> +	.srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL,							\
> +	.srcu_gp_seq_needed = SRCU_GP_SEQ_INITIAL_VAL_WITH_STATE,				\
> +	.srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL,					\
>  	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
>  }
>  
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 38238e595a61..2bfed9855d67 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -54,9 +54,6 @@
>   *					grace-period sequence number.
>   */
>  
> -#define RCU_SEQ_CTR_SHIFT	2
> -#define RCU_SEQ_STATE_MASK	((1 << RCU_SEQ_CTR_SHIFT) - 1)
> -
>  /* Low-order bit definition for polled grace-period APIs. */
>  #define RCU_GET_STATE_COMPLETED	0x1
>  
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index bc4b58b0204e..2209dd0589de 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -247,7 +247,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
>  	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
>  	ssp->srcu_idx = 0;
> -	ssp->srcu_sup->srcu_gp_seq = 0;
> +	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
>  	ssp->srcu_sup->srcu_barrier_seq = 0;
>  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
>  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> @@ -258,7 +258,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	if (!ssp->sda)
>  		goto err_free_sup;
>  	init_srcu_struct_data(ssp);
> -	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
> +	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
>  	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
>  	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
>  		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
> @@ -267,6 +267,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	}
>  	ssp->srcu_sup->srcu_ssp = ssp;
>  	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */

Remove this line?



- Neeraj

> +	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed,
> +		SRCU_GP_SEQ_INITIAL_VAL); /* Init done. */
>  	return 0;
>  
>  err_free_sda:
> -- 
> 2.45.2
