Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB9DC54FD0
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260FF2076A
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYIPu7HF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgDUNMn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUNMm (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 21 Apr 2020 09:12:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD35C061A10;
        Tue, 21 Apr 2020 06:12:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so13867896ljg.8;
        Tue, 21 Apr 2020 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YtpKRgNMP/KbXMdVvEJzfMbdjDnlZ2CZdckJrKK2NFk=;
        b=pYIPu7HFRLvbAbPwzp/xcxQY+IB23v6sqESNUNRXo7jHSSCKpyebQ/8Vu619xpp+yY
         azF8BfYnviG8F6dSb09x4QBWZYvfdpWGH0gajwK65GOBy44Y5wZMXZTCB3MriqNmvxwF
         ffVN7kMbcASPiV9SPXAc89nIotKwee1wAr4pENG4NlBSqzpVMPJQ+/DsLuFsLUyIkhZT
         k0Gm7c3tIM6FGPSIEc+U20QR+HxHJQ3paGbsOabBU5CNhRSVoSl/1cv87nvsaZJ+AIY4
         h/MAXHq4DLbuAPnDQsKE6e8ms31ESu80o4FdGYKHL0X2foTR7uY41WuGJQXO/2VNyg1J
         eJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtpKRgNMP/KbXMdVvEJzfMbdjDnlZ2CZdckJrKK2NFk=;
        b=MYZ+2oXuZYs7yt05ARshYltjfV6Xhj+f4rPaR5yoPh9TdtwBdkhkzCK2nLhiXaH0Pi
         jO+SDi8TA2ffvd6nMSLl7RZ2KRORM1S/9+JR446AfFJm65vSTNmiXel1KVPr0bdUEVbP
         FA51khLC9apqgAXWDEIrVYcstQUQDTT3xaMZSXhkOoMbBuZyYpsCeEdZ9yhlGjAjqROQ
         5vA3N3pULJZSGyJaDiLmq5NTaIZD7CffYR7GNuwhocGt98pzPLoLZ2v9UtsTGxg7EVoF
         W+M48K+jMtAfiiEJCYs7idv/311WOE4tIuQjnGpkTGIqBQYJz/D91gqY6irMvnuGupka
         L/QQ==
X-Gm-Message-State: AGi0PubFPatGVXGgsjAuMifDFOVQRJuBuOdjTslTObIJ0gkjK1raiYte
        i30+XBsC9YaNh9c7GdDiDgE=
X-Google-Smtp-Source: APiQypKwlVrt1VEJGmPtaI7Q/IERPIzeGu8ppDOjApaaTx5NnfEDdFoYtCMiH+sa7jjX9PEzpSR/vQ==
X-Received: by 2002:a2e:8805:: with SMTP id x5mr13650347ljh.223.1587474760291;
        Tue, 21 Apr 2020 06:12:40 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 64sm2163946lfh.32.2020.04.21.06.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:12:39 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Apr 2020 15:12:37 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com,
        bigeasy@linutronix.de, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/dev -fixes 1/4] rcu/tree: Keep kfree_rcu() awake
 during lock contention
Message-ID: <20200421131237.GB5695@pc636>
References: <20200420153837.194532-1-joel@joelfernandes.org>
 <20200420153837.194532-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420153837.194532-2-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 20, 2020 at 11:38:34AM -0400, Joel Fernandes (Google) wrote:
> On PREEMPT_RT kernels, contending on the krcp spinlock can cause
> sleeping as on these kernels, the spinlock is converted to an rt-mutex.
> To prevent breakage of possible usage of kfree_rcu() now or in the
> future, make use of raw spinlocks which are not subject to such
> conversions.
> 
> Vetting all code paths, there is no reason to believe that the raw
> spinlock will be held for long time so PREEMPT_RT should not suffer from
> lengthy acquirals of the lock.
> 
> Cc: urezki@gmail.com
> Cc: bigeasy@linutronix.de
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f288477ee1c26..cf68d3d9f5b81 100644
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
> @@ -3067,11 +3067,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
> @@ -3142,7 +3142,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	local_irq_save(flags);	// For safely calling this_cpu_ptr().
>  	krcp = this_cpu_ptr(&krc);
>  	if (krcp->initialized)
> -		spin_lock(&krcp->lock);
> +		raw_spin_lock(&krcp->lock);
>  
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(head)) {
> @@ -3173,7 +3173,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>  unlock_return:
>  	if (krcp->initialized)
> -		spin_unlock(&krcp->lock);
> +		raw_spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL_GPL(kfree_call_rcu);
> @@ -3205,11 +3205,11 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
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
> @@ -3236,15 +3236,15 @@ void __init kfree_rcu_scheduler_running(void)
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
> @@ -4140,7 +4140,7 @@ static void __init kfree_rcu_batch_init(void)
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
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

If we decide to move the schedule_delayed_work() outside of the critical
section, i think, it would be better to submit separate patch with good
explanation why we do it.

--
Vlad Rezki
> 
