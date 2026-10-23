Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783858;
	b=2CSxUIBIGhikKnKjna1aSMJYyOz47dZvzGmEKOMXW/J9BQbFybwGvz9f2ynpu1AhhYXv
	 P7EuDzKbBCBt12uBP4idv7Od1NpeVJ/v5CuIqXr6WYjn/24HUhNzQWXtxQRE3Yqv/6Kme
	 cF4RrotxF857jlyLyMUdZDL6Eg+0dtUoR+JyTY8POacqsPyrWSez9/IC7p4mUqGzzpb1J
	 2X+6XzjmQPyEm/+XtmdQli+IqS/yHgMHoNyo//6z6BYerEXVwqGBhWecCEM+NElq3pXU9
	 L8G2lRjekL1UGezWkuuw7RU8RNaT7fJhJxkryO3mCDByJZA09xsTrDI0gDINpjR++wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783858;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Z5A5H/6hBx61gn3hQVbAYiqZMDDREX1Nyo1gzCyekRA=;
	b=v6syEOOKu9yUGnKw+s+16eiyaTSch+S+J+83wq3J4cjIXBpU4Ux/cPb88grs6N2364ng
	 ANMujodhymdCkS+vBijhsUEFKy26wDsFB3njlBvlSnHt5zB9kZpI+LDQPw4UEztGKzNC8
	 zp1Qs/PDvubZAmey5S76UFuT+vo1tvRpaapUzjLWWLPhrD4jZEl3Gf33qAOCTwuuWqeUP
	 P7Xsn+VLujXlzMyIMyiE1+GasS/uvy15CRrEWTxpbQf/i/q4pD6nzbB3pt4TNtOaQ97vn
	 GC41a1M6XPOZq1m8c57mwAqjv4wB9S7WtvrVoRVtt4Kn5PE7NvLueoIEmrRwgfptpvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQWPKE5s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE49606A31A;
	Fri, 23 Oct 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQWPKE5s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0509E1F01825;
	Fri, 23 Oct 2026 19:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783858;
	bh=Z5A5H/6hBx61gn3hQVbAYiqZMDDREX1Nyo1gzCyekRA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=iQWPKE5sQfOcRQ/4jknn+XhK+CGVTDVg85umOMMBRzZrn4PliEycBefCLNJrtbnRu
	 AS8PpQwoL47x3+NdPE+cn4WQLsS9OGTfiwfHFcInbpLoQN8fexkseiRP1t/X88zUuT
	 U2Mxy6rxSR0M0uagSx6ar5+DGUMml15hsty4UuUO34A+BpsOcIVUq00J/3BnZxSHGD
	 mJK69dFV+sE3+al50YuaoNgsSCmI5TVPPeHITzUipXQhOYBDsAucUrzwUUdZ/N3tLf
	 W3wH8RmQU5AKLPPIwr50WZ+KKlTxGmvmesA6zreNKbJuI3xOEOGfblDpZnJ+d2mrDx
	 Ixk33pxvHrCtg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BB1DDCE0811; Fri, 23 Oct 2026 12:30:57 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:30:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 7/9] srcu: Detect duplicate callback enqueue at
 registration
Message-ID: <60e6148e-b7e1-4f2f-a665-24567305956f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-8-kunwu.chan@gmail.com>
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
In-Reply-To: <20261023101841.2910719-8-kunwu.chan@gmail.com>

On Fri, Oct 23, 2026 at 06:18:39PM +0800, Kunwu Chan wrote:
> Move the duplicate-callback check from srcu_do_enqueue() to
> __call_srcu() entry so that detected duplicate registrations
> are rejected before they reach the deferred-list enqueue path.
> Report the callback address, function symbol, and object
> information, rate-limited to the first three occurrences.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Getting the stackof the call_srcu() once double-enqueue is detected
would be a very good thing!

One question below.

> ---
>  kernel/rcu/srcutree.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1993ddbdb828..3838d9fdf532 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -27,6 +27,7 @@
>  #include <linux/smp.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/srcu.h>
>  
> @@ -1511,12 +1512,6 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
>  			    rcu_callback_t func, bool do_norm)
>  {
> -	if (debug_rcu_head_queue(rhp)) {
> -		/* Probable double call_srcu(), so leak the callback. */
> -		WRITE_ONCE(rhp->func, srcu_leak_callback);
> -		WARN_ONCE(1, "call_srcu(): Leaked duplicate callback\n");
> -		return;
> -	}
>  	rhp->func = func;
>  	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
>  }
> @@ -1529,6 +1524,8 @@ static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
>  static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  			rcu_callback_t func, bool do_norm)
>  {
> +	static atomic_t doublefrees;
> +
>  	/* Misaligned rcu_head! */
>  	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
>  
> @@ -1539,6 +1536,16 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
>  		return; // Leak the callback rather than corrupt SRCU state.
>  
> +	if (debug_rcu_head_queue(rhp)) {
> +		if (atomic_inc_return(&doublefrees) < 4) {

Why this hard-coded 4?  Why not 3 or 5?  Should this be adjustable via
Kconfig or kernel boot parameter?  Or, alternatively, should the below
pr_err() instead be pr_err_ratelimited()?

> +			pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
> +			       __func__, rhp, rhp->func);
> +			mem_dump_obj(rhp);

Does any of this automatically dump out the stack that was recorded
in earlier patches in this series?

> +		}
> +		WRITE_ONCE(rhp->func, srcu_leak_callback);
> +		return;
> +	}
> +
>  	/* Record the caller: the irq_work's stack says nothing about it. */
>  	kasan_record_aux_stack(rhp);
>  
> @@ -1554,6 +1561,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  		if (READ_ONCE(sndp->draining) && !in_nmi()) {
>  			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
>  				  "call_srcu() re-entered during callback drain; leaking callback\n");
> +			debug_rcu_head_unqueue(rhp);
>  			return;
>  		}
>  		sdp = this_cpu_ptr(ssp->sda);
> -- 
> 2.43.0
> 
