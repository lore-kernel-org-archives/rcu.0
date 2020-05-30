Return-Path: <SRS0=NM8h=7M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7628DC433E0
	for <rcu@archiver.kernel.org>; Sat, 30 May 2020 08:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A41E2075A
	for <rcu@archiver.kernel.org>; Sat, 30 May 2020 08:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgE3IBz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 May 2020 04:01:55 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3IBz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 May 2020 04:01:55 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MnagF-1jG5w709Uz-00jX0u; Sat, 30 May 2020 10:01:54 +0200
Received: by mail-qt1-f175.google.com with SMTP id q14so3679165qtr.9;
        Sat, 30 May 2020 01:01:53 -0700 (PDT)
X-Gm-Message-State: AOAM530B+ku2d6iHmd2yJqKfwaJHzm+EJIpgjUUp+7daGv9Yj9RELk+Y
        wuVxF1QHILVctjxBCQX5w3mB6YW99EfUbjr3iNU=
X-Google-Smtp-Source: ABdhPJxmyT8ot6qLbB50xkaVnfH4mv37VsInUjUpW94wGwYh1g3q9/Pe7QCtNDdk1U1eGmXhk2Z/y0tQ5V8pbhXHaL4=
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr6055346qtm.7.1590825712838;
 Sat, 30 May 2020 01:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529201600.493808-1-arnd@arndb.de> <20200530035230.GA2019114@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200530035230.GA2019114@ubuntu-s3-xlarge-x86>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 May 2020 10:01:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3UB2M7Wv8BZx3-ASbsvxD3KHbHCCQ_04xTLPwkEB6twQ@mail.gmail.com>
Message-ID: <CAK8P3a3UB2M7Wv8BZx3-ASbsvxD3KHbHCCQ_04xTLPwkEB6twQ@mail.gmail.com>
Subject: Re: [PATCH] refperf: work around 64-bit division
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rcu@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wtWiFxZOUGa3PCJvcZJ2bjzyE4UfE/ifCl2J0pYX1nQ6OhtYM8z
 ssh4yfR3hg3M8QelOlWY5TiReLfIcHzaYv+cpoW0qKW4zf2JKVCUid21Ziauxg6/wT995rE
 HIwy91VYbB3f+hCG3Mn7XDlYAMpVXrS+yC6mIyBIoeFu/Imk7f4aLqHQ9S7Tba3wkSLZv+N
 E/8QDuY3z6jrWyyMiuVaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QIWUM9NyUR8=:xD1Z/B+IzJG9ARuJZPdq1e
 FrU8OTctougHVPTXWe8vCwspWMJMxL7GudWR8c1lFLaTZjYtyN+jZaS4Cqjzk1GfWjYChHdiE
 Nc1F5M3uJNQ7C+e6+LKlhuvuQh7YD5TVTP+UjmjAkfoQREWXoVL2IrO4YYXH3UGRv8aanhqkR
 hDA5QGlRh5ngB5bUb+vOD9RqMC0WKAb9tchZ4LWRzRbHkPbZUnNMg5iLOqmHelwAFHyJwmx8u
 PClSq3gu9NB81qa80ddTnyjVyEtKEPhTwbqP1K257yEbzy5CWMJoNp4rLj+PxvoiRzTj5W3MM
 sFmkipiwmMEZh8HlrElD8mu6DUF2x5JWGjw0Rauf3AY4/dBsvM+8KzH3Zkcp5cgki2k/9zP61
 RNSH+MrHXrYlGfYnb2a9e6ocRjKSw2S/M1RApb4zjvyDMGWbP7jjJV/XebHaeYm2UYlArKy+v
 MoB4gnAwLg3oB6kjyZ+ncsxySizegXiKkIVFBRATUYl/3E2D1nw03OB5lkBTvKlGZ88SAN7Cu
 SqWkQlvFgaYD/qKxKzMJ14IZeRnKkYUR13gssRNHjVWsecp8X5VC21Fzb/l9ZIzK2aWmznEVw
 +MwDRcimAy0YkVFDhGD6gf6vWl9cZcesrDCnyTuClojcRCDVF6yiA67QCn4QP85ZaRaESCmNW
 vfTcpogWd2N3kslUF1mskY/FvOjZr9GDMAj85TiTs4WuUtLptruU2V/ngictxgIn6Zoz5NoXh
 qW8eyOPWcelMNib6F3r6t3WvYRAKFALuYKAH0QwH80l/HCIeC9xbhUPimyNJR0CZrpqdgKC8l
 YLgpz2FIZSEMow57JlHw3TCRs4Y9YXc8YDEGxhxtNu4bLyRal8=
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, May 30, 2020 at 5:52 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Fri, May 29, 2020 at 10:15:51PM +0200, Arnd Bergmann wrote:
> >       strcat(buf, "Threads\tTime(ns)\n");
> >
> >       for (exp = 0; exp < nruns; exp++) {
> > +             u64 avg;
> > +             u32 rem;
> > +
> >               if (errexit)
> >                       break;
> > -             sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
> > +
> > +             avg = div_s64_rem(result_avg[exp], 1000, &rem);
>
> Shouldn't this be div_u64_rem? result_avg is u64.

Yes, you are right. Actually that would be an important optimization
since div_u64_rem() optimizes for constant divisors while div_s64_rem
uses the slow path.

> > +             sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, avg, rem);
>
> Would %03u be the better specifier since rem is u32?

Yes, though this makes no difference in practice.

Paul, should I send a fixup for these two, or do you prefer to just
edit it in place?

    Arnd
