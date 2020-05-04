Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F1C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 14:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95B620721
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIHpH8tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgEDOV7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgEDOV7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 10:21:59 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA7AC061A0E;
        Mon,  4 May 2020 07:21:58 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s9so4702521lfp.1;
        Mon, 04 May 2020 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TjQIadq6DfkSuMtzgbVyqx7eozFCGzVHUTUogoGl7xY=;
        b=jIHpH8tCYXoUS/6yaeKsETWsdPAiDMK0RP02iwGzjzLK/nJ8eRqBiYJJ6etliXLip1
         8PlROGndEGmJOkQb+GS9LVPB3FjI/MyuzkbiZRHX56/PrN7HKjF2MNK1lcG9iht/JBKj
         hLlEk94jUha/lV4BWoFcV0WMPSo7uT2Jd/gVUmwmSdtW5KGcs6BhIPFLRhAgiP5Pxv+v
         BDvR1GlfLHarnpA6VBkpl5OLGpVFPs5Q4OEZHGxcJNpQiO6jXq/ERSTvVesCLxKVONId
         VMWRwzA4I0+tRUnuEkWEW7ZJY7TQNm00e0rgLEzgjIKJvhmvUgcnnwT8X7qCQfIuQttN
         ZFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjQIadq6DfkSuMtzgbVyqx7eozFCGzVHUTUogoGl7xY=;
        b=K2frAgdxWXGL0XWJSaUpWGKdrq255SBlQqOoLPOKmmBtA8ZoB/XLqPV7k63SPDlnof
         mQ7OXCQlh6ZetAQ//79DGSgWE7ov7H+Fw8gIV1R7+1M3lKjb3zNZnl/vLIIfDf2xdZqy
         +PTuYVRJr0f1gh9na0E2ogYR6ny7dEDupNqdDmyyaL9DI6oIEiY3/eh6B53rPs1WDk1c
         R9Te8g7jjMxQOlvkQrCFshFGPVu4cxPpD12zq6H78Gr7zUXI6yd5sHm91WtS2UBO0FZj
         +DjenE47ZW+FxvINZqn52jV++/kRyLkwrGnrHgWncsXVVKXW5x3d+V8XFrF3Kv8RUdqV
         su9A==
X-Gm-Message-State: AGi0PuZZoDja/zqWVXue3J0o/xGCemk+Rnt9oarHN38WMhkrq7orlNJ+
        XxFnbaCjWiEbt0cGi5HqUQVdCNcPxz8e5Q==
X-Google-Smtp-Source: APiQypILiwgc6kOVf1Dh9xb4iNYqSTwVc8ILuaP2SqMOrOHSXjRr2sAkPPlMPKjIkNV0biK7ivNAUA==
X-Received: by 2002:a05:6512:31d6:: with SMTP id j22mr11613555lfe.83.1588602117162;
        Mon, 04 May 2020 07:21:57 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a2sm8363646ljj.53.2020.05.04.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:21:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 16:21:53 +0200
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 19/24] rcu/tree: Support reclaim for head-less object
Message-ID: <20200504142153.GG17577@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-20-urezki@gmail.com>
 <20200501223909.GF7560@paulmck-ThinkPad-P72>
 <20200504001258.GD197097@google.com>
 <20200504002855.GF2869@paulmck-ThinkPad-P72>
 <20200504003237.GD212435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504003237.GD212435@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > 
> > > If we are not doing single-pointer allocation, then that would also eliminate
> > > entering the low-level page allocator for single-pointer allocations.
> > > 
> > > Or did you mean entry into the allocator for the full-page allocations
> > > related to the pointer array for PREEMPT_RT? Even if we skip entry into the
> > > allocator for those, we will still have additional caching which further
> > > reduces chances of getting a full page. In the event of such failure, we can
> > > simply queue the rcu_head.
> > > 
> > > Thoughts?
> > 
> > I was just trying to guess why you kept the single-pointer allocation.
> > It looks like I guessed wrong.  ;-)
> > 
> > If, as you say above, you make it go straight to synchronize_rcu()
> > upon full-page allocation failure, that would be good!
> 
> Paul, sounds good. Vlad, are you also Ok with that?
> 
OK, let's drop it and keep it simple :)

BTW, for PREEMPT_RT we still can do a page allocation for single
argument of kvfree_rcu(). In case of double we just revert everything
to the rcu_head if no cache.

For single argument we can drop the lock before the entry to the page
allocator. Because it follows might_sleep() anotation we avoid of having
a situation when spinlock(rt mutex) is taken from any atomic context.

Since the lock is dropped the current context can be interrupted by
an IRQ which in its turn can also call kvfree_rcu() on current CPU.
In that case it must be double argument(single is not allowed) kvfree_rcu()
call. For PREEMPT_RT if no cache everything is reverted to rcu_head usage,
i.e. the entry to page allocator is bypassed.

It can be addressed as a separate patch and send out later on if we
are on the same page.

Paul, Joel what are your opinions?

--
Vlad Rezki
