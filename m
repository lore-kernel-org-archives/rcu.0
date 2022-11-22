Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBAC4332F
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 01:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiKVBUb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiKVBU3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Nov 2022 20:20:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2748DE0DD0
        for <rcu@vger.kernel.org>; Mon, 21 Nov 2022 17:20:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABC52B818C0
        for <rcu@vger.kernel.org>; Tue, 22 Nov 2022 01:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68793C43151;
        Tue, 22 Nov 2022 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669080025;
        bh=3obSpWa0avT/sW4nqZ0YjIqD/dEE22vvKpDbjUqrsSU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X97H2GdeTqAYeOR03RQOCHdgnSTCljLb6N1EoVnQ+cff1FQA0Xt1KZgNtRasvTXSC
         /Um9KTetMwy24EscYP8f7IhtlpMtYoteLqGl4og9uMwLoTgvBYcCOIOWtp8Y8nfVCX
         wPAp/C1G+QpreKjvl7yy3BdnXckXtIpo/JyHnTP21et97Ak/Cpcn5isdRP/Q6w3rIg
         fi9GjeOZTjdWQRcdcpDrh90G5pxobX10sWgHlB1Xti0f5WAQq0Zj7Ozm6BefNsc9fX
         Z7vuSqLy0+Re+tZim3K15OwqyOzB6D8Bt7+SbkkA0Aqa24Ec8gMmpEwxmYGjGHeC4d
         Ljq2hIKhICRQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E30D85C0641; Mon, 21 Nov 2022 17:20:24 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:20:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] srcu: Eliminate the case that snp_seq bigger than snap
 in srcu_funnel_gp_start()
Message-ID: <20221122012024.GU4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120152040.7460-1-kernelfans@gmail.com>
 <CAFgQCTtPgke6PnG1H4wTXiqh3=73cnVoXxmxbuW72BM5VxdevQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTtPgke6PnG1H4wTXiqh3=73cnVoXxmxbuW72BM5VxdevQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 20, 2022 at 11:23:46PM +0800, Pingfan Liu wrote:
> Sorry for the fragment, but I am just aware of this and think it is
> better to fold into the same series.

Very well, I look forward to seeing the new version of this series.

						Thanx, Paul

> Thanks,
> 
>     Pingfan
> 
> On Sun, Nov 20, 2022 at 11:20 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > the seq snap should be the largest number for the slot
> > srcu_have_cbs[idx].
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: rcu@vger.kernel.org
> > ---
> >  include/linux/rcupdate.h |  1 +
> >  kernel/rcu/srcutree.c    | 10 +++++-----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 08605ce7379d..a09007236660 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -32,6 +32,7 @@
> >  #include <linux/context_tracking_irq.h>
> >
> >  #define ULONG_CMP_GE(a, b)     (ULONG_MAX / 2 >= (a) - (b))
> > +#define ULONG_CMP_GT(a, b)     (ULONG_MAX / 2 > (a) - (b))
> >  #define ULONG_CMP_LT(a, b)     (ULONG_MAX / 2 < (a) - (b))
> >  #define ulong2long(a)          (*(long *)(&(a)))
> >  #define USHORT_CMP_GE(a, b)    (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index c54d6c04751f..057752db1125 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -900,14 +900,14 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >                 for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> >                         spin_lock_irqsave_rcu_node(snp, flags);
> >                         snp_seq = snp->srcu_have_cbs[idx];
> > -                       if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > +                       /* s should be the biggest in the current slot. Hence only LE is
> > +                        * valid
> > +                        */
> > +                       BUG_ON(ULONG_CMP_GT(snp_seq, s));
> > +                       if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> >                                 if (snp == snp_leaf && snp_seq == s)
> >                                         snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> >                                 spin_unlock_irqrestore_rcu_node(snp, flags);
> > -                               if (snp == snp_leaf && snp_seq != s) {
> > -                                       srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > -                                       return;
> > -                               }
> >                                 if (!do_norm)
> >                                         srcu_funnel_exp_start(ssp, snp, s);
> >                                 return;
> > --
> > 2.31.1
> >
