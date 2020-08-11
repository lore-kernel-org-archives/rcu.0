Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A3C433E0
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 10:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8291C2054F
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 10:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgHKKVd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:21:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:53314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgHKKVd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 06:21:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B968AE51;
        Tue, 11 Aug 2020 10:21:52 +0000 (UTC)
Date:   Tue, 11 Aug 2020 12:21:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811102124.GH4793@dhcp22.suse.cz>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <20200811091807.GA2634@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811091807.GA2634@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 11-08-20 11:18:07, Uladzislau Rezki wrote:
> On Mon, Aug 10, 2020 at 09:25:25PM +0200, Michal Hocko wrote:
> > On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
> > > > On Sun 09-08-20 22:43:53, Uladzislau Rezki (Sony) wrote:
[...]
> > > As i described before, calling the __get_free_page(0) with 0 as argument
> > > will solve the (a). How correctly is it? From my point of view the logic
> > > that bypass the wakeup path should be explicitly defined.
> > 
> > gfp_mask == 0 is GFP_NOWAIT (aka an atomic allocation request) which
> > doesn't wake up kswapd. So if the wakeup is a problem then this would be
> > a way to go.
> > 
> What do you mean Michal? gfp_mask 0 != GFP_NOWAIT:
> 
> #define GFP_NOWAIT (__GFP_KSWAPD_RECLAIM)
> 
> it does wakeup of the kswapd. Or am i missing something? Please comment.
> If we are about to avoid the kswapd, should we define something special?
> 
> #define GFP_NOWWAKE_KSWAPD 0

Sorry, I was more cryptic than necessary. What I meant is that
GFP_NOWAIT is the basic non-sleepable allocation. It does wake up
kswapd but a lack of it can be expressed GFP_NOWAIT & ~__GFP_KSWAPD_RECLAIM
which is 0, now. The mouthfull variant is better for future
maintainability.
-- 
Michal Hocko
SUSE Labs
