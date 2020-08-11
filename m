Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754F6C433E0
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 21:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9DF20756
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597180174;
	bh=yO8dq+GYzKI3pBmtfR9dJRqDFTQTGZRWKVu+t+LvkGY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=eR9WOtG1RDELsVhHLBwFCHPie6wbuxStHiXWXsWWg2Y3ZQN0JHlvWm9saIeOzXPoQ
	 B1MIF0HkBdyKW7XgzLj3tDOgtf2CCnNfFqB8YNxGNQmJYM87eZk7cas7OE9fZl2Vyd
	 L+cyQfkfj2JG3OYgEDNE0479mhmgj2kFUb7beTc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgHKVJe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgHKVJd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 17:09:33 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3EDE205CB;
        Tue, 11 Aug 2020 21:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597180172;
        bh=yO8dq+GYzKI3pBmtfR9dJRqDFTQTGZRWKVu+t+LvkGY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eabVjfNhhkM5oPD2ZYU8CFXQe9OethQy5zj/0wymPHd/AZuPQFcgFvb7/wkaLXEF7
         nDhpYDRcHUrW1hOqn1EcW60ZFHF0EnXxkSBRCPDxwsmTX/avbFmTCum2lYYPsWMBoF
         Xvfs32vaa6yEFdZYPRt6oS8b0WlAFALL7KuX72RM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DB696352308E; Tue, 11 Aug 2020 14:09:31 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:09:31 -0700
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
Message-ID: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
 <20200811153327.GW4295@paulmck-ThinkPad-P72>
 <87h7t96ve3.fsf@nanos.tec.linutronix.de>
 <87eeod6kgx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeod6kgx.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 11, 2020 at 09:39:10PM +0200, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> >> On Tue, Aug 11, 2020 at 04:44:21PM +0200, Thomas Gleixner wrote:
> >>> Now RCU creates a new thing which enforces to make page allocation in
> >>> atomic context possible on RT. What for?
> >>> 
> >>> What's the actual use case in truly atomic context for this new thing on
> >>> an RT kernel?
> >>
> >> It is not just RT kernels.  CONFIG_PROVE_RAW_LOCK_NESTING=y propagates
> >> this constraint to all configurations, and a patch in your new favorite
> >> subsystem really did trigger this lockdep check in a non-RT kernel.
> >>
> >>> The actual RCU code disabling interrupts is an implementation detail
> >>> which can easily be mitigated with a local lock.
> >>
> >> In this case, we are in raw-spinlock context on entry to kfree_rcu().
> >
> > Where?
> 
> And aside of the where, wasn't kfree_rcu() from within raw spinlock held
> regions possible all the time? Either I'm missing something or you are
> fundamentally changing RCU internals. kfree_rcu() saved RT in various
> ways where invoking kfree() was just not an option. Confused...

Back in the old days (months ago!), it was possible to invoke kfree_rcu()
while holding a raw spinlock because kfree_rcu() didn't acquire any locks.
It didn't need to because it was just a wrapper around call_rcu().
And call_rcu(), along with the rest of RCU's internals, has used raw
spinlocks since near the beginnings of RT, which meant that it wasn't
a problem in the rare cases where call_rcu() needed to acquire one of
RCU's locks (for example, when call_rcu() sees that the current CPU has
accumulated more than 10,000 callbacks).

But one problem with the old kfree_rcu() approach is that the memory to
be freed is almost always cold in the cache by the time that the grace
period ends.  And this was made worse by the fact that the rcu_do_batch()
function traverses the list of objects to be freed as a linked list,
thus incurring a cache miss on each and every object.  The usual fix
for this sort of performance problem is to use arrays of pointers,
which on a 64-bit system with 64-byte cache lines reduces the number of
cache misses by a factor of eight.  In addition, decreasing the number
of post-grace-period cache misses increases the stability of RCU with
respect to callback flooding:  Because the kfree()s happen faster, it
is harder to overrun RCU with tight loops posting callbacks (as happened
some time back with certain types of ACLs).

Hence Ulad's work on kfree_rcu().  The approach is to allocate a
page-sized array to hold all the pointers, then fill in the rest of these
pointers on each subsequent kfree_rcu() call.  These arrays of pointers
also allows use of kfree_bulk() instead of kfree(), which can improve
performance yet more.  It is no big deal if kfree_rcu()'s allocation
attempts fail occasionally because it can simply fall back to the old
linked-list approach.  And given that the various lockless caches in
the memory allocator are almost never empty, in theory life is good.

But in practice, mainline now has CONFIG_PROVE_RAW_LOCK_NESTING,
and for good reason -- this Kconfig option makes it at least a
little bit harder for mainline developers to mess up RT.  But with
CONFIG_PROVE_RAW_LOCK_NESTING=y and lockdep enabled, mainline will now
sometimes complain if you invoke kfree_rcu() while holding a raw spinlock.
This happens when kfree_rcu() needs to invoke the memory allocator and
the memory allocator's caches are empty, thus resulting in the memory
allocator attempting to acquire a non-raw spinlock.

Because kfree_rcu() has a fallback available (just using the old linked
list), kfree_rcu() would work well given a way to tell the memory
allocator to return NULL instead of acquiring a non-raw spinlock.
Which is exactly what Ulad's recent patches are intended to do.

Since then, this thread has discussed various other approaches,
including using existing combinations of GFP_ flags, converting
the allocator's zone lock to a raw spinlock, and so on.

Does that help, or am I missing the point of your question?

							Thanx, Paul
