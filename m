Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97532E776C4
	for <rcu@archiver.kernel.org>; Tue,  3 Oct 2023 18:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjJCSqc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJCSqb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Oct 2023 14:46:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4523AF
        for <rcu@vger.kernel.org>; Tue,  3 Oct 2023 11:46:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so2092823a12.3
        for <rcu@vger.kernel.org>; Tue, 03 Oct 2023 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696358787; x=1696963587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpfwWfC88rZQUquZVYrMN45VeJrMBU3e54J/j9eCe4E=;
        b=lK7g+DVAcT/lrp+pjCkc915tQn7y+MEtXu8LpdSmKbSOe1Ps6Dfbnj57EVL8jhkTXd
         GX4lhvmqPNGIUmuVs+4PpRTqvnwFdhbixFl2kXp9Rhobv60umqV/nMAUVvCXDCW/KJ9f
         IsZS+g6uyXI/6n6uQsdAx46p8sPQbkM7u5olmCzqFgqxtsCx71eepRox1OVt17TclCWE
         Zd9QwhfQAfhhqGVfeBJGNbzyu2XwbgnC5m4j5EMdnPN7JReXXNJTUEnm9xPtpTEAKXcZ
         o8m2AwjoAs3kb2F+OpgtgvlJyIhx37JjBXEj+lA1vgFgOSPbFyVNNBUVsDSjl3j+V5ZT
         ag2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358787; x=1696963587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpfwWfC88rZQUquZVYrMN45VeJrMBU3e54J/j9eCe4E=;
        b=hcNakZoxqkpXcVIU3YvFjebnF4rXKqMGHMwL5sj6G2UdI115gbsWpQJ7x4PIRqF9qr
         V+OmH3HbAN5sCqe01pV2jwi06/+M/v4VLutYLnzhOnFTwu6b7Zs6cvDRcPhEYGkoj33+
         I4OJAlb7psA2NSa9UP8/Ve71DajFvNk/fmiAjHaTawdt9+9uECRMMjkNEU1C1YZdC0gA
         vX9ECFnWXjxka09NvCZiWJOlhkM0nGA/+0tjEpOLj8YUfJ/zp6FVPTr5ZmEncwCygZ/d
         CCyqusB7O82XBHtbZasLXe8pHYqHt0miRNPj2oO+o+VO2U46e5Mradzld5NRLckOeZs9
         MSUw==
X-Gm-Message-State: AOJu0YwpeJEirF3eZuqrlQTue11P82I3FjkgsOeQu7Snp29apTgXd0DN
        znyDJh8CxQ0342uXwiY1NCDIgb8V2dr3DWtr2Ts=
X-Google-Smtp-Source: AGHT+IHDHiapEzM2yuNKNm9ciESz1bXjpAs39Jy1dlQfg0rp7FkxvyvZeJHx+W3hIhkukxgoI6Q3n3PvI1b+7kCSOaQ=
X-Received: by 2002:a17:906:23ea:b0:9b7:37de:601a with SMTP id
 j10-20020a17090623ea00b009b737de601amr18253ejg.49.1696358786831; Tue, 03 Oct
 2023 11:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain> <CAFwiDX9NBdPy-CZA6i9XEd5jM+j9e57zMoW2AwAoNtzDt+8qbw@mail.gmail.com>
 <ZRqeZ31cLs8bocBo@lothringen> <CAFwiDX9TMNqG7h-FbzBYu04ew7-6x_-TinzCW6ta+7NX-BRO1Q@mail.gmail.com>
 <ZRsxk_fZZoUGJ_my@localhost.localdomain> <ZRwHadV/p6f7RzGn@lothringen>
In-Reply-To: <ZRwHadV/p6f7RzGn@lothringen>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Wed, 4 Oct 2023 00:16:13 +0530
Message-ID: <CAFwiDX_GGMvfe7JhXUfWZm6ZPfGxC4oCbGBFvg=SjfOhcxQi0w@mail.gmail.com>
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

On Tue, Oct 3, 2023 at 5:52=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> On Mon, Oct 02, 2023 at 11:09:39PM +0200, Frederic Weisbecker wrote:
> > > >         spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. =
*/
> > > >         WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
> > > >         WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
> > > > @@ -1245,7 +1243,18 @@ static unsigned long srcu_gp_start_if_needed=
(struct srcu_struct *ssp,
> > > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > > >                               rcu_seq_current(&ssp->srcu_sup->srcu_=
gp_seq));
> > > >         s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> > > > -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> > > > +       /*
> > > > +        * Acceleration might fail if the preceding call to
> > > > +        * rcu_segcblist_advance() also failed due to a prior grace
> > > > +        * period seen incomplete before rcu_seq_snap(). If so then=
 a new
> > > > +        * call to advance will see the completed grace period and =
fix
> > > > +        * the situation.
> > > > +        */
> > > > +       if (!rcu_segcblist_accelerate(&sdp->srcu_cblist, s)) {
> > >
> > > We can add below also? Here old and new are rcu_seq_current() values =
used in
> > > the 2 calls to rcu_segcblist_advance().
> > >
> > > WARN_ON_ONCE(!(rcu_seq_completed_gp(old, new) && rcu_seq_new_gp(old, =
new)));
> >
> > Very good point! "new" should be exactly one and a half grace period aw=
ay from
> > "old", will add that.
> >
> > Cooking proper patches now.
>
> Actually this more simple fix below. rcu_seq_snap() can be called before
> rcu_segcblist_advance() after all. The only side effect is that callbacks
> advancing is then _after_ the full barrier in rcu_seq_snap(). I don't see
> an obvious problem with that as that barrier only cares about:
>
> 1) Ordering accesses of the update side before call_srcu() so they don't =
bleed
> 2) See all the accesses prior to the grace period of the current gp_num
>
> The only things callbacks advancing need to be ordered against are carrie=
d by
> snp locking.
>

Nice! Your analysis looks good to me!

> I still remove the accelerations elsewhere and advancing in srcu_gp_start=
() in
> further patches. I'll also avoid advancing and acceleration in
> srcu_gp_start_if_needed if there is no callback to queue.
>
> The point is also that this simple fix alone can be easily backported and
> the rest can come as cleanups.
>

Sounds good!

>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 5602042856b1..8b09fb37dbf3 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1244,10 +1244,10 @@ static unsigned long srcu_gp_start_if_needed(stru=
ct srcu_struct *ssp,
>         spin_lock_irqsave_sdp_contention(sdp, &flags);
>         if (rhp)
>                 rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> +       s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);

We might want to add a comment here, why the specific ordering of the two
srcu_gp_seq reads is required here.



Thanks
Neeraj

>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
> -       s =3D rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> +       WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s) && r=
hp);
>         if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
>                 sdp->srcu_gp_seq_needed =3D s;
>                 needgp =3D true;
