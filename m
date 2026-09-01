Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302BA3A75AC;
	Tue,  1 Sep 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282670; cv=none; b=nt9Rd8YTKpRWJFjYoL5FGYaeBvlisAB/BhSv13cW4BaRKycnf530im2/FZs+E2Ic79d8h4jCCHxtoUxcUXkBDUW/lBj8HzkJIJSQIN0mZMZ0Y26RvqWwIFQGo9MHsqSq8gV9S6vrfF125+0QAtiAb4/p4aJwZ1BnrWv1Qm4fnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282670; c=relaxed/simple;
	bh=/jm5AOwYIqQIWhLo21ZDFhCCaYe2Y7dSrB3kfGUOdX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUfmY7WwtxeA3yutXNZUxqomTKacdZy5EfzjA2CDwLCzKIjcdPINtbwCVSacI5AniEsWtWm8Q0nIlMyl9GGeImNTm+qz6vMFsAjaWBANZDkkYyHZsWKNZRhv34cc+yA9Y5ICBZ2YA71St7QUkOcOSQ8EvHwpsYwNvzJk8k7wZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRHQvdWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRHQvdWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD54A1F000E9;
	Tue,  1 Sep 2026 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282668;
	bh=bV8SkY08Hk2IqLvlCb3rS40sSs/Ce9eQ6pv+KzOZuVc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WRHQvdWNrVNyd1k8ZRgDfdjIZ6oDEsojhwrhf7AR2LCLC96fob9gV4zGOa1Tk+Xr2
	 ZboEUgjWGFo9lG5rY/E2OCspl0N0ChgwGcGdtL3bFHfrGwpAe2xGnMcXQe8Qzkw2pF
	 sF4WnBHEsfMbZMhGo4N1V7mbSDfQoPC505nTu0vCX+RohOCjORIgUzGSpOdO/Jaf1m
	 IC/9aYphWaAMLTPfh3Wv2SpRPA+hI2YeEg07Eax7C1blqVwf/D1afK4iJl9PBd32kt
	 RZZbcFpH5/7xo5bvxqrz/eop/ziocqDL/Auis9LE0SQSCYCnKDE/ZUSmDTEf1OhXSn
	 5NZI1nS5pUbaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8E006CE09F8; Tue,  1 Sep 2026 10:11:08 -0700 (PDT)
Date: Tue, 1 Sep 2026 10:11:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutiny: Enable atomic SRCU flavor tracking
Message-ID: <d991297a-9bd4-4da2-89cd-002b6f2a3305@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260901074815.3145037-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901074815.3145037-1-kunwu.chan@linux.dev>

On Tue, Sep 01, 2026 at 03:48:15PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> Set srcu_reader_flavor to SRCU_READ_FLAVOR_ATOMIC in the Tiny SRCU
> atomic initialization paths, so that the entry-point checks added by
> the previous commit can identify atomic SRCU domains.
> 
> For static initialization, add a flavor parameter to
> __SRCU_STRUCT_INIT() and pass SRCU_READ_FLAVOR_ATOMIC through
> DEFINE_SRCU_ATOMIC() and DEFINE_STATIC_SRCU_ATOMIC().
> 
> For dynamic initialization, initialize srcu_reader_flavor to zero in
> init_srcu_struct_fields() for the generic initialization path, and
> set it to SRCU_READ_FLAVOR_ATOMIC in init_srcu_struct_atomic().
> Handle both CONFIG_DEBUG_LOCK_ALLOC and non-debug initialization paths.
> 
> Enable srcu_check_read_flavor() for Tiny SRCU, matching the Tree SRCU
> behavior, so that readers can verify that the requested flavor matches
> the SRCU domain.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Much better!  Please see below for additional questions and comments.

> ---
>  include/linux/srcutiny.h | 39 +++++++++++++++++++++++++++++----------
>  kernel/rcu/srcutiny.c    |  1 +
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 2b293336525a..9dce4b5aa084 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -40,7 +40,7 @@ void srcu_drive_gp(struct work_struct *wp);
>  void srcu_tiny_irq_work(struct irq_work *irq_work);
>  void srcu_defer_drain(struct irq_work *irq_work);
>  
> -#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
> +#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, flavor)		\
>  {									\
>  	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
>  	.srcu_cb_tail = &name.srcu_cb_head,				\
> @@ -49,6 +49,7 @@ void srcu_defer_drain(struct irq_work *irq_work);
>  	.defer_cbs = LLIST_HEAD_INIT(name.defer_cbs),			\
>  	.defer_iw = { .node = { .u_flags = IRQ_WORK_HARD_IRQ },		\
>  		      .func = srcu_defer_drain },			\
> +	.srcu_reader_flavor = flavor,					\

Don't we also need to define srcu_reader_flavor?  Or is this patch
supposed to be applied on top of your previous one?

>  	__SRCU_DEP_MAP_INIT(name)					\
>  }
>  
> @@ -57,29 +58,43 @@ void srcu_defer_drain(struct irq_work *irq_work);
>   * Tree SRCU, which needs some per-CPU data.
>   */
>  #define DEFINE_SRCU(name) \
> -	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> +	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
>  #define DEFINE_STATIC_SRCU(name) \
> -	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> +	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
>  #define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
>  #define DEFINE_STATIC_SRCU_FAST(name) \
> -	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> +	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
>  #define DEFINE_SRCU_FAST_UPDOWN(name) DEFINE_SRCU(name)
>  #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
> -	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> -#define DEFINE_SRCU_ATOMIC(name) DEFINE_SRCU(name)
> +	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
> +#define DEFINE_SRCU_ATOMIC(name) \
> +	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, SRCU_READ_FLAVOR_ATOMIC)
>  #define DEFINE_STATIC_SRCU_ATOMIC(name) \
> -	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> +	static struct srcu_struct name = \
> +		__SRCU_STRUCT_INIT(name, name, name, SRCU_READ_FLAVOR_ATOMIC)
>  
>  // Dummy structure for srcu_notifier_head.
>  struct srcu_usage { };
>  #define __SRCU_USAGE_INIT(name) { }
>  #define __init_srcu_struct_fast __init_srcu_struct
>  #define __init_srcu_struct_fast_updown __init_srcu_struct
> -#define __init_srcu_struct_atomic __init_srcu_struct
> +#define __init_srcu_struct_atomic(ssp, name, key) \
> +({ \
> +	int __ret = __init_srcu_struct(ssp, name, key); \
> +	if (!__ret) \
> +		(ssp)->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC; \
> +	__ret; \
> +})
>  #ifndef CONFIG_DEBUG_LOCK_ALLOC
>  #define init_srcu_struct_fast init_srcu_struct
>  #define init_srcu_struct_fast_updown init_srcu_struct
> -#define init_srcu_struct_atomic init_srcu_struct
> +#define init_srcu_struct_atomic(ssp)					\
> +	({								\
> +		int __ret = init_srcu_struct(ssp);			\
> +		if (!__ret)						\
> +			(ssp)->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;\
> +		__ret;							\
> +	})
>  #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
>  
>  void synchronize_srcu(struct srcu_struct *ssp);
> @@ -148,7 +163,11 @@ static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
>  void srcu_barrier(struct srcu_struct *ssp);
>  
>  static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
> -#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
> +#define srcu_check_read_flavor(ssp, read_flavor) \
> +	({ \
> +		u8 __f = (ssp)->srcu_reader_flavor; \
> +		WARN_ON_ONCE(__f && !(__f & (read_flavor))); \
> +	})

Why not make this a static inline function, along with
__init_srcu_struct_atomic() and init_srcu_struct_atomic() above?
That should simplify the code.

>  /* Defined here to avoid size increase for non-torture kernels. */
>  static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 22f7716cbb0e..873b30ccf563 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -42,6 +42,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
>  	ssp->srcu_gp_running = false;
>  	ssp->srcu_gp_waiting = false;
>  	ssp->srcu_atomic_gp_flag = 0;
> +	ssp->srcu_reader_flavor = 0;
>  	ssp->srcu_idx = 0;
>  	ssp->srcu_idx_max = 0;
>  	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> -- 
> 2.43.0

One of the purposes of Tiny SRCU is to be tiny, and one could argue
that Tiny SRCU already has too much diagnostic code.  Should we include
these patches at all?  If we should, shouldn't they be under something
like CONFIG_PROVE_RCU?  Should some of the existing Tiny SRCU debugging
code also be under something like CONFIG_PROVE_RCU?

Thoughts?

							Thanx, Paul
