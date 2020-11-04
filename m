Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185A4C2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A5321734
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604499127;
	bh=QdSmr2H/GgIpCFk9ITs9nleAHoo5vpqgzq/nhlD5j5o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RDQjxi8rtGCc94yqRzaticE44ICmq8uUK1CA7/JdZm95h4d7ypOiNBG/laCGjbyXs
	 /gXrbW60bnpfU7PQ6z4PF+eMhCtpsPRnblJosZ9zNEfcUmjbSG/aNwbGQSAk6az9Xw
	 mlUBd05HOeSw77ttSQ3ONxH6Kqre45OryTe49cJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgKDOMC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:12:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbgKDOMB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 09:12:01 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811872236F;
        Wed,  4 Nov 2020 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604499120;
        bh=QdSmr2H/GgIpCFk9ITs9nleAHoo5vpqgzq/nhlD5j5o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Duct3QTlVzj9YCibH1nesMfdKdKDezUDsGB1ooKWnQvtzb4N8BLefok0d14rDbL5L
         9m0ELaVzExIPZznNhgFfetzco6BFybdu+phgtK8L4MBZg6Q4ryplDIjLofwygUxeY1
         D+mo6NtTbmCUWNig4HraDZrkvEZBcAhvGyzFBqNI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1BBBF3520294; Wed,  4 Nov 2020 06:12:00 -0800 (PST)
Date:   Wed, 4 Nov 2020 06:12:00 -0800
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
Message-ID: <20201104141200.GH3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201103154723.GA1310511@google.com>
 <20201103163350.GA10665@pc636>
 <20201103191822.GC3249@paulmck-ThinkPad-P72>
 <20201104123553.GC17782@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104123553.GC17782@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 01:35:53PM +0100, Uladzislau Rezki wrote:
> On Tue, Nov 03, 2020 at 11:18:22AM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 03, 2020 at 05:33:50PM +0100, Uladzislau Rezki wrote:
> > > On Tue, Nov 03, 2020 at 10:47:23AM -0500, Joel Fernandes wrote:
> > > > On Thu, Oct 29, 2020 at 05:50:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > The current memmory-allocation interface presents to following
> > > > > difficulties that this patch is designed to overcome:
> > > > > 
> > > > > a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
> > > > >    complain about violation("BUG: Invalid wait context") of the
> > > > >    nesting rules. It does the raw_spinlock vs. spinlock nesting
> > > > >    checks, i.e. it is not legal to acquire a spinlock_t while
> > > > >    holding a raw_spinlock_t.
> > > > > 
> > > > >    Internally the kfree_rcu() uses raw_spinlock_t whereas the
> > > > >    "page allocator" internally deals with spinlock_t to access
> > > > >    to its zones. The code also can be broken from higher level
> > > > >    of view:
> > > > >    <snip>
> > > > >        raw_spin_lock(&some_lock);
> > > > >        kfree_rcu(some_pointer, some_field_offset);
> > > > >    <snip>
> > > > > 
> > > > > b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
> > > > >    is converted into sleepable variant. Invoking the page allocator from
> > > > >    atomic contexts leads to "BUG: scheduling while atomic".
> > > > > 
> > > > > c) call_rcu() is invoked from raw atomic context and kfree_rcu()
> > > > >    and kvfree_rcu() are expected to be called from atomic raw context
> > > > >    as well.
> > > > > 
> > > > > Move out a page allocation from contexts which trigger kvfree_rcu()
> > > > > function to the separate worker. When a k[v]free_rcu() per-cpu page
> > > > > cache is empty a fallback mechanism is used and a special job is
> > > > > scheduled to refill the per-cpu cache.
> > > > 
> > > > Looks good, still reviewing here. BTW just for my education, I was wondering
> > > > about Thomas's email:
> > > > https://lkml.org/lkml/2020/8/11/939
> > > > 
> > > > If slab allocations in pure raw-atomic context on RT is not allowed or
> > > > recommended, should kfree_rcu() be allowed?
> > > >
> > > Thanks for reviewing, Joel :)
> > > 
> > > The decision was made that we need to support kfree_rcu() from "real atomic contexts",
> > > to align with how it used to be before. We can go and just convert our local locks
> > > to the spinlock_t variant but that was not Paul goal, it can be that some users need
> > > kfree_rcu() for raw atomics.
> > 
> > People invoke call_rcu() from raw atomics, and so we should provide
> > the same for kfree_rcu().  Yes, people could work around a raw-atomic
> > prohibition, but such prohibitions incur constant costs over time in
> > terms of development effort, increased bug rate, and increased complexity.
> > Yes, this does increase all of those for RCU, but the relative increase
> > is negligible, RCU being what it is.
> > 
> I see your point.
> 
> > > > slab can have same issue right? If per-cpu cache is drained, it has to
> > > > allocate page from buddy allocator and there's no GFP flag to tell it about
> > > > context where alloc is happening from.
> > > > 
> > > Sounds like that. Apart of that, it might turn out soon that we or somebody
> > > else will rise a question one more time about something GFP_RAW or GFP_NOLOCKS.
> > > So who knows..
> > 
> > I would prefer that slab provide some way of dealing with raw atomic
> > context, but the maintainers are thus far unconvinced.
> > 
> I think, when preempt_rt is fully integrated to the kernel, we might get
> new users with such demand. So, it is not a closed topic so far, IMHO.

Agreed!  ;-)

> > > > Or are we saying that we want to support kfree on RT from raw atomic atomic
> > > > context, even though kmalloc is not supported? I hate to bring up this
> > > > elephant in the room, but since I am a part of the people maintaining this
> > > > code, I believe I would rather set some rules than supporting unsupported
> > > > usages. :-\ (Once I know what is supported and what isn't that is). If indeed
> > > > raw atomic kfree_rcu() is a bogus use case because of -RT, then we ought to
> > > > put a giant warning than supporting it :-(.
> > > > 
> > > We discussed it several times, the conclusion was that we need to support 
> > > kfree_rcu() from raw contexts. At least that was a clear signal from Paul 
> > > to me. I think, if we obtain the preemtable(), so it becomes versatile, we
> > > can drop the patch that is in question later on in the future.
> > 
> > Given a universally meaningful preemptible(), we could directly call
> > the allocator in some cases.  It might (or might not) still make sense
> > to defer the allocation when preemptible() indicated that a direct call
> > to the allocator was unsafe.
> > 
> I do not have a strong opinion here. Giving the fact that maintaining of
> such "deferring" is not considered as a big effort, i think, we can live
> with it.

And agreed here as well.  If this were instead a large body of complex
code, I might feel otherwise.  But as it is, why worry?

							Thanx, Paul
