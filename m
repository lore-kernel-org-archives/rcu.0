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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA71C433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14A864E65
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 15:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBLPpv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Feb 2021 10:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhBLPps (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Feb 2021 10:45:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E53C061756;
        Fri, 12 Feb 2021 07:45:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v5so13711462lft.13;
        Fri, 12 Feb 2021 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cu8L/WplKZ780G9jwN56kevEB3GtJ8y5NssLfkx6Uqg=;
        b=SjejLWzTI2VFjY1dfkVD5V42v7lXpknS0S+UFFh5UdUiIm+u2XIbf88yDmsIVpG7o8
         74Wb8toCwyKozPNSyWhtUZCM6QT8Pk6OSUh7SWve9TVS8dywtofoD11+lHtcwv4VpUkH
         n05k6PyRfcDWBH/iv9dZZKCb00arx84pdhW93LAj6KM+FKqdUZAGt2jro60j9O7wi3X6
         bfFCyVK4ZzxxCDZlgVc4eD+s7TvYUvRoqzOSqQmZh6JwMqyyMYOqx/d+PMzxJL8k2Z3A
         S0/5UpSp1yUY98tYLRsrfiEaF0VzTI4S+QYv0uGzrYqIL7gMo3dyiDkR39IE0Y2P7bU1
         xdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cu8L/WplKZ780G9jwN56kevEB3GtJ8y5NssLfkx6Uqg=;
        b=P3ZnPNeAeUcV/lGg1hCEeTZfQ8RMzY/8mQwy18NSIoLvh8+tUfseuBVFDCWQkfCVNJ
         qPOJexwZP8iA9dv2cwGuis3uBBAGRN3AejKSex2NfJdBMED376g6M9V/Cexba4P1Aiq8
         0J1V/LGrZtpEO3kMl7HT714P6kQMmPbdnWMZYaxDfarLAfR6ZQjROTN4yQ2ATWT2Nl4c
         WKSDrbimo5U0INJV+1V4b3TgHco/S21fZY5O2sI5wQYR2xmMzI/oZSQKrvYnoXkWkv3O
         1kMkxNZ5XCds8xNVQd7F3A40WLKmJOeXYC6jyCNDRrDSE23rUOUKNraOALMK8n1Ru5ZZ
         RaUQ==
X-Gm-Message-State: AOAM533KieM9PEaC+N0wZ+m1mdix1hx9qliQWVWFYEfmMHE3DlcQykzm
        nVxaHwZdCoqnSBKcnEBCT18=
X-Google-Smtp-Source: ABdhPJw5Rpzi91fLuT88nMYep4Q2yYCQDO87d3z/tYohHXQW6mK1UQU4krUDCvgTp1mS8xnWYoiYBA==
X-Received: by 2002:a19:4013:: with SMTP id n19mr1887674lfa.543.1613144706407;
        Fri, 12 Feb 2021 07:45:06 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v25sm1416346ljc.92.2021.02.12.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 07:45:05 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 12 Feb 2021 16:45:03 +0100
To:     qiang.zhang@windriver.com
Cc:     urezki@gmail.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] kvfree_rcu: Release page cache under memory pressure
Message-ID: <20210212154503.GA55693@pc638.lan>
References: <20210211121012.278203-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211121012.278203-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> From: Zqiang <qiang.zhang@windriver.com>
> 
> Add free per-cpu existing krcp's page cache operation in shrink callback
> function, and also during shrink period, simple delay schedule fill page
> work, to avoid refill page while free krcp page cache.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  v1->v4:
>  During the test a page shrinker is pretty active, because of low memory
>  condition. callback drains it whereas kvfree_rcu() part refill it right
>  away making kind of vicious circle.
>  Through Vlad Rezki suggestion, to avoid this, schedule a periodic delayed
>  work with HZ, and it's easy to do that.
>  v4->v5:
>  change commit message and use xchg replace WRITE_ONCE()
> 
>  kernel/rcu/tree.c | 49 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c1ae1e52f638..f1fba23f5036 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3139,7 +3139,7 @@ struct kfree_rcu_cpu {
>  	bool initialized;
>  	int count;
>  
> -	struct work_struct page_cache_work;
> +	struct delayed_work page_cache_work;
>  	atomic_t work_in_progress;
>  	struct hrtimer hrtimer;
>  
> @@ -3395,7 +3395,7 @@ schedule_page_work_fn(struct hrtimer *t)
>  	struct kfree_rcu_cpu *krcp =
>  		container_of(t, struct kfree_rcu_cpu, hrtimer);
>  
> -	queue_work(system_highpri_wq, &krcp->page_cache_work);
> +	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
>  	return HRTIMER_NORESTART;
>  }
>  
> @@ -3404,7 +3404,7 @@ static void fill_page_cache_func(struct work_struct *work)
>  	struct kvfree_rcu_bulk_data *bnode;
>  	struct kfree_rcu_cpu *krcp =
>  		container_of(work, struct kfree_rcu_cpu,
> -			page_cache_work);
> +			page_cache_work.work);
>  	unsigned long flags;
>  	bool pushed;
>  	int i;
> @@ -3428,15 +3428,21 @@ static void fill_page_cache_func(struct work_struct *work)
>  	atomic_set(&krcp->work_in_progress, 0);
>  }
>  
> +static atomic_t backoff_page_cache_fill = ATOMIC_INIT(0);
> +
Should we initialize a static atomic_t? It is zero by default.

>  static void
>  run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  {
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> -		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> -			HRTIMER_MODE_REL);
> -		krcp->hrtimer.function = schedule_page_work_fn;
> -		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> +		if (atomic_xchg(&backoff_page_cache_fill, 0)) {
> +			queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, HZ);
system_wq? It is not so critical, anyway the job is rearmed with 1 second interval.

> +		} else {
> +			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> +				HRTIMER_MODE_REL);
> +			krcp->hrtimer.function = schedule_page_work_fn;
> +			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> +		}
>  	}
>  }
>  
> @@ -3571,19 +3577,44 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
> +	atomic_set(&backoff_page_cache_fill, 1);
>  	return count;
>  }
>  
> @@ -3598,6 +3629,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count = krcp->count;
> +		count += free_krc_page_cache(krcp);
> +
>  		raw_spin_lock_irqsave(&krcp->lock, flags);
>  		if (krcp->monitor_todo)
>  			kfree_rcu_drain_unlock(krcp, flags);
> @@ -4574,7 +4607,7 @@ static void __init kfree_rcu_batch_init(void)
>  		}
>  
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> -		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
> +		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
>  		krcp->initialized = true;
>  	}
>  	if (register_shrinker(&kfree_rcu_shrinker))
> -- 
> 2.25.1
> 
I have reviewed and tested that patch. Even though it can not be applied
cleanly on the latest Paul "dev" branch feel free to use:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Also i placed some small nits, because it should be rebased on latest dev.
As for commit message i guess Paul will help :)

Thank you!

--
Vlad Rezki
