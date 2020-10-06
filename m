Return-Path: <SRS0=Nt6M=DN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A20C4727D
	for <rcu@archiver.kernel.org>; Tue,  6 Oct 2020 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F95F20760
	for <rcu@archiver.kernel.org>; Tue,  6 Oct 2020 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601998865;
	bh=5zcZJgeXWMZfqD9CHwUsl8a8Af1+R/wD5uulfCzXK5Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=DbjQegaLRmgN5/+HrPSp+ARp05dkxRsPFZjh4xnTHKP7rRYOIjD2XsME+FK65YpHK
	 iVKTtV3ZSoEZOK26XmDMGJNzzG0JXYqcB3ASC3VT78MoODD22WdtHWgAGJ/ddmoTy3
	 xwnpQuq6jRuE7iEVzNNcJUjCgHbEB1FsyuNanjeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFPlF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Oct 2020 11:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFPlF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Oct 2020 11:41:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6DD206F7;
        Tue,  6 Oct 2020 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601998864;
        bh=5zcZJgeXWMZfqD9CHwUsl8a8Af1+R/wD5uulfCzXK5Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rQ6Zbe3409jzMfKdP5zm0LSY4ZRePO1jIu3iKr7VIaprlbkkT7JbwKynwMM+0Gn/K
         ANeSzK6ifLHXcdbfk28NmNQ3K+VJIBQQjg7FM/zHoOmCckK7iPfrWgXOH0Y9wMKTF/
         HdMdpN6fglz4ja9ygnAMqSZLOj4hALgifxu977k8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 73DD93520A89; Tue,  6 Oct 2020 08:41:04 -0700 (PDT)
Date:   Tue, 6 Oct 2020 08:41:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201006154104.GH29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090729.GU2628@hirez.programming.kicks-ass.net>
 <20201002094502.GD3227@techsingularity.net>
 <20201002095858.GN2611@hirez.programming.kicks-ass.net>
 <20201002101952.GE3227@techsingularity.net>
 <20201002144120.GI29330@paulmck-ThinkPad-P72>
 <20201006100334.GK3227@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006100334.GK3227@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 06, 2020 at 11:03:34AM +0100, Mel Gorman wrote:
> On Fri, Oct 02, 2020 at 07:41:20AM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 02, 2020 at 11:19:52AM +0100, Mel Gorman wrote:
> > > On Fri, Oct 02, 2020 at 11:58:58AM +0200, Peter Zijlstra wrote:
> > > > > It's enabled by default by enough distros that adding too many checks
> > > > > is potentially painful. Granted it would be missed by most benchmarking
> > > > > which tend to control allocations from userspace but a lot of performance
> > > > > problems I see are the "death by a thousand cuts" variety.
> > > > 
> > > > Oh quite agreed, aka death by accounting. But if people are enabling
> > > > DEBUG options in production kernels, there's something wrong, no?
> > > > 
> > > 
> > > You'd think but historically I believe DEBUG_VM was enabled for some
> > > distributions because it made certain classes of problems easier to debug
> > > early. There is also a recent trend for enabling various DEBUG options for
> > > "hardening" even when they protect very specific corner cases or are for
> > > intended for kernel development. I've pushed back where I have an opinion
> > > that matters but it's generally corrosive.
> > > 
> > > > Should we now go add CONFIG_REALLY_DEBUG_STAY_AWAY_ALREADY options?
> > > 
> > > It's heading in that direction :(
> > 
> > Given that you guys have just reiterated yet again that you are very
> > unhappy with either a GFP_ flag or a special function like the one that
> > Peter Zijlstra put together, it would be very helpful if you were to at
> > least voice some level of support for Thomas Gleixner's patchset, which,
> > if accepted, will allow me to solve at least 50% of the problem.
> 
> I read through the series and didn't find anything problematic that
> had not been covered already. Minimally, avoiding surprises about what
> preemptible() means in different contexts is nice. While I have not
> run it through a test grid to check, I'd be very surprised if this was
> problematic from a performance perspective on a preempt-disabled kernels.
> Last I checked, the difference between PREEMPT_NONE and PREEMPT_VOLUNTARY
> was less than 2% *at worst* and I don't think that was due to the preempt
> accounting.

Thank you, Mel!

							Thanx, Paul
