Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA0DC433E1
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE812087D
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 12:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgHNMsf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:48:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHNMsf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 08:48:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E541AFE8;
        Fri, 14 Aug 2020 12:48:56 +0000 (UTC)
Date:   Fri, 14 Aug 2020 14:48:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814124832.GD9477@dhcp22.suse.cz>
References: <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <87lfiitquu.fsf@nanos.tec.linutronix.de>
 <20200814071750.GZ9477@dhcp22.suse.cz>
 <20200814121544.GA32598@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814121544.GA32598@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri 14-08-20 14:15:44, Uladzislau Rezki wrote:
> > On Thu 13-08-20 19:09:29, Thomas Gleixner wrote:
> > > Michal Hocko <mhocko@suse.com> writes:
> > [...]
> > > > Why should we limit the functionality of the allocator for something
> > > > that is not a real problem?
> > > 
> > > We'd limit the allocator for exactly ONE new user which was aware of
> > > this problem _before_ the code hit mainline. And that ONE user is
> > > prepared to handle the fail.
> > 
> > If we are to limit the functionality to this one particular user then
> > I would consider a dedicated gfp flag a huge overkill. It would be much
> > more easier to have a preallocated pool of pages and use those and
> > completely avoid the core allocator. That would certainly only shift the
> > complexity to the caller but if it is expected there would be only that
> > single user then it would be probably better than opening a can of worms
> > like allocator usable from raw spin locks.
> > 
> Vlastimil raised same question earlier, i answered, but let me answer again:
> 
> It is hard to achieve because the logic does not stick to certain static test
> case, i.e. it depends on how heavily kfree_rcu(single/double) are used. Based
> on that, "how heavily" - number of pages are formed, until the drain/reclaimer
> thread frees them.

How many pages are talking about - ball park? 100s, 1000s?

> Preloading pages and keeping them for internal use, IMHO, seems not optimal
> from the point of resources wasting. It is better to have a fast mechanism to
> request a page and release it back for needs of others. As described about
> we do not know how much we will need.

It would be wasted memory but if we are talking about relatively small
number of pages. Note that there are not that many pages on the
allocator's pcp list anyway.
-- 
Michal Hocko
SUSE Labs
