Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91B3C433F5
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 21:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26CB6135F
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbhI1VFi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242829AbhI1VFh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Sep 2021 17:05:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B67B160230;
        Tue, 28 Sep 2021 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632863037;
        bh=N/AOMgQYt5jS9sw/lWYKS+K/2mvp+/Ndcn8ou0y5iSM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V86Sy0cEsjiTB+k0jeIrP2sAWqZqpG12kj+tFPvQ//GeJMYz8n5mm+TuxME/dTC1j
         AFRz+EMDdRTLArbHK4R85MWbcmRRgRuNvo7D6eG9U7rTI6oWKtvh38xDpVG9PGI8ED
         Bof/ScI03jQy3Is2T7VYxNlQWnvZXNUHxapAyAJMiCyENUJJitsGiPK3UzZClAu8gi
         781SI0dJKkah3WD58sPdFqpDlP9pN2M8J9t/HlJQFFl8/aGfe/sLXUt8l9+RyAiYGc
         CjlK/dN5gPdfhi88cNjHwhndhbw9ieHlDw5P+LQuQKFhSvA+8wD3mlFFVNNwqrn4PK
         2YNe+BNhtbXxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7FE855C0B37; Tue, 28 Sep 2021 14:03:57 -0700 (PDT)
Date:   Tue, 28 Sep 2021 14:03:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: in_irq() cleanup
Message-ID: <20210928210357.GK880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928002128.4501-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928002128.4501-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 28, 2021 at 08:21:28AM +0800, Changbin Du wrote:
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Queued for v5.17 (merge window after next), thank you!

							Thanx, Paul

> ---
>  include/linux/rcutiny.h  | 2 +-
>  kernel/rcu/tree.c        | 2 +-
>  kernel/rcu/tree_plugin.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 9be015305f9f..858f4d429946 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -85,7 +85,7 @@ static inline void rcu_irq_enter_irqson(void) { }
>  static inline void rcu_irq_exit(void) { }
>  static inline void rcu_irq_exit_check_preempt(void) { }
>  #define rcu_is_idle_cpu(cpu) \
> -	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
> +	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
>  static inline void exit_rcu(void) { }
>  static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  {
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bce848e50512..b53dd00975ab 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1471,7 +1471,7 @@ static void rcu_gp_kthread_wake(void)
>  {
>  	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
>  
> -	if ((current == t && !in_irq() && !in_serving_softirq()) ||
> +	if ((current == t && !in_hardirq() && !in_serving_softirq()) ||
>  	    !READ_ONCE(rcu_state.gp_flags) || !t)
>  		return;
>  	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index d070059163d7..727bf14c9a63 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -642,7 +642,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
>  			    t->rcu_blocked_node);
>  		// Need to defer quiescent state until everything is enabled.
> -		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
> +		if (use_softirq && (in_hardirq() || (expboost && !irqs_were_disabled))) {
>  			// Using softirq, safe to awaken, and either the
>  			// wakeup is free or there is either an expedited
>  			// GP in flight or a potential need to deboost.
> -- 
> 2.32.0
> 
