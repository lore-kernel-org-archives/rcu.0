Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2442EC4332F
	for <rcu@archiver.kernel.org>; Thu, 24 Nov 2022 05:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKXFYW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Nov 2022 00:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXFYV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Nov 2022 00:24:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D36EB4C
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 21:24:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEDC0B826CE
        for <rcu@vger.kernel.org>; Thu, 24 Nov 2022 05:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7D3C433C1;
        Thu, 24 Nov 2022 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669267457;
        bh=9xggfsmvu8UMvXKJ8oRQ3xOSpj7NnwaubNkJGwlFXOQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p9pYbmB8nOKxoOZgtXZwOVTmaWOpGxOYRDxiwRDw7tWBkqnJDOifgwAbGXezkrtL1
         DJdca+vIMxleIc5KiWhjvEsD7qsRKX2csdOhpneUszrHxnS907S9HTLkAKovlZX8rF
         uXUyTJJG6zvp26lR++aMMUwi87BRgyXnQP61jQ2RVxvmVi3Rv8T7xE5JhyNqWShSbp
         ZBzWb2MX2Xfem2Dg0dyxHF2usgDbIzEQQzdO43NmysD63lT4cllPwsH4rJq6872U3V
         zhIjHrqE59LMX8YcC/Frv3A7ct7HHnwtajB1XA0ONTkoWc62xgIHWgUOv9MBJoPRnp
         vf5xOtY9AWA9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3AD115C0DF2; Wed, 23 Nov 2022 21:24:17 -0800 (PST)
Date:   Wed, 23 Nov 2022 21:24:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <20221124052417.GO4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123135638.79021-1-kernelfans@gmail.com>
 <20221123135638.79021-3-kernelfans@gmail.com>
 <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
 <CAFgQCTsEOQAuiMkPp1XnBRvSUxxW3ihkBFPhDuA7zpwgSPj+Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTsEOQAuiMkPp1XnBRvSUxxW3ihkBFPhDuA7zpwgSPj+Kg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 24, 2022 at 12:06:39PM +0800, Pingfan Liu wrote:
> On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> > > On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> > > > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > > > the seq snap should be the largest number for the slot
> > > > srcu_have_cbs[idx].
> > > >
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > To: rcu@vger.kernel.org
> > > > ---
> > > >  include/linux/rcupdate.h |  1 +
> > > >  kernel/rcu/srcutree.c    | 11 ++++++-----
> > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 08605ce7379d..a09007236660 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -32,6 +32,7 @@
> > > >  #include <linux/context_tracking_irq.h>
> > > >
> > > >  #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >= (a) - (b))
> > > > +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
> > >
> > > Please see below...
> > >
> > > >  #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
> > > >  #define ulong2long(a)              (*(long *)(&(a)))
> > > >  #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 2fc0e775ade4..41902b823687 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > >             for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> > > >                     spin_lock_irqsave_rcu_node(snp, flags);
> > > >                     snp_seq = snp->srcu_have_cbs[idx];
> > > > -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > > > +                   /*
> > > > +                    * s should be the biggest in the current slot. Hence only LE is
> > > > +                    * valid
> > > > +                    */
> > > > +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
> > >
> > > Why not this?  (Plus adjusting the comment above, of course.)
> > >
> > >                       WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > >
> >
> > A neat solution!
> >
> > And what about the comment
> >                         /* s should be the biggest in the current slot. */
> >
> > > That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> > > s being the biggest in the current slot, we get a splat and can debug
> > > further.  We both might be quite sure that we are not confused, but
> > > that is exactly when we are most prone to making mistakes.  ;-)
> > >
> >
> > Same feeling :)
> >
> > > I also ask that you run with this check for some time.  After all, if
> 
> Forget to ask if  the test
>   "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> 10h --configs 18*SRCU-P"
> satisfies your requirement?

I am thinking more in terms of adding the WARN_ON_ONCE(), letting it be
in -next and possibly mainline for a couple of years, and then if there
are no splats, start feeling more confident in the asserted relationship.

If there was a significant performance, scalability, energy-efficiency, or
simplification benefit, I would feel justified in being more aggressive.

But I am not seeing a significant benefit.

							Thanx, Paul

> Thanks
> 
>     Pingfan
> > Sure. I will try it immediately.
> >
> > > the assumption is incorrect, the resulting SRCU hangs off in various
> > > systems around the world will not be so much fun to debug.
> > >
> > > Given that this is slowpath code, it is much better to take an extra
> > > compare and branch than to introduce even an extremely small risk of
> > > hanging SRCU.
> > >
> >
> > Agree.
> >
> >
> > Thanks,
> >
> >         Pingfan
> >
> > >                                                       Thanx, Paul
> > >
> > > > +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> > > >                             if (snp == snp_leaf && snp_seq == s)
> > > >                                     snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> > > >                             spin_unlock_irqrestore_rcu_node(snp, flags);
> > > > -                           if (snp == snp_leaf && snp_seq != s) {
> > > > -                                   srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > > > -                                   return;
> > > > -                           }
> > > >                             if (!do_norm)
> > > >                                     srcu_funnel_exp_start(ssp, snp, s);
> > > >                             return;
> > > > --
> > > > 2.31.1
> > > >
