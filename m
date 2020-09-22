Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A27BC2D0E2
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 13:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83022399A
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/uufrCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIVNNC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 09:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVNNC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 09:13:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FEFC061755;
        Tue, 22 Sep 2020 06:13:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a15so14099473ljk.2;
        Tue, 22 Sep 2020 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2z8KLYcV2WyIOYkugsYC62B54jH3ZqWmai+zjoiHURM=;
        b=g/uufrCp4Tieb1/bP3Sk+L6niHHhoLetIn719xh8g8W3aR+ShzNF+eI0YiqyuwjztJ
         lxyPlfmXWIUwg7FR8tFYeiyWvGtJ/G85fUPGe9y4AuTlcLO+Hj+xTmzEr0K5zEDipXbg
         v6TlSBvwk3T7CCc7GECiGJ0V/WgZGWIgr7FejBbqX9kiQG65CcX3obzHIvZYFIt88IwX
         /VuONgmxdlA+9utpKa6wzIjyJnEBeWMe3jgpnI3lzbNS2lcHNJjQEALgj9zD2KdoGVoy
         v8JKrvSiMWWC1EPk0Clq2i9Unfxpe39ZItLJ/TIMywKgXbLTY9HH9I6/NF9uR75pckYW
         KOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2z8KLYcV2WyIOYkugsYC62B54jH3ZqWmai+zjoiHURM=;
        b=Btst4UYG+Un+9vwGZVboWWWBzUaPk3WDj4MTAib9FdtoR6MSWSLqQnFCE8sqc8VAnL
         tFWqvbhg3HHPFqitx6FrP4keFdIFVgwhOExZGSzCqnWwAN+9aQapVoR0dcSP/RoTTsmS
         gnBve1EuhhgNSWjJK6datuowQNjt+a3RIKhaIKKFeI+ZS/SvVktl49S/EJWfZtthmA5L
         o42TeSAPfYG9+ibUAwNlnuDJb49MtFIM0TNpJIEIk4QRAKkUXsypYwohZcCtGZnKQ9kn
         0f4iakHTShgKueRKayMVs2Hka5dU8EhN7tbUGjGCI/odRyHEoq3fgWdp1KmyN4mt5yJC
         Mx8A==
X-Gm-Message-State: AOAM533rOyKVozSo1gjIT2ZsefQwLyFutzBs8eYxdVb9SuOsabjP6UDZ
        2eHgR6Z7lZjSdNfWwTTabt0=
X-Google-Smtp-Source: ABdhPJynL2GGAC64a28puyBSgBYDy+TPN8QQij3z4tz/mhOyog30o8cnGg8b25izSCXatkCgDS7C7w==
X-Received: by 2002:a2e:964e:: with SMTP id z14mr1450241ljh.86.1600780380316;
        Tue, 22 Sep 2020 06:13:00 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y10sm3472646lfj.271.2020.09.22.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 06:12:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 22 Sep 2020 15:12:57 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20200922131257.GA29241@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922075002.GU12990@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > > Yes, I do well remember that you are unhappy with this approach.
> > > > Unfortunately, thus far, there is no solution that makes all developers
> > > > happy.  You might be glad to hear that we are also looking into other
> > > > solutions, each of which makes some other developers unhappy.  So we
> > > > are at least not picking on you alone.  :-/
> > > 
> > > No worries I do not feel like a whipping boy here. But do expect me to
> > > argue against the approach. I would also appreciate it if there was some
> > > more information on other attempts, why they have failed. E.g. why
> > > pre-allocation is not an option that works well enough in most
> > > reasonable workloads.
> > Pre-allocating has some drawbacks:
> > 
> > a) It is impossible to predict how many pages will be required to
> >    cover a demand that is controlled by different workloads on
> >    various systems.
> 
> Yes, this is not trivial but not a rocket science either. Remember that
> you are relying on a very dumb watermark based pcp pool from the
> allocator.
>
We rely on it, indeed. If the pcp-cache is depleted our special work is
triggered to charge our local cache(few pages) such way will also initiate
the process of pre-featching pages from the buddy allocator populating
the depleted pcp-cache. I do not have any concern here.

>
> Mimicing a similar implementation shouldn't be all that hard
> and you will get your own pool which doesn't affect other page allocator
> users as much as a bonus.
> 
I see your point Michal. As i mentioned before, it is important to avoid of
having such own pools, because the aim is not to waste memory resources. A
page will be returned back to "page allocator" as soon as a scheduler place  
our reclaim thread on a CPU and grace period is passed. So, the resource
can be used for other needs. What is important.

Otherwise a memory footprint is increased what is bad for low memory
conditions when OOM is involved. Just in case, it is a big issue for
mobile devices.

> > b) Memory overhead since we do not know how much pages should be
> >    preloaded: 100, 200 or 300
> 
> Does anybody who really needs this optimization actually cares about 300
> pages?
> 
It might be an issue for embedded devices when such devices run into a
low memory condition resulting in OOM or slow allocations due to mentioned
condition. For servers and big system it will not be visible.

> > As for memory overhead, it is important to reduce it because of
> > embedded devices like phones, where a low memory condition is a
> > big issue. In that sense pre-allocating is something that we strongly
> > would like to avoid.
> 
> How big "machines" are we talking about here? I would expect that really
> tiny machines would have hard times to really fill up thousands of pages
> with pointers to free...
> 
I mentioned above. We can not rely on static model. We would like to
have a mechanism that gives back ASAP used pages to page allocator
for other needs.

>
> Would a similar scaling as the page allocator feasible. Really I mostly
> do care about shared nature of the pcp allocator list that one user can
> easily monopolize with this API.
> 
I see your concern. pcplist can be monopolized by already existing API:

    while (i < 100)
        __get_free_page(GFP_NOWAIT | __GFP_NOWARN);

> > > I would also appreciate some more thoughts why we
> > > need to optimize for heavy abusers of RCU (like close(open) extremes).
> > > 
> > I think here is a small misunderstanding. Please note, that is not only
> > about performance and corner cases. There is a single argument support
> > of the kvfree_rcu(ptr), where maintaining an array in time is needed.
> > The fallback of the single argument case is extrimely slow.
> 
> This should be part of the changelog.
>
Hmm.. I think it is. Sorry if i missed that but i hope i mentioned about it.

> > 
> > Single-argument details is here: https://lkml.org/lkml/2020/4/28/1626
> 
> Error 501
> 
Could you please elaborate? Do not want to speculate :)

> > > > > I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
> > > > > that this optimization is not aiming at reasonable workloads. Really, go
> > > > > with pre-allocated buffer and fallback to whatever slow path you have
> > > > > already. Exposing more internals of the allocator is not going to do any
> > > > > good for long term maintainability.
> > > > 
> > > > I suggest that you carefully re-read the thread following that email.
> > > 
> > > I clearly remember Thomas not being particularly happy that you optimize
> > > for a corner case. I do not remember there being a consensus that this
> > > is the right approach. There was some consensus that this is better than
> > > a gfp flag. Still quite bad though if you ask me.
> > > 
> > > > Given a choice between making users unhappy and making developers
> > > > unhappy, I will side with the users each and every time.
> > > 
> > > Well, let me rephrase. It is not only about me (as a developer) being
> > > unhappy but also all the side effects this would have for users when
> > > performance of their favorite workload declines for no apparent reason
> > > just because pcp caches are depleted by an unrelated process.
> > >
> > If depleted, we have a special worker that charge it. From the other hand,
> > the pcplist can be depleted by its nature, what _is_ not wrong. But just
> > in case we secure it since you had a concern about it.
> 
> pcp free lists should ever get empty when we run out of memory and need
> to reclaim. Otherwise they are constantly refilled/rebalanced on demand.
> The fact that you are refilling them from outside just suggest that you
> are operating on a wrong layer. Really, create your own pool of pages
> and rebalance them based on the workload.
> 
I covered it above.

> > Could you please specify a real test case or workload you are talking about?
> 
> I am not a performance expert but essentially any memory allocator heavy
> workload might notice. I am pretty sure Mel would tell you more.
> 
OK.

Thank you for your comments, Michal!

--
Vlad Rezki
