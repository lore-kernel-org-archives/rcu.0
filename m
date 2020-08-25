Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82930C433DF
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5249720738
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598392421;
	bh=PesKYuOk2D7EIffrXsGH/Ljt5CN9DaXoJN6O4Ma60G4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=DH+1ukRx1MNtM/8qHWXARx6VqZjKfYjbAOaFHTXccZCM4o5GChyWivF4afwzIt9Kn
	 5Zun5NArpBECyPhsefvIqnO2ia9rSms/XveB64pfoYiJlu9tJqxzPhZVQZEdq7Rd1I
	 oFFRv+pjBgAb4+dLibNsLfSp33HtKScy2VpKdQLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHYVxk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHYVxj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 17:53:39 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4862071E;
        Tue, 25 Aug 2020 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598392418;
        bh=PesKYuOk2D7EIffrXsGH/Ljt5CN9DaXoJN6O4Ma60G4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ix/0ssCzLs/WbI0JtiHwyJ1LeSpM4MabIi4QepUXlwFcYzBRLLqJYJWceDM7mekmx
         q+oaIpsGT8v8e28GZzg6satLNnmp2o2V8lfbGtp4nGs/WZuekHZ9F+0ruISkZUr5cn
         tP1zzKH6mr41RwDd2aiAtRvGBkkhZXmZpFNSFWfQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6A2AE352304D; Tue, 25 Aug 2020 14:53:38 -0700 (PDT)
Date:   Tue, 25 Aug 2020 14:53:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 3/4] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200825215338.GA16846@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825024842.3408659-4-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 24, 2020 at 10:48:41PM -0400, Joel Fernandes (Google) wrote:
> Add counting of segment lengths of segmented callback list.
> 
> This will be useful for a number of things such as knowing how big the
> ready-to-execute segment have gotten. The immediate benefit is ability
> to trace how the callbacks in the segmented callback list change.
> 
> Tested by profusely reading traces when segcblist counts updated.

Might I recommend a more repeatable and sustainable test methodology?
(Sorry, couldn't resist, given that you left yourself wide open for
that one...)

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/rcu_segcblist.h |  2 +
>  kernel/rcu/rcu_segcblist.c    | 82 +++++++++++++++++++++++++++++++++--
>  2 files changed, 81 insertions(+), 3 deletions(-)
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

What are the guarantees for access to seglen?

I get that the possibility of RCU callback offloading means that you
need atomic_long_t, but presumably you are only guaranteeing coherent
lockless access to the individual elements of the array, rather than
any coherent relationship among them or with ->len.  Anything surprising
should go in the header comment blocks of the access functions.

And in case someone thinks that atomic_t would suffice, I have in the past
had list with in excess of 30M callbacks without RCU CPU stall warnings,
so 2B is not as large a number as you might think.

>  #else
>  	long len;
> +	long seglen[RCU_CBLIST_NSEGS];
>  #endif
>  	u8 enabled;
>  	u8 offloaded;
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 076337ae2e50..73a103464ea4 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -88,6 +88,62 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>  #endif
>  }
>  
> +/* Get the length of a segment of the rcu_segcblist structure. */
> +static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
> +{
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	return atomic_long_read(&rsclp->seglen[seg]);
> +#else
> +	return READ_ONCE(rsclp->seglen[seg]);
> +#endif
> +}
> +
> +/* Set the length of a segment of the rcu_segcblist structure. */
> +static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> +{
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	atomic_long_set(&rsclp->seglen[seg], v);
> +#else
> +	WRITE_ONCE(rsclp->seglen[seg], v);
> +#endif
> +}
> +
> +/* Return number of callbacks in a segment of the segmented callback list. */
> +static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> +{
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	smp_mb__before_atomic(); /* Up to the caller! */
> +	atomic_long_add(v, &rsclp->seglen[seg]);
> +	smp_mb__after_atomic(); /* Up to the caller! */
> +#else
> +	smp_mb(); /* Up to the caller! */
> +	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
> +	smp_mb(); /* Up to the caller! */
> +#endif
> +}
> +
> +/* Move from's segment length to to's segment. */
> +static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
> +{
> +	long len;
> +
> +	if (from == to)
> +		return;
> +
> +	len = rcu_segcblist_get_seglen(rsclp, from);
> +	if (!len)
> +		return;

You don't need the blank lines on this small a function.

> +	rcu_segcblist_add_seglen(rsclp, to, len);
> +	rcu_segcblist_set_seglen(rsclp, from, 0);
> +}
> +
> +/* Increment segment's length. */
> +static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
> +{
> +	rcu_segcblist_add_seglen(rsclp, seg, 1);
> +}
> +
>  /*
>   * Increase the numeric length of an rcu_segcblist structure by the
>   * specified amount, which can be negative.  This can cause the ->len
> @@ -149,8 +205,10 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
>  	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
>  	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
>  	rsclp->head = NULL;
> -	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
>  		rsclp->tails[i] = &rsclp->head;
> +		rcu_segcblist_set_seglen(rsclp, i, 0);
> +	}
>  	rcu_segcblist_set_len(rsclp, 0);
>  	rsclp->enabled = 1;
>  }
> @@ -245,6 +303,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
>  			   struct rcu_head *rhp)
>  {
>  	rcu_segcblist_inc_len(rsclp);
> +	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
>  	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
>  	rhp->next = NULL;
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> @@ -274,6 +333,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
>  	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
>  		if (rsclp->tails[i] != rsclp->tails[i - 1])
>  			break;
> +	rcu_segcblist_inc_seglen(rsclp, i);
>  	WRITE_ONCE(*rsclp->tails[i], rhp);
>  	for (; i <= RCU_NEXT_TAIL; i++)
>  		WRITE_ONCE(rsclp->tails[i], &rhp->next);
> @@ -307,6 +367,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rcu_segcblist_ready_cbs(rsclp))
>  		return; /* Nothing to do. */
> +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
>  	*rclp->tail = rsclp->head;
>  	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
>  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> @@ -314,6 +375,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
>  		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
>  			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
> +	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
>  }
>  
>  /*
> @@ -330,11 +392,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rcu_segcblist_pend_cbs(rsclp))
>  		return; /* Nothing to do. */
> +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);

A loop for future-proofness, please.  The compiler will unroll it anyway.
Plus this is nowhere near a fastpath.

>  	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
>  	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
>  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> -	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
> +	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
>  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
> +		rcu_segcblist_set_seglen(rsclp, i, 0);
> +	}
>  }
>  
>  /*
> @@ -359,6 +426,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rclp->head)
>  		return; /* No callbacks to move. */
> +	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
>  	*rclp->tail = rsclp->head;
>  	WRITE_ONCE(rsclp->head, rclp->head);
>  	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
> @@ -379,6 +447,8 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
>  {
>  	if (!rclp->head)
>  		return; /* Nothing to do. */
> +

This only has five lines of code, so the blank line is superfluous.

> +	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
>  	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
>  }
> @@ -403,6 +473,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>  		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
>  			break;
>  		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
> +		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
>  	}
>  
>  	/* If no callbacks moved, nothing more need be done. */
> @@ -423,6 +494,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>  		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
>  			break;  /* No more callbacks. */
>  		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> +		rcu_segcblist_move_seglen(rsclp, i, j);
>  		rsclp->gp_seq[j] = rsclp->gp_seq[i];
>  	}
>  }
> @@ -444,7 +516,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>   */
>  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  {
> -	int i;
> +	int i, j;
>  
>  	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
>  	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> @@ -487,6 +559,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
>  		return false;
>  
> +	/* Accounting: everything below i is about to get merged into i. */

How about "newer than i"?  Many people would think of "below i" as being
numerically less than i, which is not what we need them to think.

> +	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
> +		rcu_segcblist_move_seglen(rsclp, j, i);

I thought about merging the above loop with the next one, but the added
check and the snapshotting of "i" makes it not worthwhile, so please
leave this loop separate, just as you now have it.

							Thanx, Paul

>  	/*
>  	 * Merge all later callbacks, including newly arrived callbacks,
>  	 * into the segment located by the for-loop above.  Assign "seq"
> -- 
> 2.28.0.297.g1956fa8f8d-goog
> 
