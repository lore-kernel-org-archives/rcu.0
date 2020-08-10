Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F06CC433E0
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7756122BF3
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="H6dVBdBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgHJTWj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgHJTWi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 15:22:38 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF78C061788
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2020 12:22:38 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id o2so4803759qvk.6
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2020 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WwZk/jQSrhtFMjtWr1S/O6qX6d5wxDfE1OWHLpSfbPk=;
        b=H6dVBdBPnzC61+O+TCCIWE9zqW6owuKWHNwRDQthVrmZTQvA2wyarfe0fTz2XFbpiw
         B3vHHEKOSy1heF69daoHQwsYZH4hP1ffC95Pnq8Korv5X7BB3NhveF8VswqaL44Ph407
         F4zcPEzbHeRiLrDnx+eo2cOFUgGFZUillep6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WwZk/jQSrhtFMjtWr1S/O6qX6d5wxDfE1OWHLpSfbPk=;
        b=LWEb7vFBpjS5DI52PD/pWJtPH7Jos6kC6nVLYQ3H6cGwgy2IZRkXNEtDaI0p1ObdJj
         z5h2ZXXupJorV7apyfZl+n1QCjjItzuYsvjwPSe2x+iIgvVaDhjItnZKkgykoQeRLKi9
         l/O1pt4yPD0KurIDhUwgfl6dwA4WPvGfujWsNOhlOAChQrMzinmF06AWYllaiRX8tYzG
         buwBs7Q0iuP+7ROrUijtbiBoe9eY+7xp/viUxHeDdF6Ip5aTTaktEwL74pHZ210RYSZk
         3dl+C8Z70ty8o54UmKUrR9gkcHsBr/mUsC6HvORVeblFQBvhF++ZL9Wacn+bnCsHsy/M
         tVfA==
X-Gm-Message-State: AOAM531j5+gHQpOvwlaQNTALxxJGkD2xLS/4wfKJKwBB2kDW8EdhAl+V
        +gJOvv+MLF62UA8XE+boZ40nqw==
X-Google-Smtp-Source: ABdhPJwwzKXkvlNB6D+Kk9LwCWohyX8lh0wLeySAiGQPzt79MU/gZuJptIns/UDduplhPRvBSSzoIQ==
X-Received: by 2002:a0c:e9c7:: with SMTP id q7mr30561935qvo.195.1597087355190;
        Mon, 10 Aug 2020 12:22:35 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 71sm15123021qkk.125.2020.08.10.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:22:34 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:22:34 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, peterz@infradead.org,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        vineethrp@gmail.com
Subject: Re: [PATCH v4 2/5] rcu/tree: Clarify comments about FQS loop
 reporting quiescent states
Message-ID: <20200810192234.GC2865655@google.com>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-3-joel@joelfernandes.org>
 <20200810180647.GN4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810180647.GN4295@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 10, 2020 at 11:06:47AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 07, 2020 at 01:07:19PM -0400, Joel Fernandes (Google) wrote:
> > At least since v4.19, the FQS loop no longer reports quiescent states
> > for offline CPUs unless it is an emergency.
> > 
> > This commit therefore fixes the comment in rcu_gp_init() to match the
> > current code.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a49fa3b60faa..2fb66cdbfa25 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1701,9 +1701,11 @@ static bool rcu_gp_init(void)
> >  
> >  	/*
> >  	 * Apply per-leaf buffered online and offline operations to the
> > -	 * rcu_node tree.  Note that this new grace period need not wait
> > -	 * for subsequent online CPUs, and that quiescent-state forcing
> > -	 * will handle subsequent offline CPUs.
> > +	 * rcu_node tree. Note that this new grace period need not wait for
> > +	 * subsequent online CPUs, and that RCU hooks in the CPU offlining
> > +	 * path, when combined with checks in this function, will handle CPUs
> > +	 * that are currently going offline or that go offline later. Refer to
> > +	 * RCU's Requirements documentation about hotplug requirements as well.
> >  	 */
> >  	rcu_state.gp_state = RCU_GP_ONOFF;
> >  	rcu_for_each_leaf_node(rnp) {
> 
> Very good!  I pulled this in with light edits as shown below.
> Please let me know if I messed something up.

Yes, looks good, thanks!

 - Joel


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit a6117399840b963f90cc5322ef9ea7c52de639b2
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Fri Aug 7 13:07:19 2020 -0400
> 
>     rcu/tree: Clarify comments about FQS loop reporting quiescent states
>     
>     Since at least v4.19, the FQS loop no longer reports quiescent states
>     for offline CPUs except in emergency situations.
>     
>     This commit therefore fixes the comment in rcu_gp_init() to match the
>     current code.
>     
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bcc6160..59e1943 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1730,10 +1730,13 @@ static bool rcu_gp_init(void)
>  	raw_spin_unlock_irq_rcu_node(rnp);
>  
>  	/*
> -	 * Apply per-leaf buffered online and offline operations to the
> -	 * rcu_node tree.  Note that this new grace period need not wait
> -	 * for subsequent online CPUs, and that quiescent-state forcing
> -	 * will handle subsequent offline CPUs.
> +	 * Apply per-leaf buffered online and offline operations to
> +	 * the rcu_node tree. Note that this new grace period need not
> +	 * wait for subsequent online CPUs, and that RCU hooks in the CPU
> +	 * offlining path, when combined with checks in this function,
> +	 * will handle CPUs that are currently going offline or that will
> +	 * go offline later.  Please also refer to "Hotplug CPU" section
> +	 * of RCU's Requirements documentation.
>  	 */
>  	rcu_state.gp_state = RCU_GP_ONOFF;
>  	rcu_for_each_leaf_node(rnp) {
