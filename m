Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314AAC4363D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 08:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46CD20719
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 08:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgJBIuS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 04:50:18 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:45105 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgJBIuR (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 2 Oct 2020 04:50:17 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 364C4F8067
        for <rcu@vger.kernel.org>; Fri,  2 Oct 2020 09:50:16 +0100 (IST)
Received: (qmail 20546 invoked from network); 2 Oct 2020 08:50:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Oct 2020 08:50:15 -0000
Date:   Fri, 2 Oct 2020 09:50:14 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201002085014.GC3227@techsingularity.net>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201002071123.GB20872@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 02, 2020 at 09:11:23AM +0200, Michal Hocko wrote:
> On Thu 01-10-20 21:26:26, Uladzislau Rezki wrote:
> > > 
> > > No, I meant going back to idea of new gfp flag, but adjust the implementation in
> > > the allocator (different from what you posted in previous version) so that it
> > > only looks at the flag after it tries to allocate from pcplist and finds out
> > > it's empty. So, no inventing of new page allocator entry points or checks such
> > > as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> > > affect existing fast paths.
> > >
> > OK. Now i see. Please have a look below at the patch, so we fully understand
> > each other. If that is something that is close to your view or not:
> > 
> > <snip>
> > t a/include/linux/gfp.h b/include/linux/gfp.h
> > index c603237e006c..7e613560a502 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -39,8 +39,9 @@ struct vm_area_struct;
> >  #define ___GFP_HARDWALL                0x100000u
> >  #define ___GFP_THISNODE                0x200000u
> >  #define ___GFP_ACCOUNT         0x400000u
> > +#define ___GFP_NO_LOCKS                0x800000u
> 
> Even if a new gfp flag gains a sufficient traction and support I am
> _strongly_ opposed against consuming another flag for that. Bit space is
> limited. 

That is definitely true. I'm not happy with the GFP flag at all, the
comment is at best a damage limiting move. It still would be better for
a memory pool to be reserved and sized for critical allocations.

> Besides that we certainly do not want to allow craziness like
> __GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?

That would deserve to be taken to a dumpster and set on fire. The flag
combination could be checked in the allocator but the allocator path fast
paths are bad enough already.

-- 
Mel Gorman
SUSE Labs
