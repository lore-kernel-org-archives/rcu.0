Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D5E77362
	for <rcu@archiver.kernel.org>; Sat, 30 Sep 2023 09:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjI3JsR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Sep 2023 05:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjI3JsQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Sep 2023 05:48:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA53193
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 02:48:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5345a3dfe3bso11125291a12.3
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696067293; x=1696672093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zc5G24wP9uQnxrRkvxnQwMYrY+kIRhL8vImEKtk93A=;
        b=gGyut5I87lQSTC+NS/TUUvsQCq3cvvuOf7YtcehbdRfGg1zQT2pk1l3ZJsLnGFxU47
         qJQvG7RSFWqP8atjz3w1hiwkMBhUdxDElzqLB34/twvfZHkBVe2hyzKNWEqtkACWk9TX
         MYXY6cxki+4L53OZIWr1IQvyiGN7GgEMMpF5bhX2aW08ypD1HoMH4o5aallqOO2kPrys
         DMxgRXCvaTvZVTa/0F6PxSIVpIFDSJHaBK6jPK8XfoCrQfZH9sXOKEZZr2GRXJKuaxW5
         THus2WIT1sj8+R0uBmI6/x03SiN4+Jy+nC3GCyMbasySTkyDTZeJD9p6HN4rsOcTEUOl
         kogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696067293; x=1696672093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zc5G24wP9uQnxrRkvxnQwMYrY+kIRhL8vImEKtk93A=;
        b=PA6CwzGHi0+PWO33wQD3X9m2XRbkExMx4XKvYFNIDpIOrF5UCevItQVdK8wXXVqJ+r
         1FuQLvOAsqp0k/10gXNbUDbBLK4DssN6YQWrZ8tnKshAsbs5vdVA8TLpmbPqJKIlLMSw
         urU9wJCq0y/v5ITFUjGayeOhKd9pVkm6DxfgsbvYm6gnQjQj3uEI5WFSeAJIMWsiUsFD
         /wYEUO4tWQljRRFhF35QTYH4b8BhewvwVKQpGYxgsoVd3DfLfhge6KWSdpI9Cqzkv1Q7
         cU9Ef1XCnbxKZ4OdyOlCTn8bgjif1beIuQLo/yBiAAcLTQAThgH8hF+1f435wm0dxT3D
         5Yzg==
X-Gm-Message-State: AOJu0YwvyQ+KZSM0Ws3uFjM7gAhsCkxTlSx1keEOrFoRFxcMj6mxj+7v
        oeIjeDRbmel3EAyxRYBghpfHC+m6To8eq97nxnA=
X-Google-Smtp-Source: AGHT+IF8FOxnscVx6z9kcNlkpnWhwHvMLf9jw7PnZpTvUpmXd93xTQCuoSFHY/UeM0rMVG6uHojdLrOf5decaUFeiHI=
X-Received: by 2002:a05:6402:751:b0:531:9c1:8276 with SMTP id
 p17-20020a056402075100b0053109c18276mr5738089edy.4.1696067292605; Sat, 30 Sep
 2023 02:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <ZRdTYPFtGrbPqhUY@localhost.localdomain> <CAFwiDX9V1tmRo+qv=3=dmPMsDvoRU3vBai3NBP6KBzr6RXGVtA@mail.gmail.com>
 <ZRfl_QssVLE0fKSD@localhost.localdomain>
In-Reply-To: <ZRfl_QssVLE0fKSD@localhost.localdomain>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Sat, 30 Sep 2023 15:18:00 +0530
Message-ID: <CAFwiDX8jzMrBHaSuggEJbScUgJq0Y4nhCfSc1YGmwOn5vpQqNQ@mail.gmail.com>
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

On Sat, Sep 30, 2023 at 2:40=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Sat, Sep 30, 2023 at 08:15:06AM +0530, Neeraj upadhyay a =C3=A9crit :
> > On Sat, Sep 30, 2023 at 4:15=E2=80=AFAM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > >
> > > Le Thu, Sep 28, 2023 at 05:39:17PM -0400, Joel Fernandes a =C3=A9crit=
 :
> > > > If srcu_invoke_callbacks() was really called for the rdp, I would h=
ave
> > > > expected rcu_segcblist_advance() to advance all those pending
> > > > callbacks to 304.
> > > >
> > > > I posit that probably srcu_invoke_callbacks() is not even being cal=
led
> > > > in the first place, otherwise why is the DONE segment count still 0=
?
> > > > DONE should not be 0, otherwise callbacks will not run. The segcbli=
st
> > > > of the rdp seems out of date perhaps due to rcu_invoke_callbacks() =
not
> > > > being called due to some other bug (or a workqueue/timer issue caus=
ing
> > > > the srcu_invoke_callbacks() to not run?).
> > >
> > > Speaking of, I'm looking at srcu_gp_end() and the comment after relea=
sing
> > > srcu_gp_mutex says:
> > >
> > >               "/* A new grace period can start at this point.  But on=
ly one. */"
> > >
> > > But what ensures that?
> > >
> >
> > I think ->srcu_cb_mutex ensures that.
> >
> > /* Prevent more than one additional grace period. */
> > mutex_lock(&sup->srcu_cb_mutex);
>
> Oh I confused ->srcu_cb_mutex with ->srcu_gp_mutex, didn't I? ;-)

Maybe :) From your reply, I thought you meant srcu_invoke_callbacks() for o=
ne GP
might execute after multiple subsequent GPs have completed, which makes sen=
se.


Thanks
Neeraj
