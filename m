Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6033C4332B
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 13:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9706F20663
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 13:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lczzNM/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCSN6g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:58:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38483 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgCSN6g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 09:58:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so1827754qtq.5
        for <rcu@vger.kernel.org>; Thu, 19 Mar 2020 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zpsFsYSzCOfqOuWpPb3b9hxjUuwywyqFl0+rBPv2Dv8=;
        b=lczzNM/POeYdIOYw8lw7DzVxh/aDxFdZw/pgsm33iA2OaFfr04pJi0dEslSmQaybCh
         +oh4W2RWTWUyqb9n07mp7dfOGMBO/UR5Gm69PyGPzFC0wLHAEQ2l7DoCrIrRR6wM+yq9
         6rIAnoBE9vyNCH7jBHeWl+1qd5Y8Vvr4ZispDiyrBFYN9OMml/rtGbB3011w8Q55zBdO
         fsmkQabh5joYQr6Bz6nJYip1acmjUNzyOhcwiE+tOx5jiK0BiFpJSgkblvS5er+Spr5m
         Hw+pR/t9yM8q0Y4IJhM0UvCmO42Bugv1EoifCBxIaXvx+v6NU7a4tSHUN9sPVvtX5nsQ
         sB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zpsFsYSzCOfqOuWpPb3b9hxjUuwywyqFl0+rBPv2Dv8=;
        b=qC0stByAIrW8fhrr2lq6UR6lT5UY8sq4wo6l1lk/kbpWoFqVsvKEWSR9GyAoG4Ofb+
         vOSulZgzSt9LFmm1eV1ktTy82mNMLRD97/xNarqDskpjjA78BWFVQsb18r9cmKr7Q33A
         KxV998nZZvEAmLryOx3gWboTeMzSIKho1a7RtJLcXbhaBQHP1zEWDUOlI2IdlBRP3fdX
         jsq0a/8ihJJbfVkcgtNIZwUC4yymjPZq5hNtPIdJA7vBgAN+jFK2CIYpJmgOZQoqBKrJ
         pcpYf/yTfKZ7qUIJ06ZvduwC2x/RDwjRDQi2Wzc9f/5LkMuEY9gz0Sm9ZacfdOKyPGLd
         4idA==
X-Gm-Message-State: ANhLgQ3xrrCFqlahakFOu9A/Lg1xQDEkfuI5GibQNx8zoRzhR7mLJgsV
        plS6IBl4SjqODaFh/0qtSmVaEg==
X-Google-Smtp-Source: ADFU+vuuB6VPg6HCy/mvAVVrsnBTxfpIm9D+O5bcoleKAd6MqKbQYA8huvY5AtRn54L6SBoqc+hVMQ==
X-Received: by 2002:ac8:43da:: with SMTP id w26mr2969253qtn.309.1584626313632;
        Thu, 19 Mar 2020 06:58:33 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u49sm1642931qtb.52.2020.03.19.06.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 06:58:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Hard lockups due to "tick/common: Make tick_periodic() check for
 missing ticks"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <F95F95DE-77D9-4A1D-AA5C-CAC165F6B4C8@lca.pw>
Date:   Thu, 19 Mar 2020 09:58:31 -0400
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11BEA1A5-2E93-4E01-A05C-A6BA73A74CEB@lca.pw>
References: <CA9BD318-A8C8-4F22-828A-65C355931A5C@lca.pw>
 <F95F95DE-77D9-4A1D-AA5C-CAC165F6B4C8@lca.pw>
To:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Mar 6, 2020, at 10:33 PM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On Mar 5, 2020, at 11:06 PM, Qian Cai <cai@lca.pw> wrote:
>>=20
>=20
> Using this config,
>=20
>> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
>=20
> Reverted the linux-next commit d441dceb5dce (=E2=80=9Ctick/common: =
Make tick_periodic() check for missing ticks=E2=80=9D)
> fixed the lockup that could easily happen during boot.


Thomas or Stephen, can you back out this patch from linux-next while =
Waiman is getting to the bottom of it?
I can still reproduce it as today.

[    0.021353][    T1] ... fixed-purpose events:   0
[    0.021353][    T1] ... event mask:             000000000000003f
[    0.021353][    T1] rcu: Hierarchical SRCU implementation.
[    0.021353][    T5] NMI watchdog: Enabled. Permanently consumes one =
hw-PMU counter.
[    0.021353][    T1] smp: Bringing up secondary CPUs ...
[    0.021353][    T1] x86: Booting SMP configuration:
[    0.021353][    T1] .... node  #0, CPUs:        #1
[    0.021353][    T1] .... node  #1, CPUs:    #2
[    0.021353][    T1]   #3
[    0.021353][    T1] .... node  #2, CPUs:    #4
[    0.021353][    T1]   #5
[    0.021353][    T1] .... node  #3, CPUs:    #6
[    0.021353][    T1]   #7
[    0.021353][    T1] .... node  #4, CPUs:    #8
[    0.000000][    T0] smpboot: CPU 8 Converting physical 0 to logical =
die 1
[    0.021353][    C0] NMI watchdog: Watchdog detected hard LOCKUP on =
cpu 0
[    0.021353][    C0] Modules linked in:
[    0.021353][    C0] irq event stamp: 51754775
[    0.021353][    C0] hardirqs last  enabled at (51754775): =
[<ffffffff936a8117>] _raw_spin_unlock_irq+0x27/0x40
[    0.021353][    C0] hardirqs last disabled at (51754774): =
[<ffffffff9369c394>] __schedule+0x214/0x1070
[    0.021353][    C0] softirqs last  enabled at (78480): =
[<ffffffff93a00447>] __do_softirq+0x447/0x766
[    0.021353][    C0] softirqs last disabled at (78463): =
[<ffffffff92cd2226>] irq_exit+0xd6/0xf0
[    0.021353][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.6.0-rc6-next-20200319 #1
[    0.021353][    C0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 03/09/2018
[    0.021353][    C0] RIP: 0010:lock_is_held_type+0x3e/0x150
[    0.021353][    C0] Code: 02 00 48 83 ec 18 48 89 7d d0 48 8d bb 74 =
08 00 00 89 75 c4 e8 23 fe 28 00 8b 8b 74 08 00 00 85 c9 0f 85 02 01 00 =
00 9c 41 5e <fa> 48 c7 c7 b4 8c 93 94 e8 05 fe 28 00 8b 15 23 b8 ba 01 =
85 d2 74
[    0.021353][    C0] RSP: 0018:ffffc90003177a88 EFLAGS: 00000246
[    0.021353][    C0] RAX: 0000000000000000 RBX: ffff888480e0c040 RCX: =
0000000000000000
[    0.021353][    C0] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: =
ffff888480e0c8b4
[    0.021353][    C0] RBP: ffffc90003177ac8 R08: ffffed110f700fb9 R09: =
0000000000000001
[    0.021353][    C0] R10: ffff88887b807dc7 R11: ffffed110f700fb8 R12: =
ffff888480e0c040
[    0.021353][    C0] R13: 0000000000000000 R14: 0000000000000246 R15: =
ffff888453444340
[    0.021353][    C0] FS:  0000000000000000(0000) =
GS:ffff888453400000(0000) knlGS:0000000000000000
[    0.021353][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.021353][    C0] CR2: ffff88887b9ff000 CR3: 00000003a7e12000 CR4: =
00000000003406f0
[    0.021353][    C0] Call Trace:
[    0.021353][    C0]  __schedule+0x821/0x1070
[    0.021353][    C0]  ? firmware_map_remove+0xe9/0xe9
[    0.021353][    C0]  schedule+0x95/0x160
[    0.021353][    C0]  do_boot_cpu+0x58c/0xaf0
[    0.021353][    C0]  native_cpu_up+0x298/0x430
[    0.021353][    C0]  ? common_cpu_up+0x150/0x150
[    0.021353][    C0]  bringup_cpu+0x44/0x310
[    0.021353][    C0]  ? timers_prepare_cpu+0x114/0x190
[    0.021353][    C0]  ? takedown_cpu+0x2e0/0x2e0
[    0.021353][    C0]  cpuhp_invoke_callback+0x197/0x1120
[    0.021353][    C0]  ? ring_buffer_record_is_set_on+0x40/0x40
[    0.021353][    C0]  _cpu_up+0x171/0x280
[    0.021353][    C0]  do_cpu_up+0xb1/0x120
[    0.021353][    C0]  cpu_up+0x13/0x20
[    0.021353][    C0]  smp_init+0x91/0x118
[    0.021353][    C0]  kernel_init_freeable+0x221/0x4f8
[    0.021353][    C0]  ? mark_held_locks+0x34/0xb0
[    0.021353][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
[    0.021353][    C0]  ? start_kernel+0x8c0/0x8c0
[    0.021353][    C0]  ? lockdep_hardirqs_on+0x1b0/0x2a0
[    0.021353][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
[    0.021353][    C0]  ? rest_init+0x307/0x307
[    0.021353][    C0]  kernel_init+0x11/0x139
[    0.021353][    C0]  ? rest_init+0x307/0x307
[    0.021353][    C0]  ret_from_fork+0x27/0x50

>=20
>>=20
>> [    0.013514][    C0] NMI watchdog: Watchdog detected hard LOCKUP on =
cpu 0=20
>> [    0.013514][    C0] Modules linked in:=20
>> [    0.013514][    C0] irq event stamp: 64186318=20
>> [    0.013514][    C0] hardirqs last  enabled at (64186317): =
[<ffffffff84c9b107>] _raw_spin_unlock_irq+0x27/0x40=20
>> [    0.013514][    C0] hardirqs last disabled at (64186318): =
[<ffffffff84c8f384>] __schedule+0x214/0x1070=20
>> [    0.013514][    C0] softirqs last  enabled at (267904): =
[<ffffffff85000447>] __do_softirq+0x447/0x766=20
>> [    0.013514][    C0] softirqs last disabled at (267897): =
[<ffffffff842d1f16>] irq_exit+0xd6/0xf0=20
>> [    0.013514][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.6.0-rc4-next-20200305+ #6=20
>> [    0.013514][    C0] Hardware name: HP ProLiant BL660c Gen9, BIOS =
I38 10/17/2018=20
>> [    0.013514][    C0] RIP: 0010:lock_is_held_type+0x12a/0x150=20
>> [    0.013514][    C0] Code: 41 0f 94 c4 65 48 8b 1c 25 40 0f 02 00 =
48 8d bb 74 08 00 00 e8 77 c0 28 00 c7 83 74 08 00 00 00 00 00 00 41 56 =
9d 48 83 c4 18 <44> 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 45 31 e4 eb =
c7 41 bc 01=20
>> [    0.013514][    C0] RSP: 0000:ffffc9000628f9f8 EFLAGS: 00000082=20
>> [    0.013514][    C0] RAX: 0000000000000000 RBX: ffff889880efc040 =
RCX: ffffffff8438b449=20
>> [    0.013514][    C0] RDX: 0000000000000007 RSI: dffffc0000000000 =
RDI: ffff889880efc8b4=20
>> [    0.013514][    C0] RBP: ffffc9000628fa20 R08: ffffed1108588a24 =
R09: ffffed1108588a24=20
>> [    0.013514][    C0] R10: ffff888842c4511b R11: 0000000000000000 =
R12: 0000000000000000=20
>> [    0.013514][    C0] R13: ffff889880efc908 R14: 0000000000000046 =
R15: 0000000000000003=20
>> [    0.013514][    C0] FS:  0000000000000000(0000) =
GS:ffff888842c00000(0000) knlGS:0000000000000000=20
>> [    0.013514][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033=20
>> [    0.013514][    C0] CR2: ffff88a0707ff000 CR3: 0000000b72012001 =
CR4: 00000000001606f0=20
>> [    0.013514][    C0] Call Trace:=20
>> [    0.013514][    C0]  rcu_read_lock_sched_held+0xac/0xe0=20
>> lock_is_held at include/linux/lockdep.h:361
>> (inlined by) rcu_read_lock_sched_held at kernel/rcu/update.c:121
>> [    0.013514][    C0]  ? rcu_read_lock_bh_held+0xc0/0xc0=20
>> [    0.013514][    C0]  rcu_note_context_switcx186/0x3b0=20
>> [    0.013514][    C0]  __schedule+0x21f/0x1070=20
>> [    0.013514][    C0]  ? __sched_text_start+0x8/0x8=20
>> [    0.013514][    C0]  schedule+0x95/0x160=20
>> [    0.013514][    C0]  do_boot_cpu+0x58c/0xaf0=20
>> [    0.013514][    C0]  native_cpu_up+0x298/0x430=20
>> [    0.013514][    C0]  ? common_cpu_up+0x150/0x150=20
>> [    0.013514][    C0]  bringup_cpu+0x44/0x310=20
>> [    0.013514][    C0]  ? timers_prepare_cpu+0x114/0x190=20
>> [    0.013514][    C0]  ? takedown_cpu+0x2e0/0x2e0=20
>> [    0.013514][    C0]  cpuhp_invoke_callback+0x197/0x1120=20
>> [    0.013514][    C0]  ? ring_buffer_record_is_set_on+0x40/0x40=20
>> [    0.013514][    C0]  _cpu_up+0x171/0x280=20
>> [    0.013514][    C0]  do_cpu_up+0xb1/0x120=20
>> [    0.013514][    C0]  cpu_up+0x13/0x20=20
>> [    0.013514][    C0]  smp_init+0x91/0x118=20
>> [    0.013514][    C0]  kernel_init_freeable+0x221/0x4f8=20
>> [    0.013514][    C0]  ? mark_held_locks+0x34/0xb0=20
>> [    0.013514][    C0]  ? _raw_spin_unlock_irq+0x27/0x40=20
>> [    0.013514][    C0]  ? start_kernel+0x876/0x876=20
>> [    0.013514][    C0]  ? lockdep_hardirqs_on+0x1b0/0x2a0=20
>> [    0.013514][    C0]  ? _raw_spin_unlock_irq+0x27/0x40=20
>> [    0.013514][    C0]  ? rest_init+0x307/0x307=20
>> [    0.013514][    C0]  kernel_init+0x  0.013514][    C0]  ? =
rest_init+0x307/0x307=20
>> [    0.013514][    C0]  ret_from_fork+0x3a/0x50=20
>>=20
>=20
> We could have many slightly different traces,
>=20
> [    0.000000][    T0] smpboot: CPU 8 Converting physical 0 to logical =
die 1
> [    0.021496][    C0] NMI watchdog: Watchdog detected hard LOCKUP on =
cpu 0
> [    0.021496][    C0] Modules linked in:
> [    0.021496][    C0] irq event stamp: 53241496
> [    0.021496][    C0] hardirqs last  enabled at (53241495): =
[<ffffffffa9c8c037>] _raw_spin_unlock_irq+0x27/0x40
> [    0.021496][    C0] hardirqs last disabled at (53241496): =
[<ffffffffa9c80244>] __schedule+0x214/0x1070
> [    0.021496][    C0] softirqs last  enabled at (88160): =
[<ffffffffaa000447>] __do_softirq+0x447/0x766
> [    0.021496][    C0] softirqs last disabled at (88153): =
[<ffffffffa92d0c66>] irq_exit+0xd6/0xf0
> [    0.021496][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.6.0-rc4+ #25
> [    0.021496][    C0] Hardware name: HPE ProLiant DL385 =
Gen10/ProLiant DL385 Gen10, BIOS A40 03/09/2018
> [    0.021496][    C0] RIP: 0010:__asan_load8+0x0/0xa0
> [    0.021496][    C0] Code: e8 03 0f b6 04 30 84 c0 74 c2 38 d0 0f 9e =
c0 84 c0 74 b9 ba 01 00 00 00 be 04 00 00 00 e8 c8 e3 ff ff 5d c3 66 0f =
1f 44 00 00 <55> 48 89 e5 48 8b 4d 08 eb 3a 0f 1f 00 48 b8 00 00 00 00 =
00 00 00
> [    0.021496][    C0] RSP: 0018:ffffc900031779d8 EFLAGS: 00000082
> [    0.021496][    C0] RAX: 000000000000000f RBX: ffff88820f118040 =
RCX: ffffffffa9386e1c
> [    0.021496][    C0] RDX: ffff88820f1188b0 RSI: ffff8884534442d8 =
RDI: ffff88820f118938
> [    0.021496][    C0] RBP: ffffc90003177a10 R08: ffffed1041e23009 =
R09: ffffed1041e23009
> [    0.021496][    C0] R10: ffffed1041e23008 R11: 0000000000000000 =
R12: ffff88820f118928
> [    0.021496][    C0] R13: ffff8884534442d8 R14: 0000000000000003 =
R15: ffff88820f118928
> [    0.021496][    C0] FS:  0000000000000000(0000) =
GS:ffff888453400000(0000) knlGS:0000000000000000
> [    0.021496][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
> [    0.021496][    C0] CR2: ffff88887b9ff000 CR3: 0000000257c12000 =
CR4: 00000000003406f0
> [    0.021496][    C0] Call Trace:
> [    0.021496][    C0]  ? match_held_lock+0x20/0x250
> [    0.021496][    C0]  lock_unpin_lock+0x16a/0x260
> [    0.021496][    C0]  ? lock_repin_lock+0x210/0x210
> [    0.021496][    C0]  ? __kasan_check_read+0x11/0x20
> [    0.021496][    C0]  ? pick_next_task_fair+0x3a6/0x6b0
> [    0.021496][    C0]  __schedule+0xd4f/0x1070
> [    0.021496][    C0]  ? firmware_map_remove+0xee/0xee
> [    0.021496][    C0]  ? schedule+0xc9/0x160
> [    0.021496][    C0]  schedule+0x95/0x160
> [    0.021496][    C0]  do_boot_cpu+0x58c/0xaf0
> [    0.021496][    C0]  native_cpu_up+0x298/0x430
> [    0.021496][    C0]  ? common_cpu_up+0x150/0x150
> [    0.021496][    C0]  bringup_cpu+0x44/0x310
> [    0.021496][    C0]  ? timers_prepare_cpu+0x114/0x190
> [    0.021496][    C0]  ? takedown_cpu+0x2e0/0x2e0
> [    0.021496][    C0]  cpuhp_invoke_callback+0x197/0x1120
> [    0.021496][    C0]  ? ring_buffer_record_is_set_on+0x40/0x40
> [    0.021496][    C0]  _cpu_up+0x171/0x280
> [    0.021496][    C0]  do_cpu_up+0xb1/0x120
> [    0.021496][    C0]  cpu_up+0x13/0x20
> [    0.021496][    C0]  smp_init+0x91/0x118
> [    0.021496][    C0]  kernel_init_freeable+0x221/0x4f8
> [    0.021496][    C0]  ? mark_held_locks+0x34/0xb0
> [    0.021496][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
> [    0.021496][    C0]  ? start_kernel+0x857/0x857
> [    0.021496][    C0]  ? lockdep_hardirqs_on+0x1b0/0x2a0
> [    0.021496][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
> [    0.021496][    C0]  ? rest_init+0x307/0x307
> [    0.021496][    C0]  kernel_init+0x11/0x139
> [    0.021496][    C0]  ? rest_init+0x307/0x307
> [    0.021496][    C0]  ret_from_fork+0x27/0x50
>=20
> [    0.021458][    C0] NMI watchdog: Watchdog detected hard LOCKUP on =
cpu 0
> [    0.021458][    C0] Modules linked in:
> [    0.021458][    C0] irq event stamp: 55574034
> [    0.021458][    C0] hardirqs last  enabled at (55574033): =
[<ffffffffa549d4d7>] _raw_spin_unlock_irq+0x27/0x40
> [    0.021458][    C0] hardirqs last disabled at (55574034): =
[<ffffffffa5491754>] __schedule+0x214/0x1070
> [    0.021458][    C0] softirqs last  enabled at (83640): =
[<ffffffffa5800447>] __do_softirq+0x447/0x766
> [    0.021458][    C0] softirqs last disabled at (83623): =
[<ffffffffa4ad2196>] irq_exit+0xd6/0xf0
> [    0.021458][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.6.0-rc4+ #13
> [    0.021458][    C0] Hardware name: HPE ProLiant DL385 =
Gen10/ProLiant DL385 Gen10, BIOS A40 03/09/2018
> [    0.021458][    C0] RIP: 0010:check_memory_region+0x136/0x200
> [    0.021458][    C0] Code: 00 eb 0c 49 83 c0 01 48 89 d8 49 39 d8 74 =
10 41 80 38 00 74 ee 4b 8d 44 0d 00 4d 85 c0 75 4d 4c 89 e3 48 29 c3 e9 =
3e ff ff ff <48> 85 db 74 2e 41 80 39 00 75 34 48 b8 01 00 00 00 00 fc =
ff df 49
> [    0.021458][    C0] RSP: 0018:ffffc900031779e8 EFLAGS: 00000083
> [    0.021458][    C0] RAX: fffff5200062ef48 RBX: 0000000000000001 =
RCX: ffffffffa4b94e16
> [    0.021458][    C0] RDX: 0000000000000001 RSI: 0000000000000004 =
RDI: ffffc90003177a40
> [    0.021458][    C0] RBP: ffffc90003177a00 R08: 1ffff9200062ef48 =
R09: fffff5200062ef48
> [    0.021458][    C0] R10: fffff5200062ef48 R11: ffffc90003177a43 =
R12: fffff5200062ef49
> [    0.021458][    C0] R13: ffffc90003177a80 R14: ffff888453444310 =
R15: ffff888453444308
> [    0.021458][    C0] FS:  0000000000000000(0000) =
GS:ffff888453400000(0000) knlGS:0000000000000000
> [    0.021458][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
> [    0.021458][    C0] CR2: ffff88887b9ff000 CR3: 00000006e6c12000 =
CR4: 00000000003406f0
> [    0.021458][    C0] Call Trace:
> [    0.021458][    C0]  __kasan_check_write+0x14/0x20
> [    0.021458][    C0]  do_raw_spin_lock+0xe6/0x1e0
> [    0.021458][    C0]  ? rwlock_bug.part.1+0x60/0x60
> [    0.021458][    C0]  ? __schedule+0x227/0x1070
> [    0.021458][    C0]  _raw_spin_lock+0x37/0x40
> [    0.021458][    C0]  ? __schedule+0x227/0x1070
> [    0.021458][    C0]  __schedule+0x227/0x1070
> [    0.021458][    C0]  ? __sched_text_start+0x8/0x8
> [    0.021458][    C0]  schedule+0x95/0x160
> [    0.021458][    C0]  do_boot_cpu+0x58c/0xaf0
> [    0.021458][    C0]  native_cpu_up+0x298/0x430
> [    0.021458][    C0]  ? common_cpu_up+0x150/0x150
> [    0.021458][    C0]  bringup_cpu+0x44/0x310
> [    0.021458][    C0]  ? timers_prepare_cpu+0x114/0x190
> [    0.021458][    C0]  ? takedown_cpu+0x2e0/0x2e0
> [    0.021458][    C0]  cpuhp_invoke_callback+0x197/0x1120
> [    0.021458][    C0]  ? ring_buffer_record_is_set_on+0x40/0x40
> [    0.021458][    C0]  _cpu_up+0x171/0x280
> [    0.021458][    C0]  do_cpu_up+0xb1/0x120
> [    0.021458][    C0]  cpu_up+0x13/0x20
> [    0.021458][    C0]  smp_init+0x91/0x118
> [    0.021458][    C0]  kernel_init_freeable+0x221/0x4f8
> [    0.021458][    C0]  ? mark_held_locks+0x34/0xb0
> [    0.021458][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
> [    0.021458][    C0]  ? start_kernel+0x876/0x876
> [    0.021458][    C0]  ? lockdep_hardirqs_on+0x1b0/0x2a0
> [    0.021458][    C0]  ? _raw_spin_unlock_irq+0x27/0x40
> [    0.021458][    C0]  ? rest_init+0x307/0x307
> [    0.021458][    C0]  kernel_init+0x11/0x139
> [    0.021458][    C0]  ? rest_init+0x307/0x307
> [    0.021458][    C0]  ret_from_fork+0x27/0x50
>=20
>=20
>=20

