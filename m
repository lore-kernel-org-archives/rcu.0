Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75817C4727E
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 17:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8182075F
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 17:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meyG6+Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgIYR5X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYR5X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Sep 2020 13:57:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D08C0613CE;
        Fri, 25 Sep 2020 10:57:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so3211478ljk.0;
        Fri, 25 Sep 2020 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qc8C5BuWST1uydg8EoNF2ju4UjTDacK5SEZlqTCllKE=;
        b=meyG6+ZvcPFziY4WpY5oR3YvfU+BI9qIHUqz72Azt6oK3F1tFukxN/t9HTosveQxqP
         tCAUZh1kdUnDq6b2fkVgjFC73syBrBZRUIRdNxR8PYxQZdNLCgwgpQgLqmEaKAtvrSuf
         6EqNbF+ZaG+Y8+1QqLG38PjssqCK+XKPeS12TNJQemF8+XtmByEl5vu+ezQBb7te342v
         2v6fT/lWbfqu1oicPe6LqrzQwDvMArsoxHiUX/2qq610jZhfEKCyiWQJxQeBk//++lv3
         oyw3L5R6lNk5zKz4oI5YWI2yV0/ALM8KLdkQHqfLGflSt17PoPBq9/LanywgI2WQEUIf
         80Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qc8C5BuWST1uydg8EoNF2ju4UjTDacK5SEZlqTCllKE=;
        b=Ub94G2eQla3P3KBVSUCurrtm5xQ4k691y6oPwebkHBCYZ1DyYT5kd1Fj5nN1YxSQun
         JG/MCCiz/AnGN20S3QLwm6LrRyZhmHDH6ZVRnSG+tNI31vqIYEgQXMIE/o7j+sh4uMmV
         uPKqDnl+pAF/1CsW8v03300lrxPChU5pRNuXLQjRUFe4GAACbv8mDrRGke7opki222jI
         623ulIXMp+QjO0VZJNqcrHpiRbASFf5xaGApd1ttEbpRg65b4eFHk60+rO73YxVNfcNY
         cwM6O+aNIfAYJwSm8EQgJbKdm8Hk4jbFCoLJhD4tTOVfOtD5DjEzk8sYAFagvP2edz6q
         n9gw==
X-Gm-Message-State: AOAM530mHLXnpnC41SkfH2vcBv3hooTqEbo/8NPnja2p7eyAjjkWhWZT
        8gNQlS4wd7nOdETEvmfPCoE=
X-Google-Smtp-Source: ABdhPJz94sA179fF63C9xllvCKTh96mjW5a/yruMDb+NU3BTm8M22Cp6aUinos8LrFlRRve6+pgMLg==
X-Received: by 2002:a2e:86c2:: with SMTP id n2mr1660454ljj.346.1601056641348;
        Fri, 25 Sep 2020 10:57:21 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id c4sm2787794lfr.108.2020.09.25.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:57:20 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 25 Sep 2020 19:57:18 +0200
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200925175718.GA28909@pc636>
References: <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925161712.GM3179@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925161712.GM3179@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 25, 2020 at 05:17:12PM +0100, Mel Gorman wrote:
> On Fri, Sep 25, 2020 at 05:31:29PM +0200, Uladzislau Rezki wrote:
> > > > > > 
> > > > > > All good points!
> > > > > > 
> > > > > > On the other hand, duplicating a portion of the allocator functionality
> > > > > > within RCU increases the amount of reserved memory, and needlessly most
> > > > > > of the time.
> > > > > > 
> > > > > 
> > > > > But it's very similar to what mempools are for.
> > > > > 
> > > > As for dynamic caching or mempools. It requires extra logic on top of RCU
> > > > to move things forward and it might be not efficient way. As a side
> > > > effect, maintaining of the bulk arrays in the separate worker thread
> > > > will introduce other drawbacks:
> > > 
> > > This is true but it is also true that it is RCU to require this special
> > > logic and we can expect that we might need to fine tune this logic
> > > depending on the RCU usage. We definitely do not want to tune the
> > > generic page allocator for a very specific usecase, do we?
> > > 
> > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > to provide a memory service for contexts which are not allowed to
> > sleep, RCU is part of them. Both flags used to provide such ability
> > before but not anymore.
> > 
> > Do you agree with it?
> > 
> 
> I was led to believe that hte problem was taking the zone lock while
> holding a raw spinlock that was specific to RCU.
In RCU code we hold a raw spinlock, because the kfree_rcu() should
follow the call_rcu() rule and work in atomic contexts. So we can
not enter a page allocator because it uses spinlock_t z->lock(is sleepable for RT).

Because of CONFIG_PROVE_RAW_LOCK_NESTING option and CONFIG_PREEMPT_RT.

>
> Are you saying that GFP_ATOMIC/GFP_NOWAIT users are also holding raw
> spinlocks at the same time on RT?
>
I do not say it. And it is not possible because zone->lock has
a spinlock_t type. So, in case of CONFIG_PREEMPT_RT you will
hit a "BUG: scheduling while atomic". If allocator is called
when: raw lock is held or irqs are disabled or preempt_disable()
on a higher level.

--
Vlad Rezki
