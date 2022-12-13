Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1553AC4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 22:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiLMWm0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 17:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLMWmY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 17:42:24 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105122539
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 14:42:23 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id g14so4899352ljh.10
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 14:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AznxZF09soYNwF7TYNQbtrA+Sn0DxeW/307peBBhTWg=;
        b=bn4qssgDsO3/vsqbMB5878YKOGxpG+bxkNjs44p53yF+FcZ03K+aML+iHweLoR2Cai
         e+OcGqmKPGdqJwSwCEDxioWB3T8cRqbJvZ8WhRFI4WKPuM+H0V4bokjNhJZ1E2WSFGfC
         SliBNttLMyNVa2aQBikTtJxb7cSHeI9A5a89s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AznxZF09soYNwF7TYNQbtrA+Sn0DxeW/307peBBhTWg=;
        b=N0+DFU3zey21J4lLh58TofivKrHgAib6kdFjaomjQJOa3bVx2Vmekd4Vll+hfHgjpV
         yMoFBNy9nF3tgmwS9MrgJTCO7sBNYgtgRcMpE6iTMEo5TuAZJLwsK/UfWt8fsJCGyeC/
         qGJ477GCMBdSjHNm5TvuuUBygL6K9JN3GOt03i77G3PlHp08E29q2bCMZxSrlMOcTJRG
         uuRHQ2i5cYZ9twq/GiISjiBJfihE72zSRHbSBEwGFCmLiQE3ydWO3datHh7YDfmdqfel
         eAIw3QJGD6gjsFpGax2k6fzjepO8/MmDI7O0Qh/0DUz+16WJt8qHvBAGamaeNZn/1k9V
         2WTQ==
X-Gm-Message-State: ANoB5pkctuRCx2HrcTig3/ql+GmjDjXn7DVVH7Q73m4OvSrq3isIQImf
        4gts3mXjdE2g4r5WANKEaKyu2wr5rkLmrlkDd9IqXUwOMOUhhQ==
X-Google-Smtp-Source: AA0mqf5AvI/J5O2+oBVG/mfQ/7d2xH/XNJlLcAUjdY5DIae+HXI7a+4jf44TBNSyqLcuF1mRu/64FUiQLvyc620xybQ=
X-Received: by 2002:a05:651c:4d0:b0:27a:b1d:5662 with SMTP id
 e16-20020a05651c04d000b0027a0b1d5662mr5716064lji.356.1670971342053; Tue, 13
 Dec 2022 14:42:22 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR=DvPhk5JWUe7gYHeVsn5d4Wba83x2UB9uqP0EURgk1g@mail.gmail.com>
In-Reply-To: <CAEXW_YR=DvPhk5JWUe7gYHeVsn5d4Wba83x2UB9uqP0EURgk1g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 13 Dec 2022 17:42:10 -0500
Message-ID: <CAEXW_YSWkmE_5AUxRbVZdAQwM8dJah7F-f1apsUGi75Tn6WsJg@mail.gmail.com>
Subject: Re: Please apply to v5.10 stable: 29368e093921 ("x86/smpboot: Move
 rcu_cpu_starting() earlier")
To:     stable <stable@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 13, 2022 at 12:17 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hello,
>
> Please apply to the stable v5.10 kernel, the commit: 29368e093921
> ("x86/smpboot:  Move rcu_cpu_starting() earlier").

While I am confident this fixes it, I started an overnight test of all
rcutorture scenarios. It cherry-picks cleanly.

I will test 5.4 as well as it applies there.

 - Joel

>
> It made it into the mainline in 5.11.  I am able to reproduce the
> following splat without it on v5.10 stable, which is identical to the
> one that the commit fixed:
>
> [   42.628511] =============================
> [   42.628512] WARNING: suspicious RCU usage
> [   42.628513] 5.10.156+ #7 Not tainted
> [   42.628514] -----------------------------
> [   42.628516] kernel/locking/lockdep.c:3621 RCU-list traversed in
> non-reader section!!
> [   42.628516]
> [   42.628517] other info that might help us debug this:
> [   42.628518]
> [   42.628519]
> [   42.628519] RCU used illegally from offline CPU!
> [   42.628520] rcu_scheduler_active = 1, debug_locks = 1
> [   42.628521] no locks held by swapper/1/0.
> [   42.628522]
> [   42.628522] stack backtrace:
> [   42.628523] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.156+ #7
> [   42.628540] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [   42.628541] Call Trace:
> [   42.628541]
> [   42.628542] =============================
> [   42.628543] WARNING: suspicious RCU usage
> [   42.628544] 5.10.156+ #7 Not tainted
> [   42.628561] -----------------------------
> [   42.628563] kernel/kprobes.c:300 RCU-list traversed in non-reader section!!
> [   42.628563]
> [   42.628564] other info that might help us debug this:
> [   42.628565]
> [   42.628566]
> [   42.628567] RCU used illegally from offline CPU!
> [   42.628568] rcu_scheduler_active = 1, debug_locks = 1
> [   42.628569] no locks held by swapper/1/0.
> [   42.628570]
> [   42.628570] stack backtrace:
> [   42.628571] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.156+ #7
> [   42.628573] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [   42.628573] Call Trace:
> [   42.628574]  dump_stack+0x77/0x9b
> [   42.628575]  __is_insn_slot_addr+0x156/0x170
> [   42.628576]  kernel_text_address+0xb1/0xe0
> [   42.628577]  ? get_stack_info+0x2b/0x80
> [   42.628578]  __kernel_text_address+0x9/0x40
> [   42.628578]  show_trace_log_lvl+0x223/0x2f0
> [   42.628579]  ? dump_stack+0x77/0x9b
> [   42.628580]  dump_stack+0x77/0x9b
> [   42.628581]  __lock_acquire.cold+0x326/0x330
> [   42.628581]  lock_acquire+0xbd/0x2a0
> [   42.628582]  ? vprintk_emit+0x6c/0x310
> [   42.628583]  _raw_spin_lock+0x27/0x40
> [   42.628584]  ? vprintk_emit+0x6c/0x310
> [   42.628584]  vprintk_emit+0x6c/0x310
> [   42.628585]  printk+0x63/0x7e
> [   42.628586]  start_secondary+0x1c/0xf0
> [   42.628587]  secondary_startup_64_no_verify+0xc2/0xcb
> [   42.628588]  dump_stack+0x77/0x9b
> [   42.628588]  __lock_acquire.cold+0x326/0x330
> [   42.628589]  lock_acquire+0xbd/0x2a0
> [   42.628590]  ? vprintk_emit+0x6c/0x310
> [   42.628591]  _raw_spin_lock+0x27/0x40
> [   42.628591]  ? vprintk_emit+0x6c/0x310
> [   42.628592]  vprintk_emit+0x6c/0x310
>
> Thanks,
>
>  - Joel
