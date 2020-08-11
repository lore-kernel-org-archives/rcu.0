Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A668EC433DF
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEF42076C
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597162773;
	bh=eSlY7bnaywQP2Qzm8/RoLCGGkJGUHuYdHvojM9qWpDg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hRH43xRWeVkS9qmf2+7yWIQ2O0c7r3HYTms17tHhtPjapu4J3ToLcy3WXvA4wSv+6
	 8xyNe2PzqMRm9pNIb0v+aRJhRTad0YYJKzvWsbUsY3FFuXtmb7s3oz4+kb92hXtLKp
	 ddhtm9Y4d7JwmQ2NBFV3mYBWJ0ozTj1xxi2gFGBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgHKQTd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgHKQTc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 12:19:32 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA7B206B5;
        Tue, 11 Aug 2020 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597162772;
        bh=eSlY7bnaywQP2Qzm8/RoLCGGkJGUHuYdHvojM9qWpDg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZVEGIHWMLJLCWOXy2zPXwFEWPqlLABJ4U8TkB9Q1qgj3XY+i2S7NSiY6Xz//PNRaI
         W1z5kGe5Zl+SR/6OahDUitkov36/DQjBJQXoIeN50kZLyYc8HbgSx4AggrRCiGUfct
         CMx658Og1vNxfKwgzGEWEAKgDLMRiivDZ3326qXY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D559B352308E; Tue, 11 Aug 2020 09:19:31 -0700 (PDT)
Date:   Tue, 11 Aug 2020 09:19:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811161931.GA1746@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
 <20200811153327.GW4295@paulmck-ThinkPad-P72>
 <87h7t96ve3.fsf@nanos.tec.linutronix.de>
 <20200811160240.GX4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811160240.GX4295@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 11, 2020 at 09:02:40AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 11, 2020 at 05:43:16PM +0200, Thomas Gleixner wrote:
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > > On Tue, Aug 11, 2020 at 04:44:21PM +0200, Thomas Gleixner wrote:
> > >> Now RCU creates a new thing which enforces to make page allocation in
> > >> atomic context possible on RT. What for?
> > >> 
> > >> What's the actual use case in truly atomic context for this new thing on
> > >> an RT kernel?
> > >
> > > It is not just RT kernels.  CONFIG_PROVE_RAW_LOCK_NESTING=y propagates
> > > this constraint to all configurations, and a patch in your new favorite
> > > subsystem really did trigger this lockdep check in a non-RT kernel.
> > >
> > >> The actual RCU code disabling interrupts is an implementation detail
> > >> which can easily be mitigated with a local lock.
> > >
> > > In this case, we are in raw-spinlock context on entry to kfree_rcu().
> > 
> > Where?
> 
> Some BPF code that needs to process and free a list.  As noted above,
> this is a patch rather than something that is already in mainline.
> Not surprising, though, given call_rcu() invocations in similar contexts.
> 
> Yes, we can perhaps rework all current and future callers to avoid
> invoking both call_rcu() and kfree_rcu() from raw atomic context, but
> the required change to permit this is quite a bit simpler.

I should hasten to add that from what I can see right now, the required
change allows telling the memory allocator bail out instead of acquiring
a non-raw spinlock.  I am absolutely not advocating converting the
allocator's spinlocks to raw spinlocks.

							Thanx, Paul
