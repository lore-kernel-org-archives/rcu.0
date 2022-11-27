Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41FFC43217
	for <rcu@archiver.kernel.org>; Sun, 27 Nov 2022 17:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiK0Rz0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Nov 2022 12:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0RzZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Nov 2022 12:55:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF3A2DDE
        for <rcu@vger.kernel.org>; Sun, 27 Nov 2022 09:55:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 451E2B80B18
        for <rcu@vger.kernel.org>; Sun, 27 Nov 2022 17:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22E2C433D6;
        Sun, 27 Nov 2022 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669571721;
        bh=1JNKcBsGsIRu075JENtctrDd/eQQ/b7lB6hD4csgpfY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iZuvggi+b0qEtYdVbwCfJGUe/8XTfMP5WQaDp/tTA4XEi9Wps3Elbc6lhpK7Y7jyK
         ejkGD8WJDVwA9cC2EK/F0Dlm3njxF2rRX5mXFOCMeobxKEsL5DynsuDiAP6Uq4i3If
         GDHtIfu8LlsROhic8Eq94JTY0ETQUPJcSFiGIJcc6jf4X/PRMtE6DicvBU+EFIIh/A
         8nrJM99Y7a+IleV+GenCZVRv0K37eIhJm51UhfBrprMe8JQcBTVaRzrhBRxg0AOVU+
         J2pBiOWlDrzQ8L2u4V9U2BM4iEybk+x7gmnCW5YseCvNW4N6CRU+6iwmClgBXD8nZs
         jRZRzMeQgCWkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 78E305C09B0; Sun, 27 Nov 2022 09:55:21 -0800 (PST)
Date:   Sun, 27 Nov 2022 09:55:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <20221127175521.GG4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221126180704.GA3269129@paulmck-ThinkPad-P17-Gen-1>
 <C6E05D66-7426-4654-8551-296EE01646C2@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C6E05D66-7426-4654-8551-296EE01646C2@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 27, 2022 at 09:46:51AM -0500, Joel Fernandes wrote:
> > On Nov 26, 2022, at 1:07 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > ﻿On Sat, Nov 26, 2022 at 10:03:52AM -0800, Paul E. McKenney wrote:
> >>> On Fri, Nov 25, 2022 at 08:37:03PM +0800, Pingfan Liu wrote:
> >>> On Thu, Nov 24, 2022 at 08:19:26AM -0800, Paul E. McKenney wrote:
> >>>> On Wed, Nov 23, 2022 at 09:24:17PM -0800, Paul E. McKenney wrote:
> >>>>> On Thu, Nov 24, 2022 at 12:06:39PM +0800, Pingfan Liu wrote:
> >>>>>> On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >>>>>>> On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> >>>>>>>> On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> >>>>>>>>> Since the srcu read lock is still held during srcu_funnel_gp_start(),
> >>>>>>>>> the seq snap should be the largest number for the slot
> >>>>>>>>> srcu_have_cbs[idx].
> >>>>>>>>> 
> >>>>>>>>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >>>>>>>>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> >>>>>>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >>>>>>>>> Cc: Frederic Weisbecker <frederic@kernel.org>
> >>>>>>>>> Cc: Josh Triplett <josh@joshtriplett.org>
> >>>>>>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
> >>>>>>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>>>>>>>> To: rcu@vger.kernel.org
> >>>>>>>>> ---
> >>>>>>>>> include/linux/rcupdate.h |  1 +
> >>>>>>>>> kernel/rcu/srcutree.c    | 11 ++++++-----
> >>>>>>>>> 2 files changed, 7 insertions(+), 5 deletions(-)
> >>>>>>>>> 
> >>>>>>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> >>>>>>>>> index 08605ce7379d..a09007236660 100644
> >>>>>>>>> --- a/include/linux/rcupdate.h
> >>>>>>>>> +++ b/include/linux/rcupdate.h
> >>>>>>>>> @@ -32,6 +32,7 @@
> >>>>>>>>> #include <linux/context_tracking_irq.h>
> >>>>>>>>> 
> >>>>>>>>> #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >= (a) - (b))
> >>>>>>>>> +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
> >>>>>>>> 
> >>>>>>>> Please see below...
> >>>>>>>> 
> >>>>>>>>> #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
> >>>>>>>>> #define ulong2long(a)              (*(long *)(&(a)))
> >>>>>>>>> #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> >>>>>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >>>>>>>>> index 2fc0e775ade4..41902b823687 100644
> >>>>>>>>> --- a/kernel/rcu/srcutree.c
> >>>>>>>>> +++ b/kernel/rcu/srcutree.c
> >>>>>>>>> @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >>>>>>>>>            for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> >>>>>>>>>                    spin_lock_irqsave_rcu_node(snp, flags);
> >>>>>>>>>                    snp_seq = snp->srcu_have_cbs[idx];
> >>>>>>>>> -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> >>>>>>>>> +                   /*
> >>>>>>>>> +                    * s should be the biggest in the current slot. Hence only LE is
> >>>>>>>>> +                    * valid
> >>>>>>>>> +                    */
> >>>>>>>>> +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
> >>>>>>>> 
> >>>>>>>> Why not this?  (Plus adjusting the comment above, of course.)
> >>>>>>>> 
> >>>>>>>>                      WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> >>>>>>>> 
> >>>>>>> 
> >>>>>>> A neat solution!
> >>>>>>> 
> >>>>>>> And what about the comment
> >>>>>>>                        /* s should be the biggest in the current slot. */
> >>>>>>> 
> >>>>>>>> That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> >>>>>>>> s being the biggest in the current slot, we get a splat and can debug
> >>>>>>>> further.  We both might be quite sure that we are not confused, but
> >>>>>>>> that is exactly when we are most prone to making mistakes.  ;-)
> >>>>>>>> 
> >>>>>>> 
> >>>>>>> Same feeling :)
> >>>>>>> 
> >>>>>>>> I also ask that you run with this check for some time.  After all, if
> >>>>>> 
> >>>>>> Forget to ask if  the test
> >>>>>>  "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> >>>>>> 10h --configs 18*SRCU-P"
> >>>>>> satisfies your requirement?
> >>>>> 
> >>>>> I am thinking more in terms of adding the WARN_ON_ONCE(), letting it be
> >>>>> in -next and possibly mainline for a couple of years, and then if there
> >>>>> are no splats, start feeling more confident in the asserted relationship.
> >>>>> 
> >>>>> If there was a significant performance, scalability, energy-efficiency, or
> >>>>> simplification benefit, I would feel justified in being more aggressive.
> >>>>> 
> >>>>> But I am not seeing a significant benefit.
> >>>> 
> >>>> Ah, and before I forget -again-, have you thought through the counter-wrap
> >>>> scenarios?  Please keep in mind that on a 32-bit system, those counters
> >>>> can wrap quite quickly compared to typical uptimes.
> >>> 
> >>> I think 32-bit has not significant different since the statement
> >>>  WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> >>> 
> >>> where 's < snp_seq' is not associated with bits. Am I missing anything?
> >> 
> >> Your point is that long before there was any danger of wrap, this
> >> WARN_ON_ONCE() would trigger?
> >> 
> >> If so, the point is to avoid that WARN_ON_ONCE() from triggering.
> >> 
> >> Or am I missing your point?
> > 
> > For example, are you instead saying that the WARN_ON_ONCE() proposed in
> > your patch will detect the problem either way?  If so, what I am asking
> > is whether your earlier analysis considered wrap without the addition
> > of that WARN_ON_ONCE().
> 
> Do we want to make some rules on when to delete WARNs and fold in the
> change, such as a future date after scanning the list for reports? Such
> date can be embedded in a comment on top of the warning.

Possibly, but this question is about adding a warning.  If wrap was
not considered, let's consider wrap and see if removing the store is
appropriate.  Only if removing the store is appropriate does it make
sense to add the warning.

							Thanx, Paul

> Thanks,
> 
>     - Joel
> 
> >                            Thanx, Paul
> > 
> >>> Thanks,
> >>> 
> >>>    Pingfan
> >>> 
> >>>>                            Thanx, Paul
> >>>> 
> >>>>>> Thanks
> >>>>>> 
> >>>>>>    Pingfan
> >>>>>>> Sure. I will try it immediately.
> >>>>>>> 
> >>>>>>>> the assumption is incorrect, the resulting SRCU hangs off in various
> >>>>>>>> systems around the world will not be so much fun to debug.
> >>>>>>>> 
> >>>>>>>> Given that this is slowpath code, it is much better to take an extra
> >>>>>>>> compare and branch than to introduce even an extremely small risk of
> >>>>>>>> hanging SRCU.
> >>>>>>>> 
> >>>>>>> 
> >>>>>>> Agree.
> >>>>>>> 
> >>>>>>> 
> >>>>>>> Thanks,
> >>>>>>> 
> >>>>>>>        Pingfan
> >>>>>>> 
> >>>>>>>>                                                      Thanx, Paul
> >>>>>>>> 
> >>>>>>>>> +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> >>>>>>>>>                            if (snp == snp_leaf && snp_seq == s)
> >>>>>>>>>                                    snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> >>>>>>>>>                            spin_unlock_irqrestore_rcu_node(snp, flags);
> >>>>>>>>> -                           if (snp == snp_leaf && snp_seq != s) {
> >>>>>>>>> -                                   srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> >>>>>>>>> -                                   return;
> >>>>>>>>> -                           }
> >>>>>>>>>                            if (!do_norm)
> >>>>>>>>>                                    srcu_funnel_exp_start(ssp, snp, s);
> >>>>>>>>>                            return;
> >>>>>>>>> --
> >>>>>>>>> 2.31.1
> >>>>>>>>> 
