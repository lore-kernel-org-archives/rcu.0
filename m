Return-Path: <SRS0=vVGi=CK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E6EC433E6
	for <rcu@archiver.kernel.org>; Tue,  1 Sep 2020 06:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E04A208DB
	for <rcu@archiver.kernel.org>; Tue,  1 Sep 2020 06:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k05O1CXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgIAGvg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIAGve (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 1 Sep 2020 02:51:34 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523FFC0612B1
        for <rcu@vger.kernel.org>; Mon, 31 Aug 2020 23:51:34 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p185so43569vsp.8
        for <rcu@vger.kernel.org>; Mon, 31 Aug 2020 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJVkLzyJi04Epf6aBH5lz6bKk7X2j6MjpHh99vh3tPw=;
        b=k05O1CXOCcOlfcfdU3z4rW2tmZed1qDXT1nHJYpE4TCUBEKYn9Z7ZRp0H1eb3OEd9k
         u6ScsOP+4fBlWHmXYINIF5UM185cYCngas+Ht8VvapdAgiwsoYU4XfbHKgVjQHaisoNM
         BUA1QnDhp2WA0pMBvH0f9tB0ivXQqJs55WmfzoJZhm7wqFAA9F3J+T9ax9YqQg3C+7u1
         JaPdXqHpL6qWmnKL4m1vBgoCL48EAG4BUr1XStWWKLZylm6e3OemdM14Ox6OWxCZlD8A
         uGqEeJNVqxBcVvLMSCo/qOjkPsHC1nDBJVwrw8vLMXCa36aZ+hcWEI4EqUcDHL8zEzCO
         sdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJVkLzyJi04Epf6aBH5lz6bKk7X2j6MjpHh99vh3tPw=;
        b=bO5N2S0K3o/ETF3WdIccZlftDLGUxNHu1UTL88LaoS0Ya4aqHtAztgXslyi6393YSz
         2THITOoqAzJalmUdhs/Eo07g72Lm89B6dTaRxkvo+fdq8qE/zmhrvkB2++YfnY+MmDB9
         o1rNAwFZnIPfNKTXSV7e7qhLO0PZVzBC7abhsJSe/g97F5X1m8q87cop1dC45xMX4xmB
         8AnSZ+yVIp1PdhdcuGbA9lBkhfMGxbWzddR6ml3Za7BSHkMyh3IWJ++iH6SuotxgWuam
         04DaLjhC3JJwXcpccuXPRBVL6Glq6ksdiw+HPyWIujJbjAIE4TPp6X/8dBJyxy0FbV2H
         4OAA==
X-Gm-Message-State: AOAM532r95Xd+y3YC9aQtEqzOaZz1gtdJEJPLh1pbv6aPKCE7JWNyMYs
        FUtItbS1sn/C54r5z70njWVqWY7TIj4Ox5roy6gjsQ==
X-Google-Smtp-Source: ABdhPJxTsYsRrsxeEzeNEZ46oZmBr4Ci/2VXGuA8b437cHaYiJUrzF8DgaeA5xp5y/B0o8OTZQyOzMjHE/iQ3Kuet80=
X-Received: by 2002:a67:be08:: with SMTP id x8mr174967vsq.170.1598943093196;
 Mon, 31 Aug 2020 23:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72> <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
In-Reply-To: <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 08:50:57 +0200
Message-ID: <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
To:     paulmck@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

+ Re-adding Peter (seems like the original address was wrong)

On Tue, 1 Sep 2020 at 08:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Saravanna, Rafael, Lina
>
> On Mon, 31 Aug 2020 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Aug 31, 2020 at 12:02:31PM +0530, Naresh Kamboju wrote:
> > > While booting linux mainline kernel on arm64 db410c this kernel warning
> > > noticed.
> > >
> > > metadata:
> > >   git branch: master
> > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >   git commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
> > >   git describe: v5.9-rc3
> > >   make_kernelversion: 5.9.0-rc3
> > >   kernel-config:
> > > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-mainline/2965/config
> > >
> > > Boot log,
> > >
> > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
> > > [    0.000000] Linux version 5.9.0-rc3 (oe-user@oe-host)
> > > (aarch64-linaro-linux-gcc (GCC) 7.3.0, GNU ld (GNU Binutils)
> > > 2.30.0.20180208) #1 SMP PREEMPT Mon Aug 31 00:23:15 UTC 2020
> > > [    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
> > > <>
> > > [    5.299090] sdhci: Secure Digital Host Controller Interface driver
> > > [    5.299140] sdhci: Copyright(c) Pierre Ossman
> > > [    5.304313]
> > > [    5.307771] Synopsys Designware Multimedia Card Interface Driver
> > > [    5.308588] =============================
> > > [    5.308593] WARNING: suspicious RCU usage
> > > [    5.316628] sdhci-pltfm: SDHCI platform and OF driver helper
> > > [    5.320052] 5.9.0-rc3 #1 Not tainted
> > > [    5.320057] -----------------------------
> > > [    5.320063] /usr/src/kernel/include/trace/events/lock.h:37
> > > suspicious rcu_dereference_check() usage!
> > > [    5.320068]
> > > [    5.320068] other info that might help us debug this:
> > > [    5.320068]
> > > [    5.320074]
> > > [    5.320074] rcu_scheduler_active = 2, debug_locks = 1
> > > [    5.320078] RCU used illegally from extended quiescent state!
> > > [    5.320084] no locks held by swapper/0/0.
> > > [    5.320089]
> > > [    5.320089] stack backtrace:
> > > [    5.320098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
> > > [    5.346354] sdhci_msm 7864900.sdhci: Got CD GPIO
> > > [    5.346446] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > [    5.346452] Call trace:
> > > [    5.346463]  dump_backtrace+0x0/0x1f8
> > > [    5.346471]  show_stack+0x2c/0x38
> > > [    5.346480]  dump_stack+0xec/0x15c
> > > [    5.346490]  lockdep_rcu_suspicious+0xd4/0xf8
> > > [    5.346499]  lock_acquire+0x3d0/0x440
> > > [    5.346510]  _raw_spin_lock_irqsave+0x80/0xb0
> > > [    5.413118]  __pm_runtime_suspend+0x34/0x1d0
> > > [    5.417457]  psci_enter_domain_idle_state+0x4c/0xb0
> > > [    5.421795]  cpuidle_enter_state+0xc8/0x610
> > > [    5.426392]  cpuidle_enter+0x3c/0x50
> > > [    5.430561]  call_cpuidle+0x44/0x80
> > > [    5.434378]  do_idle+0x240/0x2a0
> >
> > RCU ignores CPUs in the idle loop, which means that you cannot use
> > rcu_read_lock() from the idle loop without use of something like
> > RCU_NONIDLE().  If this is due to event tracing, you should use the
> > _rcuidle() variant of the event trace statement.
>
> In the runtime suspend path, the runtime PM core calls
> device_links_read_lock() - if the device in question has any links to
> suppliers (to allow them to be suspended too).
>
> device_links_read_lock() calls srcu_read_lock().
>
> It turns out that the device in question (the CPU device that is
> attached to genpd) didn't have any links before - but that seems to
> have changed, due to the work done by Saravana (links become created
> on a per resource basis, parsed from DT during boot).
>
> >
> > Note also that Peter Zijlstra (CCed) is working to shrink the portion
> > of the idle loop that RCU ignores.  Not sure that it covers your
> > case, but it is worth checking.
>
> Thanks for letting me know. Let's see what Peter thinks about this then.
>
> Apologize for my ignorance, but from a cpuidle point of view, what
> does it mean using RCU_NONIDLE()? I guess we should avoid RCU_NONIDLE
> on bigger code paths?
>
> I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
> and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
> that's the easiest approach, at least to start with.
>
> Or do you have any other ideas?
>
> [...]
>
> Kind regards
> Uffe
