Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49421D3F3;
	Tue, 24 Mar 2026 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383490; cv=none; b=omXgkUuKj/TkTKlHjMV06mHfbHgYFEd/LHaKMEPHK3Ec/MQQvx/oSKIlYeaMICQJ7Swi5YCZ86vyOMmca/kOHHJQSVCgSak0PC0BM42w8/GhC5xespxF66j/D7scatsLqrbmzQIygy3CuGmgOllY0NpiCdlHdu3eBoodqO84EEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383490; c=relaxed/simple;
	bh=5D4Vd+9zOBxF1KTFcJ1FjA6UMVMQUfPdMIAKszRGhSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLLMODb4lsQTcaG6+6SjH2jHttZdu1vGvfPSh1fFCsNfW1NyChYzXmJ7tjuwtqfXutAsYjDzr0vWaFkOPH97ew32Vk86wwltIiXlO+MfzFAzXc8o5YVimZwKTmvepmJExhagTuJi21Q35s6MNE5YV441PrDhIPrnt6cVJ59M8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLhKoOM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLhKoOM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89735C2BCB2;
	Tue, 24 Mar 2026 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774383490;
	bh=5D4Vd+9zOBxF1KTFcJ1FjA6UMVMQUfPdMIAKszRGhSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLhKoOM4SZv1ZggaoplTCsJ2XFUHw61OM5gq47dhmEhIARnx/cm4b6hFESh1P6igh
	 N8+2lEaRFK2YHWhSTvhW4ft65kTg0x/8y3T27K/HyvnXGCHLg9+d9rhIWiyIJsvV1W
	 GYeANLavbYq3HpcgYtH0P+8JYDelqodTj5HWKQyzQv4CLPhgba1SUwWZVkWsL6Fdot
	 EHt8lKXpknQ9u0hWk4Kh7vO/ZO7xf/7o+HqJ8oPh6+Ymd21IH0zuQDpV/Qq9c99ReA
	 B2l4SmTK4QKuKIPlP+4TwzcqclpjXly+8VxKgAxYqhgUQX/sUrN5rDjOjULFCKLjF3
	 /Xc2h7ZK/O/9Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 90405F40068;
	Tue, 24 Mar 2026 16:18:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 24 Mar 2026 16:18:08 -0400
X-ME-Sender: <xms:gPHCaTbRHEkdD7LTBAZMS26QQYXATK9QfQeOat0wQq0WtMIXx_t1tA>
    <xme:gPHCaY43cRzhnz5nLv9OiXrtrqKi7aj1o-Z0rGn4E9siEBeIuQEHprxXhM88cM-iS
    XT0J1ZI4f_nykYGtz0G8TwGY1GtaXLDhi39KRu_TFRtzF-69oNHzQ>
X-ME-Received: <xmr:gPHCaT9G8McDBTDRPCr84Vp9NNDwy2toXRIG1BC8i6PSsXxwEVGog7dXndI4PhwPBG_KK2jMaYexk_m0PFfPWYejSh4crMJ5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjh
    druhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshhesjhho
    shhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphht
    thhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprh
    gtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:gPHCacbOKHKN8bvHn9f8rdctTUMpU4hiQdu0c4lBZvqsIxqPYnVyXg>
    <xmx:gPHCaU7RmxG3EzW45vawPvlNAz6Wgp1Yw7I3etO8I6CgY-nXX-iIJA>
    <xmx:gPHCaZklErOyOgrLXdIY6hkzWbRsh3GPqePCXCfduIUGoU6oihFITA>
    <xmx:gPHCacHFBKtwdtnBDfU6UKkmKSinrvpLH4P4T-Eh_nxc7s6yE5-sgw>
    <xmx:gPHCaajgH_drx8bXxs-S-89RSA3SJdxzB3cTXRQLzEzozrOCOC6XYv9z>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 16:18:07 -0400 (EDT)
Date: Tue, 24 Mar 2026 13:18:07 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Use irq_work to start GP in tiny SRCU
Message-ID: <acLxf01sjV0cZ0cP@tardis.local>
References: <20260324001418.89363-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324001418.89363-1-joelagnelf@nvidia.com>

On Mon, Mar 23, 2026 at 08:14:18PM -0400, Joel Fernandes wrote:
> Tiny SRCU's srcu_gp_start_if_needed() directly calls schedule_work(),
> which acquires the workqueue pool->lock.
> 
> This causes a lockdep splat when call_srcu() is called with a scheduler
> lock held, due to:
> 
>   call_srcu() [holding pi_lock]
>     srcu_gp_start_if_needed()
>       schedule_work() -> pool->lock
> 
>   workqueue_init() / create_worker() [holding pool->lock]
>     wake_up_process() -> try_to_wake_up() -> pi_lock
> 
> Also add irq_work_sync() to cleanup_srcu_struct() to prevent a
> use-after-free if a queued irq_work fires after cleanup begins.
> 
> Tested with rcutorture SRCU-T and no lockdep warnings.
> 
> [ Thanks to Boqun for similar fix in patch "rcu: Use an intermediate irq_work
> to start process_srcu()" ]
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Queued into

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git fixes.v7.0-rc4

with Paul's Reviewed-by provided in an offlist discussion.

Regards,
Boqun

> ---
>  include/linux/srcutiny.h |  4 ++++
>  kernel/rcu/srcutiny.c    | 19 ++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index dec7cbe015aa..905b629e8fa3 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -11,6 +11,7 @@
>  #ifndef _LINUX_SRCU_TINY_H
>  #define _LINUX_SRCU_TINY_H
>  
> +#include <linux/irq_work_types.h>
>  #include <linux/swait.h>
>  
>  struct srcu_struct {
> @@ -24,18 +25,21 @@ struct srcu_struct {
>  	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
>  	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
>  	struct work_struct srcu_work;	/* For driving grace periods. */
> +	struct irq_work srcu_irq_work;	/* Defer schedule_work() to irq work. */
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map dep_map;
>  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  };
>  
>  void srcu_drive_gp(struct work_struct *wp);
> +void srcu_tiny_irq_work(struct irq_work *irq_work);
>  
>  #define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
>  {									\
>  	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
>  	.srcu_cb_tail = &name.srcu_cb_head,				\
>  	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
> +	.srcu_irq_work = { .func = srcu_tiny_irq_work },		\
>  	__SRCU_DEP_MAP_INIT(name)					\
>  }
>  
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 3450c3751ef7..a2e2d516e51b 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/export.h>
> +#include <linux/irq_work.h>
>  #include <linux/mutex.h>
>  #include <linux/preempt.h>
>  #include <linux/rcupdate_wait.h>
> @@ -41,6 +42,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
>  	ssp->srcu_idx_max = 0;
>  	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
>  	INIT_LIST_HEAD(&ssp->srcu_work.entry);
> +	init_irq_work(&ssp->srcu_irq_work, srcu_tiny_irq_work);
>  	return 0;
>  }
>  
> @@ -84,6 +86,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
>  void cleanup_srcu_struct(struct srcu_struct *ssp)
>  {
>  	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
> +	irq_work_sync(&ssp->srcu_irq_work);
>  	flush_work(&ssp->srcu_work);
>  	WARN_ON(ssp->srcu_gp_running);
>  	WARN_ON(ssp->srcu_gp_waiting);
> @@ -177,6 +180,20 @@ void srcu_drive_gp(struct work_struct *wp)
>  }
>  EXPORT_SYMBOL_GPL(srcu_drive_gp);
>  
> +/*
> + * Use an irq_work to defer schedule_work() to avoid acquiring the workqueue
> + * pool->lock while the caller might hold scheduler locks, causing lockdep
> + * splats due to workqueue_init() doing a wakeup.
> + */
> +void srcu_tiny_irq_work(struct irq_work *irq_work)
> +{
> +	struct srcu_struct *ssp;
> +
> +	ssp = container_of(irq_work, struct srcu_struct, srcu_irq_work);
> +	schedule_work(&ssp->srcu_work);
> +}
> +EXPORT_SYMBOL_GPL(srcu_tiny_irq_work);
> +
>  static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>  {
>  	unsigned long cookie;
> @@ -189,7 +206,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>  	WRITE_ONCE(ssp->srcu_idx_max, cookie);
>  	if (!READ_ONCE(ssp->srcu_gp_running)) {
>  		if (likely(srcu_init_done))
> -			schedule_work(&ssp->srcu_work);
> +			irq_work_queue(&ssp->srcu_irq_work);
>  		else if (list_empty(&ssp->srcu_work.entry))
>  			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
>  	}
> -- 
> 2.34.1
> 
