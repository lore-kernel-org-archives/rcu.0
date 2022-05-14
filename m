Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D15AC433F5
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 19:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiENTsk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiENTsj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 15:48:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093022529
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 12:48:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 4so13882547ljw.11
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uCGasG0UO106DoVgsTt0iGbaXEWyTt0XRBxQVxznciE=;
        b=Kq+zVyoZlRVtlZ1TIJExnwKBtQj8qQWRrsMZ8eL6aOdOAigbCZPTHEe8RByKUk5v30
         NVgqxxphVToN/c3COxwd2jfjE+VR3c+Eslr2m/mVjYSLcK0962PL4OIDOQE8kD4PFYXz
         /WlHCYXBw5oXIpVyzxJJSMFQjnT0hleQZcC6e4DlUQ05/eL6SHHQOLzEIH1CqVVx1JEB
         lM1hfxLrMkXsnBmf0UhixcGPYqnZTTY9zBNsTil3JB/fwuyC/i6mrvRlmRrFxL5gdGD2
         Z2SB9KR+e91PAPfr/vrRee3feZ7Z9nFPeGTCHI9YioEr3+eOIo9hcpWF625h73FshI0n
         jy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uCGasG0UO106DoVgsTt0iGbaXEWyTt0XRBxQVxznciE=;
        b=axd56/oEIvcYF4uDMGSYtJCfxFVW82zaphKhE5Mi+vXu3h9Y/zA2ec6Ra56S04Wozw
         4uHxC8PWP9EL7NHeKY8zoPkWVlIdd6ik+N7p7SCeU8V7omk2ytnMpt6Nwdm/IZfKZFSu
         kWGWx83nWTwggkCtZOdvtmd3w7D/VP+Vux3wMLHZY8lASzXMpSOHjfeFM1X71SnFmVfY
         o/X4AWs70wRSLNVRimtrU1OIcoMktfQLvcj/RCng6jbZwtkypvHin36IR6gb07VO8h1l
         D7ZxOrDJlFMSFhf7RruCjtaQHfzCyqh/hqUjN5yKR/3GeuJ8ONoUbA/0Qfk0GbdAbZWK
         CxQA==
X-Gm-Message-State: AOAM531HiKrEYbUsvHwt+8lrhwRPyWfPci2ejJYeVtxEK6DGm4q1oqua
        2IGPsqfTOVVXPvfMsfl9e/ZZOru8cKK9jg==
X-Google-Smtp-Source: ABdhPJw88ghjdTKK5lohGk2Syagbp9s/ZBwQrS4bslJ7vLHkPqXejPXPiAjSZm5GqLik5REZHpLfvA==
X-Received: by 2002:a05:651c:552:b0:250:5c23:d0f2 with SMTP id q18-20020a05651c055200b002505c23d0f2mr6567653ljp.239.1652557716185;
        Sat, 14 May 2022 12:48:36 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u8-20020ac24c28000000b0047255d211c7sm793709lfq.246.2022.05.14.12.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 12:48:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sat, 14 May 2022 21:48:33 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 12/14] rcu/kfree: remove useless monitor_todo flag
Message-ID: <YoAHkU1Zi8yRtST0@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-13-joel@joelfernandes.org>
 <Yn5w0fOga4mEHEAt@pc638.lan>
 <Yn++LOrXH615Q1DU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn++LOrXH615Q1DU@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Fri, May 13, 2022 at 04:53:05PM +0200, Uladzislau Rezki wrote:
> > > monitor_todo is not needed as the work struct already tracks if work is
> > > pending. Just use that to know if work is pending using
> > > delayed_work_pending() helper.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 22 +++++++---------------
> > >  1 file changed, 7 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 3baf29014f86..3828ac3bf1c4 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3155,7 +3155,6 @@ struct kfree_rcu_cpu_work {
> > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > >   * @lock: Synchronize access to this structure
> > >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> > > - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> > >   * @initialized: The @rcu_work fields have been initialized
> > >   * @count: Number of objects for which GP not started
> > >   * @bkvcache:
> > > @@ -3180,7 +3179,6 @@ struct kfree_rcu_cpu {
> > >  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > >  	raw_spinlock_t lock;
> > >  	struct delayed_work monitor_work;
> > > -	bool monitor_todo;
> > >  	bool initialized;
> > >  	int count;
> > >  
> > > @@ -3416,9 +3414,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > >  	// of the channels that is still busy we should rearm the
> > >  	// work to repeat an attempt. Because previous batches are
> > >  	// still in progress.
> > > -	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
> > > -		krcp->monitor_todo = false;
> > > -	else
> > > +	if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
>
Can we place those three checks into separate inline function because
it is used in two places: krc_needs_offload()?

> > >  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > >  
> > >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > @@ -3607,10 +3603,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  
> > >  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> > >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > > -	    !krcp->monitor_todo) {
> > > -		krcp->monitor_todo = true;
> > > +	    !delayed_work_pending(&krcp->monitor_work))
>
I think checking weather it is pending or not does not make much sense.
schedule_delayed_work() checks inside if the work can be queued.

> > >  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > > -	}
> > >  
> > >  unlock_return:
> > >  	krc_this_cpu_unlock(krcp, flags);
> > > @@ -3685,14 +3679,12 @@ void __init kfree_rcu_scheduler_running(void)
> > >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > >  
> > >  		raw_spin_lock_irqsave(&krcp->lock, flags);
> > > -		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
> > > -				krcp->monitor_todo) {
> > > -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > -			continue;
> > > +		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head) {
Same here. Move to the separate function, IMHO makes sense.

> > > +			if (delayed_work_pending(&krcp->monitor_work)) {
Same here. Should we check it here?

> > > +				schedule_delayed_work_on(cpu, &krcp->monitor_work,
> > > +						KFREE_DRAIN_JIFFIES);
> > > +			}
> > >  		}
> > > -		krcp->monitor_todo = true;
> > > -		schedule_delayed_work_on(cpu, &krcp->monitor_work,
> > > -					 KFREE_DRAIN_JIFFIES);
> > >  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > >  	}
> > >  }
> > > -- 
> > >
> > Looks good to me from the first glance, but let me know to have a look
> > at it more closely.
> 
> Thanks, I appreciate it.
> 
One change in design after this patch is a drain work can be queued even
though there is already nothing to drain. I do not find it as a big issue
because it will just bail out. So i tend to simplification.

The monitor_todo guarantees that kvfree_rcu() caller will not schedule
any work until "monitor work" completes its job and if there is still to
do something there it rearms itself.

--
Uladzsialu Rezki
