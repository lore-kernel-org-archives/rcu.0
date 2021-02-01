Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2124DC433DB
	for <rcu@archiver.kernel.org>; Mon,  1 Feb 2021 19:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE365601FB
	for <rcu@archiver.kernel.org>; Mon,  1 Feb 2021 19:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhBAT6m (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhBAT6i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Feb 2021 14:58:38 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B0C06174A;
        Mon,  1 Feb 2021 11:57:57 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id m22so13754902ljj.4;
        Mon, 01 Feb 2021 11:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QF9QJ8bUVCzyU8yzhT8o2XH/YW88xnM0LKKudQApB6I=;
        b=KPGcqPFYCy7EmnUv1pAEpzNLr+WCrUXHdDld8RIKM7Er2Xd9ne2jMG7edcYe7KyBiG
         pEydVLLtG8/TUDv4PxiVySpnMscK/IRs+cc+gOyC2CnFORveinFyOVV6aWA807rEihFd
         qXMTMK6y6UTLW2JFKG48PLEqbEq3zAtlwL5oUbBlKql9siYNlFGnDDpQymw6T7MHI6oe
         8wFPfY63UrYSGzc+jyyexRLixv5wWBbb6AIQqjXvblecrsdb+YdMDw7SHw1kqJ71eSjO
         GIPutMS/hflxEvlZE0Hpi1nG4Cc8Ga2C4I1WGuJAWPQdtQXrKRkLWxwlMEt7V3nqSYci
         Abpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QF9QJ8bUVCzyU8yzhT8o2XH/YW88xnM0LKKudQApB6I=;
        b=niqh4LxTkAr4iWAGuQ+52CSzAdJWSSN+CGKpZd6eWkZl6h/JAS136b742htBsGvivF
         SEV1GUgHsPMTHLcKiLXcVD35FMNcK3Uwlxg2uQPwlDspqkhV2wdBJ1zLaCEIsLLwzR82
         zLQh1PuJVRqCkQ0PAi5rDINSDX57LjdN6C9d/tmqhqehl/ctlEF5ivxrA8hPR2We29OW
         GFJy6PpfCkRL622qamo0oj738ngDfiAWvGXefBAgzyWQK/AE/brjRK0Aqu1jIYLLS/F+
         e0PFC4Yg1yEMDMGrNF1HAyfpC7FuHzJIWVyfuNEWQsRBvhAtgeXvIJgpmZJNr0rFaS/j
         aEfg==
X-Gm-Message-State: AOAM532QOgytAmwMKYMRCdlNWh2VUMJs7OKn4zJF8bnKsG2fOfpb/ZRk
        WscGP/4YvYAmb56+UloNxp8=
X-Google-Smtp-Source: ABdhPJzke4EJ1Hl2YgwdRQEBalpw1f4ND6A1DPVaKwA4BO7xbLSwgPs8v6NWTTY26IzAMH/bLWLhaQ==
X-Received: by 2002:a05:651c:2113:: with SMTP id a19mr11171769ljq.147.1612209475933;
        Mon, 01 Feb 2021 11:57:55 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 189sm3065586lfj.192.2021.02.01.11.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:57:55 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 1 Feb 2021 20:57:53 +0100
To:     qiang.zhang@windriver.com
Cc:     urezki@gmail.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kvfree_rcu: Release page cache under memory pressure
Message-ID: <20210201195753.GA2026@pc638.lan>
References: <20210130131851.23285-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130131851.23285-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Zqiang.

> From: Zqiang <qiang.zhang@windriver.com>
> 
> Add free per-cpu existing krcp's page cache operation, when
> the system is under memory pressure.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/rcu/tree.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c1ae1e52f638..644b0f3c7b9f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3571,17 +3571,41 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
> +static int free_krc_page_cache(struct kfree_rcu_cpu *krcp)
> +{
> +	unsigned long flags;
> +	struct llist_node *page_list, *pos, *n;
> +	int freed = 0;
> +
> +	raw_spin_lock_irqsave(&krcp->lock, flags);
> +	page_list = llist_del_all(&krcp->bkvcache);
> +	krcp->nr_bkv_objs = 0;
> +	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +
> +	llist_for_each_safe(pos, n, page_list) {
> +		free_page((unsigned long)pos);
> +		freed++;
> +	}
> +
> +	return freed;
> +}
> +
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
>  	int cpu;
>  	unsigned long count = 0;
> +	unsigned long flags;
>  
>  	/* Snapshot count of all CPUs */
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count += READ_ONCE(krcp->count);
> +
> +		raw_spin_lock_irqsave(&krcp->lock, flags);
> +		count += krcp->nr_bkv_objs;
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  	}
>  
>  	return count;
> @@ -3598,6 +3622,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count = krcp->count;
> +		count += free_krc_page_cache(krcp);
> +
>  		raw_spin_lock_irqsave(&krcp->lock, flags);
>  		if (krcp->monitor_todo)
>  			kfree_rcu_drain_unlock(krcp, flags);
> -- 
> 2.17.1
> 
Thank you for your patch!

I spent some time to see how the patch behaves under low memory condition.
To simulate it, i used "rcuscale" tool with below parameters:

../rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig CONFIG_NR_CPUS=64 \
--bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 \
torture.disable_onoff_at_boot" --trust-make

64 CPUs + 512 MB of memory. In general, my test system was running on edge
hitting an out of memory sometimes, but could be considered as stable in
regards to a test completion and taken time, so both were pretty solid.

You can find a comparison on a plot, that can be downloaded following
a link: wget ftp://vps418301.ovh.net/incoming/release_page_cache_under_low_memory.png

In short, i see that a patched version can lead to longer test completion,
whereas the default variant is stable on almost all runs. After some analysis
and further digging i came to conclusion that a shrinker free_krc_page_cache()
concurs with run_page_cache_worker(krcp) running from kvfree_rcu() context.

i.e. During the test a page shrinker is pretty active, because of low memory
condition. Our callback drains it whereas kvfree_rcu() part refill it right
away making kind of vicious circle.

So, a run_page_cache_worker() should be backoff for some time when a system
runs into a low memory condition or high pressure:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7077d73fcb53..446723b9646b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3163,7 +3163,7 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	int count;
 
-	struct work_struct page_cache_work;
+	struct delayed_work page_cache_work;
 	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
 
@@ -3419,7 +3419,7 @@ schedule_page_work_fn(struct hrtimer *t)
 	struct kfree_rcu_cpu *krcp =
 		container_of(t, struct kfree_rcu_cpu, hrtimer);
 
-	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
 	return HRTIMER_NORESTART;
 }
 
@@ -3428,7 +3428,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	struct kvfree_rcu_bulk_data *bnode;
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work);
+			page_cache_work.work);
 	unsigned long flags;
 	bool pushed;
 	int i;
@@ -3452,15 +3452,22 @@ static void fill_page_cache_func(struct work_struct *work)
 	atomic_set(&krcp->work_in_progress, 0);
 }
 
+static bool backoff_page_cache_fill;
+
 static void
 run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-		krcp->hrtimer.function = schedule_page_work_fn;
-		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		if (READ_ONCE(backoff_page_cache_fill)) {
+			queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, HZ);
+			WRITE_ONCE(backoff_page_cache_fill, false);
+		} else {
+			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
+				HRTIMER_MODE_REL);
+			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		}
 	}
 }
 
@@ -3644,6 +3651,8 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 
+	// Low memory condition, limit a page cache worker activity.
+	WRITE_ONCE(backoff_page_cache_fill, true);
 	return count;
 }
 
@@ -4634,7 +4643,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))

below patch fixes it. We should backoff the page fill worker keeping it empty
until the situation with memory consumption is normalized.

Any thoughts ideas?

--
Vlad Rezki
