Return-Path: <SRS0=4nbA=WG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8EC32751
	for <rcu@archiver.kernel.org>; Sat, 10 Aug 2019 04:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A312085A
	for <rcu@archiver.kernel.org>; Sat, 10 Aug 2019 04:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LELmaU8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfHJEUl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 10 Aug 2019 00:20:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44995 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJEUk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 10 Aug 2019 00:20:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so45704956plr.11
        for <rcu@vger.kernel.org>; Fri, 09 Aug 2019 21:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h7j/foufibETlQ32Z6k1SCaiRJ77bkt8Ugo9Yq1rOBs=;
        b=LELmaU8C8kq7Jesri6jDhMUwdSSKzx0v9ZrWloFMXKBdKIpVGs9ZHFnY3vNJhHefON
         6fV0bHgiDtPqYNmyWMyqaTvki4/yoZt7Ow7v3scvKrqqR/7vPnp7gbn8slIZx9bB5y1y
         K76QrEO/0rdGM0i4+KURajBCae1j05tJ07vAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h7j/foufibETlQ32Z6k1SCaiRJ77bkt8Ugo9Yq1rOBs=;
        b=afKUiAAkzan3vuNThGG3FoDYHGzFDbcU7ev/B60BiGlxjoJzLWvEV6vSXCkOTEAZD4
         rU09plkzkRXhij9ul3cWE/rB9Ne/nqmvoorAo7g5XdUs8ptBq/Am6FaTTVoTPB2V/PhU
         PlEJ4J+6eFbSvCiBjUkaRCjJntV94TaL0VENZMutfHGWBuvcV2p3Ywg3q/7RBTrJVlTx
         SMwB/EhdGgS8mIekBjGU4z6ANH6J29fh132e9E0syWfQlmAckB1dN2l8bNSAly0Denyt
         /g4QLeL2rZxmG34XzJRP+xkd8yuj3D8hMrF2LyNzgwAyMDgXPJ9yPhgu4IAHSOQJlPLj
         fdQg==
X-Gm-Message-State: APjAAAWqO2LCETUAUOGIsSXlIYaOEcH+3T40zzTf/lm4XL0V4TU0A6AH
        xeUMGoN13eK3IYJqZ2BEEso+Dw==
X-Google-Smtp-Source: APXvYqzylXTMf4R3RurcOFNnUxOcppWw+otI4cOKgAJvywb04K+frk4LRL4jHUmzlUev1UeCWzjF/g==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3mr22382047plr.122.1565410840068;
        Fri, 09 Aug 2019 21:20:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d12sm67076005pfn.11.2019.08.09.21.20.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 21:20:39 -0700 (PDT)
Date:   Sat, 10 Aug 2019 00:20:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190810042037.GA175783@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190810024232.GA183658@google.com>
 <20190810033814.GP28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810033814.GP28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 09, 2019 at 08:38:14PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 09, 2019 at 10:42:32PM -0400, Joel Fernandes wrote:
> > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > [snip] 
> > > > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > > > >  {
> > > > > >  	int cpu;
> > > > > >  
> > > > > > +	kfree_rcu_batch_init();
> > > > > 
> > > > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > > > like it should work, but have you tested it?
> > > > > 
> > > > > >  	rcu_early_boot_tests();
> > > > > 
> > > > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > > > call to kfree_rcu_batch_init() here.
> > > > 
> > > > I have not tried to do the kfree_rcu() this early. I will try it out.
> > > 
> > > Yeah, well, call_rcu() this early came as a surprise to me back in the
> > > day, so...  ;-)
> > 
> > I actually did get surprised as well!
> > 
> > It appears the timers are not fully initialized so the really early
> > kfree_rcu() call from rcu_init() does cause a splat about an initialized
> > timer spinlock (even though future kfree_rcu()s and the system are working
> > fine all the way into the torture tests).
> > 
> > I think to resolve this, we can just not do batching until early_initcall,
> > during which I have an initialization function which switches batching on.
> > >From that point it is safe.
> 
> Just go ahead and batch, but don't bother with the timer until
> after single-threaded boot is done.  For example, you could check
> rcu_scheduler_active similar to how sync_rcu_exp_select_cpus() does.
> (See kernel/rcu/tree_exp.h.)

Cool, that works nicely and I tested it. Actually I made it such that we
don't need to batch even, before the scheduler is up. I don't see any benefit
of that unless we can see a kfree_rcu() flood happening that early at boot
which seems highly doubtful as a real world case.

> If needed, use an early_initcall() to handle the case where early boot
> kfree_rcu() calls needed to set the timer but could not.

And it would also need this complexity of early_initcall.

> > Below is the diff on top of this patch, I think this should be good but let
> > me know if anything looks odd to you. I tested it and it works.
> 
> Keep in mind that a call_rcu() callback can't possibly be invoked until
> quite some time after the scheduler is up and running.  So it will be
> a lot simpler to just skip setting the timer during early boot.

Sure. Skipping batching would skip the timer too :-D

If in the future, batching is needed this early, then I am happy to add an
early_initcall to setup the timer for any batched calls that could not setup
the timer. Hope that is ok with you?

thanks,

 - Joel

[snip]

