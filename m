Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F01E75426
	for <rcu@archiver.kernel.org>; Tue,  3 Oct 2023 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJCMAc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Oct 2023 08:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjJCMAc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Oct 2023 08:00:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC2AAC
        for <rcu@vger.kernel.org>; Tue,  3 Oct 2023 05:00:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9adca291f99so141681266b.2
        for <rcu@vger.kernel.org>; Tue, 03 Oct 2023 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696334427; x=1696939227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKp5HaYmRZl0uTJtu+uhKMAFHuvI8VVFG6DlxU6H4Qc=;
        b=KxHKwBRRL1X4CU/FNjg0HOGQw4Ir3pEOw/KJruKi8c4PCkpnVdrqZGKZWn5sL9P1Re
         jtZFMeCVfTMXifyllVro7oxKEI2icwED4/0trfDDwNEQ4RkZT05Dm2oCVyzZqh26nn2J
         jJBdHqnTFCMItbbAs/G1aJwHvVn/vuQaaM/Wxo5xzignGb49ev4On8IGyWk6u2Nh54Fn
         FpE6qcOWOwizKIcC2H7litzVcvK5o/3DRKoPyvVZjaFFqoQ9Px/QCuYflquKeartQbQz
         m8u1xlap0FSTHfY83L0/T2mnL6L2AHVa1Dw8ixg3aGLpLtdLqP1rOjurVOH96dMcdK7Z
         K/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696334427; x=1696939227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKp5HaYmRZl0uTJtu+uhKMAFHuvI8VVFG6DlxU6H4Qc=;
        b=fptgNxUnj9vl+S4eQNFMVXDNQNkd3zeNfWcQsAbKDuwGixpfVX5Kv0oLexiY9ij2VR
         0GaX4OXVsRIE2/n9g7n3Jr+1rrTBnW2E+XJTPt3zJcwRnBQy7GQULXpZ9Mxxh2/DtLpO
         5u4IBi8yIft1MtZHg6OpH7vB7m4+4nzfHofZ6rujVG6jW3nChZIOp66eHkn3LaSdgczC
         XAa3UBn9+rHAWFvxoJylxY2xOpCexCgWqJceo4d5SUs/KFKNeYp+L+IAIt6BN9+9rFLI
         O/DxDg31BL4c9R3yXj03uW1yCbM2Lx8y2WQnoHXyfnI7pLTpqP3YYd3GE9qcOEHPyoA4
         4mcQ==
X-Gm-Message-State: AOJu0YzrxQa3CiDs/g4poc93jEio6ovK5UyGoMDJCv3creztsGiYjCKA
        C/nm95fsbnokIholVxZW5NS/RTom/Ejz8srm6Dl5TMamBjI36MxtLunPTLSu
X-Google-Smtp-Source: AGHT+IGwdEf1BeZ/y+EB30vX/JdPctFuD0KcqZ1fRrE4oLz1YXrJWYTYDn/PFubUHQD1fMbkhm+mEugI9fNrcNpQq+E=
X-Received: by 2002:a17:906:74ca:b0:9b2:94a8:df5 with SMTP id
 z10-20020a17090674ca00b009b294a80df5mr12644915ejl.35.1696334427109; Tue, 03
 Oct 2023 05:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain> <CAFwiDX9NBdPy-CZA6i9XEd5jM+j9e57zMoW2AwAoNtzDt+8qbw@mail.gmail.com>
 <ZRqeZ31cLs8bocBo@lothringen> <CAFwiDX9TMNqG7h-FbzBYu04ew7-6x_-TinzCW6ta+7NX-BRO1Q@mail.gmail.com>
 <ZRsxk_fZZoUGJ_my@localhost.localdomain>
In-Reply-To: <ZRsxk_fZZoUGJ_my@localhost.localdomain>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Tue, 3 Oct 2023 17:30:14 +0530
Message-ID: <CAFwiDX9t2g1h2k8wviZf935X9BDLKSN1SHFWxsvtg-HoR7HMJw@mail.gmail.com>
Subject: Re: SRCU: kworker hung in synchronize_srcu
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 3 Oct, 2023, 2:39 am Frederic Weisbecker, <frederic@kernel.org> wro=
te:
>
> Le Mon, Oct 02, 2023 at 06:52:27PM +0530, Neeraj upadhyay a =C3=A9crit :
> > On Mon, Oct 2, 2023 at 4:11=E2=80=AFPM Frederic Weisbecker <frederic@ke=
rnel.org> wrote:
> > > Also the role of the remaining advance in srcu_gp_start() is unclear =
to me...
> > >
> >
> > As far as I understand, the advance call before accelerate is to make
> > space in one of WAIT
> > or NEXT_READY tail for acceleration. So, it can be removed.
>
> Sounds good. Will remove that.
>
> >
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 20d7a238d675..5ac81ca10ec8 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -782,8 +782,6 @@ static void srcu_gp_start(struct srcu_struct *ssp=
)
> > >         spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
> > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp=
_seq));
> > > -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > > -                                      rcu_seq_snap(&ssp->srcu_sup->s=
rcu_gp_seq));
> >
> > Deletion is ok; alternatively, we could have used
> > WARN_ON_ONCE(rcu_segcblist_accelerate(...))
> > in all places other than enqueue time for few cycles to be on safer sid=
e.
>
> How about WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEX=
T_TAIL)) ?
>

Sounds good. My initial thought to put
WARN_ON_ONCE(rcu_segcblist_accelerate(...)) was to
catch any unexpected accelerations for WAIT and NEXT_READY cbs.
However, as all rcu_seq_snap()
snapshots, used for acceleration, are ordered, I think we do not need
to check for those tails.

> >
> > >         spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
> > >         WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
> > >         WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
> > > @@ -1245,7 +1243,18 @@ static unsigned long srcu_gp_start_if_needed(s=
truct srcu_struct *ssp,
> > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp=
_seq));
> > >         s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> > > -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> > > +       /*
> > > +        * Acceleration might fail if the preceding call to
> > > +        * rcu_segcblist_advance() also failed due to a prior grace
> > > +        * period seen incomplete before rcu_seq_snap(). If so then a=
 new
> > > +        * call to advance will see the completed grace period and fi=
x
> > > +        * the situation.
> > > +        */
> > > +       if (!rcu_segcblist_accelerate(&sdp->srcu_cblist, s)) {
> >
> > We can add below also? Here old and new are rcu_seq_current() values us=
ed in
> > the 2 calls to rcu_segcblist_advance().
> >
> > WARN_ON_ONCE(!(rcu_seq_completed_gp(old, new) && rcu_seq_new_gp(old, ne=
w)));
>
> Very good point! "new" should be exactly one and a half grace period away=
 from
> "old", will add that.
>
> Cooking proper patches now.
>

Cool!


Thanks
Neeraj

> Thanks.
>
> >
> >
> > Thanks
> > Neeraj
> >
> > > +               rcu_segcblist_advance(&sdp->srcu_cblist,
> > > +                                     rcu_seq_current(&ssp->srcu_sup-=
>srcu_gp_seq));
> > > +               WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cbl=
ist, s));
> > > +       }
> > >         if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> > >                 sdp->srcu_gp_seq_needed =3D s;
> > >                 needgp =3D true;
> > > @@ -1692,6 +1701,7 @@ static void srcu_invoke_callbacks(struct work_s=
truct *work)
> > >         ssp =3D sdp->ssp;
> > >         rcu_cblist_init(&ready_cbs);
> > >         spin_lock_irq_rcu_node(sdp);
> > > +       WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_N=
EXT_TAIL));
> > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp=
_seq));
> > >         if (sdp->srcu_cblist_invoking ||
> > > @@ -1720,8 +1730,6 @@ static void srcu_invoke_callbacks(struct work_s=
truct *work)
> > >          */
> > >         spin_lock_irq_rcu_node(sdp);
> > >         rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
> > > -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > > -                                      rcu_seq_snap(&ssp->srcu_sup->s=
rcu_gp_seq));
> > >         sdp->srcu_cblist_invoking =3D false;
> > >         more =3D rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
> > >         spin_unlock_irq_rcu_node(sdp);
