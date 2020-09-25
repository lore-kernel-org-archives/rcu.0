Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A843C4727D
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 16:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4122B2D
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 16:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgIYQRS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:17:18 -0400
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:55051 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728489AbgIYQRS (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 25 Sep 2020 12:17:18 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 53A14FAA14
        for <rcu@vger.kernel.org>; Fri, 25 Sep 2020 17:17:15 +0100 (IST)
Received: (qmail 28638 invoked from network); 25 Sep 2020 16:17:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Sep 2020 16:17:15 -0000
Date:   Fri, 25 Sep 2020 17:17:12 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200925161712.GM3179@techsingularity.net>
References: <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200925153129.GB25350@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 25, 2020 at 05:31:29PM +0200, Uladzislau Rezki wrote:
> > > > > 
> > > > > All good points!
> > > > > 
> > > > > On the other hand, duplicating a portion of the allocator functionality
> > > > > within RCU increases the amount of reserved memory, and needlessly most
> > > > > of the time.
> > > > > 
> > > > 
> > > > But it's very similar to what mempools are for.
> > > > 
> > > As for dynamic caching or mempools. It requires extra logic on top of RCU
> > > to move things forward and it might be not efficient way. As a side
> > > effect, maintaining of the bulk arrays in the separate worker thread
> > > will introduce other drawbacks:
> > 
> > This is true but it is also true that it is RCU to require this special
> > logic and we can expect that we might need to fine tune this logic
> > depending on the RCU usage. We definitely do not want to tune the
> > generic page allocator for a very specific usecase, do we?
> > 
> I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> to provide a memory service for contexts which are not allowed to
> sleep, RCU is part of them. Both flags used to provide such ability
> before but not anymore.
> 
> Do you agree with it?
> 

I was led to believe that hte problem was taking the zone lock while
holding a raw spinlock that was specific to RCU. Are you saying that
GFP_ATOMIC/GFP_NOWAIT users are also holding raw spinlocks at the same
time on RT?

-- 
Mel Gorman
SUSE Labs
