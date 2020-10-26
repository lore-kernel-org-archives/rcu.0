Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D5C4363A
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 00:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030F8223FD
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603672336;
	bh=1fHgtDwcojHqfa38+WinzLZz7ns0UEGRw+Xv9WxjUqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tS9VOhw4tx5hug0oHZcvZBVPT1jycIU040PIyKRfOt92ago6nRZWT02D3CJij07i7
	 6vYwCr/t3mjblNWZC0uaQ13uhO8ULS6OhE32lnRL8lyVnwucUq3AaB5q0iESazsTJC
	 E+A0wgUVyZJGpxxcOwuoLisZb4xbqtyzBhLYs0to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420848AbgJZAcP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 25 Oct 2020 20:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1420846AbgJZAcP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 25 Oct 2020 20:32:15 -0400
Received: from localhost (unknown [176.177.109.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF41223EA;
        Mon, 26 Oct 2020 00:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603672335;
        bh=1fHgtDwcojHqfa38+WinzLZz7ns0UEGRw+Xv9WxjUqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vy9K02XtGXOQ19O0GUpllZFIBUvHsEbMknzslJu8tRTgwcaMJ1jg8yPDN0fma0gOC
         l1k/epX1A8JHT5dcwimx5/L9yLUY2KMmcbk5/4JMR2irV1+CScaTtYuRdhuEIouWW9
         4cIFjgTfg4tOIlCPHn4ZFXF/onrxqa4YNRNyZiuw=
Date:   Mon, 26 Oct 2020 01:32:12 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <20201026003212.GA104441@lothringen>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021190813.3005054-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 21, 2020 at 03:08:09PM -0400, Joel Fernandes (Google) wrote:
> @@ -307,6 +317,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rcu_segcblist_ready_cbs(rsclp))
>  		return; /* Nothing to do. */
> +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);

I realize, doesn't it break the unsegmented count in srcu_invoke_callbacks() ?

It still does rcu_segcblist_insert_count(), so it adds zero to rsclp->len
which thus doesn't get cleared and probably keeps growing.

At least srcu_barrier() relies on it. And module exit should warn.

>  	*rclp->tail = rsclp->head;
>  	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
>  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> @@ -314,6 +325,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
>  		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
>  			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
> +	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
>  }
>  
>  /*
> @@ -330,11 +342,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
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

You seem to have forgotten the suggestion?

    rclp->len += rcu_segcblist_get_seglen(rsclp, i)


Thanks.
