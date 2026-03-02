Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720234575F
	for <rcu@vger.kernel.org>; Mon,  2 Mar 2026 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450822; cv=pass; b=WDeVVNcy44YtiBgaMEtCuMaXrXaUhhQacJdUJ+iht6HOHhgAqTlCXXGpYccerMH7vFMaYB8r0el3UopDj1VEOQoZ/+a1VIQPN08EsQg80ej6dxZCTptdwDGwXiiG4l5aCXT6hOr9/stMeBhIopNmfGlFY42ccyg9kHP0Hm8sU90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450822; c=relaxed/simple;
	bh=K/WdmOb8LXQldUsW1E5BrJGuSzeKfcA5D71mrCT4lw0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=raF+lbkCGIbySaUWN6jDRrIF/O6oBRfD7udb/f5tEUAh2ia1Fr0gBEg0bJ53R1UtiqLdHjx2ds3cYWXsx5V9O18ZwYg/VLF1Cm/7pvH/c6Mhz/FmJA2oawAABOkboMa9HvNZ/e6oUBWaWRXW8VXvypaIQxDCIPMT/Yw0Yk9unmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwMhoVAv; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwMhoVAv"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70f91776fcso1694568a12.0
        for <rcu@vger.kernel.org>; Mon, 02 Mar 2026 03:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772450820; cv=none;
        d=google.com; s=arc-20240605;
        b=ehItuqS3AcQiQmfBTexECovxze4IfaDQGEgV3zfYvZfzBPLx/uBISEstucAbLo6imi
         h3XMlJi5V5wsJji/s9HwEpG9m7CKxGGJZ8rLZCrgJqX1Y/zONCFIFZjJR2nYZWhn8Zzg
         Hb1tb+zF13U9aBTcL4bQ9gMzunMBKbqMUR5S+VKF/wmNiUActC3JyRgNKnx+JacZBgC+
         l40CsM8LpSvBIterkz0cg6VQXGX69Xi25NuFSpOaoSeqbdEJ9pxbxM9sVbZxctkF7XWV
         vRoLRfmAFa/J4fctcIeXLvq4GAsLm+6jRxrHoEj/dOMJZtt2EYiMNVrJLr7O3yIU3oT4
         IYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=6679ws7fjghLotVV7QhFwjhZxXC9+XMku516eeTHg74=;
        fh=H0w/uzrO0UiRtVHVyFYYBNRiW3/e6SN0E7eUK1GsqDA=;
        b=fZXn9BXxKytlVDMmVBr0qQbhq8OBeyjn7AYsCL+dh7mQVpAF657e4qor6DSHUsr2SJ
         W5vzynrh3Zoendk1rwS1nCI+jpyz2nXp2ubf23/ny7d8ROin0+hzEvXV92ZIAo7aXiru
         nSphTVHfNU2fN2sJGYN3pUoQj6Sf/jXuq9nrSoqsVorLut4xER45E7bZV5D4CZah4Jkp
         nvMLtUxTd1d6h4xc1td8+VzMhkV0UB4opJ4wYF4pBXrp4PRkoWPd9sFsCFo4aODIZb6U
         wJ+6Cz3qrh1ZfNDdTskoJEdquBcGoZfWCrWwlZl7Z2KXwCf8XanuSLkHeR2C+hf707wV
         L1wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772450820; x=1773055620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6679ws7fjghLotVV7QhFwjhZxXC9+XMku516eeTHg74=;
        b=NwMhoVAvAZrPMNXGrMjjG4TxWVUh+PvxQw0gVA1LB4+lFpQeuAHySHE04IEMhBGCu3
         Vm7t2ALiPsjlMA0sffqRr1lqli2uwf4ofE441MxXLQ0m2t4yiA6sFJQarjymE2rgNCof
         aEP2TSykNNXi8PJcgsy22FVhA90mBbDyJbeST+/1oqbP1QcsiIQRGCMId4xQDa/WAmWz
         Q4kQGaIsWuB71A2wgSIS/R9ZolgTOQp4Zejn7EyZcuSGHKMoLF3eClZkcMCKMXkegAAb
         W3n/Ixt5JuX1wezWB2EF7h9/MK3gWHMLxcsDovzNFHMkedxDpqvr1Mh9Wioh6jtV4rOx
         vzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450820; x=1773055620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6679ws7fjghLotVV7QhFwjhZxXC9+XMku516eeTHg74=;
        b=nxMmF2f9CuuU8eRTiVpUYUYpe0MxUkl7aI46UGceVTHomoKHA4RF3MN/QrXQASK/Je
         jk+Fg68TwsSiDz31Ob8DdAc6mNvK5ehyogx64YDlCFPY7y1pxh2TuK94UII3BwxX/EnH
         SqZD2f68Fzk5cSkGFHBJexKp1Q2BWqZjCntmxswpQubJw2Ig5sPyYK+hWP1ejb+pEBc9
         lVzPiJVcu6ppox+yZhWWh5uUHeljXKUwcTuUqi0H7oIu4kPl8GQMum39rGqQEw2q+Lxd
         4Caauo4w9F5eLjY/pD7FxNQN4NbyD1l1HVppHZocH86jorXLl5gE+oZujC0FkGqEQ+DU
         8Hpg==
X-Forwarded-Encrypted: i=1; AJvYcCU48ykUgCU+6C9u9xk2e04QNoLh5gx23Cbvxg1lzEo/b2cIGwRNogLk9tSSRjbQ8AA08Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCjo+TZdzWzO+FH3q3hPG/HaaNzgVYiuShZkLsCGAMepPeXaa
	SOBc4MkSOgCMeYNuYwYrf93PJ1yFMv4eqEQq5CEEGDnQ4AOUo1dR6qTBKRTUGSquu1mjvHzfGxP
	eLjYuytCju89pCqvs0N1TZ9RSaApdnbs=
X-Gm-Gg: ATEYQzyVFsKdBaqYtuxqK6vET4dNSTmhVzq3xmYXzWPiF2h9708EsnCH59nmZmSehMd
	dQTUSAqjCoks6k7ArvVYFZuZ7CzU15+fDPFG7T9L90Yx336/KlmvUjonZxt3yNm26Z4SeRuEQ+P
	Sko0nkjxru02LvyOpoa/7g5NYrXGsye4R1jmy2y9XT2u1s+cUddT5Cs0BR/4NRan3Px2LECG9BL
	vLtIgb/WGEslU3NLDNGiC8Qk3mbag2o/usgKFiajQVyVEOfmFrZ0pHwx9VY10Ue7CDRgZ6/GTKv
	VbQwC7q4iJBQzn6uSQ==
X-Received: by 2002:a17:90b:2f83:b0:359:84e1:ba2e with SMTP id
 98e67ed59e1d1-35984e1bdc4mr4775927a91.18.1772450819569; Mon, 02 Mar 2026
 03:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Mon, 2 Mar 2026 19:26:48 +0800
X-Gm-Features: AaiRm533C-dgJQwMV9wJ4ExtuX_4f-VQzKwl1m8lwYeHNruIGuVT1r6C5H24QvM
Message-ID: <CAPHJ_VLUpgBO7VfF4ih2oy2HDCxvxkHRkryFUjHAm8QTNdF6Sg@mail.gmail.com>
Subject: [BUG] RCU stall / hung rcu_gp: process_srcu blocked in
 synchronize_rcu_normal triggered by perf trace teardown on 7.0.0-rc1
To: paulmck@kernel.org, peterz@infradead.org, mhiramat@kernel.org
Cc: jiangshanlai@gmail.com, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, rcu@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am reporting an RCU stall / hung task issue triggered by a syzkaller
reproducer on Linux 7.0.0-rc1.

The system gets stuck with RCU stalls and multiple hung tasks. The
rcu_gp workqueue shows in-flight =E2=80=9Cprocess_srcu=E2=80=9D, and kworke=
rs running
=E2=80=9Cprocess_srcu=E2=80=9D are blocked for >143s. At the same time, a r=
epro task
blocks during perf event teardown (close()), waiting on SRCU.

Key log excerpts:

=E2=80=9CShowing busy workqueues and worker pools: workqueue rcu_gp ...
in-flight: process_srcu=E2=80=9D

=E2=80=9Crcu: INFO: rcu_preempt detected stalls on CPUs/tasks ... Tasks
blocked on level-0 rcu_node ...=E2=80=9D

hung tasks:

kworker/... Workqueue: rcu_gp process_srcu
process_srcu -> try_check_zero -> synchronize_rcu_normal -> wait_for_comple=
tion

repro2 task blocked in close():
__x64_sys_close -> __fput -> perf_release -> perf_event_release_kernel
-> __free_event
-> perf_trace_destroy -> perf_trace_event_unreg -> __synchronize_srcu
-> wait_for_completion

My understanding / suspected wait chain:

repro task closes a perf fd and enters perf trace teardown:
perf_trace_event_unreg() waits for SRCU via __synchronize_srcu().

rcu_gp workers running process_srcu attempt to advance SRCU and end up call=
ing
synchronize_rcu_normal(), waiting for a normal RCU grace period to complete=
.

RCU grace period does not complete (RCU stall reported on CPUs/tasks), caus=
ing:
__synchronize_srcu() to wait indefinitely, process_srcu to remain
blocked, and the system to stall.

This looks like a circular wait involving perf trace teardown + SRCU +
RCU GP progress (possibly aggravated by timing/RT scheduling).

Reproducer:
C reproducer:  https://pastebin.com/raw/L9hDPCrP
kernel config:  https://pastebin.com/raw/jCq8qdq7
console output : https://pastebin.com/raw/D8XETkeH

Kernel:
git tree: torvalds/linux
commit: 4d349ee5c7782f8b27f6cb550f112c5e26fff38d
kernel version: 7.0.0-rc1
hardware: QEMU Ubuntu 24.10


[  170.750583] Showing busy workqueues and worker pools:
[  170.750595] workqueue rcu_gp: flags=3D0x108
[  170.750609]   pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 r=
efcnt=3D3
[  170.750635]     in-flight: 9:process_srcu ,11:process_srcu
[  170.750723] pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D0s
workers=3D4 idle: 220
[  173.609623] perf: interrupt took too long (69138 > 69021), lowering
kernel.pe0
[  173.918434] perf: interrupt took too long (86584 > 86422), lowering
kernel.pe0
[  174.394436] perf: interrupt took too long (109613 > 108230),
lowering kernel.0
[  174.633565] perf: interrupt took too long (137226 > 137016),
lowering kernel.0
[  174.652442] perf: interrupt took too long (171805 > 171532),
lowering kernel.0
[  174.679472] perf: interrupt took too long (214868 > 214756),
lowering kernel.0
[  174.728383] perf: interrupt took too long (268722 > 268585),
lowering kernel.0
[  174.882802] perf: interrupt took too long (336002 > 335902),
lowering kernel.0
[  271.443907] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  271.443951] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-1): P4093
[  271.443972] rcu:     (detected by 1, t=3D105002 jiffies, g=3D33573,
q=3D4342 ncpus=3D2)
[  271.443986] task:repro2          state:R  running task
stack:28792 pid:4093  tgid:4092  ppid:300    task_flags:0x400140
flags:0x00080012
[  271.444042] Call Trace:
[  271.444051]  <IRQ>
[  271.444058]  sched_show_task+0x3b5/0x650
[  271.444088]  ? trace_event_raw_event_sched_pi_setprio+0x440/0x440
[  271.444121]  ? rcu_dump_cpu_stacks+0x337/0x4b0
[  271.444146]  ? write_comp_data+0x1f/0x70
[  271.444164]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  271.444182]  ? wq_watchdog_touch+0xec/0x170
[  271.444198]  rcu_sched_clock_irq+0x297b/0x31c0
[  271.444221]  ? tmigr_requires_handle_remote_up+0x143/0x1c0
[  271.444245]  ? rcu_momentary_eqs+0x40/0x40
[  271.444261]  ? __tmigr_cpu_deactivate+0x1a0/0x1a0
[  271.444283]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  271.444301]  ? tmigr_requires_handle_remote+0x1cd/0x2a0
[  271.444324]  ? tmigr_handle_remote+0x320/0x320
[  271.444348]  ? write_comp_data+0x1f/0x70
[  271.444366]  ? write_comp_data+0x1f/0x70
[  271.444383]  ? __cgroup_account_cputime_field+0xb9/0x160
[  271.444406]  ? write_comp_data+0x1f/0x70
[  271.444424]  ? hrtimer_run_queues+0x64/0x450
[  271.444447]  update_process_times+0xfa/0x200
[  271.444469]  tick_nohz_handler+0x504/0x720
[  271.444487]  ? find_held_lock+0x2b/0x80
[  271.444505]  ? tick_do_update_jiffies64+0x380/0x380
[  271.444523]  ? lock_release+0xc9/0x2a0
[  271.444548]  __hrtimer_run_queues+0x771/0xb20
[  271.444568]  ? tick_do_update_jiffies64+0x380/0x380
[  271.444589]  ? write_comp_data+0x1f/0x70
[  271.444607]  ? enqueue_hrtimer+0x360/0x360
[  271.444626]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  271.444649]  hrtimer_interrupt+0x36e/0x820
[  271.444676]  __sysvec_apic_timer_interrupt+0xb5/0x3b0
[  271.444695]  sysvec_apic_timer_interrupt+0x6b/0x80
[  271.444720]  </IRQ>
[  271.444724]  <TASK>
[  271.444730]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  271.444748] RIP: 0010:finish_task_switch+0x126/0x5c0
[  271.444771] Code: f6 4d 8d 7d 48 e8 8a 45 0a 00 31 f6 4c 89 ef e8
b0 fb ff ff 4c 89 ff e8 88 db b9 02 e8 93 c6 34 00 fb 65 4c 8b 3d 5a
34 cb 04 <49> 8d bf c8 14 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa
48 c1
[  271.444786] RSP: 0018:ffff888009db79b0 EFLAGS: 00000202
[  271.444798] RAX: 00000000001a071f RBX: ffff88800d6b4c80 RCX: 00000000000=
00006
[  271.444808] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff814=
67bbd
[  271.444817] RBP: ffff888009db79f8 R08: 0000000000000001 R09: 00000000000=
00001
[  271.444826] R10: fffffbfff0ae32ea R11: ffffffff85719757 R12: ffff8880073=
f9a80
[  271.444836] R13: ffff88806d338fc0 R14: 0000000000000001 R15: ffff888009d=
19a80
[  271.444852]  ? finish_task_switch+0x11d/0x5c0
[  271.444876]  ? finish_task_switch+0xe0/0x5c0
[  271.444897]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  271.444914]  ? __switch_to+0x854/0x1270
[  271.444936]  __schedule+0x1198/0x4190
[  271.444957]  ? io_schedule_timeout+0x80/0x80
[  271.444974]  ? mark_held_locks+0x49/0x70
[  271.444998]  preempt_schedule_irq+0x4e/0x90
[  271.445015]  irqentry_exit+0x17b/0x6c0
[  271.445037]  ? irqentry_enter+0x2a/0xd0
[  271.445058]  ? trace_hardirqs_off_finish+0x12f/0x160
[  271.445080]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  271.445096] RIP: 0010:__sanitizer_cov_trace_pc+0xd/0x40
[  271.445127] Code: 00 00 ff 00 09 c2 75 07 4c 8b 81 e0 14 00 00 4c
89 c0 c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa bf 02 00 00 00 4c
8b 0c 24 <65> 48 8b 35 9b a7 9e 04 e8 46 ff ff ff 84 c0 74 20 48 8b 96
d0 14
[  271.445141] RSP: 0018:ffff888009db7c28 EFLAGS: 00000246
[  271.445152] RAX: dffffc0000000000 RBX: ffff88800df47b58 RCX: 00000000000=
00000
[  271.445161] RDX: 1ffff11001be8f71 RSI: ffff888009d19a80 RDI: 00000000000=
00002
[  271.445171] RBP: ffff888009d18000 R08: 0000000000000000 R09: ffffffff816=
7adf7
[  271.445180] R10: ffffed1001d87110 R11: ffff88800ec38883 R12: 00000000000=
00001
[  271.445190] R13: ffff888009db7cd0 R14: ffff888009d18028 R15: 00000000000=
000ec
[  271.445203]  ? __futex_wake_mark+0xb7/0xe0
[  271.445222]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  271.445240]  __futex_wake_mark+0xb7/0xe0
[  271.445255]  futex_wake_mark+0xa4/0x190
[  271.445272]  futex_wake+0x441/0x540
[  271.445289]  ? futex_wake_mark+0x190/0x190
[  271.445306]  ? percpu_counter_add_batch+0x11b/0x260
[  271.445329]  ? write_comp_data+0x1f/0x70
[  271.445348]  do_futex+0x26b/0x360
[  271.445363]  ? __ia32_sys_get_robust_list+0x140/0x140
[  271.445380]  ? lock_is_held_type+0x9b/0x110
[  271.445404]  __x64_sys_futex+0x1c9/0x480
[  271.445420]  ? do_futex+0x360/0x360
[  271.445433]  ? write_comp_data+0x1f/0x70
[  271.445450]  ? fd_install+0x1ec/0x4e0
[  271.445471]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  271.445488]  ? __sys_socket+0x4b/0x130
[  271.445508]  do_syscall_64+0x115/0x690
[  271.445529]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  271.445544] RIP: 0033:0x7fdfffbe4fc9
[  271.445568] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 8e 0d 00 f7 d8 64 89
01 48
[  271.445582] RSP: 002b:00007fdfffaebde8 EFLAGS: 00000246 ORIG_RAX:
00000000000000ca
[  271.445595] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdfffb=
e4fc9
[  271.445605] RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000055b24d1=
850ec
[  271.445614] RBP: 00007fdfffaebe00 R08: 0000000000000000 R09: 00000000000=
00000
[  271.445623] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffb7d=
2901e
[  271.445632] R13: 00007fffb7d2901f R14: 00007fdfffaebf00 R15: 00000000000=
22000
[  271.445650]  </TASK>
[  318.431885] INFO: task kworker/0:0:9 blocked for more than 143 seconds.
[  318.431913]       Not tainted 7.0.0-rc1-00301-g4d349ee5c778 #1
[  318.431921] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  318.431928] task:kworker/0:0     state:D stack:27912 pid:9
tgid:9     ppid:2      task_flags:0x4208060 flags:0x00080000
[  318.431983] Workqueue: rcu_gp process_srcu
[  318.432032] Call Trace:
[  318.432038]  <TASK>
[  318.432049]  __schedule+0x1190/0x4190
[  318.432078]  ? io_schedule_timeout+0x80/0x80
[  318.432095]  ? lock_release+0xc9/0x2a0
[  318.432119]  schedule+0xd1/0x260
[  318.432134]  schedule_timeout+0x240/0x280
[  318.432157]  ? hrtimer_nanosleep_restart+0x340/0x340
[  318.432182]  ? mark_held_locks+0x49/0x70
[  318.432203]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  318.432224]  ? _raw_spin_unlock_irq+0x23/0x40
[  318.432245]  ? trace_hardirqs_on+0x18/0x170
[  318.432267]  wait_for_completion+0x169/0x320
[  318.432286]  ? wait_for_completion_killable+0x410/0x410
[  318.432304]  ? mark_held_locks+0x49/0x70
[  318.432324]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  318.432348]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[  318.432372]  ? trace_hardirqs_on+0x18/0x170
[  318.432390]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[  318.432414]  synchronize_rcu_normal+0x208/0x5f0
[  318.432433]  ? start_poll_synchronize_rcu_full+0x90/0x90
[  318.432453]  ? do_raw_spin_lock+0x123/0x290
[  318.432481]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[  318.432504]  ? rt_mutex_slowunlock+0x824/0xaf0
[  318.432526]  ? lock_is_held_type+0x9b/0x110
[  318.432555]  try_check_zero+0x429/0x630
[  318.432583]  process_srcu+0x4c1/0x16c0
[  318.432607]  ? lock_acquire+0x187/0x2e0
[  318.432626]  ? process_scheduled_works+0x4ca/0x1ac0
[  318.432650]  ? lock_release+0xc9/0x2a0
[  318.432674]  process_scheduled_works+0x553/0x1ac0
[  318.432704]  ? insert_work+0x190/0x190
[  318.432723]  ? write_comp_data+0x1f/0x70
[  318.432741]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  318.432761]  ? lock_is_held_type+0x9b/0x110
[  318.432784]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  318.432805]  worker_thread+0x5a9/0xd10
[  318.432830]  ? bh_worker+0x740/0x740
[  318.435937]  kthread+0x3f9/0x530
[  318.435991]  ? kthread_affine_node+0x2a0/0x2a0
[  318.436060]  ret_from_fork+0x666/0xab0
[  318.436098]  ? native_tss_update_io_bitmap+0x6c0/0x6c0
[  318.436139]  ? write_comp_data+0x1f/0x70
[  318.436175]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  318.436213]  ? __switch_to+0x854/0x1270
[  318.436255]  ? kthread_affine_node+0x2a0/0x2a0
[  318.436301]  ret_from_fork_asm+0x11/0x20
[  318.436360]  </TASK>
[  318.436373] INFO: task kworker/0:1:11 blocked for more than 143 seconds.
[  318.436393]       Not tainted 7.0.0-rc1-00301-g4d349ee5c778 #1
[  318.436411] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  318.436422] task:kworker/0:1     state:D stack:26592 pid:11
tgid:11    ppid:2      task_flags:0x4208060 flags:0x00080000
[  318.436528] Workqueue: rcu_gp process_srcu
[  318.436571] Call Trace:
[  318.436580]  <TASK>
[  318.436595]  __schedule+0x1190/0x4190
[  318.436639]  ? io_schedule_timeout+0x80/0x80
[  318.436676]  ? lock_release+0xc9/0x2a0
[  318.436726]  schedule+0xd1/0x260
[  318.436759]  schedule_timeout+0x240/0x280
[  318.436804]  ? hrtimer_nanosleep_restart+0x340/0x340
[  318.522895]  ? mark_held_locks+0x49/0x70
[  318.522930]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  318.522952]  ? _raw_spin_unlock_irq+0x23/0x40
[  318.522977]  ? trace_hardirqs_on+0x18/0x170
[  318.523008]  wait_for_completion+0x169/0x320
[  318.523029]  ? wait_for_completion_killable+0x410/0x410
[  318.523047]  ? mark_held_locks+0x49/0x70
[  318.523068]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  318.523088]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[  318.523110]  ? trace_hardirqs_on+0x18/0x170
[  318.523128]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[  318.523152]  synchronize_rcu_normal+0x208/0x5f0
[  318.523171]  ? start_poll_synchronize_rcu_full+0x90/0x90
[  318.523190]  ? do_raw_spin_lock+0x123/0x290
[  318.523219]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[  318.523242]  ? rt_mutex_slowunlock+0x824/0xaf0
[  318.523264]  ? lock_is_held_type+0x9b/0x110
[  318.523294]  try_check_zero+0x429/0x630
[  318.523321]  process_srcu+0x4c1/0x16c0
[  318.523346]  ? lock_acquire+0x187/0x2e0
[  318.523365]  ? process_scheduled_works+0x4ca/0x1ac0
[  318.523389]  ? lock_release+0xc9/0x2a0
[  318.523412]  process_scheduled_works+0x553/0x1ac0
[  318.523442]  ? insert_work+0x190/0x190
[  318.523461]  ? write_comp_data+0x1f/0x70
[  318.523478]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  318.523498]  ? lock_is_held_type+0x9b/0x110
[  318.523521]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  318.523541]  worker_thread+0x5a9/0xd10
[  318.523566]  ? bh_worker+0x740/0x740
[  318.523587]  kthread+0x3f9/0x530
[  318.523605]  ? kthread_affine_node+0x2a0/0x2a0
[  318.523627]  ret_from_fork+0x666/0xab0
[  318.523645]  ? native_tss_update_io_bitmap+0x6c0/0x6c0
[  318.523664]  ? write_comp_data+0x1f/0x70
[  318.523680]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  318.523698]  ? __switch_to+0x854/0x1270
[  318.523717]  ? kthread_affine_node+0x2a0/0x2a0
[  318.523738]  ret_from_fork_asm+0x11/0x20
[  318.523764]  </TASK>
[  318.526244] INFO: task repro2:4086 blocked for more than 143 seconds.
[  318.526258]       Not tainted 7.0.0-rc1-00301-g4d349ee5c778 #1
[  318.526267] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  318.526273] task:repro2          state:D stack:25512 pid:4086
tgid:4086  ppid:298    task_flags:0x400040 flags:0x00080002
executing program[  318.526322] Call Trace:
[  318.526327]  <TASK>

[  318.526334]  __schedule+0x1190/0x4190
[  318.526356]  ? io_schedule_timeout+0x80/0x80
[  318.526373]  ? lock_release+0xc9/0x2a0
[  318.526396]  schedule+0xd1/0x260
[  318.526411]  schedule_timeout+0x240/0x280
[  318.526432]  ? hrtimer_nanosleep_restart+0x340/0x340
[  318.526458]  ? mark_held_locks+0x49/0x70
[  318.526478]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  318.526499]  ? _raw_spin_unlock_irq+0x23/0x40
[  318.526520]  ? trace_hardirqs_on+0x18/0x170
[  318.526539]  wait_for_completion+0x169/0x320
[  318.526556]  ? __lock_acquire+0x55a/0x1ef0
[  318.526577]  ? wait_for_completion_killable+0x410/0x410
[  318.526597]  ? lockdep_init_map_type+0x4b/0x210
[  318.526621]  __synchronize_srcu+0x143/0x230
[  318.526643]  ? start_poll_synchronize_srcu+0x10/0x10
[  318.526666]  ? rcu_tasks_pregp_step+0x10/0x10
[  318.526687]  ? kvm_clock_read+0x3b/0x60
[  318.526707]  ? write_comp_data+0x1f/0x70
[  318.526723]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[  318.526741]  ? ktime_get_mono_fast_ns+0x19d/0x2b0
[  318.526766]  ? synchronize_srcu+0x53/0x260
[  318.526789]  perf_trace_event_unreg.isra.0+0xb8/0x1e0
[  318.526807]  perf_trace_destroy+0xc3/0x1c0
[  318.526822]  ? perf_tp_event_init+0x120/0x120
[  318.529171]  __free_event+0x257/0xc10
[  318.529200]  ? perf_event_release_kernel+0x460/0x460
[  318.529215]  put_event+0x3c/0x90
[  318.529230]  perf_event_release_kernel+0x357/0x460
[  318.529248]  ? perf_event_release_kernel+0x460/0x460
[  318.529263]  perf_release+0x37/0x50
[  318.529277]  __fput+0x420/0xb80
[  318.529303]  fput_close_sync+0x10f/0x230
[  318.529325]  ? alloc_file_clone+0x110/0x110
[  318.529345]  ? dnotify_flush+0x7f/0x4c0
[  318.529372]  __x64_sys_close+0x8f/0x120
[  318.529390]  do_syscall_64+0x115/0x690
[  318.529410]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  318.529425] RIP: 0033:0x7fdfffcd611b
[  318.529436] RSP: 002b:00007fffb7d290d0 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[  318.529450] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdfffc=
d611b
[  318.529460] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00005
[  318.529469] RBP: 00007fffb7d29100 R08: 0000000000000000 R09: 00000000000=
00032
[  318.529478] R10: 0000000000000000 R11: 0000000000000293 R12: 000055b24d1=
6e3f0
[  318.529486] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[  318.529503]  </TASK>


Could you please advise whether this is a known issue/regression, and
what additional debug data would be most helpful? I can rerun with
extra debugging options if needed.

Thanks,
Zw Tang
