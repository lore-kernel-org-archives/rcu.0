Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1038C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 18:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8342A20838
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597344778;
	bh=2mtKqGaeDkG8Ee6GYdHtGerH4iVD6LZfV/g1lZcfGsg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=s2lrrLwFSj2noU2CtYZ25esLbc9h53g5xJzRKcpwO2/M0J0Or3Ym/0klqeSPR9dQh
	 A7aswacqfIOvuaCIpAT7+ikGr1mUtgE6hv7ux1aHhN0RM2VKVUxOOSj9LqnKOke8s2
	 TVilZhq2zvYiZhvWpU1YCVDSeqeWxvyVSypgpzeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMSw6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMSw6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 14:52:58 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A2EF20774;
        Thu, 13 Aug 2020 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597344777;
        bh=2mtKqGaeDkG8Ee6GYdHtGerH4iVD6LZfV/g1lZcfGsg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uTMvGRFrpS2IgaqAEMO9B9XA/NuHEQtdGsjW9Rgdx6F0TcGUpampmvjFvu+JF2O3G
         jL8RAe3HF19kd2xITEDQWGruPNzzD+XJp0B6/Dxe0LtTGFb3ZvXedFrgjHw8wONwzM
         Z1+mI5lj4ZRC3S4R2W7gSIyCiDH52Klb7HMs87as=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2F969352279C; Thu, 13 Aug 2020 11:52:57 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:52:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200813185257.GF4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813182618.GX2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 08:26:18PM +0200, peterz@infradead.org wrote:
> On Thu, Aug 13, 2020 at 04:34:57PM +0200, Thomas Gleixner wrote:
> > Michal Hocko <mhocko@suse.com> writes:
> > > On Thu 13-08-20 15:22:00, Thomas Gleixner wrote:
> > >> It basically requires to convert the wait queue to something else. Is
> > >> the waitqueue strict single waiter?
> > >
> > > I would have to double check. From what I remember only kswapd should
> > > ever sleep on it.
> > 
> > That would make it trivial as we could simply switch it over to rcu_wait.
> > 
> > >> So that should be:
> > >> 
> > >> 	if (!preemptible() && gfp == GFP_RT_NOWAIT)
> > >> 
> > >> which is limiting the damage to those callers which hand in
> > >> GFP_RT_NOWAIT.
> > >> 
> > >> lockdep will yell at invocations with gfp != GFP_RT_NOWAIT when it hits
> > >> zone->lock in the wrong context. And we want to know about that so we
> > >> can look at the caller and figure out how to solve it.
> > >
> > > Yes, that would have to somehow need to annotate the zone_lock to be ok
> > > in those paths so that lockdep doesn't complain.
> > 
> > That opens the worst of all cans of worms. If we start this here then
> > Joe programmer and his dog will use these lockdep annotation to evade
> > warnings and when exposed to RT it will fall apart in pieces. Just that
> > at that point Joe programmer moved on to something else and the usual
> > suspects can mop up the pieces. We've seen that all over the place and
> > some people even disable lockdep temporarily because annotations don't
> > help.
> > 
> > PeterZ might have opinions about that too I suspect.
> 
> PeterZ is mightily confused by all of this -- also heat induced brain
> melt.
> 
> I thought the rule was:
> 
>  - No allocators (alloc/free) inside raw_spinlock_t, full-stop.
> 
> Why are we trying to craft an exception?

So that we can reduce post-grace-period cache misses by a factor of
eight when invoking RCU callbacks.  This reduction in cache misses also
makes it more difficult to overrun RCU with floods of either call_rcu()
or kfree_rcu() invocations.

The idea is to allocate page-sized arrays of pointers so that the callback
invocation can sequence through the array instead of walking a linked
list, hence the reduction in cache misses.

If the allocation fails, for example, during OOM events, we fall back to
the linked-list approach.  So, as with much of the rest of the kernel,
under OOM we just run a bit slower.

							Thanx, Paul
