Return-Path: <SRS0=ynmX=6R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0AC28CBC
	for <rcu@archiver.kernel.org>; Sun,  3 May 2020 23:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9011206E9
	for <rcu@archiver.kernel.org>; Sun,  3 May 2020 23:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oMly1sWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgECXwP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 19:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgECXwP (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 3 May 2020 19:52:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B5C061A0F
        for <rcu@vger.kernel.org>; Sun,  3 May 2020 16:52:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ep1so7564954qvb.0
        for <rcu@vger.kernel.org>; Sun, 03 May 2020 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLtvOjbp5oM3XIiriCbgUN8dLM1UjPuREO0mz9REyAM=;
        b=oMly1sWksvLY67lLX6WANZYdRCyK9oJLRGKoQUyVbuHrwiSIy+xuJVQiT8/5Pq0bog
         h1n4Gfo7STgKRLD0hmNQAHRqAF5lE16rzbQgJuNSWkOSKDTLF6i3b6EEgTAORICo6DZq
         rw7if/9TaBubZFzuAfUwPl383xLx7nYIab2oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLtvOjbp5oM3XIiriCbgUN8dLM1UjPuREO0mz9REyAM=;
        b=HDZnlGjRVQ4SoP+XNbw3eVJ3hHUgy/6fROH0S4FoK/xjDlR6J/LSJloE2z5ZWZlX13
         qzrN9Yh1YWm2rSVSTZpsessF9bJAych23PMH6Q2tEu0QkhuPLj81BoFjMHdRBOxBn41h
         Bm5ko7ZyknW+ieRZt9bwfs19RZ+F9DfDxNsYK3f8awGqIz59EyC7T95KgpIsNCH/B8/F
         6Jj07DDuBytXbSUsAB2G6sdz4h8T8fa4PXr9e3dOxF1/FzW8LamHPHbFdJ2dCfd2iJUN
         Pi4N99qtf3jUxlj/Xyor5dotWlKwPf0CZlS9S0KHDsbRJhr/4K/4iLQE9wHBTO3fwAYz
         nmwg==
X-Gm-Message-State: AGi0PuZMGwReXEZrv9bRaW/qWbLT0khKJvSV/yytq+WR1ALI932V7Su9
        qKbWcx+VviNU19CQ7a6o7Aft+g==
X-Google-Smtp-Source: APiQypKV4ODc8F/i/nduDwca6QbGelZSJ2JPTAgzxDOJPt2H9HLUN4BQwARzCd3RiyT5KTKSpgFanQ==
X-Received: by 2002:a0c:e052:: with SMTP id y18mr316571qvk.175.1588549934020;
        Sun, 03 May 2020 16:52:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x55sm9443730qtk.3.2020.05.03.16.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 16:52:13 -0700 (PDT)
Date:   Sun, 3 May 2020 19:52:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
Message-ID: <20200503235213.GC197097@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-4-urezki@gmail.com>
 <20200501190555.GB7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501190555.GB7560@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 01, 2020 at 12:05:55PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:58:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Simple clean up of comments in kfree_rcu() code to keep it consistent
> > with majority of commenting styles.
> > 
> > Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Hmmm...
> 
> Exactly why is three additional characters per line preferable?  Or in
> the case of block comments, either one or two additional lines, depending
> on /* */ style?

I prefer to keep the code consistent and then bulk convert it later. Its a
bit ugly to read when its mixed up with "//" and "/* */" right now. We can
convert it to // all at once later but until then it'll be good to keep it
consistent in this file IMO. When I checked the kfree_rcu() code, it had more
"/* */" than not, so this small change is less churn for now.

thanks,

 - Joel

> 
> I am (slowly) moving RCU to "//" for those reasons.  ;-)
> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/tree.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index cd61649e1b00..1487af8e11e8 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3043,15 +3043,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> >  static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> >  					  unsigned long flags)
> >  {
> > -	// Attempt to start a new batch.
> > +	/* Attempt to start a new batch. */
> >  	krcp->monitor_todo = false;
> >  	if (queue_kfree_rcu_work(krcp)) {
> > -		// Success! Our job is done here.
> > +		/* Success! Our job is done here. */
> >  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> >  		return;
> >  	}
> >  
> > -	// Previous RCU batch still in progress, try again later.
> > +	/* Previous RCU batch still in progress, try again later. */
> >  	krcp->monitor_todo = true;
> >  	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > @@ -3151,14 +3151,14 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	unsigned long flags;
> >  	struct kfree_rcu_cpu *krcp;
> >  
> > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > +	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
> >  	krcp = this_cpu_ptr(&krc);
> >  	if (krcp->initialized)
> >  		raw_spin_lock(&krcp->lock);
> >  
> > -	// Queue the object but don't yet schedule the batch.
> > +	/* Queue the object but don't yet schedule the batch. */
> >  	if (debug_rcu_head_queue(head)) {
> > -		// Probable double kfree_rcu(), just leak.
> > +		/* Probable double kfree_rcu(), just leak. */
> >  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> >  			  __func__, head);
> >  		goto unlock_return;
> > @@ -3176,7 +3176,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  
> >  	WRITE_ONCE(krcp->count, krcp->count + 1);
> >  
> > -	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> > +	/* Set timer to drain after KFREE_DRAIN_JIFFIES. */
> >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> >  	    !krcp->monitor_todo) {
> >  		krcp->monitor_todo = true;
> > @@ -3722,7 +3722,7 @@ int rcutree_offline_cpu(unsigned int cpu)
> >  
> >  	rcutree_affinity_setting(cpu, cpu);
> >  
> > -	// nohz_full CPUs need the tick for stop-machine to work quickly
> > +	/* nohz_full CPUs need the tick for stop-machine to work quickly */
> >  	tick_dep_set(TICK_DEP_BIT_RCU);
> >  	return 0;
> >  }
> > -- 
> > 2.20.1
> > 
