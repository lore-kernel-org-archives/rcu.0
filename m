Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCD4C43217
	for <rcu@archiver.kernel.org>; Tue, 29 Nov 2022 00:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiK2Ahn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 19:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiK2Ahm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 19:37:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED01913DF7
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 16:37:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F914B810AF
        for <rcu@vger.kernel.org>; Tue, 29 Nov 2022 00:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D7EC433D6;
        Tue, 29 Nov 2022 00:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669682257;
        bh=xiQnXaRL7VPtaJDPDflScoPvYjPaDdlFGPl7mwWvyuc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GikQG9RtpcshAO3CYyrQyp13m5wjUH+gjahxbJweX9Io6eU0mKudgP6m/hQhoOps3
         OVaoGkFzUZag8gPnndQcHJqDj+sguLJGwqlA1VUVxqdHkrfjkvSlvw7ONGeiuYXLRi
         Sxs7YdIU2m5MJsFEFvoC0AtGJcewYtYTGJO7yO/3MgtZOUCoxzZv2ArTbwOXQOywzq
         ZSsogKDubvvjqA+ajugHBC/8IA4jg8VgSGvohtR7UWR/jViRSoPul3iblZfTOVQuMr
         XKYTI1GAkhnv0Bf4RpDbEQFjmQT6MZOhpQiFzPRmPZ8nF8XoHv2fmzXObbPOMxYCrH
         819ts0F9OqZnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55C7B5C0EBE; Mon, 28 Nov 2022 16:37:37 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:37:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <20221129003737.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
 <CAFgQCTsEOQAuiMkPp1XnBRvSUxxW3ihkBFPhDuA7zpwgSPj+Kg@mail.gmail.com>
 <20221124052417.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <20221124161926.GA3495117@paulmck-ThinkPad-P17-Gen-1>
 <Y4C271JOvsKU+ckG@piliu.users.ipa.redhat.com>
 <20221126180352.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <20221126180704.GA3269129@paulmck-ThinkPad-P17-Gen-1>
 <Y4N7vU3MI7qvMHP5@piliu.users.ipa.redhat.com>
 <20221127180016.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4Rqa67H2JBSVVXf@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Rqa67H2JBSVVXf@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 28, 2022 at 03:59:39PM +0800, Pingfan Liu wrote:
> On Sun, Nov 27, 2022 at 10:00:16AM -0800, Paul E. McKenney wrote:
> > On Sun, Nov 27, 2022 at 11:01:17PM +0800, Pingfan Liu wrote:
> > > On Sat, Nov 26, 2022 at 10:07:04AM -0800, Paul E. McKenney wrote:
> > > > On Sat, Nov 26, 2022 at 10:03:52AM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Nov 25, 2022 at 08:37:03PM +0800, Pingfan Liu wrote:
> > > > > > On Thu, Nov 24, 2022 at 08:19:26AM -0800, Paul E. McKenney wrote:
> > > > > > > On Wed, Nov 23, 2022 at 09:24:17PM -0800, Paul E. McKenney wrote:
> > > > > > > > On Thu, Nov 24, 2022 at 12:06:39PM +0800, Pingfan Liu wrote:
> > > > > > > > > On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> > > > > > > > > > On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> > > > > > > > > > > On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> > > > > > > > > > > > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > > > > > > > > > > > the seq snap should be the largest number for the slot
> > > > > > > > > > > > srcu_have_cbs[idx].
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > > > > > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > > > > > > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > > > > > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > > > > > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > > > > > > > To: rcu@vger.kernel.org
> > > > > > > > > > > > ---
> > > > > > > > > > > >  include/linux/rcupdate.h |  1 +
> > > > > > > > > > > >  kernel/rcu/srcutree.c    | 11 ++++++-----
> > > > > > > > > > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > > > > > > > > index 08605ce7379d..a09007236660 100644
> > > > > > > > > > > > --- a/include/linux/rcupdate.h
> > > > > > > > > > > > +++ b/include/linux/rcupdate.h
> > > > > > > > > > > > @@ -32,6 +32,7 @@
> > > > > > > > > > > >  #include <linux/context_tracking_irq.h>
> > > > > > > > > > > >
> > > > > > > > > > > >  #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >= (a) - (b))
> > > > > > > > > > > > +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
> > > > > > > > > > >
> > > > > > > > > > > Please see below...
> > > > > > > > > > >
> > > > > > > > > > > >  #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
> > > > > > > > > > > >  #define ulong2long(a)              (*(long *)(&(a)))
> > > > > > > > > > > >  #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > > > > > > > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > > > > > > > index 2fc0e775ade4..41902b823687 100644
> > > > > > > > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > > > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > > > > > > > @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > > > > > > > > > >             for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> > > > > > > > > > > >                     spin_lock_irqsave_rcu_node(snp, flags);
> > > > > > > > > > > >                     snp_seq = snp->srcu_have_cbs[idx];
> > > > > > > > > > > > -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > > > > > > > > > > > +                   /*
> > > > > > > > > > > > +                    * s should be the biggest in the current slot. Hence only LE is
> > > > > > > > > > > > +                    * valid
> > > > > > > > > > > > +                    */
> > > > > > > > > > > > +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
> > > > > > > > > > >
> > > > > > > > > > > Why not this?  (Plus adjusting the comment above, of course.)
> > > > > > > > > > >
> > > > > > > > > > >                       WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > A neat solution!
> > > > > > > > > >
> > > > > > > > > > And what about the comment
> > > > > > > > > >                         /* s should be the biggest in the current slot. */
> > > > > > > > > >
> > > > > > > > > > > That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> > > > > > > > > > > s being the biggest in the current slot, we get a splat and can debug
> > > > > > > > > > > further.  We both might be quite sure that we are not confused, but
> > > > > > > > > > > that is exactly when we are most prone to making mistakes.  ;-)
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Same feeling :)
> > > > > > > > > >
> > > > > > > > > > > I also ask that you run with this check for some time.  After all, if
> > > > > > > > > 
> > > > > > > > > Forget to ask if  the test
> > > > > > > > >   "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > > > > > > > > 10h --configs 18*SRCU-P"
> > > > > > > > > satisfies your requirement?
> > > > > > > > 
> > > > > > > > I am thinking more in terms of adding the WARN_ON_ONCE(), letting it be
> > > > > > > > in -next and possibly mainline for a couple of years, and then if there
> > > > > > > > are no splats, start feeling more confident in the asserted relationship.
> > > > > > > > 
> > > > > > > > If there was a significant performance, scalability, energy-efficiency, or
> > > > > > > > simplification benefit, I would feel justified in being more aggressive.
> > > > > > > > 
> > > > > > > > But I am not seeing a significant benefit.
> > > > > > > 
> > > > > > > Ah, and before I forget -again-, have you thought through the counter-wrap
> > > > > > > scenarios?  Please keep in mind that on a 32-bit system, those counters
> > > > > > > can wrap quite quickly compared to typical uptimes.
> > > > > > 
> > > > > > I think 32-bit has not significant different since the statement
> > > > > >   WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > > > > > 
> > > > > > where 's < snp_seq' is not associated with bits. Am I missing anything?
> > > > > 
> > > > > Your point is that long before there was any danger of wrap, this
> > > > > WARN_ON_ONCE() would trigger?
> > > > > 
> > > > > If so, the point is to avoid that WARN_ON_ONCE() from triggering.
> > > 
> > > Oops! I failed to figure out the scene you pointed out, where snp_x did
> > > not have call_srcu event for a very long time, then comes the wrap, and
> > > when s is close enough to snp_x's snp_seq, ULONG_CMP_LT(s, snp_seq) will
> > > raise false alarm.
> > > 
> > > Yes, this is a bug.
> > 
> > Very good, you did get there.  ;-)
> > 
> > > > > Or am I missing your point?
> > > 
> > > Sorry that I missed your point and confused you.
> > > 
> > > Can I remedy it using the root snp? Because the root snp's snp_seq advances
> > > each GP. And it is the biggest one among snp-s.
> > 
> > Yes, the root srcu_node structure is always there, but it will tend to be
> > less warm in the cache, and thus will tend to be more expensive to access.
> > 
> > So, does keeping the current unconditional store solve the wrap problem?
> > 
> 
> I think you are talking about the "snp->srcu_have_cbs[idx] = gpseq" in
> srcu_gp_end(). Yes, it can serve the purpose. And I can also apply wrap
> check on that logic later.
> 
> So if I keep that store, is PATCHv3 good enough?

It certainly needs an improved commit log.  For example, removing that
call to srcu_schedule_cbs_sdp() can increase apparent SRCU grace-period
latency.  I could easily believe that this is not a problem, but the
commit log at the very least needs to mention this possibility.

I also need to see at least one ack, given that this patch is removing
software-engineering redundancy.

							Thanx, Paul

> Thanks,
> 
> 	Pingfan
> 
> > > > For example, are you instead saying that the WARN_ON_ONCE() proposed in
> > > > your patch will detect the problem either way?  If so, what I am asking
> > > > is whether your earlier analysis considered wrap without the addition
> > > > of that WARN_ON_ONCE().
> > > 
> > > Have I answer all of your concerns?
> > 
> > Quite possibly.
> > 
> > However, to quote George Bernard Shaw, "The single biggest problem in
> > communication is the illusion that it has taken place."
> > 
> > So I guess we will see!  ;-)
> > 
> > 							Thanx, Paul
> > 
> > > Thanks,
> > > 
> > > 	Pingfan
> > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > 	Pingfan
> > > > > > 
> > > > > > > 							Thanx, Paul
> > > > > > > 
> > > > > > > > > Thanks
> > > > > > > > > 
> > > > > > > > >     Pingfan
> > > > > > > > > > Sure. I will try it immediately.
> > > > > > > > > >
> > > > > > > > > > > the assumption is incorrect, the resulting SRCU hangs off in various
> > > > > > > > > > > systems around the world will not be so much fun to debug.
> > > > > > > > > > >
> > > > > > > > > > > Given that this is slowpath code, it is much better to take an extra
> > > > > > > > > > > compare and branch than to introduce even an extremely small risk of
> > > > > > > > > > > hanging SRCU.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Agree.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > >
> > > > > > > > > >         Pingfan
> > > > > > > > > >
> > > > > > > > > > >                                                       Thanx, Paul
> > > > > > > > > > >
> > > > > > > > > > > > +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> > > > > > > > > > > >                             if (snp == snp_leaf && snp_seq == s)
> > > > > > > > > > > >                                     snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> > > > > > > > > > > >                             spin_unlock_irqrestore_rcu_node(snp, flags);
> > > > > > > > > > > > -                           if (snp == snp_leaf && snp_seq != s) {
> > > > > > > > > > > > -                                   srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > > > > > > > > > > > -                                   return;
> > > > > > > > > > > > -                           }
> > > > > > > > > > > >                             if (!do_norm)
> > > > > > > > > > > >                                     srcu_funnel_exp_start(ssp, snp, s);
> > > > > > > > > > > >                             return;
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.31.1
> > > > > > > > > > > >
