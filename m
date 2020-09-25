Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92677C4727C
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 15:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526CA20878
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 15:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt0vuLHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgIYPbe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgIYPbe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Sep 2020 11:31:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E86AC0613CE;
        Fri, 25 Sep 2020 08:31:34 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n25so2820887ljj.4;
        Fri, 25 Sep 2020 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5yEGyIWYj8YTbWfiEbLmAmKcjf/SQa3FFLnfwTbpM8c=;
        b=lt0vuLHsBnFXgrwf2Z+Zv36j0XzzDg22ogJtFhIs/98t/uQR2pm2le5pIqlq2/3yq+
         1UCBpSKp4tbk8XQ1ouhVC0LhFuYP+OQuB3xTg0Saj1gZG0/Ke0fhbWJjyy00U1M7ywQp
         t+JsY65Shq0uyVwhUgtP2JlUb5xIWDl8ZPmEAesZ82nEyF8ex3SJn9iQDktkrJZJT9pr
         B4uIVcNcHlzgCkSbhRKNS8TzQqwYnuk0j5p7X96Ef6R18kEGEISBTRX4RxcQUNBfXtXX
         hxauL+8QMd987nN/OBOI5BoqAHdwVS59xWvKV1S0GtN801NFkYBbuKfdO/8faw5o8534
         7q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5yEGyIWYj8YTbWfiEbLmAmKcjf/SQa3FFLnfwTbpM8c=;
        b=lIpxaFJTT4hvOLEjAQY1wG9Iu+T27MRFI/txNfIOv9nsZNJ3m/H5KYhDOpwFQ6R2z3
         T1PTP2vItR0J7KkNorC8r14VdfN0DOhFf9ygHhpIxIWRhNFbIHCFG2zkLyjyKz+nz45Z
         F1tk03ucfXSzZmusauUKxOxehbt4o6Xz0hKXzztUWYAeBo7v8KQeIqNswKVh8qIz7vBA
         IqnDXbwVknCC+lq/5LOwz9I9MbjuKWsPH/EkurnkGsWMzt+MER79B5rlDgxCS6DQQGnV
         zYVG9ULclCX+k/5NvmHHqo6tMVghwm/OLGbst0Mnpnmnl9IqNmTCxA/Nr8lTvXKQSR4l
         1kRw==
X-Gm-Message-State: AOAM531rFkPJ6nyzOz44vqq4H6N/INSxbX5zWY8W/SUoADRjWTASBMxG
        vNWwdCk5eJTWq8vec0QCrFs=
X-Google-Smtp-Source: ABdhPJxUXH6p6tWPW6iokwFFIR3aK2qzMG1DKJtrod/hrQUI71heXqeorSouC/tIqN+kBtGW5avHIQ==
X-Received: by 2002:a2e:b4fc:: with SMTP id s28mr1497935ljm.305.1601047892588;
        Fri, 25 Sep 2020 08:31:32 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id w26sm2635854ljm.30.2020.09.25.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 08:31:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 25 Sep 2020 17:31:29 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Message-ID: <20200925153129.GB25350@pc636>
References: <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925080503.GC3389@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > > 
> > > > All good points!
> > > > 
> > > > On the other hand, duplicating a portion of the allocator functionality
> > > > within RCU increases the amount of reserved memory, and needlessly most
> > > > of the time.
> > > > 
> > > 
> > > But it's very similar to what mempools are for.
> > > 
> > As for dynamic caching or mempools. It requires extra logic on top of RCU
> > to move things forward and it might be not efficient way. As a side
> > effect, maintaining of the bulk arrays in the separate worker thread
> > will introduce other drawbacks:
> 
> This is true but it is also true that it is RCU to require this special
> logic and we can expect that we might need to fine tune this logic
> depending on the RCU usage. We definitely do not want to tune the
> generic page allocator for a very specific usecase, do we?
> 
I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
to provide a memory service for contexts which are not allowed to
sleep, RCU is part of them. Both flags used to provide such ability
before but not anymore.

Do you agree with it?

>
> do we?
>
If you agree with above, then there is a reasonable question what to
do. Converting zone->lock into raw variant, the simplest and generic
solution, has been declined(RT people do not like and see a side effect),
NO_LOCK flag together with lock-less function were declined. All those
efforts in terms of suggestions were just to find the best way to go.
That is why we highlighted it outside of RCU.

If you do not agree, then at least a documentation of mentioned flags
should be changed, IMHO. We are, in our turn will focus on fixing it
differently.

> >  a) There is an extra latency window, a time during which a fallback
> >     mechanism is used until pages are obtained via the special
> >     worker for further pointers collecting over arrays.
> 
> This will be always the case for async refilling. More importantly this
> will be a bigger problem at the page allocator level which has other
> users other than RCU so more users are suffering...
> 
Agree on that, async refilling has its disadvantages.

> >  b) It is impossible to predict how many pages will be required to
> >     cover a demand that is controlled by different workloads on
> >     various systems. It would require a rough value.
> 
> I have asked for some actual numbers for real life scenarios this work
> is meant to cover. There was nothing presented so far. We can hand wave
> for ever but this will not move us forward much. As I've said in other
> email, few dozens pages per CPU by default will hardly get noticeable.
> You have a trivial initial implementation and can build on top in
> incremental steps. You can kick a background allocator to start new
> allocations when the pool hits a watermark and aggressivelly remove
> cached pages when they are not used. You will have quite a freedom to
> fine tune the scheme which is much harder for the page allocator because
> there are many other consumers.
> 

> Anyway, I am afraid that we are going in circles here. We do not have
> any meaningful numbers to claim memory footprint problems. There is a
> clear opposition to hook into page allocator for reasons already
> mentioned. You are looking for a dedicated memory pool and it should be
> quite trivial to develop one and fine tune it for your specific usecase.
> All that on top of page allocator. Unless this is seen as completely
> unfeasible based on some solid arguments then we can start talking about
> the page allocator itself.
>
We have only synthetic tests. As for real life scenarios, on highly
loaded servers we will have one picture, on small devices like phones
we will have another one. As i mentioned in my previous emails, in worst
case on my system it requires ~400 pages to cover the bandwidth.

But, again we would like to find the best way to go. As i mentioned
if Thomas patches are in place, we do not need to workaround everything
regarding dynamic caching or async preloading and so on.

Thank you Michal!

--
Vlad Rezki
