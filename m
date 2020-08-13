Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAA1C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2F320781
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 07:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHMHSL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:18:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHMHSK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 03:18:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E72A8ABF1;
        Thu, 13 Aug 2020 07:18:30 +0000 (UTC)
Date:   Thu, 13 Aug 2020 09:18:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813071802.GC9477@dhcp22.suse.cz>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
 <87k0y56wc1.fsf@nanos.tec.linutronix.de>
 <87mu305c1w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu305c1w.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 12-08-20 13:38:35, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Thomas Gleixner <tglx@linutronix.de> writes:
> >> Michal Hocko <mhocko@suse.com> writes:
> >>> zone->lock should be held for a very limited amount of time.
> >>
> >> Emphasis on should. free_pcppages_bulk() can hold it for quite some time
> >> when a large amount of pages are purged. We surely would have converted
> >> it to a raw lock long time ago otherwise.
> >>
> >> For regular enterprise stuff a few hundred microseconds might qualify as
> >> a limited amount of time. For advanced RT applications that's way beyond
> >> tolerable..
> >
> > Sebastian just tried with zone lock converted to a raw lock and maximum
> > latencies go up by a factor of 7 when putting a bit of stress on the
> > memory subsytem. Just a regular kernel compile kicks them up by a factor
> > of 5. Way out of tolerance.
> >
> > We'll have a look whether it's solely free_pcppages_bulk() and if so we
> > could get away with dropping the lock in the loop.
> 
> So even on !RT and just doing a kernel compile the time spent in
> free_pcppages_bulk() is up to 270 usec.
> 
> It's not only the loop which processes a large pile of pages, part of it
> is caused by lock contention on zone->lock. Dropping the lock after a
> processing a couple of pages does not make it much better if enough CPUs
> are contending on the lock.

OK, this is a bit surprising to me but well, reality sucks sometimes.

I was really hoping for a solution which would allow the allocator to
really do what gfp flags say and if something is nowait then it
shouldn't really block. I believe we need to document this properly.

I will comment on the dedicated gfp flag in reply to other email.

Thanks for trying that out Sebastian and Thomas!
-- 
Michal Hocko
SUSE Labs
