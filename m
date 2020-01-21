Return-Path: <SRS0=d+Zk=3K=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D844AC35240
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 04:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AE022314
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 04:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aG2kI59j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAUEZp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 23:25:45 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:38616 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUEZo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 23:25:44 -0500
Received: by mail-qv1-f48.google.com with SMTP id t6so844941qvs.5
        for <rcu@vger.kernel.org>; Mon, 20 Jan 2020 20:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=QT3ApTB5ulKAM4xXfMbMEmdXx1kHQ9/Rw8Gj549Qa5E=;
        b=aG2kI59jKkV0Lu87eDSog4kITKgF/O7mFPpoUEAIHUwLc4Dq3USiX/DlywbkeNBz3J
         YPfxiBMpHTj0uOFv7bfsU/rjPX9YhGes4X1M3TGrXRfErpKlbKatBkF7kkZ2K1D26VVo
         aR8DT+GG2p++qZ4etZtmRdLMmuksXCNWvC5lwzy5voifktnyxHq023NWZ87bTCm6c0go
         YH0pPgdktK+D8mRCTVmepCm7vh3JPsfV8RnMLeQ4JUpHjBcPYCYXtQigSVT6O0i2TbQ2
         MnwsK8L94evTqT/OzvHSuNUeCgKWNhsCFL9HchtM8Ao/nV1+gW2pluP//nkSYv3bB4y/
         FdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=QT3ApTB5ulKAM4xXfMbMEmdXx1kHQ9/Rw8Gj549Qa5E=;
        b=TEeQ+YnslHXffoVXKOBum5hywNnfTRkQ9psFEF9ilJTETXfcA37029E47vmw6wYSvF
         +I4yv14H4ajXOqfoTicBQ4qHap2s91pRmibiiKInQknIs/J8AdW3rCKs+rvLWWQ80ahl
         6yyEoeZ5a9QjqAA4DB4SduzSCOqWSsM4PhZr3+mdtxNS+ftJ/HAmONheHvtT30+vrvpM
         Ov9Emc8Sa8o84tkYFdm6J/4vSG/B7MjagQCgEDtKPLz/fnoWebF4EymVp9sMYwiFy2G6
         p28iWkTNYxWwAFiwtdSOweMmPRG9XFwHnhAKoikeIyrxtvjPfik73Gjugh/g3+lsvj2w
         qUqQ==
X-Gm-Message-State: APjAAAXHCOQ5bJ4JbkR4lvQNYb/eeomru3049YRLaZfB9bubvZsFDoDm
        /8oKlpoCHY2eCLISDFmCXnvrQKSavO5eNA==
X-Google-Smtp-Source: APXvYqz+IUgtSJcmKQIu6qGsUnBc+0d6GQfUdj58FZzsPb5HUbvc5rubXDDxBM9erPAo55l3tugrEw==
X-Received: by 2002:ad4:51cc:: with SMTP id p12mr2978639qvq.113.1579580742981;
        Mon, 20 Jan 2020 20:25:42 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q5sm16590610qkf.14.2020.01.20.20.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 20:25:42 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Boot warning at rcu_check_gp_start_stall()
Message-Id: <9F765463-9FA2-4E05-8390-D798A7C926A8@lca.pw>
Date:   Mon, 20 Jan 2020 23:25:41 -0500
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Booting a server generates this warning on linux-next with this config,

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

Does it ring any bell?

[   96.714534] 0xffffffffff800000-0x0000000000000000           8M        =
                       pmd
[   96.872278] Dentry cache hash table entries: 8388608 (order: 14, =
67108864 bytes, vmalloc)
[   96.938599] Inode-cache hash table entries: 4194304 (order: 13, =
33554432 bytes, vmalloc)
[   96.955357] Mount-cache hash table entries: 131072 (order: 8, 1048576 =
bytes, vmalloc)
[   96.965514] Mountpoint-cache hash table entries: 131072 (order: 8, =
1048576 bytes, vmalloc)
[   96.994553] ------------[ cut here ]------------
[   96.999922] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_stall.h:672 =
rcu_check_gp_start_stall.isra.67+0x1ae/0x260
[   97.004526] Modules linked in:
[   97.004526] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B             =
5.5.0-rc6-next-20200120+ #1
[   97.004526] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 07/10/2019
[   97.004526] RIP: 0010:rcu_check_gp_start_stall.isra.67+0x1ae/0x260
[   97.004526] Code: 61 01 4c 01 e6 48 39 f2 78 58 be 04 00 00 00 48 c7 =
c7 e0 24 b7 85 e8 71 0f 25 00 b8 01 00 00 00 87 05 66 32 7b 04 85 c0 75 =
2f <0f> 0b 48 81 fb 40 13 9d 82 74 0c 48 c7 c7 40 13 9d 82 e8 2b 2a 8d
[   97.004526] RSP: 0000:ffffc90000007e18 EFLAGS: 00010046
[   97.004526] RAX: 0000000000000000 RBX: ffffffff829d1700 RCX: =
ffffffff813bf26f
[   97.004526] RDX: 0000000000000001 RSI: 0000000000000004 RDI: =
ffffffff85b724e0
[   97.004526] RBP: ffffc90000007e30 R08: fffffbfff0b6e49d R09: =
fffffbfff0b6e49d
[   97.004526] R10: fffffbfff0b6e49c R11: ffffffff85b724e3 R12: =
0000000000001964
[   97.004526] R13: 0000000000000246 R14: ffff888843045050 R15: =
ffff888843045018
[   97.004526] FS:  0000000000000000(0000) GS:ffff888843000000(0000) =
knlGS:0000000000000000
[   97.004526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.004526] CR2: ffff8890779ff000 CR3: 0000000b7d212000 CR4: =
00000000000406b0
[   97.004526] Call Trace:
[   97.004526]  <IRQ>
[   97.004526]  rcu_core+0x22b/0xb80
[   97.004526]  ? debug_lockdep_rcu_enabled+0x11/0x60
[   97.004526]  ? call_timer_fn+0x4e0/0x4e0
[   97.004526]  ? rcu_note_context_switch+0x3b0/0x3b0
[   97.004526]  ? lock_downgrade+0x3c0/0x3c0
[   97.004526]  ? rwlock_bug.part.1+0x60/0x60
[   97.004526]  ? lockdep_hardirqs_on+0x16/0x2a0
[   97.004526]  rcu_core_si+0xe/0x10
[   97.004526]  __do_softirq+0x123/0x766
[   97.004526]  ? do_raw_spin_unlock+0xa8/0x140
[   97.004526]  irq_exit+0xd6/0xf0
[   97.004526]  do_IRQ+0xa3/0x1e0
[   97.004526]  common_interrupt+0xf/0xf
[   97.004526]  </IRQ>
[   97.004526] RIP: 0010:__asan_load8+0x0/0xa0
[   97.004526] Code: e8 03 0f b6 04 30 84 c0 74 c2 38 d0 0f 9e c0 84 c0 =
74 b9 ba 01 00 00 00 be 04 00 00 00 e8 c8 e3 ff ff 5d c3 66 0f 1f 44 00 =
00 <55> 48 89 e5 48 8b 4d 08 e9 a3 d3 9f 01 48 b8 00 00 00 00 00 00 00
[   97.004526] RSP: 0000:ffffffff82807af0 EFLAGS: 00000257 ORIG_RAX: =
ffffffffffffffcf
[   97.004526] RAX: ffffffff82f25840 RBX: ffffffff82f25840 RCX: =
0000000000000028
[   97.004526] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
ffffffff82f25840
[   97.004526] RBP: ffffffff82807b30 R08: 0000000000000000 R09: =
0000000000000004
[   97.004526] R10: ffff8890313c98fc R11: ffff8890313c98ff R12: =
0000000000000000
[   97.004526] R13: 0000000000000080 R14: 0000000000000028 R15: =
0000000000000000
[   97.004526]  ? _find_next_bit.constprop.1+0x4a/0x100
[   97.004526]  find_next_bit+0x14/0x20
[   97.004526]  cpumask_next+0x35/0x40
[   97.004526]  pcpu_alloc+0x4bf/0xa40
[   97.004526]  __alloc_percpu+0x15/0x20
[   97.004526]  __percpu_init_rwsem+0x28/0xa0
[   97.004526]  alloc_super+0x164/0x530
[   97.004526]  sget_fc+0xb9/0x3a0
[   97.004526]  ? compare_single+0x10/0x10
[   97.004526]  ? ramfs_symlink+0xe0/0xe0
[   97.004526]  vfs_get_super+0x4e/0x1a0
[   97.004526]  ? vfs_parse_fs_string+0x110/0x110
[   97.004526]  get_tree_nodev+0x16/0x20
[   97.004526]  ramfs_get_tree+0x15/0x20
[   97.004526]  vfs_get_tree+0x54/0x150
[   97.004526]  fc_mount+0x14/0x60
[   97.004526]  vfs_kern_mount.part.13+0x61/0xa0
[   97.004526]  mnt_init+0x1b0/0x34a
[   97.004526]  ? set_mphash_entries+0xa2/0xa2
[   97.004526]  ? __percpu_counter_init+0x127/0x140
[   97.004526]  vfs_caches_init+0xda/0xe6
[   97.004526]  start_kernel+0x55d/0x5dc
[   97.004526]  ? thread_stack_cache_init+0xb/0xb
[   97.004526]  ? idt_setup_from_table+0xd9/0x130
[   97.004526]  x86_64_start_reservations+0x24/0x26
[   97.004526]  x86_64_start_kernel+0xf4/0xfb
[   97.004526]  secondary_startup_64+0xb6/0xc0
[   97.004526] irq event stamp: 16832
[   97.004526] hardirqs last  enabled at (16831): [<ffffffff812a8399>] =
switch_mm+0x49/0x60
[   97.004526] hardirqs last disabled at (16832): [<ffffffff82fc0b52>] =
efi_set_virtual_address_map+0x4a7/0x574
[   97.004526] softirqs last  enabled at (15286): [<ffffffff82000447>] =
__do_softirq+0x447/0x766
[   97.004526] softirqs last disabled at (15279): [<ffffffff812d3ac6>] =
irq_exit+0xd6/0xf0
[   97.004526] ---[ end trace 33b25e8237e68c3c ]---
[   97.004535] rcu: rcu_sched: wait state: RCU_GP_IDLE(0) ->state: =
0x1ffff delta ->gp_activity 4294945934 ->gp_req_activity 8637 =
->gp_wake_time 4294945934 ->gp_wake_seq 0 ->gp_seq -1200 ->gp_seq_needed =
-1196 ->gp_flags 0x1
[   97.014531] rcu:     rcu_node 0:127 ->gp_seq -1200 ->gp_seq_needed =
-1196
[   97.024538] rcu:     rcu_node 0:15 ->gp_seq -1200 ->gp_seq_needed =
-1196
[   97.034530] rcu:     cpu 1 ->gp_seq_needed 0
[   97.039268] rcu:     cpu 2 ->gp_seq_needed 0
[   97.044530] rcu:     cpu 3 ->gp_seq_needed 0
[   97.049268] rcu:     cpu 4 ->gp_seq_needed 0
[   97.054530] rcu:     cpu 5 ->gp_seq_needed 0
[   97.059268] rcu:     cpu 6 ->gp_seq_needed 0
[   97.064006] rcu:     cpu 7 ->gp_seq_needed 0
[   97.064530] rcu:     cpu 8 ->gp_seq_needed 0
[   97.069268] rcu:     cpu 9 ->gp_seq_needed 0
[   97.074530] rcu:     cpu 10 ->gp_seq_needed 0
[   97.079354] rcu:     cpu 11 ->gp_seq_needed 0
[   97.084531] rcu:     cpu 12 ->gp_seq_needed 0
[   97.089356] rcu:     cpu 13 ->gp_seq_needed 0
[   97.094530] rcu:     cpu 14 ->gp_seq_needed 0
[   97.099355] rcu:     cpu 15 ->gp_seq_needed 0
[   97.192987] LVT offset 2 assigned for vector 0xf4
[   97.194558] numa_add_cpu cpu 0 node 0: mask now 0
[   97.194563] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512

or this,

[   96.807008] Inode-cache hash table entries: 4194304 (order: 13, =
33554432 bytes, vmalloc)
[   96.823729] Mount-cache hash table entries: 131072 (order: 8, 1048576 =
bytes, vmalloc)
[   96.827982] Mountpoint-cache hash table entries: 131072 (order: 8, =
1048576 bytes, vmalloc)
[   96.866430] ------------[ cut here ]------------
[   96.871797] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_stall.h:672 =
rcu_check_gp_start_stall.isra.67+0x1ae/0x260
[   96.876402] Modules linked in:
[   96.876402] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B             =
5.5.0-rc6-next-20200120+ #1
[   96.876402] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 07/10/2019
[   96.876402] RIP: 0010:rcu_check_gp_start_stall.isra.67+0x1ae/0x260
[   96.876402] Code: 61 01 4c 01 e6 48 39 f2 78 58 be 04 00 00 00 48 c7 =
c7 e0 24 f7 b3 e8 71 0f 25 00 b8 01 00 00 00 87 05 66 32 7b 04 85 c0 75 =
2f <0f> 0b 48 81 fb 40 13 dd b0 74 0c 48 c7 c7 40 13 dd b0 e8 8b 2b 8d
[   96.876402] RSP: 0000:ffffc90000007e18 EFLAGS: 00010046
[   96.876402] RAX: 0000000000000000 RBX: ffffffffb0dd1700 RCX: =
ffffffffaf7bf26f
[   96.876402] RDX: 0000000000000001 RSI: 0000000000000004 RDI: =
ffffffffb3f724e0
[   96.876402] RBP: ffffc90000007e30 R08: fffffbfff67ee49d R09: =
fffffbfff67ee49d
[   96.876402] R10: fffffbfff67ee49c R11: ffffffffb3f724e3 R12: =
0000000000001964
[   96.876402] R13: 0000000000000246 R14: ffff888843045050 R15: =
ffff888843045018
[   96.876402] FS:  0000000000000000(0000) GS:ffff888843000000(0000) =
knlGS:0000000000000000
[   96.876402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   96.876402] CR2: ffff8890779ff000 CR3: 0000000b2a012000 CR4: =
00000000000406b0
[   96.876402] Call Trace:
[   96.876402]  <IRQ>
[   96.876402]  rcu_core+0x22b/0xb80
[   96.876402]  ? debug_lockdep_rcu_enabled+0x11/0x60
[   96.876402]  ? call_timer_fn+0x4e0/0x4e0
[   96.876402]  ? rcu_note_context_switch+0x3b0/0x3b0
[   96.876402]  ? lock_downgrade+0x3c0/0x3c0
[   96.876402]  ? rwlock_bug.part.1+0x60/0x60
[   96.876402]  ? lockdep_hardirqs_on+0x16/0x2a0
[   96.876402]  rcu_core_si+0xe/0x10
[   96.876402]  __do_softirq+0x123/0x766
[   96.876402]  ? do_raw_spin_unlock+0xa8/0x140
[   96.876402]  irq_exit+0xd6/0xf0
[   96.876402]  do_IRQ+0xa3/0x1e0
[   96.876402]  common_interrupt+0xf/0xf
[   96.876402]  </IRQ>
[   96.876402] RIP: 0010:_raw_spin_unlock_irqrestore+0x46/0x50
[   96.876402] Code: 6a 6f ff 4c 89 e7 e8 69 fb 6f ff f6 c7 02 75 13 53 =
9d e8 ad 4c 7f ff 65 ff 0d fe ef f8 4f 5b 41 5c 5d c3 e8 ec 4d 7f ff 53 =
9d <eb> eb 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 65 ff 05 db ef f8
[   96.876402] RSP: 0000:ffffffffb0c07ab0 EFLAGS: 00000246 ORIG_RAX: =
ffffffffffffffcf
[   96.876402] RAX: 0000000000000000 RBX: 0000000000000246 RCX: =
ffffffffaf789c26
[   96.876402] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: =
ffffffffb1329794
[   96.876402] RBP: ffffffffb0c07ac0 R08: fffffbfff626282a R09: =
fffffbfff626282a
[   96.876402] R10: fffffbfff6262829 R11: ffffffffb131414b R12: =
ffffffffb0f8a860
[   96.876402] R13: ffffffffb0f8a980 R14: ffffffffb982af38 R15: =
ffff888216688310
[   96.876402]  ? lockdep_hardirqs_on+0x16/0x2a0
[   96.876402]  create_object+0x4a2/0x540
[   96.876402]  kmemleak_alloc_percpu+0xbd/0x150
[   96.876402]  pcpu_alloc+0x50c/0xa40
[   96.876402]  __alloc_percpu+0x15/0x20
[   96.876402]  __percpu_init_rwsem+0x28/0xa0
[   96.876402]  alloc_super+0x1ac/0x530
[   96.876402]  sget_fc+0xb9/0x3a0
[   96.876402]  ? compare_single+0x10/0x10
[   96.876402]  ? ramfs_symlink+0xe0/0xe0
[   96.876402]  vfs_get_super+0x4e/0x1a0
[   96.876402]  ? vfs_parse_fs_string+0x110/0x110
[   96.876402]  get_tree_nodev+0x16/0x20
[   96.876402]  ramfs_get_tree+0x15/0x20
[   96.876402]  vfs_get_tree+0x54/0x150
[   96.876402]  fc_mount+0x14/0x60
[   96.876402]  vfs_kern_mount.part.13+0x61/0xa0
[   96.876402]  mnt_init+0x1b0/0x34a
[   96.876402]  ? set_mphash_entries+0xa2/0xa2
[   96.876402]  ? __percpu_counter_init+0x127/0x140
[   96.876402]  vfs_caches_init+0xda/0xe6
[   96.876402]  start_kernel+0x55d/0x5dc
[   96.876402]  ? thread_stack_cache_init+0xb/0xb
[   96.876402]  ? idt_setup_from_table+0xd9/0x130
[   96.876402]  x86_64_start_reservations+0x24/0x26
[   96.876402]  x86_64_start_kernel+0xf4/0xfb
[   96.876402]  secondary_startup_64+0xb6/0xc0
[   96.876402] irq event stamp: 16832
[   96.876402] hardirqs last  enabled at (16831): [<ffffffffaf6a8399>] =
switch_mm+0x49/0x60
[   96.876402] hardirqs last disabled at (16832): [<ffffffffb13c0b52>] =
efi_set_virtual_address_map+0x4a7/0x574
[   96.876402] softirqs last  enabled at (15278): [<ffffffffb0400447>] =
__do_softirq+0x447/0x766
[   96.876402] softirqs last disabled at (15271): [<ffffffffaf6d3ac6>] =
irq_exit+0xd6/0xf0
[   96.876402] ---[ end trace 8c99b667a2f37d07 ]---
[   96.876412] rcu: rcu_sched: wait state: RCU_GP_IDLE(0) ->state: =
0x1ffff delta ->gp_activity 4294945938 ->gp_req_activity 8641 =
->gp_wake_time 4294945938 ->gp_wake_seq 0 ->gp_seq -1200 ->gp_seq_needed =
-1196 ->gp_flags 0x1
[   96.886409] rcu:     rcu_node 0:127 ->gp_seq -1200 ->gp_seq_needed =
-1196
[   96.896408] rcu:     rcu_node 0:15 ->gp_seq -1200 ->gp_seq_needed =
-1196
[   96.906408] rcu:     cpu 1 ->gp_seq_needed 0
[   96.911146] rcu:     cpu 2 ->gp_seq_needed 0
[   96.916407] rcu:     cpu 3 ->gp_seq_needed 0
[   96.921145] rcu:     cpu 4 ->gp_seq_needed 0
[   96.926407] rcu:     cpu 5 ->gp_seq_needed 0
[   96.931145] rcu:     cpu 6 ->gp_seq_needed 0
[   96.936407] rcu:     cpu 7 ->gp_seq_needed 0
[   96.941145] rcu:     cpu 8 ->gp_seq_needed 0
[   96.946407] rcu:     cpu 9 ->gp_seq_needed 0
[   96.951145] rcu:     cpu 10 ->gp_seq_needed 0
[   96.956407] rcu:     cpu 11 ->gp_seq_needed 0
[   96.961231] rcu:     cpu 12 ->gp_seq_needed 0
[   96.966407] rcu:     cpu 13 ->gp_seq_needed 0
[   96.971231] rcu:     cpu 14 ->gp_seq_needed 0
[   96.976055] rcu:     cpu 15 ->gp_seq_needed 0
[   97.064605] LVT offset 2 assigned for vector 0xf4
[   97.066435] numa_add_cpu cpu 0 node 0: mask now 0
[   97.066440] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512=
