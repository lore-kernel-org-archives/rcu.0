Return-Path: <SRS0=HCMS=WM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C2C3A59C
	for <rcu@archiver.kernel.org>; Fri, 16 Aug 2019 17:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77E62086C
	for <rcu@archiver.kernel.org>; Fri, 16 Aug 2019 17:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SDCg1M2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfHPRfW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:35:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39084 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfHPRfW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Aug 2019 13:35:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so3272007pgi.6
        for <rcu@vger.kernel.org>; Fri, 16 Aug 2019 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yWBq0VtKejgqsAuflTdd8kSUS6V0VNEsdv0fzvV5PpM=;
        b=SDCg1M2cACRBAdDZ0z6b1Qj1GmU0MgFaOiv8jKHv9FehGxH8q5lKiNBErsO/C28Z2Z
         WsqsgGBykFHHpB4R3jcpBOfAq/pXND4CC1DduwW2aOR+vG0uVoY38OG9Mg+eigTvZUZk
         Oi/xfUVhWi6rUsKNceQwTRMFWl+DkYlJqkoy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yWBq0VtKejgqsAuflTdd8kSUS6V0VNEsdv0fzvV5PpM=;
        b=JaC9SQ4JI7F/2ID9+QexLBURRzFv2wXX9EB+X0oGwHNESK4wGpidaIj6vKsRBZCopE
         shRzKdbKarzQ0Y2deahF7YAl/4nE5LRxgYJ+CQ0f2Wcesr6svzCVxnUSykmgrFv74m18
         IVnfpjiq/sEs2tdaQq0wox8V757YCncXUcihc2FcQ8d7pajja8wYi9LIi0QGcwJ2TbpP
         KbWIHmicNMdoLn+1Q/FGg00TmLd0FPEcm5hzOZ65N2L2trABK2mxgpN4V6cNVNoeqhif
         IRYInhF7Nd71E6CZeyt2sJPlamj0MILuodOby7jom6zRppRr3K9+Ck0s7iipqAe3Xq31
         qrPg==
X-Gm-Message-State: APjAAAWsE1ws0RjZcCahCXZMsGmDOzqyBP2CbaAbVu4yOLFwNU5LIaZm
        FwwM2nUgy9YfVDc4VNPOFb6odw==
X-Google-Smtp-Source: APXvYqykRyDI/UCBuvtjOjEQOMGkuc2ui6yJ/9XKKsPAWs2mnMOf2icH9UZlNFxibGfyYay+ibkQHw==
X-Received: by 2002:aa7:8b10:: with SMTP id f16mr12098631pfd.44.1565976921490;
        Fri, 16 Aug 2019 10:35:21 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id j20sm6057599pfr.113.2019.08.16.10.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 10:35:20 -0700 (PDT)
Date:   Fri, 16 Aug 2019 13:35:04 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH -rcu dev 1/3] rcu/tree: tick_dep_set/clear_cpu should
 accept bits instead of masks
Message-ID: <20190816173504.GD10481@google.com>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816172529.GU28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816172529.GU28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 16, 2019 at 10:25:29AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 15, 2019 at 10:53:09PM -0400, Joel Fernandes (Google) wrote:
> > This commit fixes the issue.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> And I am squashing these into their respective commits with attribution.
> Good eyes, thank you very much!!!

Thank you!!

 - Joel

> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/tree.c | 29 +++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 0512de9ead20..322b1b57967c 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -829,7 +829,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  		   !rdp->dynticks_nmi_nesting &&
> >  		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> >  		rdp->rcu_forced_tick = true;
> > -		tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> >  	}
> >  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> >  			  rdp->dynticks_nmi_nesting,
> > @@ -898,7 +898,7 @@ void rcu_irq_enter_irqson(void)
> >  void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
> >  {
> >  	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
> > -		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > +		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> >  		rdp->rcu_forced_tick = false;
> >  	}
> >  }
> > @@ -2123,8 +2123,9 @@ int rcutree_dead_cpu(unsigned int cpu)
> >  	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
> >  
> >  	// Stop-machine done, so allow nohz_full to disable tick.
> > -	for_each_online_cpu(c)
> > -		tick_dep_clear_cpu(c, TICK_DEP_MASK_RCU);
> > +	for_each_online_cpu(c) {
> > +		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);
> > +	}
> >  	return 0;
> >  }
> >  
> > @@ -2175,8 +2176,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >  	rcu_nocb_unlock_irqrestore(rdp, flags);
> >  
> >  	/* Invoke callbacks. */
> > -	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
> > -		tick_dep_set_task(current, TICK_DEP_MASK_RCU);
> > +	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> > +		tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> > +	}
> >  	rhp = rcu_cblist_dequeue(&rcl);
> >  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> >  		debug_rcu_head_unqueue(rhp);
> > @@ -2243,8 +2245,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >  	/* Re-invoke RCU core processing if there are callbacks remaining. */
> >  	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
> >  		invoke_rcu_core();
> > -	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
> > -		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);
> > +	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> > +		tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
> > +	}
> >  }
> >  
> >  /*
> > @@ -3118,8 +3121,9 @@ int rcutree_online_cpu(unsigned int cpu)
> >  	rcutree_affinity_setting(cpu, -1);
> >  
> >  	// Stop-machine done, so allow nohz_full to disable tick.
> > -	for_each_online_cpu(c)
> > -		tick_dep_clear_cpu(c, TICK_DEP_MASK_RCU);
> > +	for_each_online_cpu(c) {
> > +		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);
> > +	}
> >  	return 0;
> >  }
> >  
> > @@ -3143,8 +3147,9 @@ int rcutree_offline_cpu(unsigned int cpu)
> >  	rcutree_affinity_setting(cpu, cpu);
> >  
> >  	// nohz_full CPUs need the tick for stop-machine to work quickly
> > -	for_each_online_cpu(c)
> > -		tick_dep_set_cpu(c, TICK_DEP_MASK_RCU);
> > +	for_each_online_cpu(c) {
> > +		tick_dep_set_cpu(c, TICK_DEP_BIT_RCU);
> > +	}
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.23.0.rc1.153.gdeed80330f-goog
> > 
> 
