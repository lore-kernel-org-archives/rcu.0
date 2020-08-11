Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A970C433DF
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4420771
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160010;
	bh=vjw900Ykxtpys0XiY+Ng+zWDsAzIa4nyeQkaPls1JVo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=nBQ00YS5uelJClZ2tkRkdeuyfjDBFJI6TMPEad0PRSxDBzEXb/NY9Agl/o3BD81ce
	 /FDEYIoknsHvcMOAA5QXM+oalrHVLPIgzbpGXkjQR6loIatlcWo04o68TkmVhy7ZjD
	 /MPLV59+vMghwLrXSOtsqjaTzsp6l+Oo0iPdIEgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgHKPd3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbgHKPd3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 11:33:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F108A20768;
        Tue, 11 Aug 2020 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160008;
        bh=vjw900Ykxtpys0XiY+Ng+zWDsAzIa4nyeQkaPls1JVo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WDQZCYipHsW7cpB2hiPJst1nKZzkfiP9I6pIFg1IxyvJh7SftsdFxh4f15ce1RMJ/
         MVMZergQGKllK0YBV+dnJk2jhmDaA4hJmROh+j1anjyn+NVWbXnHe4uPgp6FzP03oq
         OAUZwat8DzX3hn60ejp8CrybtM2sh3wZGZRBXTGY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B3377352308E; Tue, 11 Aug 2020 08:33:27 -0700 (PDT)
Date:   Tue, 11 Aug 2020 08:33:27 -0700
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
Message-ID: <20200811153327.GW4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 11, 2020 at 04:44:21PM +0200, Thomas Gleixner wrote:
> Michal Hocko <mhocko@suse.com> writes:
> > On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
> >> > On Sun 09-08-20 22:43:53, Uladzislau Rezki (Sony) wrote:
> >> > Is there any fundamental problem to make zone raw_spin_lock?
> >> > 
> >> Good point. Converting a regular spinlock to the raw_* variant can solve 
> >> an issue and to me it seems partly reasonable. Because there are other
> >> questions if we do it:
> >> 
> >> a) what to do with kswapd and "wake-up path" that uses sleepable lock:
> >>     wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
> >
> > If there is no RT friendly variant for waking up process from the atomic
> > context then we might need to special case this for the RT tree.
> 
> That's a solvable problem.
> 
> >> b) How RT people reacts on it? I guess they will no be happy.
> >
> > zone->lock should be held for a very limited amount of time.
> 
> Emphasis on should. free_pcppages_bulk() can hold it for quite some time
> when a large amount of pages are purged. We surely would have converted
> it to a raw lock long time ago otherwise.
> 
> For regular enterprise stuff a few hundred microseconds might qualify as
> a limited amount of time. For advanced RT applications that's way beyond
> tolerable..
> 
> >> As i described before, calling the __get_free_page(0) with 0 as argument
> >> will solve the (a). How correctly is it? From my point of view the logic
> >> that bypass the wakeup path should be explicitly defined.
> >
> > gfp_mask == 0 is GFP_NOWAIT (aka an atomic allocation request) which
> > doesn't wake up kswapd. So if the wakeup is a problem then this would be
> > a way to go.
> 
> The wakeup is the least of my worries.
> 
> > To me it would make more sense to support atomic allocations also for
> > the RT tree. Having both GFP_NOWAIT and GFP_ATOMIC which do not really
> > work for atomic context in RT sounds subtle and wrong.
> 
> Well, no. RT moves almost everything out of atomic context which means
> that GFP_ATOMIC is pretty meanlingless on a RT kernel. RT sacrifies
> performance for determinism. It's a known tradeoff.
> 
> Now RCU creates a new thing which enforces to make page allocation in
> atomic context possible on RT. What for?
> 
> What's the actual use case in truly atomic context for this new thing on
> an RT kernel?

It is not just RT kernels.  CONFIG_PROVE_RAW_LOCK_NESTING=y propagates
this constraint to all configurations, and a patch in your new favorite
subsystem really did trigger this lockdep check in a non-RT kernel.

> The actual RCU code disabling interrupts is an implementation detail
> which can easily be mitigated with a local lock.

In this case, we are in raw-spinlock context on entry to kfree_rcu().

							Thanx, Paul
