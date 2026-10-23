Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783884;
	b=cREqRPQ86TOxXu6PCuhJisF09B9Z4cr2goIbCcRWUiMOBSe4mQItBgvfhQN5KvHWIbty
	 x9DklrA8MGPo1PYhPgZB5MRpi1ocXuoWglZC6EaTLSohdhlzRNwuIQT8y4uw5fm1VfjEX
	 lMfcuVzskGJwHmLv+NqyDx0LTRue6K3w2kC8ESPhW7Cnu4uiihAspYTVueogUrywEgJHZ
	 8SQAgMkdubls7bM4+qmruiGI5xXIkorIK82sAkJEzXdlvCVQMpDqgwTNVR/CAIfOF8dDC
	 maqClRxRh7nQgXOr2XirzKBoaRZVczNmg64e+PUrMe69Oh0DX10r5rcsXNvDBV+dj8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783884;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=j0eE9DShJATD9n4amIPDYQ7F6f0UNJGTjmUBZ2vgkSU=;
	b=F7Uq+3QJHcCQlnSngSHtedSEcgZ+sPFQWYiOv3t1TomfIGGFwvIKdDDFFIJtMrWi6uE+
	 Dti3k/5GRaKbQidGv5L4kP8uzdFF6m3/NSuZfo2aXPjsee9JLbV/sEpzSp3Gv2YCOvLNC
	 43aEuaS9wKpntLma+2kyeqV50p6P33Pg3rACnNQoM6A54n94avGeVerWDGgRlL1lZSxEl
	 HwrwMZ32ogWspx6i+2p+YvWB0eVfKPKrcuCZS1KvAaUFhrEY9SxnVQ3jIn5JucY4ztFat
	 /hMyOHs6lK/QNzmcTgBopc2dTEZL3oHP0mKeJXJXff+RuUq/W5GWkRI/IWM0F6Ey3Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJXsZTv3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C736606A320;
	Fri, 23 Oct 2026 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJXsZTv3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C6D1F031E0;
	Fri, 23 Oct 2026 19:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783883;
	bh=j0eE9DShJATD9n4amIPDYQ7F6f0UNJGTjmUBZ2vgkSU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mJXsZTv3mChWZjYfrCgDxVHOvP29m0YdoIzMgahC1C1Fwu7UFpO5TkpGuspV21/Dj
	 nGheSPQkjZBjdNQthQM6DmaZSzHHr6m20c3UM4URk8NX3ZjrIKRIEpUWi5g8MjkegB
	 NwdbRTXiV4UDdku5L3IIPDr5HNZoQ1BRIRpSmv64gwb6He2C3mwUnRCdaBqSqy+UXo
	 SZ1wZE5zUUkgMBRCofBQOxCFM5rbJHnyPjwEMmYXHcGXniFon54dtTnZav1RCGvm7v
	 VBzZfiEC6nQYiwrkFgEiH/vn2zwLe/jvw3VQdoTzoftc2gZOkpVuAPrYChSTtoT8pV
	 vBctF/RtrNVNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 10EE3CE0811; Fri, 23 Oct 2026 12:31:23 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:31:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 8/9] srcutiny: Detect duplicate callback enqueue
Message-ID: <384fa5e2-1cac-4ff4-bea9-173188d4128f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-9-kunwu.chan@gmail.com>
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
In-Reply-To: <20261023101841.2910719-9-kunwu.chan@gmail.com>

On Fri, Oct 23, 2026 at 06:18:40PM +0800, Kunwu Chan wrote:
> Detect duplicate callback enqueue attempts at call_srcu()
> entry, before the deferred list can be corrupted.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Same questions as for the previous patch.  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/srcutiny.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 98864977bed2..4400fd2b41b7 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -12,6 +12,7 @@
>  #include <linux/irq_work.h>
>  #include <linux/kasan.h>
>  #include <linux/llist.h>
> +#include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/preempt.h>
>  #include <linux/rcupdate_wait.h>
> @@ -178,6 +179,7 @@ void srcu_drive_gp(struct work_struct *wp)
>  	while (lh) {
>  		rhp = lh;
>  		lh = lh->next;
> +		debug_rcu_head_unqueue(rhp);
>  		debug_rcu_head_callback(rhp);
>  		local_bh_disable();
>  		rhp->func(rhp);
> @@ -235,6 +237,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>   * Also called by __srcu_defer_drain() to re-issue a deferred callback, so it
>   * must not re-check the deferral condition.
>   */
> +static void srcu_leak_callback(struct rcu_head *rhp) { }
> +
>  static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
>  			    rcu_callback_t func)
>  {
> @@ -272,6 +276,8 @@ static void __srcu_defer_drain(struct srcu_struct *ssp)
>  	llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
>  		struct rcu_head *rhp = (struct rcu_head *)node;
>  
> +		/* Bounds a node self-linked by a double call_srcu(). */
> +		rhp->next = NULL;
>  		srcu_do_enqueue(ssp, rhp, rhp->func);
>  	}
>  	local_irq_restore(flags);
> @@ -291,6 +297,8 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
>  void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  	       rcu_callback_t func)
>  {
> +	static atomic_t doublefrees;
> +
>  	/* Misaligned rcu_head! */
>  	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
>  
> @@ -298,6 +306,16 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  	if (WARN_ON_ONCE(!func))
>  		return;
>  
> +	if (debug_rcu_head_queue(rhp)) {
> +		if (atomic_inc_return(&doublefrees) < 4) {
> +			pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
> +			       __func__, rhp, rhp->func);
> +			mem_dump_obj(rhp);
> +		}
> +		WRITE_ONCE(rhp->func, srcu_leak_callback);
> +		return;
> +	}
> +
>  	/* Record the caller: the irq_work's stack says nothing about it. */
>  	kasan_record_aux_stack(rhp);
>  
> @@ -306,6 +324,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  		if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
>  			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
>  				  "call_srcu() re-entered during callback drain; leaking callback\n");
> +			debug_rcu_head_unqueue(rhp);
>  			return;
>  		}
>  		rhp->func = func;
> -- 
> 2.43.0
> 
