Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610EC4741F
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE15520759
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ0Q7Hih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgJATcV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATcV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 15:32:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B6C0613D0;
        Thu,  1 Oct 2020 12:32:20 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so36855lff.3;
        Thu, 01 Oct 2020 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YnQw5I7E0IE6Jm9/sjhCU27Hvf+BvkH1b7yFmJGMXJk=;
        b=IQ0Q7HihNmj2N5gtPNicajIxU3n0fnaxqryKbRbt6ce7eRM0pbTr8HZLRz3+spOa1N
         fppFiOHxIf8sg0OuN4Wqru3+khhlkn4eYqy8tt97TfZ2WY3Nu5Pd1vPeRHMAg4ZZrfiW
         Wjy3MyK2RYM3c/znLxcqU2omMUhRpo7eO0nagsFktLt6/HgzZVxamu88gEWRC/fKHPp/
         v80LAcDmsu4iAELmIXZtTDLS9nnndOJIs0i/DLuH9B7E6W+1kKJb456TZv8SOxT/tna4
         lh+KzSDq/RXhwvH5yZvxoqLEkRifzyaEDOxmomenDOWqhK0OXarCMmsAWDLYpCthz5z2
         7ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YnQw5I7E0IE6Jm9/sjhCU27Hvf+BvkH1b7yFmJGMXJk=;
        b=T9vJlr4rHku6MkXEP4HJoTNg6Rdw/SmgdQSua2dRRZrHOO/5EDacM8PcTRCDeketdy
         V41cgHuoByExkeNXcoie/jfP+8bGEC2EZAPbE0YrZKKKj/fCrUnEHWWKbwCjZF5XWxRk
         zqdlVXNYnK00UdRb0AyaZIZS+ZMzEvcIVmaWUorFgoHesgptR9kqIhFVwppmgjxO3FUB
         zJUZSWghz5ESNf7GtNVGMH02Ijlgran8WIVxKeiBRjRg00CqlwcOQIqWrYzv5dGuMTJ+
         kEB/OjeLMxM4N3DRn3rgTgyrCkX8SuKk/b1DBVm/NEHAyGrHW4eYGzkCrjJ+saRnXjyb
         vjPA==
X-Gm-Message-State: AOAM532wBv+fS/yD1eMmidju0Sj+APT3XRtGEXRCOOuiK5ygbJvqaU3O
        sLzm6j33kC+6w5hDszdX64fQy+p+jcJftwMJ
X-Google-Smtp-Source: ABdhPJwK1VkXLr9O8cmPF9oZr1DmAe5rL061I7HgPBONZTvCYAgvdKSgfytjnPxT/UHZUjVt/taz0A==
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr3015161lfk.10.1601580739284;
        Thu, 01 Oct 2020 12:32:19 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 10sm669191lfo.197.2020.10.01.12.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:32:18 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 1 Oct 2020 21:32:16 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201001193216.GB29606@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <20200930103557.GQ2277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930103557.GQ2277@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 30, 2020 at 12:35:57PM +0200, Michal Hocko wrote:
> On Wed 30-09-20 00:07:42, Uladzislau Rezki wrote:
> [...]
> > <snip>
> > bool is_pcp_cache_empty(gfp_t gfp)
> > {
> >     struct per_cpu_pages *pcp;
> >     struct zoneref *ref;
> >     unsigned long flags;
> >     bool empty;
> > 
> >     ref = first_zones_zonelist(node_zonelist(
> >             numa_node_id(), gfp), gfp_zone(gfp), NULL);
> >     if (!ref->zone)
> >             return true;
> > 
> >     local_irq_save(flags);
> >     pcp = &this_cpu_ptr(ref->zone->pageset)->pcp;
> >     empty = list_empty(&pcp->lists[gfp_migratetype(gfp)]);
> >     local_irq_restore(flags);
> > 
> >     return empty;
> > }
> > 
> > disable_irq();
> > if (!is_pcp_cache_empty(GFP_NOWAIT))
> >     __get_free_page(GFP_NOWAIT);
> > enable_irq();
> > <snip>
> > 
> > Do you mean to have something like above? I mean some extra API
> > function that returns true or false if fast-fast allocation can
> > either occur or not. Above code works just fine and never touches
> > main zone->lock.
> 
> The above code works with the _current_ implementation and it restricts
> its implementation to some degree. Future changes might get harder to
> implement with a pattern like this. I do not think we want users to be
> aware of internal implementation details like pcp caches, migrate types
> or others. While pcp caches are here for years and unlikely to change in
> a foreseeable future many details are changing on regular basis.
>
I see your view. That was en example for better understanding.

Thanks.

--
Vlad Rezki
