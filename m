Return-Path: <SRS0=pcJ+=DD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D71C2D0A8
	for <rcu@archiver.kernel.org>; Sat, 26 Sep 2020 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323A92184D
	for <rcu@archiver.kernel.org>; Sat, 26 Sep 2020 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601131024;
	bh=FBJD7mqUsKW0o036aQOviNknZPjyLPwVOUbW+LvvSpc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=0eyCrcbwKJ/UzV6aNbSWHnssfE69m9G+hdwt2+i0uBz4YbvA161hr7xtqoZFj41Ko
	 bHO/Drh+8eD5wOo51luWHaY/IlkK2MfL1yh8YUWJ2/7jYpxaPRR9Th+GERvR24gUOB
	 GTFJVYyEmVkY/Wf1K3oJcR18hDh8TsWC9UtA0QBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIZOhD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 26 Sep 2020 10:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgIZOhD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 26 Sep 2020 10:37:03 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78CFF20BED;
        Sat, 26 Sep 2020 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601131022;
        bh=FBJD7mqUsKW0o036aQOviNknZPjyLPwVOUbW+LvvSpc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qygEVKQUrYuR+hpccG0TISUK3VG52gPHvJ4n3FShOSY99AvAUgY5dDPvKYSumsEUy
         AjqjcCal2J4ffG2w3kkSdV7zLRMKZOnOGjDCXN7JG3RjGPXkx9adV8leYrTR8YLSrO
         sgzTTEUDuXJu3V60ezo51uhxlJ4z/y+u8WWTf+2M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 49B7F35225FB; Sat, 26 Sep 2020 07:37:02 -0700 (PDT)
Date:   Sat, 26 Sep 2020 07:37:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200926143702.GI29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200924111907.GE2628@hirez.programming.kicks-ass.net>
 <20200924153834.GW29330@paulmck-ThinkPad-P72>
 <20200925082618.GT2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925082618.GT2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 25, 2020 at 10:26:18AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 08:38:34AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 24, 2020 at 01:19:07PM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 24, 2020 at 10:16:14AM +0200, Uladzislau Rezki wrote:
> > > > The key point is "enough". We need pages to make a) fast progress b) support
> > > > single argument of kvfree_rcu(one_arg). Not vice versa. That "enough" depends
> > > > on scheduler latency and vague pre-allocated number of pages, it might
> > > > be not enough what would require to refill it more and more or we can overshoot
> > > > that would lead to memory overhead. So we have here timing issues and
> > > > not accurate model. IMHO.
> > > 
> > > I'm firmly opposed to the single argument kvfree_rcu() idea, that's
> > > requiring memory to free memory.
> > 
> > Not quite.
> > 
> > First, there is a fallback when memory allocation fails.  Second,
> > in heavy-use situations, there is only one allocation per about
> > 500 kvfree_rcu() calls on 64-bit systems.  Third, there are other
> > long-standing situations that require allocating memory in order to
> > free memory.
> 
> Some of which are quite broken. And yes, I'm aware of all that, I'm the
> one that started swap-over-NFS, which requires network traffic to free
> memory, which is one insane step further.

I could easily imagine that experience might have left some scars.

> But the way to make that 'work' is carefully account and pre-allocate
> (or size the reserve) the required memory to make progress and to
> strictly limit concurrency to ensure you stay in your bounds.

But your situation is different.  When swapping over NFS, if you
cannot allocate the memory to do the I/O, you cannot free the memory
you are attempting to swap out, at least not unless you can kill the
corresponding process.  So if you don't want to kill processes, as you
say, worst case is what matters.

The kvfree_rcu() situation is rather different.  In all cases, there
is a fallback, namely using the existing rcu_head for double-argument
kvfree_rcu() or falling back to synchronize_rcu() for single-argument
kvfree_rcu().  As long as these fallbacks are sufficiently rare, the
system will probably survive.

> > So I agree that it is a good general rule of thumb to avoid allocating
> > on free paths, but there are exceptions.  This is one of them.
> 
> The very first thing you need to do is proof your memory usage is
> bounded, and then calculate your bound.

Again, you are confusing your old swap-over-NFS scars with the current
situation.  They really are not the same.

> The problem is that with RCU you can't limit concurrency. call_rcu()
> can't block, you can't wait for a grace period to end when you've ran
> out of your reserve.
> 
> That is, you don't have a bound, so no reserve what so ever is going to
> help.

Almost.  A dedicated reserve large enough to result in sufficiently low
use of the fallback paths is too large.  Again, we can tolerate a small
fraction of requests taking the fallback, with emphasis on "small".

> You must have that callback_head fallback.

And we do have that callback_head fallback.  And in the case of
single-argument kvfree_rcu(), that synchronize_rcu() fallback. And as
long as we can avoid using those fallbacks almost all the time, things
will be OK.  But we do need to able to allocate memory in the common
case when there is memory to be had.

							Thanx, Paul
