Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE63C433F5
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 14:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiENOf3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiENOf1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 10:35:27 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17724201A6
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:35:26 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id hh4so9239133qtb.10
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kQmO86aj6VfDWI2cccfrc7HKv/pZDaVHtsdXoyk6k2c=;
        b=CYkDW4+nyP2lUNk/mKUt8bGlMdeAKobp0EyrAcfBlSEfJsK5/g6Ygi6zsXmRwIL+AJ
         vLuXjwM3+t3G0M3sp8JUj2EWUDBoZ+/BB0OkosnDWD70w7aYuE4vjdlzH5Y82qyHD3EM
         Wr+XBsehKBukP3AsXdP0Hqi49TjAkXcJoEePM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kQmO86aj6VfDWI2cccfrc7HKv/pZDaVHtsdXoyk6k2c=;
        b=San9d5a4XXXWeEFDAVF2+I+SHYQ+PswPnnlhbeLFJgPCw5prEjrdHLpixkoGWvhPvv
         o8fLrNz6Dkx07Xt6YbpAzpjJP45R64ap4dr1l9OFF4XhbKUadKm+18D504pQyISoL8tv
         EkQWxOS3JICVXp+gAfGWYCL0YTGNsyGF0CQlBqbSOg77T541fEfcym3FBrCkqG6FJWv3
         oeyO11nJP/uRe5XdUyTvRmhS/mhWTmiLjDH1ogOKEsVCQO14ZOAlRQSQwYmMdxxDur+c
         E1Ce9Aqqr6tvkGXhy3zxMux5546e/yP5/iwUNkm8ISeI5J1fgQqDBiIEt469Y9txY1P7
         CTlQ==
X-Gm-Message-State: AOAM533WMjUKfM7CltEfuBNsHPosJ9cNWWf4nB9BKT8l2Kf8tNZSIFD0
        8vbH1a3+ubpaxL1ZF5GcLK9FXA==
X-Google-Smtp-Source: ABdhPJwsJUtHsnapzhw2b++3EfwjMpkkKp2CC7ZVoBnqhZdUiBswGGnDVHkUsIBy397ik5bRHxp8zQ==
X-Received: by 2002:ac8:5bce:0:b0:2f3:e20a:2fd2 with SMTP id b14-20020ac85bce000000b002f3e20a2fd2mr8846098qtb.455.1652538925220;
        Sat, 14 May 2022 07:35:25 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id d81-20020a379b54000000b006a10aa7908dsm2764445qke.38.2022.05.14.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:35:24 -0700 (PDT)
Date:   Sat, 14 May 2022 14:35:24 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [RFC v1 12/14] rcu/kfree: remove useless monitor_todo flag
Message-ID: <Yn++LOrXH615Q1DU@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-13-joel@joelfernandes.org>
 <Yn5w0fOga4mEHEAt@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn5w0fOga4mEHEAt@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 13, 2022 at 04:53:05PM +0200, Uladzislau Rezki wrote:
> > monitor_todo is not needed as the work struct already tracks if work is
> > pending. Just use that to know if work is pending using
> > delayed_work_pending() helper.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 22 +++++++---------------
> >  1 file changed, 7 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 3baf29014f86..3828ac3bf1c4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3155,7 +3155,6 @@ struct kfree_rcu_cpu_work {
> >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> >   * @lock: Synchronize access to this structure
> >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> > - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> >   * @initialized: The @rcu_work fields have been initialized
> >   * @count: Number of objects for which GP not started
> >   * @bkvcache:
> > @@ -3180,7 +3179,6 @@ struct kfree_rcu_cpu {
> >  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> >  	raw_spinlock_t lock;
> >  	struct delayed_work monitor_work;
> > -	bool monitor_todo;
> >  	bool initialized;
> >  	int count;
> >  
> > @@ -3416,9 +3414,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
> >  	// of the channels that is still busy we should rearm the
> >  	// work to repeat an attempt. Because previous batches are
> >  	// still in progress.
> > -	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
> > -		krcp->monitor_todo = false;
> > -	else
> > +	if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
> >  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> >  
> >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > @@ -3607,10 +3603,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  
> >  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > -	    !krcp->monitor_todo) {
> > -		krcp->monitor_todo = true;
> > +	    !delayed_work_pending(&krcp->monitor_work))
> >  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > -	}
> >  
> >  unlock_return:
> >  	krc_this_cpu_unlock(krcp, flags);
> > @@ -3685,14 +3679,12 @@ void __init kfree_rcu_scheduler_running(void)
> >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >  
> >  		raw_spin_lock_irqsave(&krcp->lock, flags);
> > -		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
> > -				krcp->monitor_todo) {
> > -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > -			continue;
> > +		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head) {
> > +			if (delayed_work_pending(&krcp->monitor_work)) {
> > +				schedule_delayed_work_on(cpu, &krcp->monitor_work,
> > +						KFREE_DRAIN_JIFFIES);
> > +			}
> >  		}
> > -		krcp->monitor_todo = true;
> > -		schedule_delayed_work_on(cpu, &krcp->monitor_work,
> > -					 KFREE_DRAIN_JIFFIES);
> >  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> >  	}
> >  }
> > -- 
> >
> Looks good to me from the first glance, but let me know to have a look
> at it more closely.

Thanks, I appreciate it.

 - Joel

