Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2B7C77B73
	for <rcu@archiver.kernel.org>; Tue,  2 May 2023 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjEBQXL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 May 2023 12:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjEBQXG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 May 2023 12:23:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D8010E4
        for <rcu@vger.kernel.org>; Tue,  2 May 2023 09:23:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51f6461af24so2715200a12.2
        for <rcu@vger.kernel.org>; Tue, 02 May 2023 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683044582; x=1685636582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sovOqwrIvpc3Udkl2XR/7da3qmV6eimFoMB5GH5z78=;
        b=GFO3WUYMOdQgyfcLNJUfUVWHDfavOAD5IA6qkkl2GHs0nbO34FNyRAQUlsiiZ7JcF8
         c3yv0ylyn7PdCE+SMtCEL10r9P8JxWECRoR+a0L30jmp14+A1akJoQnM8lwvSgb/JMWW
         1pRSuBE5Hhnh9lcl4ppwPBt9GKRiaaOHLs78GRKjbP5wahg7fFKW06nNvhXzwV3/CIiT
         /+ikXolEoG6FeHMZ0LLPEZmBrUl3c8fV+z7vrVyoJiA4Eu1ngTHkrQRtgSyHTb0+pf+P
         F5EQX/ULr8b0JcuWkIMNA11WPPtCOqqT3DLEWWr7JfveG/y7viCv3G7n5BPDywddZjYF
         z+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683044582; x=1685636582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sovOqwrIvpc3Udkl2XR/7da3qmV6eimFoMB5GH5z78=;
        b=EV9ssfL2WDhhHjG2w4wx8xjwKgGvfnG25e8FCEuU7MMr9eDS2HAEvkXqyh81P6iksX
         Gp+RbCbnx5efdRQQQHblE/cNF2DJTy6Et5XMsxHc9DpX7gTQSqkXliXuAv/INsX/WnyY
         Ch9GYpzVqRgk0Q1l1HZ/Nh2Jz80CU3P4t6IfK4OGxyGjTTRmNj5uU2+Wit7h9pbNtjeT
         82/n2mXKamHzab+AJpcRlzTGLXNFcBJ6II2+WxSEd03oDGXPjD5ycxblJKsKa7Tmg7VO
         y7fisDH/NkshPNul5KONHmPHNG7wGDLaZ+kLKCCNl2/HbqioKKg+ALBlduHg3jvJS9vJ
         oRaA==
X-Gm-Message-State: AC+VfDwF+XF3eFwbpdoJOrhjOHFqaK+t5+Wnpnb/WDjbf49W0NgykVMC
        2Put5nPZ5yaAfxelsMDeHq6R7zQRk9f/HQAA9/M4i3Odyooggg==
X-Google-Smtp-Source: ACHHUZ7gwBq6IGwCeTzyiAoUiYGZ0hM77IvHSkbRuo+cuibhQ67kyvYBFZyHAUyIYoBaatagTyN+Ou1xcXAjRlfknvk=
X-Received: by 2002:a17:90a:bb0f:b0:249:842d:312f with SMTP id
 u15-20020a17090abb0f00b00249842d312fmr17951507pjr.4.1683044582054; Tue, 02
 May 2023 09:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2wTpG1dCU8GNTuiyj+2zkHxWgOF3j3Mqjk5BUgS6KADZA@mail.gmail.com>
 <439F943C-32E7-4FAA-8E35-15CA1CEC0A78@joelfernandes.org>
In-Reply-To: <439F943C-32E7-4FAA-8E35-15CA1CEC0A78@joelfernandes.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 3 May 2023 00:22:51 +0800
Message-ID: <CAABZP2yqu+vG+_c0MVC6gXa3X1nXVSWh44ucwJGnDGVC8WSECg@mail.gmail.com>
Subject: Re: [PATCH V2] rcu/torture replace wait_event with wait_event_idle
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thank Joel for your guidance ;-)

On Tue, May 2, 2023 at 11:53=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
>
>
> > On May 2, 2023, at 9:50 AM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > =EF=BB=BFOn Tue, May 2, 2023 at 9:40=E2=80=AFPM Paul E. McKenney <paulm=
ck@kernel.org> wrote:
> >>
> >>> On Tue, May 02, 2023 at 08:01:41AM +0800, zhouzhouyi@gmail.com wrote:
> >>> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >>>
> >>> In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
> >>> if kfree_loops is too big. Replace wait_event with wait_event_idle
> >>> to avoid false positive.
> >>>
> >>> Tested in the PPC VM of Open Source Lab of Oregon State University.
> >>>
> >>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> >>> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >>
> >> Good catch, thank you!
> >>
> >> However, this commit beat you to it:
> >>
> >> ef1ef3d47677 ("rcuscale: Move shutdown from wait_event() to wait_event=
_idle()")
> > You are very welcome ;-) Still, this is a very fruitful learning
> > process for me ;-)
>
> Speaking of learning, can you explain why it fixes the issue? ;-)
>
> Your change log lacked the real reason but that is Ok since change logs c=
an only tell you so much. I admit I myself did not know the reason till I r=
ead some code.
When I found "blocked for more than" report in console.log, I did a
grep in kernel source tree, and found check_hung_task will only be
invoked
from check_hung_uninterruptible_tasks when (state &
TASK_UNINTERRUPTIBLE) and !(state & TASK_WAKEKILL) and !(state &
TASK_NOLOAD),  so I send my first patch [1], and Paul tell me
wait_event_idle is the right answer, then I do a grep for recursively
expansion of macro wait_event_idle, which finally set current->state
to TASK_IDLE ((TASK_UNINTERRUPTIBLE | TASK_NOLOAD)), then I conclude
that check_hung_task will not be called. Yes,  _interruptible()
variant indicates that wakeups due to things like POSIX signals are
permitted, which are not our case.

I should investigate more on what wait_event_idle really means,
instead of merely grep and debug what wait_event_idle does.
I should write my change log more clearly and explain why wait_event_idle w=
orks.

I discovered [1] during the testing of the patch, this is also a very
fruitful learning process.

I will write my change log more indicative next time, and do better
work to our RCU community (and thanks for remove linux-kernel from CC
list ;-))

Thanks
Zhouyi
[1] Link: https://lore.kernel.org/lkml/CAABZP2yS5=3DZUwEZQ7iHkV0wDm_HgO8K-T=
eAhyJrZhavzKDa44Q@mail.gmail.com/T/
On Tue, May 2, 2023 at 11:53=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
>
>
> > On May 2, 2023, at 9:50 AM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > =EF=BB=BFOn Tue, May 2, 2023 at 9:40=E2=80=AFPM Paul E. McKenney <paulm=
ck@kernel.org> wrote:
> >>
> >>> On Tue, May 02, 2023 at 08:01:41AM +0800, zhouzhouyi@gmail.com wrote:
> >>> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >>>
> >>> In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
> >>> if kfree_loops is too big. Replace wait_event with wait_event_idle
> >>> to avoid false positive.
> >>>
> >>> Tested in the PPC VM of Open Source Lab of Oregon State University.
> >>>
> >>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> >>> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >>
> >> Good catch, thank you!
> >>
> >> However, this commit beat you to it:
> >>
> >> ef1ef3d47677 ("rcuscale: Move shutdown from wait_event() to wait_event=
_idle()")
> > You are very welcome ;-) Still, this is a very fruitful learning
> > process for me ;-)
>
> Speaking of learning, can you explain why it fixes the issue? ;-)
>
> Your change log lacked the real reason but that is Ok since change logs c=
an only tell you so much. I admit I myself did not know the reason till I r=
ead some code.
When I found "task xxx blocked for more than" report in console.log, I
did a grep in kernel source tree, and found check_hung_task will only
be invoked
from check_hung_uninterruptible_tasks when (state &
TASK_UNINTERRUPTIBLE) and !(state & TASK_NOLOAD),  so I send my first
patch [1], and Paul tell me wait_event_idle is the right answer, then
I do a grep for recursively expansion of macro wait_event_idle, which
finally set current->state to TASK_IDLE ((TASK_UNINTERRUPTIBLE |
TASK_NOLOAD)), then
I conclude that


[1] https://lore.kernel.org/lkml/1681264483-5208-1-git-send-email-zhouzhouy=
i@gmail.com/T/
>
> Quiz: why exactly does this all work out in the end even though the hung =
task detector saw it hung?
>
> Thanks,
>
>  - Joel
>
>
> >
> > Cheers
> > Zhouyi
> >>
> >>                                                        Thanx, Paul
> >>
> >>> ---
> >>> kernel/rcu/rcuscale.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> >>> index 91fb5905a008..d99c586939d1 100644
> >>> --- a/kernel/rcu/rcuscale.c
> >>> +++ b/kernel/rcu/rcuscale.c
> >>> @@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
> >>> static int
> >>> kfree_scale_shutdown(void *arg)
> >>> {
> >>> -     wait_event(shutdown_wq,
> >>> +     wait_event_idle(shutdown_wq,
> >>>                 atomic_read(&n_kfree_scale_thread_ended) >=3D kfree_n=
realthreads);
> >>>
> >>>      smp_mb(); /* Wake before output. */
> >>> --
> >>> 2.34.1
> >>>


[1] https://lore.kernel.org/lkml/1681264483-5208-1-git-send-email-zhouzhouy=
i@gmail.com/T/
>
> Quiz: why exactly does this all work out in the end even though the hung =
task detector saw it hung?
>
> Thanks,
>
>  - Joel
>
>
> >
> > Cheers
> > Zhouyi
> >>
> >>                                                        Thanx, Paul
> >>
> >>> ---
> >>> kernel/rcu/rcuscale.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> >>> index 91fb5905a008..d99c586939d1 100644
> >>> --- a/kernel/rcu/rcuscale.c
> >>> +++ b/kernel/rcu/rcuscale.c
> >>> @@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
> >>> static int
> >>> kfree_scale_shutdown(void *arg)
> >>> {
> >>> -     wait_event(shutdown_wq,
> >>> +     wait_event_idle(shutdown_wq,
> >>>                 atomic_read(&n_kfree_scale_thread_ended) >=3D kfree_n=
realthreads);
> >>>
> >>>      smp_mb(); /* Wake before output. */
> >>> --
> >>> 2.34.1
> >>>
