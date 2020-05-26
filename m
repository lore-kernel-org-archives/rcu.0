Return-Path: <SRS0=yR10=7I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF48AC433DF
	for <rcu@archiver.kernel.org>; Tue, 26 May 2020 16:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23FE20776
	for <rcu@archiver.kernel.org>; Tue, 26 May 2020 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590509770;
	bh=xEHmgnxkxaALvBrFKBRWfnxTgnZvNpRIyAMaxbvk9wM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=VKNlsuMZl/urt+5pBWPhvoI1KEpLommUkfT+Rtvk9gYJE4WhVKG3CaS6TJMkhFFEs
	 lGXHbpD4aR4KkLvcAZoEbygBSvYPY64hU8/9H7m8xZvHDEvhUBOr3e7aYWNinGiq57
	 lh8cN+B2r6B+EXtNrZVhENbGJL+PdlCAjYQzGkSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgEZQQK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 May 2020 12:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgEZQQK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 May 2020 12:16:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7CD20704;
        Tue, 26 May 2020 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590509769;
        bh=xEHmgnxkxaALvBrFKBRWfnxTgnZvNpRIyAMaxbvk9wM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VHswxgcKkxeluYKiH4v4pe1MFXGcYoAXf1GpqKQveGmKrldcxpBZjx8LewLgzbLBz
         RFpH03Vhx5itPPALMsnhGG85iaJaDWYj7A4UuqwpH4IYFjJE2XV2s+vhVR9dd6U1yn
         VhoQxzd2Q3Dogj4xxfqsqB+KQ+NBgdPHU20UgtAc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A4DE43522A8B; Tue, 26 May 2020 09:16:09 -0700 (PDT)
Date:   Tue, 26 May 2020 09:16:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH] srcu: Avoid local_irq_save() before acquiring spinlock_t
Message-ID: <20200526161609.GJ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520184345.GU2869@paulmck-ThinkPad-P72>
 <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
 <20200522173953.GI2869@paulmck-ThinkPad-P72>
 <20200523150831.wdrthklakwm6wago@linutronix.de>
 <20200524190356.eqohmrmbilonm4u7@linutronix.de>
 <20200525032717.GV2869@paulmck-ThinkPad-P72>
 <20200526134134.5uq62linhbog43q3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526134134.5uq62linhbog43q3@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 26, 2020 at 03:41:34PM +0200, Sebastian Andrzej Siewior wrote:
> SRCU disables interrupts to get a stable per-CPU pointer and then
> acquires the spinlock which is in the per-CPU data structure. The
> release uses spin_unlock_irqrestore(). While this is correct on a non-RT
> kernel, this conflicts with the RT semantics because the spinlock is
> converted to a 'sleeping' spinlock. Sleeping locks can obviously not be
> acquired with interrupts disabled.
> 
> Acquire the per-CPU pointer `ssp->sda' without disabling preemption and
> then acquire the spinlock_t of the per-CPU data structure. The lock
> will ensure that the data is consistent.
> The added check_init_srcu_struct() is now needed because a statically 
> defined srcu_struct may remain uninitialized until this point and the
> newly introduced locking operation requires an initialized spinlock_t.
> 
> This change was tested for four hours with 8*SRCU-N and 8*SRCU-P without
> causing any warnings.

Queued, thank you!!!

							Thanx, Paul

> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: rcu@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/rcu/srcutree.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0c71505f0e19c..9459bca58c380 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -764,14 +764,15 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
>  	unsigned long t;
>  	unsigned long tlast;
>  
> +	check_init_srcu_struct(ssp);
>  	/* If the local srcu_data structure has callbacks, not idle.  */
> -	local_irq_save(flags);
> -	sdp = this_cpu_ptr(ssp->sda);
> +	sdp = raw_cpu_ptr(ssp->sda);
> +	spin_lock_irqsave_rcu_node(sdp, flags);
>  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> -		local_irq_restore(flags);
> +		spin_unlock_irqrestore_rcu_node(sdp, flags);
>  		return false; /* Callbacks already present, so not idle. */
>  	}
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore_rcu_node(sdp, flags);
>  
>  	/*
>  	 * No local callbacks, so probabalistically probe global state.
> @@ -851,9 +852,8 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  	}
>  	rhp->func = func;
>  	idx = srcu_read_lock(ssp);
> -	local_irq_save(flags);
> -	sdp = this_cpu_ptr(ssp->sda);
> -	spin_lock_rcu_node(sdp);
> +	sdp = raw_cpu_ptr(ssp->sda);
> +	spin_lock_irqsave_rcu_node(sdp, flags);
>  	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>  	rcu_segcblist_advance(&sdp->srcu_cblist,
>  			      rcu_seq_current(&ssp->srcu_gp_seq));
> -- 
> 2.27.0.rc0
> 
