Return-Path: <SRS0=xcwz=6D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E511C38A30
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 12:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE7E214AF
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 12:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF+nfrIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgDSMPR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgDSMPR (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 19 Apr 2020 08:15:17 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF386C061A0C
        for <rcu@vger.kernel.org>; Sun, 19 Apr 2020 05:15:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 198so5561926lfo.7
        for <rcu@vger.kernel.org>; Sun, 19 Apr 2020 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7hZZodF2p57khG2SoTH4UCblGTeJsz2+ImtzVFXqPA=;
        b=JF+nfrIOqI+Wmh/NHNXwIUexHu2up01LfpiTAdoACV07G3c8dtc2dNqpVjjPCM6Rkw
         JK+JoOCnVwkL6YSbVApMppbfZLGfSxKQOacFPKhbWUANhl3W6BmJaEwwajnRrcVzg7bX
         jwCd/V7dPXCg4437UWDTWJW5T4UfJWf18g6n17BXDHVTuEDI+BNrQG8wrIA8qnF0nEGt
         +flpSX27cn8UA/L0fCDev+u2qvfQnXgnDmoUMEZQla5l+JFnX5esx5zTY4AhZjpntEqt
         yztDeMVuJmVyofPsnOVO9SDC/uIGWOZyhK9TXAVRyCeqUDvFLmhmS8fyiJEfGYIGy69x
         GWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7hZZodF2p57khG2SoTH4UCblGTeJsz2+ImtzVFXqPA=;
        b=i+L2v2s/Fqi1LiqIejugWLuASaao5nwI43umIaONvzuilo+r242lxaMylY1MBb2pvx
         qg2LuUKKcejaf6Xn8wZE8hpn+CdnTPyaWB3BuRj7of3X0s067bmvXARlB7e7EtEuzvEP
         FQbu5FqGCEWNO0RvYirfui71JnYFbrBViB+RHuHVZ0El7GL3ceszGCpq4NR2vAThg4Yz
         pgKeipkhN4E2lqOwdz1hgQu8FkeXLzvml0ACahlAWMLTgwnp24cuCxURBJPGqcF9r1mY
         SB9IeU7lNkhbYNKtr4GY5+rMYk7UvpJFZ+2/hr+g53ojaCdKGiBgY3twc5y4q+QF0j7m
         jgYg==
X-Gm-Message-State: AGi0PuZ3l6ukNVOTf1RY7J2+6N9ZzPKDfn/I9Ic6/ofcbjo2z+5cgA9R
        zILRyhnHEjz/uNkvgckhX0Q=
X-Google-Smtp-Source: APiQypKNGYQXcXhWqmY/kVZz5KyaDFXlzYbAITnzsWpR8F+YXWUtp4I0hJ1v9oIhcXIqB42Mph7RvA==
X-Received: by 2002:ac2:5f73:: with SMTP id c19mr7727091lfc.29.1587298515036;
        Sun, 19 Apr 2020 05:15:15 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id b28sm22927913lfo.46.2020.04.19.05.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 05:15:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 19 Apr 2020 14:15:06 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200419121506.GA5324@pc636>
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
Joel, we also need to drop the lock before alloc_pages(). We are not
allowed to allocate under raw_spin_lock held, because of it uses
sleepable spinlocks. If i miss something, please fix me :)

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ba831712fb30..9a334e3c7f96 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3076,7 +3076,8 @@ static void kfree_rcu_monitor(struct work_struct *work)

 static inline bool
 kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
-       struct rcu_head *head, rcu_callback_t func, bool alloc)
+       struct rcu_head *head, rcu_callback_t func, bool alloc,
+       unsigned long *flags)
 {
        struct kfree_rcu_bulk_data *bnode;

@@ -3096,8 +3097,22 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
                        if (!alloc)
                                return false;

+                       /* Drop the lock. */
+                       if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+                               migrate_disable();
+                               raw_spin_unlock(&krcp->lock);
+                               local_irq_restore(*flags);
+                       }
+
                        bnode = (struct kfree_rcu_bulk_data *)
                                __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+                       /* Grab the lock back. */
+                       if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+                               local_irq_save(*flags);
+                               raw_spin_lock(&krcp->lock);
+                               migrate_enable();
+                       }
                }

                /* Switch to emergency path. */
@@ -3164,7 +3179,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
         * Under high memory pressure GFP_NOWAIT can fail,
         * in that case the emergency path is maintained.
         */
-       if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func, alloc))) {
+       if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func, alloc, &flags))) {
                head->func = func;
                head->next = krcp->head;
                krcp->head = head;
<snip>

If everyone agrees to go with such solution, let's split this work into
at least two patches, one is converting to raw spinlocks and second one
is an allocation fix for RT case.

?

--
Vlad Rezki
