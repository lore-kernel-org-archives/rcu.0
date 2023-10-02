Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC265E784AC
	for <rcu@archiver.kernel.org>; Mon,  2 Oct 2023 13:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjJBNWu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Oct 2023 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjJBNWq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Oct 2023 09:22:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E049EB0
        for <rcu@vger.kernel.org>; Mon,  2 Oct 2023 06:22:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso2339074066b.1
        for <rcu@vger.kernel.org>; Mon, 02 Oct 2023 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696252961; x=1696857761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+jZCNcvdqL/8IXQNC1tjV/dMLZEbuLksSGqCKOw4+E=;
        b=XdTTomM2hjYHaRu36A0Bwk1NmY4mEE6KbECrco/0FPNFdpxa/BSaYgxAt1q5vD3rih
         QUjwHuHlAlsYnI1jRhxEOnWtOh1sRmoqXa+W+KZumkkrqGTeT51x65GvLdOOnG/Px4Bc
         nf4MNCLTMjJXyr+94eg6JCgMReBFqIZL4m0JMOfoUpkG2sLQzv2M68/PpJR5Ap5lVnFX
         aLl7BTt++akvl3ZJ/d05SbnD5SS1JYupf8bp6DtypNLpfYWSB7heWZO7X0h8X8fGr77x
         8mJrzzqfKpsq/tt7fLGbyH70n2NdIM65JbVsmmUGP5MMcpGzYDLn1E5Ja9Q1cKS0hcCA
         C5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252961; x=1696857761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+jZCNcvdqL/8IXQNC1tjV/dMLZEbuLksSGqCKOw4+E=;
        b=rSGux69Y/jJtpVt/vraK22u8vG/N55PAgDVGuKQ8hV0Gfwmp5grIri48N8HHrhMA8s
         mnSgDaprencwdSLp+dQsiPcVusn29ndZBsj31WvRF/GanxDPItkwqdFkFw+joSEm4bRf
         Rm54TqZdo9l2/ocJ48eKqP1NQtn984npexQWWGBheXPh2nFxJ0RfJnJb5pCbwE9Myvkm
         w8jRp+89MPZMF6h/nc3dBxQeeut1TU/iJPlgqYoQioOsRX87yAB/CJzbSiXWxwQAv3wF
         6t/Jt5XkHQm1BRkbSj6m0KWG/yBG8nP9ImKc9lx+UzZde5hxMCDdeO1yWVUq3SpaXn6X
         B4hQ==
X-Gm-Message-State: AOJu0YxhnrwYFGZMWHZN+s5vdFXp3+bOfTCiL/wwJDI33UD95pofNLLW
        aDLpIrjBDYKikeLqax7rsYEqIeiaI+YBJ7zthZg=
X-Google-Smtp-Source: AGHT+IFIoOnKtd6YX3hC50UOsEOEETqh/Td8s8XNhpaYAl1FRFgHr9Ex9oWwqlwRJMYF7P0WocDgOIuCfrWUB+3usWo=
X-Received: by 2002:a17:906:53da:b0:9ae:5492:64e with SMTP id
 p26-20020a17090653da00b009ae5492064emr10263494ejo.25.1696252960885; Mon, 02
 Oct 2023 06:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain> <CAFwiDX9NBdPy-CZA6i9XEd5jM+j9e57zMoW2AwAoNtzDt+8qbw@mail.gmail.com>
 <ZRqeZ31cLs8bocBo@lothringen>
In-Reply-To: <ZRqeZ31cLs8bocBo@lothringen>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Mon, 2 Oct 2023 18:52:27 +0530
Message-ID: <CAFwiDX9TMNqG7h-FbzBYu04ew7-6x_-TinzCW6ta+7NX-BRO1Q@mail.gmail.com>
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

On Mon, Oct 2, 2023 at 4:11=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> On Mon, Oct 02, 2023 at 07:47:55AM +0530, Neeraj upadhyay wrote:
> > On Mon, Oct 2, 2023 at 4:02=E2=80=AFAM Frederic Weisbecker <frederic@ke=
rnel.org> wrote:
> > >
> > > Le Sun, Oct 01, 2023 at 07:57:14AM +0530, Neeraj upadhyay a =C3=A9cri=
t :
> > > >
> > > > But "more" only checks for CBs in DONE tail. The callbacks which ha=
ve been just
> > > > accelerated are not advanced to DONE tail.
> > > >
> > > > Having said above, I am still trying to figure out, which callbacks
> > > > are actually being pointed
> > > > by NEXT tail. Given that __call_srcu() already does a advance and
> > > > accelerate, all enqueued
> > > > callbacks would be in either WAIT tail (the callbacks for current
> > > > active GP) or NEXT_READY
> > > > tail (the callbacks for next GP after current one completes). So, t=
hey
> > > > should already have
> > > > GP num assigned and srcu_invoke_callbacks() won't accelerate them.
> > > > Only case I can
> > > > think of is, if current GP completes after we sample
> > > > rcu_seq_current(&ssp->srcu_gp_seq) for
> > > > rcu_segcblist_advance() (so, WAIT tail cbs are not moved to DONE ta=
il)
> > > > and a new GP is started
> > > > before we take snapshot ('s') of next GP  for
> > > > rcu_segcblist_accelerate(), then the gp num 's'
> > > > > gp num of NEXT_READY_TAIL and will be put in NEXT tail. Not sure
> > > > if my understanding is correct here. Thoughts?
> > > >
> > > > __call_srcu()
> > > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > > >                               rcu_seq_current(&ssp->srcu_gp_seq));
> > > >         s =3D rcu_seq_snap(&ssp->srcu_gp_seq);
> > > >         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> > >
> > > Good point! This looks plausible.
> > >
> > > Does the (buggy) acceleration in srcu_invoke_callbacks() exists solel=
y
> > > to handle that case? Because then the acceleration could be moved bef=
ore
> > > the advance on callbacks handling, something like:
> > >
> >
> > I think we might need to accelerate after advance, as the  tail pointer=
s
> > (WAIT, NEXT_READY) can be non-empty and we will not be able to
> > accelerate (and assign GP num) until we advance WAIT tail to DONE tail?
>
> Right indeed! How about the following patch then, assuming that in SRCU:
> 1 enqueue =3D=3D 1 accelerate and therefore it only makes sense
> to accelerate on enqueue time and any other accelerate call is error pron=
e.
>

Agree.

> I can't find a scenario where the second call below to accelerate (and th=
us also
> the second call to advance) would fail. Please tell me if I'm missing som=
ething.

Looks good to me. Few minor comments.

> Also the role of the remaining advance in srcu_gp_start() is unclear to m=
e...
>

As far as I understand, the advance call before accelerate is to make
space in one of WAIT
or NEXT_READY tail for acceleration. So, it can be removed.

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..5ac81ca10ec8 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -782,8 +782,6 @@ static void srcu_gp_start(struct srcu_struct *ssp)
>         spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
> -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> -                                      rcu_seq_snap(&ssp->srcu_sup->srcu_=
gp_seq));

Deletion is ok; alternatively, we could have used
WARN_ON_ONCE(rcu_segcblist_accelerate(...))
in all places other than enqueue time for few cycles to be on safer side.

>         spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
>         WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
>         WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
> @@ -1245,7 +1243,18 @@ static unsigned long srcu_gp_start_if_needed(struc=
t srcu_struct *ssp,
>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
>         s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> +       /*
> +        * Acceleration might fail if the preceding call to
> +        * rcu_segcblist_advance() also failed due to a prior grace
> +        * period seen incomplete before rcu_seq_snap(). If so then a new
> +        * call to advance will see the completed grace period and fix
> +        * the situation.
> +        */
> +       if (!rcu_segcblist_accelerate(&sdp->srcu_cblist, s)) {

We can add below also? Here old and new are rcu_seq_current() values used i=
n
the 2 calls to rcu_segcblist_advance().

WARN_ON_ONCE(!(rcu_seq_completed_gp(old, new) && rcu_seq_new_gp(old, new)))=
;


Thanks
Neeraj

> +               rcu_segcblist_advance(&sdp->srcu_cblist,
> +                                     rcu_seq_current(&ssp->srcu_sup->src=
u_gp_seq));
> +               WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist,=
 s));
> +       }
>         if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
>                 sdp->srcu_gp_seq_needed =3D s;
>                 needgp =3D true;
> @@ -1692,6 +1701,7 @@ static void srcu_invoke_callbacks(struct work_struc=
t *work)
>         ssp =3D sdp->ssp;
>         rcu_cblist_init(&ready_cbs);
>         spin_lock_irq_rcu_node(sdp);
> +       WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_=
TAIL));
>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
>         if (sdp->srcu_cblist_invoking ||
> @@ -1720,8 +1730,6 @@ static void srcu_invoke_callbacks(struct work_struc=
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
