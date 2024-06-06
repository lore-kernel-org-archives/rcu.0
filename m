Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18905196D9C;
	Thu,  6 Jun 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688778; cv=none; b=i8IUtZ/+1ISTDQ2iTNwcDnsZE/DuwV7c+E1bgDcxc/Qqa6PGLfMD4ZuKvslxezA0rBJh05p6ytL8sh5ePxNQhdxYzF/n44IydH7JZ3x5r+WP21xHe8VWJ/74D/pjPD38RjruM7cys6wudTDeLmzwBMPFRb6165Iaa9O3yr+WDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688778; c=relaxed/simple;
	bh=PCVxqroXWU1Dirz3jq0jsklJsOGvigJooaXO9jZTPYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcsux/PmQM67qL7wOsQHsY8h3ZoJG09x9Aa0newqO2GNNRxNsCtNqRkaHYw6phg5Q4LPdOVIfGT126p5IAyU4yR9K1aYkoFycTOhIjuY4Eh+uhWS1lUUg+PMf9MxvLySddFt0sXfNp6a/F+cKpxWl4lfycQXCpL0p9PPr5YSPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2zervz6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2zervz6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6342c5faaso10332355ad.2;
        Thu, 06 Jun 2024 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688776; x=1718293576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny5DLzEZtMJmVIKG3oSs8yHbF8E/d1B6MwfIlVQeaRs=;
        b=P2zervz6MNH8mogIHWyK/fR7rX5R5hFUXI6mmwEKyVhUcDKRnDMFlhNgDM+Xv86hSh
         bpnhLoeddzayOa3Tnw0pjfuD/Khzdgpb92f2QZFwPi0wLpGK+z9iN2nnUTHOZNQKcfoV
         jvkxjd3yLTTGzfLYokabDVuzXDykVzj03TPMki3axvH2AYyZQ7ednyRPfwCoy6GvBqaa
         IiUSvNnMLWfD1sRW7FxcdRBbcJc1WUf7h5Bl/YRPCKVjc432ISNDbKFVvuUFSwk4YPZc
         03CRsvRDEr9+fvWW5yiM9szAXBXmytirmXChw/yEHuhaT91tUlfWECymFs+OR52VoXGl
         IxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688776; x=1718293576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny5DLzEZtMJmVIKG3oSs8yHbF8E/d1B6MwfIlVQeaRs=;
        b=r1chqrd1Tks6O/Dc/vd1ploBAO0OHl0ZLSpFvtjxFXuwYHXxD6iESNI24/0YfeXDLE
         lvpL43IIsOhBEYJcK21eB4yhc8QvgRk9wNCTxJsunvl+Q5XaECk/7FbkmrXTegJwzn0q
         EFbxiJvcR6lgKYdd37HMjVsOLeEotL6zpNtAgJNws1sxcfLT+KG+429w1g8TYXgA5nmW
         F2marNKbMpVzA/SS4nAOj99fyZw0iyEOiyE9/18KXt3g9/rGrwixNI1YzVvutK0w7V1z
         06UvYnVzhjhfMOCQ4zqhzSiIPAWqDw6UMEazASJf8cKbsaedNfU8qI2yBMewQz1/DM4i
         Y2zg==
X-Forwarded-Encrypted: i=1; AJvYcCX1kzRixUAvfVexfFyJLeCDd2T0PP4oxivlyidAK/CJ3HRvPfWRlQ3J3PLxvxEGQP4YhxUvuW4bNe97O3rRd0gL3nHtt3GQM23xiJpEAt3a9RWtt918xi+wUka4GZFXdF7L
X-Gm-Message-State: AOJu0Yz16Um9IKs81EWi6s0ysbmhbKa4/GFYrot+no5uA8vv0TwnR32X
	Ehu8TgOHGrBnng0mbJ/8iyeaC8n6T35FcDf8E2K0bRMOHzs6r5Zo
X-Google-Smtp-Source: AGHT+IEKWhvlLszIa5zOt6BjaT5RUHK3Nsegm6pdns7x1QFQLail472k+/g63ueC9qnnLVWNHz5S5w==
X-Received: by 2002:a17:90a:ac16:b0:2bf:ac8a:c795 with SMTP id 98e67ed59e1d1-2c27db4a1e3mr6622428a91.34.1717688776208;
        Thu, 06 Jun 2024 08:46:16 -0700 (PDT)
Received: from localhost.localdomain ([91.199.84.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806bd631sm3708740a91.42.2024.06.06.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:46:15 -0700 (PDT)
From: Wei Fu <fuweid89@gmail.com>
To: oleg@redhat.com
Cc: Sudhanva.Huruli@microsoft.com,
	akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	axboe@kernel.dk,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	ebiederm@xmission.com,
	frederic@kernel.org,
	fuweid89@gmail.com,
	j.granados@samsung.com,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang1211@gmail.com,
	rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	weifu@microsoft.com
Subject: Re: [RCU] zombie task hung in synchronize_rcu_expedited
Date: Thu,  6 Jun 2024 23:45:53 +0800
Message-ID: <20240606154553.53514-1-fuweid89@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606111051.GA22450@redhat.com>
References: <20240606111051.GA22450@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

> Add Eric.
> 
> Well, due to unfortunate design zap_pid_ns_processes() can hang "forever"
> if this namespace has a (zombie) task injected from the parent ns, this
> task should be reaped by its parent.

That zombie task was cloned by pid-1 process in that pid namespace. In my last
reproduced log, the process tree in that pid namespace looks like

```
# unshare(CLONE_NEWPID | CLONE_NEWNS)

npm start (pid 2522045)
    |__npm run zombie (pid 2522605)
       |__ sh -c "whle true; do echo zombie; sleep 1; done" (pid 2522869)
```

The `npm start (pid 2522045)` was stuck in kernel_wait4. And its child,
`npm run zombie (pid 2522605)`, has two threads. One of them was in D status.
As far as I know, pid-2522605 can't be reaped by its parent pid-2522045 until
that thread returns from `synchronize_rcu_expedited`.

```
$ sudo cat /proc/2522605/task/*/stack
[<0>] synchronize_rcu_expedited+0x177/0x1f0
[<0>] namespace_unlock+0xd6/0x1b0
[<0>] put_mnt_ns+0x73/0xa0
[<0>] free_nsproxy+0x1c/0x1b0
[<0>] switch_task_namespaces+0x5d/0x70
[<0>] exit_task_namespaces+0x10/0x20
[<0>] do_exit+0x2ce/0x500
[<0>] io_sq_thread+0x48e/0x5a0
[<0>] ret_from_fork+0x3c/0x60
[<0>] ret_from_fork_asm+0x1b/0x30

$ sudo cat /proc/2522605/task/2522645/status
Name: iou-sqp-2522605
State: D (disk sleep)
Tgid: 2522605
Ngid: 0
Pid: 2522645
PPid: 2522045
TracerPid: 0
Uid: 1000 1000 1000 1000
Gid: 1000 1000 1000 1000
FDSize: 0
Groups: 1000
NStgid: 2522605 25
NSpid: 2522645 40
NSpgid: 2522045 1
NSsid: 2522045 1
Kthread: 0
Threads: 2
SigQ: 0/128311
SigPnd: 0000000000000000
ShdPnd: 0000000000000100
SigBlk: fffffffffffbfeff
SigIgn: 0000000001001000
SigCgt: 0000000000014602
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000
CapBnd: 00000000a80425fb
CapAmb: 0000000000000000
NoNewPrivs: 0
Seccomp: 2
Seccomp_filters: 1
Speculation_Store_Bypass: vulnerable
SpeculationIndirectBranch: always enabled
Cpus_allowed: ff
Cpus_allowed_list: 0-7
Mems_allowed: 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
Mems_allowed_list: 0
voluntary_ctxt_switches: 11
nonvoluntary_ctxt_switches: 21
```

> 
> But zap_pid_ns_processes() shouldn't cause the soft-lockup, it should
> sleep in kernel_wait4().

I run `cat /proc/2522045/status` and found that the status was kept switching
between running and sleeping. But the kernel was still reporting soft lockup.
And there is log from dmesg. The CPU 5 wasn't able to report the quiescent
state. It seems that [rcu_flavor_sched_clock_irq][1] wasn't able to call
[run_qs][2].

```
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:         5-....: (15000 ticks this GP) idle=db4c/1/0x4000000000000000 softirq=14924115/14924115 fqs=7430
rcu:                  hardirqs   softirqs   csw/system
rcu:          number:        0        833            0
rcu:         cputime:        0          0        29996   ==> 30000(ms)
rcu:         (t=15003 jiffies g=44379053 q=145851 ncpus=8)
CPU: 5 PID: 2522045 Comm: npm start Tainted: G             L     6.5.0-1021-azure #22~22.04.1-Ubuntu
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x20
Code: cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 e8 62 06 00 00 90 f7 c6 00 02 00 00 74 01 fb 5d <e9> d2 19 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffa666c4bafc30 EFLAGS: 00000206
RAX: 0000000000000001 RBX: ffffa666c4bafcc0 RCX: 0000000000000020
RDX: ffff8a3d82130928 RSI: 0000000000000282 RDI: ffff8a3d82130920
RBP: ffffa666c4bafc48 R08: ffff8a3d82130928 R09: ffff8a3d82130928
R10: 0000000000000040 R11: 0000000000000002 R12: ffff8a3d82130920
R13: ffff8a44f3db9980 R14: ffff8a44f3db9980 R15: ffff8a44f3db9970
FS:  0000000000000000(0000) GS:ffff8a451fd40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000767ea57cc000 CR3: 00000005db436002 CR4: 0000000000370ee0
Call Trace:
 <IRQ>
 ? show_regs+0x6a/0x80
 ? dump_cpu_task+0x71/0x90
 ? rcu_dump_cpu_stacks+0xe8/0x180
 ? print_cpu_stall+0x131/0x290
 ? load_balance+0x160/0x870
 ? check_cpu_stall+0x1d8/0x270
 ? rcu_pending+0x32/0x1e0
 ? rcu_sched_clock_irq+0x16e/0x290
 ? update_process_times+0x63/0xa0
 ? tick_sched_handle+0x28/0x70
 ? tick_sched_timer+0x77/0x90
 ? __pfx_tick_sched_timer+0x10/0x10
 ? __hrtimer_run_queues+0x111/0x240
 ? srso_alias_return_thunk+0x5/0x7f
 ? hrtimer_interrupt+0x101/0x240
 ? hv_stimer0_isr+0x20/0x30
 ? __sysvec_hyperv_stimer0+0x32/0x70
 ? sysvec_hyperv_stimer0+0x7b/0x90
 </IRQ>
 <TASK>
 ? asm_sysvec_hyperv_stimer0+0x1b/0x20
 ? _raw_spin_unlock_irqrestore+0x19/0x20
 ? remove_wait_queue+0x47/0x50
 do_wait+0x19f/0x300
 kernel_wait4+0xaf/0x150
 ? __pfx_child_wait_callback+0x10/0x10
 zap_pid_ns_processes+0x105/0x190
 forget_original_parent+0x2e4/0x360
 exit_notify+0x4a/0x210
 do_exit+0x30b/0x500
 ? srso_alias_return_thunk+0x5/0x7f
 ? wake_up_state+0x10/0x20
 ? srso_alias_return_thunk+0x5/0x7f
 do_group_exit+0x35/0x90
 __x64_sys_exit_group+0x18/0x20
 x64_sys_call+0xd95/0x1ff0
 do_syscall_64+0x56/0x80
 ? srso_alias_return_thunk+0x5/0x7f
 ? handle_mm_fault+0x128/0x290
 ? srso_alias_return_thunk+0x5/0x7f
 ? srso_alias_return_thunk+0x5/0x7f
 ? exit_to_user_mode_prepare+0x49/0x100
 ? srso_alias_return_thunk+0x5/0x7f
 ? irqentry_exit_to_user_mode+0x19/0x30
 ? srso_alias_return_thunk+0x5/0x7f
 ? irqentry_exit+0x1d/0x30
 ? srso_alias_return_thunk+0x5/0x7f
 ? exc_page_fault+0x80/0x160
 entry_SYSCALL_64_after_hwframe+0x73/0xdd
RIP: 0033:0x75fce9367f8e
Code: Unable to access opcode bytes at 0x75fce9367f64.
RSP: 002b:00007ffc80c04b18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000075fce672d1b0 RCX: 000075fce9367f8e
RDX: 000075fce93e30c0 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 00007ffc80c04b60 R08: 0000000000000024 R09: 0000000800000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
R13: 000075fce9081a90 R14: 0000000000000000 R15: 000075fce6771d50
 </TASK>

rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 5-.... } 15359 jiffies s: 90777 root: 0x20/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 4 to CPUs 5:
NMI backtrace for cpu 5
CPU: 5 PID: 2522045 Comm: npm start Tainted: G             L     6.5.0-1021-azure #22~22.04.1-Ubuntu
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
RIP: 0010:do_wait+0x11/0x300
Code: 8b 4d d4 e9 28 fd ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 <53> 48 89 fb 48 83 ec 08 48 8b 77 08 0f 1f 44 00 00 65 4c 8b 34 25
RSP: 0018:ffffa666c4bafc68 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000040000004 RCX: 0000000000000000
RDX: 0000000040000000 RSI: 0000000000000000 RDI: ffffa666c4bafc98
RBP: ffffa666c4bafc88 R08: ffff8a3d82130928 R09: ffff8a3d82130928
R10: 0000000000000040 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8a451fd40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000767ea57cc000 CR3: 00000005db436002 CR4: 0000000000370ee0
Call Trace:
 <NMI>
 ? show_regs+0x6a/0x80
 ? nmi_cpu_backtrace+0x9c/0x100
 ? nmi_cpu_backtrace_handler+0x11/0x20
 ? nmi_handle+0x62/0x160
 ? default_do_nmi+0x45/0x120
 ? exc_nmi+0x19f/0x250
 ? end_repeat_nmi+0x16/0x67
 ? do_wait+0x11/0x300
 ? do_wait+0x11/0x300
 ? do_wait+0x11/0x300
 </NMI>
 <TASK>
 kernel_wait4+0xaf/0x150
 ? __pfx_child_wait_callback+0x10/0x10
 zap_pid_ns_processes+0x105/0x190
 forget_original_parent+0x2e4/0x360
 exit_notify+0x4a/0x210
 do_exit+0x30b/0x500
 ? srso_alias_return_thunk+0x5/0x7f
 ? wake_up_state+0x10/0x20
 ? srso_alias_return_thunk+0x5/0x7f
 do_group_exit+0x35/0x90
 __x64_sys_exit_group+0x18/0x20
 x64_sys_call+0xd95/0x1ff0
 do_syscall_64+0x56/0x80
 ? srso_alias_return_thunk+0x5/0x7f
 ? handle_mm_fault+0x128/0x290
 ? srso_alias_return_thunk+0x5/0x7f
 ? srso_alias_return_thunk+0x5/0x7f
 ? exit_to_user_mode_prepare+0x49/0x100
 ? srso_alias_return_thunk+0x5/0x7f
 ? irqentry_exit_to_user_mode+0x19/0x30
 ? srso_alias_return_thunk+0x5/0x7f
 ? irqentry_exit+0x1d/0x30
 ? srso_alias_return_thunk+0x5/0x7f
 ? exc_page_fault+0x80/0x160
 entry_SYSCALL_64_after_hwframe+0x73/0xdd
RIP: 0033:0x75fce9367f8e
Code: Unable to access opcode bytes at 0x75fce9367f64.
RSP: 002b:00007ffc80c04b18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000075fce672d1b0 RCX: 000075fce9367f8e
RDX: 000075fce93e30c0 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 00007ffc80c04b60 R08: 0000000000000024 R09: 0000000800000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
R13: 000075fce9081a90 R14: 0000000000000000 R15: 000075fce6771d50
 </TASK>


watchdog: BUG: soft lockup - CPU#5 stuck for 85s! [npm start:2522045]
Modules linked in: tls raw_diag unix_diag af_packet_diag netlink_diag udp_diag tcp_diag inet_diag xt_statistic xt_mark veth xt_comment xt_CHECKSUM ipt_REJECT nf_reject_ipv4 xt_nat xt_MASQUERADE nft_chain_nat nf_nat nf_conntrack_netlink xfrm_user xfrm_algo xt_addrtype br_netfilter bridge stp llc overlay binfmt_misc nls_iso8859_1 xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_owner xt_tcpudp nft_compat crct10dif_pclmul crc32_pclmul nf_tables polyval_clmulni polyval_generic ghash_clmulni_intel libcrc32c sha256_ssse3 joydev sha1_ssse3 hid_generic nfnetlink aesni_intel crypto_simd hyperv_drm cryptd hid_hyperv serio_raw drm_kms_helper hv_netvsc hid hyperv_keyboard pata_acpi drm_shmem_helper dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua sch_fq_codel msr drm efi_pstore i2c_core ip_tables x_tables autofs4
CPU: 5 PID: 2522045 Comm: npm start Tainted: G             L     6.5.0-1021-azure #22~22.04.1-Ubuntu
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x20
Code: cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 e8 62 06 00 00 90 f7 c6 00 02 00 00 74 01 fb 5d <e9> d2 19 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffa666c4bafc30 EFLAGS: 00000206
RAX: 0000000000000001 RBX: ffffa666c4bafcc0 RCX: 0000000000000020
RDX: ffff8a3d82130928 RSI: 0000000000000282 RDI: ffff8a3d82130920
RBP: ffffa666c4bafc48 R08: ffff8a3d82130928 R09: ffff8a3d82130928
R10: 0000000000000040 R11: 0000000000000002 R12: ffff8a3d82130920
R13: ffff8a44f3db9980 R14: ffff8a44f3db9980 R15: ffff8a44f3db9970
FS:  0000000000000000(0000) GS:ffff8a451fd40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000767ea57cc000 CR3: 00000005db436002 CR4: 0000000000370ee0
Call Trace:
 <IRQ>
 ? show_regs+0x6a/0x80
 ? watchdog_timer_fn+0x1ce/0x230
 ? __pfx_watchdog_timer_fn+0x10/0x10
 ? __hrtimer_run_queues+0x111/0x240
 ? srso_alias_return_thunk+0x5/0x7f
 ? hrtimer_interrupt+0x101/0x240
 ? hv_stimer0_isr+0x20/0x30
 ? __sysvec_hyperv_stimer0+0x32/0x70
 ? sysvec_hyperv_stimer0+0x7b/0x90
 </IRQ>
 <TASK>
 ? asm_sysvec_hyperv_stimer0+0x1b/0x20
 ? _raw_spin_unlock_irqrestore+0x19/0x20
 ? remove_wait_queue+0x47/0x50
 do_wait+0x19f/0x300
 kernel_wait4+0xaf/0x150
 ? __pfx_child_wait_callback+0x10/0x10
 zap_pid_ns_processes+0x105/0x190
 forget_original_parent+0x2e4/0x360
 exit_notify+0x4a/0x210
 do_exit+0x30b/0x500
 ? srso_alias_return_thunk+0x5/0x7f
 ? wake_up_state+0x10/0x20
 ? srso_alias_return_thunk+0x5/0x7f
 do_group_exit+0x35/0x90
 __x64_sys_exit_group+0x18/0x20
 x64_sys_call+0xd95/0x1ff0
 do_syscall_64+0x56/0x80
 ? srso_alias_return_thunk+0x5/0x7f
 ? handle_mm_fault+0x128/0x290
 ? srso_alias_return_thunk+0x5/0x7f
 ? srso_alias_return_thunk+0x5/0x7f
 ? exit_to_user_mode_prepare+0x49/0x100
 ? srso_alias_return_thunk+0x5/0x7f
 ? irqentry_exit_to_user_mode+0x19/0x30
 ? srso_alias_return_thunk+0x5/0x7f
 ? irqentry_exit+0x1d/0x30
 ? srso_alias_return_thunk+0x5/0x7f
 ? exc_page_fault+0x80/0x160
 entry_SYSCALL_64_after_hwframe+0x73/0xdd
RIP: 0033:0x75fce9367f8e
Code: Unable to access opcode bytes at 0x75fce9367f64.
RSP: 002b:00007ffc80c04b18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000075fce672d1b0 RCX: 000075fce9367f8e
RDX: 000075fce93e30c0 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 00007ffc80c04b60 R08: 0000000000000024 R09: 0000000800000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
R13: 000075fce9081a90 R14: 0000000000000000 R15: 000075fce6771d50
 </TASK>
```

> 
> Any chance you can test the patch below? This patch makes sense anyway,
> I'll send it later. But I am not sure it can fix your problem.

Sure! Will do! Thanks

> 
> Oleg.
> 
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index dc48fecfa1dc..25f3cf679b35 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -218,6 +218,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	 */
>  	do {
>  		clear_thread_flag(TIF_SIGPENDING);
> +		clear_thread_flag(TIF_NOTIFY_SIGNAL);
>  		rc = kernel_wait4(-1, NULL, __WALL, NULL);
>  	} while (rc != -ECHILD);
>  
> 
> 

Wei, Fu

[1]: https://elixir.bootlin.com/linux/v6.5/source/kernel/rcu/tree_plugin.h#L964
[2]: https://elixir.bootlin.com/linux/v6.5/source/kernel/rcu/tree_plugin.h#L848
