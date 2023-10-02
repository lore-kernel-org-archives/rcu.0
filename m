Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1167AE784A6
	for <rcu@archiver.kernel.org>; Mon,  2 Oct 2023 02:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjJBCV3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCV3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 1 Oct 2023 22:21:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DF78E
        for <rcu@vger.kernel.org>; Sun,  1 Oct 2023 19:21:26 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ae5ee80c0dso4508946b6e.3
        for <rcu@vger.kernel.org>; Sun, 01 Oct 2023 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696213286; x=1696818086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYrFm3CjIRUxAt6U9FFuiSr179kFkDuERVuyV3+p0X0=;
        b=UbTAuHMyHpvyLmugaqb6p23mQ0W8CzSkeuOwXvaFP21iNmv4X9a05tNB9LRcT2qkKe
         THRAAFi9d3axJamkfhLPIjTg8sK+2ybHV96yfNNJJLB2W2tV7g23KPQgp9HBM48P3B1x
         ywmHE53icafwhx59bgBoWUQrDVWd6bqPKTRPlVnNuoS3Ag/Ph/wLBayp5UijtFjpxphf
         5UMBMDkYfpgXpyghobAjFCw1durR2Asz97Rz8RZZbLl7okWH/lFj0qPr2pLetgbSWhBC
         xp9+qkWVVAvkp+lJP1jIyAvbLXxQUhpFzA94CKOoO251ASyVxmuBHC9+jKCyzM5MPCAo
         9EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696213286; x=1696818086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYrFm3CjIRUxAt6U9FFuiSr179kFkDuERVuyV3+p0X0=;
        b=I6Hu8eqrwPCqnndMMpTA+IvdkZ2xRFLeyFhMrf9v5ElbaGGgxPIOgJbGNgC48n4Rq1
         +H6512Ey9fsuhlVXRtD63WtAF1BYwDWfckVSipwa5/NUxP28TdwRmETQzXHLhojkWvAM
         DIPXMTPnqieb3x3RiDRoRucH1DFvLjzpKfCMO1QQ4ApEMdAfrk9znRA9R1/VBpUcW8Dp
         JHDWsL1MXz9u+DewkDkgXLIgjkYyj7ONu0QIR3eQR/71Z3KhDBSM9vyRQp/8JClqUBmW
         6aXvkpRUS+jja/uM57Paw5/Ug/gl7AgGDvvX4zvenY0kZ8kd0XlJFTLy7YCOZ2sHF+O0
         +zuw==
X-Gm-Message-State: AOJu0Yzrb4c5gI5frSnuOyTZNkLCGymmd02irmG4LUwKOOvkjgKPkAqM
        PqYs4c9e9/CtIvl7+fUzq8m5ezD+mSMD/6hhnPWN/SP+PqagSVMS
X-Google-Smtp-Source: AGHT+IH/2U3E+blwGVZiv5jyA+830naO6UtaE3lNlFithJ/miKuLkkdYApLMTHGC9fsiPxP4OQfh/w5xMOOkdAnuCXs=
X-Received: by 2002:a05:6808:2391:b0:3af:585:402a with SMTP id
 bp17-20020a056808239100b003af0585402amr13539243oib.39.1696213285700; Sun, 01
 Oct 2023 19:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain> <ZRn1PU8enLoM8u1T@localhost.localdomain>
In-Reply-To: <ZRn1PU8enLoM8u1T@localhost.localdomain>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Mon, 2 Oct 2023 07:51:10 +0530
Message-ID: <CAFwiDX_RxMQ1SgG8Wc+JWB_9i-i90Qmxuei_Yk2yJ7ohTOHjLg@mail.gmail.com>
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

On Mon, Oct 2, 2023 at 4:10=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Mon, Oct 02, 2023 at 12:32:41AM +0200, Frederic Weisbecker a =C3=A9cri=
t :
> > Le Sun, Oct 01, 2023 at 07:57:14AM +0530, Neeraj upadhyay a =C3=A9crit =
:
> > >
> > > But "more" only checks for CBs in DONE tail. The callbacks which have=
 been just
> > > accelerated are not advanced to DONE tail.
> > >
> > > Having said above, I am still trying to figure out, which callbacks
> > > are actually being pointed
> > > by NEXT tail. Given that __call_srcu() already does a advance and
> > > accelerate, all enqueued
> > > callbacks would be in either WAIT tail (the callbacks for current
> > > active GP) or NEXT_READY
> > > tail (the callbacks for next GP after current one completes). So, the=
y
> > > should already have
> > > GP num assigned and srcu_invoke_callbacks() won't accelerate them.
> > > Only case I can
> > > think of is, if current GP completes after we sample
> > > rcu_seq_current(&ssp->srcu_gp_seq) for
> > > rcu_segcblist_advance() (so, WAIT tail cbs are not moved to DONE tail=
)
> > > and a new GP is started
> > > before we take snapshot ('s') of next GP  for
> > > rcu_segcblist_accelerate(), then the gp num 's'
> > > > gp num of NEXT_READY_TAIL and will be put in NEXT tail. Not sure
> > > if my understanding is correct here. Thoughts?
> > >
> > > __call_srcu()
> > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > >                               rcu_seq_current(&ssp->srcu_gp_seq));
> > >         s =3D rcu_seq_snap(&ssp->srcu_gp_seq);
> > >         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> >
> > Good point! This looks plausible.
> >
> > Does the (buggy) acceleration in srcu_invoke_callbacks() exists solely
> > to handle that case? Because then the acceleration could be moved befor=
e
> > the advance on callbacks handling, something like:
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 20d7a238d675..af9d8af1d321 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1245,6 +1245,11 @@ static unsigned long srcu_gp_start_if_needed(str=
uct srcu_struct *ssp,
> >       rcu_segcblist_advance(&sdp->srcu_cblist,
> >                             rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
> >       s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> > +     /*
> > +      * Acceleration might fail if the preceding call to
> > +      * rcu_segcblist_advance() also failed due to a prior incomplete =
grace
> > +      * period. This should be later fixed in srcu_invoke_callbacks().
> > +      */
> >       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> >       if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> >               sdp->srcu_gp_seq_needed =3D s;
> > @@ -1692,6 +1697,13 @@ static void srcu_invoke_callbacks(struct work_st=
ruct *work)
> >       ssp =3D sdp->ssp;
> >       rcu_cblist_init(&ready_cbs);
> >       spin_lock_irq_rcu_node(sdp);
> > +     /*
> > +      * Acceleration might have failed in srcu_gp_start_if_needed() if
> > +      * the preceding call to rcu_segcblist_advance() also failed due =
to
> > +      * a prior incomplete grace period.
> > +      */
> > +     (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > +                                    sdp->srcu_gp_seq_needed);
> >       rcu_segcblist_advance(&sdp->srcu_cblist,
> >                             rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
> >       if (sdp->srcu_cblist_invoking ||
> > @@ -1720,8 +1732,6 @@ static void srcu_invoke_callbacks(struct work_str=
uct *work)
> >        */
> >       spin_lock_irq_rcu_node(sdp);
> >       rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
> > -     (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > -                                    rcu_seq_snap(&ssp->srcu_sup->srcu_=
gp_seq));
> >       sdp->srcu_cblist_invoking =3D false;
> >       more =3D rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
> >       spin_unlock_irq_rcu_node(sdp);
>
> And if this works, can we then remove srcu_invoke_callbacks() self-requeu=
e?
> If queued several times before it actually fires, it will catch the lates=
t
> grace period's end. And if queued while the callback runs, it will re-run=
.
>

This makes sense, but not sure for non-wq context which  link [1] mentions,
whether it needs it.

> Also why do we have sdp->srcu_invoke_callbacks ? Is that workqueue re-ent=
rant?
>
I think you mean sdp->srcu_cblist_invoking ?

There was a prior discussion on this [1], where Paul mentions about
non-wq context.



Thanks
Neeraj

[1] https://lkml.org/lkml/2020/11/19/1065

> Thanks.
