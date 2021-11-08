Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A93C433EF
	for <rcu@archiver.kernel.org>; Mon,  8 Nov 2021 12:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C47A61242
	for <rcu@archiver.kernel.org>; Mon,  8 Nov 2021 12:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhKHMZo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Nov 2021 07:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhKHMZo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Nov 2021 07:25:44 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34493C061714
        for <rcu@vger.kernel.org>; Mon,  8 Nov 2021 04:23:00 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so12985563otj.5
        for <rcu@vger.kernel.org>; Mon, 08 Nov 2021 04:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oWxAh99exjntWaHx951+lk35+JEy7HDXRjBJyaOouWU=;
        b=TMWKPx9Mlu1gt1Dsql9V5i6foiLkmYoluQWW2TZGLNH9JOIfWbU3kOAlTrgWmJU18L
         6t+dAkMC0bLe9uBOUXznq2AchZWKNXA8QGz1X5dGFyuODtusu3svwNtw42mDoyLY2c1z
         n0q7RrPftmR6gKSGND2PkG+Io+Cb9i2PzKvOrGbg3Vt6sRTQQCgossWdxIM4/1rm2GDY
         AqMzY4atHP5Nmn6iaNooPg0xfx4Lgu451Ie6jcjWyrH9kMsVRCxJ5fJ0mcl9klsHLC7L
         4xte54RsrSavj+bV+2BjwG30ATpN8QSaIKLXmVQgv1i+vmexgkEKcDvnWfyjOUM5iGqQ
         JAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oWxAh99exjntWaHx951+lk35+JEy7HDXRjBJyaOouWU=;
        b=Lsdkp8LTF7LThibv18z+V6MoJvhLjyskuuHPAoHjukuVhG0xN6rr9xECEil7U8BzEm
         wu52KECrQZEkbqdq0F+iOpJC87kWTFbvp5693LAPws8LaDzhO7Rp3cvq4Z/X9a54XtVm
         NxVVMDH4NB7BDW4gGz+aQo6q2JIm7Izn3dNZLx0GnjCOXlq6L5E2cCLjd4pFQbLVj0oE
         61uH+2KUKQc77Nr3bzaP7acY1hg5hDorLkdgfRCidVxqJBWWsdmcg75ljpzoKCssX2Ah
         hIe2r+mN4HmNE3GoSK97hiPCa+E/CDn16H1ovouKo7ZUe37MNg9nNGP3jCvAnaVkxVhn
         BxnQ==
X-Gm-Message-State: AOAM531c0Uqn1N2HRbQHxt1xBsVQ2v33jBerA5+eRiRAeIorSxuc292X
        tI7Mv1MQ3dbsld2/ITFLpQsOWC4ZBPrO3wvpwRVI4w==
X-Google-Smtp-Source: ABdhPJwY6iY3P7gjSdKE3FL0f53VDSp7ma6kV0PenUej/5Wv3VnkI+lYk+RF5GRmXbPONupQsEfVwY+asQAkq08knik=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr60084401otb.92.1636374179281;
 Mon, 08 Nov 2021 04:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20211101103158.3725704-1-jun.miao@windriver.com>
 <96f9d669-b9da-f387-199e-e6bf36081fbd@windriver.com> <CA+KHdyU98uHkf1VKbvFs0wcXz7SaizENRXn4BEpKJhe+KmXZuw@mail.gmail.com>
 <baa768a3-aacf-ba3a-8d20-0abc78eca2f7@windriver.com> <CA+KHdyUEtBQjh61Xx+4a-AS0+z18CW1W5GzaRVsihuy=PUpUxA@mail.gmail.com>
 <20211103181315.GT880162@paulmck-ThinkPad-P17-Gen-1> <20211103212117.GA631708@paulmck-ThinkPad-P17-Gen-1>
 <309b8284-1c31-7cc4-eb40-ba6d8d136c09@windriver.com> <20211104012843.GD641268@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+bih9gX2+XvRh3q7XYe8rbgCDF5=5eMV8cxBimvPLQtug@mail.gmail.com>
In-Reply-To: <CACT4Y+bih9gX2+XvRh3q7XYe8rbgCDF5=5eMV8cxBimvPLQtug@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 8 Nov 2021 13:22:47 +0100
Message-ID: <CANpmjNOHvG-9tWK-1Kk4o+L=XXd09xBac_KpCr9PR5us2m-vTA@mail.gmail.com>
Subject: Re: [PATCH] rcu: avoid alloc_pages() when recording stack
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     paulmck@kernel.org, kasan-dev <kasan-dev@googlegroups.com>,
        Jun Miao <jun.miao@windriver.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        qiang.zhang1211@gmail.com, RCU <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, miaojun0823@163.com,
        ryabinin.a.a@gmail.com, Alexander Potapenko <glider@google.com>,
        jianwei.hu@windriver.com, melver@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 8 Nov 2021 at 12:42, 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
[...]
> > > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > I have queued it for review and testing, thank you both!  I do ha=
ve
> > > > > some remaining concerns about this code being starved for memory.=
  I am
> > > > > wondering if the code needs to check the interrupt state.  And pe=
rhaps
> > > > > also whether locks are held.  I of course will refrain from sendi=
ng
> > > > > this to mainline until these concerns are resolved.
> > > > >
> > > > > Marco, Dmitry, thoughts?

It's a general limitation of kasan_record_aux_stack_noalloc(), and if
stackdepot's pool is exhausted, we just don't record the stacktrace.
But given we just can't allocate any memory at all, I think it's the
best we can do.

However, given there are enough normal (with allocation allowed) uses
of stackdepot with KASAN enabled, the chances of stackdepot having
exhausted its pool when calling this are small. The condition when
recording the stack with the _noalloc() variant would fail is:
stackdepot runs out of space AND the same stack trace has not been
recorded before. And the only time we'd notice this is if we actually
hit a kernel bug that KASAN wants to report. The aggregate probability
of all this happening is very very low.

The original series has some more explanation:
https://lkml.kernel.org/r/20210913112609.2651084-1-elver@google.com

> > > > Well, the compiler does have an opinion:
> > > >
> > > > kernel/rcu/tree.c: In function =E2=80=98__call_rcu=E2=80=99:
> > > > kernel/rcu/tree.c:3029:2: error: implicit declaration of function =
=E2=80=98kasan_record_aux_stack_noalloc=E2=80=99; did you mean =E2=80=98kas=
an_record_aux_stack=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> > > >   3029 |  kasan_record_aux_stack_noalloc(head);
> > > >        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >        |  kasan_record_aux_stack
> > > >
> > > > I get the same message after merging in current mainline.
> > > >
> > > > I have therefore dropped this patch for the time being.
> > > >
> > > >                                                          Thanx, Pau=
l
> > > Hi Paul E,
> > > The kasan_record_aux_stack_noalloc() is just introduce to linux-next =
now,
> > > and marking "Notice: this object is not reachable from any branch." i=
n
> > > commit.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/include/linux/kasan.h?h=3Dnext-20211029&id=3D2f64acf6b653d01fbdc92a69=
3f12bbf71a205926

"Notice: this object is not reachable from any branch." because it
kept changing the hash since it's in the -mm tree.

> > That would explain it!  Feel free to resend once the functionality is
> > more generally available.
>
> +kasan-dev@googlegroups.com mailing list
>
> I found the full commit with kasan_record_aux_stack_noalloc() implementat=
ion:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?h=3Dnext-20211029&id=3D2f64acf6b653d01fbdc92a693f12bbf71a205926
>
> but it calls kasan_save_stack() with second bool argument, and
> kasan_save_stack() accepts only 1 argument:
> https://elixir.bootlin.com/linux/latest/source/mm/kasan/common.c#L33
> so I am lost and can't comment on any of the Paul's questions re
> interrupts/spinlocks.

None of the kasan_record_aux_stack_noalloc() code and its dependencies
were in mainline yet. I think it landed a few days ago, but too late
for the patches here.
