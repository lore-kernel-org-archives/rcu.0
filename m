Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57C72626;
	Wed,  7 May 2025 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651896; cv=none; b=o8gdMlzzW3seDGyksxn3OOYbsrf/uRP/bOCMsPtdi2OgCWtJA0KzNjupn03x27Lby6fOizjxDJ2Wjnov9zpwiINV7q5xL+pMtTDI+23keZdi/fyOKwGsVo+yaQKFan0QswXY+IiLuD04m3CLhngK16N+PGksjs58u+ldCYY1Bcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651896; c=relaxed/simple;
	bh=GUkW1g+uu5m2dJXuV+B31jajok8+HhqfJ3ZrY3GzlsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1SVCNGV7gyltr1+HdoK5N7bTm2z25uRfziMl79VNSIi8bT7U+nAR+It6eAITCgchJKasnyXOouCKk+pGuHDDo2go2pXlXmuhPXti0YASYY3toL7R3Iy3fS4rrmGy5+PWlFxGMPM7k0mpWwtsKuKvurOaSY/fq8hzweFme5umeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPdqcoG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPdqcoG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7646C4CEE2;
	Wed,  7 May 2025 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746651895;
	bh=GUkW1g+uu5m2dJXuV+B31jajok8+HhqfJ3ZrY3GzlsU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vPdqcoG5iK9nvfPzTH9P+D/xvgm3IWSRl8yqWRKm/0j4bs/1mi7oPomqjM+8J7QtX
	 siig0RYleR3haPF1yddi0hoUm5d/BINA1pBpDsN6qNS+bi1dAt/nBM0je3w7Xaf4Sg
	 Nay0jmhYboXriDCNcPTt56FLSV18AaYbbUrbqjw18BFy/hD4/M9nBRysI9lPrL5pRY
	 639OoZtjgJYmEcg1ocI/5kd2zCT9sQGUo2DDjjHEYHyDUnsahr3Sgzldgln8U4nkKd
	 cZ8zOWjqMMBSe6c6QIrQvnhlP5PD2FNHcs2BrkzrGquVMHJ79HQmy9eE+Elzyo0l9E
	 1BjBTP3sUNggw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 81363CE077B; Wed,  7 May 2025 14:04:55 -0700 (PDT)
Date: Wed, 7 May 2025 14:04:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix rcutorture_one_extend_check() splat in
 RT kernels
Message-ID: <c5b6ab90-82de-437e-b608-7de6b21c9586@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507112605.20910-1-qiang.zhang1211@gmail.com>

On Wed, May 07, 2025 at 07:26:03PM +0800, Zqiang wrote:
> For built with CONFIG_PREEMPT_RT=y kernels, running rcutorture
> tests resulted in the following splat:
> 
> [   68.797425] rcutorture_one_extend_check during change: Current 0x1  To add 0x1  To remove 0x0  preempt_count() 0x0
> [   68.797533] WARNING: CPU: 2 PID: 512 at kernel/rcu/rcutorture.c:1993 rcutorture_one_extend_check+0x419/0x560 [rcutorture]
> [   68.797601] Call Trace:
> [   68.797602]  <TASK>
> [   68.797619]  ? lockdep_softirqs_off+0xa5/0x160
> [   68.797631]  rcutorture_one_extend+0x18e/0xcc0 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
> [   68.797646]  ? local_clock+0x19/0x40
> [   68.797659]  rcu_torture_one_read+0xf0/0x280 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
> [   68.797678]  ? __pfx_rcu_torture_one_read+0x10/0x10 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
> [   68.797804]  ? __pfx_rcu_torture_timer+0x10/0x10 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
> [   68.797815] rcu-torture: rcu_torture_reader task started
> [   68.797824] rcu-torture: Creating rcu_torture_reader task
> [   68.797824]  rcu_torture_reader+0x238/0x580 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
> [   68.797836]  ? kvm_sched_clock_read+0x15/0x30
> 
> Disable BH does not change the SOFTIRQ corresponding bits in
> preempt_count() for RT kernels, this commit therefore use
> softirq_count() to check the if BH is disabled.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 373c65a6e103..ef439569f979 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -471,7 +471,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
>  	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
>  		started = cur_ops->get_gp_seq();
>  		ts = rcu_trace_clock_local();
> -		if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
> +		if ((preempt_count() & HARDIRQ_MASK) || softirq_count())
>  			longdelay_ms = 5; /* Avoid triggering BH limits. */
>  		mdelay(longdelay_ms);
>  		rtrsp->rt_delay_ms = longdelay_ms;
> @@ -1990,7 +1990,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>  		return;
>  
>  	WARN_ONCE((curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
> -		  !(preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
> +		  !softirq_count(), ROEC_ARGS);
>  	WARN_ONCE((curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
>  		  !(preempt_count() & PREEMPT_MASK), ROEC_ARGS);
>  	WARN_ONCE(cur_ops->readlock_nesting &&
> @@ -2004,7 +2004,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>  
>  	WARN_ONCE(cur_ops->extendables &&
>  		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
> -		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
> +		  softirq_count(), ROEC_ARGS);

Given that softirq_count is defined as (preempt_count() & SOFTIRQ_MASK)
for CONFIG_PREEMPT_RT=n, the above don't change anything in that case,
so good.  For CONFIG_PREEMPT_RT=y, softirq_count() looks to be the way
to check BH-disable nesting, so that is good as well.

>  	/*
>  	 * non-preemptible RCU in a preemptible kernel uses preempt_disable()
> @@ -2025,6 +2025,9 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
>  		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && softirq_count())
> +		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;

At this point in the code, we are complaining if something is disabled
when it is not supposed to be.  So if I understand this correctly, this
added code would suppress complaints (but only in CONFIG_PREEMPT_RT=y
kernels) when there is an unexpected rcu_read_lock() in the case where
there was either local_bh_disable() or rcu_read_lock_bh() in effect.

So I would expect that the CONFIG_PREEMPT_RT=y version of both
local_bh_disable() and rcu_read_lock_bh() would contain rcu_read_lock().

And in fact, rcu_read_lock_bh() invokes local_bh_disable(),
which, for CONFIG_PREEMPT_RT=y invokes __local_bh_disable_ip() in
kernel/softirq.c, which on the outermost local_bh_disabe() really does
invoke rcu_read_lock().

So this one looks good as well!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> +
>  	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
>  		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
>  }
> -- 
> 2.17.1
> 
