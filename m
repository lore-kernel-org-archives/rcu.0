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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E14C54FC9
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980922068F
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilnKy7G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDUNJC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728739AbgDUNJB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 21 Apr 2020 09:09:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5BC061A10;
        Tue, 21 Apr 2020 06:09:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so11079205lfc.0;
        Tue, 21 Apr 2020 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ae3UnuFpJ8+A0PbXgsT3rOwWvqv/eSO4G3CZAuRBTig=;
        b=ilnKy7G9PjI815DS9hT3SBdLYkWF5UDM4G+QulvHe+eswRuw7R/zeuyOBOTbwtBzkb
         pjznuM9Q7RZmDsURDJ1HVBRYDWUE0GHot529qQpaBGOsUrg3xThRG+bGeK/Dtf4ZK3f5
         f1ldeB+SqDacSXQ+nJ/Inh03pwBXbwFQsx2Htixut6/wf772OihXGXJ+ka4W2bnf/LPO
         qY4Q9HyBvVvGLhmBxD31MabT+EbEF3K5o7mGVH+6A0zyE4TnJn3coSWwo6zYz45LXVjl
         Dn4BM4RHu8k11c7i0R4DpvZs9Ju4wrGuK8cqmm+0LbPuyRDs2F1s0q8NeKJEz0oaWK7i
         NhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ae3UnuFpJ8+A0PbXgsT3rOwWvqv/eSO4G3CZAuRBTig=;
        b=DMr0swKV8gJa1kpt7LtRnStH5stcDtK0Xi01ouCE4V+RA7+j0Z0BuD95pHZuaxGaFE
         +hXEN11mKfAaLfgYAykmeNRVmlFNGvTHGQ6FwC/wMDvPmAmljpveYulkwtS7pV7K6c8Y
         lbzibwXzr1wPRRRi42gmH3amZdsxd19/X/0ZtgapVJ0thyaTcsJidn9F7w0Y6+CdDjT5
         qfWuM3BYyjl6svC3MUzQsmKb8/aTeGU0Cdh8QU05GEziLqPJ1ANRXxkQAlZ14WSfRpS5
         VvnKKyfEYmA2vf6Wk2KtiXW1IZPM4GSACmwXgJj5O/UD8hJalTagAaeBYLD2bQc/Xb7U
         x6NA==
X-Gm-Message-State: AGi0PuZrb1LiRRbDsr7Lhrd6Ib0m3zsWXD7yKYRoVE/iOLIfh6Fs1n/y
        EMxiuY9k46OCep3QuGPc87E=
X-Google-Smtp-Source: APiQypLObkaoviPeUqqOpTMNmwXnp2oB4VmD0S1mnIjPBbbFpdbIaXGWNgBJhr3Rgml+5T6263BDlw==
X-Received: by 2002:a19:cb41:: with SMTP id b62mr13882680lfg.21.1587474538470;
        Tue, 21 Apr 2020 06:08:58 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id b73sm2136210lfg.86.2020.04.21.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:08:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Apr 2020 15:08:51 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: Re: [PATCH rcu/dev -fixes 4/4] rcu/tree: Use consistent style for
 comments
Message-ID: <20200421130851.GA5695@pc636>
References: <20200420153837.194532-1-joel@joelfernandes.org>
 <20200420153837.194532-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420153837.194532-5-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 20, 2020 at 11:38:37AM -0400, Joel Fernandes (Google) wrote:
> Simple clean up of comments in kfree_rcu() code to keep it consistent
> with majority of commenting styles.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f6eb3aee0935e..0512e0f9e2f31 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3043,15 +3043,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
>  					  unsigned long flags)
>  {
> -	// Attempt to start a new batch.
> +	/* Attempt to start a new batch. */
>  	krcp->monitor_todo = false;
>  	if (queue_kfree_rcu_work(krcp)) {
> -		// Success! Our job is done here.
> +		/* Success! Our job is done here. */
>  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  		return;
>  	}
>  
> -	// Previous RCU batch still in progress, try again later.
> +	/* Previous RCU batch still in progress, try again later. */
>  	krcp->monitor_todo = true;
>  	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> @@ -3152,14 +3152,14 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
>  
> -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> +	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
>  	krcp = this_cpu_ptr(&krc);
>  	if (krcp->initialized)
>  		raw_spin_lock(&krcp->lock);
>  
> -	// Queue the object but don't yet schedule the batch.
> +	/* Queue the object but don't yet schedule the batch. */
>  	if (debug_rcu_head_queue(head)) {
> -		// Probable double kfree_rcu(), just leak.
> +		/* Probable double kfree_rcu(), just leak. */
>  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
>  			  __func__, head);
>  		goto unlock_return;
> @@ -3177,7 +3177,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>  	WRITE_ONCE(krcp->count, krcp->count + 1);
>  
> -	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> +	/* Set timer to drain after KFREE_DRAIN_JIFFIES. */
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  	    !krcp->monitor_todo) {
>  		krcp->monitor_todo = true;
> @@ -3723,7 +3723,7 @@ int rcutree_offline_cpu(unsigned int cpu)
>  
>  	rcutree_affinity_setting(cpu, cpu);
>  
> -	// nohz_full CPUs need the tick for stop-machine to work quickly
> +	/* nohz_full CPUs need the tick for stop-machine to work quickly */
>  	tick_dep_set(TICK_DEP_BIT_RCU);
>  	return 0;
>  }
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
