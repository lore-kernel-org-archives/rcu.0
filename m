Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC68C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 15:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2026820855
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597333322;
	bh=VXnU5/ocESCROl+hxCUfrt0MWEogC6G/QevOWXTzutw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=E9moF8PvB3YofJs7mN1fsdVrwmhT8ZgiruF6bWDbFXnAF0S7e/WKwMdgUPunUlPHy
	 yqF0wojsnyqDG4oGFVpA+J3IjWFpTyhjOs3k2mYRt/p6aROqnP5j7YOok/NJLj9oHI
	 RMSa/6AYPpRMLlnr44oAkWuB3uLAULbTd5YuDaSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHMPmB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgHMPmB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 11:42:01 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3939D20829;
        Thu, 13 Aug 2020 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597333320;
        bh=VXnU5/ocESCROl+hxCUfrt0MWEogC6G/QevOWXTzutw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O8VmC9iJktYuMqfPtf9Yt+8H1q/+BEKEq46neXEh78fusuQoTMVOm35cb++k+P3Vd
         nQ9/4we3SqjSLvlqp1FFNDsgXSsLxOQbOosGzSHx58mcgQaup9Ob2zZrtPbKgCqq25
         c7INpMCBfUOh3eFZMii6NO/B79x1Lnmi5d0Tp5c4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BAB8E352279C; Thu, 13 Aug 2020 08:41:59 -0700 (PDT)
Date:   Thu, 13 Aug 2020 08:41:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813154159.GR4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813145335.GN9477@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 04:53:35PM +0200, Michal Hocko wrote:
> On Thu 13-08-20 16:34:57, Thomas Gleixner wrote:
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
> 
> Hmm. I am likely missing something really important here. We have two
> problems at hand:
> 1) RT will become broken as soon as this new RCU functionality which
> requires an allocation from inside of raw_spinlock hits the RT tree
> 2) lockdep splats which are telling us that early because of the
> raw_spinlock-> spin_lock dependency.

That is a reasonable high-level summary.

> 1) can be handled by handled by the bailing out whenever we have to use
> zone->lock inside the buddy allocator - essentially even more strict
> NOWAIT semantic than we have for RT tree - proposed (pseudo) patch is
> trying to describe that.

Unless I am missing something subtle, the problem with this approach
is that in production-environment CONFIG_PREEMPT_NONE=y kernels, there
is no way at runtime to distinguish between holding a spinlock on the
one hand and holding a raw spinlock on the other.  Therefore, without
some sort of indication from the caller, this approach will not make
CONFIG_PREEMPT_NONE=y users happy.

> 2) would become a false positive if 1) is in place, right? RT wouldn't
> do the illegal nesting and !RT would just work fine because
> GFP_RT_NOWAIT would be simply GFP_NOWAIT & ~__GFP_KSWAPD_RECLAIM.
> Why should we limit the functionality of the allocator for something
> that is not a real problem?

I will confess that I found this approach quite attractive, at least
until I dug into it.  But it runs up against the inability to distinguish
between holding a spinlock and holding a raw spinlock.  This inability
shows up in non-debugging CONFIG_PREEMPT_NONE=y kernels.  (Specifically,
production kernels of this type will have CONFIG_PREEMPT_COUNT=n.)

I will always have a warm spot in my heart for RT, but this
CONFIG_PREEMPT_NONE=y&&CONFIG_PREEMPT_COUNT=n configuration is still
very important.

> > PeterZ might have opinions about that too I suspect.
> > 
> > Really, if your primary lockless caches are empty then any allocation
> > which comes from deep atomic context should simply always fail. Being
> > stuck in an interrupt handler or even deeper for 200+ microseconds
> > waiting for zone lock is just bonkers IMO.
> 
> That would require changing NOWAIT/ATOMIC allocations semantic quite
> drastically for !RT kernels as well. I am not sure this is something we
> can do. Or maybe I am just missing your point.

Exactly, and avoiding changing this semantic for current users is
precisely why we are proposing some sort of indication to be passed
into the allocation request.  In Uladzislau's patch, this was the
__GFP_NO_LOCKS flag, but whatever works.

							Thanx, Paul
