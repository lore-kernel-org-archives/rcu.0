Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D2C77B73
	for <rcu@archiver.kernel.org>; Tue,  2 May 2023 16:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjEBQad (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 May 2023 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjEBQad (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 May 2023 12:30:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481F1173C
        for <rcu@vger.kernel.org>; Tue,  2 May 2023 09:30:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b5465fb99so3209192b3a.1
        for <rcu@vger.kernel.org>; Tue, 02 May 2023 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683045032; x=1685637032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4opXW8bC+qbtx7mQU0PMceyHsyXzPaWkJ7L8puO8Wuk=;
        b=FmAGh2QXdB6Bx9OZftUQKxF+JR8XLzf746OKAWSfk+dX7XRVFTs24/BtYSA0r7VMFT
         Fh6xbMgF2csaTQR6Y9UkXrNrxJEpii7MZN6bUNa7Nuj383xr4wZNTdI2U9D+tNh83UgO
         97nDvBgbnerUHEZy3OXIoZRXmi7t0aEo/+fy4splAVVAG4xwPK7iwdd7wK9i7HRsiJDA
         W9DhXS4G7EFydszoyRIMARUrpWURNTdc3mowFQs0r1g0ETnkn3krw1cyGtoPwBVMhlJj
         UOkJuQHce231W/M7YNeQU1SVpF54R1WiKxSONsQrbil10QtS8Xrt2ST661HV6c/ll8YI
         O+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683045032; x=1685637032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4opXW8bC+qbtx7mQU0PMceyHsyXzPaWkJ7L8puO8Wuk=;
        b=BwaLbkWRqz6J6wLK1dlFqaBhevwJHmEQHpcdVy+zyLbDLpCPKucyRtOEH2385yKFEG
         G7JsU/PbQ4vsUn2O+qqCMb/oNItXEMG7wFu9/EfjolAMj+P7B+ySMIVFkQryRNUfgSNP
         SMeNzKxNPrWQr7pRLgtSZu9KBV5yYVe5QwnfRrfCRVEYZeBbEgZqYAb/2hlvd9i2fPUu
         fj6o5Aqe3w6jIUmEV4b9ULdDQCY6bUO63BvkRjs0Euo4sS0tfmwYID8rj2B2x6LhYcjQ
         mZ3dBNavIlXYkZIIjQ2r+fLWBCZGfpT80Mdtk5GirbB2fd1Aeqoe3++tvtv+I3mFpplt
         EDRA==
X-Gm-Message-State: AC+VfDxiwk/rPXMgOA9Ul1LXr3PK6b8kutD9+MhDqE103YXkCjs4fcoB
        O4FiDq7Rhj0+gtwZ7W3/GAtWAcGHOOrSNZpOdJ5gDea2x3iomg==
X-Google-Smtp-Source: ACHHUZ7NH+4tYN50lTeNolzxEZmXdWrUHXBoxxbzQkHM2Tb20w20xa2ydugBboxnXyMRcuu/bmZXgEK4LQtrnnjfoCs=
X-Received: by 2002:a05:6a20:258d:b0:ef:bd:3b with SMTP id k13-20020a056a20258d00b000ef00bd003bmr24959090pzd.55.1683045031583;
 Tue, 02 May 2023 09:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2wTpG1dCU8GNTuiyj+2zkHxWgOF3j3Mqjk5BUgS6KADZA@mail.gmail.com>
 <439F943C-32E7-4FAA-8E35-15CA1CEC0A78@joelfernandes.org>
In-Reply-To: <439F943C-32E7-4FAA-8E35-15CA1CEC0A78@joelfernandes.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 3 May 2023 00:30:20 +0800
Message-ID: <CAABZP2yjEzC3xrpQfrzRDigO0k_dz5auaRaEWUriUy=iZVzhbg@mail.gmail.com>
Subject: Re: [PATCH V2] rcu/torture replace wait_event with wait_event_idle
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sorry for the bad format of my previous email, there is always
something wrong when I press Ctrl+C and Ctrl+V in my browser.
Sorry for the inconvenience that I bring.

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
>
> Quiz: why exactly does this all work out in the end even though the hung =
task detector saw it hung?
When I found "blocked for more than" report in console.log, I did a
grep in kernel source tree, and found check_hung_task will only be
invoked
from check_hung_uninterruptible_tas
ks when (state & TASK_UNINTERRUPTIBLE) and !(state & TASK_WAKEKILL)
and !(state &
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

I discovered [2] during the testing of the patch, this is also a very
fruitful learning process.

I will write my change log more indicative next time, and do better
work to our RCU community (and thanks for remove linux-kernel from CC
list ;-))

Thanks
Zhouyi
[1] https://lore.kernel.org/lkml/1681264483-5208-1-git-send-email-zhouzhouy=
i@gmail.com/T/
[2] https://lore.kernel.org/lkml/CAABZP2yS5=3DZUwEZQ7iHkV0wDm_HgO8K-TeAhyJr=
ZhavzKDa44Q@mail.gmail.com/T/

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
