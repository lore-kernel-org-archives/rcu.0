Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0DCC433F5
	for <rcu@archiver.kernel.org>; Thu, 21 Oct 2021 22:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADC861251
	for <rcu@archiver.kernel.org>; Thu, 21 Oct 2021 22:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhJUW0x (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhJUW0w (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Oct 2021 18:26:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EEFB61354;
        Thu, 21 Oct 2021 22:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634855076;
        bh=OhoeVdSi2C1vVlxwW1Oip3gQuIDUNpweF6qFnyJMsFc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=b+xdNWjGQ9VwPO04q15ShBJ+XSKf8oUiD1o3INJqDMgydXapNzaaRdxt1z0a0HI3H
         AGD8NYGptUiXAzdihCKQti2KnJwlMo2jNRCZfN9LAUg4uYj+BRvLTIAfDf5gcVCWBo
         VVCcmUjOrvqrdnf8NC1pijI0om4Ztf6PeOE4+VcS4r5gPZ6oW901EOja/3BeDN7Sv4
         ieKeS2XDx7OSrEQlo0wtVDWISIGPSYilcQOggqpSQhGr9NRE2io+7xi6ul6Bal1z1l
         FojjJK70YK3nsQR7sdbHBXR2iM+/SpTRZuJpyPhREdFqPVIFzxjBbSESyC3026PCgX
         8dyEzzlXC3wyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EECED5C06CD; Thu, 21 Oct 2021 15:24:35 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:24:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Seth Forshee <seth@forshee.me>
Cc:     rcu@vger.kernel.org
Subject: Re: Improving RCU wait in mini_qdisc_pair_swap()
Message-ID: <20211021222435.GW880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YXCIrNiLY5kMmcSI@ubuntu-x1>
 <20211020224430.GO880162@paulmck-ThinkPad-P17-Gen-1>
 <YXF1+qMXukbnf3gr@ubuntu-x1>
 <20211021175537.GU880162@paulmck-ThinkPad-P17-Gen-1>
 <YXHYuYnm1nrUTkuW@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXHYuYnm1nrUTkuW@ubuntu-x1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 21, 2021 at 04:16:41PM -0500, Seth Forshee wrote:
> On Thu, Oct 21, 2021 at 10:55:37AM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 21, 2021 at 09:15:22AM -0500, Seth Forshee wrote:
> > > On Wed, Oct 20, 2021 at 03:44:30PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Oct 20, 2021 at 04:22:52PM -0500, Seth Forshee wrote:
> > > > > Hi Paul,
> > > > 
> > > > Hello, Seth!
> > > > 
> > > > Adding the rcu list on CC in case others are seeing similar issues.
> > > > 
> > > > > You got some questions the other day from (I believe) Mathieu Desnoyers,
> > > > > who a colleague of mine had reached out to about this problem. Thanks a
> > > > > lot for your suggestions! I was headed in the right direction, but I
> > > > > wouldn't have got there as quickly, and I'm not sure I would have known
> > > > > to use start_poll_syncronize_rcu(). I do have a question though, so I
> > > > > thought I'd reach out to you about it while I continue to test the
> > > > > patch.
> > > > > 
> > > > > To refresh your memory, or fill in bits that might not have made it to
> > > > > you: we're seeing a lot of time spent in rcu_barrier() from
> > > > > mini_qdisc_pair_swap() when we are trying to (quickly) restore a bunch
> > > > > of network connections for VMs. I'm trying to make this go faster.
> > > > > 
> > > > > My patch is pasted below, which speeds things up drastically, by a
> > > > > factor of 10,000 or so in most cases. My question is about initializing
> > > > > mini_Qdisc.rcu_state. On my first pass I took a cautious approach and
> > > > > initialized it from get_state_synchronize_rcu() when the structure is
> > > > > first initialized. That patch didn't really help. I suspected this was
> > > > > because the time between init and calling mini_qdisc_pair_swap() was
> > > > > short enough that a grace period had not elapsed, so in the patch below
> > > > > rcu_state is initialized to 0 (due to the fact that the memory is
> > > > > kzalloc-ed). I think this should be safe, based on my understanding of
> > > > > how the cookie works and the fact that no other task yet has a reference
> > > > > to either buffer. Is this correct?
> > > > 
> > > > Let me see if I understand your reasoning.  Right after creating the
> > > > mini Qdisc, someone might be accessing the current buffer, but no one
> > > > ever was accessing the non-current buffer.  So on the initial swap
> > > > (and -only- on the initial swap), there are no readers to wait for.
> > > > Is that your line of reasoning?  If so, sort-of OK, but let's talk about
> > > > more organized ways of handling this.
> > > 
> > > That's almost right, just missing a couple of details. Initially neither
> > > buffer (let's call them miniq1 and miniq2 for clarity) is active, and
> > > *p_miniq is NULL until the first mini_qdisc_pair_swap() call, so there
> > > can be no readers for either. On the first swap miniq1 becomes active,
> > > and there are no readers to wait for. On the second swap there are no
> > > readers of miniq2 to wait for, and at this time miniq1->rcu_state will
> > > be set. On the third swap we might finally have readers of miniq1 to
> > > wait for.
> > > 
> > > Also, this function is a little different from the way your examples are
> > > structured in that oldstate is saved at the end of the function, and the
> > > wait on oldstate happens in a subsequent call to the function. So it's
> > > more like:
> > > 
> > >         oldstate = start_poll_synchronize_rcu();
> > >         return;
> > > 
> > >         // Some unknown amount of time passes ...
> > > 
> > >         cond_synchronize_rcu(oldstate);
> > > 
> > > So I suspect that it wouldn't be uncommon for enough time to have passed
> > > that there are no readers to wait for.
> > > 
> > > But that brings us to an important point. I'm not a networking expert, I
> > > don't know what common patterns are for these swaps, so I'm probably
> > > ill-equipped to say what makes the most sense beyond the specific
> > > scenario I'm trying to improve. These swaps will happen when setting up
> > > QoS on a network interface, so if I had to guess I'd think the most
> > > common pattern would be short bursts of activity when interfaces are
> > > set up. I know the pattern in the use case I've been debugging, which
> > > sees a lot of "first swaps" for different instances of mini_Qdisc_pair,
> > > and a smaller number of "second swaps" about 200 ms after the first,
> > > which means we're paying a high price for the rcu_barrier() when there
> > > can be no readers. Other scenaios might result in multiple swaps on the
> > > same instance within a short time period, but I can't say for sure.
> > 
> > Very good!  We can pool our ignorance of networking!  ;-)
> > 
> > If the common case really is mostly just the one swap, I can easily give
> > you an API that hands you an already-expired "oldstate".  Full disclosure:
> > On 32-bit systems, after 2^31 grace periods (maybe as quickly as three
> > months of runtime), the "oldstate" would no longer appear to be at
> > all old.  And would take another 2^31 grace periods to look old again.
> > 
> > However, that is an unusual API, so I would want to know that it was
> > really useful before creating it.
> > 
> > Plus if you start early enough at boot, the value of zero will not look
> > old, just so you know.  ;-)
> 
> Of course. However, when I was initializing mini_Qdisc.rcu_state from
> get_state_synchronize_rcu() along with cond_synchronize_rcu(), I was
> still seeing many calls (50% or more) to mini_qdisc_pair_swap() take
> tens of milliseconds in my use case. When I initialized rcu_state to 0 I
> saw virtually no times over 1 ms. Trading a high probability of a long
> delay for a low probability seems like an improvement to me. :-)
> 
> I think the new API is probably unnecessary though. I have some notes
> from testing the other two approaches below.

Happy to avoid further RCU API proliferation!  ;-)

> > > > However, another approach is something like this:
> > > > 
> > > > 	oldstate = start_poll_synchronize_rcu();
> > > > 
> > > > 	// do something.
> > > > 
> > > > 	if (!poll_state_synchronize_rcu(oldstate))
> > > > 		synchronize_rcu_expedited();
> > > > 
> > > > This will be roughly an order of magnitude faster than you would see with
> > > > your current cond_synchronize_rcu().  And it will speed up all swaps,
> > > > not just the first one.  On the other hand, synchronize_rcu_expedited()
> > > > sends IPIs to all non-idle CPUs, which is often OK, but not so much for
> > > > heavy real-time workloads.
> > > > 
> > > > So you can let the heavy real-time workloads
> > > > have slowish Qdisc switching and IPI the IPI-insensitive workloads:
> > > > 
> > > > 	oldstate = start_poll_synchronize_rcu();
> > > > 
> > > > 	// do something.
> > > > 
> > > > 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > > 		cond_synchronize_rcu(oldstate);
> > > > 	else if (!poll_state_synchronize_rcu(oldstate))
> > > > 		synchronize_rcu_expedited();
> > > 
> > > I was concerned about the system-wide impact synchronize_rcu_expedited()
> > > has, but this at least avoids doing it if it's unnecessary. If it's bad
> > > form to leave mini_Qdisc.rcu_state initialized to 0, this option is
> > > preferable from my perspective.
> > 
> > This might well be the best approach if multiple swaps are at all common.
> > 
> > But if needed, we really could do both:  Make initial swaps really fast,
> > and improve the performance of later swaps.
> 
> Using this the time for mini_qdisc_pair_swap() to complete was similar
> to my earlier patch with mini_Qdisc.rcu_state initialized to 0. So this
> seems acceptible for my purposes.

Not sure which approach "this" refers to.  For the moment, I am assuming
the last code fragment shown above.

> > > > Yet another approach is this:
> > > > 
> > > > 	oldstate = start_poll_synchronize_rcu();
> > > > 
> > > > 	// do something.
> > > > 
> > > > 	while (!poll_state_synchronize_rcu(oldstate))
> > > > 		schedule_timeout_idle(1);
> > > > 
> > > > The advantage of this one is that you get credit for partial progress
> > > > through grace periods, but it won't be anywhere near as fast as
> > > > synchronize_rcu_expedited().
> > > 
> > > If we need to initialize mini_Qdisc.rcu_state up front this approach
> > > probably won't improve things much for my problem.
> > 
> > It all depends on how long between swaps.  ;-)
> 
> This approach helps, but I still see about 50% of the
> mini_qdisc_pair_swap() calls taking tens of milliseconds. This is
> similar to what I saw using cond_synchronize_rcu() with rcu_state
> initialized from get_state_synchronize_rcu().

OK, which means that the swaps are too closely spaced to get much
benefit about 50% of the time.

> Wouldn't this also behave very poorly in the wrapping case you mentioned
> above?

I confess, I have no idea what case is the "wrapping case".

But any implementation that needs to wait for a full normal
(non-expedited) grace period will suffer at least 50% of the time
when running your workload.  And of the above code fragments, only the
synchronize_rcu_expedited() variants avoid waiting for a full normal
grace period.

> In the end, I'm happy to move forward using synchronize_rcu_expedited().
> I'm going to test a bit more, and I should have a patch out sometime
> tomorrow.

Works for me!  At least given the CONFIG_PREEMPT_RT check.

							Thanx, Paul
