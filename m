Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA45C433FE
	for <rcu@archiver.kernel.org>; Mon,  7 Dec 2020 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA9B233CF
	for <rcu@archiver.kernel.org>; Mon,  7 Dec 2020 12:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgLGMYY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Dec 2020 07:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgLGMYY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Dec 2020 07:24:24 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE49EC0613D2
        for <rcu@vger.kernel.org>; Mon,  7 Dec 2020 04:23:37 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id x13so4722224oto.8
        for <rcu@vger.kernel.org>; Mon, 07 Dec 2020 04:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6pk4jhfaBDxagsrjqdb98OOZTNvh3pSgPws7wibwpo=;
        b=b/Javx/Yso5ETEG1DyHBm95cEnc1pUIgVv1H2AJva36lbgk43gZb16ZvdcRcUTnLud
         b5iEOhXaTFCR3ZSOlhZLS0yhJdJy3zyssHm9MiqV67y1moqxd8392AB3tUo3GSropJ0g
         XepIRQyg03EgSZlWraWQgMFWab4oIeEpD8LyMhT9tazpjWTeqn6NJPUs7am/MPWZYL7A
         QPV0Nd8CfztiThSkiKTUbVtfcN2ZY1WWOxTIuiSFdeaenOUFuujh7/ujtDmbi6PH1WBL
         jtnwjjRnEwl0LIKdI6TfbKxQAQET9iKeEgH1+HkQilE7H0XkdFMnXCPTSoyJ6+eGx9c/
         wO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6pk4jhfaBDxagsrjqdb98OOZTNvh3pSgPws7wibwpo=;
        b=ig5HSkAhqYjp9NrA5XP+DD3DH3you5haF9T6N25JbSY98VGwgF5zKd4vqTg8XL8LTh
         O3jmUwxMGXDWvcVGzmHjEjAr7nbZcWRdnDL7CoMtQqv/oJMRMXT//qCSYhFTI1GtB0u2
         rH9qpISSo64ycOMvWokgdRMY8TSKGhP1zTliGY6a3FGQaPxwqoB7gjxI1RCKbBESHzUU
         JYVPDtGCUzNy8GzIQeEq+iqmokrhzygQstnHNMt4SAr04zfIh7t5a8sVlTO4fSNvST+y
         TjIofeTK8A4eBRBgBSsktrV6EUCAb/zVbH5sfTQp4DExZfQOtijyWRJzazxPhVt19Q66
         F5IA==
X-Gm-Message-State: AOAM532IISizNbTL28SL9Y7deTv+b0vNWvzJU/PdfbO7ySiwItIKBLZr
        SnGGx/uqI/kroZaspA8Ab/p0Hu3eVsm6n4aeijOEnA==
X-Google-Smtp-Source: ABdhPJxPu5BAYHCw8QYIy3IuypqC5dWWHnHvVd/9Dp2o3b6w+EXFELpPjZhRtxrNOEDF+wITXXmjPKiLvzouwbef5bQ=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr13034529otk.251.1607343816907;
 Mon, 07 Dec 2020 04:23:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsHo-9tmxCKGticDowF8e3d1RkcLamapOgMQqeP6OdEEg@mail.gmail.com>
 <CANpmjNPpOym1eHYQBK4TyGgsDA=WujRJeR3aMpZPa6Y7ahtgKA@mail.gmail.com>
 <87wnxw86bv.fsf@nanos.tec.linutronix.de> <87eek395oe.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eek395oe.fsf@nanos.tec.linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Dec 2020 13:23:25 +0100
Message-ID: <CANpmjNNdothEQfz6LFN_HHYFQPa6679+WoodMBvsZiPSLndEdw@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in tick_nohz_next_event / tick_nohz_stop_tick
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 6 Dec 2020 at 00:47, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sat, Dec 05 2020 at 19:18, Thomas Gleixner wrote:
> > On Fri, Dec 04 2020 at 20:53, Marco Elver wrote:
> > It might be useful to find the actual variable, data member or whatever
> > which is involved in the various reports and if there is a match then
> > the reports could be aggregated. The 3 patterns here are not even the
> > complete possible picture.
> >
> > So if you sum them up: 58 + 148 + 205 instances then their weight
> > becomes more significant as well.
>
> I just looked into the moderation queue and picked stuff which I'm
> familiar with from the subject line.

We managed to push (almost) everything that was still in private
moderation to public moderation, so now there's even more to look at:
https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce
:-)

> There are quite some reports which have a different trigger scenario,
> but are all related to the same issue.
>
>   https://syzkaller.appspot.com/bug?id=f5a5ed5b2b6c3e92bc1a9dadc934c44ee3ba4ec5
>   https://syzkaller.appspot.com/bug?id=36fc4ad4cac8b8fc8a40713f38818488faa9e9f4
>
> are just variations of the same problem timer_base->running_timer being
> set to NULL without holding the base lock. Safe, but insanely hard to
> explain why :)
>
> Next:
>
>   https://syzkaller.appspot.com/bug?id=e613fc2458de1c8a544738baf46286a99e8e7460
>   https://syzkaller.appspot.com/bug?id=55bc81ed3b2f620f64fa6209000f40ace4469bc0
>   https://syzkaller.appspot.com/bug?id=972894de81731fc8f62b8220e7cd5153d3e0d383
>   .....
>
> That's just the ones which caught my eye and all are related to
> task->flags usage. There are tons more judging from the subject
> lines.
>
> So you really want to look at them as classes of problems and not as
> individual scenarios.

Regarding auto-dedup: as you suggest, it'd make this straightforward
if we had the variable name -- it turns out that's not so trivial. I
think we need compiler support for that, or is there some existing
infrastructure that can just tell us the canonical variable name if it
points into a struct or global? For globals it's fine, but for
arbitrary pointers that point into structs, I don't see how we could
do it without compiler support e.g. mapping PC->variable name (we need
to map instructions back to the variable names they access).

Any precedence for this? [+Cc linux-toolchains@vger.kernel.org]

Thanks,
-- Marco
