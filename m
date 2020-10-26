Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F308C4363A
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 11:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28CA24650
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 11:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603711489;
	bh=MQ0/v4M+9um/4CqtMyy96DyV1IDJAihnw27n13nKzG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hk6p6p5+L0wl4l4bqW5GCGtfPl5VJqTf3WGNgIkZ0uCZXdGv0rrVs3GHAhBKsz4OL
	 Ep5W2/xG1CWuc0PPjJMJrRSibY94Hlu/QiE6Ym6PrRPaHQXz2Rdob/qL0X8VnBJdUf
	 IImX0EVeAxp9aoT6buZr3pBCEO9wj82T0RGG9VoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773739AbgJZLYt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Oct 2020 07:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770047AbgJZLYt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Oct 2020 07:24:49 -0400
Received: from localhost (unknown [176.177.109.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 044BB2464E;
        Mon, 26 Oct 2020 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603711488;
        bh=MQ0/v4M+9um/4CqtMyy96DyV1IDJAihnw27n13nKzG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Brhj/SV313c9F6doqs8u0xyghwgifcl9lJ6EOnn1VpJKiSxmL1dFeiMYpkeZUX5AM
         kZS761u1cBN88PUvyyHdLYdmAlE7NWQ35ydz7+4qn5ZrvbMDOqUuCwR0n4nlNRLLSw
         XjvWGHbrIKfxKlcTNw7TmNpoUq+vpQKGPeaNpllg=
Date:   Mon, 26 Oct 2020 12:24:45 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v8 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201026112445.GC104441@lothringen>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-3-joel@joelfernandes.org>
 <20201026003212.GA104441@lothringen>
 <20201026054043.GA4192074@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026054043.GA4192074@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 26, 2020 at 01:40:43AM -0400, Joel Fernandes wrote:
> On Mon, Oct 26, 2020 at 01:32:12AM +0100, Frederic Weisbecker wrote:
> > You seem to have forgotten the suggestion?
> > 
> >     rclp->len += rcu_segcblist_get_seglen(rsclp, i)
> 
> I decided to keep it this way as I did not see how it could be better.
> You mentioned you are Ok with either option so I left it as is.
> 
> Thanks!

Fair enough!

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0f23d20d485a..79b7081143a7 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1160,6 +1160,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
>   */
>  static void srcu_invoke_callbacks(struct work_struct *work)
>  {
> +	long len;
>  	bool more;
>  	struct rcu_cblist ready_cbs;
>  	struct rcu_head *rhp;
> @@ -1182,6 +1183,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  	/* We are on the job!  Extract and invoke ready callbacks. */
>  	sdp->srcu_cblist_invoking = true;
>  	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
> +	len = ready_cbs.len;
>  	spin_unlock_irq_rcu_node(sdp);
>  	rhp = rcu_cblist_dequeue(&ready_cbs);
>  	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
> @@ -1190,13 +1192,14 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  		rhp->func(rhp);
>  		local_bh_enable();
>  	}
> +	WARN_ON_ONCE(ready_cbs.len);
>  
>  	/*
>  	 * Update counts, accelerate new callbacks, and if needed,
>  	 * schedule another round of callback invocation.
>  	 */
>  	spin_lock_irq_rcu_node(sdp);
> -	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
> +	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
>  	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
>  				       rcu_seq_snap(&ssp->srcu_gp_seq));
>  	sdp->srcu_cblist_invoking = false;

Looks good! Thanks.
