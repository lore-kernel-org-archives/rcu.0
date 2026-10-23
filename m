Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784467;
	b=ECHdPXLdG8+hD7qHwZeKd2Ul9mZG4oDaSmiIF5BgLIeu9qW8vITvpjWFaoRVwddz7t7s
	 7pSslUuM2NFjDWtauGZ15TQdjcg2yeE2T038otIb9xN6hpRTSU5NlYPY08NQU3KVK9anM
	 Gmo2x3bWvHFMNVDXYNv34QY5a9VRk7tSaCqfk9ANozBwLX4quZbxTwxnqWCDMK2yglWxc
	 dfKHFCWhuzZM/v5l8jJ6MJ5NFnsoN+6dmXSvWsYkIJk5b7lKj3FIO2vD9EwiwmFpV4t0R
	 dw20EcF/78FlEtIC4wUwIuu92HQ3t5przV9WI9Cn/G/CSSbLiGBNHObEOgPjkaUr4+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784467;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=EgDiY2LFhakw2S3C6zCHb4VaExbh0TfqfBv7C2PSD5A=;
	b=lrducEK9ifXLe+BPLPwCxet4/5rfgSXrnHhnLJEsnhF/0JvG94sTyt8bmt1Y31ltgzPM
	 oTWbyd8Ti6jX2ONoZMbSlapoOcV+Z7A/Jc9vo7dl2BWpn/WVfxaINoIkzjaxIfF/6exk9
	 3hKcpDmbirKbYgWvQ4lIjBxWWL7fNfezrCB6rblImW4dybbSXhlDzq7uygNQmPA7rBs0v
	 zjAZAwhaZaLcplnR726etxngOPJrSLnL0NXx3Clq8d7lLbRa/3BASS3ZOSm6xtBuobUmW
	 lk0rjL26OmukM0VTKfCyTdEnc5xoBMLS2+lFFtcppoFXG6z1XC386JTmnMmUyfqNQyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdJ1W9QT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1E606A31D;
	Fri, 23 Oct 2026 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdJ1W9QT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4C81F01825;
	Fri, 23 Oct 2026 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792784466;
	bh=EgDiY2LFhakw2S3C6zCHb4VaExbh0TfqfBv7C2PSD5A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WdJ1W9QTaZdS/WlyDDjsdVvDFiohq1KCQ2bT/uo+6uVQFXzrfMHL7sNMDm4k86/j5
	 RhgwB42H/0BbhGdbVZr/1FU+SYjw3+YIQIj8npONZnxNN+bK7XwEB73tRb03NUWRYD
	 /u6hRzBOK/CfruUTFubT9S3uKS38mvmFWvHopTamKnkZuXBUP+PAzs+zTe73Vv+Ppt
	 j4TAKAPavYwkYOWW3hmKsPWVyvpVz5uL5JRZQwj3+hclyS4dVNImuUL/SRRrlOB+ZY
	 qahaXkwYgu7bSYqUfEgLbJU2W/BGNBkCG5zpmxgz9AIvAFoP7xaJa4QN4HuiEFRTaf
	 Q0SvjJZblx9wg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36382CE0811; Fri, 23 Oct 2026 12:41:06 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:41:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 1/9] srcu: Record callback registration stack for KASAN
Message-ID: <ee221d82-c064-4db8-bf85-3acc2e70b983@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-2-kunwu.chan@gmail.com>
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
In-Reply-To: <20261023101841.2910719-2-kunwu.chan@gmail.com>

On Fri, Oct 23, 2026 at 06:18:33PM +0800, Kunwu Chan wrote:
> Record the callback registration stack in __call_srcu()
> for KASAN diagnostics involving SRCU callbacks.
> 
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

For 1/9-3/9, looks good if there is a kasan_print_aux_stacks() called
somewhere from 7/9-9/9.  I am not seeing it, but then again, I do not
claim to be a KASAN expert.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2b0e2b2d2c18..46fe2f0cef85 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -20,6 +20,7 @@
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
>  #include <linux/irq_work.h>
> +#include <linux/kasan.h>
>  #include <linux/llist.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/sched.h>
> @@ -1530,6 +1531,10 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  {
>  	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
>  		return; // Leak the callback rather than corrupt SRCU state.
> +
> +	/* Record the caller: the irq_work's stack says nothing about it. */
> +	kasan_record_aux_stack(rhp);
> +
>  	if (should_rcu_defer()) {
>  		struct srcu_defer *sndp = this_cpu_ptr(&srcu_defer);
>  		struct srcu_data *sdp;
> -- 
> 2.43.0
> 
