Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7F5C4361A
	for <rcu@archiver.kernel.org>; Fri,  4 Dec 2020 19:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CDE22CA0
	for <rcu@archiver.kernel.org>; Fri,  4 Dec 2020 19:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgLDTEo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDTEo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Dec 2020 14:04:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93248C0613D1
        for <rcu@vger.kernel.org>; Fri,  4 Dec 2020 11:04:03 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d18so6922083edt.7
        for <rcu@vger.kernel.org>; Fri, 04 Dec 2020 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MqRGZy01kstwz9ClfAxBNg8au7mjb5Di2jtSuxAThnw=;
        b=cKh7YAPyiW5dF2YKcQ6YErWfHBKONF7uMnPY9TYmHN7gPmV7kfqvsO4K0lg++uClO4
         /NKlA32KStz5R5xgk/EmX5yO3AeBxOVahoO7Cr/jlnA8KqQqzxvURXxN06PLGzr6WMff
         onAd2r/QLhG3fZ+UTnXB7iwVosDOUPxQfGz4C8bJhE2yN1OhePi+9XpIiqRjOES4G6Us
         PH6bCU13CsY7mDMvTvYQ/b13hFDg5UwUmsOMVIFCogK/Kz+7mHZ64tLeW9PR81vJ+une
         J/od/fTCV8y1bBhUuty/kWa4a3dAtkQmR1L+3v7h8E1Ampsvk9MEVlznXOkGJ/x6L0eQ
         FnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MqRGZy01kstwz9ClfAxBNg8au7mjb5Di2jtSuxAThnw=;
        b=H/QLJAsQZ461xfCjop9j/BcdtBGzFHDiHrlQW/9coSVKbaiMR3TrFldka45go64ajd
         EUNA4hpGs2Qegyds0UtIewqpsbQXBo/bZKeJsjome3RJKX38dCT5EwdFvP86cHYExuq4
         h5xiArDD/xFRx4r034XyebCaF3QWrgUfgrKOMnAHfIxVhGq8m7M8gYhRWr0UVpmPj9lk
         zRVNNT0RwQS7CKO47hy/kM4KagfStO+FAG0Z5B+zwQrtZ9IqVe3q8tFG8uF3/bDpldau
         MsJDRXO2hrxgXCsGHy3Sa3byJ8m6azyKkNqNu/IcSug78E8NRJgO+7m4Vnl5ppdiNaHl
         czqg==
X-Gm-Message-State: AOAM533/u65N3LObDNpl+5pr8J7dBe7jR8lRaAUDr0LQZ9tPfwhoeaHQ
        6HI/g0muNe2r0Z28dIgm4dD7FLsLCoCo76+iNeU6YQ==
X-Google-Smtp-Source: ABdhPJwhhMhsQr+VWTK66ALmYBtYgDGk3593gFW7FRQCJRH8kC4J57TPK3zbqIHhm1yF098qCGo9CPVlPYN9XjZIZrQ=
X-Received: by 2002:aa7:da8f:: with SMTP id q15mr8904092eds.239.1607108642178;
 Fri, 04 Dec 2020 11:04:02 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 5 Dec 2020 00:33:51 +0530
Message-ID: <CA+G9fYsHo-9tmxCKGticDowF8e3d1RkcLamapOgMQqeP6OdEEg@mail.gmail.com>
Subject: BUG: KCSAN: data-race in tick_nohz_next_event / tick_nohz_stop_tick
To:     open list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        lkft-triage@lists.linaro.org
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

LKFT started testing KCSAN enabled kernel from the linux next tree.
Here we have found BUG: KCSAN: data-race in tick_nohz_next_event /
tick_nohz_stop_tick

This report is from an x86_64 machine clang-11 linux next 20201201.
Since we are running for the first time we do not call this regression.

[   47.811425] BUG: KCSAN: data-race in tick_nohz_next_event /
tick_nohz_stop_tick
[   47.818738]
[   47.820239] write to 0xffffffffa4cbe920 of 4 bytes by task 0 on cpu 2:
[   47.826766]  tick_nohz_stop_tick+0x8b/0x310
[   47.830951]  tick_nohz_idle_stop_tick+0xcb/0x170
[   47.835571]  do_idle+0x193/0x250
[   47.838804]  cpu_startup_entry+0x25/0x30
[   47.842728]  start_secondary+0xa0/0xb0
[   47.846482]  secondary_startup_64_no_verify+0xc2/0xcb
[   47.851531]
[   47.853034] read to 0xffffffffa4cbe920 of 4 bytes by task 0 on cpu 3:
[   47.859473]  tick_nohz_next_event+0x165/0x1e0
[   47.863831]  tick_nohz_get_sleep_length+0x94/0xd0
[   47.868539]  menu_select+0x250/0xac0
[   47.872116]  cpuidle_select+0x47/0x50
[   47.875781]  do_idle+0x17c/0x250
[   47.879015]  cpu_startup_entry+0x25/0x30
[   47.882942]  start_secondary+0xa0/0xb0
[   47.886694]  secondary_startup_64_no_verify+0xc2/0xcb
[   47.891743]
[   47.893234] Reported by Kernel Concurrency Sanitizer on:
[   47.898541] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
5.10.0-rc6-next-20201201 #2
[   47.906017] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018

metadata:
    git_repo: https://gitlab.com/aroxell/lkft-linux-next
    target_arch: x86
    toolchain: clang-11
    git_describe: next-20201201
    download_url: https://builds.tuxbuild.com/1l8eiWgGMi6W4aDobjAAlOleFVl/

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/2002643#L2019

-- 
Linaro LKFT
https://lkft.linaro.org
