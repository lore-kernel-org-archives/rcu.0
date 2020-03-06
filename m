Return-Path: <SRS0=V1ps=4X=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA4CC3F2CE
	for <rcu@archiver.kernel.org>; Fri,  6 Mar 2020 04:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005152072A
	for <rcu@archiver.kernel.org>; Fri,  6 Mar 2020 04:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PXaE65re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFEGP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:06:15 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:33331 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCFEGP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Mar 2020 23:06:15 -0500
Received: by mail-qt1-f176.google.com with SMTP id d22so857188qtn.0
        for <rcu@vger.kernel.org>; Thu, 05 Mar 2020 20:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=jl1llC1QLL0h85aToeTKnor77qaGaLvLiMm/Y/ZN5pM=;
        b=PXaE65re+0SRUo/j3JkHaf0mZhyRHBShkKQFG2xT/OiUDIjp3eEmOy1KI3i7rNjc+I
         QQsRfL9mLEd7izEjPux+OIKfSINSd2GRPvvy1yS+PyZ/pnzGVOTc9Jn/7F/4qJBglDS8
         h+IJFES0VndCz3e+9eDWSmCqNHiNzCtaaBwRIaALVtmr4ay+sPdJHO9ist3aFjQDtzqm
         g9bRnZqa6Doc8WohO3KZ5ROy5APZIwK56g6FSLsVMpLsgUJRNj76KPI8YQisD+87fvFF
         cxRrD09yT4qePLCblyiHE3PcR0UWCsi/WlT5qaTQ3A22N9/0EKn0uxxkWDq7oSMXlNx9
         ei2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=jl1llC1QLL0h85aToeTKnor77qaGaLvLiMm/Y/ZN5pM=;
        b=P02BpfSUQMbW8/ZqlOIeZcXo/zkibWcPN4fDRONt4ScAeLwnC6tJzYTGuMv81G8Ds7
         VenOY/DQM7kenrLopQ5K8RsIkS0TBNfawRJLujc6gndz1SJR3vNbFIJncR1snUBah0p1
         KkmTX62AJVOLR5/8656KvWcYBPsm5i4OuhHGlUJQ++9JbKL51CFD0AfnkicfO5gBWoh1
         U+R0PD26+66XMbHcnS3+mWZvOxqnnYBwxRsUxGcGNoH8OV3Zx/gpPlyXQ/qLxgNibz9Y
         JVF4U/BSLxK0mnO7aFNG4T/GsJlu9C3bHIPZVbKCuKdd6BVGHOpJ0j+8gYAnW23XpDcw
         dIKA==
X-Gm-Message-State: ANhLgQ37TuSotPv4E8WykGQGGLgJXOb1YmvBV9fSopZaJeSjQVWfOMYz
        NIMxCQ4C7gbQEdfO5tPzwmRilg==
X-Google-Smtp-Source: ADFU+vsxtEMydLYHAbt6Iz531ko/2u5XmQL0PnctD5Dyrqwf5CL7++qN9gFWRBdwj0nwW8gG6kHciw==
X-Received: by 2002:aed:2284:: with SMTP id p4mr1249893qtc.329.1583467571738;
        Thu, 05 Mar 2020 20:06:11 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d185sm17381684qkf.46.2020.03.05.20.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 20:06:11 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: PROVE_RCU_LIST + /proc/lockdep warning
Message-Id: <CA9BD318-A8C8-4F22-828A-65C355931A5C@lca.pw>
Date:   Thu, 5 Mar 2020 23:06:10 -0500
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since the linux-next commit c9af03c14bfd (=E2=80=9CDefault enable RCU =
list lockdep debugging with PROVE_RCU=E2=80=9D),
read /proc/lockdep will trigger a warning with this config below. =
Reverted the commit fixed the issue
right away.

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

[26405.676199][ T3548] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[26405.676239][ T3548] WARNING: CPU: 11 PID: 3548 at =
kernel/locking/lockdep.c:4637 check_flags.part.28+0x218/0x220
[26405.756287][ T3548] Modules linked in: kvm_intel nls_iso8859_1 =
nls_cp437 kvm vfat fat irqbypass intel_cstate intel_uncore =
intel_rapl_perf dax_pmem dax_pmem_core efivars ip_tables x_tables xfs =
sd_mod bnx2x hpsa mdio scsi_transport_sas firmware_class dm_mirror =
dm_region_hash dm_log dm_mod efivarfs
[26405.881899][ T3548] CPU: 11 PID: 3548 Comm: cat Not tainted =
5.6.0-rc4-next-20200305+ #8
[26405.920091][ T3548] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 =
10/17/2018
[26405.955370][ T3548] RIP: 0010:check_flags.part.28+0x218/0x220
[26405.983016][ T3548] Code: 13 8a e8 2b 3f 29 00 44 8b 15 84 df ba 01 =
45 85 d2 0f 85 c7 94 00 00 48 c7 c6 40 2b 47 89 48 c7 c7 40 04 47 89 e8 =
49 e3 f3 ff <0f> 0b e9 ad 94 00 00 90 55 48 89 e5 41 57 4d 89 cf 41 56 =
45 89 c6
[26406.076147][ T3548] RSP: 0018:ffffc9000695f848 EFLAGS: 00010086
[26406.104215][ T3548] RAX: 0000000000000000 RBX: ffff888fe6184040 RCX: =
ffffffff8858cecf
[26406.140856][ T3548] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: =
0000000000000000
[26406.178465][ T3548] RBP: ffffc9000695f850 R08: fffffbfff1377355 R09: =
fffffbfff1377355
[26406.217995][ T3548] R10: ffffffff89bb9aa3 R11: fffffbfff1377354 R12: =
0000000000000000
[26406.256760][ T3548] R13: ffffffff8aa55ee0 R14: 0000000000000046 R15: =
ffffffff8aa55ec0
[26406.293708][ T3548] FS:  00007f58cf3a3540(0000) =
GS:ffff88905fa80000(0000) knlGS:0000000000000000
[26406.335252][ T3548] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[26406.366331][ T3548] CR2: 00007f58cf326000 CR3: 0000000f1ba38006 CR4: =
00000000001606e0
[26406.402408][ T3548] Call Trace:
[26406.416739][ T3548]  lock_is_held_type+0x5d/0x150
[26406.438262][ T3548]  ? rcu_lockdep_current_cpu_online+0x64/0x80
[26406.466463][ T3548]  rcu_read_lock_any_held+0xac/0x100
[26406.490105][ T3548]  ? rcu_read_lock_held+0xc0/0xc0
[26406.513258][ T3548]  ? __slab_free+0x421/0x540
[26406.535012][ T3548]  ? kasan_kmalloc+0x9/0x10
[26406.555901][ T3548]  ? __kmalloc_node+0x1d7/0x320
[26406.578668][ T3548]  ? kvmalloc_node+0x6f/0x80
[26406.599872][ T3548]  __bfs+0x28a/0x3c0
[26406.617075][ T3548]  ? class_equal+0x30/0x30
[26406.637524][ T3548]  lockdep_count_forward_deps+0x11a/0x1a0
[26406.664134][ T3548]  ? check_noncircular+0x2e0/0x2e0
[26406.688191][ T3548]  ? __kasan_check_read+0x11/0x20
[26406.713581][ T3548]  ? check_chain_key+0x1df/0x2e0
[26406.738044][ T3548]  ? seq_vprintf+0x4e/0xb0
[26406.758241][ T3548]  ? seq_printf+0x9b/0xd0
[26406.778169][ T3548]  ? seq_vprintf+0xb0/0xb0
[26406.798172][ T3548]  l_show+0x1c4/0x380
[26406.816474][ T3548]  ? print_name+0xb0/0xb0
[26406.836393][ T3548]  seq_read+0x56b/0x750
[26406.855346][ T3548]  proc_reg_read+0x1b4/0x200
[26406.876737][ T3548]  ? proc_reg_unlocked_ioctl+0x1e0/0x1e0
[26406.903030][ T3548]  ? check_chain_key+0x1df/0x2e0
[26406.926531][ T3548]  ? find_held_lock+0xca/0xf0
[26406.948291][ T3548]  __vfs_read+0x50/0xa0
[26406.967391][ T3548]  vfs_read+0xcb/0x1e0
[26406.986102][ T3548]  ksys_read+0xc6/0x160
[26407.005405][ T3548]  ? kernel_write+0xc0/0xc0
[26407.026076][ T3548]  ? do_syscall_64+0x79/0xaec
[26407.047448][ T3548]  ? do_syscall_64+0x79/0xaec
[26407.068650][ T3548]  __x64_sys_read+0x43/0x50
[26407.089132][ T3548]  do_syscall_64+0xcc/0xaec
[26407.109939][ T3548]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[26407.134924][ T3548]  ? syscall_return_slowpath+0x580/0x580
[26407.160854][ T3548]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[26407.188943][ T3548]  ? trace_hardirqs_off_caller+0x3a/0x150
[26407.216692][ T3548]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[26407.243534][ T3548]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[26407.272720][ T3548] RIP: 0033:0x7f58ceeafd75
[26407.293162][ T3548] Code: fe ff ff 50 48 8d 3d 4a dc 09 00 e8 25 0e =
02 00 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 a5 59 2d 00 8b 00 85 c0 75 0f =
31 c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89 =
f5 53 89
[26407.386043][ T3548] RSP: 002b:00007ffc115111a8 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000000
[26407.425283][ T3548] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: =
00007f58ceeafd75
[26407.462717][ T3548] RDX: 0000000000020000 RSI: 00007f58cf327000 RDI: =
0000000000000003
[26407.500428][ T3548] RBP: 00007f58cf327000 R08: 00000000ffffffff R09: =
0000000000000000
[26407.538473][ T3548] R10: 0000000000000022 R11: 0000000000000246 R12: =
00007f58cf327000
[26407.575743][ T3548] R13: 0000000000000003 R14: 0000000000000fff R15: =
0000000000020000
[26407.613112][ T3548] irq event stamp: 7161
[26407.632089][ T3548] hardirqs last  enabled at (7161): =
[<ffffffff88ea2684>] _raw_spin_unlock_irqrestore+0x44/0x50
[26407.680094][ T3548] hardirqs last disabled at (7160): =
[<ffffffff88ea2418>] _raw_spin_lock_irqsave+0x18/0x50
[26407.727273][ T3548] softirqs last  enabled at (5898): =
[<ffffffff89200447>] __do_softirq+0x447/0x766
[26407.774000][ T3548] softirqs last disabled at (5889): =
[<ffffffff884d20e6>] irq_exit+0xd6/0xf0
[26407.814407][ T3548] ---[ end trace 1026d00df66af83e ]---
[26407.839742][ T3548] possible reason: unannotated irqs-off.
[26407.866243][ T3548] irq event stamp: 7161
[26407.885407][ T3548] hardirqs last  enabled at (7161): =
[<ffffffff88ea2684>] _raw_spin_unlock_irqrestore+0x44/0x50
[26407.933602][ T3548] hardirqs last disabled at (7160): =
[<ffffffff88ea2418>] _raw_spin_lock_irqsave+0x18/0x50
[26407.980432][ T3548] softirqs last  enabled at (5898): =
[<ffffffff89200447>] __do_softirq+0x447/0x766
[26408.022826][ T3548] softirqs last disabled at (5889): =
[<ffffffff884d20e6>] irq_exit+0xd6/0xf0

On a side note, it likely to hit another bug in next-20200305 (not such =
problem on 0304) where it
will stuck during boot, but the reverting does not help there. Rebooting =
a few times could pass.

[    0.013514][    C0] NMI watchdog: Watchdog detected hard LOCKUP on =
cpu 0=20
[    0.013514][    C0] Modules linked in:=20
[    0.013514][    C0] irq event stamp: 64186318=20
[    0.013514][    C0] hardirqs last  enabled at (64186317): =
[<ffffffff84c9b107>] _raw_spin_unlock_irq+0x27/0x40=20
[    0.013514][    C0] hardirqs last disabled at (64186318): =
[<ffffffff84c8f384>] __schedule+0x214/0x1070=20
[    0.013514][    C0] softirqs last  enabled at (267904): =
[<ffffffff85000447>] __do_softirq+0x447/0x766=20
[    0.013514][    C0] softirqs last disabled at (267897): =
[<ffffffff842d1f16>] irq_exit+0xd6/0xf0=20
[    0.013514][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.6.0-rc4-next-20200305+ #6=20
[    0.013514][    C0] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 =
10/17/2018=20
[    0.013514][    C0] RIP: 0010:lock_is_held_type+0x12a/0x150=20
[    0.013514][    C0] Code: 41 0f 94 c4 65 48 8b 1c 25 40 0f 02 00 48 =
8d bb 74 08 00 00 e8 77 c0 28 00 c7 83 74 08 00 00 00 00 00 00 41 56 9d =
48 83 c4 18 <44> 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 45 31 e4 eb c7 =
41 bc 01=20
[    0.013514][    C0] RSP: 0000:ffffc9000628f9f8 EFLAGS: 00000082=20
[    0.013514][    C0] RAX: 0000000000000000 RBX: ffff889880efc040 RCX: =
ffffffff8438b449=20
[    0.013514][    C0] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: =
ffff889880efc8b4=20
[    0.013514][    C0] RBP: ffffc9000628fa20 R08: ffffed1108588a24 R09: =
ffffed1108588a24=20
[    0.013514][    C0] R10: ffff888842c4511b R11: 0000000000000000 R12: =
0000000000000000=20
[    0.013514][    C0] R13: ffff889880efc908 R14: 0000000000000046 R15: =
0000000000000003=20
[    0.013514][    C0] FS:  0000000000000000(0000) =
GS:ffff888842c00000(0000) knlGS:0000000000000000=20
[    0.013514][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20=

[    0.013514][    C0] CR2: ffff88a0707ff000 CR3: 0000000b72012001 CR4: =
00000000001606f0=20
[    0.013514][    C0] Call Trace:=20
[    0.013514][    C0]  rcu_read_lock_sched_held+0xac/0xe0=20
lock_is_held at include/linux/lockdep.h:361
(inlined by) rcu_read_lock_sched_held at kernel/rcu/update.c:121
[    0.013514][    C0]  ? rcu_read_lock_bh_held+0xc0/0xc0=20
[    0.013514][    C0]  rcu_note_context_switcx186/0x3b0=20
[    0.013514][    C0]  __schedule+0x21f/0x1070=20
[    0.013514][    C0]  ? __sched_text_start+0x8/0x8=20
[    0.013514][    C0]  schedule+0x95/0x160=20
[    0.013514][    C0]  do_boot_cpu+0x58c/0xaf0=20
[    0.013514][    C0]  native_cpu_up+0x298/0x430=20
[    0.013514][    C0]  ? common_cpu_up+0x150/0x150=20
[    0.013514][    C0]  bringup_cpu+0x44/0x310=20
[    0.013514][    C0]  ? timers_prepare_cpu+0x114/0x190=20
[    0.013514][    C0]  ? takedown_cpu+0x2e0/0x2e0=20
[    0.013514][    C0]  cpuhp_invoke_callback+0x197/0x1120=20
[    0.013514][    C0]  ? ring_buffer_record_is_set_on+0x40/0x40=20
[    0.013514][    C0]  _cpu_up+0x171/0x280=20
[    0.013514][    C0]  do_cpu_up+0xb1/0x120=20
[    0.013514][    C0]  cpu_up+0x13/0x20=20
[    0.013514][    C0]  smp_init+0x91/0x118=20
[    0.013514][    C0]  kernel_init_freeable+0x221/0x4f8=20
[    0.013514][    C0]  ? mark_held_locks+0x34/0xb0=20
[    0.013514][    C0]  ? _raw_spin_unlock_irq+0x27/0x40=20
[    0.013514][    C0]  ? start_kernel+0x876/0x876=20
[    0.013514][    C0]  ? lockdep_hardirqs_on+0x1b0/0x2a0=20
[    0.013514][    C0]  ? _raw_spin_unlock_irq+0x27/0x40=20
[    0.013514][    C0]  ? rest_init+0x307/0x307=20
[    0.013514][    C0]  kernel_init+0x  0.013514][    C0]  ? =
rest_init+0x307/0x307=20
[    0.013514][    C0]  ret_from_fork+0x3a/0x50=20

=20=
