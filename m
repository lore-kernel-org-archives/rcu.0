Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F7253B5A;
	Wed, 21 May 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820607; cv=none; b=USStwPEQS2KlwC8lgJEG5bHjVmg+dxOOuaiECwV9qBLqVn5AImZgLrR2eJoNFqqdJ9UREVNm00qk191Q2nTzUTI9T5lb/6xZKinjMPDAKCL1jIwH/NAxppo993YdLo0JtslRJEjljmrSnZgKPg1uWOJaOn8AkWbpEd63f+P82BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820607; c=relaxed/simple;
	bh=AB6vrtrGKSOlL4+NIB8XxZHaFKUtRBpHMQJtFBmqnTA=;
	h=To:CC:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=K8SyqDF8JD6joOZTlYAxYZfRR+8Hr+aE9EUnl2BGHlC4/HoOK6dyyu13DfbAw/JsRq/W9XNVOCVgngJj3qIrghEPUWrs09y7OKHmEVDP645dtfJSg7EQvK/5Mt78LhEQtXqJi/HIyuxqes6PhmeaAZUOyb/5jNTM/XAlN3Y/UpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4b2RK42XjxzVmcT;
	Wed, 21 May 2025 17:42:00 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id EEA6F18006C;
	Wed, 21 May 2025 17:43:15 +0800 (CST)
Received: from kwepemq500009.china.huawei.com (7.202.195.53) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 May 2025 17:43:15 +0800
Received: from [10.174.179.5] (10.174.179.5) by kwepemq500009.china.huawei.com
 (7.202.195.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 May
 2025 17:43:14 +0800
To: <ankur.a.arora@oracle.com>, Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	<neeraj.upadhyay@kernel.org>, <urezki@gmail.com>
CC: <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <xiqi2@huawei.com>,
	"Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
Message-ID: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
Date: Wed, 21 May 2025 17:43:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500009.china.huawei.com (7.202.195.53)

Hi RCU experts,

When I ran syskaller in Linux 6.6 with CONFIG_PREEMPT_RCU enabled, I got
the following soft lockup. The Calltrace is too long. I put it in the end.
The issue can also be reproduced in the latest kernel.

The issue is as follows. CPU3 is waiting for a spin_lock, which is got by CPU1.
But CPU1 stuck in the following dead loop.

irq_exit()
  __irq_exit_rcu()
    /* in_hardirq() returns false after this */
    preempt_count_sub(HARDIRQ_OFFSET)
    tick_irq_exit()
      tick_nohz_irq_exit()
	    tick_nohz_stop_sched_tick()
	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
		   __bpf_trace_tick_stop()
		      bpf_trace_run2()
			    rcu_read_unlock_special()
                              /* will send a IPI to itself */
			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);

/* after interrupt is enabled again, the irq_work is called */
asm_sysvec_irq_work()
  sysvec_irq_work()
irq_exit() /* after handled the irq_work, we again enter into irq_exit() */
  __irq_exit_rcu()
    ...skip...
	   /* we queue a irq_work again, and enter a dead loop */
	   irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
	
I am not familiar with RCU code and don't know how to solve this problem.
Any guidance would be appreciated.

Thanks,
Xiongfeng


[ 1901.634222][    C3] watchdog: BUG: soft lockup - CPU#3 stuck for 913s!
[syz.8.781:8076]
[ 1901.634947][    C3] Modules linked in:
[ 1901.635261][    C3] CPU: 3 PID: 8076 Comm: syz.8.781 Tainted: G             L
    6.6.0+ #1873
[ 1901.635981][    C3] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 0.0.0 02/06/2015
[ 1901.636735][    C3] RIP: 0010:queued_spin_lock_slowpath+0x109/0x9c0
[ 1901.637281][    C3] Code: 00 48 8b 44 24 60 65 48 2b 04 25 28 00 00 00 0f 85
ca 07 00 00 48 83 c4 68 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc f3 90 <eb>
85 81 fe 00 01 00 00 0f 84 dc 00 00 00 81 fe ff 00 00 00 0f 87
[ 1901.638858][    C3] RSP: 0000:ff1100002900f8b0 EFLAGS: 00000202
[ 1901.639364][    C3] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
ffffffff961f5ecd
[ 1901.640001][    C3] RDX: fffa7c000005f936 RSI: 0000000000000004 RDI:
ffd40000002fc9a8
[ 1901.640624][    C3] RBP: 0000000000000003 R08: 0000000000000000 R09:
fffa7c000005f935
[ 1901.641255][    C3] R10: ffd40000002fc9ab R11: 0000000000000000 R12:
fffa7c000005f935
[ 1901.641905][    C3] R13: 0000000000000001 R14: 1fe2200005201f17 R15:
ffd40000002fc9a8
[ 1901.642527][    C3] FS:  000000002316c500(0000) GS:ff11000107980000(0000)
knlGS:0000000000000000
[ 1901.643272][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1901.643818][    C3] CR2: 0000000020000000 CR3: 0000000036592004 CR4:
0000000000771ee0
[ 1901.644469][    C3] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1901.645105][    C3] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 1901.645724][    C3] PKRU: 80000000
[ 1901.646010][    C3] Call Trace:
[ 1901.646287][    C3]  <TASK>
[ 1901.646526][    C3]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
[ 1901.647053][    C3]  _raw_spin_lock+0xd0/0xe0
[ 1901.647450][    C3]  ? __pfx__raw_spin_lock+0x10/0x10
[ 1901.647883][    C3]  __pte_offset_map_lock+0x129/0x270
[ 1901.648335][    C3]  ? __pfx___pte_offset_map_lock+0x10/0x10
[ 1901.648820][    C3]  migration_entry_wait+0x85/0x270
[ 1901.649247][    C3]  ? __pfx_migration_entry_wait+0x10/0x10
[ 1901.649705][    C3]  ? __pfx___schedule+0x10/0x10
[ 1901.650122][    C3]  ? __hrtimer_start_range_ns+0x355/0xd00
[ 1901.650623][    C3]  do_swap_page+0x36d2/0x4670
[ 1901.651016][    C3]  ? plist_del+0x24c/0x450
[ 1901.651453][    C3]  ? __pte_offset_map+0x2b9/0x3d0
[ 1901.651981][    C3]  ? __pfx_do_swap_page+0x10/0x10
[ 1901.652432][    C3]  ? __pfx_default_wake_function+0x10/0x10
[ 1901.652947][    C3]  handle_pte_fault+0x5ae/0x7b0
[ 1901.653387][    C3]  __handle_mm_fault+0xf9e/0x17f0
[ 1901.653839][    C3]  ? __pfx___handle_mm_fault+0x10/0x10
[ 1901.654335][    C3]  ? lock_vma_under_rcu+0x377/0x4d0
[ 1901.654797][    C3]  ? __pfx_lock_vma_under_rcu+0x10/0x10
[ 1901.655294][    C3]  handle_mm_fault+0x4bf/0xa20
[ 1901.655725][    C3]  exc_page_fault+0x20b/0x7f0
[ 1901.656150][    C3]  asm_exc_page_fault+0x26/0x30
[ 1901.656582][    C3] RIP: 0033:0x51d788
[ 1901.656927][    C3] Code: 66 89 74 17 02 88 0f c3 c5 fa 6f 06 c5 fa 6f 4c 16
f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 0f 1f 44 00 00 48 8b 4c 16 f8 48 8b 36 <48>
89 37 48 89 4c 17 f8 c3 62 e1 fe 28 6f 54 16 ff 62 e1 fe 28 6f
[ 1901.658618][    C3] RSP: 002b:00007fff991f9118 EFLAGS: 00010202
[ 1901.659157][    C3] RAX: 0000000020000000 RBX: 0000000000000004 RCX:
002367732f766564
[ 1901.659856][    C3] RDX: 0000000000000009 RSI: 2367732f7665642f RDI:
0000000020000000
[ 1901.660553][    C3] RBP: 0000000000797ba0 R08: 00007f10a7800000 R09:
0000000000000001
[ 1901.661240][    C3] R10: 0000000000000001 R11: 0000000000000009 R12:
0000000000000032
[ 1901.661906][    C3] R13: 00000000000e2c77 R14: 0000000000795fa0 R15:
0000000000795fac
[ 1901.662589][    C3]  </TASK>
[ 1901.662864][    C3] Sending NMI from CPU 3 to CPUs 0-2:
[ 1901.663358][    C1] NMI backtrace for cpu 1
[ 1901.663365][    C1] AAA2 1901441189248 1901441163169 0 0 0 1901441162197
[ 1901.663374][    C1] AAA2 1901441197984 993372484411 993372484804 993372484875
928887973527 928887973577 928887974425 // handle_softirqs
[ 1901.663383][    C1] softirq_handle_start:
[ 1901.663385][    C1] 0
[ 1901.663387][    C1] 928330006990
[ 1901.663390][    C1] 924221567459
[ 1901.663392][    C1] 928817263100
[ 1901.663395][    C1] 928328744939
[ 1901.663397][    C1] 0
[ 1901.663399][    C1] 921062008817
[ 1901.663401][    C1] 928879010614
[ 1901.663403][    C1] 0
[ 1901.663405][    C1] 928887973635
[ 1901.663407][    C1]
[ 1901.663409][    C1] softirq_handle_end_time:
[ 1901.663410][    C1] 0
[ 1901.663412][    C1] 928330009295
[ 1901.663415][    C1] 924221568491
[ 1901.663417][    C1] 928817511439
[ 1901.663419][    C1] 928328806233
[ 1901.663421][    C1] 0
[ 1901.663423][    C1] 921062009968
[ 1901.663425][    C1] 928879011708
[ 1901.663427][    C1] 0
[ 1901.663429][    C1] 928887974243
[ 1901.663432][    C1]
[ 1901.663434][    C1] CPU: 1 PID: 8079 Comm: syz.8.781 Tainted: G             L
    6.6.0+ #1873
[ 1901.663444][    C1] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 0.0.0 02/06/2015
[ 1901.663448][    C1] RIP: 0010:irq_work_claim+0x5c/0xa0
[ 1901.663464][    C1] Code: 14 02 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2
75 44 8b 5b 08 e8 c3 74 e7 ff 89 da 41 89 dc 89 d8 83 ca 23 f0 0f b1 55 00 <41>
0f 94 c5 31 ff 89 c3 44 89 ee e8 74 6a e7 ff 45 84 ed 74 d7 e8
[ 1901.663473][    C1] RSP: 0018:ff11000107889c68 EFLAGS: 00000046
[ 1901.663480][    C1] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
ffffffff8dc11a4d
[ 1901.663486][    C1] RDX: 0000000000000023 RSI: 0000000000000004 RDI:
ff110001078c6838
[ 1901.663491][    C1] RBP: ff110001078c6838 R08: 0000000000000001 R09:
ffe21c0020f18d07
[ 1901.663496][    C1] R10: ff110001078c683b R11: 0000000000000000 R12:
0000000000000000
[ 1901.663502][    C1] R13: ff110001078c6bf0 R14: 0000000000000000 R15:
ffffffff99f43000
[ 1901.663507][    C1] FS:  00007f10a79556c0(0000) GS:ff11000107880000(0000)
knlGS:0000000000000000
[ 1901.663517][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1901.663523][    C1] CR2: 0000000000638300 CR3: 0000000036592002 CR4:
0000000000771ee0
[ 1901.663529][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1901.663534][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 1901.663539][    C1] PKRU: 00000000
[ 1901.663542][    C1] Call Trace:
[ 1901.663546][    C1]  <IRQ>
[ 1901.663551][    C1]  irq_work_queue_on+0x59/0x130
[ 1901.663563][    C1]  rcu_read_unlock_special+0x46a/0x530
[ 1901.663577][    C1]  bpf_trace_run2+0xf7/0x220
[ 1901.663588][    C1]  ? __pfx_bpf_trace_run2+0x10/0x10
[ 1901.663599][    C1]  ? __pfx_ep_poll_callback+0x10/0x10
[ 1901.663613][    C1]  __bpf_trace_tick_stop+0xb4/0xf0
[ 1901.663623][    C1]  ? __pfx___bpf_trace_tick_stop+0x10/0x10
[ 1901.663633][    C1]  ? __pfx_sched_clock_cpu+0x10/0x10
[ 1901.663643][    C1]  ? __wake_up+0x44/0x60
[ 1901.663657][    C1]  check_tick_dependency+0x362/0x670
[ 1901.663673][    C1]  __tick_nohz_full_update_tick+0xd1/0x220
[ 1901.663683][    C1]  tick_nohz_irq_exit+0x22c/0x2a0
[ 1901.663694][    C1]  sysvec_irq_work+0x36/0x80
[ 1901.663705][    C1]  asm_sysvec_irq_work+0x1a/0x20
[ 1901.663720][    C1] RIP: 0010:handle_softirqs+0x230/0x8d0
[ 1901.663734][    C1] Code: 24 f5 80 5d 84 98 e8 1f 9b 27 00 4c 89 e2 48 c1 ea
03 42 80 3c 3a 00 0f 85 d5 05 00 00 49 89 04 24 fb 65 44 8b 35 0c 2c 93 72 <4d>
63 f6 49 c7 c4 20 0c 03 00 4a 8d 3c f5 80 5d 84 98 48 89 f8 48
[ 1901.663742][    C1] RSP: 0018:ff11000107889f68 EFLAGS: 00000246
[ 1901.663748][    C1] RAX: 000000e7499d350b RBX: 0000000000000000 RCX:
0000000000000018
[ 1901.663754][    C1] RDX: 1fe2200020f16185 RSI: 00000000001e2170 RDI:
0000000000000004
[ 1901.663759][    C1] RBP: ff1100003ae422c0 R08: 0000000000000001 R09:
ffe21c0020f16239
[ 1901.663765][    C1] R10: 00000000001e2170 R11: 3030303030302052 R12:
ff110001078b0c28
[ 1901.663770][    C1] R13: 0000000000400140 R14: 0000000000000001 R15:
dffffc0000000000
[ 1901.663779][    C1]  ? handle_softirqs+0x211/0x8d0
[ 1901.663792][    C1]  ? update_sibling_normalize_runtime+0x1a/0x410
[ 1901.663807][    C1]  irq_exit_rcu+0x134/0x190
[ 1901.663820][    C1]  sysvec_irq_work+0x6a/0x80
[ 1901.663830][    C1]  </IRQ>
[ 1901.663833][    C1]  <TASK>
[ 1901.663835][    C1]  asm_sysvec_irq_work+0x1a/0x20
[ 1901.663849][    C1] RIP: 0010:rcu_read_unlock_special+0x186/0x530
[ 1901.663861][    C1] Code: 0f 85 01 01 00 00 4d 85 f6 0f 84 6a 01 00 00 40 84
ed 0f 84 61 01 00 00 bf 09 00 00 00 e8 c2 45 df ff fb 65 8b 2d 26 65 72 72 <48>
63 ed 48 c7 c3 40 1a 03 00 48 b8 00 00 00 00 00 fc ff df 48 8d
[ 1901.663869][    C1] RSP: 0018:ff110000380b6fe8 EFLAGS: 00000283
[ 1901.663875][    C1] RAX: 0000000000000001 RBX: ff110001078c6800 RCX:
ffffffff8d7c6a90
[ 1901.663881][    C1] RDX: 0000000000000001 RSI: 0000000000000046 RDI:
ff11000100e33084
[ 1901.663886][    C1] RBP: 0000000000000001 R08: 0000000000000000 R09:
fffffbfff3716ab4
[ 1901.663891][    C1] R10: 0000000000000000 R11: 0000000000000001 R12:
0000000000000000
[ 1901.663896][    C1] R13: dffffc0000000000 R14: 0000000000000200 R15:
ffffffff99f43000
[ 1901.663903][    C1]  ? ttwu_do_activate+0x520/0x6f0
[ 1901.663918][    C1]  ? rcu_read_unlock_special+0x17e/0x530
[ 1901.663930][    C1]  page_vma_mapped_walk+0x1e00/0x2b50
[ 1901.663948][    C1]  ? __netlink_deliver_tap_skb+0x352/0x4d0
[ 1901.663959][    C1]  ? __pfx_page_vma_mapped_walk+0x10/0x10
[ 1901.663974][    C1]  ? netlink_ack+0x614/0xba0
[ 1901.663986][    C1]  try_to_migrate_one+0x3f0/0x2cb0
[ 1901.663999][    C1]  ? __sys_sendmsg+0xee/0x1b0
[ 1901.664015][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
[ 1901.664028][    C1]  ? __orc_find+0x109/0x140
[ 1901.664041][    C1]  ? arch_stack_walk+0x92/0x160
[ 1901.664058][    C1]  ? __anon_vma_interval_tree_subtree_search+0x171/0x1f0
[ 1901.664080][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
[ 1901.664094][    C1]  rmap_walk_anon+0x2b0/0x980
[ 1901.664108][    C1]  try_to_migrate+0x19f/0x350
[ 1901.664122][    C1]  ? __pfx_try_to_migrate+0x10/0x10
[ 1901.664135][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
[ 1901.664148][    C1]  ? __pfx_folio_not_mapped+0x10/0x10
[ 1901.664159][    C1]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
[ 1901.664173][    C1]  ? __pfx_invalid_migration_vma+0x10/0x10
[ 1901.664184][    C1]  ? folio_total_mapcount+0xb4/0x210
[ 1901.664197][    C1]  split_huge_page_to_list_to_order+0xc84/0x17f0
[ 1901.664213][    C1]  ? __pfx_split_huge_page_to_list_to_order+0x10/0x10
[ 1901.664226][    C1]  ? __orc_find+0x109/0x140
[ 1901.664240][    C1]  ? __orc_find+0x109/0x140
[ 1901.664253][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
[ 1901.664269][    C1]  madvise_cold_or_pageout_pte_range+0x1966/0x2450
[ 1901.664284][    C1]  ? arch_stack_walk+0x92/0x160
[ 1901.664298][    C1]  ? __read_once_word_nocheck+0x9/0x20
[ 1901.664311][    C1]  ? deref_stack_reg+0x1a4/0x2b0
[ 1901.664326][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
[ 1901.664340][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
[ 1901.664354][    C1]  ? __read_once_word_nocheck+0x9/0x20
[ 1901.664368][    C1]  ? __orc_find+0x109/0x140
[ 1901.664381][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
[ 1901.664395][    C1]  walk_pmd_range.isra.0+0x240/0x720
[ 1901.664405][    C1]  ? __read_once_word_nocheck+0x9/0x20
[ 1901.664419][    C1]  walk_pud_range.isra.0+0x3d3/0x6c0
[ 1901.664431][    C1]  walk_p4d_range+0x2ef/0x4f0
[ 1901.664441][    C1]  walk_pgd_range+0x27e/0x530
[ 1901.664452][    C1]  __walk_page_range+0x4ab/0x5a0
[ 1901.664461][    C1]  ? find_vma+0x81/0xb0
[ 1901.664469][    C1]  ? __pfx_find_vma+0x10/0x10
[ 1901.664477][    C1]  ? folios_put_refs+0x510/0x740
[ 1901.664487][    C1]  ? walk_page_test+0xa0/0x190
[ 1901.664503][    C1]  walk_page_range+0x2a0/0x530
[ 1901.664513][    C1]  ? __pfx_walk_page_range+0x10/0x10
[ 1901.664522][    C1]  ? vtime_task_switch_generic+0x278/0x5a0
[ 1901.664535][    C1]  ? folio_batch_move_lru+0x2b8/0x3d0
[ 1901.664544][    C1]  ? __pfx_lru_add_fn+0x10/0x10
[ 1901.664554][    C1]  madvise_pageout_page_range+0x1cc/0x6d0
[ 1901.664567][    C1]  ? __pfx_madvise_pageout_page_range+0x10/0x10
[ 1901.664582][    C1]  madvise_pageout+0x1f4/0x400
[ 1901.664595][    C1]  ? __pfx_madvise_pageout+0x10/0x10
[ 1901.664608][    C1]  ? futex_wait+0x552/0x680
[ 1901.664624][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
[ 1901.664635][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
[ 1901.664645][    C1]  ? mas_prev_setup.constprop.0+0xb4/0x530
[ 1901.664661][    C1]  madvise_vma_behavior+0x8fa/0xe30
[ 1901.664675][    C1]  ? __pfx_madvise_vma_behavior+0x10/0x10
[ 1901.664688][    C1]  ? find_vma_prev+0xf5/0x170
[ 1901.664698][    C1]  ? __pfx_find_vma_prev+0x10/0x10
[ 1901.664711][    C1]  ? do_futex+0x135/0x360
[ 1901.664724][    C1]  do_madvise+0x3af/0x650
[ 1901.664737][    C1]  ? __pfx_do_madvise+0x10/0x10
[ 1901.664749][    C1]  ? __se_sys_futex+0xf7/0x390
[ 1901.664762][    C1]  ? kvm_steal_clock+0xca/0x100
[ 1901.664778][    C1]  ? get_vtime_delta+0xd7/0x250
[ 1901.664793][    C1]  __x64_sys_madvise+0xaf/0x120
[ 1901.664805][    C1]  ? __ct_user_exit+0x70/0xe0
[ 1901.664819][    C1]  do_syscall_64+0x59/0x110
[ 1901.664834][    C1]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[ 1901.664849][    C1] RIP: 0033:0x54d2cd
[ 1901.664856][    C1] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
[ 1901.664864][    C1] RSP: 002b:00007f10a7955048 EFLAGS: 00000246 ORIG_RAX:
000000000000001c
[ 1901.664873][    C1] RAX: ffffffffffffffda RBX: 0000000000795fa0 RCX:
000000000054d2cd
[ 1901.664878][    C1] RDX: 0000000000000015 RSI: 0000000000003000 RDI:
0000000020001000
[ 1901.664884][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[ 1901.664889][    C1] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000795fac
[ 1901.664894][    C1] R13: 0000000000000000 R14: 0000000000795fa0 R15:
00007f10a7935000
