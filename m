Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89546C38147
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 22:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjARWBr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjARWBV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Jan 2023 17:01:21 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E395EFB4
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 14:01:20 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f34so393650lfv.10
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/f6GHQGzQEaiHB47dGSqaEpuNR0EbdyrEaRizrbLVA0=;
        b=FaErN5Pqdlxy0qi2w4z3TbV5KPeBng1AWRf3/T+joQdDeiOfMgGb02AXSP7BFOgzNu
         HzgGe1lvK3N2vm0qVTn042WPAM7bvYLKphXNY4nhphVuDis/L6EyueD58oa5uX5xVquQ
         ITTXocDdKTSBySCN89sVK6OY+iNu2jlnLfdY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/f6GHQGzQEaiHB47dGSqaEpuNR0EbdyrEaRizrbLVA0=;
        b=o4eVf0fLWWm4M/w3H587aeY6mOcsrKsKf9kTtgOha4I9zkVsPNsEwjuXjlvahHV1Nu
         ScgqHfOp0KU9mrewAsjz0+CBWsl+g5/xX98TfhOOF0QjHyEZWZ/2P2KtDuReMf6wIv8R
         yIQ1ah1K6PwvG+AOxA1hD+ChnvMCle/S0E2grmfNd1RNi0qFjYuN+OrahddzjFfU0WcO
         gpEH9DschwBUDtpqC4boytA3Na0fTjzY9863WUx2sQ8em0VzURz2fRIvttgl2MPdmV67
         m9toyM0rUsXkNxgr5bFjsIy/SUnWS0d2jFReGRYnCKeGYED5pjTJHCESFwDAu/ZRIM4o
         JvFg==
X-Gm-Message-State: AFqh2kqv1ZzUApsHOwaQFeOH1SvWsbvvwmECrxkosCHdasCi8k6gn58I
        V9OQN48VltHzFhWHXEPg4U/HiRgfmlVG+jTzy/8435RPhsawD0c1
X-Google-Smtp-Source: AMrXdXtwkq16tyvOsTsOQ6/42AkK5wWYSgeBjL0sFolXiSCLs8+h8rkJR73J8McjhBLZiWOJAXRZyddLyyHX6OpK2vE=
X-Received: by 2002:ac2:5ec4:0:b0:4cb:3b:846e with SMTP id d4-20020ac25ec4000000b004cb003b846emr391003lfq.128.1674079278964;
 Wed, 18 Jan 2023 14:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org> <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1> <20230118165121.GB19026@willie-the-truck>
In-Reply-To: <20230118165121.GB19026@willie-the-truck>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 Jan 2023 22:01:07 +0000
Message-ID: <CAEXW_YQ=v0u+NFCwUcvMcYfsMXknb8YJrfGgKSW=dCA56Q+a0A@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hey Will,

On Wed, Jan 18, 2023 at 4:51 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 18, 2023 at 02:17:06AM +0000, Joel Fernandes wrote:
> >
> > I would be happier to forgive failure to offline housekeeping CPUs than
> > blanket forgiveness of CPU 0.  Especially given that I recently got
> > burned by a non-zero boot cpu.  ;-)
> >
> > But wouldn't it be even better for cpu_is_hotpluggable() to know the
> > NO_HZ_FULL rules of the road?
> >
> > > Adding Frederic to CC as well as we are talking about
> > > housekeeping/isolation stuff.
> >
> > But as you say, perhaps Frederic has a better idea.
> >
> > > > And topology_init() sets this based on platform_can_hotplug_cpu(cpu).
> > > > And this function sets CPU 0 as !cpu_is_hotpluggable() unless the
> > > > architecture specifies a .cpu_can_disable() function.
> > >
> > > Ah, that is 32-bit ARM code only. This issue is on 64-bit ARM (arch/arm64/).
> >
> > Apologies!  I will look more carefully at the pathnames next time!
> >
> > But maybe arm64 needs something similar?
>
> Just chiming quickly from the arm64 side here, but there's nothing in the
> architecture that precludes offlining CPU 0 and it certainly works on some
> platforms, so I'd be hesitant to rule it out entirely for testing.
>
> One reason why hotplug can fail in practice is if a trusted OS (i.e. code
> running on the secure side of the fence outside of Linux's view of the
> world) is resident on a core and rejects firmware requests to power it
> off. The PSCI code (drivers/firmware/psci/) should detect this and return
> -EPERM, although earlier in this thread there was mention of -EBUSY so it
> sounds like something else...

Thank you for the heads up on that. To give you context, I am
currently testing rcutorture on stable kernels 5.10, 5.15, 6.1 on my
ARM64 QC7180 board. I certainly don't want to hit the -EPERM in the
future on this or other ARM64 hardware. It would be great if
cpu_psci_cpu_can_disable() in arm64 can return false if hotplugging
causes -EPERM indefinitely. Then we do not need to make any changes.
This is similar to the idea Paul mentioned in an earlier thread where
the ARCH can disable the hotplug and make it clear the CPU removal is
off limits.

Meanwhile, I am also looking into whether we can make the housekeeping
CPU (returning -EBUSY) offlining be encoded somehow in the
cpu_is_hotpluggable() logic (also an idea from Paul). That appears to
not be arch code related though.

Thanks,

- Joel
