Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63FC4332F
	for <rcu@archiver.kernel.org>; Fri, 25 Nov 2022 12:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKYMcc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 07:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKYMcb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 07:32:31 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC4E21
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 04:32:28 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j12so3877994plj.5
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 04:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VU+7mwsE/KqPdcpw7Bw4be3UW6pmbHS26eLug+t2jV8=;
        b=c1EPMAcdGcr8iKXD1vKIuhcNQRvQZ4q9T10Qx9psPbi7ikOsL9doZuj8FndzCxlWVJ
         EKOPVCnRPB/7Dp47vnLNdUpcsSg7wGHFTwqtCDdcg2fnEAvPaYTiTZfmBHVB5TOh80Q6
         RfqBFhBPvaHlaymnClYQlJNieC8pLvFeUa7cIdJnCkDXo2GnNojJ8QGfsHzaU+FH0AE8
         k0UOGrJLBV401TdogfYDB4CKHRQZsQZ67SVylkbvfD5lEkt4RqPhGx4aPKtn5bHUiyJo
         Ce8fH0XP3mU7j3215C18MN8emIpjwhnxt+j4Zgo/z2IjHyO4L0eSbvHJ8r6t5GXBDxlP
         9cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU+7mwsE/KqPdcpw7Bw4be3UW6pmbHS26eLug+t2jV8=;
        b=p4s/VpC0R1BCkX+Q5IWI6+uVsAFzEHXwf+kcI7aZaASZ4mjcjztV2ChRI0LF2arqBf
         iy3vW8yRbZhd+zN5bbce+ba8HLWFfk00UFqT2gjznh8jIMGDblvSdPsQ2H2+4ziYdZG3
         3mQ7BDRfsavK5L/sUmC7XGHA0fvqCSfjA8GuH6haWy694Z7BRAbz56fuMbyA98NGNjO/
         mntll317r3VQzKTNAZcJsghGhc3h40AvjX7Vjj0c0ZKceMAJHSRqBCbEue634ssoMOeI
         AbJlvarMbxlF7WiFZobwgmr7g531zqi7nrYiWV5HbL4zuyaTki+j/lHawOokEP2NKpGa
         bkAw==
X-Gm-Message-State: ANoB5pnmC05Gjdp4o3ZKvm5SzNbgqqiMiegdVN6YLF2bELCmUi7+Yo4o
        BpJ1oV4Dg14AcJFh7qtaGQ==
X-Google-Smtp-Source: AA0mqf5OZt/7wnMH/aogQF5gMLbpwg4vLR/koyJHvALyEGrkHuBNgN4YosDIEsgNJGQqkLden6FScw==
X-Received: by 2002:a17:90b:3d03:b0:213:1e05:f991 with SMTP id pt3-20020a17090b3d0300b002131e05f991mr47164853pjb.216.1669379547633;
        Fri, 25 Nov 2022 04:32:27 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b001891a17bd93sm3317972plh.43.2022.11.25.04.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:32:26 -0800 (PST)
Date:   Fri, 25 Nov 2022 20:32:22 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <Y4C11t3wKyPzB8Rq@piliu.users.ipa.redhat.com>
References: <20221123135638.79021-1-kernelfans@gmail.com>
 <20221123135638.79021-3-kernelfans@gmail.com>
 <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
 <CAFgQCTsEOQAuiMkPp1XnBRvSUxxW3ihkBFPhDuA7zpwgSPj+Kg@mail.gmail.com>
 <20221124052417.GO4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124052417.GO4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 23, 2022 at 09:24:17PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 24, 2022 at 12:06:39PM +0800, Pingfan Liu wrote:
> > On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> > > > On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> > > > > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > > > > the seq snap should be the largest number for the slot
> > > > > srcu_have_cbs[idx].
> > > > >
> > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > To: rcu@vger.kernel.org
> > > > > ---
> > > > >  include/linux/rcupdate.h |  1 +
> > > > >  kernel/rcu/srcutree.c    | 11 ++++++-----
> > > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > index 08605ce7379d..a09007236660 100644
> > > > > --- a/include/linux/rcupdate.h
> > > > > +++ b/include/linux/rcupdate.h
> > > > > @@ -32,6 +32,7 @@
> > > > >  #include <linux/context_tracking_irq.h>
> > > > >
> > > > >  #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >= (a) - (b))
> > > > > +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
> > > >
> > > > Please see below...
> > > >
> > > > >  #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
> > > > >  #define ulong2long(a)              (*(long *)(&(a)))
> > > > >  #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index 2fc0e775ade4..41902b823687 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > > >             for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> > > > >                     spin_lock_irqsave_rcu_node(snp, flags);
> > > > >                     snp_seq = snp->srcu_have_cbs[idx];
> > > > > -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > > > > +                   /*
> > > > > +                    * s should be the biggest in the current slot. Hence only LE is
> > > > > +                    * valid
> > > > > +                    */
> > > > > +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
> > > >
> > > > Why not this?  (Plus adjusting the comment above, of course.)
> > > >
> > > >                       WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > > >
> > >
> > > A neat solution!
> > >
> > > And what about the comment
> > >                         /* s should be the biggest in the current slot. */
> > >
> > > > That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> > > > s being the biggest in the current slot, we get a splat and can debug
> > > > further.  We both might be quite sure that we are not confused, but
> > > > that is exactly when we are most prone to making mistakes.  ;-)
> > > >
> > >
> > > Same feeling :)
> > >
> > > > I also ask that you run with this check for some time.  After all, if
> > 
> > Forget to ask if  the test
> >   "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > 10h --configs 18*SRCU-P"
> > satisfies your requirement?
> 
> I am thinking more in terms of adding the WARN_ON_ONCE(), letting it be
> in -next and possibly mainline for a couple of years, and then if there
> are no splats, start feeling more confident in the asserted relationship.
> 

Sounds reasonable.

> If there was a significant performance, scalability, energy-efficiency, or
> simplification benefit, I would feel justified in being more aggressive.
> 
> But I am not seeing a significant benefit.
> 

No, not a significant benefit.

I will send out V3 for this patch


Thanks,

	Pingfan

> 							Thanx, Paul
> 
> > Thanks
> > 
> >     Pingfan
> > > Sure. I will try it immediately.
> > >
> > > > the assumption is incorrect, the resulting SRCU hangs off in various
> > > > systems around the world will not be so much fun to debug.
> > > >
> > > > Given that this is slowpath code, it is much better to take an extra
> > > > compare and branch than to introduce even an extremely small risk of
> > > > hanging SRCU.
> > > >
> > >
> > > Agree.
> > >
> > >
> > > Thanks,
> > >
> > >         Pingfan
> > >
> > > >                                                       Thanx, Paul
> > > >
> > > > > +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> > > > >                             if (snp == snp_leaf && snp_seq == s)
> > > > >                                     snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> > > > >                             spin_unlock_irqrestore_rcu_node(snp, flags);
> > > > > -                           if (snp == snp_leaf && snp_seq != s) {
> > > > > -                                   srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > > > > -                                   return;
> > > > > -                           }
> > > > >                             if (!do_norm)
> > > > >                                     srcu_funnel_exp_start(ssp, snp, s);
> > > > >                             return;
> > > > > --
> > > > > 2.31.1
> > > > >
