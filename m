Return-Path: <SRS0=7Ubr=X4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F528C10F14
	for <rcu@archiver.kernel.org>; Thu,  3 Oct 2019 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D77D2086A
	for <rcu@archiver.kernel.org>; Thu,  3 Oct 2019 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570111856;
	bh=yj+v/xnwfsImbwvHnodO8koA4ah7y80gAuvuQteNkjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UQRPns5vIGuoipEN3A4z70aMphnfawA0P03anmBpdZNFsSQs7wVPOcg2SjEIX9TL5
	 Mf8r28QGuwKYOULW12BTzowARkVb8UcrOPG+YITWTX6J8h/SyhcBuBX9rF3xI24dIh
	 3YSXbIkQYL6XD5Hfjl0I/Okiou8/rlu0dQ8GoiUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfJCOK4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbfJCOK4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Oct 2019 10:10:56 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55A7207FF;
        Thu,  3 Oct 2019 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570111855;
        bh=yj+v/xnwfsImbwvHnodO8koA4ah7y80gAuvuQteNkjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0aVIO1KF622Q3Gvoh7K7/M7qwrcwXZ/JUtIqSP89eL4Rj2h2ZWcgF6+zuOke2CQSb
         vHgo2WvC67JYiuTXpUgrbh5YLJDUbaneOrMD7MBUUK/uha6RlJq74NFX22ofFooy2x
         e6axzfFX1vDVtoGbRKiBhafVQwhOYYZ2CcIKGbP8=
Date:   Thu, 3 Oct 2019 16:10:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 03/12] rcu: Force on tick when invoking lots
 of callbacks
Message-ID: <20191003140955.GA27003@lenoir>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
 <20191003013903.13079-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003013903.13079-3-paulmck@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 02, 2019 at 06:38:54PM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> 
> Callback invocation can run for a significant time period, and within
> CONFIG_NO_HZ_FULL=y kernels, this period will be devoid of scheduler-clock
> interrupts.  In-kernel execution without such interrupts can cause all
> manner of malfunction, with RCU CPU stall warnings being but one result.
> 
> This commit therefore forces scheduling-clock interrupts on whenever more
> than a few RCU callbacks are invoked.  Because offloaded callback invocation
> can be preempted, this forcing is withdrawn on each context switch.  This
> in turn requires that the loop invoking RCU callbacks reiterate the forcing
> periodically.
> 
> [ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  kernel/rcu/tree.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8110514..db673ae 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2151,6 +2151,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	rcu_nocb_unlock_irqrestore(rdp, flags);
>  
>  	/* Invoke callbacks. */
> +	if (IS_ENABLED(CONFIG_NO_HZ_FULL))

No need for the IS_ENABLED(), the API takes care of that.

> +		tick_dep_set_task(current, TICK_DEP_BIT_RCU);
>  	rhp = rcu_cblist_dequeue(&rcl);
>  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>  		debug_rcu_head_unqueue(rhp);
> @@ -2217,6 +2219,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	/* Re-invoke RCU core processing if there are callbacks remaining. */
>  	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
>  		invoke_rcu_core();
> +	if (IS_ENABLED(CONFIG_NO_HZ_FULL))

Same here.

Thanks.

> +		tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
>  }
>  
>  /*
> -- 
> 2.9.5
> 
