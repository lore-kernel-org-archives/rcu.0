Return-Path: <SRS0=zJ2d=4Y=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14838C10F25
	for <rcu@archiver.kernel.org>; Sat,  7 Mar 2020 03:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C712070A
	for <rcu@archiver.kernel.org>; Sat,  7 Mar 2020 03:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WF4b75xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCGDd2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:33:28 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42841 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGDd1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Mar 2020 22:33:27 -0500
Received: by mail-qt1-f175.google.com with SMTP id r6so3286154qtt.9
        for <rcu@vger.kernel.org>; Fri, 06 Mar 2020 19:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yWvC0kkBmOA3iFTKCQGyV2Z6IPkQjFiOBlLksK4/WcI=;
        b=WF4b75xXsJ7bXheJut50ZeKYt6rOXZItWoih1bMTVCYOp35Sc5K+pDKXId4BXS8D29
         RTb+LY7ycNwBWJNUl4ChZWOfmfE9NcBuPeXyk0zAURmlzFhOo293aiTbvcRzrCC7Iz1e
         hDe5F55IIAy3ZQlWQlYNXc2IMMTGtbndoZDmZgjP6VmHxC+YR4qQLpcQC8Qj8IdqdDSV
         1+0sGOUW7Ot7Snd8Fr9OtUhHjADJbXlHxWdpQeHwhh+9cLBg/K5kpBU/L7c/eA9i3kdp
         cHD7bsjFynfqnZ2h5w0ZSA+w4qVljTpYPdPUETJXCH+WFa1yZ/xCkyw3UV5UipSnmEIh
         1yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yWvC0kkBmOA3iFTKCQGyV2Z6IPkQjFiOBlLksK4/WcI=;
        b=FpdKXnzI5YQqZIwND8wqVP6bId9HuCwhtVCaPS1BUaBNV+6uU39CMo/AuT4xOe3Ahl
         UYS3zjZ3t7p2S5fnS93wbQTDXrbJ+Isseq70Xmp5rHdXv9mQe1di2WiuXeuDzFNXJUMS
         rlO+aYkqBOAuMwdNsv3M4ayCz/IeVvoDCAjd/EQ8t4CcDsJVxxk7pNDW3iDf6J7piQXJ
         tPOcoLS2SpfXJxR1bAFyk1RbTNNiR/qGkMnuJL/IwDqSSA6ym0Yhoxhycy1ifLdi+bqT
         PVowfaWc0MNzt/Y3JElry9iqcOndyG5bpbXkHMvWe0wPocqITtfMFzqt8r9RvRplPbeW
         NWzQ==
X-Gm-Message-State: ANhLgQ0tgofybtamgHERv2bvW9uVy9xdbBWas7zwlVpczRDzRelP9jeJ
        qgg5+5GIVdIcrwwolvwFAqrrZw==
X-Google-Smtp-Source: ADFU+vt5J+r0T8D+Mtv0eHCxm/U/E2qaELnto77SqaHWKdYT+AnfibJx+GhzROWnYastPlzlQ9KkGQ==
X-Received: by 2002:ac8:48c7:: with SMTP id l7mr5809284qtr.174.1583552003986;
        Fri, 06 Mar 2020 19:33:23 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 206sm5755555qkn.36.2020.03.06.19.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 19:33:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Hard lockups due to "tick/common: Make tick_periodic() check for
 missing ticks"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CA9BD318-A8C8-4F22-828A-65C355931A5C@lca.pw>
Date:   Fri, 6 Mar 2020 22:33:22 -0500
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F95F95DE-77D9-4A1D-AA5C-CAC165F6B4C8@lca.pw>
References: <CA9BD318-A8C8-4F22-828A-65C355931A5C@lca.pw>
To:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Mar 5, 2020, at 11:06 PM, Qian Cai <cai@lca.pw> wrote:
>=20

Using this config,

> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

Reverted the linux-next commit d441dceb5dce (=E2=80=9Ctick/common: Make =
tick_periodic() check for missing ticks=E2=80=9D)
fixed the lockup that could easily happen during boot.

>=20
> [    0.013514][    C0] NMI watchdog: Watchdog detected hard LOCKUP on =
cpu 0=20
> [    0.013514][    C0] Modules linked in:=20
> [    0.013514][    C0] irq event stamp: 64186318=20
> [    0.013514][    C0] hardirqs last  enabled at (64186317): =
[<ffffffff84c9b107>] _raw_spin_unlock_irq+0x27/0x40=20
> [    0.013514][    C0] hardirqs last disabled at (64186318): =
[<ffffffff84c8f384>] __schedule+0x214/0x1070=20
> [    0.013514][    C0] softirqs last  enabled at (267904): =
[<ffffffff85000447>] __do_softirq+0x447/0x766=20
> [    0.013514][    C0] softirqs last disabled at (267897): =
[<ffffffff842d1f16>] irq_exit+0xd6/0xf0=20
> [    0.013514][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.6.0-rc4-next-20200305+ #6=20
> [    0.013514][    C0] Hardware name: HP ProLiant BL660c Gen9, BIOS =
I38 10/17/2018=20
> [    0.013514][    C0] RIP: 0010:lock_is_held_type+0x12a/0x150=20
> [    0.013514][    C0] Code: 41 0f 94 c4 65 48 8b 1c 25 40 0f 02 00 48 =
8d bb 74 08 00 00 e8 77 c0 28 00 c7 83 74 08 00 00 00 00 00 00 41 56 9d =
48 83 c4 18 <44> 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 45 31 e4 eb c7 =
41 bc 01=20
> [    0.013514][    C0] RSP: 0000:ffffc9000628f9f8 EFLAGS: 00000082=20
> [    0.013514][    C0] RAX: 0000000000000000 RBX: ffff889880efc040 =
RCX: ffffffff8438b449=20
> [    0.013514][    C0] RDX: 0000000000000007 RSI: dffffc0000000000 =
RDI: ffff889880efc8b4=20
> [    0.013514][    C0] RBP: ffffc9000628fa20 R08: ffffed1108588a24 =
R09: ffffed1108588a24=20
> [    0.013514][    C0] R10: ffff888842c4511b R11: 0000000000000000 =
R12: 0000000000000000=20
> [    0.013514][    C0] R13: ffff889880efc908 R14: 0000000000000046 =
R15: 0000000000000003=20
> [    0.013514][    C0] FS:  0000000000000000(0000) =
GS:ffff888842c00000(0000) knlGS:0000000000000000=20
> [    0.013514][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033=20
> [    0.013514][    C0] CR2: ffff88a0707ff000 CR3: 0000000b72012001 =
CR4: 00000000001606f0=20
> [    0.013514][    C0] Call Trace:=20
> [    0.013514][    C0]  rcu_read_lock_sched_held+0xac/0xe0=20
> lock_is_held at include/linux/lockdep.h:361
> (inlined by) rcu_read_lock_sched_held at kernel/rcu/update.c:121
> [    0.013514][    C0]  ? rcu_read_lock_bh_held+0xc0/0xc0=20
> [    0.013514][    C0]  rcu_note_context_switcx186/0x3b0=20
> [    0.013514][    C0]  __schedule+0x21f/0x1070=20
> [    0.013514][    C0]  ? __sched_text_start+0x8/0x8=20
> [    0.013514][    C0]  schedule+0x95/0x160=20
> [    0.013514][    C0]  do_boot_cpu+0x58c/0xaf0=20
> [    0.013514][    C0]  native_cpu_up+0x298/0x430=20
> [    0.013514][    C0]  ? common_cpu_up+0x150/0x150=20
> [    0.013514][    C0]  bringup_cpu+0x44/0x310=20
> [    0.013514][    C0]  ? timers_prepare_cpu+0x114/0x190=20
> [    0.013514][    C0]  ? takedown_cpu+0x2e0/0x2e0=20
> [    0.013514][    C0]  cpuhp_invoke_callback+0x197/0x1120=20
> [    0.013514][    C0]  ? ring_buffer_record_is_set_on+0x40/0x40=20
> [    0.013514][    C0]  _cpu_up+0x171/0x280=20
> [    0.013514][    C0]  do_cpu_up+0xb1/0x120=20
> [    0.013514][    C0]  cpu_up+0x13/0x20=20
> [    0.013514][    C0]  smp_init+0x91/0x118=20
> [    0.013514][    C0]  kernel_init_freeable+0x221/0x4f8=20
> [    0.013514][    C0]  ? mark_held_locks+0x34/0xb0=20
> [    0.013514][    C0]  ? _raw_spin_unlock_irq+0x27/0x40=20
> [    0.013514][    C0]  ? start_kernel+0x876/0x876=20
> [    0.013514][    C0]  ? lockdep_hardirqs_on+0x1b0/0x2a0=20
> [    0.013514][    C0]  ? _raw_spin_unlock_irq+0x27/0x40=20
> [    0.013514][    C0]  ? rest_init+0x307/0x307=20
> [    0.013514][    C0]  kernel_init+0x  0.013514][    C0]  ? =
rest_init+0x307/0x307=20
> [    0.013514][    C0]  ret_from_fork+0x3a/0x50=20
>=20

We could have many slightly different traces,

[    0.000000][    T0] smpboot: CPU 8 Converting physical 0 to logical =
die 1
[    0.021496][    C0] NMI watchdog: Watchdog detected hard LOCKUP on =
cpu 0
[    0.021496][    C0] Modules linked in:
[    0.021496][    C0] irq event stamp: 53241496
[    0.021496][    C0] hardirqs last  enabled at (53241495): =
[<ffffffffa9c8c037>] _raw_spin_unlock_irq+0x27/0x40
[    0.021496][    C0] hardirqs last disabled at (53241496): =
[<ffffffffa9c80244>] __schedule+0x214/0x1070
[    0.021496][    C0] softirqs last  enabled at (88160): =
[<ffffffffaa000447>] __do_softirq+0x447/0x766
[    0.021496][    C0] softirqs last disabled at (88153): =
[<ffffffffa92d0c66>] irq_exit+0xd6/0xf0
[    0.021496][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.6.0-rc4+ #25
[    0.021496][    C0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 03/09/2018
[    0.021496][    C0] RIP: 0010:__asan_load8+0x0/0xa0
[    0.021496][    C0] Code: e8 03 0f b6 04 30 84 c0 74 c2 38 d0 0f 9e =
c0 84 c0 74 b9 ba 01 00 00 00 be 04 00 00 00 e8 c8 e3 ff ff 5d c3 66 0f =
1f 44 00 00 <55> 48 89 e5 48 8b 4d 08 eb 3a 0f 1f 00 48 b8 00 00 00 00 =
00 00 00
[    0.021496][    C0] RSP: 0018:ffffc900031779d8 EFLAGS: 00000082
[    0.021496][    C0] RAX: 000000000000000f RBX: ffff88820f118040 RCX: =
ffffffffa9386e1c
[    0.021496][    C0] RDX: ffff88820f1188b0 RSI: ffff8884534442d8 RDI: =
ffff88820f118938
[    0.021496][    C0] RBP: ffffc90003177a10 R08: ffffed1041e23009 R09: =
ffffed1041e23009
[    0.021496][    C0] R10: ffffed1041e23008 R11: 0000000000000000 R12: =
ffff88820f118928
[    0.021496][    C0] R13: ffff8884534442d8 R14: 0000000000000003 R15: =
ffff88820f118928
[    0.021496][    C0] FS:  0000000000000000(0000) =
GS:ffff888453400000(0000) knlGS:0000000000000000
[    0.021496][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.021496][    C0] CR2: ffff88887b9ff000 CR3: 0000000257c12000 CR4: =
00000000003406f0
[    0.021496][    C0] Call Trace:
[    0.021496][    C0]  ? match_held_lock+0x20/0x250
[    0.021496][    C0]  lock_unpin_lock+0x16a/0x260
[    0.021496][    C0]  ? lock_repin_lock+0x210/0x210
[    0.021496][    C0]  ? __kasan_check_read+0x11/0x20
[    0.021496][    C0]  ? pick_next_task_fair+0x3a6/0x6b0
[    0.021496][    C0]  __schedule+0xd4f/0x1070
[    0.021496][    C0]  ? firmware_map_remove+0xee/0xee
[    0.021496][    C0]  ? schedule+0xc9/0x160
[    0.021496][    C0]  schedule+0x95/0x160
[    0.021496][    C0]  do_boot_cpu+0x58c/0xaf0
[    0.021496][    C0]  native_cpu_up+0x298/0x430
[    0.021496][    C0]  ? common_cpu_up+0x150/0x150
[    0.021496][    C0]  bringup_cpu+0x44/0x310
[    0.021496][    C0]  ? timers_prepare_cpu+0x114/0x190
[    0.021496][    C0]  ? takedown_cpu+0x2e0/0x2e0
[    0.021496][    C0]  cpuhp_invoke_callback+0x197/0x1120
[    0.021496][    C0]  ? ring_buffer_record_is_set_on+0x40/0x40
[    0.021496][    C0]  _cpu_up+0x171/0x280
[    0.021496][    C0]  do_cpu_up+0xb1/0x120
[    0.021496][    C0]  cpu_up+0x13/0x20
[    0.021496][    C0]  smp_init+0x91/0x118
[    0.021496][    C0]  kernel_init_freeable+0x221/0x4f8
[    0.021496][    C0]  ? mark_held_locks+0x34/0xb0
[    0.021496][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
[    0.021496][    C0]  ? start_kernel+0x857/0x857
[    0.021496][    C0]  ? lockdep_hardirqs_on+0x1b0/0x2a0
[    0.021496][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
[    0.021496][    C0]  ? rest_init+0x307/0x307
[    0.021496][    C0]  kernel_init+0x11/0x139
[    0.021496][    C0]  ? rest_init+0x307/0x307
[    0.021496][    C0]  ret_from_fork+0x27/0x50

[    0.021458][    C0] NMI watchdog: Watchdog detected hard LOCKUP on =
cpu 0
[    0.021458][    C0] Modules linked in:
[    0.021458][    C0] irq event stamp: 55574034
[    0.021458][    C0] hardirqs last  enabled at (55574033): =
[<ffffffffa549d4d7>] _raw_spin_unlock_irq+0x27/0x40
[    0.021458][    C0] hardirqs last disabled at (55574034): =
[<ffffffffa5491754>] __schedule+0x214/0x1070
[    0.021458][    C0] softirqs last  enabled at (83640): =
[<ffffffffa5800447>] __do_softirq+0x447/0x766
[    0.021458][    C0] softirqs last disabled at (83623): =
[<ffffffffa4ad2196>] irq_exit+0xd6/0xf0
[    0.021458][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.6.0-rc4+ #13
[    0.021458][    C0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 03/09/2018
[    0.021458][    C0] RIP: 0010:check_memory_region+0x136/0x200
[    0.021458][    C0] Code: 00 eb 0c 49 83 c0 01 48 89 d8 49 39 d8 74 =
10 41 80 38 00 74 ee 4b 8d 44 0d 00 4d 85 c0 75 4d 4c 89 e3 48 29 c3 e9 =
3e ff ff ff <48> 85 db 74 2e 41 80 39 00 75 34 48 b8 01 00 00 00 00 fc =
ff df 49
[    0.021458][    C0] RSP: 0018:ffffc900031779e8 EFLAGS: 00000083
[    0.021458][    C0] RAX: fffff5200062ef48 RBX: 0000000000000001 RCX: =
ffffffffa4b94e16
[    0.021458][    C0] RDX: 0000000000000001 RSI: 0000000000000004 RDI: =
ffffc90003177a40
[    0.021458][    C0] RBP: ffffc90003177a00 R08: 1ffff9200062ef48 R09: =
fffff5200062ef48
[    0.021458][    C0] R10: fffff5200062ef48 R11: ffffc90003177a43 R12: =
fffff5200062ef49
[    0.021458][    C0] R13: ffffc90003177a80 R14: ffff888453444310 R15: =
ffff888453444308
[    0.021458][    C0] FS:  0000000000000000(0000) =
GS:ffff888453400000(0000) knlGS:0000000000000000
[    0.021458][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.021458][    C0] CR2: ffff88887b9ff000 CR3: 00000006e6c12000 CR4: =
00000000003406f0
[    0.021458][    C0] Call Trace:
[    0.021458][    C0]  __kasan_check_write+0x14/0x20
[    0.021458][    C0]  do_raw_spin_lock+0xe6/0x1e0
[    0.021458][    C0]  ? rwlock_bug.part.1+0x60/0x60
[    0.021458][    C0]  ? __schedule+0x227/0x1070
[    0.021458][    C0]  _raw_spin_lock+0x37/0x40
[    0.021458][    C0]  ? __schedule+0x227/0x1070
[    0.021458][    C0]  __schedule+0x227/0x1070
[    0.021458][    C0]  ? __sched_text_start+0x8/0x8
[    0.021458][    C0]  schedule+0x95/0x160
[    0.021458][    C0]  do_boot_cpu+0x58c/0xaf0
[    0.021458][    C0]  native_cpu_up+0x298/0x430
[    0.021458][    C0]  ? common_cpu_up+0x150/0x150
[    0.021458][    C0]  bringup_cpu+0x44/0x310
[    0.021458][    C0]  ? timers_prepare_cpu+0x114/0x190
[    0.021458][    C0]  ? takedown_cpu+0x2e0/0x2e0
[    0.021458][    C0]  cpuhp_invoke_callback+0x197/0x1120
[    0.021458][    C0]  ? ring_buffer_record_is_set_on+0x40/0x40
[    0.021458][    C0]  _cpu_up+0x171/0x280
[    0.021458][    C0]  do_cpu_up+0xb1/0x120
[    0.021458][    C0]  cpu_up+0x13/0x20
[    0.021458][    C0]  smp_init+0x91/0x118
[    0.021458][    C0]  kernel_init_freeable+0x221/0x4f8
[    0.021458][    C0]  ? mark_held_locks+0x34/0xb0
[    0.021458][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
[    0.021458][    C0]  ? start_kernel+0x876/0x876
[    0.021458][    C0]  ? lockdep_hardirqs_on+0x1b0/0x2a0
[    0.021458][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
[    0.021458][    C0]  ? rest_init+0x307/0x307
[    0.021458][    C0]  kernel_init+0x11/0x139
[    0.021458][    C0]  ? rest_init+0x307/0x307
[    0.021458][    C0]  ret_from_fork+0x27/0x50



