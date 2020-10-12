Return-Path: <SRS0=R7PL=DT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02699C433E7
	for <rcu@archiver.kernel.org>; Mon, 12 Oct 2020 23:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFD920838
	for <rcu@archiver.kernel.org>; Mon, 12 Oct 2020 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602544812;
	bh=FR/XhIiRDNVQjTauUtYXk48qWpsYZADdnNm8X2ctaWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2iVXR3+WS83iOoEjhAWgI8kor3UAqxs+2ylek+TY2oljK/xhYLvGXSxZpe3snFRVW
	 pYG1VKJvTzNBa440JyRdDxzAonWCaKM5u14ivKJfUGa5kURqjckCpFYpvZ8/81+8+P
	 jcBCcBqEoEvmQnS6eANXrha6gHgMBXfs0d0bYmpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgJLXUM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Oct 2020 19:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgJLXUM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Oct 2020 19:20:12 -0400
Received: from localhost (unknown [176.164.225.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0002076D;
        Mon, 12 Oct 2020 23:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602544811;
        bh=FR/XhIiRDNVQjTauUtYXk48qWpsYZADdnNm8X2ctaWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qq5ShvRN7W/05X85qGJqqh5KHoOF31TRFGWcqUMU7hCKTS+z7FNw/lrg0QDfyPbgZ
         kAGfva6WKdEFbW4jKxwqCP2zXQw8WC18mjuVnaBBNuoy9Zr+JugOpGLA4xsYKHwL6m
         JS93CChPZh5NbdhSG6hIn/uOJT8EWNupH12A9O4Q=
Date:   Tue, 13 Oct 2020 01:20:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v6 2/4] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201012232008.GA47577@lothringen>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923152211.2403352-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 23, 2020 at 11:22:09AM -0400, Joel Fernandes (Google) wrote:
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

I know that these "Up to the caller" comments come from the existing len
functions but perhaps we should explain a bit more against what it is ordering
and what it pairs to.

Also why do we need one before _and_ after?

And finally do we have the same ordering requirements than the unsegmented len
field?

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
> +
> +	rcu_segcblist_add_seglen(rsclp, to, len);
> +	rcu_segcblist_set_seglen(rsclp, from, 0);
> +}
> +
[...]
> @@ -245,6 +283,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
>  			   struct rcu_head *rhp)
>  {
>  	rcu_segcblist_inc_len(rsclp);
> +	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
>  	smp_mb(); /* Ensure counts are updated before callback is enqueued. */

Since inc_len and even now inc_seglen have two full barriers embracing the add up,
we can probably spare the above smp_mb()?

>  	rhp->next = NULL;
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> @@ -274,27 +313,13 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
>  	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
>  		if (rsclp->tails[i] != rsclp->tails[i - 1])
>  			break;
> +	rcu_segcblist_inc_seglen(rsclp, i);
>  	WRITE_ONCE(*rsclp->tails[i], rhp);
>  	for (; i <= RCU_NEXT_TAIL; i++)
>  		WRITE_ONCE(rsclp->tails[i], &rhp->next);
>  	return true;
>  }
>  
> @@ -403,6 +437,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>  		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
>  			break;
>  		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
> +		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);

Do we still need the same amount of full barriers contained in add() called by move() here?
It's called in the reverse order (write queue then len) than usual. If I trust the comment
in rcu_segcblist_enqueue(), the point of the barrier is to make the length visible before
the new callback for rcu_barrier() (although that concerns len and not seglen). But here
above, the unsegmented length doesn't change. I could understand a write barrier between
add_seglen(x, i) and set_seglen(0, RCU_DONE_TAIL) but I couldn't find a paired couple either.

>  	}
>  
>  	/* If no callbacks moved, nothing more need be done. */
> @@ -423,6 +458,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>  		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
>  			break;  /* No more callbacks. */
>  		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> +		rcu_segcblist_move_seglen(rsclp, i, j);

Same question here (feel free to reply "same answer" :o)

Thanks!
