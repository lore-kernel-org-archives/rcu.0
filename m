Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DF4C2D0A3
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 19:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3379720870
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 19:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604431104;
	bh=W1KrRl2SR9qaJPw6LcrcuRypZW22z89eV1jif/bLgYc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zSb5Y49pDUSdzBVVOnQdWnQGv5JxYrFc267aiCF31JeZdEW8fDmCOowuqwp2c01oT
	 RdrwlyZxJ93WwSStbrvCIQmyQHYOzRp92s1bP8jkEmR1UIYc1mAbsZiKhoDNiXzZa7
	 96XUKXTN0IO38yWFrj9QsLHLpwOkMf0Kw8L24mh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgKCTSY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgKCTSX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 14:18:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08DC20786;
        Tue,  3 Nov 2020 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604431102;
        bh=W1KrRl2SR9qaJPw6LcrcuRypZW22z89eV1jif/bLgYc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c1ygTLkcxdrfGoa4b5sqjlSXmqs1/Fu5qT7NqHnaighwVxjQiSVaYw5k4cjwg6i49
         ycxAFZ4CnGCr50uKv+qUtCFTxQzRt3R/E90AdhVblCa6+PKM2L63/ZTY5/ByuMcYB0
         R+50+86MRprDPSlpou2MQYyyBXl9/uqGudkx24PA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 50250352265F; Tue,  3 Nov 2020 11:18:22 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:18:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        willy@infradead.org
Subject: Re: [PATCH 01/16] rcu/tree: Add a work to allocate pages from
 regular context
Message-ID: <20201103191822.GC3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201103154723.GA1310511@google.com>
 <20201103163350.GA10665@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103163350.GA10665@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 05:33:50PM +0100, Uladzislau Rezki wrote:
> On Tue, Nov 03, 2020 at 10:47:23AM -0500, Joel Fernandes wrote:
> > On Thu, Oct 29, 2020 at 05:50:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > > The current memmory-allocation interface presents to following
> > > difficulties that this patch is designed to overcome:
> > > 
> > > a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
> > >    complain about violation("BUG: Invalid wait context") of the
> > >    nesting rules. It does the raw_spinlock vs. spinlock nesting
> > >    checks, i.e. it is not legal to acquire a spinlock_t while
> > >    holding a raw_spinlock_t.
> > > 
> > >    Internally the kfree_rcu() uses raw_spinlock_t whereas the
> > >    "page allocator" internally deals with spinlock_t to access
> > >    to its zones. The code also can be broken from higher level
> > >    of view:
> > >    <snip>
> > >        raw_spin_lock(&some_lock);
> > >        kfree_rcu(some_pointer, some_field_offset);
> > >    <snip>
> > > 
> > > b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
> > >    is converted into sleepable variant. Invoking the page allocator from
> > >    atomic contexts leads to "BUG: scheduling while atomic".
> > > 
> > > c) call_rcu() is invoked from raw atomic context and kfree_rcu()
> > >    and kvfree_rcu() are expected to be called from atomic raw context
> > >    as well.
> > > 
> > > Move out a page allocation from contexts which trigger kvfree_rcu()
> > > function to the separate worker. When a k[v]free_rcu() per-cpu page
> > > cache is empty a fallback mechanism is used and a special job is
> > > scheduled to refill the per-cpu cache.
> > 
> > Looks good, still reviewing here. BTW just for my education, I was wondering
> > about Thomas's email:
> > https://lkml.org/lkml/2020/8/11/939
> > 
> > If slab allocations in pure raw-atomic context on RT is not allowed or
> > recommended, should kfree_rcu() be allowed?
> >
> Thanks for reviewing, Joel :)
> 
> The decision was made that we need to support kfree_rcu() from "real atomic contexts",
> to align with how it used to be before. We can go and just convert our local locks
> to the spinlock_t variant but that was not Paul goal, it can be that some users need
> kfree_rcu() for raw atomics.

People invoke call_rcu() from raw atomics, and so we should provide
the same for kfree_rcu().  Yes, people could work around a raw-atomic
prohibition, but such prohibitions incur constant costs over time in
terms of development effort, increased bug rate, and increased complexity.
Yes, this does increase all of those for RCU, but the relative increase
is negligible, RCU being what it is.

> > slab can have same issue right? If per-cpu cache is drained, it has to
> > allocate page from buddy allocator and there's no GFP flag to tell it about
> > context where alloc is happening from.
> > 
> Sounds like that. Apart of that, it might turn out soon that we or somebody
> else will rise a question one more time about something GFP_RAW or GFP_NOLOCKS.
> So who knows..

I would prefer that slab provide some way of dealing with raw atomic
context, but the maintainers are thus far unconvinced.

> > Or are we saying that we want to support kfree on RT from raw atomic atomic
> > context, even though kmalloc is not supported? I hate to bring up this
> > elephant in the room, but since I am a part of the people maintaining this
> > code, I believe I would rather set some rules than supporting unsupported
> > usages. :-\ (Once I know what is supported and what isn't that is). If indeed
> > raw atomic kfree_rcu() is a bogus use case because of -RT, then we ought to
> > put a giant warning than supporting it :-(.
> > 
> We discussed it several times, the conclusion was that we need to support 
> kfree_rcu() from raw contexts. At least that was a clear signal from Paul 
> to me. I think, if we obtain the preemtable(), so it becomes versatile, we
> can drop the patch that is in question later on in the future.

Given a universally meaningful preemptible(), we could directly call
the allocator in some cases.  It might (or might not) still make sense
to defer the allocation when preemptible() indicated that a direct call
to the allocator was unsafe.

							Thanx, Paul
