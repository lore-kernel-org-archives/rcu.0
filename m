Return-Path: <SRS0=SldO=A6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959C6C433E1
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1142176B
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595194420;
	bh=39w97OAujguAv3WgCcCJ8gxOTSuZUuRcGIFiyJTtDrQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jEMIyd5pOrt8Se3bcgduQD8est/b8K31JPIEO4xP7/HqCNd+gHKb03ZgsxE47x38V
	 38HvuYC4snbmYHlM06p1WcziN0xyoCp/+rjiuZZiQyKAu0ZBAeemWwdjR3MEGkJOpm
	 u+I2kRygATG6MuAVwrwX0SIIGvsH0aQWkkE7qz7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgGSVdk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgGSVdj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Jul 2020 17:33:39 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DBD72065D;
        Sun, 19 Jul 2020 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595194419;
        bh=39w97OAujguAv3WgCcCJ8gxOTSuZUuRcGIFiyJTtDrQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f1gsk+DezGktyqHKnei43C+3mSxBVm0ZV/rdQmuR/lY1sAZfkzivrXRu+iEitPrIN
         WTOtQ6fkaKZXMusswFuiv1S9fPL3MJVb+nrJ2cmaiIzgNG3EZNrm9X7aLiPydPe5YJ
         UvYdduySub8e2fo3Edlc5K8uMQzpqwhqPFzreSxo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8425C35230B3; Sun, 19 Jul 2020 14:33:39 -0700 (PDT)
Date:   Sun, 19 Jul 2020 14:33:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     josh@joshtriplett.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: Correct kernel-doc inconsistency
Message-ID: <20200719213339.GN9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200719210533.152080-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719210533.152080-1-colton.w.lewis@protonmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 19, 2020 at 09:05:40PM +0000, Colton Lewis wrote:
> Silence documentation build warnings by correcting kernel-doc comment
> for rcu_nmi_enter function and kfree_rcu_cpu struct.
> 
> ./kernel/rcu/tree.c:969: warning: Excess function parameter 'irq' description in 'rcu_nmi_enter'
> ./kernel/rcu/tree.c:3024: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
> 
> Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>

Good eyes, but someone beat you to this one, and the patch is queued
in -rcu.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6c6569e0586c..f38a51b96027 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -954,7 +954,6 @@ void __rcu_irq_enter_check_tick(void)
>  
>  /**
>   * rcu_nmi_enter - inform RCU of entry to NMI context
> - * @irq: Is this call from rcu_irq_enter?
>   *
>   * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
>   * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
> @@ -3004,6 +3003,7 @@ struct kfree_rcu_cpu_work {
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
>   * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
>   * @initialized: The @lock and @rcu_work fields have been initialized
> + * @count: number of objects for which GP is not started
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
>   * the rcu_data structure is to permit this code to be extracted from
> @@ -3019,7 +3019,6 @@ struct kfree_rcu_cpu {
>  	struct delayed_work monitor_work;
>  	bool monitor_todo;
>  	bool initialized;
> -	// Number of objects for which GP not started
>  	int count;
>  };
>  
> -- 
> 2.26.2
> 
> 
