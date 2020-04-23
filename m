Return-Path: <SRS0=pjFQ=6H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E17C55191
	for <rcu@archiver.kernel.org>; Thu, 23 Apr 2020 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D820781
	for <rcu@archiver.kernel.org>; Thu, 23 Apr 2020 17:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="AWsdxyLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgDWRsf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729899AbgDWRse (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Apr 2020 13:48:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B67DC09B043
        for <rcu@vger.kernel.org>; Thu, 23 Apr 2020 10:48:34 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e17so2169136qtp.7
        for <rcu@vger.kernel.org>; Thu, 23 Apr 2020 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FAZ52cnk3wcvUt1W/Ed1mVvAWy8GxOI+H5ExGJW5XyE=;
        b=AWsdxyLZGVXs8t4INrRYy61Nt0tvLnKMuwSCfex/23YKQoH319UNdp4xtCnRcJYHqg
         zE9AOzgoLZMjH2UPrTV3qXzkJPHYE32f2FdR2pdF7NUakkA/c8oL4ThIYHClpWVQNiDA
         7Z8GvTDJCFTwwijushsuSosuR/eUl6Wv6z0+d5DeC1zhfEbjpYfpFZvuYl9QW3TrzyBI
         bplLPjN6F4jj6GT0mLTjRBc23N6n8y/tJz+CT5jC2nywVaHX0hEKDMRY6YhzN7ljgtci
         KbleDyI9YaVtWNOhDHm4mR9lUiE+SaYlFAOKqbomiySEKQJmdMwdm+HIiVJeRJpj5q7q
         bENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FAZ52cnk3wcvUt1W/Ed1mVvAWy8GxOI+H5ExGJW5XyE=;
        b=IHD+6D2q6DyWLMwkZtWVwNJXqhGcuw2lM0Mlf4a3rbujPXFEEJiX/fHA+yPwx/zpR/
         8owC1HtRGMq9YKMSsdRGVYHq8Zqdg1KdbjLwDq+Eu/NFRENJw6jWHYK5r83BtK3hCoFM
         Yqi0hMRqQYqgwOYScQADb43kmTs3+QNjSXK8HtHyq9vJP6urDSjRaOFZH/AeVCnHyGlA
         qTtVLrVjoffIUsx5vAxCNGwBSpL3p08ATxjeFVHKPH1H59Yzc64jJ3uSLICCmNVloSMq
         /Rc6jwj/Xc9FQQHcL6WtJHAiiJXWXK0W0MCmfhQ2cuIFPlGSs/WM35cwQJJMgEMOBMpi
         NNvw==
X-Gm-Message-State: AGi0PuYqcee3J8+YtIHpt4G/lBPJ8uyUhqbUR5Ga8k8zfrNviJFr4koz
        K6mVCNW767Vau+PXDNPLS2+uyw==
X-Google-Smtp-Source: APiQypLEN1T1zc6utFfcpFpNfXeYSAKOqC86P82XokUCisOw41VJu4GyH5s3kbMvIDB4V8SfvLo4Yw==
X-Received: by 2002:aed:2943:: with SMTP id s61mr4966542qtd.299.1587664113540;
        Thu, 23 Apr 2020 10:48:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id y17sm1852318qky.33.2020.04.23.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 10:48:32 -0700 (PDT)
Date:   Thu, 23 Apr 2020 13:48:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200423174831.GB389168@cmpxchg.org>
References: <20200413211504.108086-1-joel@joelfernandes.org>
 <20200414194353.GQ17661@paulmck-ThinkPad-P72>
 <20200416103007.GA3925@pc636>
 <20200416131745.GA90777@google.com>
 <20200416180100.GT17661@paulmck-ThinkPad-P72>
 <20200422145752.GB362484@cmpxchg.org>
 <20200422153503.GQ17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422153503.GQ17661@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 22, 2020 at 08:35:03AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 22, 2020 at 10:57:52AM -0400, Johannes Weiner wrote:
> > On Thu, Apr 16, 2020 at 11:01:00AM -0700, Paul E. McKenney wrote:
> > > On Thu, Apr 16, 2020 at 09:17:45AM -0400, Joel Fernandes wrote:
> > > > On Thu, Apr 16, 2020 at 12:30:07PM +0200, Uladzislau Rezki wrote:
> > > > > I have a question about dynamic attaching of the rcu_head. Do you think
> > > > > that we should drop it? We have it because of it requires 8 + syzeof(struct rcu_head)
> > > > > bytes and is used when we can not allocate 1 page what is much more for array purpose.
> > > > > Therefore, dynamic attaching can succeed because of using SLAB and requesting much
> > > > > less memory then one page. There will be higher chance of bypassing synchronize_rcu()
> > > > > and inlining freeing on a stack.
> > > > > 
> > > > > I agree that we should not use GFP_* flags instead we could go with GFP_NOWAIT |
> > > > > __GFP_NOWARN when head attaching only. Also dropping GFP_ATOMIC to keep
> > > > > atomic reserved memory for others.
> > > 
> > > I must defer to people who understand the GFP flags better than I do.
> > > The suggestion of __GFP_RETRY_MAYFAIL for no memory pressure (or maybe
> > > when the CPU's reserve is not yet full) and __GFP_NORETRY otherwise came
> > > from one of these people.  ;-)
> > 
> > The exact flags we want here depends somewhat on the rate and size of
> > kfree_rcu() bursts we can expect. We may want to start with one set
> > and instrument allocation success rates.
> > 
> > Memory tends to be fully consumed by the filesystem cache, so some
> > form of light reclaim is necessary for almost all allocations.
> > 
> > GFP_NOWAIT won't do any reclaim by itself, but it'll wake kswapd.
> > Kswapd maintains a small pool of free pages so that even allocations
> > that are allowed to enter reclaim usually don't have to. It would be
> > safe for RCU to dip into that.
> > 
> > However, there are some cons to using it:
> > 
> > - Depending on kfree_rcu() burst size, this pool could exhaust (it's
> > usually about half a percent of memory, but is affected by sysctls),
> > and then it would fail NOWAIT allocations until kswapd has caught up.
> > 
> > - This pool is shared by all GFP_NOWAIT users, and many (most? all?)
> > of them cannot actually sleep. Often they would have to drop locks,
> > restart list iterations, or suffer some other form of deterioration to
> > work around failing allocations.
> > 
> > Since rcu wouldn't have anything better to do than sleep at this
> > juncture, it may as well join the reclaim effort.
> > 
> > Using __GFP_NORETRY or __GFP_RETRY_MAYFAIL would allow them that
> > without exerting too much pressure on the VM.
> 
> Thank you for looking this over and for the feedback!
> 
> Good point on the sleeping.  My assumption has been that sleeping waiting
> for a grace period was highly likely to allow memory to eventually be
> freed, and that there is a point of diminishing returns beyond which
> adding additional tasks to the reclaim effort does not help much.

There is when the VM is struggling, but not necessarily when there is
simply a high, concurrent rate of short-lived file cache allocations.

Kswapd can easily reclaim gigabytes of clean page cache each second,
but there might be enough allocation concurrency from other threads to
starve a kfree_rcu() that only makes a very cursory attempt at getting
memory out of being able to snap up some of those returns.

In that scenario it makes sense to be a bit more persistent, or even
help scale out the concurrency of reclaim to that of allocations.

> Here are some strategies right offhand when sleeping is required:
> 
> 1.	Always sleep in synchronize_rcu() in order to (with high
> 	probability) free the memory.  This might mean that the reclaim
> 	effort goes slower than would be good.
> 
> 2.	Always sleep in the memory allocator in order to help reclaim
> 	along.	(This is a strawman version of what I expect your
> 	proposal really is, but putting it here for completeness, please
> 	see below.)
> 
> 3.	Always sleep in the memory allocator in order to help reclaim
> 	along, but return failure at some point.  Then the caller
> 	invokes synchronize_rcu().  When to return failure?
> 
> 	o	After some substantial but limited amount of effort has
> 		been spent on reclaim.
> 
> 	o	When it becomes likely that further reclaim effort
> 		is not going to free up additional memory.
> 
> I am guessing that you are thinking in terms of specifying GFP flags to
> result in some variant of #3.

Yes, although I would add

	o	After making more than one attempt at the freelist to
		prevent merely losing races when the allocator/reclaim
		subsystem is mobbed by a high concurrency of requests.

__GFP_NORETRY (despite its name) accomplishes this.

__GFP_RETRY_MAYFAIL is yet more persistent, but may retry for quite a
while if the allocation keeps losing the race for a page. This
increases the chance of the allocation eventually suceeding, but also
the risk of 1) trying to get memory for longer than a
synchronize_rcu() might have taken and 2) exerting more temporary
memory pressure on the workload* than might be productive.

So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
further decisions based on instrumentation of the success rates of
these opportunistic allocations.

* Reclaim and OOM handling will be fine since no reserves are tapped
