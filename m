Return-Path: <SRS0=NFG3=CS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6141CC433E2
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 04:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2AF21D43
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 04:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlBjRsfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIIE1t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIE1s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Sep 2020 00:27:48 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D8FC061573
        for <rcu@vger.kernel.org>; Tue,  8 Sep 2020 21:27:48 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id r78so362334vke.11
        for <rcu@vger.kernel.org>; Tue, 08 Sep 2020 21:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lmdiyj/70FAt1MqnYepgOMsvppkz9UCOyxgtuK4ZyWA=;
        b=LlBjRsfGVocQsRFr2x4XqQQ0Ty8BjXNNX5hLS9LfrwoJA6MjKUtE35EDCn/LBzS4CG
         aNr0+gOY0quhsgPcB14zVpaVykYjejPU+uhiJ5GRE3iwFomYPUGPGXf62ZIsjmZpPwFV
         lqVZbnRXUHReaVVOHTccZmTw1LSeAB4Opg+ydikg6vOnVf0WR9P1sRE+5yVCqwsTlfIw
         S13WUJRZ/w8lBOUSwV6ykm6lDc6ijVB3AGZ4jiP4o+Z2+ME/hKlmK/uNGE9YolYp2s0f
         eTScFsRpMbXXifxnWAdh+Fpnv/hOkPOW2npsPkA6FnuOFY0mpN525qDu/0fSzg9faqx4
         vWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lmdiyj/70FAt1MqnYepgOMsvppkz9UCOyxgtuK4ZyWA=;
        b=SbbnPpUBpsggix113ogESO/yXv7aZSFHAbpyIOo9a4sWyMxFuMl+XV7NcmdNCnT4vZ
         R6vrdfhK8L4IgzpkgrCKqrbGwMwTgDLGcvAlmSVV1w2R8qHWrwk0fcShC0BthwqCpShr
         59vpoCTOwELzaH581z5wyRAx/o23uV31UpUUJKF29ulCZII+cY2WYUPf8BOwTluTt9YZ
         D4J4pJiufZAKbDT8bHVKg/n2MPEXtCLyrpy/9yBsX9mj47SFq/OzgkST8fkq6A4OO//J
         pZtRNCF2K4/ta1LFmDdS5QVFw99tmPfOohqlgk/rHtwfI2YHlnt8hXlepPacPAYSuhS1
         tHBA==
X-Gm-Message-State: AOAM530OI/Zxvx9Wn5olZY5y+C7ehjnlr1h6nxTi8QrRAgC/AIR8dBxp
        WHbgpLSftgJoCblB6RCU/kCNoeoHBJHN0iz0nIFnZw==
X-Google-Smtp-Source: ABdhPJxgsedb4wzLubajLwc+AXqKhZq/N1Y5DdrQccSR11g4h11PRQvX+vIyEpJVxQq713ke0dbJ9eoL+b86mSCEpEo=
X-Received: by 2002:a1f:9f87:: with SMTP id i129mr1538929vke.46.1599625667666;
 Tue, 08 Sep 2020 21:27:47 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Sep 2020 09:57:36 +0530
Message-ID: <CA+G9fYvFOw2NFtUz7DT_2_bKfHPVo8Vrsc+F=ub_R+b1wXpQOQ@mail.gmail.com>
Subject: WARNING: suspicious RCU usage: include/trace/events/tlb.h:57
 suspicious rcu_dereference_check() usage!
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

While booting i386 with Linux next 20200908 tag kernel this warning noticed.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: dff9f829e5b0181d4ed9d35aa62d695292399b54
  git describe: next-20200908
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/853/config

warning log:
-----------------
[   11.451223] Write protecting kernel text and read-only data: 20800k
[   11.457522] Run /sbin/init as init process
[   11.463807] random: fast init done
[   11.471527]
[   11.473118] =============================
[   11.477129] WARNING: suspicious RCU usage
[   11.481135] 5.9.0-rc4-next-20200908 #1 Not tainted
[   11.485926] -----------------------------
[   11.489931] /usr/src/kernel/include/trace/events/tlb.h:57
suspicious rcu_dereference_check() usage!
[   11.498970]
[   11.498970] other info that might help us debug this:
[   11.498970]
[   11.506961]
[   11.506961] rcu_scheduler_active = 2, debug_locks = 1
[   11.513476] RCU used illegally from extended quiescent state!
[   11.519215] no locks held by swapper/0/0.
[   11.523217]
[   11.523217] stack backtrace:
[   11.527569] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.9.0-rc4-next-20200908 #1
[   11.534955] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   11.542345] Call Trace:
[   11.544792]  dump_stack+0x6d/0x8b
[   11.548112]  lockdep_rcu_suspicious+0xb2/0xd0
[   11.552473]  switch_mm_irqs_off+0x508/0x510
[   11.556658]  switch_mm+0x19/0x50
[   11.559890]  leave_mm+0x2d/0x40
[   11.563034]  acpi_idle_enter_bm+0x1c/0x120
[   11.567127]  acpi_idle_enter+0x13b/0x230
[   11.571049]  ? rcu_eqs_enter.constprop.87+0x9e/0x180
[   11.576008]  ? acpi_idle_enter_s2idle+0x50/0x50
[   11.580542]  cpuidle_enter_state+0x87/0x560
[   11.584732]  cpuidle_enter+0x27/0x40
[   11.588316]  do_idle+0x20b/0x2a0
[   11.591551]  cpu_startup_entry+0x25/0x30
[   11.595474]  rest_init+0x166/0x230
[   11.598881]  arch_call_rest_init+0xd/0x19
[   11.602893]  start_kernel+0x481/0x4a0
[   11.606562]  i386_start_kernel+0x48/0x4a
[   11.610485]  startup_32_smp+0x164/0x168
[   11.614338]
[   11.614339] =============================
[   11.614339] WARNING: suspicious RCU usage
[   11.614340] 5.9.0-rc4-next-20200908 #1 Not tainted
[   11.614340] -----------------------------
[   11.614341] /usr/src/kernel/include/trace/events/lock.h:37
suspicious rcu_dereference_check() usage!
[   11.614341]
[   11.614341] other info that might help us debug this:
[   11.614342]
[   11.614342]
[   11.614342] rcu_scheduler_active = 2, debug_locks = 1
[   11.614343] RCU used illegally from extended quiescent state!
[   11.614343] no locks held by swapper/0/0.
[   11.614343]
[   11.614344] stack backtrace:
[   11.614344] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.9.0-rc4-next-20200908 #1
[   11.614345] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   11.614345] Call Trace:
[   11.614345]  dump_stack+0x6d/0x8b
[   11.614346]  lockdep_rcu_suspicious+0xb2/0xd0
[   11.614346]  lock_acquire+0x2d8/0x340
[   11.614346]  _raw_spin_lock+0x27/0x40
[   11.614347]  ? vprintk_emit+0x57/0x2c0
[   11.614347]  vprintk_emit+0x57/0x2c0
[   11.614347]  vprintk_default+0x17/0x20
[   11.614348]  vprintk_func+0x4f/0xd0
[   11.614348]  printk+0x13/0x15
[   11.614348]  lockdep_rcu_suspicious+0x21/0xd0
[   11.614349]  switch_mm_irqs_off+0x508/0x510
[   11.614349]  switch_mm+0x19/0x50
[   11.614349]  leave_mm+0x2d/0x40
[   11.614350]  acpi_idle_enter_bm+0x1c/0x120
[   11.614350]  acpi_idle_enter+0x13b/0x230
[   11.614351]  ? rcu_eqs_enter.constprop.87+0x9e/0x180
[   11.614351]  ? acpi_idle_enter_s2idle+0x50/0x50
[   11.614351]  cpuidle_enter_state+0x87/0x560
[   11.614352]  cpuidle_enter+0x27/0x40
[   11.614352]  do_idle+0x20b/0x2a0
[   11.614352]  cpu_startup_entry+0x25/0x30
[   11.614353]  rest_init+0x166/0x230
[   11.614353]  arch_call_rest_init+0xd/0x19
[   11.614353]  start_kernel+0x481/0x4a0
[   11.614354]  i386_start_kernel+0x48/0x4a
[   11.614354]  startup_32_smp+0x164/0x168
[   11.614354]
[   11.614355] =============================
[   11.614355] WARNING: suspicious RCU usage
[   11.614356] 5.9.0-rc4-next-20200908 #1 Not tainted
[   11.614356] -----------------------------
[   11.614356] /usr/src/kernel/include/trace/events/lock.h:63
suspicious rcu_dereference_check() usage!
[   11.614357]
[   11.614357] other info that might help us debug this:
[   11.614357]
[   11.614358]
[   11.614358] rcu_scheduler_active = 2, debug_locks = 1
[   11.614358] RCU used illegally from extended quiescent state!
[   11.614359] 1 lock held by swapper/0/0:
[   11.614359]  #0: c82fd670 (logbuf_lock){-...}-{2:2}, at:
vprintk_emit+0x57/0x2c0
[   11.614361]
[   11.614361] stack backtrace:
[   11.614362] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.9.0-rc4-next-20200908 #1
[   11.614362] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   11.614362] Call Trace:
[   11.614363]  dump_stack+0x6d/0x8b
[   11.614363]  lockdep_rcu_suspicious+0xb2/0xd0
[   11.614364]  lock_release+0x23c/0x260
[   11.614364]  ? vprintk_emit+0x79/0x2c0
[   11.614364]  _raw_spin_unlock+0x16/0x30
[   11.614365]  vprintk_emit+0x79/0x2c0
[   11.614365]  vprintk_default+0x17/0x20
[   11.614365]  vprintk_func+0x4f/0xd0
[   11.614366]  printk+0x13/0x15
[   11.614366]  lockdep_rcu_suspicious+0x21/0xd0
[   11.614366]  switch_mm_irqs_off+0x508/0x510
[   11.614367]  switch_mm+0x19/0x50
[   11.614367]  leave_mm+0x2d/0x40
[   11.614367]  acpi_idle_enter_bm+0x1c/0x120
[   11.614368]  acpi_idle_enter+0x13b/0x230
[   11.614368]  ? rcu_eqs_enter.constprop.87+0x9e/0x180
[   11.614368]  ? acpi_idle_enter_s2idle+0x50/0x50
[   11.614369]  cpuidle_enter_state+0x87/0x560
[   11.614369]  cpuidle_enter+0x27/0x40
[   11.614369]  do_idle+0x20b/0x2a0
[   11.614370]  cpu_startup_entry+0x25/0x30
[   11.614370]  rest_init+0x166/0x230
[   11.614370]  arch_call_rest_init+0xd/0x19
[   11.614371]  start_kernel+0x481/0x4a0
[   11.614371]  i386_start_kernel+0x48/0x4a
[   11.614371]  startup_32_smp+0x164/0x168

Full test log,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200908/testrun/3171106/suite/linux-log-parser/test/check-kernel-warning-1743529/log


-- 
Linaro LKFT
https://lkft.linaro.org
