Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DADAE784A7
	for <rcu@archiver.kernel.org>; Mon,  2 Oct 2023 02:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjJBCSN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjJBCSN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 1 Oct 2023 22:18:13 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4F0C9
        for <rcu@vger.kernel.org>; Sun,  1 Oct 2023 19:18:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fa2125e19so507118539f.0
        for <rcu@vger.kernel.org>; Sun, 01 Oct 2023 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696213089; x=1696817889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7s6pgG/HczAne7nsb3Qy9nQCpxgtZMC7gcJ07hYeJw=;
        b=dvTbUjwSv1rXa8IThboiWB/a8pcFG7ZnyFq9yUPkil7Y5gBnNy4iskTXqQcvJ6EV8A
         bcRjgkn0zD+q7A8fzL/hc1E+GcyD8bO21Q71w6jnBG/U0A+hUC0Nl2V2Y4ugoh7Jc1N7
         pt6gJ8MsiddfQvbG6xZ2le2u4Hb2yk1GlDTyGhmi5HFH5WrPWx8BN6Bjzmx5ScKzJVgg
         trdBRWm7ROjUb37eXA6IMaqwXZ+3EWpJEEEzFgqWw2Fp3stcmGAUQygB0UjIdigh3QAC
         uN5MMqXVqKIIJ2/I5GWKAkNt1rD0+SryFjm1XCGstQx1TTq9LVjeZeX1l0UZrbYVM7gI
         aCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696213089; x=1696817889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7s6pgG/HczAne7nsb3Qy9nQCpxgtZMC7gcJ07hYeJw=;
        b=u/gCbo+1FD3d2Xa4tHabImDtsyhfJ83P4U6q0YhwOM8cughRRq3/3I1iWdHvC+DDFQ
         cODCNnNvs5jEUdGHBA3GIgz2v5PAJxg9N1ZU/W+mRd1CQMCQUyQZaZZqduDDlPUNkzU1
         tzFABReNkxP7J/qVXHes9smDswJoGJCIQNDxn658K+7Ot+LZbq2pYju+Kc73dsHeIi9B
         toY9f8oHgM0I97ix/PNHDKS9Uw+z+VgVHVXT6U6OEFVVP5CL3Y48ZxHObAlZ+jU5YN32
         +F9aRcyC+9MgZKz+ZAxGRSEkK0m5eETWSntEF0avhlMUdm2oUd/irntkHNHe7CQmC+rT
         UTHg==
X-Gm-Message-State: AOJu0YxEboR/5Z/Pu093AlB+YsOAg15HRWEmxn6R3KKsYVK6hS+s0uHD
        /Judv1HaVN4R1qrmKh+c7mPsO8K0DsACJR6SG78UXTRHDIFqZw==
X-Google-Smtp-Source: AGHT+IG/TGGUAgl6LQ9K2xkluUFw40yuwn+GFeSuYMjNPllkJDUt/Ln8BU62Ch6LAaDQ8O1+5TaBh0ixNjohzl5YLYI=
X-Received: by 2002:a05:6e02:1489:b0:351:5acb:289 with SMTP id
 n9-20020a056e02148900b003515acb0289mr13349126ilk.30.1696213089550; Sun, 01
 Oct 2023 19:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com> <ZRnziciQQLdgYJNx@localhost.localdomain>
In-Reply-To: <ZRnziciQQLdgYJNx@localhost.localdomain>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Mon, 2 Oct 2023 07:47:55 +0530
Message-ID: <CAFwiDX9NBdPy-CZA6i9XEd5jM+j9e57zMoW2AwAoNtzDt+8qbw@mail.gmail.com>
Subject: Re: SRCU: kworker hung in synchronize_srcu
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 2, 2023 at 4:02=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Sun, Oct 01, 2023 at 07:57:14AM +0530, Neeraj upadhyay a =C3=A9crit :
> >
> > But "more" only checks for CBs in DONE tail. The callbacks which have b=
een just
> > accelerated are not advanced to DONE tail.
> >
> > Having said above, I am still trying to figure out, which callbacks
> > are actually being pointed
> > by NEXT tail. Given that __call_srcu() already does a advance and
> > accelerate, all enqueued
> > callbacks would be in either WAIT tail (the callbacks for current
> > active GP) or NEXT_READY
> > tail (the callbacks for next GP after current one completes). So, they
> > should already have
> > GP num assigned and srcu_invoke_callbacks() won't accelerate them.
> > Only case I can
> > think of is, if current GP completes after we sample
> > rcu_seq_current(&ssp->srcu_gp_seq) for
> > rcu_segcblist_advance() (so, WAIT tail cbs are not moved to DONE tail)
> > and a new GP is started
> > before we take snapshot ('s') of next GP  for
> > rcu_segcblist_accelerate(), then the gp num 's'
> > > gp num of NEXT_READY_TAIL and will be put in NEXT tail. Not sure
> > if my understanding is correct here. Thoughts?
> >
> > __call_srcu()
> >         rcu_segcblist_advance(&sdp->srcu_cblist,
> >                               rcu_seq_current(&ssp->srcu_gp_seq));
> >         s =3D rcu_seq_snap(&ssp->srcu_gp_seq);
> >         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
>
> Good point! This looks plausible.
>
> Does the (buggy) acceleration in srcu_invoke_callbacks() exists solely
> to handle that case? Because then the acceleration could be moved before
> the advance on callbacks handling, something like:
>

I think we might need to accelerate after advance, as the  tail pointers
(WAIT, NEXT_READY) can be non-empty and we will not be able to
accelerate (and assign GP num) until we advance WAIT tail to DONE tail?


Thanks
Neeraj

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..af9d8af1d321 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1245,6 +1245,11 @@ static unsigned long srcu_gp_start_if_needed(struc=
t srcu_struct *ssp,
>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
>         s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> +       /*
> +        * Acceleration might fail if the preceding call to
> +        * rcu_segcblist_advance() also failed due to a prior incomplete =
grace
> +        * period. This should be later fixed in srcu_invoke_callbacks().
> +        */
>         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
>         if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
>                 sdp->srcu_gp_seq_needed =3D s;
> @@ -1692,6 +1697,13 @@ static void srcu_invoke_callbacks(struct work_stru=
ct *work)
>         ssp =3D sdp->ssp;
>         rcu_cblist_init(&ready_cbs);
>         spin_lock_irq_rcu_node(sdp);
> +       /*
> +        * Acceleration might have failed in srcu_gp_start_if_needed() if
> +        * the preceding call to rcu_segcblist_advance() also failed due =
to
> +        * a prior incomplete grace period.
> +        */
> +       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> +                                      sdp->srcu_gp_seq_needed);
>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
>         if (sdp->srcu_cblist_invoking ||
> @@ -1720,8 +1732,6 @@ static void srcu_invoke_callbacks(struct work_struc=
t *work)
>          */
>         spin_lock_irq_rcu_node(sdp);
>         rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
> -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> -                                      rcu_seq_snap(&ssp->srcu_sup->srcu_=
gp_seq));
>         sdp->srcu_cblist_invoking =3D false;
>         more =3D rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
>         spin_unlock_irq_rcu_node(sdp);
>
>
> >
> > Thanks
> > Neeraj
> >
> >
> > > if (more) {
> > >   srcu_schedule_cbs_sdp(sdp, 0);
> > > }
> > >
> > > thanks,
> > >
> > >  - Joel
