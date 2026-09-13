Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E83E1738;
	Sun, 13 Sep 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341415; cv=none; b=Mx2R+GVigFHHLfsNVsH6Ks7TWBH/Jyx2K9UiOfzi613jWFu64Z3i/LaQExUxNQ3fxu1uqes0r7xINvGb5t7TkVtwrTyNbX1ZTeBVDzc9MyJf4sYQiP6ku8drx65o2V922LN0Lds72qTIjGVfdErEf53OyY2GaikSzqzX7bnb2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341415; c=relaxed/simple;
	bh=1EZnoUrH/X6IrIqvP48pU2SBbFfn9GrOypeGTiCn5AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSkNlW6PDHq3fEnr0bHvAuEby/pseW/SrEykTF97p4SVCEWWQxKpxdawIB2ExywOvEpr6b+8N3AVVAigoFo4e/KSsnMUHNT+V54HAJJYxh7G9x3En/xWoxVuX5mC4+qKYz6jDeAqGIgT0AqNfwHYVOd3/OAzDCMA0sZwMI2gTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVMUrFwZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVMUrFwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D01A1F000FF;
	Sun, 13 Sep 2026 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789341403;
	bh=Z++f/6f1VG25rLAkuYDP/1NrDNkTWmgG+53Z9meC95Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=GVMUrFwZV19GTr2mGO2GjsWkTew+JEB6an5Tc1HvoOpfhllW1PcqOhLLbeczsBQQ0
	 SiEJYNIFd2lfLuhyC7jJrk9/qpoc31KxpaSoPOa+bFIIZzP1BIpoSg29FKuC3j0M6V
	 4pz5HO67mjZgM8gYkoJUl/duIQ18nuu5a8jmaxI+2U01Tz6nOhXb1LTCficnoK8Ro/
	 pcJ7RihBYljW4yAC81YaUaph9OX1M9QncnaSJo0IrLq1noH+kckOl5ZXSPu6sKhup0
	 iEwfoPgQZoKeQr3JolhYgfLg5H/ndZzY7MmvqdC/89RWh9awHnoXLnXJOw0J1am0R8
	 38KyXIBsDulpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A437CCE10F1; Sun, 13 Sep 2026 13:37:29 -0700 (PDT)
Date: Sun, 13 Sep 2026 13:37:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutiny: Add reader flavor checking for atomic SRCU
Message-ID: <c91b151e-efa5-4f9d-b4c7-512adf3fcfe5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260913134301.7236-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913134301.7236-1-brads@mainlining.org>

On Sun, Sep 13, 2026 at 01:43:01PM +0000, Bradley Morgan wrote:
> Tiny SRCU stubs out srcu_check_read_flavor() as a nop.  So if you
> DEFINE_SRCU_ATOMIC() a struct and then call srcu_read_lock() on it
> by mistake, nothing warns you.  Tree SRCU has
> __srcu_check_read_flavor() which splats when the flavor changes.
> 
> Add a srcu_reader_flavor field to Tiny's srcu_struct, gated on
> CONFIG_PROVE_RCU.  DEFINE_SRCU_ATOMIC() bakes in the flavor at
> build time via __SRCU_STRUCT_INIT_ATOMIC(), and the runtime init
> paths set it too.
> 
> The check itself is simple: warn if the flavor changes after first
> use.  Tiny is UP so there is no race on first write, no cmpxchg
> needed.
> 
> This catches the case where a normal reader sneaks into an atomic
> domain.  synchronize_srcu_atomic() would then return early while
> that reader is still in its section, which is a UAF waiting to
> happen.
> 
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

Great minds think alike?  Kunwu Chan recently proposed a similar change,
but after discussion, we chose not to take this approach on the grounds
that Tiny SRCU should remain tiny.

But maybe we missed something.  If so, please let us know what that is.

							Thanx, Paul

> ---
>  include/linux/srcu.h     |  4 ++--
>  include/linux/srcutiny.h | 39 +++++++++++++++++++++++++++++++++++----
>  kernel/rcu/srcutiny.c    | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 1a8a465a5650..649a44d1cd00 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -36,9 +36,9 @@ static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
>  int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
>  int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
>  				   struct lock_class_key *key);
> +#endif // #ifndef CONFIG_TINY_SRCU
>  int __init_srcu_struct_atomic(struct srcu_struct *ssp, const char *name,
>  			      struct lock_class_key *key);
> -#endif // #ifndef CONFIG_TINY_SRCU
>  
>  #define init_srcu_struct_fast(ssp) \
>  ({ \
> @@ -73,8 +73,8 @@ static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
>  #ifndef CONFIG_TINY_SRCU
>  int init_srcu_struct_fast(struct srcu_struct *ssp);
>  int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
> -int init_srcu_struct_atomic(struct srcu_struct *ssp);
>  #endif // #ifndef CONFIG_TINY_SRCU
> +int init_srcu_struct_atomic(struct srcu_struct *ssp);
>  
>  #define __SRCU_DEP_MAP_INIT(srcu_name)
>  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 47a368f945e3..6b14511d09f2 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -20,6 +20,9 @@ struct srcu_struct {
>  	u8 srcu_gp_running;		/* GP workqueue running? */
>  	u8 srcu_gp_waiting;		/* GP waiting for readers? */
>  	u8 srcu_atomic_gp_flag;		/* Serialize atomic GP work.*/
> +#ifdef CONFIG_PROVE_RCU
> +	u8 srcu_reader_flavor;		/* Reader flavor for srcu_struct? */
> +#endif /* #ifdef CONFIG_PROVE_RCU */
>  	unsigned long srcu_idx;		/* Current reader array element in bit 0x2. */
>  	unsigned long srcu_idx_max;	/* Furthest future srcu_idx request. */
>  	struct swait_queue_head srcu_wq;
> @@ -39,6 +42,12 @@ void srcu_drive_gp(struct work_struct *wp);
>  void srcu_tiny_irq_work(struct irq_work *irq_work);
>  void srcu_defer_drain(struct irq_work *irq_work);
>  
> +#ifdef CONFIG_PROVE_RCU
> +#define __SRCU_READER_FLAVOR_INIT	.srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC,
> +#else
> +#define __SRCU_READER_FLAVOR_INIT
> +#endif
> +
>  #define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
>  {									\
>  	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
> @@ -51,6 +60,19 @@ void srcu_defer_drain(struct irq_work *irq_work);
>  	__SRCU_DEP_MAP_INIT(name)					\
>  }
>  
> +#define __SRCU_STRUCT_INIT_ATOMIC(name)					\
> +{									\
> +	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
> +	.srcu_cb_tail = &name.srcu_cb_head,				\
> +	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
> +	.srcu_irq_work = { .func = srcu_tiny_irq_work },		\
> +	.defer_cbs = LLIST_HEAD_INIT(name.defer_cbs),			\
> +	.defer_iw = { .node = { .u_flags = IRQ_WORK_HARD_IRQ },		\
> +		      .func = srcu_defer_drain },			\
> +	__SRCU_READER_FLAVOR_INIT					\
> +	__SRCU_DEP_MAP_INIT(name)					\
> +}
> +
>  /*
>   * This odd _STATIC_ arrangement is needed for API compatibility with
>   * Tree SRCU, which needs some per-CPU data.
> @@ -65,20 +87,19 @@ void srcu_defer_drain(struct irq_work *irq_work);
>  #define DEFINE_SRCU_FAST_UPDOWN(name) DEFINE_SRCU(name)
>  #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
>  	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> -#define DEFINE_SRCU_ATOMIC(name) DEFINE_SRCU(name)
> +#define DEFINE_SRCU_ATOMIC(name) \
> +	struct srcu_struct name = __SRCU_STRUCT_INIT_ATOMIC(name)
>  #define DEFINE_STATIC_SRCU_ATOMIC(name) \
> -	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> +	static struct srcu_struct name = __SRCU_STRUCT_INIT_ATOMIC(name)
>  
>  // Dummy structure for srcu_notifier_head.
>  struct srcu_usage { };
>  #define __SRCU_USAGE_INIT(name) { }
>  #define __init_srcu_struct_fast __init_srcu_struct
>  #define __init_srcu_struct_fast_updown __init_srcu_struct
> -#define __init_srcu_struct_atomic __init_srcu_struct
>  #ifndef CONFIG_DEBUG_LOCK_ALLOC
>  #define init_srcu_struct_fast init_srcu_struct
>  #define init_srcu_struct_fast_updown init_srcu_struct
> -#define init_srcu_struct_atomic init_srcu_struct
>  #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
>  
>  void synchronize_srcu(struct srcu_struct *ssp);
> @@ -147,7 +168,17 @@ static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
>  void srcu_barrier(struct srcu_struct *ssp);
>  
>  static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
> +
> +#ifdef CONFIG_PROVE_RCU
> +void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
> +
> +static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
> +{
> +	__srcu_check_read_flavor(ssp, read_flavor);
> +}
> +#else /* #ifdef CONFIG_PROVE_RCU */
>  #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
> +#endif /* #else #ifdef CONFIG_PROVE_RCU */
>  
>  /* Defined here to avoid size increase for non-torture kernels. */
>  static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 76411562366f..76a276de07ee 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -52,6 +52,25 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROVE_RCU
> +int __init_srcu_struct_atomic(struct srcu_struct *ssp, const char *name,
> +			      struct lock_class_key *key)
> +{
> +	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
> +	return __init_srcu_struct(ssp, name, key);
> +}
> +EXPORT_SYMBOL_GPL(__init_srcu_struct_atomic);
> +
> +#ifndef CONFIG_DEBUG_LOCK_ALLOC
> +int init_srcu_struct_atomic(struct srcu_struct *ssp)
> +{
> +	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
> +	return init_srcu_struct_generic(ssp);
> +}
> +EXPORT_SYMBOL_GPL(init_srcu_struct_atomic);
> +#endif /* #ifndef CONFIG_DEBUG_LOCK_ALLOC */
> +#endif /* #ifdef CONFIG_PROVE_RCU */
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
>  int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
> @@ -212,6 +231,23 @@ void srcu_tiny_irq_work(struct irq_work *irq_work)
>  }
>  EXPORT_SYMBOL_GPL(srcu_tiny_irq_work);
>  
> +#ifdef CONFIG_PROVE_RCU
> +/*
> + * Check for consistent reader flavor.  Tiny SRCU is UP only, so no
> + * cmpxchg is needed to set the flavor on first use.
> + */
> +void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
> +{
> +	int old_read_flavor = ssp->srcu_reader_flavor;
> +
> +	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
> +	WARN_ON_ONCE(old_read_flavor && read_flavor != old_read_flavor);
> +	if (!old_read_flavor)
> +		ssp->srcu_reader_flavor = read_flavor;
> +}
> +EXPORT_SYMBOL_GPL(__srcu_check_read_flavor);
> +#endif /* #ifdef CONFIG_PROVE_RCU */
> +
>  static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>  {
>  	unsigned long cookie;
> -- 
> 2.47.3
