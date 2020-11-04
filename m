Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1A7C388F9
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 00:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17671223C6
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 00:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604448357;
	bh=KZ6By4TUfVUgQ/D4nmd6klO+Ho7DgbM92Y0TRb1lyGw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=acWYlOa3ff1brumW8YlRX+I9E9Xrk10YiGItvbyk9CZidLEzsxUEnwdAR00JRddyA
	 KO2g1IyNatBA6nRdHqAWNI3TBNKGMT+k1bZQ7+2LZp7kwwBGOxzXpLP9IkN2JQpZhg
	 1124Vko8igfLlC5f4jEvvESgKhkMzVIZW8ZYTGc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgKDAF4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 19:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbgKDAFz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 19:05:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D483D223BD;
        Wed,  4 Nov 2020 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604448354;
        bh=KZ6By4TUfVUgQ/D4nmd6klO+Ho7DgbM92Y0TRb1lyGw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pl1XoOMkN8m5IwRwgIRc9JBtjNijN8KaAgcOw6gblZkJg6ARjKvVVNOrtxO+gqpLE
         3GMaabVmFV5qQhJIfS/iM9/+SYUw9Ev9c3b7uIh4dAQfl38vpLL2BqwQSkxWpCw/Yp
         ynPkxWU5PmOVNgFADfOBUnsO3YXMF2aT7Kqw8F2k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9B3CF3522ABD; Tue,  3 Nov 2020 16:05:54 -0800 (PST)
Date:   Tue, 3 Nov 2020 16:05:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 1/7] rcu/tree: Make rcu_do_batch count how many
 callbacks were executed
Message-ID: <20201104000554.GF3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103142603.1302207-2-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 09:25:57AM -0500, Joel Fernandes (Google) wrote:
> Currently, rcu_do_batch() depends on the unsegmented callback list's len field
> to know how many CBs are executed. This fields counts down from 0 as CBs are
> dequeued.  It is possible that all CBs could not be run because of reaching
> limits in which case the remaining unexecuted callbacks are requeued in the
> CPU's segcblist.
> 
> The number of callbacks that were not requeued are then the negative count (how
> many CBs were run) stored in the rcl->len which has been counting down on every
> dequeue. This negative count is then added to the per-cpu segmented callback
> list's to correct its count.
> 
> Such a design works against future efforts to track the length of each segment
> of the segmented callback list. The reason is because
> rcu_segcblist_extract_done_cbs() will be populating the unsegmented callback
> list's length field (rcl->len) during extraction.
> 
> Also, the design of counting down from 0 is confusing and error-prone IMHO.
> 
> This commit therefore explicitly counts how many callbacks were executed in
> rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
> field, without relying on the negativity of rcl->len.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued for testing and further review, thank you all!

I will be pulling these in as I look them over, and running tests
in between times, so this will take some time.

As usual, I could not resist editing the commit log, so please
see below to check whether I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit d77ef2684cbff728c14b3c84a356139c52ca3a5e
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Tue Nov 3 09:25:57 2020 -0500

    rcu/tree: Make rcu_do_batch count how many callbacks were executed
    
    The rcu_do_batch() function extracts the ready-to-invoke callbacks
    from the rcu_segcblist located in the ->cblist field of the current
    CPU's rcu_data structure.  These callbacks are first moved to a local
    (unsegmented) rcu_cblist.  The rcu_do_batch() function then uses this
    rcu_cblist's ->len field to count how many CBs it has invoked, but it
    does so by counting that field down from zero.  Finally, this function
    negates the value in this ->len field (resulting in a positive number)
    and subtracts the result from the ->len field of the current CPU's
    ->cblist field.
    
    Except that it is sometimes necessary for rcu_do_batch() to stop invoking
    callbacks mid-stream, despite there being more ready to invoke, for
    example, if a high-priority task wakes up.  In this case the remaining
    not-yet-invoked callbacks are requeued back onto the CPU's ->cblist,
    but remain in the ready-to-invoke segment of that list.  As above, the
    negative of the local rcu_cblist's ->len field is still subtracted from
    the ->len field of the current CPU's ->cblist field.
    
    The design of counting down from 0 is confusing and error-prone, plus
    use of a positive count will make it easier to provide a uniform and
    consistent API to deal with the per-segment counts that are added
    later in this series.  For example, rcu_segcblist_extract_done_cbs()
    can unconditionally populate the resulting unsegmented list's ->len
    field during extraction.
    
    This commit therefore explicitly counts how many callbacks were executed
    in rcu_do_batch() itself, counting up from zero, and then uses that
    to update the per-CPU segcb list's ->len field, without relying on the
    downcounting of rcl->len from zero.
    
    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
    Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 2d2a6b6b9..bb246d8 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -95,7 +95,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
  */
-static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	smp_mb__before_atomic(); /* Up to the caller! */
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 492262b..1d2d614 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -76,6 +76,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 }
 
 void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b6ec565..c4035e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2436,7 +2436,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
-	long bl, count;
+	long bl, count = 0;
 	long pending, tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
@@ -2481,6 +2481,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
+		count++;
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
@@ -2494,15 +2495,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		/*
 		 * Stop only if limit reached and CPU has something to do.
-		 * Note: The rcl structure counts down from zero.
 		 */
-		if (-rcl.len >= bl && !offloaded &&
+		if (count >= bl && !offloaded &&
 		    (need_resched() ||
 		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
 			break;
 		if (unlikely(tlimit)) {
 			/* only call local_clock() every 32 callbacks */
-			if (likely((-rcl.len & 31) || local_clock() < tlimit))
+			if (likely((count & 31) || local_clock() < tlimit))
 				continue;
 			/* Exceeded the time limit, so leave. */
 			break;
@@ -2519,7 +2519,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
-	count = -rcl.len;
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
@@ -2527,7 +2526,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
+	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
