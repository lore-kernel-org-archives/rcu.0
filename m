Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85FEC433B4
	for <rcu@archiver.kernel.org>; Mon,  3 May 2021 22:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8955C61186
	for <rcu@archiver.kernel.org>; Mon,  3 May 2021 22:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhECWxH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 May 2021 18:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhECWxH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 May 2021 18:53:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 804B1611AD;
        Mon,  3 May 2021 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620082333;
        bh=5VGVTUJIMUJhrTaq5GAH+lpnw//U4yocmybZf0eQ9mk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GnYTKcS8sswIAW7ePAh/AGgSOkotql7sNG7DYO9CkF5/ACNrBS9HPyZNOEs5Lsvat
         7hul/jw7pLnSP8t4szXEd5OZwoiP1/1PlX7sxz8+EHXqiP1JgFtsKYvBr3BnlH+147
         cXG0yewXSRjJ5fIrznXAmuwPKrYh49HUY8fU3mpKpsvpFLS184WvsHTlRGeLAv0qnT
         K+xN5xS4++LQyN2wSodyG7Odqe2UFArp6bFU3+Mv9c8oCW3gDh+f3WYWQUaK+ni5fH
         nrJkO7FQyqIf38jHNtFkWHlmqmldSaRk98M+pINEo1cb3D67NVW5n7pMBltnyg6r7I
         9VTYTy/a9nObg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 325275C0269; Mon,  3 May 2021 15:52:13 -0700 (PDT)
Date:   Mon, 3 May 2021 15:52:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 4/5] kvfree_rcu: Refactor kfree_rcu_monitor() function
Message-ID: <20210503225213.GA975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210428134422.1894-1-urezki@gmail.com>
 <20210428134422.1894-4-urezki@gmail.com>
 <20210503181214.GA2270@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503181214.GA2270@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 03, 2021 at 08:12:14PM +0200, Uladzislau Rezki wrote:
> Hello, Paul.
> 
> > Rearm the monitor work directly from its own function that
> > is kfree_rcu_monitor(). So this patch puts the invocation
> > timing control in one place.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 35 +++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index e44d6f8c56f0..229e909ad437 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3415,37 +3415,44 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> >  	return !repeat;
> >  }
> >  
> > -static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > -					  unsigned long flags)
> > +/*
> > + * This function queues a new batch. If success or nothing to
> > + * drain it returns 1. Otherwise 0 is returned indicating that
> > + * a reclaim kthread has not processed a previous batch.
> > + */
> > +static inline int kfree_rcu_drain(struct kfree_rcu_cpu *krcp)
> >  {
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	raw_spin_lock_irqsave(&krcp->lock, flags);
> > +
> >  	// Attempt to start a new batch.
> > -	if (queue_kfree_rcu_work(krcp)) {
> > +	ret = queue_kfree_rcu_work(krcp);
> > +	if (ret)
> >  		// Success! Our job is done here.
> >  		krcp->monitor_todo = false;
> > -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > -		return;
> > -	}
> >  
> >  	// Previous RCU batch still in progress, try again later.
> > -	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > +	return ret;
> >  }
> >  
> >  /*
> >   * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> > - * It invokes kfree_rcu_drain_unlock() to attempt to start another batch.
> > + * It invokes kfree_rcu_drain() to attempt to start another batch.
> >   */
> >  static void kfree_rcu_monitor(struct work_struct *work)
> >  {
> > -	unsigned long flags;
> >  	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
> >  						 monitor_work.work);
> >  
> > -	raw_spin_lock_irqsave(&krcp->lock, flags);
> > -	if (krcp->monitor_todo)
> > -		kfree_rcu_drain_unlock(krcp, flags);
> > -	else
> > -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > +	if (kfree_rcu_drain(krcp))
> > +		return;
> > +
> > +	// Not success. A previous batch is still in progress.
> > +	// Rearm a work to repeat an attempt of starting another batch.
> > +	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> >  }
> >  
> >  static enum hrtimer_restart
> > -- 
> > 2.20.1
> > 
> 
> Please see below a v2 of this patch. The main difference between v1
> is that, the monitor work now is open-coded, thus some extra inline
> functions were eliminated:
> 
> >From 7d153a640a4f791cbfd9b546e32f90fb2c60c480 Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Wed, 21 Apr 2021 13:22:52 +0200
> Subject: [PATCH v2] kvfree_rcu: Refactor kfree_rcu_monitor()
> 
> Currently we have three functions which depend on each other.
> Two of them are quite tiny and the last one where the most
> work is done. All of them are related to queuing RCU batches
> to reclaim objects after a GP.
> 
> 1. kfree_rcu_monitor(). It consist of few lines. It acquires
>    the spin-lock and calls "drain" function.
> 
> 2. kfree_rcu_drain_unlock(). It also consists of few lines of
>    code. It calls a func. to queue the batch. If not success
>    rearm the monitor work to repeat an attempt one more time.
> 
> 3. queue_kfree_rcu_work(). Main core part is implemented here.
>    In short, it attempts to start a new batch to free objects
>    after a GP.
> 
> Since there are no external users of [2] and [3] functions we
> can eliminate both by moving all logic directly into [1]. That
> makes the kfree_rcu_monitor() to be open-coded what is easier
> to follow thus becomes less complicated.
> 
> Apart of that, replace comments which start with "/*" to "//"
> format to make it unified across the file.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued and pushed as shown below.  Nice diffstat!  ;-)

						Thanx, Paul

------------------------------------------------------------------------

 tree.c |   84 ++++++++++++++++++++---------------------------------------------
 1 file changed, 26 insertions(+), 58 deletions(-)

commit c47687cb4cd09422c93a1a7dd7562e10439861b6
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Apr 21 13:22:52 2021 +0200

    kvfree_rcu: Refactor kfree_rcu_monitor()
    
    Currently we have three functions which depend on each other.
    Two of them are quite tiny and the last one where the most
    work is done. All of them are related to queuing RCU batches
    to reclaim objects after a GP.
    
    1. kfree_rcu_monitor(). It consist of few lines. It acquires a spin-lock
       and calls kfree_rcu_drain_unlock().
    
    2. kfree_rcu_drain_unlock(). It also consists of few lines of code. It
       calls queue_kfree_rcu_work() to queue the batch.  If this fails,
       it rearms the monitor work to try again later.
    
    3. queue_kfree_rcu_work(). This provides the bulk of the functionality,
       attempting to start a new batch to free objects after a GP.
    
    Since there are no external users of functions [2] and [3], both
    can eliminated by moving all logic directly into [1], which both
    shrinks and simplifies the code.
    
    Also replace comments which start with "/*" to "//" format to make it
    unified across the file.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4d93c6985d3f..3a5fef9fc934 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3362,29 +3362,26 @@ static void kfree_rcu_work(struct work_struct *work)
 }
 
 /*
- * Schedule the kfree batch RCU work to run in workqueue context after a GP.
- *
- * This function is invoked by kfree_rcu_monitor() when the KFREE_DRAIN_JIFFIES
- * timeout has been reached.
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
-static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
+static void kfree_rcu_monitor(struct work_struct *work)
 {
-	struct kfree_rcu_cpu_work *krwp;
-	bool repeat = false;
+	struct kfree_rcu_cpu *krcp = container_of(work,
+		struct kfree_rcu_cpu, monitor_work.work);
+	unsigned long flags;
 	int i, j;
 
-	lockdep_assert_held(&krcp->lock);
+	raw_spin_lock_irqsave(&krcp->lock, flags);
 
+	// Attempt to start a new batch.
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
-		krwp = &(krcp->krw_arr[i]);
+		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
 
-		/*
-		 * Try to detach bkvhead or head and attach it over any
-		 * available corresponding free channel. It can be that
-		 * a previous RCU batch is in progress, it means that
-		 * immediately to queue another one is not possible so
-		 * return false to tell caller to retry.
-		 */
+		// Try to detach bkvhead or head and attach it over any
+		// available corresponding free channel. It can be that
+		// a previous RCU batch is in progress, it means that
+		// immediately to queue another one is not possible so
+		// in that case the monitor work is rearmed.
 		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
 			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
@@ -3406,57 +3403,28 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 
 			WRITE_ONCE(krcp->count, 0);
 
-			/*
-			 * One work is per one batch, so there are three
-			 * "free channels", the batch can handle. It can
-			 * be that the work is in the pending state when
-			 * channels have been detached following by each
-			 * other.
-			 */
+			// One work is per one batch, so there are three
+			// "free channels", the batch can handle. It can
+			// be that the work is in the pending state when
+			// channels have been detached following by each
+			// other.
 			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
-
-		// Repeat if any "free" corresponding channel is still busy.
-		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
-			repeat = true;
 	}
 
-	return !repeat;
-}
-
-static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
-					  unsigned long flags)
-{
-	// Attempt to start a new batch.
-	if (queue_kfree_rcu_work(krcp)) {
-		// Success! Our job is done here.
+	// If there is nothing to detach, it means that our job is
+	// successfully done here. In case of having at least one
+	// of the channels that is still busy we should rearm the
+	// work to repeat an attempt. Because previous batches are
+	// still in progress.
+	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
 		krcp->monitor_todo = false;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-		return;
-	}
+	else
+		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 
-	// Previous RCU batch still in progress, try again later.
-	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
-/*
- * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
- * It invokes kfree_rcu_drain_unlock() to attempt to start another batch.
- */
-static void kfree_rcu_monitor(struct work_struct *work)
-{
-	unsigned long flags;
-	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
-						 monitor_work.work);
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	if (krcp->monitor_todo)
-		kfree_rcu_drain_unlock(krcp, flags);
-	else
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-}
-
 static enum hrtimer_restart
 schedule_page_work_fn(struct hrtimer *t)
 {
