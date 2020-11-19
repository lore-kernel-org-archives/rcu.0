Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD5C56201
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C565246A7
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 18:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmdG7jJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgKSSMh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 13:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgKSSMg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 13:12:36 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8D72225B;
        Thu, 19 Nov 2020 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605809556;
        bh=BQglaJdKNtKWX2Zk4RYXa7mU1pwvbWzO/F2vKmVQHAI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TmdG7jJCw4y5pRWzc6q4L+fJvWD1Th+9C1p416Qbbde86cU1ehvrTyntyeRV9kcGj
         wAtN0nAJJK+BuM6QWfojq2DZgINmG78FggOYR0GtYoGm/ovdxYd4CD8DkkVfeX0Jiq
         ViP6s54Ik1QQrPKcR0fslFFawiZPXjssr5sl5jGI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C2B6035225CF; Thu, 19 Nov 2020 10:12:35 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:12:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     jiangshanlai@gmail.com, rostedt@goodmis.org, josh@joshtriplett.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Remove srcu_cblist_invoking member from sdp
Message-ID: <20201119181235.GX1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201119053411.11698-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119053411.11698-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 01:34:11PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> Workqueue can ensure the multiple same sdp->work sequential
> execution in rcu_gp_wq, not need srcu_cblist_invoking to
> prevent concurrent execution, so remove it.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Good job analyzing the code, which is very good to see!!!

But these do have a potential purpose.  Right now, it is OK to invoke
synchronize_srcu() during early boot, that is, before the scheduler
has started.  But there is a gap from the time that the scheduler has
initialized (so that preemption and blocking are possible) and the time
that workqueues are initialized and fully functional.  Only after that
is it once again OK to use synchronize_srcu().

If synchronize_srcu() is ever required to work correctly during that
time period, it will need to directly invoke the functions that are
currently run in workqueue context.  Which means that there will then be
the possibility of two instances of these functions running just after
workqueues are available.

							Thanx, Paul

> ---
>  include/linux/srcutree.h | 1 -
>  kernel/rcu/srcutree.c    | 8 ++------
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 9cfcc8a756ae..62d8312b5451 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -31,7 +31,6 @@ struct srcu_data {
>  	struct rcu_segcblist srcu_cblist;	/* List of callbacks.*/
>  	unsigned long srcu_gp_seq_needed;	/* Furthest future GP needed. */
>  	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
> -	bool srcu_cblist_invoking;		/* Invoking these CBs? */
>  	struct timer_list delay_work;		/* Delay for CB invoking */
>  	struct work_struct work;		/* Context for CB invoking. */
>  	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 3c5e2806e0b9..c4d5cd2567a6 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -134,7 +134,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
>  		sdp = per_cpu_ptr(ssp->sda, cpu);
>  		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
>  		rcu_segcblist_init(&sdp->srcu_cblist);
> -		sdp->srcu_cblist_invoking = false;
>  		sdp->srcu_gp_seq_needed = ssp->srcu_gp_seq;
>  		sdp->srcu_gp_seq_needed_exp = ssp->srcu_gp_seq;
>  		sdp->mynode = &snp_first[cpu / levelspread[level]];
> @@ -1254,14 +1253,11 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  	spin_lock_irq_rcu_node(sdp);
>  	rcu_segcblist_advance(&sdp->srcu_cblist,
>  			      rcu_seq_current(&ssp->srcu_gp_seq));
> -	if (sdp->srcu_cblist_invoking ||
> -	    !rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
> +	if (!rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
>  		spin_unlock_irq_rcu_node(sdp);
>  		return;  /* Someone else on the job or nothing to do. */
>  	}
>  
> -	/* We are on the job!  Extract and invoke ready callbacks. */
> -	sdp->srcu_cblist_invoking = true;
>  	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
>  	len = ready_cbs.len;
>  	spin_unlock_irq_rcu_node(sdp);
> @@ -1282,7 +1278,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
>  	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
>  				       rcu_seq_snap(&ssp->srcu_gp_seq));
> -	sdp->srcu_cblist_invoking = false;
> +
>  	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
>  	spin_unlock_irq_rcu_node(sdp);
>  	if (more)
> -- 
> 2.17.1
> 
