Return-Path: <SRS0=vGyR=6I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ACCC2BA1A
	for <rcu@archiver.kernel.org>; Fri, 24 Apr 2020 04:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF822168B
	for <rcu@archiver.kernel.org>; Fri, 24 Apr 2020 04:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hbylwVse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgDXEQ3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDXEQ3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 Apr 2020 00:16:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724DBC09B045
        for <rcu@vger.kernel.org>; Thu, 23 Apr 2020 21:16:29 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x2so8029328ilp.13
        for <rcu@vger.kernel.org>; Thu, 23 Apr 2020 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jAtHDJaXQSPoo3nlkU9v2knO6zODUCVprDxXUvahvs=;
        b=hbylwVseW+Q4cQX5hp1JKipzdh1CUwDlAXJDMcFr7j/SKwjCcLigYjv9Qmninfrg1S
         C8ZpA8YPu9+bb7UiaB6jK3I4/m6PH5iUK9JBywLRaL5d/gOk2U99cr+DGgdndrFWhsit
         PyX/Z2IGQoRX/MmSv+q+uxCOYkTCbvmIH9Pck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jAtHDJaXQSPoo3nlkU9v2knO6zODUCVprDxXUvahvs=;
        b=C5JzKMlkDDNzpry7Jm0hHSMbgkM2Lz20OskW5bXS42HKmt75IWGhc4fKwzYznfuV53
         LpXOrlE+K7sA9BEAQlLdesqVZnvQ/Nx0bPTk7qZsaYHLsVUZa25PnTpWzJHD/fnyBjYA
         SyU113kuS+dsIbkpZyhjuPJw16RbLMSp1lur4mQ99iISMukf0i4rSKcQyYw/Wc3Xe/St
         AnMKTKRmWhzbEfhE56K0zWNgp55PUXOA5vcX3IUBDAGqNwabzkV1eKix5/iN4QOfnnpF
         mTuO78v2rNAZNrMGCwgr1kUgdE4IUpPFDjYQentrq7BDsUHAYkCi3jM80s6IYKpoe+u7
         B4Xg==
X-Gm-Message-State: AGi0PuZ090c3xu1n8Ya/Wd5pogj3hJOOBUG2lXd1Yl2BezheKS4I6h5u
        /tKtZr6H7nYb3+V17lCsTZ5T5r7buXoqW6f488XGBQ==
X-Google-Smtp-Source: APiQypLx9xEPu8dS1vDdvm9qb8bGXok/ZPGQ0Hw37lDg82ejq0fVG3kbMb6RrvqQdn/HyvHInL+Ow9CgUloYV2kC984=
X-Received: by 2002:a92:194f:: with SMTP id e15mr7143517ilm.78.1587701788804;
 Thu, 23 Apr 2020 21:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200414194353.GQ17661@paulmck-ThinkPad-P72> <20200416103007.GA3925@pc636>
 <20200416131745.GA90777@google.com> <20200416180100.GT17661@paulmck-ThinkPad-P72>
 <20200422145752.GB362484@cmpxchg.org> <20200422153503.GQ17661@paulmck-ThinkPad-P72>
 <20200423174831.GB389168@cmpxchg.org> <20200423180249.GT17661@paulmck-ThinkPad-P72>
 <20200423182750.GA32451@pc636> <20200423192115.GV17661@paulmck-ThinkPad-P72> <20200423195955.GA476@pc636>
In-Reply-To: <20200423195955.GA476@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 24 Apr 2020 00:16:16 -0400
Message-ID: <CAEXW_YSt=yLDS4Fj7atqB_OYiKAvt2472eTKcytEkzVABUMPkQ@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Vlad,
I'm mostly on the same page, some more comments below:

On Thu, Apr 23, 2020 at 4:00 PM Uladzislau Rezki <urezki@gmail.com> wrote:
[snip]
> a) Single argument(headless)
> In this case we can make use an allocator with sleepable flags,
> because we document that headleass variant must follow might_sleep()
> annotation. For example __GFP_NORETRY | __GFP_NOWARN. __GFP_NORETRY
> can do some light direct reclaim, thus the caller can call schedule().
> To do such allocation we just drop our local spinlock.
> If an allocation gets failed, we directly fall into synchronize_rcu()
> i.e. inline freeing.
>
> I also call it sleepable case, that is (a).
>
> b) Double argument(with rcu_head)
> This case we consider as it gets called from atomic context even though
> it can be not. Why we consider such case as atomic: we just assume that.
> The reason is to keep it simple, because it is not possible to detect whether
> a current context is attomic or not(for all type of kernels), i mean the one
> that calls kfree_rcu().
>
> In this case we do not have synchronize_rcu() option. Instead we have an
> object with rcu_head inside. If an allocation gets failed we just make
> use of rcu_head inside the object, regular queuing.
>
> In this case we do not need to hard in order to obtain memory. Therefore
> my question was to Johannes what is best way here. Since we decided to
> minimize reclaiming, whereas GFP_NOWAIT wakes up kswapd if no memory.
> GFP_ATOMIC also is not good, because for (b) we do not need to waste
> it.

I think Johannes said that waking up kswapd is Ok. OTOH, I did not see
the drawback in waking up kswapd to do background reclaim since it
does not happen synchronously right? I think Johannes said we can do
better than just waking kswapd by also doing light direct reclaim
using __GFP_NORETRY but let me know if I missed something.

> > Upon memory-allocation failure, the single-argument kfree_rcu() can leak
> > the memory (it has presumably already splatted) and the double-argument
> > kfree_rcu() can make use of the rcu_head structure that was provided.
> >
> For single argument we inline freeing into current context after
> synchronize_rcu() because it follows might_sleep() annotation.

Yes.

Also, with the additional caching being planned, we could avoid the
chances of hitting the synchronize_rcu inlining.

Thanks,

 - Joel
