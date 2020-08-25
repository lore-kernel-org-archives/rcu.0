Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A71C433DF
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 20:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CE52074A
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598386436;
	bh=AKpUwXbrvLHVdIrs1d1s9f5rMKCIf8DxBfGkM26WAbM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TnFJV4llBxC7cGaOmuLZPFjd6I4KZpeqcQgMYyMltiOng8nznuIHDCc9jAuG4JOVK
	 u/rerwSC9Wse5xTXhZlIsecaRsXWzyh1KjkspaKwQL3Iut0gxN3rx2f1tV7RqxD+ob
	 77mUBdv+sFXE1YA8X+zD5OtvlOHwU2oZ/t7Hniok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHYUN4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYUN4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 16:13:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813D220738;
        Tue, 25 Aug 2020 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598386435;
        bh=AKpUwXbrvLHVdIrs1d1s9f5rMKCIf8DxBfGkM26WAbM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EEOc6Dfw6VquQL7OMVibtTzxHXT9ts/F+dcrk71UOtFuhnp99SpAL5rAHxOD9o+7R
         25/Yj8RGZyVH6GkO69UO9zaXlc0GlE54y1kklT32A4bJYt3n6U0LeBtVHIwrcEeTzQ
         iV1GJDmmnE295TAaM7CMfj8yvsWA7b0pVouV2fkY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3B7EC35226AE; Tue, 25 Aug 2020 13:13:55 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:13:55 -0700
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
Subject: Re: [PATCH v4 -rcu 2/4] rcu/tree: Make rcu_do_batch count how many
 callbacks were executed
Message-ID: <20200825201355.GX2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825024842.3408659-3-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 24, 2020 at 10:48:40PM -0400, Joel Fernandes (Google) wrote:
> Currently, rcu_do_batch() depends on the unsegmented callback list's len field
> to know how many CBs are executed. This fields counts down from 0 as CBs are
> dequeued.  It is possible that all CBs could not be run because of reaching
> limits in which case the remaining unexecuted callbacks are requeued in the
> CPU's segcblist.

Again, please mention why the ->cblist.len fields are preserved, namely
due to interactions with rcu_barrier().

> The number of callbacks that were not requeued are then the negative count (how
> many CBs were run) stored in the rcl->len which has been counting down on every
> dequeue. This negative count is then added to the per-cpu segmented callback
> list's to correct its count.
> 
> Such a design works against future efforts to track the length of each segment
> of the segmented callback list. The reason is because
> rcu_segcblist_extract_done_cbs() will have to store the length of the callback
> list in rcl->len to make rcu_segcblist_merge() work.
> 
> Also, the design of counting down from 0 is confusing and error-prone IMHO.
> 
> This commit therefore explicitly counts have many callbacks were executed in
> rcu_do_batch() itself, and uses that to update the per-CPU segcb list's len
> field, without relying on the negativity of rcl->len.

This last, as noted in response to 1/4, should allow rcu_segcblist_merge()
to avoid carrying the callback count separately.

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 2 +-
>  kernel/rcu/rcu_segcblist.h | 1 +
>  kernel/rcu/tree.c          | 9 ++++-----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index b70d4154433c..076337ae2e50 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -95,7 +95,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>   * This increase is fully ordered with respect to the callers accesses
>   * both before and after.
>   */
> -static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
> +void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	smp_mb__before_atomic(); /* Up to the caller! */
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 5c293afc07b8..b90725f81d77 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -76,6 +76,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
>  }
>  
>  void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
> +void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
>  void rcu_segcblist_init(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 548404489c04..51348144a4ea 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2419,7 +2419,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  			       rcu_segcblist_is_offloaded(&rdp->cblist);
>  	struct rcu_head *rhp;
>  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
> -	long bl, count;
> +	long bl, count = 0;
>  	long pending, tlimit = 0;
>  
>  	/* If no callbacks are ready, just return. */
> @@ -2464,6 +2464,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>  		rcu_callback_t f;
>  
> +		count++;
>  		debug_rcu_head_unqueue(rhp);
>  
>  		rcu_lock_acquire(&rcu_callback_map);
> @@ -2477,9 +2478,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  
>  		/*
>  		 * Stop only if limit reached and CPU has something to do.
> -		 * Note: The rcl structure counts down from zero.
>  		 */
> -		if (-rcl.len >= bl && !offloaded &&
> +		if (count >= bl && !offloaded &&
>  		    (need_resched() ||
>  		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
>  			break;

Please also replace "-rcl.len" in this if statement with "count":

			/* only call local_clock() every 32 callbacks */
			if (likely((-rcl.len & 31) || local_clock() < tlimit))
				continue;
			/* Exceeded the time limit, so leave. */
			break;

Yeah, it does work either way, but having "count" consistently throughout
is easier on the people reading the code.  And I haven't heard many
complaints about the code being too easy to read...

							Thanx, Paul

> @@ -2502,7 +2502,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  
>  	local_irq_save(flags);
>  	rcu_nocb_lock(rdp);
> -	count = -rcl.len;
>  	rdp->n_cbs_invoked += count;
>  	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
>  			    is_idle_task(current), rcu_is_callbacks_kthread());
> @@ -2510,7 +2509,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	/* Update counts and requeue any remaining callbacks. */
>  	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
>  	smp_mb(); /* List handling before counting for rcu_barrier(). */
> -	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
> +	rcu_segcblist_add_len(&rdp->cblist, -count);
>  
>  	/* Reinstate batch limit if we have worked down the excess. */
>  	count = rcu_segcblist_n_cbs(&rdp->cblist);
> -- 
> 2.28.0.297.g1956fa8f8d-goog
> 
