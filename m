Return-Path: <SRS0=1SSE=BR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED3C433DF
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEA62224D
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 15:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LIohIIVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgHGPpc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHGPpc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Aug 2020 11:45:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC9DC061757
        for <rcu@vger.kernel.org>; Fri,  7 Aug 2020 08:45:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so1576098qtn.7
        for <rcu@vger.kernel.org>; Fri, 07 Aug 2020 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ti3fqOdIqlQ3qR8alSRUbBOgYNuMnwYJVfSRr0xptkU=;
        b=LIohIIVu+q/iM/Msq4pk2cUT4wKIxHdGh0JmONVclYRwvpTXRrvjhqoMqZDRTA4whC
         dzFDwGiXsdH6AHZq6f9f6JoJDGZSRV5sp1Evqn2zy8rJOyVm8fEe2f/+ImtTimJype2e
         XFRpMXOvOZJDkLQqI5tWRKRHMOjnRni0z6eE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ti3fqOdIqlQ3qR8alSRUbBOgYNuMnwYJVfSRr0xptkU=;
        b=LX4iw4s1bto5xYY52xFPbGoDs7BTpbsnG43V3rcuxcZR2jsgChpR/0P8DfNhIRvysC
         hAeDWzCMtiMwHe4ncdG5zVL3YOw2eNnLqjY0ZEOjZoS9m21bYbiy4m81WThAzCnJjFfX
         BxqWOlYHLU2K3oswySAJCt51cEgX5u5FOebv342k7XDBwP1hhuLlUwKS02z7f85/Tpxh
         66aT1UgMPMetMzMdDaNeuiFgtB9hEJIf+/UBjI7lz6yR6OFBuZUWmpphnmAFLP9Mj16C
         nI7G63wCQz6CmS4lqeFYYMShjVUoAl3l1bev2MzCS8ZW7YstZ67ktAGK//JXJzAlNzXk
         pi6A==
X-Gm-Message-State: AOAM533aAcOpTlD/VItTCzRmZo7nhZca8/YwxuxraMg0aPSIB+t00b9f
        2ojISo1GsPx2lWiewnH78uPeTxP6eIg=
X-Google-Smtp-Source: ABdhPJwLpbk/AwOM/zPDpTdB3A7yJijyMEWUYiClwRPwSl6++M1w6t37CmEO4nJMtycstuXqRviMPw==
X-Received: by 2002:ac8:349a:: with SMTP id w26mr15110226qtb.263.1596815130907;
        Fri, 07 Aug 2020 08:45:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b23sm7874747qtp.41.2020.08.07.08.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 08:45:30 -0700 (PDT)
Date:   Fri, 7 Aug 2020 11:45:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not
 report QS already
Message-ID: <20200807154529.GB2865655@google.com>
References: <20200730030221.705255-1-joel@joelfernandes.org>
 <20200730162159.GZ9247@paulmck-ThinkPad-P72>
 <20200731014222.GA2349603@google.com>
 <20200731034825.GI9247@paulmck-ThinkPad-P72>
 <20200807153732.GA2865655@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807153732.GA2865655@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 07, 2020 at 11:37:32AM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Thu, Jul 30, 2020 at 08:48:25PM -0700, Paul E. McKenney wrote:
> [...]
> > > And I could make the comment here as:
> > > 	/*
> > > 	 * Delete QS reporting from here, by June 2021, if the warning does not
> > >  	 * fire. Leave the warning indefinitely. Check RCU design requirements
> > > 	 * in Documentation/RCU/ about CPU hotplug requirements.
> > > 	 */
> > 
> > Rather than decide for our future selves, could we please just suggest
> > reviewing this on June 2021?  Or, given enterprise distro schedules,
> > 2024.  :-/
> 
> I am replacing it with the following, let me know if any objections, thanks:
> 
> +        * XXX: The following rcu_report_qs_rnp() is redundant. If the below
> +        * warning does not fire, consider replacing it with the "else" block,
> +        * by June 2021 or so. The rationale for this is as follows: The CPU
> +        * onlining path does not need to report QS for an offline CPU. Either
> +        * the QS should have reported during CPU offlining, or during
> +        * rcu_gp_init() if it detected a race with either CPU offlining or
> +        * task unblocking on previously offlined CPUs. To avoid deadlocks
> +        * related to waiting on timers or cpu hotplug locks, only those paths
> +        * do the QS reporting for offline CPUs.

And you did mention you still want the warn-on indefinitely, so I'll document
that in the comment as well.

Now it looks like:

        /*
         * XXX: The following rcu_report_qs_rnp() is redundant. If the below
         * warning does not fire, consider replacing it with the "else" block,
         * by June 2021 or so (while keeping the warning). The rationale for
         * this is as follows: The CPU onlining path does not need to report QS
         * for an offline CPU. Either the QS should have reported during CPU
         * offlining, or during rcu_gp_init() if it detected a race with either
         * CPU offlining or task unblocking on a node with all of its CPUs
         * previously offlined.  To avoid deadlocks related to waiting on
         * timers or cpu hotplug locks, only these paths do the QS reporting
         * for offline CPUs making the following reporting redundant.
         */

thanks,

 - Joel

> 
> thanks,
> 
>  - Joel
> 
> > 
> > 							Thanx, Paul
> > 
> > > I will post my v3 with changes to the requirements document.
> > > 
> > > Let me know any other comments, thanks,
> > > 
> > >  - Joel
> > > 
