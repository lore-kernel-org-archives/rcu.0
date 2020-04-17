Return-Path: <SRS0=YclE=6B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19533C2D0EF
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 16:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91C02078E
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 16:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shul1Vjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgDQQMB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgDQQMA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Apr 2020 12:12:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC8C061A0C
        for <rcu@vger.kernel.org>; Fri, 17 Apr 2020 09:12:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so74434lje.10
        for <rcu@vger.kernel.org>; Fri, 17 Apr 2020 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qwU7S1TiJw8Q5Y/dZba0x5bo1iejh7U+eOTX3e93w2E=;
        b=Shul1VjqBQ9SMD0zNCCwwnFqqskkT5xoHOKxY8V1Xr5JiKAuKIeVk5HbV+sYyZ4pWG
         f0a48aGjYbJGydnn5eRnRagpkZ90Oej47ltJ27n8oYbup9fklKYYtyEfzi69F3pZwArL
         VFTh8jcGcJrC8o0WXnsaxqcKNAJLtNeEB6P2VFWrUtWnISjHFUmE1TQ6I1CNwyb1228I
         Nwrzoa0EjmuZzqo9hezm+7jDKdU+5dgU4YpWKlu3pwXpLxhROiM/gRyWBjy79ObyFZ8s
         ir0oeOMl5DFgUIpAGhi64nrLNSLKMqmCzQc0stKe3hbHdNmERrN/Z6kNaET3a/2BwVVb
         Ovpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qwU7S1TiJw8Q5Y/dZba0x5bo1iejh7U+eOTX3e93w2E=;
        b=Q6TDZRxV7sLKbQ93DohR9CUrfVgddBLGdCcitIFNn5oMKs/Xd9Uu08Gwd1emLl0nOc
         SnfKegHd+4PPIkDnXFtCFFR1kjLlhZ9Qud9eb7V4Of/uVbgJgXrLACn6dRTFzsaTPPz1
         mY1n3UDQDI/uAKjR9mEYVpvjnvrdxxt7/43QgP+WOgmEo2nO1YrdGuSlfLBqCp4FSlif
         UN4XheoOx06S7yRaAokfx5ggpMboh9mFYctjJqewX8MQ7Euxvb6eEHfD8ok9fCri5Fvq
         iptCM0FkiQjsiqDw2kSGHnDBrDFf+6xEXvWzsN+hN/Baun1rxPL24y/iQOUOBA0KD1yo
         RVOA==
X-Gm-Message-State: AGi0PuYuV3XlXBBS7k9CcorOCvKolqjgt/ELuZEf1FHDp5sJR80awPe1
        1PKmRnp5x2WB+ZubwMn9Ep6h8lUfDMp2eg==
X-Google-Smtp-Source: APiQypJ42KbEl8uK56/SffyczQz2X8k2znFlGYv/tq6iI+3GKJoJLd51hvKnRw7jC4a/r/AfpoVTfw==
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr2683291ljk.134.1587139918769;
        Fri, 17 Apr 2020 09:11:58 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 64sm16566772ljj.41.2020.04.17.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:11:58 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 17 Apr 2020 18:11:51 +0200
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200417161151.GA17292@pc636>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416203637.GA176663@google.com>
 <20200416210057.GY17661@paulmck-ThinkPad-P72>
 <20200416213444.4cc6kzxmwl32s2eh@linutronix.de>
 <20200417030515.GE176663@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417030515.GE176663@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 11:05:15PM -0400, Joel Fernandes wrote:
> On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-04-16 14:00:57 [-0700], Paul E. McKenney wrote:
> > > 
> > > We might need different calling-context restrictions for the two variants
> > > of kfree_rcu().  And we might need to come up with some sort of lockdep
> > > check for "safe to use normal spinlock in -rt".
> > 
> > Oh. We do have this already, it is called CONFIG_PROVE_RAW_LOCK_NESTING.
> > This one will scream if you do
> > 	raw_spin_lock();
> > 	spin_lock();
> > 
> > Sadly, as of today, there is code triggering this which needs to be
> > addressed first (but it is one list of things to do).
> > 
> > Given the thread so far, is it okay if I repost the series with
> > migrate_disable() instead of accepting a possible migration before
> > grabbing the lock? I would prefer to avoid the extra RT case (avoiding
> > memory allocations in a possible atomic context) until we get there.
> 
> I prefer something like the following to make it possible to invoke
> kfree_rcu() from atomic context considering call_rcu() is already callable
> from such contexts. Thoughts?
> 
> (Only build tested)
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] rcu/tree: Avoid allocating in non-preemptible context for
>  PREEMPT_RT kernels
> 
> Per recent discussions, kfree_rcu() is a low-level facility which should be
> callable in atomic context (raw spinlock sections, IRQ disable sections etc).
> 
> However, it depends on page allocation which acquires sleeping locks on
> PREEMPT_RT.
> 
> In order to support all usecases, avoid the allocation of pages for
> PREEMPT_RT. The page allocation is just an optimization which does not
> break functionality. Further, in future patches the pages will be
> pre-allocated reducing the likelihood that page allocations will be
> needed.
> 
> We also convert the spinlock_t to raw_spinlock_t so that does not sleep
> in PREEMPT_RT's raw atomic critical sections.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f288477ee1c26..ba831712fb307 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2905,7 +2905,7 @@ struct kfree_rcu_cpu {
>  	struct kfree_rcu_bulk_data *bhead;
>  	struct kfree_rcu_bulk_data *bcached;
>  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> -	spinlock_t lock;
> +	raw_spinlock_t lock;
>  	struct delayed_work monitor_work;
>  	bool monitor_todo;
>  	bool initialized;
> @@ -2939,12 +2939,12 @@ static void kfree_rcu_work(struct work_struct *work)
>  	krwp = container_of(to_rcu_work(work),
>  			    struct kfree_rcu_cpu_work, rcu_work);
>  	krcp = krwp->krcp;
> -	spin_lock_irqsave(&krcp->lock, flags);
> +	raw_spin_lock_irqsave(&krcp->lock, flags);
>  	head = krwp->head_free;
>  	krwp->head_free = NULL;
>  	bhead = krwp->bhead_free;
>  	krwp->bhead_free = NULL;
> -	spin_unlock_irqrestore(&krcp->lock, flags);
> +	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  
>  	/* "bhead" is now private, so traverse locklessly. */
>  	for (; bhead; bhead = bnext) {
> @@ -3047,14 +3047,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
>  	krcp->monitor_todo = false;
>  	if (queue_kfree_rcu_work(krcp)) {
>  		// Success! Our job is done here.
> -		spin_unlock_irqrestore(&krcp->lock, flags);
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  		return;
>  	}
>  
>  	// Previous RCU batch still in progress, try again later.
>  	krcp->monitor_todo = true;
>  	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> -	spin_unlock_irqrestore(&krcp->lock, flags);
> +	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
>  /*
> @@ -3067,16 +3067,16 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
>  						 monitor_work.work);
>  
> -	spin_lock_irqsave(&krcp->lock, flags);
> +	raw_spin_lock_irqsave(&krcp->lock, flags);
>  	if (krcp->monitor_todo)
>  		kfree_rcu_drain_unlock(krcp, flags);
>  	else
> -		spin_unlock_irqrestore(&krcp->lock, flags);
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
>  static inline bool
>  kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> -	struct rcu_head *head, rcu_callback_t func)
> +	struct rcu_head *head, rcu_callback_t func, bool alloc)
>  {
>  	struct kfree_rcu_bulk_data *bnode;
>  
> @@ -3092,6 +3092,10 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>  		if (!bnode) {
>  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
>  
> +			/* If allocation is not allowed, don't do it. */
> +			if (!alloc)
> +				return false;
> +
>  			bnode = (struct kfree_rcu_bulk_data *)
>  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
>  		}
> @@ -3138,11 +3142,15 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
> +	bool alloc = true;
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> +		alloc = false;
>  
>  	local_irq_save(flags);	// For safely calling this_cpu_ptr().
>  	krcp = this_cpu_ptr(&krc);
>  	if (krcp->initialized)
> -		spin_lock(&krcp->lock);
> +		raw_spin_lock(&krcp->lock);
>  
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(head)) {
> @@ -3156,7 +3164,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	 * Under high memory pressure GFP_NOWAIT can fail,
>  	 * in that case the emergency path is maintained.
>  	 */
> -	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
> +	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func, alloc))) {
>  		head->func = func;
>  		head->next = krcp->head;
>  		krcp->head = head;
> @@ -3173,7 +3181,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>  unlock_return:
>  	if (krcp->initialized)
> -		spin_unlock(&krcp->lock);
> +		raw_spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL_GPL(kfree_call_rcu);
> @@ -3205,11 +3213,11 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count = krcp->count;
> -		spin_lock_irqsave(&krcp->lock, flags);
> +		raw_spin_lock_irqsave(&krcp->lock, flags);
>  		if (krcp->monitor_todo)
>  			kfree_rcu_drain_unlock(krcp, flags);
>  		else
> -			spin_unlock_irqrestore(&krcp->lock, flags);
> +			raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  
>  		sc->nr_to_scan -= count;
>  		freed += count;
> @@ -3236,15 +3244,15 @@ void __init kfree_rcu_scheduler_running(void)
>  	for_each_online_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> -		spin_lock_irqsave(&krcp->lock, flags);
> +		raw_spin_lock_irqsave(&krcp->lock, flags);
>  		if (!krcp->head || krcp->monitor_todo) {
> -			spin_unlock_irqrestore(&krcp->lock, flags);
> +			raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  			continue;
>  		}
>  		krcp->monitor_todo = true;
>  		schedule_delayed_work_on(cpu, &krcp->monitor_work,
>  					 KFREE_DRAIN_JIFFIES);
> -		spin_unlock_irqrestore(&krcp->lock, flags);
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  	}
>  }
>  
> @@ -4140,7 +4148,7 @@ static void __init kfree_rcu_batch_init(void)
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> -		spin_lock_init(&krcp->lock);
> +		raw_spin_lock_init(&krcp->lock);
>  		for (i = 0; i < KFREE_N_BATCHES; i++) {
>  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>  			krcp->krw_arr[i].krcp = krcp;
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
Forgot to add:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
