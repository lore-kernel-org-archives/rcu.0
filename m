Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DE9C43217
	for <rcu@archiver.kernel.org>; Sun, 27 Nov 2022 15:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK0PB0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Nov 2022 10:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0PBZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Nov 2022 10:01:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B0F5BD
        for <rcu@vger.kernel.org>; Sun, 27 Nov 2022 07:01:24 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w129so8220722pfb.5
        for <rcu@vger.kernel.org>; Sun, 27 Nov 2022 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LoVwI8EZP4bWHP6GzkMGMJewCJv5QLXzPPd1mGXyA8E=;
        b=ZWQG7HPQwCQmzxw0699/Ed6qUF/N1T0wPxyEFP7UXcVbcNvCiP/xIdimPILwYc5SHg
         7QRIC3vNYc4y9G0pBbH3xr+lGboTg5GOJKsxavjgldeXhDKO3e61R01p2zHy/Hq/oRRw
         Y5q4zkPv+0dmi1Umi78XgV4X0qyH52CDI+cRHDJ0u0sSwRtH1omRdwN6WwSH238Lm2be
         LODAIdd9nTm8opgg8tof7OZcTI9V/D7Z1aJPLXUjA8a+Yoty9pMuwWpKtxaHR9HB2biy
         Ndou3ca6D2zKWgBP+mfREIxbbBrhPtYKfHItXaRuaaaX1CBNfTXYBrqLiVl18x85Kkak
         hXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoVwI8EZP4bWHP6GzkMGMJewCJv5QLXzPPd1mGXyA8E=;
        b=WNyhlYb36GPzyTvin5L/cP/VXPkKpsNJLE+MJEleys4vgDHIkbi4InyMIRohBNbQa7
         DOheoj38NkJ7/vzeK9Zv2TOc1Atz3b3rbmx3SatuEXeOKSr31dsm5ZrUsujHpfVtf6H+
         +kRiljKlnewjgDYTDAEpwgH1MUFB6QImgIWgU3TXD9O5Vxi7JK5iVrzkNbunvxA2kuBB
         9r/WniOfsp+ZZCwcrM2ScEGA6mjHbCI+ggK4297stUun0SlVBm8ucd7ZZFt4ZXb7bGJO
         uDTyObWf0U1PtfZU3Ha36jEXleD622IrwXIMyV4/gkFVrKPV5Ipq6K3XRhttKC3NS+CH
         hF0Q==
X-Gm-Message-State: ANoB5pnU/ryIsgkmUMcYv/j0GSF7gHs/15f3/ZxkDNlICixw8Kd4vCfj
        c+my6Uoo4rvrPZFEtyPMfBnQMh9DGg==
X-Google-Smtp-Source: AA0mqf5oOf3L+svIo86mQFFi4noIYnDRpMm3u2jaLq7YiHXf+u9B4FZU3JhOZ7sEmlS3Oq+2kTEmyQ==
X-Received: by 2002:a05:6a00:439a:b0:56b:c95f:34dd with SMTP id bt26-20020a056a00439a00b0056bc95f34ddmr27457895pfb.74.1669561283847;
        Sun, 27 Nov 2022 07:01:23 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b0018157b415dbsm6984934plh.63.2022.11.27.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 07:01:23 -0800 (PST)
Date:   Sun, 27 Nov 2022 23:01:17 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <Y4N7vU3MI7qvMHP5@piliu.users.ipa.redhat.com>
References: <20221123135638.79021-1-kernelfans@gmail.com>
 <20221123135638.79021-3-kernelfans@gmail.com>
 <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
 <CAFgQCTsEOQAuiMkPp1XnBRvSUxxW3ihkBFPhDuA7zpwgSPj+Kg@mail.gmail.com>
 <20221124052417.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <20221124161926.GA3495117@paulmck-ThinkPad-P17-Gen-1>
 <Y4C271JOvsKU+ckG@piliu.users.ipa.redhat.com>
 <20221126180352.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <20221126180704.GA3269129@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126180704.GA3269129@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Nov 26, 2022 at 10:07:04AM -0800, Paul E. McKenney wrote:
> On Sat, Nov 26, 2022 at 10:03:52AM -0800, Paul E. McKenney wrote:
> > On Fri, Nov 25, 2022 at 08:37:03PM +0800, Pingfan Liu wrote:
> > > On Thu, Nov 24, 2022 at 08:19:26AM -0800, Paul E. McKenney wrote:
> > > > On Wed, Nov 23, 2022 at 09:24:17PM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Nov 24, 2022 at 12:06:39PM +0800, Pingfan Liu wrote:
> > > > > > On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> > > > > > > On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> > > > > > > > On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> > > > > > > > > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > > > > > > > > the seq snap should be the largest number for the slot
> > > > > > > > > srcu_have_cbs[idx].
> > > > > > > > >
> > > > > > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > > > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > > > > To: rcu@vger.kernel.org
> > > > > > > > > ---
> > > > > > > > >  include/linux/rcupdate.h |  1 +
> > > > > > > > >  kernel/rcu/srcutree.c    | 11 ++++++-----
> > > > > > > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > > > > > index 08605ce7379d..a09007236660 100644
> > > > > > > > > --- a/include/linux/rcupdate.h
> > > > > > > > > +++ b/include/linux/rcupdate.h
> > > > > > > > > @@ -32,6 +32,7 @@
> > > > > > > > >  #include <linux/context_tracking_irq.h>
> > > > > > > > >
> > > > > > > > >  #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >= (a) - (b))
> > > > > > > > > +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
> > > > > > > >
> > > > > > > > Please see below...
> > > > > > > >
> > > > > > > > >  #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
> > > > > > > > >  #define ulong2long(a)              (*(long *)(&(a)))
> > > > > > > > >  #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > > > > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > > > > index 2fc0e775ade4..41902b823687 100644
> > > > > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > > > > @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > > > > > > >             for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> > > > > > > > >                     spin_lock_irqsave_rcu_node(snp, flags);
> > > > > > > > >                     snp_seq = snp->srcu_have_cbs[idx];
> > > > > > > > > -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > > > > > > > > +                   /*
> > > > > > > > > +                    * s should be the biggest in the current slot. Hence only LE is
> > > > > > > > > +                    * valid
> > > > > > > > > +                    */
> > > > > > > > > +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
> > > > > > > >
> > > > > > > > Why not this?  (Plus adjusting the comment above, of course.)
> > > > > > > >
> > > > > > > >                       WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > > > > > > >
> > > > > > >
> > > > > > > A neat solution!
> > > > > > >
> > > > > > > And what about the comment
> > > > > > >                         /* s should be the biggest in the current slot. */
> > > > > > >
> > > > > > > > That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> > > > > > > > s being the biggest in the current slot, we get a splat and can debug
> > > > > > > > further.  We both might be quite sure that we are not confused, but
> > > > > > > > that is exactly when we are most prone to making mistakes.  ;-)
> > > > > > > >
> > > > > > >
> > > > > > > Same feeling :)
> > > > > > >
> > > > > > > > I also ask that you run with this check for some time.  After all, if
> > > > > > 
> > > > > > Forget to ask if  the test
> > > > > >   "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > > > > > 10h --configs 18*SRCU-P"
> > > > > > satisfies your requirement?
> > > > > 
> > > > > I am thinking more in terms of adding the WARN_ON_ONCE(), letting it be
> > > > > in -next and possibly mainline for a couple of years, and then if there
> > > > > are no splats, start feeling more confident in the asserted relationship.
> > > > > 
> > > > > If there was a significant performance, scalability, energy-efficiency, or
> > > > > simplification benefit, I would feel justified in being more aggressive.
> > > > > 
> > > > > But I am not seeing a significant benefit.
> > > > 
> > > > Ah, and before I forget -again-, have you thought through the counter-wrap
> > > > scenarios?  Please keep in mind that on a 32-bit system, those counters
> > > > can wrap quite quickly compared to typical uptimes.
> > > 
> > > I think 32-bit has not significant different since the statement
> > >   WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > > 
> > > where 's < snp_seq' is not associated with bits. Am I missing anything?
> > 
> > Your point is that long before there was any danger of wrap, this
> > WARN_ON_ONCE() would trigger?
> > 
> > If so, the point is to avoid that WARN_ON_ONCE() from triggering.
> > 

Oops! I failed to figure out the scene you pointed out, where snp_x did
not have call_srcu event for a very long time, then comes the wrap, and
when s is close enough to snp_x's snp_seq, ULONG_CMP_LT(s, snp_seq) will
raise false alarm.

Yes, this is a bug.

> > Or am I missing your point?

Sorry that I missed your point and confused you.

Can I remedy it using the root snp? Because the root snp's snp_seq advances
each GP. And it is the biggest one among snp-s.

> 
> For example, are you instead saying that the WARN_ON_ONCE() proposed in
> your patch will detect the problem either way?  If so, what I am asking
> is whether your earlier analysis considered wrap without the addition
> of that WARN_ON_ONCE().
> 

Have I answer all of your concerns?


Thanks,

	Pingfan

> 							Thanx, Paul
> 
> > > Thanks,
> > > 
> > > 	Pingfan
> > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > > Thanks
> > > > > > 
> > > > > >     Pingfan
> > > > > > > Sure. I will try it immediately.
> > > > > > >
> > > > > > > > the assumption is incorrect, the resulting SRCU hangs off in various
> > > > > > > > systems around the world will not be so much fun to debug.
> > > > > > > >
> > > > > > > > Given that this is slowpath code, it is much better to take an extra
> > > > > > > > compare and branch than to introduce even an extremely small risk of
> > > > > > > > hanging SRCU.
> > > > > > > >
> > > > > > >
> > > > > > > Agree.
> > > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > >         Pingfan
> > > > > > >
> > > > > > > >                                                       Thanx, Paul
> > > > > > > >
> > > > > > > > > +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> > > > > > > > >                             if (snp == snp_leaf && snp_seq == s)
> > > > > > > > >                                     snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> > > > > > > > >                             spin_unlock_irqrestore_rcu_node(snp, flags);
> > > > > > > > > -                           if (snp == snp_leaf && snp_seq != s) {
> > > > > > > > > -                                   srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > > > > > > > > -                                   return;
> > > > > > > > > -                           }
> > > > > > > > >                             if (!do_norm)
> > > > > > > > >                                     srcu_funnel_exp_start(ssp, snp, s);
> > > > > > > > >                             return;
> > > > > > > > > --
> > > > > > > > > 2.31.1
> > > > > > > > >
