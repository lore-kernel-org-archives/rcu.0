Return-Path: <SRS0=pjFQ=6H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF39C54FCB
	for <rcu@archiver.kernel.org>; Thu, 23 Apr 2020 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C572076C
	for <rcu@archiver.kernel.org>; Thu, 23 Apr 2020 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587664971;
	bh=PtHvISQThy7g71GdSKI/mLDDG7TnVFxrZ8SfuAr4FEM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=BGeBbXCjx/YjgeA0aLVPp+tt3B6txZO1QnB3qkc82+ebtmImUHElCMxJd3TjT6oOB
	 U5VIIbh1NfwJz/hxTuK4jOdufm3dVbAAdXlujBdfMOvJangaWR4iM3GIrSCs3hd7u4
	 N1u4nl7bGonqEC/eARRqAjDOe7vcuFL9sG3hIv44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgDWSCv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbgDWSCu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Apr 2020 14:02:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD48620736;
        Thu, 23 Apr 2020 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587664969;
        bh=PtHvISQThy7g71GdSKI/mLDDG7TnVFxrZ8SfuAr4FEM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t9FZvHLFoyc2kemRJuW6yVDZPaSX57RDg8gZopCPGwfs/pKf88vRAWUoMFBUrjcz3
         T7gguUvYwThqZ/gTfhxM2S+RWywqEdveWA0Q3ArUSsfRJCiu1hI5oTs8MxS587BFU6
         tMi4hlGWIezTrQP1Bw2Bs6QW2T9Lpnx/ANJBUBm8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 962A53522721; Thu, 23 Apr 2020 11:02:49 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:02:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200423180249.GT17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200413211504.108086-1-joel@joelfernandes.org>
 <20200414194353.GQ17661@paulmck-ThinkPad-P72>
 <20200416103007.GA3925@pc636>
 <20200416131745.GA90777@google.com>
 <20200416180100.GT17661@paulmck-ThinkPad-P72>
 <20200422145752.GB362484@cmpxchg.org>
 <20200422153503.GQ17661@paulmck-ThinkPad-P72>
 <20200423174831.GB389168@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423174831.GB389168@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 23, 2020 at 01:48:31PM -0400, Johannes Weiner wrote:
> On Wed, Apr 22, 2020 at 08:35:03AM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 22, 2020 at 10:57:52AM -0400, Johannes Weiner wrote:
> > > On Thu, Apr 16, 2020 at 11:01:00AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Apr 16, 2020 at 09:17:45AM -0400, Joel Fernandes wrote:
> > > > > On Thu, Apr 16, 2020 at 12:30:07PM +0200, Uladzislau Rezki wrote:
> > > > > > I have a question about dynamic attaching of the rcu_head. Do you think
> > > > > > that we should drop it? We have it because of it requires 8 + syzeof(struct rcu_head)
> > > > > > bytes and is used when we can not allocate 1 page what is much more for array purpose.
> > > > > > Therefore, dynamic attaching can succeed because of using SLAB and requesting much
> > > > > > less memory then one page. There will be higher chance of bypassing synchronize_rcu()
> > > > > > and inlining freeing on a stack.
> > > > > > 
> > > > > > I agree that we should not use GFP_* flags instead we could go with GFP_NOWAIT |
> > > > > > __GFP_NOWARN when head attaching only. Also dropping GFP_ATOMIC to keep
> > > > > > atomic reserved memory for others.
> > > > 
> > > > I must defer to people who understand the GFP flags better than I do.
> > > > The suggestion of __GFP_RETRY_MAYFAIL for no memory pressure (or maybe
> > > > when the CPU's reserve is not yet full) and __GFP_NORETRY otherwise came
> > > > from one of these people.  ;-)
> > > 
> > > The exact flags we want here depends somewhat on the rate and size of
> > > kfree_rcu() bursts we can expect. We may want to start with one set
> > > and instrument allocation success rates.
> > > 
> > > Memory tends to be fully consumed by the filesystem cache, so some
> > > form of light reclaim is necessary for almost all allocations.
> > > 
> > > GFP_NOWAIT won't do any reclaim by itself, but it'll wake kswapd.
> > > Kswapd maintains a small pool of free pages so that even allocations
> > > that are allowed to enter reclaim usually don't have to. It would be
> > > safe for RCU to dip into that.
> > > 
> > > However, there are some cons to using it:
> > > 
> > > - Depending on kfree_rcu() burst size, this pool could exhaust (it's
> > > usually about half a percent of memory, but is affected by sysctls),
> > > and then it would fail NOWAIT allocations until kswapd has caught up.
> > > 
> > > - This pool is shared by all GFP_NOWAIT users, and many (most? all?)
> > > of them cannot actually sleep. Often they would have to drop locks,
> > > restart list iterations, or suffer some other form of deterioration to
> > > work around failing allocations.
> > > 
> > > Since rcu wouldn't have anything better to do than sleep at this
> > > juncture, it may as well join the reclaim effort.
> > > 
> > > Using __GFP_NORETRY or __GFP_RETRY_MAYFAIL would allow them that
> > > without exerting too much pressure on the VM.
> > 
> > Thank you for looking this over and for the feedback!
> > 
> > Good point on the sleeping.  My assumption has been that sleeping waiting
> > for a grace period was highly likely to allow memory to eventually be
> > freed, and that there is a point of diminishing returns beyond which
> > adding additional tasks to the reclaim effort does not help much.
> 
> There is when the VM is struggling, but not necessarily when there is
> simply a high, concurrent rate of short-lived file cache allocations.
> 
> Kswapd can easily reclaim gigabytes of clean page cache each second,
> but there might be enough allocation concurrency from other threads to
> starve a kfree_rcu() that only makes a very cursory attempt at getting
> memory out of being able to snap up some of those returns.
> 
> In that scenario it makes sense to be a bit more persistent, or even
> help scale out the concurrency of reclaim to that of allocations.
> 
> > Here are some strategies right offhand when sleeping is required:
> > 
> > 1.	Always sleep in synchronize_rcu() in order to (with high
> > 	probability) free the memory.  This might mean that the reclaim
> > 	effort goes slower than would be good.
> > 
> > 2.	Always sleep in the memory allocator in order to help reclaim
> > 	along.	(This is a strawman version of what I expect your
> > 	proposal really is, but putting it here for completeness, please
> > 	see below.)
> > 
> > 3.	Always sleep in the memory allocator in order to help reclaim
> > 	along, but return failure at some point.  Then the caller
> > 	invokes synchronize_rcu().  When to return failure?
> > 
> > 	o	After some substantial but limited amount of effort has
> > 		been spent on reclaim.
> > 
> > 	o	When it becomes likely that further reclaim effort
> > 		is not going to free up additional memory.
> > 
> > I am guessing that you are thinking in terms of specifying GFP flags to
> > result in some variant of #3.
> 
> Yes, although I would add
> 
> 	o	After making more than one attempt at the freelist to
> 		prevent merely losing races when the allocator/reclaim
> 		subsystem is mobbed by a high concurrency of requests.
> 
> __GFP_NORETRY (despite its name) accomplishes this.
> 
> __GFP_RETRY_MAYFAIL is yet more persistent, but may retry for quite a
> while if the allocation keeps losing the race for a page. This
> increases the chance of the allocation eventually suceeding, but also
> the risk of 1) trying to get memory for longer than a
> synchronize_rcu() might have taken and 2) exerting more temporary
> memory pressure on the workload* than might be productive.
> 
> So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
> further decisions based on instrumentation of the success rates of
> these opportunistic allocations.
> 
> * Reclaim and OOM handling will be fine since no reserves are tapped

Thank you for the explanation!  Makes sense to me!!!

Joel, Vlad, does this seem reasonable?

							Thanx, Paul
