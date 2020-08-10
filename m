Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A71C433DF
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 19:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31ECA22BF3
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 19:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgHJTZc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:25:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730039AbgHJTZ2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 15:25:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71F94AE24;
        Mon, 10 Aug 2020 19:25:46 +0000 (UTC)
Date:   Mon, 10 Aug 2020 21:25:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200810192525.GG4773@dhcp22.suse.cz>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810160739.GA29884@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
> > On Sun 09-08-20 22:43:53, Uladzislau Rezki (Sony) wrote:
> > [...]
> > > Limitations and concerns (Main part)
> > > ====================================
> > > The current memmory-allocation interface presents to following
> > > difficulties that this patch is designed to overcome:
> > > 
> > > a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
> > >    complain about violation("BUG: Invalid wait context") of the
> > >    nesting rules. It does the raw_spinlock vs. spinlock nesting
> > >    checks, i.e. it is not legal to acquire a spinlock_t while
> > >    holding a raw_spinlock_t.
> > > 
> > >    Internally the kfree_rcu() uses raw_spinlock_t(in rcu-dev branch)
> > >    whereas the "page allocator" internally deals with spinlock_t to
> > >    access to its zones. The code also can be broken from higher level
> > >    of view:
> > >    <snip>
> > >        raw_spin_lock(&some_lock);
> > >        kfree_rcu(some_pointer, some_field_offset);
> > >    <snip>
> > 
> > Is there any fundamental problem to make zone raw_spin_lock?
> > 
> Good point. Converting a regular spinlock to the raw_* variant can solve 
> an issue and to me it seems partly reasonable. Because there are other
> questions if we do it:
> 
> a) what to do with kswapd and "wake-up path" that uses sleepable lock:
>     wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).

If there is no RT friendly variant for waking up process from the atomic
context then we might need to special case this for the RT tree.

> b) How RT people reacts on it? I guess they will no be happy.

zone->lock should be held for a very limited amount of time.

> As i described before, calling the __get_free_page(0) with 0 as argument
> will solve the (a). How correctly is it? From my point of view the logic
> that bypass the wakeup path should be explicitly defined.

gfp_mask == 0 is GFP_NOWAIT (aka an atomic allocation request) which
doesn't wake up kswapd. So if the wakeup is a problem then this would be
a way to go.

> Or we can enter the allocator with (__GFP_HIGH|__GFP_ATOMIC) that bypass
> the __GFP_KSWAPD_RECLAIM as well.

This would be an alternative which consumes memory reserves. Is this
really needed for the particular case?

> 
> Any thoughts here? Please comment.
> 
> Having proposed flag will not heart RT latency and solve all concerns.
> 
> > > b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
> > >    is converted into sleepable variant. Invoking the page allocator from
> > >    atomic contexts leads to "BUG: scheduling while atomic".
> > 
> > [...]
> > 
> > > Proposal
> > > ========
> > > 1) Make GFP_* that ensures that the allocator returns NULL rather
> > > than acquire its own spinlock_t. Having such flag will address a and b
> > > limitations described above. It will also make the kfree_rcu() code
> > > common for RT and regular kernel, more clean, less handling corner
> > > cases and reduce the code size.
> > 
> > I do not think this is a good idea. Single purpose gfp flags that tend
> > to heavily depend on the current implementation of the page allocator
> > have turned out to be problematic. Users used to misunderstand their
> > meaning resulting in a lot of abuse which was not trivial to remove.
> > This flag seem to fall into exactly this sort of category. If there is a
> > problem in nesting then that should be addressed rather than a new flag
> > exported IMHO. If that is absolutely not possible for some reason then
> > we can try to figure out what to do but that really need a very strong
> > justification.
> > 
> The problem that i see is we can not use the page allocator from atomic
> contexts, what is our case:
> 
> <snip>
>     local_irq_save(flags) or preempt_disable() or raw_spinlock();
>     __get_free_page(GFP_ATOMIC);
> <snip>
> 
> So if we can convert the page allocator to raw_* lock it will be appreciated,
> at least from our side, IMHO, not from RT one. But as i stated above we need
> to sort raised questions out if converting is done.
> 
> What is your view?

To me it would make more sense to support atomic allocations also for
the RT tree. Having both GFP_NOWAIT and GFP_ATOMIC which do not really
work for atomic context in RT sounds subtle and wrong.
-- 
Michal Hocko
SUSE Labs
