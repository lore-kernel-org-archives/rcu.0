Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EBC433DF
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 12:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3CC22249
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602764522;
	bh=FJ5bTk8vf5rV2RhefNs+cKOPow5fLZ9ShzXDYcMU0Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o/0Z17RRqONYRtqrXp0xH2OtApckud8MXUn5jDjtCBmEfej3mhz8CWOff5dK2hnbg
	 gAQ/CDmWZ5fsYEQ0ZBwaAvlaNDjzJuOQGsTYRbusfJ8SOpyOG+99npP2wksOKEUwRK
	 6gP73zCX/Ar8zS5AXnvjShTGMQpdvb0VjaUGMy10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgJOMWC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Oct 2020 08:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgJOMWC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Oct 2020 08:22:02 -0400
Received: from localhost (unknown [176.167.119.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961CD2223F;
        Thu, 15 Oct 2020 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602764521;
        bh=FJ5bTk8vf5rV2RhefNs+cKOPow5fLZ9ShzXDYcMU0Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pa85ZkyCCX2heoe3Z8r5WFhi7yQI3+LAHzaKfoDL/lPCiYqPZseTMb4XKnVZ3AK1r
         Zf38As7NK4Cx5huWyhs3N9wARTPiQEBpc8W0iPCZMAhxBhns6tvZLaGzWlfMge5OuZ
         BXNaIGaF4/AWKru938FF6+b2WOaTgDf45PUsov4E=
Date:   Thu, 15 Oct 2020 14:21:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v7 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201015122158.GA127222@lothringen>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015002301.101830-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 14, 2020 at 08:22:57PM -0400, Joel Fernandes (Google) wrote:
> Add counting of segment lengths of segmented callback list.
> 
> This will be useful for a number of things such as knowing how big the
> ready-to-execute segment have gotten. The immediate benefit is ability
> to trace how the callbacks in the segmented callback list change.
> 
> Also this patch remove hacks related to using donecbs's ->len field as a
> temporary variable to save the segmented callback list's length. This cannot be
> done anymore and is not needed.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/rcu_segcblist.h |   2 +
>  kernel/rcu/rcu_segcblist.c    | 133 +++++++++++++++++++++++-----------
>  kernel/rcu/rcu_segcblist.h    |   2 -
>  3 files changed, 92 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> index b36afe7b22c9..d462ae5e340a 100644
> --- a/include/linux/rcu_segcblist.h
> +++ b/include/linux/rcu_segcblist.h
> @@ -69,8 +69,10 @@ struct rcu_segcblist {
>  	unsigned long gp_seq[RCU_CBLIST_NSEGS];
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	atomic_long_t len;
> +	atomic_long_t seglen[RCU_CBLIST_NSEGS];

Also does it really need to be atomic?

> @@ -245,7 +280,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
>  			   struct rcu_head *rhp)
>  {
>  	rcu_segcblist_inc_len(rsclp);
> -	smp_mb(); /* Ensure counts are updated before callback is enqueued. */

That's a significant change that shouldn't be hidden and unexplained in an unrelated
patch or it may be easily missed. I'd suggest to move this line together in
"rcu/tree: Remove redundant smp_mb() in rcu_do_batch" (with the title updated perhaps)
and maybe put it in the beginning of the series?

> +	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
>  	rhp->next = NULL;
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
>  	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
[...]
> @@ -330,11 +353,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rcu_segcblist_pend_cbs(rsclp))
>  		return; /* Nothing to do. */
> +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
>  	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
>  	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
>  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> -	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
> +	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
>  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
> +		rcu_segcblist_set_seglen(rsclp, i, 0);
> +	}

So, that's probably just a matter of personal preference, so feel free to
ignore but I'd rather do:

    rclp->len += rcu_segcblist_get_seglen(rsclp, i);
    rcu_segcblist_set_seglen(rsclp, i, 0);

instead of the big addition above. That way, if a new index ever gets added/renamed
to the segcblist, we'll take it into account. Also that spares a few lines.

Thanks.
