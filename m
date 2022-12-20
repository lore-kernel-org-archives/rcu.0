Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C25C3DA6E
	for <rcu@archiver.kernel.org>; Tue, 20 Dec 2022 23:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiLTXqZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiLTXqY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Dec 2022 18:46:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE834113B
        for <rcu@vger.kernel.org>; Tue, 20 Dec 2022 15:46:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 1so21022504lfz.4
        for <rcu@vger.kernel.org>; Tue, 20 Dec 2022 15:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtML0qwGaitUp0TiRy+O4yYYdbB8tFyIG4fs8NuVCa8=;
        b=YvSlxYAty7ptj+47fW722mslnmYbmOMcphE/kwVArTgkcoYN9XNKCGTWjElFJPT/Et
         AHJmRI/6bxx9qArXwUviHg0KBXnmdQziNra7RV4bCV0LfgZmmhELJHbb1YzTWFIUwHin
         8NEEy3MfYmAKKeNtERKqDBNLwPyT7iYPD1TvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtML0qwGaitUp0TiRy+O4yYYdbB8tFyIG4fs8NuVCa8=;
        b=0rsx6ELFmI23iCaOa+J5a+ws3qoFMYFZmn2xfT9dSQsiBhCDyvfLcxMEuVzvQ0MqVX
         z4Z/kknl8IlZq60uxQLVAWKyhg5ruNH+ZEHCWq9N3VhqQ8cPlOs4y0JANFhPcTw2v5XI
         R/Ai7O97Cm5bxxv9n7bF2RruywTvpiKKoX6fyn3P/A1umKLoj+3Xu3J5clGa08E5R7Fa
         s/zpmTzbs4/g9Ylh2bWBdVcm5yPJI3h+r25F1tZKAdBuhXFFkfUzHq9RBkm5+KWjGADc
         0+Tg3vdRO9bejA/HYt7FNwm7tjFAwxL1dB+uBYFW3sA2gThdWwQouBCF5hQakY3jBSnV
         k2yQ==
X-Gm-Message-State: ANoB5pkQXuXUdUTTAdLUVKP2AvkdwmI6CQmGA4BSRktNDjghdy+0s/F1
        ysTPB3OaVE9TuOLgpNKQdJYI5ASxX1G5BIVXZTKZ4xDyqama2wibQ8k=
X-Google-Smtp-Source: AA0mqf5y9AaRKqe9GoU5stkGyhjdrAgbiKjzJOpEdCei7zwLDtg0XuYSBv+cYQoULx58DH7465i25iN0t1N4VEW33+g=
X-Received: by 2002:ac2:4347:0:b0:4a4:782a:42ac with SMTP id
 o7-20020ac24347000000b004a4782a42acmr31901376lfl.468.1671579982033; Tue, 20
 Dec 2022 15:46:22 -0800 (PST)
MIME-Version: 1.0
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org> <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
 <CAEXW_YRFbsCzT9iPdVfmeZ5qK+2fnVAwSzxbj1EXmU+vepOKdg@mail.gmail.com> <20221220230521.GC26563@lothringen>
In-Reply-To: <20221220230521.GC26563@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 20 Dec 2022 18:46:10 -0500
Message-ID: <CAEXW_YRw76oCBevJwFvwRRTyNGJZW2H0Zbg1WNX7D4R3bTvsHw@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 20, 2022 at 6:05 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Tue, Dec 20, 2022 at 07:06:57PM +0000, Joel Fernandes wrote:
> > On Tue, Dec 20, 2022 at 7:01 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > >
> > > On 2022-12-20 13:29, Joel Fernandes wrote:
> > > >
> > >
> > > > I do want to finish my memory barrier studies of SRCU over the holi=
days since I have been deep in the hole with that already. Back to the post=
 flip memory barrier here since I think now even that might not be needed=
=E2=80=A6
> > >
> > > I strongly suspect the memory barrier after flip is useless for the s=
ame
> > > reasons I mentioned explaining why the barrier before the flip is use=
less.
> > >
> > > However, we need to double-check that we have memory barriers at the
> > > beginning and end of synchronize_srcu, and between load of "unlock"
> > > counters and load of "lock" counters.
> > >
> > > Where is the barrier at the beginning of synchronize_srcu ?
> >
> > I believe we don't need another memory barrier at the beginning of
> > synchronize_srcu() (but this part of my SRCU study is still pending
> > ;)) . The grace period guarantee (read-side critical sections don't
> > span the GP) is already enforced by the memory barrier between
> > scanning for all unlocks, and scanning for all locks (Paired with
> > corresponding memory barriers on the read-side).
> >
> > Accordingly, before we scan all locks and match lock =3D=3D unlock, the=
re
> > is an smp_mb(). Why is that not sufficient?
>
> That's not enough, you still need a barrier between the updater's pre-GP
> accesses and the scans, so that post-GP read side sees the updater's pre-=
GP
> accesses:
>
>
>             UPDATER                        READER
>             -------                        ------
>             WRITE A                        WRITE srcu_read_lock
>             smp_mb() //rcu_seq_snap()      smp_mb()
>             READ srcu_read_lock //scans    READ A

But see the comments also in srcu_readers_active_idx_check()

* Needs to be a smp_mb() as the read side may
* contain a read from a variable that is written to before the
* synchronize_srcu() in the write side

So that appears to be already covered. Or is your point that the scans
are not happening on the same CPU as the pre-GP writer, as scans are
happening from workqueue ?

Perhaps that comment misled me.

Confused,

 - Joel
