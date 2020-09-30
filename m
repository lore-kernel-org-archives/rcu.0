Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFD8C4727E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 10:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687CF2064B
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 10:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RROXmXp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgI3Kf7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 06:35:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3Kf7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 06:35:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601462157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FWdudvb6rnom2+iYLotus6hARt6/ghjp6H9hbcaqJPM=;
        b=RROXmXp0w1cns3nM5MVBGcDg3nStPGVtCMbSSSRGjR1F4MFLpamWW+1t//7hI3P928iQMY
        Jj46jzsy4xTUKdiE1nyI4Cujwp6dp5Yt2x8CdIcgm2zcHspoAYh+74bhBgF7/KRNpQyt6N
        w1h+0gZZ/Gf+zG+7YwEKDX9rAPdirvw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5C0BABE3;
        Wed, 30 Sep 2020 10:35:57 +0000 (UTC)
Date:   Wed, 30 Sep 2020 12:35:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <20200930103557.GQ2277@dhcp22.suse.cz>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929220742.GB8768@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 30-09-20 00:07:42, Uladzislau Rezki wrote:
[...]
> <snip>
> bool is_pcp_cache_empty(gfp_t gfp)
> {
>     struct per_cpu_pages *pcp;
>     struct zoneref *ref;
>     unsigned long flags;
>     bool empty;
> 
>     ref = first_zones_zonelist(node_zonelist(
>             numa_node_id(), gfp), gfp_zone(gfp), NULL);
>     if (!ref->zone)
>             return true;
> 
>     local_irq_save(flags);
>     pcp = &this_cpu_ptr(ref->zone->pageset)->pcp;
>     empty = list_empty(&pcp->lists[gfp_migratetype(gfp)]);
>     local_irq_restore(flags);
> 
>     return empty;
> }
> 
> disable_irq();
> if (!is_pcp_cache_empty(GFP_NOWAIT))
>     __get_free_page(GFP_NOWAIT);
> enable_irq();
> <snip>
> 
> Do you mean to have something like above? I mean some extra API
> function that returns true or false if fast-fast allocation can
> either occur or not. Above code works just fine and never touches
> main zone->lock.

The above code works with the _current_ implementation and it restricts
its implementation to some degree. Future changes might get harder to
implement with a pattern like this. I do not think we want users to be
aware of internal implementation details like pcp caches, migrate types
or others. While pcp caches are here for years and unlikely to change in
a foreseeable future many details are changing on regular basis.
-- 
Michal Hocko
SUSE Labs
