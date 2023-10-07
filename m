Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB29BE95A60
	for <rcu@archiver.kernel.org>; Sat,  7 Oct 2023 09:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJGJOC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 7 Oct 2023 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJGJOB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 7 Oct 2023 05:14:01 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC7B9
        for <rcu@vger.kernel.org>; Sat,  7 Oct 2023 02:13:59 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3aec067556dso1873823b6e.2
        for <rcu@vger.kernel.org>; Sat, 07 Oct 2023 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696670039; x=1697274839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzxS67I0eUnKfGTkK0+VSzE9FL5W9yqRoc2YN2RlmGI=;
        b=gxIFWWkRho34SVUmuUJUXMFos0Q7U7miFOWbnEHYMCXlsnbH8l/OSjOfEfFoybtnHH
         AdBYCqmXgiFaiYFDbWbivGF/unaYp925ZZnqlyGt+hLYsEjc9b7E7KNB1jJ0Qk2sfKEh
         uAPPQuYSDy0eCRidxGud6lNGfpxAYSQToBY7wIxMg4m0pO7+ejnKMf1BaEUFHUxqqtWN
         CuPBCV8JZwIhUA0MqyNrRdEm2H7KK/noTGzQe1XPIdHA6vbHg1Cznabc+YLIV6srT1wN
         IdJ2nl/JLlsDgjH6bVqoTWRnUJ0/qOhY82rZC0ouJpfpo8nXctnT7qKWM4t9ADinq6R8
         Du6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696670039; x=1697274839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzxS67I0eUnKfGTkK0+VSzE9FL5W9yqRoc2YN2RlmGI=;
        b=ZpHK1sRHAjoy1Fp0VPYjUc3B3IGfXHY/6n+2prY/mazEf7ad8apk4Q58PiVqB3jojK
         Dd7qPwUv0uAxztbOyUlLyPLj171HHFGqUnhlNllVn9yFyNLWzCDCeAcJ3y9IkWNHHTUa
         D6JZKEUIo6mnDizCnwr9tl+omjArkEaVYxqpO7QXH9cWs7MpOfHuixBDXtUg7vNwmwk0
         Vh8VhNSwgiPRn3rGsCtTE9SlY4XquBxXys7dZlCxMRVCw4M5AyZZjIIqxRkXyF8vpIB9
         qmDpTCzBFQoiqCoXHcF5STxSFVALmo2XuQ9jqTi6ROTs4syQ/JApkcXXVizb6hNs+Dbs
         W9Ig==
X-Gm-Message-State: AOJu0Yyr9LckU2toyHfJ+ko888tWfmD597o+JR5VuIgK/dbSvXY++k6q
        Y6p6cOiMuJ3ga+Ei/eZljdKmGyy40VIOsXyci9Y=
X-Google-Smtp-Source: AGHT+IGVT/6J04y2cnTL1/bkpp3cxbsfH9Wp55K+yJxNlLec3XHsncK80eVfvg5p1a78UDgyie3anHuHo8e7OXoVBZ8=
X-Received: by 2002:a05:6358:9192:b0:150:70a:417 with SMTP id
 j18-20020a056358919200b00150070a0417mr11567693rwa.22.1696670039092; Sat, 07
 Oct 2023 02:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com> <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
In-Reply-To: <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
From:   zhuangel570 <zhuangel570@gmail.com>
Date:   Sat, 7 Oct 2023 17:13:47 +0800
Message-ID: <CANZk6aSHU++f6GN7bPhxfbXEySP8TkHSmrvcmzeL4AhP+Ra4sQ@mail.gmail.com>
Subject: Re: SRCU: kworker hung in synchronize_srcu
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 1, 2023 at 10:27=E2=80=AFAM Neeraj upadhyay <neeraj.iitr10@gmai=
l.com> wrote:
>
> On Sun, Oct 1, 2023 at 5:49=E2=80=AFAM Joel Fernandes <joel@joelfernandes=
.org> wrote:
> >
> > On Sat, Sep 30, 2023 at 6:01=E2=80=AFAM Neeraj upadhyay <neeraj.iitr10@=
gmail.com> wrote:
> > >
> > > On Fri, Sep 29, 2023 at 3:35=E2=80=AFAM Joel Fernandes <joel@joelfern=
andes.org> wrote:
> > > >
> > > > Hello,
> > > > Firstly, kudos to the detailed report and analysis. Rare failures a=
re
> > > > hard and your usage crash/kdump is awesome to dig deeper into the
> > > > issue..
> > > >
> > > > On Thu, Sep 28, 2023 at 3:59=E2=80=AFAM zhuangel570 <zhuangel570@gm=
ail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > We encounter SRCU hung issue in stable tree 5.4.203, we are runni=
ng VM create
> > > > > and destroy concurrent test, the issue happens after several week=
s. Now we
> > > > > didn't have a way to reproduce this issue, the issue happens rand=
omly, this
> > > > > is the second time we found it in this year.
> > > > >
> > > > >
> > > > >
> > > > > CASE1: entry of CPU 136 belongs to GP 288 was accelerated to GP 2=
92
> > > > > - [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_call=
backs.
> > > > > - [CPU 136] [GP 284-288] starting, new synchronize_srcu request, =
queue entry
> > > > >   to SDP.
> > > > > - [CPU 041] [GP 284-288] starting, new synchronize_srcu request, =
workload run
> > > > >   faster than CPU 136, start GP, set rcu_seq_start.
> > > > > - [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, fou=
nd no need
> > > > >   to start GP.
> > > > > - [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callb=
acks,
> > > > >   "accelerate" the seq of new added entry to 292 (it should be 28=
8).
> > > >
> > > > But srcu_gp_seq is at 304 right now. How does it matter that the CB=
 is
> > > > marked for 292? It should be ready to execute anyway even at 292. N=
ote
> > > > the meaning of "acceleration", the idea is to start conservatively =
and
> > > > move the callbacks forward as more accurate information is availabl=
e.
> > > > Considering this, 292 initially should be OK IMHO (that's just more
> > > > conservative than 288)..
> > > >
> > >
> > > Maybe it matters, as for a CPU, the callbacks will only be scheduled
> > > in srcu_gp_end() for the GPs, for which it has updated ->srcu_data_ha=
ve_cbs[idx]
> > > and ->srcu_have_cbs[idx]
> >
> > Right but if I am looking at the code correctly, nothing guarantees
> > that srcu_invoke_callbacks is called before srcu_gp_seq can advance.
> > So all callbacks that were previously queued for older grace periods
> > should be run whenever srcu_invoke_callbacks() eventually runs. That's
> > why I was thinking that part looked normal to me (segments having
> > older GP numbers).
> >
> > > > >
> > > > > /*
> > > > >  * CASE2
> > > > >  * - entry of CPU 136 belongs to GP 288 was accelerated to GP 296=
.
> > > > >  * - GP0: 280-284, GP1: 284-288, GP2: 288-292.
> > > > >  */
> > > > >
> > > > > /* [GP0][CPU-136] */
> > > > > process_srcu {
> > > > >  srcu_gp_end
> > > > > }
> > > > >
> > > > >                   /* [GP1][CPU-136] */
> > > > >                   synchronize_srcu {
> > > > >                    __call_srcu {
> > > > >                     rcu_segcblist_enqueue
> > > > >                                            /* [GP1][CPU-041] */
> > > > >                                            synchronize_srcu {
> > > > >                                             __call_srcu {
> > > > >                                              srcu_funnel_gp_start
> > > > >                                               srcu_gp_start
> > > > >                                             }
> > > > >                                            }
> > > > >                                            process_srcu {
> > > > >                                             srcu_gp_end
> > > > >                                              rcu_seq_end
> > > > >                                            }
> > > > >                   /* [GP1][CPU-136] */
> > > > >                     srcu_funnel_gp_start
> > > > >                    }
> > > > >                   }
> > > > > /* [GP0][CPU-136] */
> > > > > srcu_invoke_callbacks {
> > > >
> > > > If srcu_invoke_callbacks() was really called for the rdp, I would h=
ave
> > > > expected rcu_segcblist_advance() to advance all those pending
> > > > callbacks to 304.
> > >
> > > If the callback is in NEXT_TAIL and not assigned GP num,
> > > rcu_segcblist_advance() won't move it and next accelerate in
> > > srcu_invoke_callbacks() will
> > > assign it the next gp sequence num.
> >
> > Sure, and after that again it will call srcu_schedule_cbs_sdp() so
> > that should be fine and the next workqueue invocation
> > srcu_invoke_callbacks() can advance at that time. Right?
> >
>
> But "more" only checks for CBs in DONE tail. The callbacks which have bee=
n just
> accelerated are not advanced to DONE tail.
>
> Having said above, I am still trying to figure out, which callbacks
> are actually being pointed
> by NEXT tail. Given that __call_srcu() already does a advance and
> accelerate, all enqueued
> callbacks would be in either WAIT tail (the callbacks for current
> active GP) or NEXT_READY
> tail (the callbacks for next GP after current one completes). So, they
> should already have
> GP num assigned and srcu_invoke_callbacks() won't accelerate them.
> Only case I can
> think of is, if current GP completes after we sample
> rcu_seq_current(&ssp->srcu_gp_seq) for
> rcu_segcblist_advance() (so, WAIT tail cbs are not moved to DONE tail)
> and a new GP is started
> before we take snapshot ('s') of next GP  for
> rcu_segcblist_accelerate(), then the gp num 's'
> > gp num of NEXT_READY_TAIL and will be put in NEXT tail. Not sure
> if my understanding is correct here. Thoughts?
>
> __call_srcu()
>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_gp_seq));
>         s =3D rcu_seq_snap(&ssp->srcu_gp_seq);
>         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);

Thanks for helping to confirm this!

What I want to explain in my CASE (maybe is not totally correct, I "created=
"
it which base the hung context), is rcu_segcblist_advance and
rcu_segcblist_accelerate in srcu_invoke_callbacks maybe using not-matched
GP seq. And this makes the callbacks "accelerate" to wrong GP, which has no
CBS event on that SNP (CPU groups), then callback leaked in segcglist, caus=
e
__synchronize_srcu hang.

>
> Thanks
> Neeraj
>
>
> > if (more) {
> >   srcu_schedule_cbs_sdp(sdp, 0);
> > }
> >
> > thanks,
> >
> >  - Joel
