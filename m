Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD24C54EBE
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 00:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjAQAha (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 19:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjAQAh3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 19:37:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE52A178
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 16:37:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso32574195pjf.1
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 16:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WC1Ldt+LH+xzOQXE7y0o7+Kw/GsMOUnmHVyiZCxO2zg=;
        b=LyOqemCSBIN6lX5oshczPEJKwto0WiIlVI0fCJvqAf+Ny+rpqCpbVE4Q6R9dDPYMpw
         q+JeSvi/UT1Ssrb4Gl6FlelrLD2mhLnHXnTXCLHyRmzLeZWIKV7QBeqaLbGwzykwZBkp
         ngFyh3Wpd96U/EJDRLB6PxRtq7X7HRTbnC2/IkLrO68uCgQuvmiu55y4mvLnfFWiaKA1
         n72Nnn0nuslktm/q9k83LQoa3MGHvlhwf/vRrc4hL5jcGt2BO4aVAqWEXhNuxvpMr8ec
         ofHjvRvoDlCnmPj5cozg7HARoWBJbuElZ8BbsMO1Bx9l2MGqAlyG9IuViYcO70BMxgVC
         luWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WC1Ldt+LH+xzOQXE7y0o7+Kw/GsMOUnmHVyiZCxO2zg=;
        b=tKcWxKppJMlXQjrVx/Bcsl75p87OJUbG0M6HZF58DdiFZpu6Ut8Bz1MmFThV0xRNUZ
         5SK2KRORPUQNx3XPNpUScVphl2s52J2Gw5AfBkjIlzLYqraYY0gjwprVHRHAuTYk1s8x
         mPxBWEezbAqGPK++llGAJCMDkIXUcM8DLFi6pb0Ny3/qfG+PgpO1GfmSvO+yPb3vsXtI
         JHaubuWflWbvJg/VA6msg5BCEC5Biu4RQiZw4A6yJaUDfhZkrUy4AMEISs+IcELq4mAI
         6yjn8VzSz7YH/ZgZgHuodYB7vSotwu0dAqIlIl8izJS98eXgH5xA4wcjJxRSx/6Lildo
         v5Cg==
X-Gm-Message-State: AFqh2koJCmf8aTUMRE+/MaGk4rHvbQiK6585hZPuzTxC2OkjI8P9YgzI
        UH9C3Hi/SUiyncJTqu8PtadnYd3uXFeHDdl82i9SWLGVcrFtRw==
X-Google-Smtp-Source: AMrXdXsqUhAEJzArmLRX32swjr3w56ggl7r60Mu+NeK4u3JFPKzllh/IfRX6qtAAVphrD+vFQKa3UTfw2RNvgPgO7Qo=
X-Received: by 2002:a17:903:2284:b0:193:39c4:cf54 with SMTP id
 b4-20020a170903228400b0019339c4cf54mr94724plh.48.1673915847638; Mon, 16 Jan
 2023 16:37:27 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
 <CAABZP2xnCCfCf5DLQuiTXBVbpEgsoedqxA8JsWBLs4SyLOLuFw@mail.gmail.com>
 <CAEXW_YQsUN_80FiXcts+5KgWo999KXWZDbkuPjmFCb8LiiLBzw@mail.gmail.com> <Y8Xoi3UvMs+Oy78O@google.com>
In-Reply-To: <Y8Xoi3UvMs+Oy78O@google.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 17 Jan 2023 08:37:16 +0800
Message-ID: <CAABZP2z50Fbs2rh4j2ToH-0hGfDamzQF3SoxxniC5LrXZ=Ja+A@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 8:15 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > Hi Zhouyi,
> >
> > On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > >
> > [..]
> > > On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > Hello,
> > > > I am seeing -EBUSY returned a lot during torture_onoff() when running
> > > > rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > > > also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> > > >
> > > > This causes warnings in torture tests:
> > > > [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > >
> > > > Full kernel log here:
> > > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> > > >
> > > > Any ideas on why this is happening and only for CPU 0 (presumably the
> > > > boot CPU)? I'd personally need these warnings to go away for my tests
> > > > as this causes rcutorture's tests to not cleanly pass for me. It
> > > > appears remove_cpu() -> device_offline() is what returns the error.
> > > >
> > > I guess this probably because CPU 0 is the tick_do_timer_cpu in
> > > nohz_full mode, which prevent that cpu from
> > > going offline [1]. We have discussed this topic, but there is no
> > > agreement on how to solve it yet.
> >
> > But I am seeing the issue in TRACE02 config which is:
> > CONFIG_NO_HZ_IDLE=y
> > # CONFIG_NO_HZ_FULL is not set
> >
> > So that is not NO_HZ_FULL:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/console.log.diags/
> > However, I can't seem to find the full kernel logs for that.
> >
> > Also, other than the TRACE02 fail, I only see the issue with configs
> > with CONFIG_NO_HZ_FULL=y
> >
> > Can you try TRACE02 specifically, and see if you can reproduce the
> > same issue on your setup? Meanwhile, I'll try to trace what is
> > returning the -EBUSY.
I am trying TRACE02 on my X86_64 machine using cross compile and
qemu-system-aarch64 now, my equipment is limited, but hope I can be of
beneficial to the community ;-)
>
> How about something simple like the following? (untested)
>
> ---8<-----------------------
>
> diff --git a/kernel/torture.c b/kernel/torture.c
> index bc8fb361efc0..cd64110694c0 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
>                         // PCI probe frequently disables hotplug during boot.
>                         (*n_offl_attempts)--;
>                         s = " (-EBUSY forgiven during boot)";
> +               } else if (tick_nohz_full_running && ret == -EBUSY) {
> +                       (*n_offl_attempts)--;
> +                       s = " (-EBUSY forgiven if nohz_full is running)";
 Fantastic fix!! thus we can fix the time keeper cpu torture problem
without touch the time keeper code.

Thanks
Zhouyi
>                 }
>                 if (verbose)
>                         pr_alert("%s" TORTURE_FLAG
