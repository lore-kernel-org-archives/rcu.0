Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F7EC4727E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D350E2076E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 12:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnfGmHDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgI3Mb6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3Mb6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 08:31:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03737C061755;
        Wed, 30 Sep 2020 05:31:58 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so1941878lfj.0;
        Wed, 30 Sep 2020 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9/oKsXJpZXyeQKTaev3w4RNfmHS79ATahAgjioXXp8=;
        b=hnfGmHDRjYYcWgcCiPre31p22gIiWSjZ0GHw3fhfe/80Osu8GClQ20Qq/ITsw9UViy
         HBAyJJkvH2MEWJdV4+k3QiaIUicORMhBuo4QcMpRSlQMej9KJ9xc7WhtDRr1U5aY/SRo
         jxQ+IlSNiZ8GNSfXfrFCBqQKLoxUxNfGc8taXyfs5JcdVbosSplkw+uizOMRV1fJNq8d
         gshFllAdOsumUJa37H28NvTFx64B9sXm9LNwdUE+yAN7UZVq3+ZxC/n8yvG3R0bu0wjJ
         sLiuWDExobjIw45d5myMBkG0M7XJzb4wEkF9dvsNgeFEhy83qcpikSw9qkfBmdmSqyEn
         H8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9/oKsXJpZXyeQKTaev3w4RNfmHS79ATahAgjioXXp8=;
        b=kyoy5c6Wf2a86h9kFaMw1gy4w5o9e5lyP3f28NjlD0dcj/ZePq1klYqj5vrcOLlpsB
         2DuJimKjklxKJZa4d207GLRzzdX9wv5LMr+j1ON9k7BrzB8DzTylAliYFIBtYqPA2EZX
         lal+luTva/VwjkQPukZwf01JH6nY+TbBlSUfL31YtJ/jpX7TSryDOv/0N74Ac8ASmhin
         e+pdjjXdy9e13GqRHYiOhnP7aH0SGYDWp+wHdrx+qIcaM9IZNWlOG4bmGDsdJtdbsOD7
         YcbIpzoqS+N7GYe4oXGZLl0fEqakuRT3nkhmLXS9DhaqbNvdXlkXaWJ7+sqeOaf9lLVq
         0dtA==
X-Gm-Message-State: AOAM532ulEOuQFj7Cjp10zZLF66Ztuet3NbeKtZPHiY8JYmARyWzcghv
        BSUa+ZK8b2vP+5Vgs2Oh8tQ=
X-Google-Smtp-Source: ABdhPJyCZ8m6KQq4ClhP/w3GzOj4X/CJUyeqaWBcxG4DuKG+WkXUsib/D1j9ZyageT9ImNl4jNgY8A==
X-Received: by 2002:a19:640b:: with SMTP id y11mr755623lfb.373.1601469116418;
        Wed, 30 Sep 2020 05:31:56 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l4sm176231lfg.296.2020.09.30.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:31:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 30 Sep 2020 14:31:53 +0200
To:     Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20200930123153.GA18005@pc636>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
 <20200930084139.GN2277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930084139.GN2277@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
> > > What is the point of calling kmalloc  for a PAGE_SIZE object? Wouldn't
> > > using the page allocator directly be better?
> > 
> > Well, you guys gave me considerable heat about abusing internal allocator
> > interfaces, and kmalloc() and kfree() seem to be about as non-internal
> > as you can get and still be invoking the allocator.  ;-)
> 
> alloc_pages resp. __get_free_pages is a normal page allocator interface
> to use for page size granular allocations. kmalloc is for more fine
> grained allocations.
>
I do not have a strong opinion here but i would tend to using of the page
allocator directly. Because we operate on a page level where the page
allocator is supposed to be used. From the other hand i saw a slightly
better performance in case of SLAB only. I think that is because of
a) slab caches; b) more objects which can be cached. But i have one more
concern about using of kmalloc(). That is about fragmentations it can
cause with PAGE_SIZE requests.

As for SLUB it was identical whereas the SLOB i din not check.

--
Vlad Rezki
