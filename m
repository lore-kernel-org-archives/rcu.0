Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C676E776C2
	for <rcu@archiver.kernel.org>; Mon,  2 Oct 2023 21:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjJBVJp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Oct 2023 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBVJp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Oct 2023 17:09:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC50F8E
        for <rcu@vger.kernel.org>; Mon,  2 Oct 2023 14:09:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73C9C433C8;
        Mon,  2 Oct 2023 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696280982;
        bh=OECyARqsjMUXPxTHbJkS/wyXgvJpyp6sFzlVSpSAlLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3m3jVVlCvWV0MAdd6R8NV9Bw6srySBvLiL1Q/d0+0aViVerpPspivCeCbOkRP8Rs
         LhRkhrS3jqVIw/ar2U7euQR3keo+p2w6Ts190VczueOFOuqlRHfcDjYw1GdwE3Kpiy
         HHkxqzxECdPCPh4zpXEkVvv2soRzBG6VPsOIHZqjl9L9L/Y4XZ6T5ePqHr11YDhkbO
         jsDUHcnhE2JMmehLyv8pQw2DDreeDjuliOn6K5fLFYLl6XT8pA4ncfsuKSpow8Fmkr
         x7JuzJipCM6jKSyNMjVnb/aw1dulEmuB8L0GaW+7QEzvy1usmebaJueHI5fcqf+JaU
         j2QtFPM4Oz94g==
Date:   Mon, 2 Oct 2023 23:09:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRsxk_fZZoUGJ_my@localhost.localdomain>
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain>
 <CAFwiDX9NBdPy-CZA6i9XEd5jM+j9e57zMoW2AwAoNtzDt+8qbw@mail.gmail.com>
 <ZRqeZ31cLs8bocBo@lothringen>
 <CAFwiDX9TMNqG7h-FbzBYu04ew7-6x_-TinzCW6ta+7NX-BRO1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX9TMNqG7h-FbzBYu04ew7-6x_-TinzCW6ta+7NX-BRO1Q@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Mon, Oct 02, 2023 at 06:52:27PM +0530, Neeraj upadhyay a écrit :
> On Mon, Oct 2, 2023 at 4:11 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > Also the role of the remaining advance in srcu_gp_start() is unclear to me...
> >
> 
> As far as I understand, the advance call before accelerate is to make
> space in one of WAIT
> or NEXT_READY tail for acceleration. So, it can be removed.

Sounds good. Will remove that.

> 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 20d7a238d675..5ac81ca10ec8 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -782,8 +782,6 @@ static void srcu_gp_start(struct srcu_struct *ssp)
> >         spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
> >         rcu_segcblist_advance(&sdp->srcu_cblist,
> >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> > -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > -                                      rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
> 
> Deletion is ok; alternatively, we could have used
> WARN_ON_ONCE(rcu_segcblist_accelerate(...))
> in all places other than enqueue time for few cycles to be on safer side.

How about WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL)) ?

> 
> >         spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
> >         WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
> >         WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
> > @@ -1245,7 +1243,18 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >         rcu_segcblist_advance(&sdp->srcu_cblist,
> >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> >         s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> > -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> > +       /*
> > +        * Acceleration might fail if the preceding call to
> > +        * rcu_segcblist_advance() also failed due to a prior grace
> > +        * period seen incomplete before rcu_seq_snap(). If so then a new
> > +        * call to advance will see the completed grace period and fix
> > +        * the situation.
> > +        */
> > +       if (!rcu_segcblist_accelerate(&sdp->srcu_cblist, s)) {
> 
> We can add below also? Here old and new are rcu_seq_current() values used in
> the 2 calls to rcu_segcblist_advance().
> 
> WARN_ON_ONCE(!(rcu_seq_completed_gp(old, new) && rcu_seq_new_gp(old, new)));

Very good point! "new" should be exactly one and a half grace period away from
"old", will add that.

Cooking proper patches now.

Thanks.

> 
> 
> Thanks
> Neeraj
> 
> > +               rcu_segcblist_advance(&sdp->srcu_cblist,
> > +                                     rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> > +               WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
> > +       }
> >         if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> >                 sdp->srcu_gp_seq_needed = s;
> >                 needgp = true;
> > @@ -1692,6 +1701,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
> >         ssp = sdp->ssp;
> >         rcu_cblist_init(&ready_cbs);
> >         spin_lock_irq_rcu_node(sdp);
> > +       WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
> >         rcu_segcblist_advance(&sdp->srcu_cblist,
> >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> >         if (sdp->srcu_cblist_invoking ||
> > @@ -1720,8 +1730,6 @@ static void srcu_invoke_callbacks(struct work_struct *work)
> >          */
> >         spin_lock_irq_rcu_node(sdp);
> >         rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
> > -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > -                                      rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
> >         sdp->srcu_cblist_invoking = false;
> >         more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
> >         spin_unlock_irq_rcu_node(sdp);
