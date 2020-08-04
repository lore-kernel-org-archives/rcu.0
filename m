Return-Path: <SRS0=f/Ck=BO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B73C433DF
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 19:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A06205CB
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 19:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m09AJlMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHDTqb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHDTqb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Aug 2020 15:46:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A9CC06174A;
        Tue,  4 Aug 2020 12:46:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so45001511ljc.5;
        Tue, 04 Aug 2020 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lVyMcxcvmmyedeYfSbK8qbRXCIO+2OgkI4z04nWhYYk=;
        b=m09AJlMvueFhhbTA1t9QQyo+47mlsSJWTqYoKzSkiAXhoyT6Bc1oUMTnhvSG4R6EKe
         uoz7TjrPfa7L7PPvmXKYxDrnfOD4LR4Lm8hEooFiDUerzu/KLknRDodgJKFXWZq8Cc4R
         KfYw0QSUWDVTzbicjTsbc12ZJJJN12E468mjIOGt98wqlwLW3G5vBQwh8BW57MmzvSYB
         H/gxqYF9m5gHj+1YhSI4/D3ifRghP4ZSHybeT/wQ441bGXyf8/ULHjft7zkD5nRd8xYX
         VNG6t1Q9kwZ/90WJ82HNOUlezHGqM09S1frZyfKwmWIs0eeCz31PeYBxYe3lHZj0gbaH
         3hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lVyMcxcvmmyedeYfSbK8qbRXCIO+2OgkI4z04nWhYYk=;
        b=pQFL6bNr5FdEX7wmWU0Q+sis3wuKupRUPueYXqqwKxhs04CGyb+sbQIjElPgPQUSjk
         MVPbU3/q63MjW+sGRnTc0ZsSn/o1DAHf/lPg1lwgnemxMA7qEy2rjAgARx5uGqmpyB9S
         nnuOpQzj8g2op0zU0fdmTtuovzKPHlj9IXf+dhy25Mtc9vu2vo79r+SqybYyipVUyHnC
         uY2/PZNHKNorXBEGIoWTWy79L9pZpYYR59ziBJbhoRB4j4IRj12pkxz4tBf9fvWW3BxF
         L4h93GPZfJHeymTGJO74GtCXpcXmJ7o1DQxIUldr10BR//kH9UB+xShZOnVqkSybyA6i
         y9QQ==
X-Gm-Message-State: AOAM531zLspoF7FQMjA/m8D2amP36QeG2lod5SWFZlYMJ9t1oatWPzYV
        uLQctIoOzBDx5Z2L5d/9azLSP7ek8/k=
X-Google-Smtp-Source: ABdhPJzzOZvIuTyEZKdf+mwYJ1WWzQAEpHHreWcGzjDLXmFJ/lzDR13WoFK3Km6HNb7uAbA1bxxvug==
X-Received: by 2002:a2e:898d:: with SMTP id c13mr5704120lji.236.1596570388380;
        Tue, 04 Aug 2020 12:46:28 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z25sm283372ljz.13.2020.08.04.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 12:46:27 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 4 Aug 2020 21:46:25 +0200
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PROTOTYPE 1/1] mm: Add __GFP_FAST_TRY flag
Message-ID: <20200804194625.GA29837@pc636>
References: <20200803163029.1997-1-urezki@gmail.com>
 <1d50a46a-b97f-96b2-8a5c-21075f022f01@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d50a46a-b97f-96b2-8a5c-21075f022f01@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 04, 2020 at 07:02:14PM +0200, Vlastimil Babka wrote:
> On 8/3/20 6:30 PM, Uladzislau Rezki (Sony) wrote:
> > Some background and kfree_rcu()
> > ===============================
> > The pointers to be freed are stored in the per-cpu array to improve
> > performance, to enable an easier-to-use API, to accommodate vmalloc
> > memmory and to support a single argument of the kfree_rcu() when only
> > a pointer is passed. More details are below.
> > 
> > In order to maintain such per-CPU arrays there is a need in dynamic
> > allocation when a current array is fully populated and a new block is
> > required. See below the example:
> > 
> >  0 1 2 3      0 1 2 3
> > |p|p|p|p| -> |p|p|p|p| -> NULL
> > 
> > there are two pointer-blocks, each one can store 4 addresses
> > which will be freed after a grace period is passed. In reality
> > we store PAGE_SIZE / sizeof(void *).
> 
> So what do you actually have without the dynamic allocation, 8 addresses or
> PAGE_SIZE / sizeof(void *) addresses? And how many dynamically allocated pages
> did you observe you might need in practice? Can it be somehow quantified the
> benefit that you are able to allocate up to X pages dynamically from the
> pcplists, vs a fixed number of pages held just for that purpose + fallback?
> 
We have PAGE_SIZE / sizeof(void *). The above ASCI was an example :)

Answering the second question about fixed number of preloaded pages. Please see
some concerns:

- It is hard to achieve because the logic does not stick to certain static test
  case, i.e. it depends on how heavily kfree_rcu(single/double) are used. Based
  on that, "how heavily" - number of pages are formed, until the drain/reclaimer
  thread frees them.

- Preloading pages and keeping them for internal use, IMHO, seems not optimal
  from the point of resources wasting. It is better to have a fast mechanism to
  request a page and release it back for needs of others. As described about
  we do not know how much we will need.

- As for fallback. That is something we would like to avoid(please see the cover letter).
  Just mention here one concern. For single argument it an entrance to synchronize_rcu()
  that can significantly slow down the reclamation process. What actually we would like
  to speed up.

> 
> > A number of pre-fetched elements seems does not depend on amount of the
> > physical memory in a system. In my case it is 63 pages. This step is not
> 
> It may depend, if you tune vm.percpu_pagelist_fraction sysctl. But I wouldn't
> know the exact formulas immediately. See pageset_set_high_and_batch(). In any
> case for your purpose the 'high' value (in e.g. /proc/zoneinfo) is more relevant
> (it means the maximum pages you might find cached) for you than the 'batch' (how
> much is cached in one refill).
> 
Thanks. I will have a look at it :) it is good that we can control it!

> > lock-less. It uses spinlock_t for accessing to the body's zone. This
> > step is fully covered in the rmqueue_bulk() function.
> > 
> > Summarizing. The __GFP_FAST_TRY covers only [1] and can not do step [2],
> > due to the fact that [2] acquires spinlock_t. It implies that it is super
> > fast, but a higher rate of fails is also expected.
> > 
> > Usage: __get_free_page(__GFP_FAST_TRY);
> > 
> > 2) There was a proposal from Matthew Wilcox: https://lkml.org/lkml/2020/7/31/1015
> > 
> > <snip>
> > On non-RT, we could make that lock a raw spinlock.  On RT, we could
> > decline to take the lock.  We'd need to abstract the spin_lock() away
> > behind zone_lock(zone), but that should be OK.
> > <snip>
> > 
> > It would be great to use any existing flag, say GFP_NOWAIT. Suppose we
> > decline to take the lock across the page allocator for RT. But there is
> > at least one path that does it outside of the page allocator. GFP_NOWAIT
> > can wakeup the kswapd, whereas a "wake-up path" uses sleepable lock:
> > 
> > wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
> > 
> > Probably it can be fixed by the excluding of waking of the kswapd process
> > defining something like below:
> 
> Is something missing here?
> 
I was talking about: how to bypass waking up of the kswapd that uses
sleepable lock. So, __get_free_page(0) will give a trick. But of course
that is not enough. Because we have prefeatchin pcpl-logic also. 

> > what is equal to zero and i am not sure if __get_free_page(0) handles
> > all that correctly, though it allocates and seems working on my test
> > machine! Please note it is related to "if we can reuse existing flags".
> > 
> > In the meantime, please see below for a patch that adds a __GFP_FAST_TRY,
> > which can at least serve as a baseline against which other proposals can
> > be compared. The patch is based on the 5.8.0-rc3.
> > 
> > Please RFC.
> 
> At first glance __GFP_FAST_TRY (more descriptive name? __GFP_NO_LOCKS?) seems
> better than doing weird things with GFP_NOWAIT, but depends on the real benefits
> (hence my first questions).
> 
No, i do not want to break GFP_NOWAIT, as Matthew mentioned later :)
__GFP_NO_LOCKS looks nice. I think, something like "TRY" should be added as well.
For example __GFP_NO_LOCKS_FAST_TRY.

I am glad for the reaction on it :)

Thank you, Vlastimil! 

--
Vlad Rezki
