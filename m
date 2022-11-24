Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA04C4332F
	for <rcu@archiver.kernel.org>; Thu, 24 Nov 2022 04:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKXEGz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 23:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKXEGy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 23:06:54 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FD2C769C
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 20:06:53 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r12so776303lfp.1
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 20:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0rz2MajdF0Iev+7W0sD18Y9MeiDwccUDPwkBJX/JwlY=;
        b=ILGJ+pG3BTdkopGLCzITehUXJtSC575ZGrP6+CoXHA5IIsnWLUH91vx8YEjbWCl7Lz
         rgls4UOKRREjenaksGvIpHJfAoWqcu4LOVdxCVHvgQAE7FHKmokZgmpndplLHIgZCnJy
         fGv6D7FGxRPrdcRhY7uT8ESacJxbyWB3qdVbqVne2AlgkcnUUVmlJ92SJXilC7nyoN5J
         h8CLAcXxIZJwlzrksMiQF+I2/ZOUX96+X5HZI71YKfk3CY7dddC9retvKDptI3W/Kjqu
         +SPZvHTnFpcGXgVu6nHenaf7QNhysXaVyyj7OqtIYpuoM+rOQRbW7/nLs22Oeclt4R63
         hZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rz2MajdF0Iev+7W0sD18Y9MeiDwccUDPwkBJX/JwlY=;
        b=CSdYIaP+UJewUSwWNgyuoU420QxJ1PAj7ISmbiXTuEroXdixvDQmvKZNtXahTr8dh4
         smxpbEQS2bZc5/DEaZnrYalANxMUcUd2+zrres3RG9awxRwBEYlHI3cTzzjykemR/X1I
         v98m0j4nHcYSfUi+7jNUV2JIVKD/SzO69fW8nOZ1YKKYCyhYD2BTp4UzaakwzVetUOkt
         tuox1PTNsHbcG0sNGrsi0YWe1vGiE3gBkvBJsqHu3NIlu69gw95EjttD+skgbf1y+z1S
         mhjjvoO3h8SY8dwGoz7u2toV1hHrZ9iDSdMbWG+d12TRUfk4vJvH+CtZtmDF2kfdo3Wd
         nvmg==
X-Gm-Message-State: ANoB5pmjw4zAzTF5oW6JICsU6MQxt3UqtetalAMv1HcjL6Gqx45260ou
        w12frFIyOMt70bnJZcAmPC6LxdjvXr3q6VuAH9KDqEZu52Go
X-Google-Smtp-Source: AA0mqf6mVpldStCX/GRvCBobWSlaETj47p5WWR7EKyot0nP4YRKaZynBnLeb38fG1C+9h0AyC+ihhAorCpopE5YFHw8=
X-Received: by 2002:ac2:41d9:0:b0:4b1:4d9f:2204 with SMTP id
 d25-20020ac241d9000000b004b14d9f2204mr9803965lfi.22.1669262811659; Wed, 23
 Nov 2022 20:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20221123135638.79021-1-kernelfans@gmail.com> <20221123135638.79021-3-kernelfans@gmail.com>
 <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1> <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
In-Reply-To: <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 24 Nov 2022 12:06:39 +0800
Message-ID: <CAFgQCTsEOQAuiMkPp1XnBRvSUxxW3ihkBFPhDuA7zpwgSPj+Kg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> > > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > > the seq snap should be the largest number for the slot
> > > srcu_have_cbs[idx].
> > >
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > To: rcu@vger.kernel.org
> > > ---
> > >  include/linux/rcupdate.h |  1 +
> > >  kernel/rcu/srcutree.c    | 11 ++++++-----
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 08605ce7379d..a09007236660 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -32,6 +32,7 @@
> > >  #include <linux/context_tracking_irq.h>
> > >
> > >  #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >= (a) - (b))
> > > +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
> >
> > Please see below...
> >
> > >  #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
> > >  #define ulong2long(a)              (*(long *)(&(a)))
> > >  #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 2fc0e775ade4..41902b823687 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > >             for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> > >                     spin_lock_irqsave_rcu_node(snp, flags);
> > >                     snp_seq = snp->srcu_have_cbs[idx];
> > > -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > > +                   /*
> > > +                    * s should be the biggest in the current slot. Hence only LE is
> > > +                    * valid
> > > +                    */
> > > +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
> >
> > Why not this?  (Plus adjusting the comment above, of course.)
> >
> >                       WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> >
>
> A neat solution!
>
> And what about the comment
>                         /* s should be the biggest in the current slot. */
>
> > That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> > s being the biggest in the current slot, we get a splat and can debug
> > further.  We both might be quite sure that we are not confused, but
> > that is exactly when we are most prone to making mistakes.  ;-)
> >
>
> Same feeling :)
>
> > I also ask that you run with this check for some time.  After all, if
>

Forget to ask if  the test
  "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
10h --configs 18*SRCU-P"
satisfies your requirement?

Thanks

    Pingfan
> Sure. I will try it immediately.
>
> > the assumption is incorrect, the resulting SRCU hangs off in various
> > systems around the world will not be so much fun to debug.
> >
> > Given that this is slowpath code, it is much better to take an extra
> > compare and branch than to introduce even an extremely small risk of
> > hanging SRCU.
> >
>
> Agree.
>
>
> Thanks,
>
>         Pingfan
>
> >                                                       Thanx, Paul
> >
> > > +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> > >                             if (snp == snp_leaf && snp_seq == s)
> > >                                     snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> > >                             spin_unlock_irqrestore_rcu_node(snp, flags);
> > > -                           if (snp == snp_leaf && snp_seq != s) {
> > > -                                   srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > > -                                   return;
> > > -                           }
> > >                             if (!do_norm)
> > >                                     srcu_funnel_exp_start(ssp, snp, s);
> > >                             return;
> > > --
> > > 2.31.1
> > >
