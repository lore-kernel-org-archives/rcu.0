Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11512C4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 17:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiLMRRf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 12:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiLMRRe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 12:17:34 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6F20BE8
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 09:17:33 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z4so3984298ljq.6
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 09:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zxE5lRszqVM0ouHR0vbvVZ4o1ASwrAhhJIoATFIJCtw=;
        b=AsanEacweZDmYofQrypHGYVQOYQhWMaQ7DPTbTDeAqGm981okOHeLFgqt8+bPsalFC
         YQbr+zOzUQoXjCvCeRdW7KjI3GLRCQ1oliWiRi+imvIXQgLs/KON33vHPcuaIF2lK2jh
         ORLobf+h6t/ybb2R2gUGmyFh0waeyLQYzhMzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxE5lRszqVM0ouHR0vbvVZ4o1ASwrAhhJIoATFIJCtw=;
        b=bj4e4JK+uasVAEsnVQvozpiq/J2z5B3FygStw1xxYJW8tknjqpGygZEfzB+aVNtAYh
         8KLk7JJZNzxNlPSX2mb5WCX6fB2HZkvgiEKZ0u+2AO8WmoVc2k4rrZNfk2LEPAJzOqgS
         LWiVzBZ8tk1MranQozWQK60lzlGKP6DBBeBSh1woie04laizOojmy4D9MdtK0eGbt3yk
         5u4mP5bGStUSQONeTCWxJ7KYQoyyEGUrjWaonvEQT2B5uW1DZwV81EMEXzg6oL25KFgy
         D2bdEuYRGe2Fk/3VkPDse/thiqN+6sieFFgMRdDXbjGgPlgAsqjsxBA6ZXWfweMve2rV
         P5gA==
X-Gm-Message-State: ANoB5pkH17V+JDUyw6GWFiCzxl1gtWkXbYFSI7qKa+wxF5OPKiUH6Yz6
        /h96Z2ktSD5VcYsF++5ebjyWQDLFqN4dMRDxGEeA7UmZcl41NbBJ
X-Google-Smtp-Source: AA0mqf7PmojIa/MT3BQvSbSqqZ1O3bxkA4hdVH4RRavcZHM03v32wnRjGtbnouskp7AfYdJTHFDcAYKcdQsgm2bADVU=
X-Received: by 2002:a05:651c:90a:b0:277:309:73cb with SMTP id
 e10-20020a05651c090a00b00277030973cbmr32805994ljq.371.1670951851591; Tue, 13
 Dec 2022 09:17:31 -0800 (PST)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 13 Dec 2022 12:17:20 -0500
Message-ID: <CAEXW_YR=DvPhk5JWUe7gYHeVsn5d4Wba83x2UB9uqP0EURgk1g@mail.gmail.com>
Subject: Please apply to v5.10 stable: 29368e093921 ("x86/smpboot: Move
 rcu_cpu_starting() earlier")
To:     stable <stable@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,

Please apply to the stable v5.10 kernel, the commit: 29368e093921
("x86/smpboot:  Move rcu_cpu_starting() earlier").

It made it into the mainline in 5.11.  I am able to reproduce the
following splat without it on v5.10 stable, which is identical to the
one that the commit fixed:

[   42.628511] =============================
[   42.628512] WARNING: suspicious RCU usage
[   42.628513] 5.10.156+ #7 Not tainted
[   42.628514] -----------------------------
[   42.628516] kernel/locking/lockdep.c:3621 RCU-list traversed in
non-reader section!!
[   42.628516]
[   42.628517] other info that might help us debug this:
[   42.628518]
[   42.628519]
[   42.628519] RCU used illegally from offline CPU!
[   42.628520] rcu_scheduler_active = 1, debug_locks = 1
[   42.628521] no locks held by swapper/1/0.
[   42.628522]
[   42.628522] stack backtrace:
[   42.628523] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.156+ #7
[   42.628540] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[   42.628541] Call Trace:
[   42.628541]
[   42.628542] =============================
[   42.628543] WARNING: suspicious RCU usage
[   42.628544] 5.10.156+ #7 Not tainted
[   42.628561] -----------------------------
[   42.628563] kernel/kprobes.c:300 RCU-list traversed in non-reader section!!
[   42.628563]
[   42.628564] other info that might help us debug this:
[   42.628565]
[   42.628566]
[   42.628567] RCU used illegally from offline CPU!
[   42.628568] rcu_scheduler_active = 1, debug_locks = 1
[   42.628569] no locks held by swapper/1/0.
[   42.628570]
[   42.628570] stack backtrace:
[   42.628571] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.156+ #7
[   42.628573] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[   42.628573] Call Trace:
[   42.628574]  dump_stack+0x77/0x9b
[   42.628575]  __is_insn_slot_addr+0x156/0x170
[   42.628576]  kernel_text_address+0xb1/0xe0
[   42.628577]  ? get_stack_info+0x2b/0x80
[   42.628578]  __kernel_text_address+0x9/0x40
[   42.628578]  show_trace_log_lvl+0x223/0x2f0
[   42.628579]  ? dump_stack+0x77/0x9b
[   42.628580]  dump_stack+0x77/0x9b
[   42.628581]  __lock_acquire.cold+0x326/0x330
[   42.628581]  lock_acquire+0xbd/0x2a0
[   42.628582]  ? vprintk_emit+0x6c/0x310
[   42.628583]  _raw_spin_lock+0x27/0x40
[   42.628584]  ? vprintk_emit+0x6c/0x310
[   42.628584]  vprintk_emit+0x6c/0x310
[   42.628585]  printk+0x63/0x7e
[   42.628586]  start_secondary+0x1c/0xf0
[   42.628587]  secondary_startup_64_no_verify+0xc2/0xcb
[   42.628588]  dump_stack+0x77/0x9b
[   42.628588]  __lock_acquire.cold+0x326/0x330
[   42.628589]  lock_acquire+0xbd/0x2a0
[   42.628590]  ? vprintk_emit+0x6c/0x310
[   42.628591]  _raw_spin_lock+0x27/0x40
[   42.628591]  ? vprintk_emit+0x6c/0x310
[   42.628592]  vprintk_emit+0x6c/0x310

Thanks,

 - Joel
