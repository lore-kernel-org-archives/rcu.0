Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90372C433EF
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 14:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381466AbiEMOxM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 May 2022 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381468AbiEMOxK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 May 2022 10:53:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAC6E00C
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:53:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 4so10554229ljw.11
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wrENCMX9tbrq0ZBL6GhYegRZ93TQxU4cZk8EFlc+xso=;
        b=OEn/ZTV6tW317OVgGoOsSeKDi+4bVTuV8F/Vq/7u3iUBon8VWqIL9xLj8kxMiFHENy
         yntPhaIhOR5iZ0bO6cgN5xC4cQi+srdkHdZMTLK73E6Sh0yXjfq+Q9V4zpmd+1G3toYt
         uDdUWLdQOWE5bDk/UPDAHXTn+yilaA02p320Md7aXX9BJdpiI2HBk1OoDh+4iQ5wKwR8
         mznJg0MKLHGFIOPR2JJABwGfmsqcb/BZbscNh5EoVlsLBPEMQ2fF2/sKY2xQft+7Rlk/
         xU0S3ayHHckOrHuFgYakySM88z97Y4d7YH/eYotPiiesnbS2RJ6qnrob87qhf0yV4Oj2
         omUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wrENCMX9tbrq0ZBL6GhYegRZ93TQxU4cZk8EFlc+xso=;
        b=0GpfcnLKLCiueL3eS4MoRv9Mdw0rJI8ns3H6eR++okp7M4GKRD7FhwcSSpmn2Oeaey
         i43bHIU0sNqoJQdGRbHqt7tMwXVn81JNM9dhPhNsAJt6j9zH6HBGb4dTguCKgLUin3yU
         GhhUteGu2s0wjee3XSGVpZUl5rbNpkJyIAhw9euSq4qWxSLm2NAxKUg58H/DK5hOK5sG
         JpKhFI47DaNbDWhnLHZjM5LsAbp8Fo4CrvRyrnzD2+lx7QznmD6ggrTzYvnHo5TrXCxA
         ydXXKJTf06/Kp9PFkBzIvgXFTf/E1gO4m4WcEtvEm0gdp2CMwIAsukg3FJb4lLVbwPFo
         ULWw==
X-Gm-Message-State: AOAM533GP1RZdN0LptM3GAwK3AX1SzAxrT7inGGH9eqbfozCg6gqgvqA
        rvGOGdXWIJERZ3wF55NuqJU=
X-Google-Smtp-Source: ABdhPJyy7syuoiab4pby4Wcqgl8SybKIDNiadg7JuJmFaNwL5YQ/hjZReD5+pdw2UghfEl9MSQMXug==
X-Received: by 2002:a2e:854b:0:b0:24f:b98:e2d2 with SMTP id u11-20020a2e854b000000b0024f0b98e2d2mr3386988ljj.165.1652453587463;
        Fri, 13 May 2022 07:53:07 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id k15-20020a2eb74f000000b0024f3d1daee3sm450237ljo.107.2022.05.13.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:53:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 13 May 2022 16:53:05 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [RFC v1 12/14] rcu/kfree: remove useless monitor_todo flag
Message-ID: <Yn5w0fOga4mEHEAt@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-13-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-13-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> monitor_todo is not needed as the work struct already tracks if work is
> pending. Just use that to know if work is pending using
> delayed_work_pending() helper.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3baf29014f86..3828ac3bf1c4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3155,7 +3155,6 @@ struct kfree_rcu_cpu_work {
>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
>   * @lock: Synchronize access to this structure
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
>   * @initialized: The @rcu_work fields have been initialized
>   * @count: Number of objects for which GP not started
>   * @bkvcache:
> @@ -3180,7 +3179,6 @@ struct kfree_rcu_cpu {
>  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>  	raw_spinlock_t lock;
>  	struct delayed_work monitor_work;
> -	bool monitor_todo;
>  	bool initialized;
>  	int count;
>  
> @@ -3416,9 +3414,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	// of the channels that is still busy we should rearm the
>  	// work to repeat an attempt. Because previous batches are
>  	// still in progress.
> -	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
> -		krcp->monitor_todo = false;
> -	else
> +	if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
>  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> @@ -3607,10 +3603,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> -	    !krcp->monitor_todo) {
> -		krcp->monitor_todo = true;
> +	    !delayed_work_pending(&krcp->monitor_work))
>  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> -	}
>  
>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
> @@ -3685,14 +3679,12 @@ void __init kfree_rcu_scheduler_running(void)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		raw_spin_lock_irqsave(&krcp->lock, flags);
> -		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
> -				krcp->monitor_todo) {
> -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -			continue;
> +		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head) {
> +			if (delayed_work_pending(&krcp->monitor_work)) {
> +				schedule_delayed_work_on(cpu, &krcp->monitor_work,
> +						KFREE_DRAIN_JIFFIES);
> +			}
>  		}
> -		krcp->monitor_todo = true;
> -		schedule_delayed_work_on(cpu, &krcp->monitor_work,
> -					 KFREE_DRAIN_JIFFIES);
>  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  	}
>  }
> -- 
>
Looks good to me from the first glance, but let me know to have a look
at it more closely.

--
Uladzislau Rezki
