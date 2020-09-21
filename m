Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A945FC43465
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6562520874
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600702453;
	bh=Qfz/osnh0nifGLXC37WqN1bCZaz5T5g6Ftq3vatCeU0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mkgUz+ZJrtkHZkKyW+nr8CcYcJAUr33W4MTNR2yq5IQPLNLym1WQVBS9G8dNw/z+H
	 SmCYo9KjWmEtmE70Xmev4fCq03TYORnrhCyUdPw4t5/QWcmOFM1KkQRl41o5C1bgMF
	 UOAoIKrdByqVMa7kJ5EibEmDjJr/7VtU4H8eYII4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgIUPeN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 11:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIUPeN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 11:34:13 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3824620866;
        Mon, 21 Sep 2020 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702452;
        bh=Qfz/osnh0nifGLXC37WqN1bCZaz5T5g6Ftq3vatCeU0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fqCCBh1O572AsYzhfAKEIVEAKyLffBs/V23FRxIyITsxODjYJKVffaASkeIhuEeBi
         K0sRpKvauMmLp+SrJIpN1DdG++wAmfMdSwq+D5GTM+93HhU+vCIPyGNKuK29CYEQBt
         ayUKSfV3W+oaYnUX2IB4f50chbLyPsjyuA74tmNU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 00720352303A; Mon, 21 Sep 2020 08:34:11 -0700 (PDT)
Date:   Mon, 21 Sep 2020 08:34:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [RFC v5 0/5] Add support length of each segment in the segcblist
 (breaks TREE04)
Message-ID: <20200921153411.GA8734@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921012152.2831904-1-joel@joelfernandes.org>
 <20200921020625.GA2930323@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921020625.GA2930323@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 20, 2020 at 10:06:25PM -0400, Joel Fernandes wrote:
> On Sun, Sep 20, 2020 at 09:21:47PM -0400, Joel Fernandes (Google) wrote:
> > 
> > NOTE: I marked as RFC since TREE 04 fails even though TREE03 passes. I don't
> > see any RCU errors in the counters, however when shutdown thread tries to
> > shutdown the system, it hangs when trying to shutdown the rcu_barrier thread.
> 
> Looks like if I restore the logic of setting the segcb_list ->len field from
> the callers of extract_done_cbs(), then TREE04 issues go away. I am inclined
> to do that considering this series, for what it is trying to do, does not
> really need to optimize that logic (can be done later).
> 
> With the below diff on top of this series, TREE04 passes. I will await any
> other review comments before posting another series.. meanwhile, will pass
> it through the grinders..

As discussed on IRC, I will await v6.

							Thanx, Paul

> ---8<---
> diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> index 319a565f6ecb..d462ae5e340a 100644
> --- a/include/linux/rcu_segcblist.h
> +++ b/include/linux/rcu_segcblist.h
> @@ -76,7 +76,6 @@ struct rcu_segcblist {
>  #endif
>  	u8 enabled;
>  	u8 offloaded;
> -	u8 invoking;
>  };
>  
>  #define RCU_SEGCBLIST_INITIALIZER(n) \
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index ec9a609a461b..3c82c016feb1 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -388,7 +388,6 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
>  			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
>  	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> -	rcu_segcblist_add_len(rsclp, -(rclp->len));
>  }
>  
>  /*
> @@ -452,7 +451,17 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
>  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
>  		rcu_segcblist_set_seglen(rsclp, i, 0);
>  	}
> -	rcu_segcblist_add_len(rsclp, -(rclp->len));
> +}
> +
> +/*
> + * Insert counts from the specified rcu_cblist structure in the
> + * specified rcu_segcblist structure.
> + */
> +void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
> +				struct rcu_cblist *rclp)
> +{
> +	rcu_segcblist_add_len(rsclp, rclp->len);
> +	rclp->len = 0;
>  }
>  
>  /*
> @@ -476,7 +485,6 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
>  			break;
>  	rclp->head = NULL;
>  	rclp->tail = &rclp->head;
> -	rcu_segcblist_add_len(rsclp, rclp->len);
>  }
>  
>  /*
> @@ -492,7 +500,6 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
>  	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
>  	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
> -	rcu_segcblist_add_len(rsclp, rclp->len);
>  }
>  
>  /*
> @@ -637,9 +644,12 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
>  	rcu_cblist_init(&donecbs);
>  	rcu_cblist_init(&pendcbs);
>  
> +	rcu_segcblist_set_len(src_rsclp, 0);
>  	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
>  	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
>  
> +	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
> +	rcu_segcblist_insert_count(dst_rsclp, &pendcbs);
>  	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
>  	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
>  
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index c2dc08a9b020..15c10d30f88c 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -40,33 +40,14 @@ static inline bool rcu_segcblist_empty(struct rcu_segcblist *rsclp)
>  	return !READ_ONCE(rsclp->head);
>  }
>  
> -static inline void rcu_segcblist_set_invoking(struct rcu_segcblist *rsclp)
> -{
> -	WRITE_ONCE(rsclp->invoking, 1);
> -}
> -
> -static inline void rcu_segcblist_reset_invoking(struct rcu_segcblist *rsclp)
> -{
> -	WRITE_ONCE(rsclp->invoking, 0);
> -}
> -
>  /* Return number of callbacks in segmented callback list. */
>  static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
>  {
> -	long ret;
>  #ifdef CONFIG_RCU_NOCB_CPU
> -	ret = atomic_long_read(&rsclp->len);
> +	return atomic_long_read(&rsclp->len);
>  #else
> -	ret = READ_ONCE(rsclp->len);
> +	return READ_ONCE(rsclp->len);
>  #endif
> -
> -	/*
> -	 * An invoking list should not appear empty. This is required
> -	 * by rcu_barrier().
> -	 */
> -	if (ret)
> -		return ret;
> -	return (READ_ONCE(rsclp->invoking) ? 1 : 0);
>  }
>  
>  /*
> @@ -112,6 +93,8 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  				    struct rcu_cblist *rclp);
>  void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
>  				    struct rcu_cblist *rclp);
> +void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
> +				struct rcu_cblist *rclp);
>  void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
>  				   struct rcu_cblist *rclp);
>  void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 62b83fb997ee..0f23d20d485a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1196,6 +1196,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  	 * schedule another round of callback invocation.
>  	 */
>  	spin_lock_irq_rcu_node(sdp);
> +	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
>  	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
>  				       rcu_seq_snap(&ssp->srcu_gp_seq));
>  	sdp->srcu_cblist_invoking = false;
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b4dc18e4661c..64dff7b17e74 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2465,7 +2465,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	}
>  	trace_rcu_batch_start(rcu_state.name,
>  			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
> -	rcu_segcblist_set_invoking(&rdp->cblist);
>  	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
>  	if (offloaded)
>  		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> @@ -2524,9 +2523,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  
>  	/* Update counts and requeue any remaining callbacks. */
>  	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
> -
> -	smp_mb();
> -	rcu_segcblist_reset_invoking(&rdp->cblist);
> +	smp_mb(); /* List handling before counting for rcu_barrier(). */
> +	rcu_segcblist_add_len(&rdp->cblist, -count);
>  
>  	/* Reinstate batch limit if we have worked down the excess. */
>  	count = rcu_segcblist_n_cbs(&rdp->cblist);
