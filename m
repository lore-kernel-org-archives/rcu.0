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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70878C433E0
	for <rcu@archiver.kernel.org>; Mon,  8 Feb 2021 13:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F38B64E82
	for <rcu@archiver.kernel.org>; Mon,  8 Feb 2021 13:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBHNDd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Feb 2021 08:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBHNDc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Feb 2021 08:03:32 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3774C061756;
        Mon,  8 Feb 2021 05:02:51 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e18so16811731lja.12;
        Mon, 08 Feb 2021 05:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b7Ntd6xk8fkmmQrfnT7+pjI8yRVrY36ISzhp9gp/+qo=;
        b=UVeArX5dnnbdSZZLXOLVozsw5KFWX5lk9rUACersqUl4CpkRCuGnY0ory/J1XjXE9p
         M8cls28C8CxvqL0kNW0TuUOKjSESUmswORaVL0A/P/YUnuphVychrZFw7iyiNv2F7/1W
         AT0zQZ4hgtfXbB6OvdHnSbZKPwRznrt9GXKNjRwWriPmrPm/EmUhX2bdl2pFEj+3V3nY
         cz07yjwEjhAkatoVve5Rhgqn18EYtR2vV1hWrAgsis59QemJfV/9+VERlc5WDQ9n/14z
         p7tFTm18GDI8DYExi4z/wnraZgHdm7cpsObgaNG5JuWnxJqKI6d2PdqqkzDHoHZkwoAg
         eMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b7Ntd6xk8fkmmQrfnT7+pjI8yRVrY36ISzhp9gp/+qo=;
        b=UuX/VatsuGUo7KCO3aQHH9MhtFIGcG7CBUKHxnmm/lCnQpNJpn79SNK+hEIAcC41Bs
         phZ0xvjO3C4BXiT0zaFzlEfjLBRoT0aOTtOljJma4kMmR/n3efpW2sOaw5zFQqashH60
         ZJgXBrR/iDAJpFY+187Od48TB9bHkiViA5oTo5iBlSc5SRNun4FDTEQ5ScFv0UVIDv9u
         DDFy2AdVVaDqb2UYYcrBW2gEUUJHhwb6bQlDZInkijU+/cCi+BXx+LJftdfFk8oI6mi+
         8nOjwwY3jV2PnJG15RG0NS7KvTFqK30v8ExGFdUcVyHbIgaIhXOv6AUU6OJTbGC7kdLv
         H/kg==
X-Gm-Message-State: AOAM5303MtgmbItawvclJLPNoTRtR7i13NAqz4B35LKvCxKL4q24pR7Q
        MzE6yXX5Jb7Z+oEMffS9W20=
X-Google-Smtp-Source: ABdhPJwbX3xod7wvvEB/d3zZVGHJY5A4YWyXa2xzte6qkdeU63HZ09LRuIHNPxmICQE9S8HwPyyjjw==
X-Received: by 2002:a2e:3c0c:: with SMTP id j12mr11121695lja.305.1612789370416;
        Mon, 08 Feb 2021 05:02:50 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id z15sm2001117lji.110.2021.02.08.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 05:02:49 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 8 Feb 2021 14:02:48 +0100
To:     qiang.zhang@windriver.com
Cc:     urezki@gmail.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kvfree_rcu: Release page cache under memory pressure
Message-ID: <20210208130248.GC1920@pc638.lan>
References: <20210207124432.10143-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207124432.10143-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Zqiang.

Thank you for your v4!

Some small nits see below:

> From: Zqiang <qiang.zhang@windriver.com>
> 
> Add free per-cpu existing krcp's page cache operation, when
> the system is under memory pressure.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  v1->v2->v3->v4:
>  During the test a page shrinker is pretty active, because of low memory
>  condition. callback drains it whereas kvfree_rcu() part refill it right
>  away making kind of vicious circle.
>  Through Vlad Rezki suggestion, to avoid this, schedule a periodic delayed
>  work with HZ, and it's easy to do that.
> 
I think the commit message should be improved. Please add a clear
description how it works, i mean its connection with shrinker, etc.

>  kernel/rcu/tree.c | 50 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c1ae1e52f638..f3b772eef468 100644
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
> @@ -3428,15 +3428,22 @@ static void fill_page_cache_func(struct work_struct *work)
>  	atomic_set(&krcp->work_in_progress, 0);
>  }
>  
> +static bool backoff_page_cache_fill;
> +
>  static void
>  run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  {
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> -		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> -			HRTIMER_MODE_REL);
> -		krcp->hrtimer.function = schedule_page_work_fn;
> -		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> +		if (READ_ONCE(backoff_page_cache_fill)) {
Can we just use xchg directly inside "if" statement? So we can
get rid of below WRITE_ONCE(). It is not considered as a "hot"
path, so it should not be an issue.

> +			queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, HZ);
> +			WRITE_ONCE(backoff_page_cache_fill, false);
> +		} else {
> +			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> +				HRTIMER_MODE_REL);
> +			krcp->hrtimer.function = schedule_page_work_fn;
> +			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> +		}
>  	}
>  }

Thank you!

--
Vlad Rezki
