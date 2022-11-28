Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED80FC4332F
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 07:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiK1H7s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 02:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1H7r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 02:59:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F004C114E
        for <rcu@vger.kernel.org>; Sun, 27 Nov 2022 23:59:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so7955089pjd.5
        for <rcu@vger.kernel.org>; Sun, 27 Nov 2022 23:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5G9F1UCssnDpGEi58xITuBpM/+4mmtzytGkJ7UFy0A=;
        b=PG4ep5fe9gaWd+gz17K6HKwboPxtaKyYS2trVMVJwdaqHu1o8b9jDb9u88QHQtSG4X
         bdjJUJxNC40HhIcM4o/jI/hFiMaSK0OT7Itn78LHk+XjigbuD0jE6cR3lzQ+tXaiSRgU
         PzqAxvkFCJjKcNgzYv0cTSt1/s1cnRKclr/ZCzt7lTls0UxGdwV88at/BA++6xVik5ek
         mrctkt1x9Rdx3lXi/AWTbR4pvY+sJSe7dZNbu4e1sL3fL3Ylihkg056f+tO3puxLEYXo
         beysSaMT+VpUIfRgBgqWzxvJkeEvwxU6rj5ZsiFQrXwtWBeYW8uvDqUC8z0Pvo4xuoRO
         mGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5G9F1UCssnDpGEi58xITuBpM/+4mmtzytGkJ7UFy0A=;
        b=lOn8EsGbZcEdivbos3RsjjdIVxvhSXvmkw42QKw8kScRjhOmjLnBdqQ5mJOYLz6XCf
         0cRyayI2ZZwzy+AP5Tho1ZEXIi/Qeko0BFkqcatgmQeJI28IjO+nw4fPkKv0sLfUkR2U
         IUUXLdcXvFgRWMoWrXtfoqz8nfVHrklmLHf4iIVN93gBTJaFED5ESBYjBqVwmJBJ14zP
         CAhrmNd49MVZh9/+tUsid/R+BWJe/9A+I2QbyEOFcHznQgeOrVxqEA1NzW41HqYPL3vj
         lP6xfbmv6eAT+L7eyPdSg4PohI3yWYe7LV0+CniG4a905GKIGvGl2WGjEYs044V9xfuu
         dBrQ==
X-Gm-Message-State: ANoB5pnI5V/1CmhMBG4cnN8TkYGUfO5mEbuABQrg+RSXdBR9J0sk5K+F
        c+XCdY3XYq+hOCBlHgh6QkxE6/xqKg==
X-Google-Smtp-Source: AA0mqf7IYMVPinKkUvpywcy7/7qReJOrrzosgkcR2yhIyslPeaX2/hCYplpNJu0Dw62rkFwGVRJTwg==
X-Received: by 2002:a17:90a:9bcb:b0:206:f02a:cb4b with SMTP id b11-20020a17090a9bcb00b00206f02acb4bmr53020964pjw.159.1669622385450;
        Sun, 27 Nov 2022 23:59:45 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b00189758e2b99sm4244928ple.92.2022.11.27.23.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 23:59:44 -0800 (PST)
Date:   Mon, 28 Nov 2022 15:59:39 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <Y4Rqa67H2JBSVVXf@piliu.users.ipa.redhat.com>
References: <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
 <CAFgQCTsEOQAuiMkPp1XnBRvSUxxW3ihkBFPhDuA7zpwgSPj+Kg@mail.gmail.com>
 <20221124052417.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <20221124161926.GA3495117@paulmck-ThinkPad-P17-Gen-1>
 <Y4C271JOvsKU+ckG@piliu.users.ipa.redhat.com>
 <20221126180352.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <20221126180704.GA3269129@paulmck-ThinkPad-P17-Gen-1>
 <Y4N7vU3MI7qvMHP5@piliu.users.ipa.redhat.com>
 <20221127180016.GH4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127180016.GH4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 27, 2022 at 10:00:16AM -0800, Paul E. McKenney wrote:
> On Sun, Nov 27, 2022 at 11:01:17PM +0800, Pingfan Liu wrote:
> > On Sat, Nov 26, 2022 at 10:07:04AM -0800, Paul E. McKenney wrote:
> > > On Sat, Nov 26, 2022 at 10:03:52AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Nov 25, 2022 at 08:37:03PM +0800, Pingfan Liu wrote:
> > > > > On Thu, Nov 24, 2022 at 08:19:26AM -0800, Paul E. McKenney wrote:
> > > > > > On Wed, Nov 23, 2022 at 09:24:17PM -0800, Paul E. McKenney wrote:
> > > > > > > On Thu, Nov 24, 2022 at 12:06:39PM +0800, Pingfan Liu wrote:
> > > > > > > > On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> > > > > > > > > On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> > > > > > > > > > On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> > > > > > > > > > > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > > > > > > > > > > the seq snap should be the largest number for the slot
> > > > > > > > > > > srcu_have_cbs[idx].
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > > > > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > > > > > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > > > > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > > > > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > > > > > > To: rcu@vger.kernel.org
> > > > > > > > > > > ---
> > > > > > > > > > >  include/linux/rcupdate.h |  1 +
> > > > > > > > > > >  kernel/rcu/srcutree.c    | 11 ++++++-----
> > > > > > > > > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > > > > > > > index 08605ce7379d..a09007236660 100644
> > > > > > > > > > > --- a/include/linux/rcupdate.h
> > > > > > > > > > > +++ b/include/linux/rcupdate.h
> > > > > > > > > > > @@ -32,6 +32,7 @@
> > > > > > > > > > >  #include <linux/context_tracking_irq.h>
> > > > > > > > > > >
> > > > > > > > > > >  #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >= (a) - (b))
> > > > > > > > > > > +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
> > > > > > > > > >
> > > > > > > > > > Please see below...
> > > > > > > > > >
> > > > > > > > > > >  #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
> > > > > > > > > > >  #define ulong2long(a)              (*(long *)(&(a)))
> > > > > > > > > > >  #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > > > > > > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > > > > > > index 2fc0e775ade4..41902b823687 100644
> > > > > > > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > > > > > > @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > > > > > > > > >             for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> > > > > > > > > > >                     spin_lock_irqsave_rcu_node(snp, flags);
> > > > > > > > > > >                     snp_seq = snp->srcu_have_cbs[idx];
> > > > > > > > > > > -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > > > > > > > > > > +                   /*
> > > > > > > > > > > +                    * s should be the biggest in the current slot. Hence only LE is
> > > > > > > > > > > +                    * valid
> > > > > > > > > > > +                    */
> > > > > > > > > > > +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
> > > > > > > > > >
> > > > > > > > > > Why not this?  (Plus adjusting the comment above, of course.)
> > > > > > > > > >
> > > > > > > > > >                       WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > A neat solution!
> > > > > > > > >
> > > > > > > > > And what about the comment
> > > > > > > > >                         /* s should be the biggest in the current slot. */
> > > > > > > > >
> > > > > > > > > > That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> > > > > > > > > > s being the biggest in the current slot, we get a splat and can debug
> > > > > > > > > > further.  We both might be quite sure that we are not confused, but
> > > > > > > > > > that is exactly when we are most prone to making mistakes.  ;-)
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Same feeling :)
> > > > > > > > >
> > > > > > > > > > I also ask that you run with this check for some time.  After all, if
> > > > > > > > 
> > > > > > > > Forget to ask if  the test
> > > > > > > >   "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > > > > > > > 10h --configs 18*SRCU-P"
> > > > > > > > satisfies your requirement?
> > > > > > > 
> > > > > > > I am thinking more in terms of adding the WARN_ON_ONCE(), letting it be
> > > > > > > in -next and possibly mainline for a couple of years, and then if there
> > > > > > > are no splats, start feeling more confident in the asserted relationship.
> > > > > > > 
> > > > > > > If there was a significant performance, scalability, energy-efficiency, or
> > > > > > > simplification benefit, I would feel justified in being more aggressive.
> > > > > > > 
> > > > > > > But I am not seeing a significant benefit.
> > > > > > 
> > > > > > Ah, and before I forget -again-, have you thought through the counter-wrap
> > > > > > scenarios?  Please keep in mind that on a 32-bit system, those counters
> > > > > > can wrap quite quickly compared to typical uptimes.
> > > > > 
> > > > > I think 32-bit has not significant different since the statement
> > > > >   WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> > > > > 
> > > > > where 's < snp_seq' is not associated with bits. Am I missing anything?
> > > > 
> > > > Your point is that long before there was any danger of wrap, this
> > > > WARN_ON_ONCE() would trigger?
> > > > 
> > > > If so, the point is to avoid that WARN_ON_ONCE() from triggering.
> > 
> > Oops! I failed to figure out the scene you pointed out, where snp_x did
> > not have call_srcu event for a very long time, then comes the wrap, and
> > when s is close enough to snp_x's snp_seq, ULONG_CMP_LT(s, snp_seq) will
> > raise false alarm.
> > 
> > Yes, this is a bug.
> 
> Very good, you did get there.  ;-)
> 
> > > > Or am I missing your point?
> > 
> > Sorry that I missed your point and confused you.
> > 
> > Can I remedy it using the root snp? Because the root snp's snp_seq advances
> > each GP. And it is the biggest one among snp-s.
> 
> Yes, the root srcu_node structure is always there, but it will tend to be
> less warm in the cache, and thus will tend to be more expensive to access.
> 
> So, does keeping the current unconditional store solve the wrap problem?
> 

I think you are talking about the "snp->srcu_have_cbs[idx] = gpseq" in
srcu_gp_end(). Yes, it can serve the purpose. And I can also apply wrap
check on that logic later.

So if I keep that store, is PATCHv3 good enough?

Thanks,

	Pingfan

> > > For example, are you instead saying that the WARN_ON_ONCE() proposed in
> > > your patch will detect the problem either way?  If so, what I am asking
> > > is whether your earlier analysis considered wrap without the addition
> > > of that WARN_ON_ONCE().
> > 
> > Have I answer all of your concerns?
> 
> Quite possibly.
> 
> However, to quote George Bernard Shaw, "The single biggest problem in
> communication is the illusion that it has taken place."
> 
> So I guess we will see!  ;-)
> 
> 							Thanx, Paul
> 
> > Thanks,
> > 
> > 	Pingfan
> > 
> > > 							Thanx, Paul
> > > 
> > > > > Thanks,
> > > > > 
> > > > > 	Pingfan
> > > > > 
> > > > > > 							Thanx, Paul
> > > > > > 
> > > > > > > > Thanks
> > > > > > > > 
> > > > > > > >     Pingfan
> > > > > > > > > Sure. I will try it immediately.
> > > > > > > > >
> > > > > > > > > > the assumption is incorrect, the resulting SRCU hangs off in various
> > > > > > > > > > systems around the world will not be so much fun to debug.
> > > > > > > > > >
> > > > > > > > > > Given that this is slowpath code, it is much better to take an extra
> > > > > > > > > > compare and branch than to introduce even an extremely small risk of
> > > > > > > > > > hanging SRCU.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Agree.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > >
> > > > > > > > >         Pingfan
> > > > > > > > >
> > > > > > > > > >                                                       Thanx, Paul
> > > > > > > > > >
> > > > > > > > > > > +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> > > > > > > > > > >                             if (snp == snp_leaf && snp_seq == s)
> > > > > > > > > > >                                     snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> > > > > > > > > > >                             spin_unlock_irqrestore_rcu_node(snp, flags);
> > > > > > > > > > > -                           if (snp == snp_leaf && snp_seq != s) {
> > > > > > > > > > > -                                   srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > > > > > > > > > > -                                   return;
> > > > > > > > > > > -                           }
> > > > > > > > > > >                             if (!do_norm)
> > > > > > > > > > >                                     srcu_funnel_exp_start(ssp, snp, s);
> > > > > > > > > > >                             return;
> > > > > > > > > > > --
> > > > > > > > > > > 2.31.1
> > > > > > > > > > >
