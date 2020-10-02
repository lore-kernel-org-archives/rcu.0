Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6D6C4363D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 09:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCA7206DD
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 09:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJBJwF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 05:52:05 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:58731 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbgJBJwF (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 2 Oct 2020 05:52:05 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 05:52:04 EDT
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id CF8361C3A03
        for <rcu@vger.kernel.org>; Fri,  2 Oct 2020 10:45:03 +0100 (IST)
Received: (qmail 29917 invoked from network); 2 Oct 2020 09:45:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Oct 2020 09:45:03 -0000
Date:   Fri, 2 Oct 2020 10:45:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201002094502.GD3227@techsingularity.net>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090729.GU2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201002090729.GU2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 02, 2020 at 11:07:29AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 02, 2020 at 09:50:14AM +0100, Mel Gorman wrote:
> > On Fri, Oct 02, 2020 at 09:11:23AM +0200, Michal Hocko wrote:
> 
> > > > +#define ___GFP_NO_LOCKS                0x800000u
> > > 
> > > Even if a new gfp flag gains a sufficient traction and support I am
> > > _strongly_ opposed against consuming another flag for that. Bit space is
> > > limited. 
> > 
> > That is definitely true. I'm not happy with the GFP flag at all, the
> > comment is at best a damage limiting move. It still would be better for
> > a memory pool to be reserved and sized for critical allocations.
> 
> This is one of the reasons I did a separate allocation function. No GFP
> flag to leak into general usage.
> 

Even a specific function with a hint that "this is for RCU only" will
not prevent abuse.

> > > Besides that we certainly do not want to allow craziness like
> > > __GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?
> > 
> > That would deserve to be taken to a dumpster and set on fire. The flag
> > combination could be checked in the allocator but the allocator path fast
> > paths are bad enough already.
> 
> Isn't that what we have CONFIG_DEBUG_VM for?

It's enabled by default by enough distros that adding too many checks
is potentially painful. Granted it would be missed by most benchmarking
which tend to control allocations from userspace but a lot of performance
problems I see are the "death by a thousand cuts" variety.

-- 
Mel Gorman
SUSE Labs
