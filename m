Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C62DC46467
	for <rcu@archiver.kernel.org>; Mon, 16 Jan 2023 22:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjAPWnT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 17:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjAPWnS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 17:43:18 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B2D2387F
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 14:43:17 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y19so10115625ljq.7
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFItsAc0yAK/mg8krnPXwMCaEzlI1PgLaCB9Y1SfUcw=;
        b=BK6o9EOOqXyBDhlFiR4U5WltpdX10MbbJ6JrBzs6UaZTo5MdvMoX5eX6F+7yTYDdD6
         346zOSNpSWCKq6alGUVXjCzBoXRatoUij2Qvbq1HRi+imiNlFbUtRlUKnXTmBmDMKdrv
         h/yRKaSdN41fNY+XiPf0jYZTywLbJe/N5V/Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFItsAc0yAK/mg8krnPXwMCaEzlI1PgLaCB9Y1SfUcw=;
        b=adUh4TN1esPgj+q7nosI6Q0CaaX2VftRXRPpITWv8w7NtbSXq03VVSaZ0iJVxqjFYT
         l01A4qLAii0jgi9r5kLg/ye/h8plAe6m9P+t7teqipXbZc9dqdcpdU3J3V9JEfXxOspz
         VGY4JrgjNzD5Bu0Byg8yiDwxo0AquV5SKUd5+PIiC+pbGkVYv0mo7Imjg/STDmYmDex+
         JiKwGz0kD4mlj0VSzpVd+fiwngP6dak0pmj4Pnx6WOZ2MV6INnEiZVr9qbH62aK1EOs9
         LFBBU0jNV+Gq+fpXr0rHtr6oterhluERp7Af00DgWtf9KTGm/6lJF0sKRxi/zdo+q0g5
         8Gbg==
X-Gm-Message-State: AFqh2kqi8ZOGReSRp+orsSYs2tMrvqQqbMG//vYL00HAGAL0VaIylh7n
        ikNij93w/d5GFtW/xyYal8W9GtYy2+swz26/7i4OqA==
X-Google-Smtp-Source: AMrXdXs7nVti3bLG8Lk0H7OXczVsnq3074gRDCbZW+wvMGSky2TezBAvnQGiDuDOBCo0K+t+BruTGRRHPeTtfXUjl2s=
X-Received: by 2002:a2e:7019:0:b0:284:6390:1f8 with SMTP id
 l25-20020a2e7019000000b00284639001f8mr130379ljc.167.1673908995635; Mon, 16
 Jan 2023 14:43:15 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
 <864jsqnyql.wl-maz@kernel.org>
In-Reply-To: <864jsqnyql.wl-maz@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Jan 2023 17:43:03 -0500
Message-ID: <CAEXW_YRqktsV=onGsrp-DSxoWKRoZ4UabMpXg_k=LAAO7CtrMw@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Marc Zyngier <maz@kernel.org>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Marc,
Thanks a lot for taking a look.

On Mon, Jan 16, 2023 at 1:03 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Joel,
>
> On Mon, 16 Jan 2023 17:03:31 +0000,
> Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hello,
> > I am seeing -EBUSY returned a lot during torture_onoff() when running
> > rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> >
> > This causes warnings in torture tests:
> > [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> >
> > Full kernel log here:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> >
> > Any ideas on why this is happening and only for CPU 0 (presumably the
> > boot CPU)? I'd personally need these warnings to go away for my tests
> > as this causes rcutorture's tests to not cleanly pass for me. It
> > appears remove_cpu() -> device_offline() is what returns the error.
>
> I've taken your kernel for a ride as a KVM guest (probably similar to
> what you are doing), and saw the same thing (CPU0 not offlining):
>
> [   64.555845] Detected VIPT I-cache on CPU4
> [   64.556146] GICv3: CPU4: found redistributor 4 region 0:0x000000003ff70000
> [   64.556689] CPU4: Booted secondary processor 0x0000000004 [0x612f0290]
> [   69.823670] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> [   73.991960] psci: CPU7 killed (polled 0 ms)
> [   74.239626] rcu-torture: rcu_torture_read_exit: Start of episode
> [   74.243863] rcu-torture: rcu_torture_read_exit: End of episode
>
> I then tried v6.2-rc4 with defconfig + RCU_TORTURE and your command
> line, and CPU0 does seem to hotplug off correctly:

Interesting, can you try the Config fragment of the failing config on
the 6.2-rc4 [1] ?

[1] http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/ConfigFragment

Notable, it has the following which Zhoui said he was able to repro
with on another arch as well:
CONFIG_NO_HZ_IDLE=n
CONFIG_NO_HZ_FULL=y

> [   47.217109] psci: CPU3 killed (polled 0 ms)
> [   52.241009] Detected VIPT I-cache on CPU3
> [   52.241227] cacheinfo: Unable to detect cache hierarchy for CPU 3
> [   52.241481] GICv3: CPU3: found redistributor 3 region 0:0x000000003ff50000
> [   52.241849] CPU3: Booted secondary processor 0x0000000003 [0x612f0290]
> [   56.337011] psci: CPU0 killed (polled 0 ms)
> [...]
> [  121.090339] rcu-torture: Free-Block Circulation:  922 920 919 918 917 916 914 913 912 911 0
> [  125.574311] Detected VIPT I-cache on CPU0
> [  125.574557] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [  125.574901] GICv3: CPU0: found redistributor 0 region 0:0x000000003fef0000
> [  125.575322] CPU0: Booted secondary processor 0x0000000000 [0x612f0290]
> [  130.176893] rcu-torture: rcu_torture_read_exit: Start of episode
> [  130.317001] psci: CPU0 killed (polled 0 ms)
> [...]
> [  225.588999] Detected VIPT I-cache on CPU0
> [  225.589224] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [  225.589535] GICv3: CPU0: found redistributor 0 region 0:0x000000003fef0000
> [  225.589946] CPU0: Booted secondary processor 0x0000000000 [0x612f0290]
>
> No such error is being reported.
>
> Is there anything special in your config that would help triggering
> this with the current tip of tree?

Perhaps, your config needs the options in the config fragment I mentioned above.

Thanks!

 - Joel
