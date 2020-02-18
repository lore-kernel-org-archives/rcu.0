Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3663C34026
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 11:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E6C207FD
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 11:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wb1uzUTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgBRLrD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:47:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41880 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgBRLrD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 06:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UxjyAte6Pn7aIA1sKonsxJ1h6Ij2+oKQk3yC+HQWKYw=; b=Wb1uzUTHlM0O+2/DCKc77awEdC
        AP+b2dZyhAGrtdOPsxRJlpdm2XJ/mcOPG9fx/PcZquMGWMOQ3+oi5Tcin4GmToKywuMXnYDEKxYBg
        fDTXykpIMZdyieeiaMCT10LlSkBFa0l0TorVVd71EvkC7OHjst104lA8QOmCIJFJFHRB6xKEi4dTx
        o0RzZ8GlXUYh4nPaQyoVZuhRzO3Fiaf4tlAyOkm6RKq0/Ax1LCQ2N3NztkiVBcH/D3KPvvIuI66C4
        PaBkzXYtYGm44sh6NdZt3aTosJNSb5FuWNpRweBKXtGRGGnezNApxOGv2yREiz2CpUI7XXAKYCrAv
        1DsvWu8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j41Kl-0002iV-OF; Tue, 18 Feb 2020 11:46:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AE00300446;
        Tue, 18 Feb 2020 12:44:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1CE4203E6A01; Tue, 18 Feb 2020 12:46:31 +0100 (CET)
Date:   Tue, 18 Feb 2020 12:46:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 4/4] srcu: Add READ_ONCE() to srcu_struct
 ->srcu_gp_seq load
Message-ID: <20200218114631.GY14914@hirez.programming.kicks-ass.net>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-4-paulmck@kernel.org>
 <20200217124507.GT14914@hirez.programming.kicks-ass.net>
 <20200217183220.GS2935@paulmck-ThinkPad-P72>
 <20200217230657.GA8985@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217230657.GA8985@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 03:06:57PM -0800, Paul E. McKenney wrote:
> commit 52324a7b8a025f47a1a1a9fbd23ffe59fa764764
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Jan 3 11:42:05 2020 -0800
> 
>     srcu: Hold srcu_struct ->lock when updating ->srcu_gp_seq
>     
>     A read of the srcu_struct structure's ->srcu_gp_seq field should not
>     need READ_ONCE() when that structure's ->lock is held.  Except that this
>     lock is not always held when updating this field.  This commit therefore
>     acquires the lock around updates and removes a now-unneeded READ_ONCE().
>     
>     This data race was reported by KCSAN.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 119a373..c19c1df 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -450,7 +450,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
>  	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
>  	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
>  	rcu_seq_start(&ssp->srcu_gp_seq);
> -	state = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
> +	state = rcu_seq_state(ssp->srcu_gp_seq);
>  	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
>  }
>  
> @@ -1130,7 +1130,9 @@ static void srcu_advance_state(struct srcu_struct *ssp)
>  			return; /* readers present, retry later. */
>  		}
>  		srcu_flip(ssp);
> +		spin_lock_irq_rcu_node(ssp);
>  		rcu_seq_set_state(&ssp->srcu_gp_seq, SRCU_STATE_SCAN2);
> +		spin_unlock_irq_rcu_node(ssp);
>  	}
>  
>  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
