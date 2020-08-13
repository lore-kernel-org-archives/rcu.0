Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F036C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 17:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6550220715
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 17:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgHMRMP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:12:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHMRMO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 13:12:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9100AFBB;
        Thu, 13 Aug 2020 17:12:34 +0000 (UTC)
Date:   Thu, 13 Aug 2020 19:12:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20200813171211.GT9477@dhcp22.suse.cz>
References: <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <20200813154159.GR4295@paulmck-ThinkPad-P72>
 <20200813155412.GP9477@dhcp22.suse.cz>
 <20200813160442.GV4295@paulmck-ThinkPad-P72>
 <20200813161357.GQ9477@dhcp22.suse.cz>
 <20200813162904.GX4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813162904.GX4295@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 13-08-20 09:29:04, Paul E. McKenney wrote:
> On Thu, Aug 13, 2020 at 06:13:57PM +0200, Michal Hocko wrote:
> > On Thu 13-08-20 09:04:42, Paul E. McKenney wrote:
> > > On Thu, Aug 13, 2020 at 05:54:12PM +0200, Michal Hocko wrote:
> > [...]
> > > > If the whole bailout is guarded by CONFIG_PREEMPT_RT specific atomicity
> > > > check then there is no functional problem - GFP_RT_SAFE would still be
> > > > GFP_NOWAIT so functional wise the allocator will still do the right
> > > > thing.
> > > 
> > > Perhaps it was just me getting confused, early hour Pacific Time and
> > > whatever other excuses might apply.  But I thought that you still had
> > > an objection to GFP_RT_SAFE based on changes in allocator semantics for
> > > other users.
> > 
> > There is still that problem with lockdep complaining about raw->regular
> > spinlock on !PREEMPT_RT that would need to get resolved somehow. Thomas
> > is not really keen on adding some lockdep annotation mechanism and
> > unfortunatelly I do not have a different idea how to get rid of those.
> 
> OK.  So the current situation requires a choice between these these
> alternatives, each of which has shortcomings that have been mentioned
> earlier in this thread:
> 
> 1.	Prohibit invoking allocators from raw atomic context, such
> 	as when holding a raw spinlock.
> 
> 2.	Adding a GFP_ flag.

Which would implemente a completely new level atomic allocation for all
preemption models

> 
> 3.	Reusing existing GFP_ flags/values/whatever to communicate
> 	the raw-context information that was to be communicated by
> 	the new GFP_ flag.

this would have to be RT specific to not change the semantic for
existing users. In other words make NOWAIT semantic working for
RT atomic contexts.

> 
> 4.	Making lockdep forgive acquiring spinlocks while holding
> 	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.

and this would have to go along with 3 to remove false positives on !RT.

-- 
Michal Hocko
SUSE Labs
