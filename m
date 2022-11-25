Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1258EC43217
	for <rcu@archiver.kernel.org>; Fri, 25 Nov 2022 12:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKYMh7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 07:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiKYMhl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 07:37:41 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514C4EC12
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 04:37:09 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id io19so3881036plb.8
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 04:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKuALqz4Rbmiyxkq68X7wRYXUWqaXBMUfJ5PGAOhmiI=;
        b=QlJw3x/fbWdy8fXmFJzFaMYiF/a0X4OyorafgStKR3+Q7mb+gT/ohwG1AQsqxuoJYz
         gr9uXu9/xGn77w+UvNobse6Reu43CuMC4/4PkE0d9HaInrk7tNJFdYECiTn5ZVu/2/2l
         bRpy/+2uMxedzNF0Y+QUT60xP1fJO/krPgXM9mXj+9KGC+mXiyC8HhtHaeTazZGNRrAh
         /R+Ltr4ZzZySJj8ZD5lSctzGYac75kmGEW1UiA9P8RxYcm9wdhtBD2pylQHd9YK8E4KY
         dv7Y7wJFW8iNZ7oKuMx5mBxCOdyLUAlqUg/DVSTihaXUVegYMkOlxtBW1l4ij1/gw98L
         DrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKuALqz4Rbmiyxkq68X7wRYXUWqaXBMUfJ5PGAOhmiI=;
        b=5SLq8f0Ss5iOmh+25zjOeM5efTPrg1MDXyP0KlUkOJal4Znc9kqmdiy6FN40bSLci0
         369pJtd9Ky5zhi4T21HagZ/NU9g5j/f8maZ28kEJ/80TRtVU/VjOgdjW4XNkw42H65e4
         xa16MrBvj/F3D/Wnx54mg3zlzf2IojcO4SdzS9Uc0Z5WcG5GlztxVWPClCAH6wPpi05C
         TZhNZqGI9qAWZYvebcMq5q5xw6OAjGSnOiFsxxuzFeHNH78/0evoZ04xgw3k5bc9XvLS
         IZOl2byGaEXQweinOZ6yxM+qnO5rSRUmgUslBcVSaj9lObm1Dno1BFWgk7V+X273cX5n
         9rmA==
X-Gm-Message-State: ANoB5pkApnBkxtEIr5IjNaMJocBFxZ9v2UggRvFpAPjVk8+w9yDBPyHl
        ItGzfDj/wFZI6TN+a/sPFg==
X-Google-Smtp-Source: AA0mqf6dExMUCVixAN1jQaoibVCWoOFxLXsZVVqS11q4OJI+cAui2p7AKncqCPewFblexyknG2Ewaw==
X-Received: by 2002:a17:90b:30d0:b0:213:f1d8:eb6a with SMTP id hi16-20020a17090b30d000b00213f1d8eb6amr39661815pjb.219.1669379829224;
        Fri, 25 Nov 2022 04:37:09 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b005745a586badsm2964981pfb.218.2022.11.25.04.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:37:08 -0800 (PST)
Date:   Fri, 25 Nov 2022 20:37:03 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <Y4C271JOvsKU+ckG@piliu.users.ipa.redhat.com>
References: <20221123135638.79021-1-kernelfans@gmail.com>
 <20221123135638.79021-3-kernelfans@gmail.com>
 <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
 <CAFgQCTsEOQAuiMkPp1XnBRvSUxxW3ihkBFPhDuA7zpwgSPj+Kg@mail.gmail.com>
 <20221124052417.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <20221124161926.GA3495117@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124161926.GA3495117@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 24, 2022 at 08:19:26AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 23, 2022 at 09:24:17PM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 24, 2022 at 12:06:39PM +0800, Pingfan Liu wrote:
> > > On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> > > >
> > > > On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> > > > > On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> > > > > > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > > > > > the seq snap should be the largest number for the slot
> > > > > > srcu_have_cbs[idx].
> > > > > >
> > > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > To: rcu@vger.kernel.org
> > > > > > ---
> > > > > >  include/linux/rcupdate.h |  1 +
> > > > > >  kernel/rcu/srcutree.c    | 11 ++++++-----
> > > > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > > index 08605ce7379d..a09007236660 100644
> > > > > > --- a/include/linux/rcupdate.h
> > > > > > +++ b/include/linux/rcupdate.h
> > > > > > @@ -32,6 +32,7 @@
> > > > > >  #include <linux/context_tracking_irq.h>
> > > > > >
> > > > > >  #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >= (a) - (b))
> > > > > > +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
> > > > >
> > > > > Please see below...
> > > > >
> > > > > >  #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
> > > > > >  #define ulong2long(a)              (*(long *)(&(a)))
> > > > > >  #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > index 2fc0e775ade4..41902b823687 100644
> > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > > > >             for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> > > > > >                     spin_lock_irqsave_rcu_node(snp, flags);
> > > > > >                     snp_seq = snp->srcu_have_cbs[idx];
> > > > > > -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > > > > > +                   /*
> > > > > > +                    * s should be the biggest in the current slot. Hence only LE is
> > > > > > +                    * valid
> > > > > > +                    */
> > > > > > +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
> > > > >
> > > > > Why not this?  (Plus adjusting the comment above, of course.)
> > > > >
> > > > >                       WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > > > >
> > > >
> > > > A neat solution!
> > > >
> > > > And what about the comment
> > > >                         /* s should be the biggest in the current slot. */
> > > >
> > > > > That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> > > > > s being the biggest in the current slot, we get a splat and can debug
> > > > > further.  We both might be quite sure that we are not confused, but
> > > > > that is exactly when we are most prone to making mistakes.  ;-)
> > > > >
> > > >
> > > > Same feeling :)
> > > >
> > > > > I also ask that you run with this check for some time.  After all, if
> > > 
> > > Forget to ask if  the test
> > >   "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > > 10h --configs 18*SRCU-P"
> > > satisfies your requirement?
> > 
> > I am thinking more in terms of adding the WARN_ON_ONCE(), letting it be
> > in -next and possibly mainline for a couple of years, and then if there
> > are no splats, start feeling more confident in the asserted relationship.
> > 
> > If there was a significant performance, scalability, energy-efficiency, or
> > simplification benefit, I would feel justified in being more aggressive.
> > 
> > But I am not seeing a significant benefit.
> 
> Ah, and before I forget -again-, have you thought through the counter-wrap
> scenarios?  Please keep in mind that on a 32-bit system, those counters
> can wrap quite quickly compared to typical uptimes.
> 

I think 32-bit has not significant different since the statement
  WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));

where 's < snp_seq' is not associated with bits. Am I missing anything?

Thanks,

	Pingfan

> 							Thanx, Paul
> 
> > > Thanks
> > > 
> > >     Pingfan
> > > > Sure. I will try it immediately.
> > > >
> > > > > the assumption is incorrect, the resulting SRCU hangs off in various
> > > > > systems around the world will not be so much fun to debug.
> > > > >
> > > > > Given that this is slowpath code, it is much better to take an extra
> > > > > compare and branch than to introduce even an extremely small risk of
> > > > > hanging SRCU.
> > > > >
> > > >
> > > > Agree.
> > > >
> > > >
> > > > Thanks,
> > > >
> > > >         Pingfan
> > > >
> > > > >                                                       Thanx, Paul
> > > > >
> > > > > > +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> > > > > >                             if (snp == snp_leaf && snp_seq == s)
> > > > > >                                     snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> > > > > >                             spin_unlock_irqrestore_rcu_node(snp, flags);
> > > > > > -                           if (snp == snp_leaf && snp_seq != s) {
> > > > > > -                                   srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > > > > > -                                   return;
> > > > > > -                           }
> > > > > >                             if (!do_norm)
> > > > > >                                     srcu_funnel_exp_start(ssp, snp, s);
> > > > > >                             return;
> > > > > > --
> > > > > > 2.31.1
> > > > > >
