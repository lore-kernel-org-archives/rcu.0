Return-Path: <SRS0=pjFQ=6H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E4C54FCB
	for <rcu@archiver.kernel.org>; Thu, 23 Apr 2020 20:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A4820776
	for <rcu@archiver.kernel.org>; Thu, 23 Apr 2020 20:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNBqavm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDWUAF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWUAF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Apr 2020 16:00:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA61C09B043;
        Thu, 23 Apr 2020 13:00:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so4680087ljj.11;
        Thu, 23 Apr 2020 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0EyYFzFXUoyAbXr5eyvhApjRihBuPrK6jsEPpntnAs=;
        b=fNBqavm20gs2iawh4ThPooUdZfvlf7avFnA1JRwMXcqUGEcxojE2ffuXkIPdKKGf0k
         qlZi7sFAQNmQuKfoNVnpFJNMRELEkG2eOmnc7n/NXoCBLi8USSKY/gUl+Bq7Ht0sqQ0Q
         IMdjzw5Bn6IiVqyp2KuLOwcB+y4tVdGJRkHS4LGzKA1Vq+PTH8BEFKBFMnGqDV3baZKo
         GvkSgoEq1+n+m0lN2FVqwmQsoWVSS+a9lph+jjnjuc4YF7JHjJtZPOQh8vRo2VEXksSj
         cgbSp1zPGn2M65ufRbWD2d9Q38OWYn5MDsmiYakFhZmk4+dbYMnpjn866J0zr7myHJNV
         LVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0EyYFzFXUoyAbXr5eyvhApjRihBuPrK6jsEPpntnAs=;
        b=alPJJ/C6U90odL/rJhss9DJUxPL3o/DPyztW6hQdrAtujhujjj6JBHqMu2yZyYr03m
         mxbnjJ7cF6g46QL1bcizABiHX2WtYBKuKRFYb8Cw1ur583nrurT92JDbd7iM9zmIF9TV
         qLRkGIGSZdq2YWoYvH90yI2IPoYS0MQfUBKoQzOk9Gd97QYkW0wYEOFibwlcjxdS8JbZ
         rjBOHQftN0eKOrfW3lrLpqDTt00PbipUnSbKDLqyqbLJP1dRCMa0KdJ06XCqvfe8SUlr
         hHfXEag2EuafDJUG6rDi+vAmeVzEeyOy1B/Fs0mqDva7pTFKguATlQaBjG7O2Y3eRjc7
         K9Hw==
X-Gm-Message-State: AGi0PubSzm4BGiUMYoGr3jTzzr11zEE4jtw2i1Pc+Jd/+ICj6A3KaAtS
        gI+ZFYURmy9vVSzG0J2jYYA=
X-Google-Smtp-Source: APiQypKT5PMzoPa1w048eywQjISMekk6uoq/ZIgvUpORwTv/nZO8WiPHRAWnyvC7QWwLAYG4kk0GVg==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr3605678ljw.71.1587672003475;
        Thu, 23 Apr 2020 13:00:03 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u16sm2979725ljk.9.2020.04.23.13.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:00:02 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 23 Apr 2020 21:59:55 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200423195955.GA476@pc636>
References: <20200414194353.GQ17661@paulmck-ThinkPad-P72>
 <20200416103007.GA3925@pc636>
 <20200416131745.GA90777@google.com>
 <20200416180100.GT17661@paulmck-ThinkPad-P72>
 <20200422145752.GB362484@cmpxchg.org>
 <20200422153503.GQ17661@paulmck-ThinkPad-P72>
 <20200423174831.GB389168@cmpxchg.org>
 <20200423180249.GT17661@paulmck-ThinkPad-P72>
 <20200423182750.GA32451@pc636>
 <20200423192115.GV17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423192115.GV17661@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > > > 
> > > > > Thank you for looking this over and for the feedback!
> > > > > 
> > > > > Good point on the sleeping.  My assumption has been that sleeping waiting
> > > > > for a grace period was highly likely to allow memory to eventually be
> > > > > freed, and that there is a point of diminishing returns beyond which
> > > > > adding additional tasks to the reclaim effort does not help much.
> > > > 
> > > > There is when the VM is struggling, but not necessarily when there is
> > > > simply a high, concurrent rate of short-lived file cache allocations.
> > > > 
> > > > Kswapd can easily reclaim gigabytes of clean page cache each second,
> > > > but there might be enough allocation concurrency from other threads to
> > > > starve a kfree_rcu() that only makes a very cursory attempt at getting
> > > > memory out of being able to snap up some of those returns.
> > > > 
> > > > In that scenario it makes sense to be a bit more persistent, or even
> > > > help scale out the concurrency of reclaim to that of allocations.
> > > > 
> > > > > Here are some strategies right offhand when sleeping is required:
> > > > > 
> > > > > 1.	Always sleep in synchronize_rcu() in order to (with high
> > > > > 	probability) free the memory.  This might mean that the reclaim
> > > > > 	effort goes slower than would be good.
> > > > > 
> > > > > 2.	Always sleep in the memory allocator in order to help reclaim
> > > > > 	along.	(This is a strawman version of what I expect your
> > > > > 	proposal really is, but putting it here for completeness, please
> > > > > 	see below.)
> > > > > 
> > > > > 3.	Always sleep in the memory allocator in order to help reclaim
> > > > > 	along, but return failure at some point.  Then the caller
> > > > > 	invokes synchronize_rcu().  When to return failure?
> > > > > 
> > > > > 	o	After some substantial but limited amount of effort has
> > > > > 		been spent on reclaim.
> > > > > 
> > > > > 	o	When it becomes likely that further reclaim effort
> > > > > 		is not going to free up additional memory.
> > > > > 
> > > > > I am guessing that you are thinking in terms of specifying GFP flags to
> > > > > result in some variant of #3.
> > > > 
> > > > Yes, although I would add
> > > > 
> > > > 	o	After making more than one attempt at the freelist to
> > > > 		prevent merely losing races when the allocator/reclaim
> > > > 		subsystem is mobbed by a high concurrency of requests.
> > > > 
> > > > __GFP_NORETRY (despite its name) accomplishes this.
> > > > 
> > > > __GFP_RETRY_MAYFAIL is yet more persistent, but may retry for quite a
> > > > while if the allocation keeps losing the race for a page. This
> > > > increases the chance of the allocation eventually suceeding, but also
> > > > the risk of 1) trying to get memory for longer than a
> > > > synchronize_rcu() might have taken and 2) exerting more temporary
> > > > memory pressure on the workload* than might be productive.
> > > > 
> > > > So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
> > > > further decisions based on instrumentation of the success rates of
> > > > these opportunistic allocations.
> > > > 
> > > > * Reclaim and OOM handling will be fine since no reserves are tapped
> > > 
> > > Thank you for the explanation!  Makes sense to me!!!
> > > 
> > > Joel, Vlad, does this seem reasonable?
> > >
> > To me that makes sense. I think such strategy does fit to what we do,
> > i mean we need to release memory asap. Doing it without initiating of
> > long process of memory reclaim and do it only lightly(what __GFP_NORETRY does)
> > is a good approach. We have an option to fallback to synchronize_rcu().
> > 
> > But that is for sleepable context.
> > 
> > I have a question about non-sleeping context as well and how we allocate one
> > page:
> > 
> > <snip>
> >    bnode = (struct kvfree_rcu_bulk_data *)
> >        __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > 
> > <snip>
> > 
> > Johannes, i saw you mentioned earlier that waking up a kswapd is not a
> > good idea, what actually GFP_NOWAIT does. Do you recommend to exclude
> > it? Also to replace by what? __GFP_HIGH|__GFP_ATOMIC?
> 
> This is best-effort, correct?
> 
a) Single argument(headless)
In this case we can make use an allocator with sleepable flags,
because we document that headleass variant must follow might_sleep()
annotation. For example __GFP_NORETRY | __GFP_NOWARN. __GFP_NORETRY
can do some light direct reclaim, thus the caller can call schedule().
To do such allocation we just drop our local spinlock.

If an allocation gets failed, we directly fall into synchronize_rcu()
i.e. inline freeing.

I also call it sleepable case, that is (a).

b) Double argument(with rcu_head)
This case we consider as it gets called from atomic context even though
it can be not. Why we consider such case as atomic: we just assume that.
The reason is to keep it simple, because it is not possible to detect whether
a current context is attomic or not(for all type of kernels), i mean the one
that calls kfree_rcu().

In this case we do not have synchronize_rcu() option. Instead we have an
object with rcu_head inside. If an allocation gets failed we just make
use of rcu_head inside the object, regular queuing.

In this case we do not need to hard in order to obtain memory. Therefore
my question was to Johannes what is best way here. Since we decided to
minimize reclaiming, whereas GFP_NOWAIT wakes up kswapd if no memory.
GFP_ATOMIC also is not good, because for (b) we do not need to waste
it.

>
> Upon memory-allocation failure, the single-argument kfree_rcu() can leak
> the memory (it has presumably already splatted) and the double-argument
> kfree_rcu() can make use of the rcu_head structure that was provided.
>
For single argument we inline freeing into current context after
synchronize_rcu() because it follows might_sleep() annotation.

Sorry for long email, i hope i covered everything :)

--
Vlad Rezki
