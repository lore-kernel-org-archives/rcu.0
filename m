Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04217C433EF
	for <rcu@archiver.kernel.org>; Thu,  2 Jun 2022 23:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbiFBXc2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jun 2022 19:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFBXc1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jun 2022 19:32:27 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9FF9FE3
        for <rcu@vger.kernel.org>; Thu,  2 Jun 2022 16:32:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id br33so3100590qkb.0
        for <rcu@vger.kernel.org>; Thu, 02 Jun 2022 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XqGZjQLwKPzhMCld0pLX+NX09gFdRXY1Sy3dgwMApEM=;
        b=FsEAiQu3EOJQeirdxD1xamPieZqOQS4aWEkoI729jtBwR5DUvtVNFMwxl0S5cHJ3Zb
         +s+dJMf5fLXPRHBmKoNwWmlTBWfQMPpB2LxT2xGomRBoGO4SS0lEO/yRsxqThv6Bi+YH
         gLvY0w6m2rriGN4DU73EHqeWoj0aX3eDwwBFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XqGZjQLwKPzhMCld0pLX+NX09gFdRXY1Sy3dgwMApEM=;
        b=LyLaoRNQ8/t9rEony1tSaZur0JwrMuwmShKytkXKcs12U05lbR8+wzCQDKWszqkMOj
         fM611lcA2qzIdVNMGHA+KrImoaadYvSEQGcMdwt+CLVf9Mdn+nxsH/JVatyrskWK3hj0
         MIOF5CmMc4/riN53YWgEscPp376089sqnfwHJ4qooMDn+z55LebMc7CjwsJ2+Li8Ydfw
         zsf/Our0xCBjxe7HwbuhHr+nL86sWS+DfDi8lv2Q96poZ2JXfyoaunUtkiYIadD3Kotl
         77sESBzfqInMY18hNt4FtTSm6nAKZrdrb29StA+cbpUPax+cJTwyycVDQLvr1Q99lRgk
         BRJQ==
X-Gm-Message-State: AOAM533Zrtkb7S5I0H/jYJcuHHWbHPOHsiYCyXT1QMgV5g0XMWM54Hs/
        8kry8TBXOXVoybp8EMDZ6UJLvQ==
X-Google-Smtp-Source: ABdhPJxSbirZ/FXgCneU/bGF6+9U39VRXx4lOmuzx/bPLpPrcGFKWIRYKV2MkfIWeSjO/FBVxnpLQQ==
X-Received: by 2002:a05:620a:1510:b0:6a3:9b95:196 with SMTP id i16-20020a05620a151000b006a39b950196mr5159796qkk.152.1654212744944;
        Thu, 02 Jun 2022 16:32:24 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id i12-20020a37c20c000000b0069fc13ce20asm3901545qkm.59.2022.06.02.16.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 16:32:24 -0700 (PDT)
Date:   Thu, 2 Jun 2022 23:32:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN]
 interval
Message-ID: <YplIh8BoYXc8X77q@google.com>
References: <20220602080644.432156-1-urezki@gmail.com>
 <20220602080644.432156-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602080644.432156-2-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> Currently the monitor work is scheduled with a fixed interval that
> is HZ/20 or each 50 milliseconds. The drawback of such approach is
> a low utilization of page slot in some scenarios. The page can store
> up to 512 records. For example on Android system it can look like:
> 
> <snip>
>   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
>   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
>   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
>   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
>   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
>   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
>   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
>   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
>   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
>   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
>   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
>   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
>   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
>   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
>   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> <snip>
> 
> where a page only carries few records to reclaim a memory. In order to
> improve batching and make utilization more efficient the patch introduces
> a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> case a memory reclaim occurs more often whereas in mostly idle cases the
> interval is set to its maximum timeout that improves the utilization of
> page slots.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel



> ---
>  kernel/rcu/tree.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fd16c0b46d9e..c02a64995b85 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3249,7 +3249,8 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  
>  
>  /* Maximum number of jiffies to wait before draining a batch. */
> -#define KFREE_DRAIN_JIFFIES (HZ / 50)
> +#define KFREE_DRAIN_JIFFIES_MAX (HZ)
> +#define KFREE_DRAIN_JIFFIES_MIN (HZ / 50)
>  #define KFREE_N_BATCHES 2
>  #define FREE_N_CHANNELS 2
>  
> @@ -3510,6 +3511,26 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
>  	return !!krcp->head;
>  }
>  
> +static void
> +schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> +{
> +	long delay, delay_left;
> +
> +	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ?
> +		KFREE_DRAIN_JIFFIES_MIN:KFREE_DRAIN_JIFFIES_MAX;
> +
> +	if (delayed_work_pending(&krcp->monitor_work)) {
> +		delay_left = krcp->monitor_work.timer.expires - jiffies;
> +
> +		if (delay < delay_left)
> +			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> +
> +		return;
> +	}
> +
> +	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> +}
> +
>  /*
>   * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
>   */
> @@ -3567,7 +3588,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	// work to repeat an attempt. Because previous batches are
>  	// still in progress.
>  	if (need_offload_krc(krcp))
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		schedule_delayed_monitor_work(krcp);
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
> @@ -3755,7 +3776,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		schedule_delayed_monitor_work(krcp);
>  
>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
> @@ -3831,7 +3852,7 @@ void __init kfree_rcu_scheduler_running(void)
>  
>  		raw_spin_lock_irqsave(&krcp->lock, flags);
>  		if (need_offload_krc(krcp))
> -			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +			schedule_delayed_monitor_work(krcp);
>  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  	}
>  }
> -- 
> 2.30.2
> 
