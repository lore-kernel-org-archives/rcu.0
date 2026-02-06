Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720031812E
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363501; cv=none; b=khkiQsgFVZ8sdTuP7ArWQX8q2m4TsKPVcgQqsGCF4TsogeN3BBvepiQp4GIvt/U79NAiGbBvcls5FMbjloZyOvjMwjIA45kVfKjW1NSqS9msyQZGtnysCbSaW0m9uVLIW52D391Dn4gFwW6Xt5ax0pqdzeRABEYjS3GdLLxAdpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363501; c=relaxed/simple;
	bh=Fno2qm6ulhptYKu01FmNso6DHXrwfSjlyh/jO0cae9I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BU3O6rCb3LmjU6x94ashgxzWhH0Ff8bttOI7+ZkDij4yeOpfTDdUNG7y9rUD5KDIS2qqKCfbe0gAG5aQDg5RhL1wV2JW3WhvQJUU8vJ6029EkdK8Zljf5WULNlFM8q4nEv+XAyA1NCnbo9tMSI1niTa3Aj2ukBeDM6L63tQgmWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jOUi5vB9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jOUi5vB9"
Message-ID: <e5ae996b-b5de-46cf-8c1a-532e4852a412@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770363489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSXSTz0W4QxEPrm4qmpvhLbcjqS3K5HHQ7Y8SU9rx/I=;
	b=jOUi5vB9WJEVXrzWPWZuJxLOTe3s0OtdKYnjjA9OyV0yG25wwlcPFJa7op0Bfgskg0H+T2
	PK0pXnoPeNYtWsUPBMKQfuEttn/TQUtZ/49g12FDIXYjgecdwtmDwi9vRQTrz56zUfULef
	W1L1Pciiy7fFNMBMDBKpEk9SMQ4YiWM=
Date: Fri, 6 Feb 2026 15:37:28 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: [BUG] rcu detected stall in shmem_file_write_iter
To: Zw Tang <shicenci@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 rcu@vger.kernel.org
Cc: "hughd@google.com" <hughd@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "david@kernel.org" <david@kernel.org>, chrisl@kernel.org,
 kasong@tencent.com, paulmck@kernel.org, frederic@kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAPHJ_V+75SmoRQmoQmAT0GfdP-JotzwW801uPHZtHyynwdSOgw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPHJ_V+75SmoRQmoQmAT0GfdP-JotzwW801uPHZtHyynwdSOgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/5/26 20:57, Zw Tang wrote:
> Hi,
>
> I am reporting a reproducible RCU stall observed on Linux 6.19.0-rc7,
> triggered by a syzkaller C reproducer.
>
> The stall is reported while a userspace task is executing the tmpfs
> (shmem) write path. The blocked task is a syz-executor process, and the
> RCU report consistently shows it running in the shmem write / folio
> allocation path for an extended period of time.
>
> The relevant call trace of the stalled task is:
>
>   shmem_file_write_iter
>     shmem_write_begin
>       shmem_get_folio_gfp
>         __folio_batch_add_and_move
>           folio_batch_move_lru
>             lru_add
>               __mod_zone_page_state
>
> The kernel eventually reports:
>
>   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks
>
> This suggests that the task spends an excessive amount of time in the
> shmem write and folio/LRU accounting path, preventing the CPU from
> reaching a quiescent state and triggering the RCU stall detector.
>
> I am not yet certain whether the stall is caused by heavy memory
> pressure, LRU/zone accounting contention, or an unintended long-running
> critical section in the shmem write path, but the stall is consistently
> associated with shmem_file_write_iter().
>
> Reproducer:
>
> C reproducer: https://pastebin.com/raw/AjQ5a5PL
> console output: https://pastebin.com/raw/FyBF1R7b
> kernel config: https://pastebin.com/raw/LwALTGZ5
>
> Kernel:
> git tree: torvalds/linux
> HEAD commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> kernel version: 6.19.0-rc7 (QEMU Ubuntu 24.10)
>
>
>
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:  Tasks blocked on level-0 rcu_node (CPUs 0-1): P51643
> rcu:  (detected by 1, t=100002 jiffies, g=470049, q=86 ncpus=2)
> task:syz.3.5719      state:R  running task     stack:25640 pid:51643
> tgid:51627 ppid:49386  task_flags:0x400140 flags:0x00080012
> Call Trace:
>  <IRQ>
>  sched_show_task kernel/sched/core.c:7821 [inline]
>  sched_show_task+0x357/0x510 kernel/sched/core.c:7796
>  rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:292 [inline]
>  print_other_cpu_stall kernel/rcu/tree_stall.h:681 [inline]
>  check_cpu_stall kernel/rcu/tree_stall.h:856 [inline]
>  rcu_pending kernel/rcu/tree.c:3667 [inline]
>  rcu_sched_clock_irq+0x20ab/0x27e0 kernel/rcu/tree.c:2704
>  update_process_times+0xf4/0x160 kernel/time/timer.c:2474
>  tick_sched_handle kernel/time/tick-sched.c:298 [inline]
>  tick_nohz_handler+0x504/0x720 kernel/time/tick-sched.c:319
>  __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
>  __hrtimer_run_queues+0x274/0x810 kernel/time/hrtimer.c:1841
>  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1903
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
>  __sysvec_apic_timer_interrupt+0x82/0x250 arch/x86/kernel/apic/apic.c:1062
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
>  sysvec_apic_timer_interrupt+0x6b/0x80 arch/x86/kernel/apic/apic.c:1056
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> RIP: 0010:finish_task_switch+0x128/0x610 kernel/sched/core.c:5118
> Code: 02 00 0f 85 67 04 00 00 49 8b 9c 24 98 0a 00 00 48 85 db 0f 85
> 70 03 00 00 4c 89 e7 e8 61 78 92 02 fb 65 48 8b 1d 68 51 5d 04 <48> 8d
> bb e0 0a 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
> RSP: 0018:ffff88802d32f630 EFLAGS: 00000286
> RAX: 0000000000000000 RBX: ffff888012496900 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff888012496900 RDI: ffff88806d535b80
> RBP: ffff88802d32f670 R08: 0000000000000000 R09: ffffffff817f85a5
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88806d535b80
> R13: ffff88800635c600 R14: ffff88800f630f00 R15: ffff888012497374
>  context_switch kernel/sched/core.c:5263 [inline]
>  __schedule+0x1293/0x38c0 kernel/sched/core.c:6867
>  preempt_schedule_irq+0x49/0x70 kernel/sched/core.c:7194
>  irqentry_exit+0xc1/0x5a0 kernel/entry/common.c:216
>  asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:733
> RIP: 0010:__mod_zone_page_state+0x12/0xf0 mm/vmstat.c:347
> Code: 89 ef e8 b1 53 18 00 e9 54 ff ff ff 66 66 2e 0f 1f 84 00 00 00
> 00 00 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 41 55 41 54 <55> 48
> 89 fd 48 83 c7 70 53 48 89 f9 48 c1 e9 03 48 83 ec 10 80 3c
> RSP: 0018:ffff88802d32f898 EFLAGS: 00000286
> RAX: dffffc0000000000 RBX: ffff88800c0c4640 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffff88807ffdcc00
> RBP: ffffea00014a5a00 R08: ffffffff846c1c01 R09: ffff88806d53b6d0
> R10: ffff888006278000 R11: ffff8880062785bb R12: 0000000000000000
> R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000001
>  __update_lru_size include/linux/mm_inline.h:48 [inline]
>  update_lru_size include/linux/mm_inline.h:56 [inline]
>  lruvec_add_folio include/linux/mm_inline.h:348 [inline]
>  lru_add+0x44f/0x890 mm/swap.c:154
>  folio_batch_move_lru+0x110/0x4c0 mm/swap.c:172
>  __folio_batch_add_and_move+0x27e/0x7e0 mm/swap.c:196
>  shmem_alloc_and_add_folio mm/shmem.c:1991 [inline]
>  shmem_get_folio_gfp.isra.0+0xc49/0x1410 mm/shmem.c:2556
>  shmem_get_folio mm/shmem.c:2662 [inline]
>  shmem_write_begin+0x197/0x3b0 mm/shmem.c:3315
>  generic_perform_write+0x37f/0x800 mm/filemap.c:4314
>  shmem_file_write_iter+0x10d/0x140 mm/shmem.c:3490
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write fs/read_write.c:686 [inline]
>  vfs_write+0xabc/0xe90 fs/read_write.c:666
>  ksys_write+0x121/0x240 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xac/0x330 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f9b5abad69f
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54
> 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
> RSP: 002b:00007f9b595eddf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f9b5abad69f
> RDX: 0000000000010000 RSI: 00007f9b511ce000 RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000002f2
> R10: 00000000000001ce R11: 0000000000000293 R12: 0000000000000007
> R13: 00007f9b595edef0 R14: 00007f9b595edeb0 R15: 00007f9b511ce000
>  </TASK>
>
Hi Zw,

__mod_zone_page_state() itself doesn't appear to block, so the reported
frame is
likely just where the task was sampled.

Given the task stays in running state, this looks more like a long CPU-bound
section rather than a blocking issue. With heavy shmem writes, we may be
spending significant time in the folio allocation/LRU paths (for example
folio_batch_move_lru() or alloc_pages() slowpath with reclaim/compaction),
which can run for quite a while without hitting a reschedule point and thus
starve RCU.

Could you try enabling lockdep as David suggested? It would also help to
collect
some tracing or perf data around the allocation/LRU paths to see where
the CPU
time is actually spent.


Thanx, Kunwu

