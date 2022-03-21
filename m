Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC58DC433EF
	for <rcu@archiver.kernel.org>; Mon, 21 Mar 2022 15:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348674AbiCUPsM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350566AbiCUPsL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Mar 2022 11:48:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52B15D180
        for <rcu@vger.kernel.org>; Mon, 21 Mar 2022 08:46:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qa43so30596441ejc.12
        for <rcu@vger.kernel.org>; Mon, 21 Mar 2022 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=txtuc0Zg7A4ntfwoCjdjnBEIgr1gTemxkjggs8BHPG8=;
        b=Tlr9ey6nldy5Y7ftsihEqjYtEOF8oKbFO/ZJ4p7CcI5IUvLinRBFm/1DL7G6quNcPo
         ksjp7zp1gT8a5bk6OQbs43Np//UnxkImrNbtrWNpdG8yE65rjelXiiOEHzHGBaZMPXac
         w4xJw0kgEVqXCZXozvdwFhWCd+cqk5wKwO7u4FZkSNRbWOe1F31zxrma298T/iGMl3xB
         vyzZ6kQBOpdeRE9+jKwfxT9SB/5vGv7Cg0QIDywQ3RVN2eZJG6G1/dE5A0seIwpjyC1Y
         +NQ2sDrqIEZNq+3kxAVVC7ovXT3ueZa5ngwnBg9gLdW+U7VZUMeN1G5T/9DTm+tUnwq5
         j11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=txtuc0Zg7A4ntfwoCjdjnBEIgr1gTemxkjggs8BHPG8=;
        b=6J18pY3bbb3xIaJA2JMiShgHbNZnVMdsl3rKf0CC3v60vbVOaomcJlo/NSfPd7RDel
         kz+Cuv+NUF3+Yrmd7WRn8/sAj/Xa3UPsviwTqiM0Pyyz9+qLxaDMKW6MCAGAiK530rY+
         FiRRts5+QE/7ERQvDif1KQAz6Mec4unHAaXl3md2+orJpN4uVsj53cnI/wfA8jvedOl2
         ZgyscwXVFg4a1UmuH/25uNqaiSQDnpZEuURrPy3mYek+OpE8U3z3S45cOnQ6ErAE0tVK
         qAhoW7kbEO4uzvE0F2gDvNWg0DH2G04+A5f9IWA/34DmkQ6nrHGs180m/XTz5YR8P6xd
         H9bA==
X-Gm-Message-State: AOAM531+exWQJJByjQTQUjEuZmPK+Zrphyqzd4/R+7P/LjEXnmPoSmXZ
        uUZFpHvIKfpJSsq4Kh8iEKPExVN6rIBYV/+KMoA=
X-Google-Smtp-Source: ABdhPJyw/bU1WDoWap2U8cQQkUJcIg/2VElh9eyoSj22OJ1EInLrMAXeYfCI5ouhMIC+Ch+flukUTzWWHwzCZRiCClw=
X-Received: by 2002:a17:907:2cc2:b0:6df:f4ec:eebd with SMTP id
 hg2-20020a1709072cc200b006dff4eceebdmr8709574ejc.486.1647877600593; Mon, 21
 Mar 2022 08:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <Yje18NgLjpPo7VEp@casper.infradead.org> <SA1PR15MB49655CF8AC3998CA9A7CE903B8169@SA1PR15MB4965.namprd15.prod.outlook.com>
 <20220321043813.GF4285@paulmck-ThinkPad-P17-Gen-1> <20220321071327.GA798064@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220321071327.GA798064@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 21 Mar 2022 23:46:28 +0800
Message-ID: <CAABZP2woW2UuPg1rSYYc+S6k7qd9JwM4gJFMHhiVcBkDewE_Nw@mail.gmail.com>
Subject: Re: Fw: rc6 splat
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Paul McKenney <paulmckrcu@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul and Willy

I can reproduce the bug. Following is what I do:
1.1 git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/=
torvalds/linux.git
1.2 cd linux
1.3 cp http://154.223.142.244/20220321/config-20220321 to .config
1.4 make vmlinux -j 16
1.5 kvm -smp 4 -net none     -serial file:/tmp/console.log -m 512
-kernel vmlinux -append "console=3DttyS0"
1.6 the /tmp/console.log is uploaded to
http://154.223.142.244/20220321/console.log

2.1 wget https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torva=
lds/linux.git/snapshot/linux-5.17-rc6.tar.gz
2.2 - 2.6 the result is similar.

I am very interested in this topic.
Could you please give me about a week to make a full understand of the
meaning of the warning, and try the fixes one by one, and
find out what happens?

Thanks
Zhouyi

On Mon, Mar 21, 2022 at 5:53 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Sun, Mar 20, 2022 at 09:38:13PM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 21, 2022 at 04:30:30AM +0000, Paul McKenney wrote:
> > > Forwarding to a non-Outlook email address...
> > >
> > > In the meantime, building without CONFIG_PROVE_RCU will stop this par=
ticular complaint.
> > >
> > > More after I look at it in mutt.  =F0=9F=98=89
> >
> > Sebastian saw something like this, but in CONFIG_PREEMPT_RT, which is
> > not what you are doing.  But just in case, here are a couple of
> > commits that made things work for him (also on -rcu):
> >
> > 94ec5f491d47 ("rcu-tasks: Use rcuwait for the rcu_tasks_kthread()")
> > 1baec2d43e93 ("rcu-tasks: Use schedule_hrtimeout_range() to wait for gr=
ace periods")
> >
> > And this one fixed up some resulting breakage on !CONFIG_PREEMPT_RT:
> >
> > 4ed24c15b90c ("rcu-tasks: Restore use of timers for non-RT kernels")
> >
> > Even less likely to be relevant, here is one that fixes a race between
> > schedule and flush work, but that is long after boot:
> >
> > 3a51a7c1c1ce ("rcu-tasks: Fix race in schedule and flush work")
> >
> > Though if this is due to the new CONFIG_PREEMPT_DYNAMIC=3Dy, which
> > you do have set, this last commit might actually help.
>
> Actually, unless you need CONFIG_PREEMPT_DYNAMIC=3Dy, the easiest workaro=
und
> might be to build with CONFIG_PREEMPT_DYNAMIC=3Dn.
>
>                                                         Thanx, Paul
>
> > I just now fired up a test of all the rcutorture scenarios, but with
> > CONFIG_PROVE_RCU enabled to see if I can reproduce.
> >
> > But if you get a chance to try them out, please let me know if any of
> > the above help.
> >
> >                                  Thanx, Paul
> >
> > > ________________________________
> > > From: Matthew Wilcox <willy@infradead.org>
> > > Sent: Sunday, March 20, 2022 4:17 PM
> > > To: Paul McKenney <paulmckrcu@fb.com>
> > > Subject: rc6 splat
> > >
> > >
> > > 00000 call_rcu_tasks() has been failed.
> > > 00000 ------------[ cut here ]------------
> > > 00000 WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_ver=
ify_self_te
> > > sts+0x29/0x40
> > > 00000 Modules linked in:
> > > 00000 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc6-00009-g9cb=
7c5a19627-d
> > > irty #157
> > > 00000 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0=
-1 04/01/20
> > > 14
> > > 00000 RIP: 0010:rcu_tasks_verify_self_tests+0x29/0x40
> > > 00000 Code: 00 55 31 c0 48 89 e5 53 48 c7 c3 80 cf 0c 82 80 7b 18 00 =
0f 84 9a 44
> > >  64 00 48 83 c3 20 48 81 fb e0 cf 0c 82 75 e9 85 c0 74 02 <0f> 0b 48 =
8b 5d f8 c9
> > >  c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> > > 00000 RSP: 0000:ffff88810015be98 EFLAGS: 00010286
> > > 00000 RAX: 00000000ffffffff RBX: ffffffff820ccfe0 RCX: 00000000000000=
00
> > > 00000 RDX: 0000000000000001 RSI: 00000000ffffffea RDI: 00000000ffffff=
ff
> > > 00000 RBP: ffff88810015bea0 R08: ffff88827f7fdfe8 R09: 00000000000000=
03
> > > 00000 R10: ffff88827dbfe000 R11: ffff88827dbfe000 R12: ffffffff810d86=
e0
> > > 00000 R13: ffff888100120200 R14: ffffffff822cb984 R15: 00000000000000=
00
> > > 00000 FS:  0000000000000000(0000) GS:ffff888275800000(0000) knlGS:000=
00000000000
> > > 00
> > > 00000 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > 00000 CR2: ffff88827ffff000 CR3: 0000000002012001 CR4: 0000000000770e=
b0
> > > 00000 PKRU: 55555554
> > > 00000 Call Trace:
> > > 00000  <TASK>
> > > 00000  do_one_initcall+0x49/0x2d0
> > > 00000  ? rcu_read_lock_sched_held+0x41/0x80
> > > 00000  kernel_init_freeable+0x183/0x1c8
> > > 00000  ? rest_init+0x260/0x260
> > > 00000  kernel_init+0x15/0x120
> > > 00000  ret_from_fork+0x1f/0x30
> > > 00000  </TASK>
> > > 00000 irq event stamp: 148967
> > > 00000 hardirqs last  enabled at (148977): [<ffffffff810c8333>] __up_c=
onsole_sem+0x53/0x60
> > > 00000 hardirqs last disabled at (148986): [<ffffffff810c8318>] __up_c=
onsole_sem+0x38/0x60
> > > 00000 softirqs last  enabled at (148660): [<ffffffff81066267>] irq_ex=
it_rcu+0xa7/0xf0
> > > 00000 softirqs last disabled at (148631): [<ffffffff81066267>] irq_ex=
it_rcu+0xa7/0xf0
> > > 00000 ---[ end trace 0000000000000000 ]---
> > >
> > > .config attached
> > >
> >
> > > #
> > > # Automatically generated file; DO NOT EDIT.
> > > # Linux/x86 5.17.0-rc6 Kernel Configuration
> > > #
> > > CONFIG_CC_VERSION_TEXT=3D"gcc (Debian 11.2.0-16) 11.2.0"
> > > CONFIG_CC_IS_GCC=3Dy
> > > CONFIG_GCC_VERSION=3D110200
> > > CONFIG_CLANG_VERSION=3D0
> > > CONFIG_AS_IS_GNU=3Dy
> > > CONFIG_AS_VERSION=3D23800
> > > CONFIG_LD_IS_BFD=3Dy
> > > CONFIG_LD_VERSION=3D23800
> > > CONFIG_LLD_VERSION=3D0
> > > CONFIG_CC_CAN_LINK=3Dy
> > > CONFIG_CC_CAN_LINK_STATIC=3Dy
> > > CONFIG_CC_HAS_ASM_GOTO=3Dy
> > > CONFIG_CC_HAS_ASM_GOTO_OUTPUT=3Dy
> > > CONFIG_CC_HAS_ASM_INLINE=3Dy
> > > CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy
> > > CONFIG_IRQ_WORK=3Dy
> > > CONFIG_BUILDTIME_TABLE_SORT=3Dy
> > > CONFIG_THREAD_INFO_IN_TASK=3Dy
> > >
> > > #
> > > # General setup
> > > #
> > > CONFIG_INIT_ENV_ARG_LIMIT=3D32
> > > # CONFIG_COMPILE_TEST is not set
> > > # CONFIG_WERROR is not set
> > > CONFIG_LOCALVERSION=3D""
> > > CONFIG_LOCALVERSION_AUTO=3Dy
> > > CONFIG_BUILD_SALT=3D""
> > > CONFIG_HAVE_KERNEL_GZIP=3Dy
> > > CONFIG_HAVE_KERNEL_BZIP2=3Dy
> > > CONFIG_HAVE_KERNEL_LZMA=3Dy
> > > CONFIG_HAVE_KERNEL_XZ=3Dy
> > > CONFIG_HAVE_KERNEL_LZO=3Dy
> > > CONFIG_HAVE_KERNEL_LZ4=3Dy
> > > CONFIG_HAVE_KERNEL_ZSTD=3Dy
> > > CONFIG_KERNEL_GZIP=3Dy
> > > # CONFIG_KERNEL_BZIP2 is not set
> > > # CONFIG_KERNEL_LZMA is not set
> > > # CONFIG_KERNEL_XZ is not set
> > > # CONFIG_KERNEL_LZO is not set
> > > # CONFIG_KERNEL_LZ4 is not set
> > > # CONFIG_KERNEL_ZSTD is not set
> > > CONFIG_DEFAULT_INIT=3D""
> > > CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> > > CONFIG_SWAP=3Dy
> > > CONFIG_SYSVIPC=3Dy
> > > CONFIG_SYSVIPC_SYSCTL=3Dy
> > > # CONFIG_POSIX_MQUEUE is not set
> > > # CONFIG_WATCH_QUEUE is not set
> > > # CONFIG_CROSS_MEMORY_ATTACH is not set
> > > # CONFIG_USELIB is not set
> > > # CONFIG_AUDIT is not set
> > > CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> > >
> > > #
> > > # IRQ subsystem
> > > #
> > > CONFIG_GENERIC_IRQ_PROBE=3Dy
> > > CONFIG_GENERIC_IRQ_SHOW=3Dy
> > > CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
> > > CONFIG_GENERIC_PENDING_IRQ=3Dy
> > > CONFIG_GENERIC_IRQ_MIGRATION=3Dy
> > > CONFIG_HARDIRQS_SW_RESEND=3Dy
> > > CONFIG_IRQ_DOMAIN=3Dy
> > > CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> > > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
> > > CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
> > > CONFIG_IRQ_FORCED_THREADING=3Dy
> > > CONFIG_SPARSE_IRQ=3Dy
> > > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > > # end of IRQ subsystem
> > >
> > > CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> > > CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
> > > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
> > > CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> > > CONFIG_GENERIC_CLOCKEVENTS=3Dy
> > > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> > > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> > > CONFIG_GENERIC_CMOS_UPDATE=3Dy
> > > CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> > > CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> > >
> > > #
> > > # Timers subsystem
> > > #
> > > CONFIG_TICK_ONESHOT=3Dy
> > > CONFIG_HZ_PERIODIC=3Dy
> > > # CONFIG_NO_HZ_IDLE is not set
> > > # CONFIG_NO_HZ_FULL is not set
> > > # CONFIG_NO_HZ is not set
> > > CONFIG_HIGH_RES_TIMERS=3Dy
> > > # end of Timers subsystem
> > >
> > > CONFIG_BPF=3Dy
> > > CONFIG_HAVE_EBPF_JIT=3Dy
> > > CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
> > >
> > > #
> > > # BPF subsystem
> > > #
> > > # CONFIG_BPF_SYSCALL is not set
> > > # CONFIG_BPF_JIT is not set
> > > # end of BPF subsystem
> > >
> > > CONFIG_PREEMPT_BUILD=3Dy
> > > CONFIG_PREEMPT_NONE=3Dy
> > > # CONFIG_PREEMPT_VOLUNTARY is not set
> > > # CONFIG_PREEMPT is not set
> > > CONFIG_PREEMPT_COUNT=3Dy
> > > CONFIG_PREEMPTION=3Dy
> > > CONFIG_PREEMPT_DYNAMIC=3Dy
> > > # CONFIG_SCHED_CORE is not set
> > >
> > > #
> > > # CPU/Task time and stats accounting
> > > #
> > > CONFIG_TICK_CPU_ACCOUNTING=3Dy
> > > # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> > > # CONFIG_IRQ_TIME_ACCOUNTING is not set
> > > # CONFIG_BSD_PROCESS_ACCT is not set
> > > # CONFIG_TASKSTATS is not set
> > > # CONFIG_PSI is not set
> > > # end of CPU/Task time and stats accounting
> > >
> > > CONFIG_CPU_ISOLATION=3Dy
> > >
> > > #
> > > # RCU Subsystem
> > > #
> > > CONFIG_TREE_RCU=3Dy
> > > CONFIG_PREEMPT_RCU=3Dy
> > > # CONFIG_RCU_EXPERT is not set
> > > CONFIG_SRCU=3Dy
> > > CONFIG_TREE_SRCU=3Dy
> > > CONFIG_TASKS_RCU_GENERIC=3Dy
> > > CONFIG_TASKS_RCU=3Dy
> > > CONFIG_RCU_STALL_COMMON=3Dy
> > > CONFIG_RCU_NEED_SEGCBLIST=3Dy
> > > # end of RCU Subsystem
> > >
> > > # CONFIG_IKCONFIG is not set
> > > # CONFIG_IKHEADERS is not set
> > > CONFIG_LOG_BUF_SHIFT=3D17
> > > CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> > > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> > > # CONFIG_PRINTK_INDEX is not set
> > > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> > >
> > > #
> > > # Scheduler features
> > > #
> > > # CONFIG_UCLAMP_TASK is not set
> > > # end of Scheduler features
> > >
> > > CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> > > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> > > CONFIG_CC_HAS_INT128=3Dy
> > > CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"
> > > CONFIG_ARCH_SUPPORTS_INT128=3Dy
> > > CONFIG_CGROUPS=3Dy
> > > # CONFIG_MEMCG is not set
> > > # CONFIG_BLK_CGROUP is not set
> > > # CONFIG_CGROUP_SCHED is not set
> > > # CONFIG_CGROUP_PIDS is not set
> > > # CONFIG_CGROUP_RDMA is not set
> > > # CONFIG_CGROUP_FREEZER is not set
> > > # CONFIG_CPUSETS is not set
> > > # CONFIG_CGROUP_DEVICE is not set
> > > # CONFIG_CGROUP_CPUACCT is not set
> > > # CONFIG_CGROUP_PERF is not set
> > > # CONFIG_CGROUP_MISC is not set
> > > # CONFIG_CGROUP_DEBUG is not set
> > > CONFIG_NAMESPACES=3Dy
> > > CONFIG_UTS_NS=3Dy
> > > CONFIG_TIME_NS=3Dy
> > > CONFIG_IPC_NS=3Dy
> > > CONFIG_USER_NS=3Dy
> > > CONFIG_PID_NS=3Dy
> > > CONFIG_NET_NS=3Dy
> > > # CONFIG_CHECKPOINT_RESTORE is not set
> > > # CONFIG_SCHED_AUTOGROUP is not set
> > > # CONFIG_SYSFS_DEPRECATED is not set
> > > # CONFIG_RELAY is not set
> > > # CONFIG_BLK_DEV_INITRD is not set
> > > # CONFIG_BOOT_CONFIG is not set
> > > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> > > # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> > > CONFIG_LD_ORPHAN_WARN=3Dy
> > > CONFIG_SYSCTL=3Dy
> > > CONFIG_HAVE_UID16=3Dy
> > > CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> > > CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> > > # CONFIG_EXPERT is not set
> > > CONFIG_UID16=3Dy
> > > CONFIG_MULTIUSER=3Dy
> > > CONFIG_SGETMASK_SYSCALL=3Dy
> > > CONFIG_SYSFS_SYSCALL=3Dy
> > > CONFIG_FHANDLE=3Dy
> > > CONFIG_POSIX_TIMERS=3Dy
> > > CONFIG_PRINTK=3Dy
> > > CONFIG_BUG=3Dy
> > > CONFIG_ELF_CORE=3Dy
> > > CONFIG_PCSPKR_PLATFORM=3Dy
> > > CONFIG_BASE_FULL=3Dy
> > > CONFIG_FUTEX=3Dy
> > > CONFIG_FUTEX_PI=3Dy
> > > CONFIG_EPOLL=3Dy
> > > CONFIG_SIGNALFD=3Dy
> > > CONFIG_TIMERFD=3Dy
> > > CONFIG_EVENTFD=3Dy
> > > CONFIG_SHMEM=3Dy
> > > CONFIG_AIO=3Dy
> > > CONFIG_IO_URING=3Dy
> > > CONFIG_ADVISE_SYSCALLS=3Dy
> > > CONFIG_MEMBARRIER=3Dy
> > > CONFIG_KALLSYMS=3Dy
> > > CONFIG_KALLSYMS_ALL=3Dy
> > > CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
> > > CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> > > # CONFIG_USERFAULTFD is not set
> > > CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
> > > CONFIG_RSEQ=3Dy
> > > # CONFIG_EMBEDDED is not set
> > > CONFIG_HAVE_PERF_EVENTS=3Dy
> > >
> > > #
> > > # Kernel Performance Events And Counters
> > > #
> > > CONFIG_PERF_EVENTS=3Dy
> > > # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> > > # end of Kernel Performance Events And Counters
> > >
> > > CONFIG_VM_EVENT_COUNTERS=3Dy
> > > CONFIG_SLUB_DEBUG=3Dy
> > > # CONFIG_COMPAT_BRK is not set
> > > # CONFIG_SLAB is not set
> > > CONFIG_SLUB=3Dy
> > > # CONFIG_SLAB_MERGE_DEFAULT is not set
> > > # CONFIG_SLAB_FREELIST_RANDOM is not set
> > > # CONFIG_SLAB_FREELIST_HARDENED is not set
> > > # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> > > CONFIG_SLUB_CPU_PARTIAL=3Dy
> > > CONFIG_PROFILING=3Dy
> > > CONFIG_TRACEPOINTS=3Dy
> > > # end of General setup
> > >
> > > CONFIG_64BIT=3Dy
> > > CONFIG_X86_64=3Dy
> > > CONFIG_X86=3Dy
> > > CONFIG_INSTRUCTION_DECODER=3Dy
> > > CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> > > CONFIG_LOCKDEP_SUPPORT=3Dy
> > > CONFIG_STACKTRACE_SUPPORT=3Dy
> > > CONFIG_MMU=3Dy
> > > CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> > > CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> > > CONFIG_GENERIC_ISA_DMA=3Dy
> > > CONFIG_GENERIC_BUG=3Dy
> > > CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> > > CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> > > CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> > > CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> > > CONFIG_ARCH_HAS_FILTER_PGPROT=3Dy
> > > CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> > > CONFIG_ARCH_NR_GPIO=3D1024
> > > CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> > > CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> > > CONFIG_AUDIT_ARCH=3Dy
> > > CONFIG_X86_64_SMP=3Dy
> > > CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> > > CONFIG_FIX_EARLYCON_MEM=3Dy
> > > CONFIG_PGTABLE_LEVELS=3D5
> > > CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy
> > >
> > > #
> > > # Processor type and features
> > > #
> > > CONFIG_SMP=3Dy
> > > CONFIG_X86_FEATURE_NAMES=3Dy
> > > # CONFIG_X86_X2APIC is not set
> > > CONFIG_X86_MPPARSE=3Dy
> > > # CONFIG_GOLDFISH is not set
> > > # CONFIG_RETPOLINE is not set
> > > # CONFIG_X86_CPU_RESCTRL is not set
> > > # CONFIG_X86_EXTENDED_PLATFORM is not set
> > > # CONFIG_IOSF_MBI is not set
> > > # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> > > CONFIG_HYPERVISOR_GUEST=3Dy
> > > CONFIG_PARAVIRT=3Dy
> > > # CONFIG_PARAVIRT_DEBUG is not set
> > > # CONFIG_PARAVIRT_SPINLOCKS is not set
> > > CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
> > > # CONFIG_XEN is not set
> > > CONFIG_KVM_GUEST=3Dy
> > > CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
> > > # CONFIG_PVH is not set
> > > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > > CONFIG_PARAVIRT_CLOCK=3Dy
> > > # CONFIG_JAILHOUSE_GUEST is not set
> > > # CONFIG_ACRN_GUEST is not set
> > > # CONFIG_MK8 is not set
> > > # CONFIG_MPSC is not set
> > > CONFIG_MCORE2=3Dy
> > > # CONFIG_MATOM is not set
> > > # CONFIG_GENERIC_CPU is not set
> > > CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> > > CONFIG_X86_L1_CACHE_SHIFT=3D6
> > > CONFIG_X86_INTEL_USERCOPY=3Dy
> > > CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> > > CONFIG_X86_P6_NOP=3Dy
> > > CONFIG_X86_TSC=3Dy
> > > CONFIG_X86_CMPXCHG64=3Dy
> > > CONFIG_X86_CMOV=3Dy
> > > CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> > > CONFIG_X86_DEBUGCTLMSR=3Dy
> > > CONFIG_IA32_FEAT_CTL=3Dy
> > > CONFIG_X86_VMX_FEATURE_NAMES=3Dy
> > > CONFIG_CPU_SUP_INTEL=3Dy
> > > CONFIG_CPU_SUP_AMD=3Dy
> > > CONFIG_CPU_SUP_HYGON=3Dy
> > > CONFIG_CPU_SUP_CENTAUR=3Dy
> > > CONFIG_CPU_SUP_ZHAOXIN=3Dy
> > > CONFIG_HPET_TIMER=3Dy
> > > CONFIG_HPET_EMULATE_RTC=3Dy
> > > CONFIG_DMI=3Dy
> > > # CONFIG_GART_IOMMU is not set
> > > # CONFIG_MAXSMP is not set
> > > CONFIG_NR_CPUS_RANGE_BEGIN=3D2
> > > CONFIG_NR_CPUS_RANGE_END=3D512
> > > CONFIG_NR_CPUS_DEFAULT=3D64
> > > CONFIG_NR_CPUS=3D64
> > > CONFIG_SCHED_CLUSTER=3Dy
> > > CONFIG_SCHED_SMT=3Dy
> > > CONFIG_SCHED_MC=3Dy
> > > CONFIG_SCHED_MC_PRIO=3Dy
> > > CONFIG_X86_LOCAL_APIC=3Dy
> > > CONFIG_X86_IO_APIC=3Dy
> > > # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
> > > # CONFIG_X86_MCE is not set
> > >
> > > #
> > > # Performance monitoring
> > > #
> > > CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dy
> > > CONFIG_PERF_EVENTS_INTEL_RAPL=3Dy
> > > CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dy
> > > # CONFIG_PERF_EVENTS_AMD_POWER is not set
> > > CONFIG_PERF_EVENTS_AMD_UNCORE=3Dy
> > > # end of Performance monitoring
> > >
> > > CONFIG_X86_16BIT=3Dy
> > > CONFIG_X86_ESPFIX64=3Dy
> > > CONFIG_X86_VSYSCALL_EMULATION=3Dy
> > > # CONFIG_X86_IOPL_IOPERM is not set
> > > # CONFIG_MICROCODE is not set
> > > # CONFIG_X86_MSR is not set
> > > # CONFIG_X86_CPUID is not set
> > > CONFIG_X86_5LEVEL=3Dy
> > > CONFIG_X86_DIRECT_GBPAGES=3Dy
> > > # CONFIG_X86_CPA_STATISTICS is not set
> > > # CONFIG_AMD_MEM_ENCRYPT is not set
> > > # CONFIG_NUMA is not set
> > > CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> > > CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> > > CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
> > > CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> > > CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> > > # CONFIG_X86_PMEM_LEGACY is not set
> > > # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> > > CONFIG_MTRR=3Dy
> > > CONFIG_MTRR_SANITIZER=3Dy
> > > CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D0
> > > CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> > > CONFIG_X86_PAT=3Dy
> > > CONFIG_ARCH_USES_PG_UNCACHED=3Dy
> > > CONFIG_ARCH_RANDOM=3Dy
> > > CONFIG_X86_SMAP=3Dy
> > > CONFIG_X86_UMIP=3Dy
> > > CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> > > CONFIG_X86_INTEL_TSX_MODE_OFF=3Dy
> > > # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> > > # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> > > # CONFIG_HZ_100 is not set
> > > CONFIG_HZ_250=3Dy
> > > # CONFIG_HZ_300 is not set
> > > # CONFIG_HZ_1000 is not set
> > > CONFIG_HZ=3D250
> > > CONFIG_SCHED_HRTICK=3Dy
> > > CONFIG_KEXEC=3Dy
> > > CONFIG_CRASH_DUMP=3Dy
> > > CONFIG_PHYSICAL_START=3D0x1000000
> > > CONFIG_RELOCATABLE=3Dy
> > > # CONFIG_RANDOMIZE_BASE is not set
> > > CONFIG_PHYSICAL_ALIGN=3D0x200000
> > > CONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy
> > > CONFIG_HOTPLUG_CPU=3Dy
> > > # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> > > # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> > > # CONFIG_COMPAT_VDSO is not set
> > > # CONFIG_LEGACY_VSYSCALL_EMULATE is not set
> > > CONFIG_LEGACY_VSYSCALL_XONLY=3Dy
> > > # CONFIG_LEGACY_VSYSCALL_NONE is not set
> > > # CONFIG_CMDLINE_BOOL is not set
> > > CONFIG_MODIFY_LDT_SYSCALL=3Dy
> > > # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> > > CONFIG_HAVE_LIVEPATCH=3Dy
> > > # end of Processor type and features
> > >
> > > CONFIG_ARCH_HAS_ADD_PAGES=3Dy
> > > CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy
> > >
> > > #
> > > # Power management and ACPI options
> > > #
> > > CONFIG_SUSPEND=3Dy
> > > CONFIG_SUSPEND_FREEZER=3Dy
> > > # CONFIG_HIBERNATION is not set
> > > CONFIG_PM_SLEEP=3Dy
> > > CONFIG_PM_SLEEP_SMP=3Dy
> > > # CONFIG_PM_AUTOSLEEP is not set
> > > # CONFIG_PM_WAKELOCKS is not set
> > > CONFIG_PM=3Dy
> > > CONFIG_PM_DEBUG=3Dy
> > > # CONFIG_PM_ADVANCED_DEBUG is not set
> > > # CONFIG_PM_TEST_SUSPEND is not set
> > > CONFIG_PM_SLEEP_DEBUG=3Dy
> > > # CONFIG_PM_TRACE_RTC is not set
> > > CONFIG_PM_CLK=3Dy
> > > # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> > > # CONFIG_ENERGY_MODEL is not set
> > > CONFIG_ARCH_SUPPORTS_ACPI=3Dy
> > > # CONFIG_ACPI is not set
> > >
> > > #
> > > # CPU Frequency scaling
> > > #
> > > CONFIG_CPU_FREQ=3Dy
> > > CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> > > # CONFIG_CPU_FREQ_STAT is not set
> > > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> > > CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> > > # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> > > # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
> > > # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> > > # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
> > > CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
> > >
> > > #
> > > # CPU frequency scaling drivers
> > > #
> > > CONFIG_X86_INTEL_PSTATE=3Dy
> > > # CONFIG_X86_P4_CLOCKMOD is not set
> > >
> > > #
> > > # shared options
> > > #
> > > # end of CPU Frequency scaling
> > >
> > > #
> > > # CPU Idle
> > > #
> > > # CONFIG_CPU_IDLE is not set
> > > # end of CPU Idle
> > > # end of Power management and ACPI options
> > >
> > > #
> > > # Bus options (PCI etc.)
> > > #
> > > CONFIG_PCI_DIRECT=3Dy
> > > CONFIG_ISA_DMA_API=3Dy
> > > CONFIG_AMD_NB=3Dy
> > > # end of Bus options (PCI etc.)
> > >
> > > #
> > > # Binary Emulations
> > > #
> > > CONFIG_IA32_EMULATION=3Dy
> > > # CONFIG_X86_X32 is not set
> > > CONFIG_COMPAT_32=3Dy
> > > CONFIG_COMPAT=3Dy
> > > CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> > > CONFIG_SYSVIPC_COMPAT=3Dy
> > > # end of Binary Emulations
> > >
> > > CONFIG_HAVE_KVM=3Dy
> > > # CONFIG_VIRTUALIZATION is not set
> > > CONFIG_AS_AVX512=3Dy
> > > CONFIG_AS_SHA1_NI=3Dy
> > > CONFIG_AS_SHA256_NI=3Dy
> > > CONFIG_AS_TPAUSE=3Dy
> > >
> > > #
> > > # General architecture-dependent options
> > > #
> > > CONFIG_CRASH_CORE=3Dy
> > > CONFIG_KEXEC_CORE=3Dy
> > > CONFIG_HOTPLUG_SMT=3Dy
> > > CONFIG_GENERIC_ENTRY=3Dy
> > > CONFIG_KPROBES=3Dy
> > > CONFIG_JUMP_LABEL=3Dy
> > > # CONFIG_STATIC_KEYS_SELFTEST is not set
> > > # CONFIG_STATIC_CALL_SELFTEST is not set
> > > CONFIG_OPTPROBES=3Dy
> > > CONFIG_UPROBES=3Dy
> > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> > > CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> > > CONFIG_KRETPROBES=3Dy
> > > CONFIG_HAVE_IOREMAP_PROT=3Dy
> > > CONFIG_HAVE_KPROBES=3Dy
> > > CONFIG_HAVE_KRETPROBES=3Dy
> > > CONFIG_HAVE_OPTPROBES=3Dy
> > > CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> > > CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy
> > > CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
> > > CONFIG_HAVE_NMI=3Dy
> > > CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> > > CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> > > CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> > > CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> > > CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> > > CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> > > CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
> > > CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
> > > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> > > CONFIG_ARCH_WANTS_NO_INSTR=3Dy
> > > CONFIG_HAVE_ASM_MODVERSIONS=3Dy
> > > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> > > CONFIG_HAVE_RSEQ=3Dy
> > > CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
> > > CONFIG_HAVE_HW_BREAKPOINT=3Dy
> > > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> > > CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> > > CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> > > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
> > > CONFIG_HAVE_PERF_REGS=3Dy
> > > CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> > > CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> > > CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
> > > CONFIG_MMU_GATHER_TABLE_FREE=3Dy
> > > CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
> > > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> > > CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
> > > CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> > > CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> > > CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> > > CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> > > CONFIG_HAVE_ARCH_SECCOMP=3Dy
> > > CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> > > # CONFIG_SECCOMP is not set
> > > CONFIG_HAVE_ARCH_STACKLEAK=3Dy
> > > CONFIG_HAVE_STACKPROTECTOR=3Dy
> > > # CONFIG_STACKPROTECTOR is not set
> > > CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy
> > > CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy
> > > CONFIG_LTO_NONE=3Dy
> > > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> > > CONFIG_HAVE_CONTEXT_TRACKING=3Dy
> > > CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=3Dy
> > > CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> > > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> > > CONFIG_HAVE_MOVE_PUD=3Dy
> > > CONFIG_HAVE_MOVE_PMD=3Dy
> > > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> > > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> > > CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> > > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> > > CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> > > CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> > > CONFIG_MODULES_USE_ELF_RELA=3Dy
> > > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> > > CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
> > > CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> > > CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> > > CONFIG_HAVE_EXIT_THREAD=3Dy
> > > CONFIG_ARCH_MMAP_RND_BITS=3D28
> > > CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> > > CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> > > CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy
> > > CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy
> > > CONFIG_HAVE_STACK_VALIDATION=3Dy
> > > CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
> > > CONFIG_OLD_SIGSUSPEND3=3Dy
> > > CONFIG_COMPAT_OLD_SIGACTION=3Dy
> > > # CONFIG_COMPAT_32BIT_TIME is not set
> > > CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> > > # CONFIG_VMAP_STACK is not set
> > > CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy
> > > # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> > > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> > > CONFIG_STRICT_KERNEL_RWX=3Dy
> > > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> > > CONFIG_STRICT_MODULE_RWX=3Dy
> > > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
> > > # CONFIG_LOCK_EVENT_COUNTS is not set
> > > CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy
> > > CONFIG_HAVE_STATIC_CALL=3Dy
> > > CONFIG_HAVE_STATIC_CALL_INLINE=3Dy
> > > CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> > > CONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy
> > > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> > > CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=3Dy
> > > CONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy
> > > CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=3Dy
> > > CONFIG_DYNAMIC_SIGFRAME=3Dy
> > >
> > > #
> > > # GCOV-based kernel profiling
> > > #
> > > # CONFIG_GCOV_KERNEL is not set
> > > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> > > # end of GCOV-based kernel profiling
> > >
> > > CONFIG_HAVE_GCC_PLUGINS=3Dy
> > > # end of General architecture-dependent options
> > >
> > > CONFIG_RT_MUTEXES=3Dy
> > > CONFIG_BASE_SMALL=3D0
> > > CONFIG_MODULES=3Dy
> > > # CONFIG_MODULE_FORCE_LOAD is not set
> > > CONFIG_MODULE_UNLOAD=3Dy
> > > # CONFIG_MODULE_FORCE_UNLOAD is not set
> > > # CONFIG_MODVERSIONS is not set
> > > # CONFIG_MODULE_SRCVERSION_ALL is not set
> > > # CONFIG_MODULE_SIG is not set
> > > CONFIG_MODULE_COMPRESS_NONE=3Dy
> > > # CONFIG_MODULE_COMPRESS_GZIP is not set
> > > # CONFIG_MODULE_COMPRESS_XZ is not set
> > > # CONFIG_MODULE_COMPRESS_ZSTD is not set
> > > # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> > > CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
> > > CONFIG_MODULES_TREE_LOOKUP=3Dy
> > > CONFIG_BLOCK=3Dy
> > > CONFIG_BLK_DEV_BSG_COMMON=3Dy
> > > # CONFIG_BLK_DEV_BSGLIB is not set
> > > # CONFIG_BLK_DEV_INTEGRITY is not set
> > > CONFIG_BLK_DEV_ZONED=3Dy
> > > # CONFIG_BLK_WBT is not set
> > > CONFIG_BLK_DEBUG_FS=3Dy
> > > CONFIG_BLK_DEBUG_FS_ZONED=3Dy
> > > # CONFIG_BLK_SED_OPAL is not set
> > > # CONFIG_BLK_INLINE_ENCRYPTION is not set
> > >
> > > #
> > > # Partition Types
> > > #
> > > # CONFIG_PARTITION_ADVANCED is not set
> > > CONFIG_MSDOS_PARTITION=3Dy
> > > CONFIG_EFI_PARTITION=3Dy
> > > # end of Partition Types
> > >
> > > CONFIG_BLOCK_COMPAT=3Dy
> > > CONFIG_BLK_MQ_PCI=3Dy
> > > CONFIG_BLK_MQ_VIRTIO=3Dy
> > > CONFIG_BLK_PM=3Dy
> > > CONFIG_BLOCK_HOLDER_DEPRECATED=3Dy
> > >
> > > #
> > > # IO Schedulers
> > > #
> > > CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> > > CONFIG_MQ_IOSCHED_KYBER=3Dy
> > > # CONFIG_IOSCHED_BFQ is not set
> > > # end of IO Schedulers
> > >
> > > CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
> > > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> > > CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> > > CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> > > CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> > > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> > > CONFIG_QUEUED_SPINLOCKS=3Dy
> > > CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> > > CONFIG_QUEUED_RWLOCKS=3Dy
> > > CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy
> > > CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
> > > CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
> > > CONFIG_FREEZER=3Dy
> > >
> > > #
> > > # Executable file formats
> > > #
> > > CONFIG_BINFMT_ELF=3Dy
> > > CONFIG_COMPAT_BINFMT_ELF=3Dy
> > > CONFIG_ELFCORE=3Dy
> > > CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> > > CONFIG_BINFMT_SCRIPT=3Dy
> > > # CONFIG_BINFMT_MISC is not set
> > > CONFIG_COREDUMP=3Dy
> > > # end of Executable file formats
> > >
> > > #
> > > # Memory Management options
> > > #
> > > CONFIG_SELECT_MEMORY_MODEL=3Dy
> > > CONFIG_SPARSEMEM_MANUAL=3Dy
> > > CONFIG_SPARSEMEM=3Dy
> > > CONFIG_SPARSEMEM_EXTREME=3Dy
> > > CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> > > CONFIG_SPARSEMEM_VMEMMAP=3Dy
> > > CONFIG_HAVE_FAST_GUP=3Dy
> > > CONFIG_EXCLUSIVE_SYSTEM_RAM=3Dy
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> > > # CONFIG_MEMORY_HOTPLUG is not set
> > > CONFIG_SPLIT_PTLOCK_CPUS=3D4
> > > CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> > > # CONFIG_COMPACTION is not set
> > > # CONFIG_PAGE_REPORTING is not set
> > > CONFIG_PHYS_ADDR_T_64BIT=3Dy
> > > CONFIG_VIRT_TO_BUS=3Dy
> > > # CONFIG_KSM is not set
> > > CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> > > # CONFIG_TRANSPARENT_HUGEPAGE is not set
> > > CONFIG_ARCH_WANTS_THP_SWAP=3Dy
> > > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> > > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> > > CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> > > # CONFIG_CMA is not set
> > > # CONFIG_ZSWAP is not set
> > > # CONFIG_ZPOOL is not set
> > > # CONFIG_ZSMALLOC is not set
> > > CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> > > # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> > > # CONFIG_IDLE_PAGE_TRACKING is not set
> > > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> > > CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
> > > CONFIG_ZONE_DMA=3Dy
> > > CONFIG_ZONE_DMA32=3Dy
> > > CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> > > CONFIG_ARCH_HAS_PKEYS=3Dy
> > > # CONFIG_PERCPU_STATS is not set
> > > # CONFIG_GUP_TEST is not set
> > > CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
> > > CONFIG_SECRETMEM=3Dy
> > > # CONFIG_ANON_VMA_NAME is not set
> > >
> > > #
> > > # Data Access Monitoring
> > > #
> > > # CONFIG_DAMON is not set
> > > # end of Data Access Monitoring
> > > # end of Memory Management options
> > >
> > > CONFIG_NET=3Dy
> > >
> > > #
> > > # Networking options
> > > #
> > > CONFIG_PACKET=3Dy
> > > # CONFIG_PACKET_DIAG is not set
> > > CONFIG_UNIX=3Dy
> > > CONFIG_UNIX_SCM=3Dy
> > > CONFIG_AF_UNIX_OOB=3Dy
> > > # CONFIG_UNIX_DIAG is not set
> > > # CONFIG_TLS is not set
> > > # CONFIG_XFRM_USER is not set
> > > # CONFIG_NET_KEY is not set
> > > CONFIG_INET=3Dy
> > > CONFIG_IP_MULTICAST=3Dy
> > > # CONFIG_IP_ADVANCED_ROUTER is not set
> > > # CONFIG_IP_PNP is not set
> > > # CONFIG_NET_IPIP is not set
> > > # CONFIG_NET_IPGRE_DEMUX is not set
> > > CONFIG_NET_IP_TUNNEL=3Dy
> > > # CONFIG_IP_MROUTE is not set
> > > # CONFIG_SYN_COOKIES is not set
> > > # CONFIG_NET_IPVTI is not set
> > > # CONFIG_NET_FOU is not set
> > > # CONFIG_NET_FOU_IP_TUNNELS is not set
> > > # CONFIG_INET_AH is not set
> > > # CONFIG_INET_ESP is not set
> > > # CONFIG_INET_IPCOMP is not set
> > > CONFIG_INET_TUNNEL=3Dy
> > > CONFIG_INET_DIAG=3Dy
> > > CONFIG_INET_TCP_DIAG=3Dy
> > > # CONFIG_INET_UDP_DIAG is not set
> > > # CONFIG_INET_RAW_DIAG is not set
> > > # CONFIG_INET_DIAG_DESTROY is not set
> > > # CONFIG_TCP_CONG_ADVANCED is not set
> > > CONFIG_TCP_CONG_CUBIC=3Dy
> > > CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> > > # CONFIG_TCP_MD5SIG is not set
> > > CONFIG_IPV6=3Dy
> > > # CONFIG_IPV6_ROUTER_PREF is not set
> > > # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> > > # CONFIG_INET6_AH is not set
> > > # CONFIG_INET6_ESP is not set
> > > # CONFIG_INET6_IPCOMP is not set
> > > # CONFIG_IPV6_MIP6 is not set
> > > # CONFIG_IPV6_VTI is not set
> > > CONFIG_IPV6_SIT=3Dy
> > > # CONFIG_IPV6_SIT_6RD is not set
> > > CONFIG_IPV6_NDISC_NODETYPE=3Dy
> > > # CONFIG_IPV6_TUNNEL is not set
> > > # CONFIG_IPV6_MULTIPLE_TABLES is not set
> > > # CONFIG_IPV6_MROUTE is not set
> > > # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> > > # CONFIG_IPV6_SEG6_HMAC is not set
> > > # CONFIG_IPV6_RPL_LWTUNNEL is not set
> > > # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> > > # CONFIG_MPTCP is not set
> > > # CONFIG_NETWORK_SECMARK is not set
> > > # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> > > # CONFIG_NETFILTER is not set
> > > # CONFIG_BPFILTER is not set
> > > # CONFIG_IP_DCCP is not set
> > > # CONFIG_IP_SCTP is not set
> > > # CONFIG_RDS is not set
> > > # CONFIG_TIPC is not set
> > > # CONFIG_ATM is not set
> > > # CONFIG_L2TP is not set
> > > # CONFIG_BRIDGE is not set
> > > # CONFIG_NET_DSA is not set
> > > # CONFIG_VLAN_8021Q is not set
> > > # CONFIG_DECNET is not set
> > > # CONFIG_LLC2 is not set
> > > # CONFIG_ATALK is not set
> > > # CONFIG_X25 is not set
> > > # CONFIG_LAPB is not set
> > > # CONFIG_PHONET is not set
> > > # CONFIG_6LOWPAN is not set
> > > # CONFIG_IEEE802154 is not set
> > > # CONFIG_NET_SCHED is not set
> > > # CONFIG_DCB is not set
> > > # CONFIG_BATMAN_ADV is not set
> > > # CONFIG_OPENVSWITCH is not set
> > > # CONFIG_VSOCKETS is not set
> > > # CONFIG_NETLINK_DIAG is not set
> > > # CONFIG_MPLS is not set
> > > # CONFIG_NET_NSH is not set
> > > # CONFIG_HSR is not set
> > > # CONFIG_NET_SWITCHDEV is not set
> > > # CONFIG_NET_L3_MASTER_DEV is not set
> > > # CONFIG_QRTR is not set
> > > # CONFIG_NET_NCSI is not set
> > > CONFIG_PCPU_DEV_REFCNT=3Dy
> > > CONFIG_RPS=3Dy
> > > CONFIG_RFS_ACCEL=3Dy
> > > CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy
> > > CONFIG_XPS=3Dy
> > > # CONFIG_CGROUP_NET_PRIO is not set
> > > # CONFIG_CGROUP_NET_CLASSID is not set
> > > CONFIG_NET_RX_BUSY_POLL=3Dy
> > > CONFIG_BQL=3Dy
> > > CONFIG_NET_FLOW_LIMIT=3Dy
> > >
> > > #
> > > # Network testing
> > > #
> > > # CONFIG_NET_PKTGEN is not set
> > > # CONFIG_NET_DROP_MONITOR is not set
> > > # end of Network testing
> > > # end of Networking options
> > >
> > > # CONFIG_HAMRADIO is not set
> > > # CONFIG_CAN is not set
> > > # CONFIG_BT is not set
> > > # CONFIG_AF_RXRPC is not set
> > > # CONFIG_AF_KCM is not set
> > > # CONFIG_MCTP is not set
> > > CONFIG_WIRELESS=3Dy
> > > # CONFIG_CFG80211 is not set
> > >
> > > #
> > > # CFG80211 needs to be enabled for MAC80211
> > > #
> > > CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> > > # CONFIG_RFKILL is not set
> > > CONFIG_NET_9P=3Dy
> > > CONFIG_NET_9P_FD=3Dy
> > > CONFIG_NET_9P_VIRTIO=3Dy
> > > # CONFIG_NET_9P_DEBUG is not set
> > > # CONFIG_CAIF is not set
> > > # CONFIG_CEPH_LIB is not set
> > > # CONFIG_NFC is not set
> > > # CONFIG_PSAMPLE is not set
> > > # CONFIG_NET_IFE is not set
> > > # CONFIG_LWTUNNEL is not set
> > > CONFIG_DST_CACHE=3Dy
> > > CONFIG_GRO_CELLS=3Dy
> > > CONFIG_FAILOVER=3Dy
> > > CONFIG_ETHTOOL_NETLINK=3Dy
> > >
> > > #
> > > # Device Drivers
> > > #
> > > CONFIG_HAVE_EISA=3Dy
> > > # CONFIG_EISA is not set
> > > CONFIG_HAVE_PCI=3Dy
> > > CONFIG_PCI=3Dy
> > > CONFIG_PCI_DOMAINS=3Dy
> > > # CONFIG_PCIEPORTBUS is not set
> > > CONFIG_PCIEASPM=3Dy
> > > CONFIG_PCIEASPM_DEFAULT=3Dy
> > > # CONFIG_PCIEASPM_POWERSAVE is not set
> > > # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> > > # CONFIG_PCIEASPM_PERFORMANCE is not set
> > > # CONFIG_PCIE_PTM is not set
> > > # CONFIG_PCI_MSI is not set
> > > CONFIG_PCI_QUIRKS=3Dy
> > > # CONFIG_PCI_DEBUG is not set
> > > # CONFIG_PCI_STUB is not set
> > > CONFIG_PCI_LOCKLESS_CONFIG=3Dy
> > > # CONFIG_PCI_IOV is not set
> > > # CONFIG_PCI_PRI is not set
> > > # CONFIG_PCI_PASID is not set
> > > CONFIG_PCI_LABEL=3Dy
> > > # CONFIG_HOTPLUG_PCI is not set
> > >
> > > #
> > > # PCI controller drivers
> > > #
> > >
> > > #
> > > # DesignWare PCI Core Support
> > > #
> > > # end of DesignWare PCI Core Support
> > >
> > > #
> > > # Mobiveil PCIe Core Support
> > > #
> > > # end of Mobiveil PCIe Core Support
> > >
> > > #
> > > # Cadence PCIe controllers support
> > > #
> > > # end of Cadence PCIe controllers support
> > > # end of PCI controller drivers
> > >
> > > #
> > > # PCI Endpoint
> > > #
> > > # CONFIG_PCI_ENDPOINT is not set
> > > # end of PCI Endpoint
> > >
> > > #
> > > # PCI switch controller drivers
> > > #
> > > # CONFIG_PCI_SW_SWITCHTEC is not set
> > > # end of PCI switch controller drivers
> > >
> > > # CONFIG_CXL_BUS is not set
> > > # CONFIG_PCCARD is not set
> > > # CONFIG_RAPIDIO is not set
> > >
> > > #
> > > # Generic Driver Options
> > > #
> > > # CONFIG_UEVENT_HELPER is not set
> > > CONFIG_DEVTMPFS=3Dy
> > > CONFIG_DEVTMPFS_MOUNT=3Dy
> > > # CONFIG_DEVTMPFS_SAFE is not set
> > > # CONFIG_STANDALONE is not set
> > > # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> > >
> > > #
> > > # Firmware loader
> > > #
> > > CONFIG_FW_LOADER=3Dy
> > > CONFIG_EXTRA_FIRMWARE=3D""
> > > # CONFIG_FW_LOADER_USER_HELPER is not set
> > > # CONFIG_FW_LOADER_COMPRESS is not set
> > > CONFIG_FW_CACHE=3Dy
> > > # end of Firmware loader
> > >
> > > CONFIG_ALLOW_DEV_COREDUMP=3Dy
> > > # CONFIG_DEBUG_DRIVER is not set
> > > # CONFIG_DEBUG_DEVRES is not set
> > > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > > # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> > > CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> > > CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
> > > # end of Generic Driver Options
> > >
> > > #
> > > # Bus devices
> > > #
> > > # CONFIG_MHI_BUS is not set
> > > # end of Bus devices
> > >
> > > # CONFIG_CONNECTOR is not set
> > >
> > > #
> > > # Firmware Drivers
> > > #
> > >
> > > #
> > > # ARM System Control and Management Interface Protocol
> > > #
> > > # end of ARM System Control and Management Interface Protocol
> > >
> > > # CONFIG_EDD is not set
> > > CONFIG_FIRMWARE_MEMMAP=3Dy
> > > CONFIG_DMIID=3Dy
> > > # CONFIG_DMI_SYSFS is not set
> > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> > > # CONFIG_FW_CFG_SYSFS is not set
> > > CONFIG_SYSFB=3Dy
> > > # CONFIG_SYSFB_SIMPLEFB is not set
> > > # CONFIG_GOOGLE_FIRMWARE is not set
> > >
> > > #
> > > # Tegra firmware driver
> > > #
> > > # end of Tegra firmware driver
> > > # end of Firmware Drivers
> > >
> > > # CONFIG_GNSS is not set
> > > # CONFIG_MTD is not set
> > > # CONFIG_OF is not set
> > > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> > > # CONFIG_PARPORT is not set
> > > CONFIG_BLK_DEV=3Dy
> > > # CONFIG_BLK_DEV_NULL_BLK is not set
> > > # CONFIG_BLK_DEV_FD is not set
> > > # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> > > CONFIG_BLK_DEV_LOOP=3Dy
> > > CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
> > > # CONFIG_BLK_DEV_DRBD is not set
> > > # CONFIG_BLK_DEV_NBD is not set
> > > # CONFIG_BLK_DEV_SX8 is not set
> > > # CONFIG_BLK_DEV_RAM is not set
> > > # CONFIG_CDROM_PKTCDVD is not set
> > > # CONFIG_ATA_OVER_ETH is not set
> > > # CONFIG_VIRTIO_BLK is not set
> > > # CONFIG_BLK_DEV_RBD is not set
> > >
> > > #
> > > # NVME Support
> > > #
> > > # CONFIG_BLK_DEV_NVME is not set
> > > # CONFIG_NVME_FC is not set
> > > # CONFIG_NVME_TCP is not set
> > > # CONFIG_NVME_TARGET is not set
> > > # end of NVME Support
> > >
> > > #
> > > # Misc devices
> > > #
> > > # CONFIG_DUMMY_IRQ is not set
> > > # CONFIG_IBM_ASM is not set
> > > # CONFIG_PHANTOM is not set
> > > # CONFIG_TIFM_CORE is not set
> > > # CONFIG_ENCLOSURE_SERVICES is not set
> > > # CONFIG_HP_ILO is not set
> > > # CONFIG_SRAM is not set
> > > # CONFIG_DW_XDATA_PCIE is not set
> > > # CONFIG_PCI_ENDPOINT_TEST is not set
> > > # CONFIG_XILINX_SDFEC is not set
> > > # CONFIG_C2PORT is not set
> > >
> > > #
> > > # EEPROM support
> > > #
> > > # CONFIG_EEPROM_93CX6 is not set
> > > # end of EEPROM support
> > >
> > > # CONFIG_CB710_CORE is not set
> > >
> > > #
> > > # Texas Instruments shared transport line discipline
> > > #
> > > # end of Texas Instruments shared transport line discipline
> > >
> > > #
> > > # Altera FPGA firmware download module (requires I2C)
> > > #
> > > # CONFIG_INTEL_MEI is not set
> > > # CONFIG_INTEL_MEI_ME is not set
> > > # CONFIG_INTEL_MEI_TXE is not set
> > > # CONFIG_VMWARE_VMCI is not set
> > > # CONFIG_GENWQE is not set
> > > # CONFIG_ECHO is not set
> > > # CONFIG_MISC_ALCOR_PCI is not set
> > > # CONFIG_MISC_RTSX_PCI is not set
> > > # CONFIG_HABANA_AI is not set
> > > # CONFIG_PVPANIC is not set
> > > # end of Misc devices
> > >
> > > #
> > > # SCSI device support
> > > #
> > > CONFIG_SCSI_MOD=3Dy
> > > # CONFIG_RAID_ATTRS is not set
> > > CONFIG_SCSI_COMMON=3Dy
> > > CONFIG_SCSI=3Dy
> > > CONFIG_SCSI_DMA=3Dy
> > > CONFIG_SCSI_PROC_FS=3Dy
> > >
> > > #
> > > # SCSI support type (disk, tape, CD-ROM)
> > > #
> > > CONFIG_BLK_DEV_SD=3Dy
> > > # CONFIG_CHR_DEV_ST is not set
> > > # CONFIG_BLK_DEV_SR is not set
> > > # CONFIG_CHR_DEV_SG is not set
> > > CONFIG_BLK_DEV_BSG=3Dy
> > > # CONFIG_CHR_DEV_SCH is not set
> > > # CONFIG_SCSI_CONSTANTS is not set
> > > # CONFIG_SCSI_LOGGING is not set
> > > # CONFIG_SCSI_SCAN_ASYNC is not set
> > >
> > > #
> > > # SCSI Transports
> > > #
> > > # CONFIG_SCSI_SPI_ATTRS is not set
> > > # CONFIG_SCSI_FC_ATTRS is not set
> > > # CONFIG_SCSI_ISCSI_ATTRS is not set
> > > # CONFIG_SCSI_SAS_ATTRS is not set
> > > # CONFIG_SCSI_SAS_LIBSAS is not set
> > > # CONFIG_SCSI_SRP_ATTRS is not set
> > > # end of SCSI Transports
> > >
> > > CONFIG_SCSI_LOWLEVEL=3Dy
> > > # CONFIG_ISCSI_TCP is not set
> > > # CONFIG_ISCSI_BOOT_SYSFS is not set
> > > # CONFIG_SCSI_CXGB3_ISCSI is not set
> > > # CONFIG_SCSI_CXGB4_ISCSI is not set
> > > # CONFIG_SCSI_BNX2_ISCSI is not set
> > > # CONFIG_BE2ISCSI is not set
> > > # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> > > # CONFIG_SCSI_HPSA is not set
> > > # CONFIG_SCSI_3W_9XXX is not set
> > > # CONFIG_SCSI_3W_SAS is not set
> > > # CONFIG_SCSI_ACARD is not set
> > > # CONFIG_SCSI_AACRAID is not set
> > > # CONFIG_SCSI_AIC7XXX is not set
> > > # CONFIG_SCSI_AIC79XX is not set
> > > # CONFIG_SCSI_AIC94XX is not set
> > > # CONFIG_SCSI_MVSAS is not set
> > > # CONFIG_SCSI_MVUMI is not set
> > > # CONFIG_SCSI_DPT_I2O is not set
> > > # CONFIG_SCSI_ADVANSYS is not set
> > > # CONFIG_SCSI_ARCMSR is not set
> > > # CONFIG_SCSI_ESAS2R is not set
> > > # CONFIG_MEGARAID_NEWGEN is not set
> > > # CONFIG_MEGARAID_LEGACY is not set
> > > # CONFIG_MEGARAID_SAS is not set
> > > # CONFIG_SCSI_MPT3SAS is not set
> > > # CONFIG_SCSI_MPT2SAS is not set
> > > # CONFIG_SCSI_MPI3MR is not set
> > > # CONFIG_SCSI_SMARTPQI is not set
> > > # CONFIG_SCSI_UFSHCD is not set
> > > # CONFIG_SCSI_HPTIOP is not set
> > > # CONFIG_SCSI_BUSLOGIC is not set
> > > # CONFIG_SCSI_MYRB is not set
> > > # CONFIG_SCSI_MYRS is not set
> > > # CONFIG_VMWARE_PVSCSI is not set
> > > # CONFIG_SCSI_SNIC is not set
> > > # CONFIG_SCSI_DMX3191D is not set
> > > # CONFIG_SCSI_FDOMAIN_PCI is not set
> > > # CONFIG_SCSI_ISCI is not set
> > > # CONFIG_SCSI_IPS is not set
> > > # CONFIG_SCSI_INITIO is not set
> > > # CONFIG_SCSI_INIA100 is not set
> > > # CONFIG_SCSI_STEX is not set
> > > # CONFIG_SCSI_SYM53C8XX_2 is not set
> > > # CONFIG_SCSI_QLOGIC_1280 is not set
> > > # CONFIG_SCSI_QLA_ISCSI is not set
> > > # CONFIG_SCSI_DC395x is not set
> > > # CONFIG_SCSI_AM53C974 is not set
> > > # CONFIG_SCSI_WD719X is not set
> > > CONFIG_SCSI_DEBUG=3Dm
> > > # CONFIG_SCSI_PMCRAID is not set
> > > # CONFIG_SCSI_PM8001 is not set
> > > CONFIG_SCSI_VIRTIO=3Dy
> > > # CONFIG_SCSI_DH is not set
> > > # end of SCSI device support
> > >
> > > # CONFIG_ATA is not set
> > > CONFIG_MD=3Dy
> > > # CONFIG_BLK_DEV_MD is not set
> > > # CONFIG_BCACHE is not set
> > > CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> > > CONFIG_BLK_DEV_DM=3Dy
> > > # CONFIG_DM_DEBUG is not set
> > > CONFIG_DM_BUFIO=3Dy
> > > # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> > > CONFIG_DM_BIO_PRISON=3Dy
> > > CONFIG_DM_PERSISTENT_DATA=3Dy
> > > # CONFIG_DM_UNSTRIPED is not set
> > > # CONFIG_DM_CRYPT is not set
> > > CONFIG_DM_SNAPSHOT=3Dy
> > > CONFIG_DM_THIN_PROVISIONING=3Dy
> > > # CONFIG_DM_CACHE is not set
> > > # CONFIG_DM_WRITECACHE is not set
> > > # CONFIG_DM_EBS is not set
> > > # CONFIG_DM_ERA is not set
> > > # CONFIG_DM_CLONE is not set
> > > # CONFIG_DM_MIRROR is not set
> > > # CONFIG_DM_RAID is not set
> > > # CONFIG_DM_ZERO is not set
> > > # CONFIG_DM_MULTIPATH is not set
> > > # CONFIG_DM_DELAY is not set
> > > # CONFIG_DM_DUST is not set
> > > # CONFIG_DM_INIT is not set
> > > # CONFIG_DM_UEVENT is not set
> > > CONFIG_DM_FLAKEY=3Dy
> > > # CONFIG_DM_VERITY is not set
> > > # CONFIG_DM_SWITCH is not set
> > > CONFIG_DM_LOG_WRITES=3Dy
> > > # CONFIG_DM_INTEGRITY is not set
> > > # CONFIG_DM_ZONED is not set
> > > # CONFIG_TARGET_CORE is not set
> > > # CONFIG_FUSION is not set
> > >
> > > #
> > > # IEEE 1394 (FireWire) support
> > > #
> > > # CONFIG_FIREWIRE is not set
> > > # CONFIG_FIREWIRE_NOSY is not set
> > > # end of IEEE 1394 (FireWire) support
> > >
> > > # CONFIG_MACINTOSH_DRIVERS is not set
> > > CONFIG_NETDEVICES=3Dy
> > > CONFIG_NET_CORE=3Dy
> > > # CONFIG_BONDING is not set
> > > # CONFIG_DUMMY is not set
> > > # CONFIG_WIREGUARD is not set
> > > # CONFIG_EQUALIZER is not set
> > > # CONFIG_NET_FC is not set
> > > # CONFIG_NET_TEAM is not set
> > > # CONFIG_MACVLAN is not set
> > > # CONFIG_IPVLAN is not set
> > > # CONFIG_VXLAN is not set
> > > # CONFIG_GENEVE is not set
> > > # CONFIG_BAREUDP is not set
> > > # CONFIG_GTP is not set
> > > # CONFIG_AMT is not set
> > > # CONFIG_MACSEC is not set
> > > # CONFIG_NETCONSOLE is not set
> > > # CONFIG_TUN is not set
> > > # CONFIG_TUN_VNET_CROSS_LE is not set
> > > # CONFIG_VETH is not set
> > > CONFIG_VIRTIO_NET=3Dy
> > > # CONFIG_NLMON is not set
> > > # CONFIG_ARCNET is not set
> > > CONFIG_ETHERNET=3Dy
> > > CONFIG_NET_VENDOR_3COM=3Dy
> > > # CONFIG_VORTEX is not set
> > > # CONFIG_TYPHOON is not set
> > > CONFIG_NET_VENDOR_ADAPTEC=3Dy
> > > # CONFIG_ADAPTEC_STARFIRE is not set
> > > CONFIG_NET_VENDOR_AGERE=3Dy
> > > # CONFIG_ET131X is not set
> > > CONFIG_NET_VENDOR_ALACRITECH=3Dy
> > > # CONFIG_SLICOSS is not set
> > > CONFIG_NET_VENDOR_ALTEON=3Dy
> > > # CONFIG_ACENIC is not set
> > > # CONFIG_ALTERA_TSE is not set
> > > CONFIG_NET_VENDOR_AMAZON=3Dy
> > > CONFIG_NET_VENDOR_AMD=3Dy
> > > # CONFIG_AMD8111_ETH is not set
> > > # CONFIG_PCNET32 is not set
> > > # CONFIG_AMD_XGBE is not set
> > > CONFIG_NET_VENDOR_AQUANTIA=3Dy
> > > # CONFIG_AQTION is not set
> > > CONFIG_NET_VENDOR_ARC=3Dy
> > > CONFIG_NET_VENDOR_ASIX=3Dy
> > > CONFIG_NET_VENDOR_ATHEROS=3Dy
> > > # CONFIG_ATL2 is not set
> > > # CONFIG_ATL1 is not set
> > > # CONFIG_ATL1E is not set
> > > # CONFIG_ATL1C is not set
> > > # CONFIG_ALX is not set
> > > CONFIG_NET_VENDOR_BROADCOM=3Dy
> > > # CONFIG_B44 is not set
> > > # CONFIG_BCMGENET is not set
> > > # CONFIG_BNX2 is not set
> > > # CONFIG_CNIC is not set
> > > # CONFIG_TIGON3 is not set
> > > # CONFIG_BNX2X is not set
> > > # CONFIG_SYSTEMPORT is not set
> > > # CONFIG_BNXT is not set
> > > CONFIG_NET_VENDOR_BROCADE=3Dy
> > > # CONFIG_BNA is not set
> > > CONFIG_NET_VENDOR_CADENCE=3Dy
> > > # CONFIG_MACB is not set
> > > CONFIG_NET_VENDOR_CAVIUM=3Dy
> > > # CONFIG_THUNDER_NIC_PF is not set
> > > # CONFIG_THUNDER_NIC_VF is not set
> > > # CONFIG_THUNDER_NIC_BGX is not set
> > > # CONFIG_THUNDER_NIC_RGX is not set
> > > # CONFIG_LIQUIDIO is not set
> > > CONFIG_NET_VENDOR_CHELSIO=3Dy
> > > # CONFIG_CHELSIO_T1 is not set
> > > # CONFIG_CHELSIO_T3 is not set
> > > # CONFIG_CHELSIO_T4 is not set
> > > # CONFIG_CHELSIO_T4VF is not set
> > > CONFIG_NET_VENDOR_CISCO=3Dy
> > > # CONFIG_ENIC is not set
> > > CONFIG_NET_VENDOR_CORTINA=3Dy
> > > # CONFIG_CX_ECAT is not set
> > > # CONFIG_DNET is not set
> > > CONFIG_NET_VENDOR_DEC=3Dy
> > > # CONFIG_NET_TULIP is not set
> > > CONFIG_NET_VENDOR_DLINK=3Dy
> > > # CONFIG_DL2K is not set
> > > # CONFIG_SUNDANCE is not set
> > > CONFIG_NET_VENDOR_EMULEX=3Dy
> > > # CONFIG_BE2NET is not set
> > > CONFIG_NET_VENDOR_ENGLEDER=3Dy
> > > # CONFIG_TSNEP is not set
> > > CONFIG_NET_VENDOR_EZCHIP=3Dy
> > > CONFIG_NET_VENDOR_GOOGLE=3Dy
> > > CONFIG_NET_VENDOR_HUAWEI=3Dy
> > > CONFIG_NET_VENDOR_I825XX=3Dy
> > > CONFIG_NET_VENDOR_INTEL=3Dy
> > > # CONFIG_E100 is not set
> > > # CONFIG_E1000 is not set
> > > # CONFIG_E1000E is not set
> > > # CONFIG_IGB is not set
> > > # CONFIG_IGBVF is not set
> > > # CONFIG_IXGB is not set
> > > # CONFIG_IXGBE is not set
> > > # CONFIG_I40E is not set
> > > # CONFIG_IGC is not set
> > > CONFIG_NET_VENDOR_MICROSOFT=3Dy
> > > # CONFIG_JME is not set
> > > CONFIG_NET_VENDOR_LITEX=3Dy
> > > CONFIG_NET_VENDOR_MARVELL=3Dy
> > > # CONFIG_MVMDIO is not set
> > > # CONFIG_SKGE is not set
> > > # CONFIG_SKY2 is not set
> > > CONFIG_NET_VENDOR_MELLANOX=3Dy
> > > # CONFIG_MLX4_EN is not set
> > > # CONFIG_MLX5_CORE is not set
> > > # CONFIG_MLXSW_CORE is not set
> > > # CONFIG_MLXFW is not set
> > > CONFIG_NET_VENDOR_MICREL=3Dy
> > > # CONFIG_KS8851_MLL is not set
> > > # CONFIG_KSZ884X_PCI is not set
> > > CONFIG_NET_VENDOR_MICROCHIP=3Dy
> > > # CONFIG_LAN743X is not set
> > > CONFIG_NET_VENDOR_MICROSEMI=3Dy
> > > CONFIG_NET_VENDOR_MYRI=3Dy
> > > # CONFIG_MYRI10GE is not set
> > > # CONFIG_FEALNX is not set
> > > CONFIG_NET_VENDOR_NATSEMI=3Dy
> > > # CONFIG_NATSEMI is not set
> > > # CONFIG_NS83820 is not set
> > > CONFIG_NET_VENDOR_NETERION=3Dy
> > > # CONFIG_S2IO is not set
> > > # CONFIG_VXGE is not set
> > > CONFIG_NET_VENDOR_NETRONOME=3Dy
> > > CONFIG_NET_VENDOR_NI=3Dy
> > > # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> > > CONFIG_NET_VENDOR_8390=3Dy
> > > # CONFIG_NE2K_PCI is not set
> > > CONFIG_NET_VENDOR_NVIDIA=3Dy
> > > # CONFIG_FORCEDETH is not set
> > > CONFIG_NET_VENDOR_OKI=3Dy
> > > # CONFIG_ETHOC is not set
> > > CONFIG_NET_VENDOR_PACKET_ENGINES=3Dy
> > > # CONFIG_HAMACHI is not set
> > > # CONFIG_YELLOWFIN is not set
> > > CONFIG_NET_VENDOR_PENSANDO=3Dy
> > > # CONFIG_IONIC is not set
> > > CONFIG_NET_VENDOR_QLOGIC=3Dy
> > > # CONFIG_QLA3XXX is not set
> > > # CONFIG_QLCNIC is not set
> > > # CONFIG_NETXEN_NIC is not set
> > > # CONFIG_QED is not set
> > > CONFIG_NET_VENDOR_QUALCOMM=3Dy
> > > # CONFIG_QCOM_EMAC is not set
> > > # CONFIG_RMNET is not set
> > > CONFIG_NET_VENDOR_RDC=3Dy
> > > # CONFIG_R6040 is not set
> > > CONFIG_NET_VENDOR_REALTEK=3Dy
> > > # CONFIG_8139CP is not set
> > > # CONFIG_8139TOO is not set
> > > # CONFIG_R8169 is not set
> > > CONFIG_NET_VENDOR_RENESAS=3Dy
> > > CONFIG_NET_VENDOR_ROCKER=3Dy
> > > CONFIG_NET_VENDOR_SAMSUNG=3Dy
> > > # CONFIG_SXGBE_ETH is not set
> > > CONFIG_NET_VENDOR_SEEQ=3Dy
> > > CONFIG_NET_VENDOR_SOLARFLARE=3Dy
> > > # CONFIG_SFC is not set
> > > # CONFIG_SFC_FALCON is not set
> > > CONFIG_NET_VENDOR_SILAN=3Dy
> > > # CONFIG_SC92031 is not set
> > > CONFIG_NET_VENDOR_SIS=3Dy
> > > # CONFIG_SIS900 is not set
> > > # CONFIG_SIS190 is not set
> > > CONFIG_NET_VENDOR_SMSC=3Dy
> > > # CONFIG_EPIC100 is not set
> > > # CONFIG_SMSC911X is not set
> > > # CONFIG_SMSC9420 is not set
> > > CONFIG_NET_VENDOR_SOCIONEXT=3Dy
> > > CONFIG_NET_VENDOR_STMICRO=3Dy
> > > # CONFIG_STMMAC_ETH is not set
> > > CONFIG_NET_VENDOR_SUN=3Dy
> > > # CONFIG_HAPPYMEAL is not set
> > > # CONFIG_SUNGEM is not set
> > > # CONFIG_CASSINI is not set
> > > # CONFIG_NIU is not set
> > > CONFIG_NET_VENDOR_SYNOPSYS=3Dy
> > > # CONFIG_DWC_XLGMAC is not set
> > > CONFIG_NET_VENDOR_TEHUTI=3Dy
> > > # CONFIG_TEHUTI is not set
> > > CONFIG_NET_VENDOR_TI=3Dy
> > > # CONFIG_TI_CPSW_PHY_SEL is not set
> > > # CONFIG_TLAN is not set
> > > CONFIG_NET_VENDOR_VERTEXCOM=3Dy
> > > CONFIG_NET_VENDOR_VIA=3Dy
> > > # CONFIG_VIA_RHINE is not set
> > > # CONFIG_VIA_VELOCITY is not set
> > > CONFIG_NET_VENDOR_WIZNET=3Dy
> > > # CONFIG_WIZNET_W5100 is not set
> > > # CONFIG_WIZNET_W5300 is not set
> > > CONFIG_NET_VENDOR_XILINX=3Dy
> > > # CONFIG_XILINX_EMACLITE is not set
> > > # CONFIG_XILINX_AXI_EMAC is not set
> > > # CONFIG_XILINX_LL_TEMAC is not set
> > > # CONFIG_FDDI is not set
> > > # CONFIG_HIPPI is not set
> > > # CONFIG_PHYLIB is not set
> > > # CONFIG_MDIO_DEVICE is not set
> > >
> > > #
> > > # PCS device drivers
> > > #
> > > # end of PCS device drivers
> > >
> > > # CONFIG_PPP is not set
> > > # CONFIG_SLIP is not set
> > >
> > > #
> > > # Host-side USB support is needed for USB Network Adapter support
> > > #
> > > CONFIG_WLAN=3Dy
> > > CONFIG_WLAN_VENDOR_ADMTEK=3Dy
> > > CONFIG_WLAN_VENDOR_ATH=3Dy
> > > # CONFIG_ATH_DEBUG is not set
> > > # CONFIG_ATH5K_PCI is not set
> > > CONFIG_WLAN_VENDOR_ATMEL=3Dy
> > > CONFIG_WLAN_VENDOR_BROADCOM=3Dy
> > > CONFIG_WLAN_VENDOR_CISCO=3Dy
> > > CONFIG_WLAN_VENDOR_INTEL=3Dy
> > > CONFIG_WLAN_VENDOR_INTERSIL=3Dy
> > > # CONFIG_HOSTAP is not set
> > > CONFIG_WLAN_VENDOR_MARVELL=3Dy
> > > CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
> > > CONFIG_WLAN_VENDOR_MICROCHIP=3Dy
> > > CONFIG_WLAN_VENDOR_RALINK=3Dy
> > > CONFIG_WLAN_VENDOR_REALTEK=3Dy
> > > CONFIG_WLAN_VENDOR_RSI=3Dy
> > > CONFIG_WLAN_VENDOR_ST=3Dy
> > > CONFIG_WLAN_VENDOR_TI=3Dy
> > > CONFIG_WLAN_VENDOR_ZYDAS=3Dy
> > > CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
> > > # CONFIG_WAN is not set
> > >
> > > #
> > > # Wireless WAN
> > > #
> > > # CONFIG_WWAN is not set
> > > # end of Wireless WAN
> > >
> > > # CONFIG_VMXNET3 is not set
> > > # CONFIG_NETDEVSIM is not set
> > > CONFIG_NET_FAILOVER=3Dy
> > > # CONFIG_ISDN is not set
> > >
> > > #
> > > # Input device support
> > > #
> > > CONFIG_INPUT=3Dy
> > > CONFIG_INPUT_FF_MEMLESS=3Dy
> > > # CONFIG_INPUT_SPARSEKMAP is not set
> > > # CONFIG_INPUT_MATRIXKMAP is not set
> > >
> > > #
> > > # Userland interfaces
> > > #
> > > # CONFIG_INPUT_MOUSEDEV is not set
> > > # CONFIG_INPUT_JOYDEV is not set
> > > # CONFIG_INPUT_EVDEV is not set
> > > # CONFIG_INPUT_EVBUG is not set
> > >
> > > #
> > > # Input Device Drivers
> > > #
> > > CONFIG_INPUT_KEYBOARD=3Dy
> > > CONFIG_KEYBOARD_ATKBD=3Dy
> > > # CONFIG_KEYBOARD_LKKBD is not set
> > > # CONFIG_KEYBOARD_NEWTON is not set
> > > # CONFIG_KEYBOARD_OPENCORES is not set
> > > # CONFIG_KEYBOARD_SAMSUNG is not set
> > > # CONFIG_KEYBOARD_STOWAWAY is not set
> > > # CONFIG_KEYBOARD_SUNKBD is not set
> > > # CONFIG_KEYBOARD_XTKBD is not set
> > > CONFIG_INPUT_MOUSE=3Dy
> > > CONFIG_MOUSE_PS2=3Dy
> > > CONFIG_MOUSE_PS2_ALPS=3Dy
> > > CONFIG_MOUSE_PS2_BYD=3Dy
> > > CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> > > CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> > > CONFIG_MOUSE_PS2_CYPRESS=3Dy
> > > CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> > > CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> > > # CONFIG_MOUSE_PS2_ELANTECH is not set
> > > # CONFIG_MOUSE_PS2_SENTELIC is not set
> > > # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> > > CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> > > # CONFIG_MOUSE_PS2_VMMOUSE is not set
> > > # CONFIG_MOUSE_SERIAL is not set
> > > # CONFIG_MOUSE_VSXXXAA is not set
> > > # CONFIG_INPUT_JOYSTICK is not set
> > > # CONFIG_INPUT_TABLET is not set
> > > # CONFIG_INPUT_TOUCHSCREEN is not set
> > > # CONFIG_INPUT_MISC is not set
> > > # CONFIG_RMI4_CORE is not set
> > >
> > > #
> > > # Hardware I/O ports
> > > #
> > > CONFIG_SERIO=3Dy
> > > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> > > CONFIG_SERIO_I8042=3Dy
> > > CONFIG_SERIO_SERPORT=3Dy
> > > # CONFIG_SERIO_CT82C710 is not set
> > > # CONFIG_SERIO_PCIPS2 is not set
> > > CONFIG_SERIO_LIBPS2=3Dy
> > > # CONFIG_SERIO_RAW is not set
> > > # CONFIG_SERIO_ALTERA_PS2 is not set
> > > # CONFIG_SERIO_PS2MULT is not set
> > > # CONFIG_SERIO_ARC_PS2 is not set
> > > # CONFIG_USERIO is not set
> > > # CONFIG_GAMEPORT is not set
> > > # end of Hardware I/O ports
> > > # end of Input device support
> > >
> > > #
> > > # Character devices
> > > #
> > > CONFIG_TTY=3Dy
> > > CONFIG_VT=3Dy
> > > CONFIG_CONSOLE_TRANSLATIONS=3Dy
> > > CONFIG_VT_CONSOLE=3Dy
> > > CONFIG_VT_CONSOLE_SLEEP=3Dy
> > > CONFIG_HW_CONSOLE=3Dy
> > > # CONFIG_VT_HW_CONSOLE_BINDING is not set
> > > CONFIG_UNIX98_PTYS=3Dy
> > > CONFIG_LEGACY_PTYS=3Dy
> > > CONFIG_LEGACY_PTY_COUNT=3D256
> > > CONFIG_LDISC_AUTOLOAD=3Dy
> > >
> > > #
> > > # Serial drivers
> > > #
> > > CONFIG_SERIAL_EARLYCON=3Dy
> > > CONFIG_SERIAL_8250=3Dy
> > > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=3Dy
> > > # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> > > # CONFIG_SERIAL_8250_FINTEK is not set
> > > CONFIG_SERIAL_8250_CONSOLE=3Dy
> > > CONFIG_SERIAL_8250_PCI=3Dy
> > > CONFIG_SERIAL_8250_EXAR=3Dy
> > > CONFIG_SERIAL_8250_NR_UARTS=3D4
> > > CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> > > # CONFIG_SERIAL_8250_EXTENDED is not set
> > > CONFIG_SERIAL_8250_DWLIB=3Dy
> > > # CONFIG_SERIAL_8250_DW is not set
> > > # CONFIG_SERIAL_8250_RT288X is not set
> > > CONFIG_SERIAL_8250_LPSS=3Dy
> > > CONFIG_SERIAL_8250_MID=3Dy
> > > CONFIG_SERIAL_8250_PERICOM=3Dy
> > >
> > > #
> > > # Non-8250 serial port support
> > > #
> > > # CONFIG_SERIAL_KGDB_NMI is not set
> > > # CONFIG_SERIAL_UARTLITE is not set
> > > CONFIG_SERIAL_CORE=3Dy
> > > CONFIG_SERIAL_CORE_CONSOLE=3Dy
> > > CONFIG_CONSOLE_POLL=3Dy
> > > # CONFIG_SERIAL_JSM is not set
> > > # CONFIG_SERIAL_LANTIQ is not set
> > > # CONFIG_SERIAL_SCCNXP is not set
> > > # CONFIG_SERIAL_BCM63XX is not set
> > > # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> > > # CONFIG_SERIAL_ALTERA_UART is not set
> > > # CONFIG_SERIAL_ARC is not set
> > > # CONFIG_SERIAL_RP2 is not set
> > > # CONFIG_SERIAL_FSL_LPUART is not set
> > > # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> > > # CONFIG_SERIAL_SPRD is not set
> > > # end of Serial drivers
> > >
> > > # CONFIG_SERIAL_NONSTANDARD is not set
> > > # CONFIG_N_GSM is not set
> > > # CONFIG_NOZOMI is not set
> > > # CONFIG_NULL_TTY is not set
> > > CONFIG_HVC_DRIVER=3Dy
> > > # CONFIG_SERIAL_DEV_BUS is not set
> > > CONFIG_VIRTIO_CONSOLE=3Dy
> > > # CONFIG_IPMI_HANDLER is not set
> > > CONFIG_HW_RANDOM=3Dy
> > > # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> > > CONFIG_HW_RANDOM_INTEL=3Dy
> > > CONFIG_HW_RANDOM_AMD=3Dy
> > > # CONFIG_HW_RANDOM_BA431 is not set
> > > CONFIG_HW_RANDOM_VIA=3Dy
> > > CONFIG_HW_RANDOM_VIRTIO=3Dy
> > > # CONFIG_HW_RANDOM_XIPHERA is not set
> > > # CONFIG_APPLICOM is not set
> > > # CONFIG_MWAVE is not set
> > > # CONFIG_DEVMEM is not set
> > > # CONFIG_NVRAM is not set
> > > CONFIG_DEVPORT=3Dy
> > > # CONFIG_HANGCHECK_TIMER is not set
> > > # CONFIG_TCG_TPM is not set
> > > # CONFIG_TELCLOCK is not set
> > > # CONFIG_XILLYBUS is not set
> > > # CONFIG_RANDOM_TRUST_CPU is not set
> > > # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> > > # end of Character devices
> > >
> > > #
> > > # I2C support
> > > #
> > > # CONFIG_I2C is not set
> > > # end of I2C support
> > >
> > > # CONFIG_I3C is not set
> > > # CONFIG_SPI is not set
> > > # CONFIG_SPMI is not set
> > > # CONFIG_HSI is not set
> > > # CONFIG_PPS is not set
> > >
> > > #
> > > # PTP clock support
> > > #
> > > # CONFIG_PTP_1588_CLOCK is not set
> > > CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy
> > >
> > > #
> > > # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional cl=
ocks.
> > > #
> > > # end of PTP clock support
> > >
> > > # CONFIG_PINCTRL is not set
> > > # CONFIG_GPIOLIB is not set
> > > # CONFIG_W1 is not set
> > > # CONFIG_POWER_RESET is not set
> > > # CONFIG_POWER_SUPPLY is not set
> > > # CONFIG_HWMON is not set
> > > # CONFIG_THERMAL is not set
> > > # CONFIG_WATCHDOG is not set
> > > CONFIG_SSB_POSSIBLE=3Dy
> > > # CONFIG_SSB is not set
> > > CONFIG_BCMA_POSSIBLE=3Dy
> > > # CONFIG_BCMA is not set
> > >
> > > #
> > > # Multifunction device drivers
> > > #
> > > # CONFIG_MFD_MADERA is not set
> > > # CONFIG_HTC_PASIC3 is not set
> > > # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> > > # CONFIG_LPC_ICH is not set
> > > # CONFIG_LPC_SCH is not set
> > > # CONFIG_MFD_INTEL_LPSS_PCI is not set
> > > # CONFIG_MFD_JANZ_CMODIO is not set
> > > # CONFIG_MFD_KEMPLD is not set
> > > # CONFIG_MFD_MT6397 is not set
> > > # CONFIG_MFD_RDC321X is not set
> > > # CONFIG_MFD_SM501 is not set
> > > # CONFIG_MFD_SYSCON is not set
> > > # CONFIG_MFD_TI_AM335X_TSCADC is not set
> > > # CONFIG_MFD_TQMX86 is not set
> > > # CONFIG_MFD_VX855 is not set
> > > # end of Multifunction device drivers
> > >
> > > # CONFIG_REGULATOR is not set
> > > # CONFIG_RC_CORE is not set
> > >
> > > #
> > > # CEC support
> > > #
> > > # CONFIG_MEDIA_CEC_SUPPORT is not set
> > > # end of CEC support
> > >
> > > # CONFIG_MEDIA_SUPPORT is not set
> > >
> > > #
> > > # Graphics support
> > > #
> > > # CONFIG_AGP is not set
> > > CONFIG_VGA_ARB=3Dy
> > > CONFIG_VGA_ARB_MAX_GPUS=3D16
> > > # CONFIG_DRM is not set
> > >
> > > #
> > > # ARM devices
> > > #
> > > # end of ARM devices
> > >
> > > #
> > > # Frame buffer Devices
> > > #
> > > # CONFIG_FB is not set
> > > # end of Frame buffer Devices
> > >
> > > #
> > > # Backlight & LCD device support
> > > #
> > > # CONFIG_LCD_CLASS_DEVICE is not set
> > > # CONFIG_BACKLIGHT_CLASS_DEVICE is not set
> > > # end of Backlight & LCD device support
> > >
> > > #
> > > # Console display driver support
> > > #
> > > CONFIG_VGA_CONSOLE=3Dy
> > > CONFIG_DUMMY_CONSOLE=3Dy
> > > CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> > > CONFIG_DUMMY_CONSOLE_ROWS=3D25
> > > # end of Console display driver support
> > > # end of Graphics support
> > >
> > > # CONFIG_SOUND is not set
> > >
> > > #
> > > # HID support
> > > #
> > > CONFIG_HID=3Dy
> > > # CONFIG_HID_BATTERY_STRENGTH is not set
> > > # CONFIG_HIDRAW is not set
> > > # CONFIG_UHID is not set
> > > CONFIG_HID_GENERIC=3Dy
> > >
> > > #
> > > # Special HID drivers
> > > #
> > > CONFIG_HID_A4TECH=3Dy
> > > # CONFIG_HID_ACRUX is not set
> > > CONFIG_HID_APPLE=3Dy
> > > # CONFIG_HID_AUREAL is not set
> > > CONFIG_HID_BELKIN=3Dy
> > > CONFIG_HID_CHERRY=3Dy
> > > # CONFIG_HID_COUGAR is not set
> > > # CONFIG_HID_MACALLY is not set
> > > # CONFIG_HID_CMEDIA is not set
> > > CONFIG_HID_CYPRESS=3Dy
> > > # CONFIG_HID_DRAGONRISE is not set
> > > # CONFIG_HID_EMS_FF is not set
> > > # CONFIG_HID_ELECOM is not set
> > > CONFIG_HID_EZKEY=3Dy
> > > # CONFIG_HID_GEMBIRD is not set
> > > # CONFIG_HID_GFRM is not set
> > > # CONFIG_HID_GLORIOUS is not set
> > > # CONFIG_HID_VIVALDI is not set
> > > # CONFIG_HID_KEYTOUCH is not set
> > > # CONFIG_HID_KYE is not set
> > > # CONFIG_HID_WALTOP is not set
> > > # CONFIG_HID_VIEWSONIC is not set
> > > # CONFIG_HID_XIAOMI is not set
> > > # CONFIG_HID_GYRATION is not set
> > > # CONFIG_HID_ICADE is not set
> > > CONFIG_HID_ITE=3Dy
> > > # CONFIG_HID_JABRA is not set
> > > # CONFIG_HID_TWINHAN is not set
> > > CONFIG_HID_KENSINGTON=3Dy
> > > # CONFIG_HID_LCPOWER is not set
> > > # CONFIG_HID_LENOVO is not set
> > > # CONFIG_HID_MAGICMOUSE is not set
> > > # CONFIG_HID_MALTRON is not set
> > > # CONFIG_HID_MAYFLASH is not set
> > > CONFIG_HID_REDRAGON=3Dy
> > > CONFIG_HID_MICROSOFT=3Dy
> > > CONFIG_HID_MONTEREY=3Dy
> > > # CONFIG_HID_MULTITOUCH is not set
> > > # CONFIG_HID_NTI is not set
> > > # CONFIG_HID_ORTEK is not set
> > > # CONFIG_HID_PANTHERLORD is not set
> > > # CONFIG_HID_PETALYNX is not set
> > > # CONFIG_HID_PICOLCD is not set
> > > # CONFIG_HID_PLANTRONICS is not set
> > > # CONFIG_HID_PRIMAX is not set
> > > # CONFIG_HID_SAITEK is not set
> > > # CONFIG_HID_SEMITEK is not set
> > > # CONFIG_HID_SPEEDLINK is not set
> > > # CONFIG_HID_STEAM is not set
> > > # CONFIG_HID_STEELSERIES is not set
> > > # CONFIG_HID_SUNPLUS is not set
> > > # CONFIG_HID_RMI is not set
> > > # CONFIG_HID_GREENASIA is not set
> > > # CONFIG_HID_SMARTJOYPLUS is not set
> > > # CONFIG_HID_TIVO is not set
> > > # CONFIG_HID_TOPSEED is not set
> > > # CONFIG_HID_UDRAW_PS3 is not set
> > > # CONFIG_HID_XINMO is not set
> > > # CONFIG_HID_ZEROPLUS is not set
> > > # CONFIG_HID_ZYDACRON is not set
> > > # CONFIG_HID_SENSOR_HUB is not set
> > > # CONFIG_HID_ALPS is not set
> > > # end of Special HID drivers
> > >
> > > #
> > > # Intel ISH HID support
> > > #
> > > # CONFIG_INTEL_ISH_HID is not set
> > > # end of Intel ISH HID support
> > >
> > > #
> > > # AMD SFH HID Support
> > > #
> > > # CONFIG_AMD_SFH_HID is not set
> > > # end of AMD SFH HID Support
> > > # end of HID support
> > >
> > > CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> > > # CONFIG_USB_SUPPORT is not set
> > > # CONFIG_MMC is not set
> > > # CONFIG_MEMSTICK is not set
> > > # CONFIG_NEW_LEDS is not set
> > > # CONFIG_ACCESSIBILITY is not set
> > > # CONFIG_INFINIBAND is not set
> > > CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> > > CONFIG_EDAC_SUPPORT=3Dy
> > > CONFIG_RTC_LIB=3Dy
> > > CONFIG_RTC_MC146818_LIB=3Dy
> > > CONFIG_RTC_CLASS=3Dy
> > > CONFIG_RTC_HCTOSYS=3Dy
> > > CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> > > CONFIG_RTC_SYSTOHC=3Dy
> > > CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
> > > # CONFIG_RTC_DEBUG is not set
> > > CONFIG_RTC_NVMEM=3Dy
> > >
> > > #
> > > # RTC interfaces
> > > #
> > > CONFIG_RTC_INTF_SYSFS=3Dy
> > > CONFIG_RTC_INTF_PROC=3Dy
> > > CONFIG_RTC_INTF_DEV=3Dy
> > > # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> > > # CONFIG_RTC_DRV_TEST is not set
> > >
> > > #
> > > # I2C RTC drivers
> > > #
> > >
> > > #
> > > # SPI RTC drivers
> > > #
> > >
> > > #
> > > # SPI and I2C RTC drivers
> > > #
> > >
> > > #
> > > # Platform RTC drivers
> > > #
> > > CONFIG_RTC_DRV_CMOS=3Dy
> > > # CONFIG_RTC_DRV_DS1286 is not set
> > > # CONFIG_RTC_DRV_DS1511 is not set
> > > # CONFIG_RTC_DRV_DS1553 is not set
> > > # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> > > # CONFIG_RTC_DRV_DS1742 is not set
> > > # CONFIG_RTC_DRV_DS2404 is not set
> > > # CONFIG_RTC_DRV_STK17TA8 is not set
> > > # CONFIG_RTC_DRV_M48T86 is not set
> > > # CONFIG_RTC_DRV_M48T35 is not set
> > > # CONFIG_RTC_DRV_M48T59 is not set
> > > # CONFIG_RTC_DRV_MSM6242 is not set
> > > # CONFIG_RTC_DRV_BQ4802 is not set
> > > # CONFIG_RTC_DRV_RP5C01 is not set
> > > # CONFIG_RTC_DRV_V3020 is not set
> > >
> > > #
> > > # on-CPU RTC drivers
> > > #
> > > # CONFIG_RTC_DRV_FTRTC010 is not set
> > >
> > > #
> > > # HID Sensor RTC drivers
> > > #
> > > # CONFIG_RTC_DRV_GOLDFISH is not set
> > > # CONFIG_DMADEVICES is not set
> > >
> > > #
> > > # DMABUF options
> > > #
> > > # CONFIG_SYNC_FILE is not set
> > > # CONFIG_DMABUF_HEAPS is not set
> > > # end of DMABUF options
> > >
> > > # CONFIG_AUXDISPLAY is not set
> > > # CONFIG_UIO is not set
> > > # CONFIG_VFIO is not set
> > > # CONFIG_VIRT_DRIVERS is not set
> > > CONFIG_VIRTIO=3Dy
> > > CONFIG_VIRTIO_PCI_LIB=3Dy
> > > CONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy
> > > CONFIG_VIRTIO_MENU=3Dy
> > > CONFIG_VIRTIO_PCI=3Dy
> > > CONFIG_VIRTIO_PCI_LEGACY=3Dy
> > > # CONFIG_VIRTIO_BALLOON is not set
> > > # CONFIG_VIRTIO_INPUT is not set
> > > # CONFIG_VIRTIO_MMIO is not set
> > > # CONFIG_VDPA is not set
> > > CONFIG_VHOST_MENU=3Dy
> > > # CONFIG_VHOST_NET is not set
> > > # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> > >
> > > #
> > > # Microsoft Hyper-V guest support
> > > #
> > > # end of Microsoft Hyper-V guest support
> > >
> > > # CONFIG_GREYBUS is not set
> > > # CONFIG_COMEDI is not set
> > > # CONFIG_STAGING is not set
> > > # CONFIG_X86_PLATFORM_DEVICES is not set
> > > CONFIG_PMC_ATOM=3Dy
> > > # CONFIG_CHROME_PLATFORMS is not set
> > > # CONFIG_MELLANOX_PLATFORM is not set
> > > CONFIG_SURFACE_PLATFORMS=3Dy
> > > CONFIG_HAVE_CLK=3Dy
> > > CONFIG_HAVE_CLK_PREPARE=3Dy
> > > CONFIG_COMMON_CLK=3Dy
> > > # CONFIG_COMMON_CLK_LAN966X is not set
> > > # CONFIG_XILINX_VCU is not set
> > > # CONFIG_HWSPINLOCK is not set
> > >
> > > #
> > > # Clock Source drivers
> > > #
> > > CONFIG_CLKEVT_I8253=3Dy
> > > CONFIG_I8253_LOCK=3Dy
> > > CONFIG_CLKBLD_I8253=3Dy
> > > # end of Clock Source drivers
> > >
> > > # CONFIG_MAILBOX is not set
> > > # CONFIG_IOMMU_SUPPORT is not set
> > >
> > > #
> > > # Remoteproc drivers
> > > #
> > > # CONFIG_REMOTEPROC is not set
> > > # end of Remoteproc drivers
> > >
> > > #
> > > # Rpmsg drivers
> > > #
> > > # CONFIG_RPMSG_VIRTIO is not set
> > > # end of Rpmsg drivers
> > >
> > > #
> > > # SOC (System On Chip) specific Drivers
> > > #
> > >
> > > #
> > > # Amlogic SoC drivers
> > > #
> > > # end of Amlogic SoC drivers
> > >
> > > #
> > > # Broadcom SoC drivers
> > > #
> > > # end of Broadcom SoC drivers
> > >
> > > #
> > > # NXP/Freescale QorIQ SoC drivers
> > > #
> > > # end of NXP/Freescale QorIQ SoC drivers
> > >
> > > #
> > > # i.MX SoC drivers
> > > #
> > > # end of i.MX SoC drivers
> > >
> > > #
> > > # Enable LiteX SoC Builder specific drivers
> > > #
> > > # end of Enable LiteX SoC Builder specific drivers
> > >
> > > #
> > > # Qualcomm SoC drivers
> > > #
> > > # end of Qualcomm SoC drivers
> > >
> > > # CONFIG_SOC_TI is not set
> > >
> > > #
> > > # Xilinx SoC drivers
> > > #
> > > # end of Xilinx SoC drivers
> > > # end of SOC (System On Chip) specific Drivers
> > >
> > > # CONFIG_PM_DEVFREQ is not set
> > > # CONFIG_EXTCON is not set
> > > # CONFIG_MEMORY is not set
> > > # CONFIG_IIO is not set
> > > # CONFIG_NTB is not set
> > > # CONFIG_VME_BUS is not set
> > > # CONFIG_PWM is not set
> > >
> > > #
> > > # IRQ chip support
> > > #
> > > # end of IRQ chip support
> > >
> > > # CONFIG_IPACK_BUS is not set
> > > # CONFIG_RESET_CONTROLLER is not set
> > >
> > > #
> > > # PHY Subsystem
> > > #
> > > # CONFIG_GENERIC_PHY is not set
> > > # CONFIG_PHY_CAN_TRANSCEIVER is not set
> > >
> > > #
> > > # PHY drivers for Broadcom platforms
> > > #
> > > # CONFIG_BCM_KONA_USB2_PHY is not set
> > > # end of PHY drivers for Broadcom platforms
> > >
> > > # CONFIG_PHY_PXA_28NM_HSIC is not set
> > > # CONFIG_PHY_PXA_28NM_USB2 is not set
> > > # CONFIG_PHY_INTEL_LGM_EMMC is not set
> > > # end of PHY Subsystem
> > >
> > > # CONFIG_POWERCAP is not set
> > > # CONFIG_MCB is not set
> > >
> > > #
> > > # Performance monitor support
> > > #
> > > # end of Performance monitor support
> > >
> > > # CONFIG_RAS is not set
> > > # CONFIG_USB4 is not set
> > >
> > > #
> > > # Android
> > > #
> > > # CONFIG_ANDROID is not set
> > > # end of Android
> > >
> > > # CONFIG_LIBNVDIMM is not set
> > > # CONFIG_DAX is not set
> > > CONFIG_NVMEM=3Dy
> > > CONFIG_NVMEM_SYSFS=3Dy
> > > # CONFIG_NVMEM_RMEM is not set
> > >
> > > #
> > > # HW tracing support
> > > #
> > > # CONFIG_STM is not set
> > > # CONFIG_INTEL_TH is not set
> > > # end of HW tracing support
> > >
> > > # CONFIG_FPGA is not set
> > > # CONFIG_TEE is not set
> > > # CONFIG_SIOX is not set
> > > # CONFIG_SLIMBUS is not set
> > > # CONFIG_INTERCONNECT is not set
> > > # CONFIG_COUNTER is not set
> > > # CONFIG_MOST is not set
> > > # end of Device Drivers
> > >
> > > #
> > > # File systems
> > > #
> > > CONFIG_DCACHE_WORD_ACCESS=3Dy
> > > # CONFIG_VALIDATE_FS_PARSER is not set
> > > CONFIG_FS_IOMAP=3Dy
> > > # CONFIG_EXT2_FS is not set
> > > # CONFIG_EXT3_FS is not set
> > > CONFIG_EXT4_FS=3Dy
> > > CONFIG_EXT4_USE_FOR_EXT2=3Dy
> > > CONFIG_EXT4_FS_POSIX_ACL=3Dy
> > > # CONFIG_EXT4_FS_SECURITY is not set
> > > # CONFIG_EXT4_DEBUG is not set
> > > CONFIG_JBD2=3Dy
> > > # CONFIG_JBD2_DEBUG is not set
> > > CONFIG_FS_MBCACHE=3Dy
> > > # CONFIG_REISERFS_FS is not set
> > > CONFIG_JFS_FS=3Dy
> > > CONFIG_JFS_POSIX_ACL=3Dy
> > > # CONFIG_JFS_SECURITY is not set
> > > # CONFIG_JFS_DEBUG is not set
> > > # CONFIG_JFS_STATISTICS is not set
> > > CONFIG_XFS_FS=3Dy
> > > CONFIG_XFS_SUPPORT_V4=3Dy
> > > CONFIG_XFS_QUOTA=3Dy
> > > CONFIG_XFS_POSIX_ACL=3Dy
> > > CONFIG_XFS_RT=3Dy
> > > CONFIG_XFS_ONLINE_SCRUB=3Dy
> > > CONFIG_XFS_ONLINE_REPAIR=3Dy
> > > # CONFIG_XFS_WARN is not set
> > > # CONFIG_XFS_DEBUG is not set
> > > CONFIG_GFS2_FS=3Dm
> > > # CONFIG_OCFS2_FS is not set
> > > # CONFIG_BTRFS_FS is not set
> > > # CONFIG_NILFS2_FS is not set
> > > # CONFIG_F2FS_FS is not set
> > > CONFIG_ZONEFS_FS=3Dm
> > > # CONFIG_FS_DAX is not set
> > > CONFIG_FS_POSIX_ACL=3Dy
> > > CONFIG_EXPORTFS=3Dy
> > > # CONFIG_EXPORTFS_BLOCK_OPS is not set
> > > CONFIG_FILE_LOCKING=3Dy
> > > # CONFIG_FS_ENCRYPTION is not set
> > > # CONFIG_FS_VERITY is not set
> > > CONFIG_FSNOTIFY=3Dy
> > > # CONFIG_DNOTIFY is not set
> > > CONFIG_INOTIFY_USER=3Dy
> > > # CONFIG_FANOTIFY is not set
> > > CONFIG_QUOTA=3Dy
> > > # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> > > CONFIG_PRINT_QUOTA_WARNING=3Dy
> > > # CONFIG_QUOTA_DEBUG is not set
> > > # CONFIG_QFMT_V1 is not set
> > > # CONFIG_QFMT_V2 is not set
> > > CONFIG_QUOTACTL=3Dy
> > > # CONFIG_AUTOFS4_FS is not set
> > > # CONFIG_AUTOFS_FS is not set
> > > # CONFIG_FUSE_FS is not set
> > > # CONFIG_OVERLAY_FS is not set
> > >
> > > #
> > > # Caches
> > > #
> > > CONFIG_NETFS_SUPPORT=3Dy
> > > # CONFIG_NETFS_STATS is not set
> > > # CONFIG_FSCACHE is not set
> > > # end of Caches
> > >
> > > #
> > > # CD-ROM/DVD Filesystems
> > > #
> > > # CONFIG_ISO9660_FS is not set
> > > # CONFIG_UDF_FS is not set
> > > # end of CD-ROM/DVD Filesystems
> > >
> > > #
> > > # DOS/FAT/EXFAT/NT Filesystems
> > > #
> > > # CONFIG_MSDOS_FS is not set
> > > # CONFIG_VFAT_FS is not set
> > > # CONFIG_EXFAT_FS is not set
> > > # CONFIG_NTFS_FS is not set
> > > # CONFIG_NTFS3_FS is not set
> > > # end of DOS/FAT/EXFAT/NT Filesystems
> > >
> > > #
> > > # Pseudo filesystems
> > > #
> > > CONFIG_PROC_FS=3Dy
> > > CONFIG_PROC_KCORE=3Dy
> > > CONFIG_PROC_VMCORE=3Dy
> > > # CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
> > > CONFIG_PROC_SYSCTL=3Dy
> > > CONFIG_PROC_PAGE_MONITOR=3Dy
> > > # CONFIG_PROC_CHILDREN is not set
> > > CONFIG_PROC_PID_ARCH_STATUS=3Dy
> > > CONFIG_KERNFS=3Dy
> > > CONFIG_SYSFS=3Dy
> > > CONFIG_TMPFS=3Dy
> > > # CONFIG_TMPFS_POSIX_ACL is not set
> > > # CONFIG_TMPFS_XATTR is not set
> > > # CONFIG_TMPFS_INODE64 is not set
> > > # CONFIG_HUGETLBFS is not set
> > > CONFIG_MEMFD_CREATE=3Dy
> > > CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> > > CONFIG_CONFIGFS_FS=3Dy
> > > # end of Pseudo filesystems
> > >
> > > CONFIG_MISC_FILESYSTEMS=3Dy
> > > # CONFIG_ORANGEFS_FS is not set
> > > # CONFIG_ADFS_FS is not set
> > > # CONFIG_AFFS_FS is not set
> > > # CONFIG_HFS_FS is not set
> > > # CONFIG_HFSPLUS_FS is not set
> > > # CONFIG_BEFS_FS is not set
> > > # CONFIG_BFS_FS is not set
> > > # CONFIG_EFS_FS is not set
> > > # CONFIG_CRAMFS is not set
> > > # CONFIG_SQUASHFS is not set
> > > # CONFIG_VXFS_FS is not set
> > > # CONFIG_MINIX_FS is not set
> > > # CONFIG_OMFS_FS is not set
> > > # CONFIG_HPFS_FS is not set
> > > # CONFIG_QNX4FS_FS is not set
> > > # CONFIG_QNX6FS_FS is not set
> > > # CONFIG_ROMFS_FS is not set
> > > # CONFIG_PSTORE is not set
> > > # CONFIG_SYSV_FS is not set
> > > # CONFIG_UFS_FS is not set
> > > # CONFIG_EROFS_FS is not set
> > > CONFIG_NETWORK_FILESYSTEMS=3Dy
> > > # CONFIG_NFS_FS is not set
> > > # CONFIG_NFSD is not set
> > > # CONFIG_CEPH_FS is not set
> > > # CONFIG_CIFS is not set
> > > # CONFIG_SMB_SERVER is not set
> > > # CONFIG_CODA_FS is not set
> > > # CONFIG_AFS_FS is not set
> > > CONFIG_9P_FS=3Dy
> > > # CONFIG_9P_FS_POSIX_ACL is not set
> > > # CONFIG_9P_FS_SECURITY is not set
> > > CONFIG_NLS=3Dy
> > > CONFIG_NLS_DEFAULT=3D"iso8859-1"
> > > # CONFIG_NLS_CODEPAGE_437 is not set
> > > # CONFIG_NLS_CODEPAGE_737 is not set
> > > # CONFIG_NLS_CODEPAGE_775 is not set
> > > # CONFIG_NLS_CODEPAGE_850 is not set
> > > # CONFIG_NLS_CODEPAGE_852 is not set
> > > # CONFIG_NLS_CODEPAGE_855 is not set
> > > # CONFIG_NLS_CODEPAGE_857 is not set
> > > # CONFIG_NLS_CODEPAGE_860 is not set
> > > # CONFIG_NLS_CODEPAGE_861 is not set
> > > # CONFIG_NLS_CODEPAGE_862 is not set
> > > # CONFIG_NLS_CODEPAGE_863 is not set
> > > # CONFIG_NLS_CODEPAGE_864 is not set
> > > # CONFIG_NLS_CODEPAGE_865 is not set
> > > # CONFIG_NLS_CODEPAGE_866 is not set
> > > # CONFIG_NLS_CODEPAGE_869 is not set
> > > # CONFIG_NLS_CODEPAGE_936 is not set
> > > # CONFIG_NLS_CODEPAGE_950 is not set
> > > # CONFIG_NLS_CODEPAGE_932 is not set
> > > # CONFIG_NLS_CODEPAGE_949 is not set
> > > # CONFIG_NLS_CODEPAGE_874 is not set
> > > # CONFIG_NLS_ISO8859_8 is not set
> > > # CONFIG_NLS_CODEPAGE_1250 is not set
> > > # CONFIG_NLS_CODEPAGE_1251 is not set
> > > # CONFIG_NLS_ASCII is not set
> > > # CONFIG_NLS_ISO8859_1 is not set
> > > # CONFIG_NLS_ISO8859_2 is not set
> > > # CONFIG_NLS_ISO8859_3 is not set
> > > # CONFIG_NLS_ISO8859_4 is not set
> > > # CONFIG_NLS_ISO8859_5 is not set
> > > # CONFIG_NLS_ISO8859_6 is not set
> > > # CONFIG_NLS_ISO8859_7 is not set
> > > # CONFIG_NLS_ISO8859_9 is not set
> > > # CONFIG_NLS_ISO8859_13 is not set
> > > # CONFIG_NLS_ISO8859_14 is not set
> > > # CONFIG_NLS_ISO8859_15 is not set
> > > # CONFIG_NLS_KOI8_R is not set
> > > # CONFIG_NLS_KOI8_U is not set
> > > # CONFIG_NLS_MAC_ROMAN is not set
> > > # CONFIG_NLS_MAC_CELTIC is not set
> > > # CONFIG_NLS_MAC_CENTEURO is not set
> > > # CONFIG_NLS_MAC_CROATIAN is not set
> > > # CONFIG_NLS_MAC_CYRILLIC is not set
> > > # CONFIG_NLS_MAC_GAELIC is not set
> > > # CONFIG_NLS_MAC_GREEK is not set
> > > # CONFIG_NLS_MAC_ICELAND is not set
> > > # CONFIG_NLS_MAC_INUIT is not set
> > > # CONFIG_NLS_MAC_ROMANIAN is not set
> > > # CONFIG_NLS_MAC_TURKISH is not set
> > > # CONFIG_NLS_UTF8 is not set
> > > # CONFIG_DLM is not set
> > > # CONFIG_UNICODE is not set
> > > CONFIG_IO_WQ=3Dy
> > > # end of File systems
> > >
> > > #
> > > # Security options
> > > #
> > > # CONFIG_KEYS is not set
> > > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > > # CONFIG_SECURITY is not set
> > > # CONFIG_SECURITYFS is not set
> > > CONFIG_PAGE_TABLE_ISOLATION=3Dy
> > > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> > > # CONFIG_HARDENED_USERCOPY is not set
> > > # CONFIG_FORTIFY_SOURCE is not set
> > > # CONFIG_STATIC_USERMODEHELPER is not set
> > > CONFIG_DEFAULT_SECURITY_DAC=3Dy
> > > CONFIG_LSM=3D"lockdown,yama,loadpin,safesetid,integrity"
> > >
> > > #
> > > # Kernel hardening options
> > > #
> > >
> > > #
> > > # Memory initialization
> > > #
> > > CONFIG_INIT_STACK_NONE=3Dy
> > > # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> > > # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> > > CONFIG_CC_HAS_ZERO_CALL_USED_REGS=3Dy
> > > # CONFIG_ZERO_CALL_USED_REGS is not set
> > > # end of Memory initialization
> > > # end of Kernel hardening options
> > > # end of Security options
> > >
> > > CONFIG_CRYPTO=3Dy
> > >
> > > #
> > > # Crypto core or helper
> > > #
> > > CONFIG_CRYPTO_ALGAPI=3Dy
> > > CONFIG_CRYPTO_ALGAPI2=3Dy
> > > CONFIG_CRYPTO_AEAD=3Dm
> > > CONFIG_CRYPTO_AEAD2=3Dm
> > > CONFIG_CRYPTO_SKCIPHER=3Dm
> > > CONFIG_CRYPTO_SKCIPHER2=3Dm
> > > CONFIG_CRYPTO_HASH=3Dy
> > > CONFIG_CRYPTO_HASH2=3Dy
> > > CONFIG_CRYPTO_RNG2=3Dm
> > > # CONFIG_CRYPTO_MANAGER is not set
> > > # CONFIG_CRYPTO_USER is not set
> > > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> > > # CONFIG_CRYPTO_NULL is not set
> > > CONFIG_CRYPTO_NULL2=3Dm
> > > # CONFIG_CRYPTO_PCRYPT is not set
> > > # CONFIG_CRYPTO_CRYPTD is not set
> > > # CONFIG_CRYPTO_AUTHENC is not set
> > > # CONFIG_CRYPTO_TEST is not set
> > > CONFIG_CRYPTO_ENGINE=3Dm
> > >
> > > #
> > > # Public-key cryptography
> > > #
> > > # CONFIG_CRYPTO_RSA is not set
> > > # CONFIG_CRYPTO_DH is not set
> > > # CONFIG_CRYPTO_ECDH is not set
> > > # CONFIG_CRYPTO_ECDSA is not set
> > > # CONFIG_CRYPTO_ECRDSA is not set
> > > # CONFIG_CRYPTO_SM2 is not set
> > > # CONFIG_CRYPTO_CURVE25519 is not set
> > > # CONFIG_CRYPTO_CURVE25519_X86 is not set
> > >
> > > #
> > > # Authenticated Encryption with Associated Data
> > > #
> > > # CONFIG_CRYPTO_CCM is not set
> > > # CONFIG_CRYPTO_GCM is not set
> > > # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> > > # CONFIG_CRYPTO_AEGIS128 is not set
> > > # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> > > # CONFIG_CRYPTO_SEQIV is not set
> > > # CONFIG_CRYPTO_ECHAINIV is not set
> > >
> > > #
> > > # Block modes
> > > #
> > > # CONFIG_CRYPTO_CBC is not set
> > > # CONFIG_CRYPTO_CFB is not set
> > > # CONFIG_CRYPTO_CTR is not set
> > > # CONFIG_CRYPTO_CTS is not set
> > > # CONFIG_CRYPTO_ECB is not set
> > > # CONFIG_CRYPTO_LRW is not set
> > > # CONFIG_CRYPTO_OFB is not set
> > > # CONFIG_CRYPTO_PCBC is not set
> > > # CONFIG_CRYPTO_XTS is not set
> > > # CONFIG_CRYPTO_KEYWRAP is not set
> > > # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> > > # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> > > # CONFIG_CRYPTO_ADIANTUM is not set
> > > # CONFIG_CRYPTO_ESSIV is not set
> > >
> > > #
> > > # Hash modes
> > > #
> > > # CONFIG_CRYPTO_CMAC is not set
> > > # CONFIG_CRYPTO_HMAC is not set
> > > # CONFIG_CRYPTO_XCBC is not set
> > > # CONFIG_CRYPTO_VMAC is not set
> > >
> > > #
> > > # Digest
> > > #
> > > CONFIG_CRYPTO_CRC32C=3Dy
> > > # CONFIG_CRYPTO_CRC32C_INTEL is not set
> > > # CONFIG_CRYPTO_CRC32 is not set
> > > # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> > > # CONFIG_CRYPTO_XXHASH is not set
> > > # CONFIG_CRYPTO_BLAKE2B is not set
> > > # CONFIG_CRYPTO_BLAKE2S is not set
> > > # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> > > CONFIG_CRYPTO_CRCT10DIF=3Dm
> > > # CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
> > > # CONFIG_CRYPTO_GHASH is not set
> > > # CONFIG_CRYPTO_POLY1305 is not set
> > > # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> > > # CONFIG_CRYPTO_MD4 is not set
> > > # CONFIG_CRYPTO_MD5 is not set
> > > # CONFIG_CRYPTO_MICHAEL_MIC is not set
> > > # CONFIG_CRYPTO_RMD160 is not set
> > > # CONFIG_CRYPTO_SHA1 is not set
> > > # CONFIG_CRYPTO_SHA1_SSSE3 is not set
> > > # CONFIG_CRYPTO_SHA256_SSSE3 is not set
> > > # CONFIG_CRYPTO_SHA512_SSSE3 is not set
> > > # CONFIG_CRYPTO_SHA256 is not set
> > > # CONFIG_CRYPTO_SHA512 is not set
> > > # CONFIG_CRYPTO_SHA3 is not set
> > > # CONFIG_CRYPTO_SM3 is not set
> > > # CONFIG_CRYPTO_STREEBOG is not set
> > > # CONFIG_CRYPTO_WP512 is not set
> > > # CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
> > >
> > > #
> > > # Ciphers
> > > #
> > > # CONFIG_CRYPTO_AES is not set
> > > # CONFIG_CRYPTO_AES_TI is not set
> > > # CONFIG_CRYPTO_AES_NI_INTEL is not set
> > > # CONFIG_CRYPTO_BLOWFISH is not set
> > > # CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
> > > # CONFIG_CRYPTO_CAMELLIA is not set
> > > # CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
> > > # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
> > > # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
> > > # CONFIG_CRYPTO_CAST5 is not set
> > > # CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
> > > # CONFIG_CRYPTO_CAST6 is not set
> > > # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> > > # CONFIG_CRYPTO_DES is not set
> > > # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> > > # CONFIG_CRYPTO_FCRYPT is not set
> > > # CONFIG_CRYPTO_CHACHA20 is not set
> > > # CONFIG_CRYPTO_CHACHA20_X86_64 is not set
> > > # CONFIG_CRYPTO_SERPENT is not set
> > > # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
> > > # CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
> > > # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
> > > # CONFIG_CRYPTO_SM4 is not set
> > > # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> > > # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> > > # CONFIG_CRYPTO_TWOFISH is not set
> > > # CONFIG_CRYPTO_TWOFISH_X86_64 is not set
> > > # CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
> > > # CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
> > >
> > > #
> > > # Compression
> > > #
> > > # CONFIG_CRYPTO_DEFLATE is not set
> > > # CONFIG_CRYPTO_LZO is not set
> > > # CONFIG_CRYPTO_842 is not set
> > > # CONFIG_CRYPTO_LZ4 is not set
> > > # CONFIG_CRYPTO_LZ4HC is not set
> > > # CONFIG_CRYPTO_ZSTD is not set
> > >
> > > #
> > > # Random Number Generation
> > > #
> > > # CONFIG_CRYPTO_ANSI_CPRNG is not set
> > > # CONFIG_CRYPTO_DRBG_MENU is not set
> > > # CONFIG_CRYPTO_JITTERENTROPY is not set
> > > # CONFIG_CRYPTO_USER_API_HASH is not set
> > > # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> > > # CONFIG_CRYPTO_USER_API_RNG is not set
> > > # CONFIG_CRYPTO_USER_API_AEAD is not set
> > > CONFIG_CRYPTO_HW=3Dy
> > > # CONFIG_CRYPTO_DEV_PADLOCK is not set
> > > # CONFIG_CRYPTO_DEV_CCP is not set
> > > # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> > > # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> > > # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> > > # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> > > # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> > > # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> > > # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> > > CONFIG_CRYPTO_DEV_VIRTIO=3Dm
> > > # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> > > # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> > >
> > > #
> > > # Certificates for signature checking
> > > #
> > > # end of Certificates for signature checking
> > >
> > > CONFIG_BINARY_PRINTF=3Dy
> > >
> > > #
> > > # Library routines
> > > #
> > > # CONFIG_PACKING is not set
> > > CONFIG_BITREVERSE=3Dy
> > > CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> > > CONFIG_GENERIC_STRNLEN_USER=3Dy
> > > CONFIG_GENERIC_NET_UTILS=3Dy
> > > # CONFIG_CORDIC is not set
> > > # CONFIG_PRIME_NUMBERS is not set
> > > CONFIG_RATIONAL=3Dy
> > > CONFIG_GENERIC_PCI_IOMAP=3Dy
> > > CONFIG_GENERIC_IOMAP=3Dy
> > > CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> > > CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> > > CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy
> > >
> > > #
> > > # Crypto library routines
> > > #
> > > CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dy
> > > # CONFIG_CRYPTO_LIB_CHACHA is not set
> > > # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> > > CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11
> > > # CONFIG_CRYPTO_LIB_POLY1305 is not set
> > > # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> > > # end of Crypto library routines
> > >
> > > # CONFIG_CRC_CCITT is not set
> > > CONFIG_CRC16=3Dy
> > > CONFIG_CRC_T10DIF=3Dm
> > > # CONFIG_CRC_ITU_T is not set
> > > CONFIG_CRC32=3Dy
> > > # CONFIG_CRC32_SELFTEST is not set
> > > CONFIG_CRC32_SLICEBY8=3Dy
> > > # CONFIG_CRC32_SLICEBY4 is not set
> > > # CONFIG_CRC32_SARWATE is not set
> > > # CONFIG_CRC32_BIT is not set
> > > # CONFIG_CRC64 is not set
> > > # CONFIG_CRC4 is not set
> > > # CONFIG_CRC7 is not set
> > > CONFIG_LIBCRC32C=3Dy
> > > # CONFIG_CRC8 is not set
> > > # CONFIG_RANDOM32_SELFTEST is not set
> > > # CONFIG_XZ_DEC is not set
> > > CONFIG_HAS_IOMEM=3Dy
> > > CONFIG_HAS_IOPORT_MAP=3Dy
> > > CONFIG_HAS_DMA=3Dy
> > > CONFIG_NEED_SG_DMA_LENGTH=3Dy
> > > CONFIG_NEED_DMA_MAP_STATE=3Dy
> > > CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> > > CONFIG_SWIOTLB=3Dy
> > > # CONFIG_DMA_API_DEBUG is not set
> > > # CONFIG_DMA_MAP_BENCHMARK is not set
> > > CONFIG_CPU_RMAP=3Dy
> > > CONFIG_DQL=3Dy
> > > CONFIG_GLOB=3Dy
> > > # CONFIG_GLOB_SELFTEST is not set
> > > CONFIG_NLATTR=3Dy
> > > # CONFIG_IRQ_POLL is not set
> > > CONFIG_HAVE_GENERIC_VDSO=3Dy
> > > CONFIG_GENERIC_GETTIMEOFDAY=3Dy
> > > CONFIG_GENERIC_VDSO_TIME_NS=3Dy
> > > CONFIG_SG_POOL=3Dy
> > > CONFIG_ARCH_HAS_PMEM_API=3Dy
> > > CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
> > > CONFIG_ARCH_HAS_COPY_MC=3Dy
> > > CONFIG_ARCH_STACKWALK=3Dy
> > > CONFIG_SBITMAP=3Dy
> > > # end of Library routines
> > >
> > > #
> > > # Kernel hacking
> > > #
> > >
> > > #
> > > # printk and dmesg options
> > > #
> > > # CONFIG_PRINTK_TIME is not set
> > > # CONFIG_PRINTK_CALLER is not set
> > > # CONFIG_STACKTRACE_BUILD_ID is not set
> > > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> > > CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> > > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> > > # CONFIG_BOOT_PRINTK_DELAY is not set
> > > # CONFIG_DYNAMIC_DEBUG is not set
> > > # CONFIG_DYNAMIC_DEBUG_CORE is not set
> > > # CONFIG_SYMBOLIC_ERRNAME is not set
> > > CONFIG_DEBUG_BUGVERBOSE=3Dy
> > > # end of printk and dmesg options
> > >
> > > #
> > > # Compile-time checks and compiler options
> > > #
> > > CONFIG_DEBUG_INFO=3Dy
> > > # CONFIG_DEBUG_INFO_REDUCED is not set
> > > # CONFIG_DEBUG_INFO_COMPRESSED is not set
> > > # CONFIG_DEBUG_INFO_SPLIT is not set
> > > # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> > > CONFIG_DEBUG_INFO_DWARF4=3Dy
> > > # CONFIG_DEBUG_INFO_DWARF5 is not set
> > > CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
> > > CONFIG_GDB_SCRIPTS=3Dy
> > > CONFIG_FRAME_WARN=3D2048
> > > # CONFIG_STRIP_ASM_SYMS is not set
> > > # CONFIG_READABLE_ASM is not set
> > > # CONFIG_HEADERS_INSTALL is not set
> > > # CONFIG_DEBUG_SECTION_MISMATCH is not set
> > > # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
> > > CONFIG_FRAME_POINTER=3Dy
> > > CONFIG_STACK_VALIDATION=3Dy
> > > # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> > > # end of Compile-time checks and compiler options
> > >
> > > #
> > > # Generic Kernel Debugging Instruments
> > > #
> > > CONFIG_MAGIC_SYSRQ=3Dy
> > > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
> > > CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> > > CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=3D""
> > > CONFIG_DEBUG_FS=3Dy
> > > CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> > > # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> > > # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> > > CONFIG_HAVE_ARCH_KGDB=3Dy
> > > CONFIG_KGDB=3Dy
> > > CONFIG_KGDB_HONOUR_BLOCKLIST=3Dy
> > > CONFIG_KGDB_SERIAL_CONSOLE=3Dy
> > > # CONFIG_KGDB_TESTS is not set
> > > # CONFIG_KGDB_LOW_LEVEL_TRAP is not set
> > > # CONFIG_KGDB_KDB is not set
> > > CONFIG_ARCH_HAS_EARLY_DEBUG=3Dy
> > > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> > > # CONFIG_UBSAN is not set
> > > CONFIG_HAVE_ARCH_KCSAN=3Dy
> > > CONFIG_HAVE_KCSAN_COMPILER=3Dy
> > > # CONFIG_KCSAN is not set
> > > # end of Generic Kernel Debugging Instruments
> > >
> > > CONFIG_DEBUG_KERNEL=3Dy
> > > # CONFIG_DEBUG_MISC is not set
> > >
> > > #
> > > # Networking Debugging
> > > #
> > > # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> > > # CONFIG_NET_NS_REFCNT_TRACKER is not set
> > > # end of Networking Debugging
> > >
> > > #
> > > # Memory Debugging
> > > #
> > > # CONFIG_PAGE_EXTENSION is not set
> > > # CONFIG_DEBUG_PAGEALLOC is not set
> > > # CONFIG_PAGE_OWNER is not set
> > > # CONFIG_PAGE_TABLE_CHECK is not set
> > > # CONFIG_PAGE_POISONING is not set
> > > # CONFIG_DEBUG_PAGE_REF is not set
> > > # CONFIG_DEBUG_RODATA_TEST is not set
> > > CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> > > # CONFIG_DEBUG_WX is not set
> > > CONFIG_GENERIC_PTDUMP=3Dy
> > > # CONFIG_PTDUMP_DEBUGFS is not set
> > > # CONFIG_DEBUG_OBJECTS is not set
> > > # CONFIG_SLUB_DEBUG_ON is not set
> > > # CONFIG_SLUB_STATS is not set
> > > CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> > > # CONFIG_DEBUG_KMEMLEAK is not set
> > > # CONFIG_DEBUG_STACK_USAGE is not set
> > > # CONFIG_SCHED_STACK_END_CHECK is not set
> > > CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> > > # CONFIG_DEBUG_VM is not set
> > > # CONFIG_DEBUG_VM_PGTABLE is not set
> > > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> > > # CONFIG_DEBUG_VIRTUAL is not set
> > > CONFIG_DEBUG_MEMORY_INIT=3Dy
> > > # CONFIG_DEBUG_PER_CPU_MAPS is not set
> > > CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=3Dy
> > > # CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
> > > CONFIG_HAVE_ARCH_KASAN=3Dy
> > > CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> > > CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> > > CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> > > # CONFIG_KASAN is not set
> > > CONFIG_HAVE_ARCH_KFENCE=3Dy
> > > # CONFIG_KFENCE is not set
> > > # end of Memory Debugging
> > >
> > > # CONFIG_DEBUG_SHIRQ is not set
> > >
> > > #
> > > # Debug Oops, Lockups and Hangs
> > > #
> > > CONFIG_PANIC_ON_OOPS=3Dy
> > > CONFIG_PANIC_ON_OOPS_VALUE=3D1
> > > CONFIG_PANIC_TIMEOUT=3D0
> > > CONFIG_LOCKUP_DETECTOR=3Dy
> > > CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> > > # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> > > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> > > CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
> > > CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
> > > CONFIG_HARDLOCKUP_DETECTOR=3Dy
> > > # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> > > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D0
> > > CONFIG_DETECT_HUNG_TASK=3Dy
> > > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> > > # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> > > CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
> > > CONFIG_WQ_WATCHDOG=3Dy
> > > # CONFIG_TEST_LOCKUP is not set
> > > # end of Debug Oops, Lockups and Hangs
> > >
> > > #
> > > # Scheduler Debugging
> > > #
> > > CONFIG_SCHED_DEBUG=3Dy
> > > # CONFIG_SCHEDSTATS is not set
> > > # end of Scheduler Debugging
> > >
> > > # CONFIG_DEBUG_TIMEKEEPING is not set
> > > CONFIG_DEBUG_PREEMPT=3Dy
> > >
> > > #
> > > # Lock Debugging (spinlocks, mutexes, etc...)
> > > #
> > > CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> > > CONFIG_PROVE_LOCKING=3Dy
> > > # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> > > # CONFIG_LOCK_STAT is not set
> > > CONFIG_DEBUG_RT_MUTEXES=3Dy
> > > CONFIG_DEBUG_SPINLOCK=3Dy
> > > CONFIG_DEBUG_MUTEXES=3Dy
> > > CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> > > CONFIG_DEBUG_RWSEMS=3Dy
> > > CONFIG_DEBUG_LOCK_ALLOC=3Dy
> > > CONFIG_LOCKDEP=3Dy
> > > CONFIG_LOCKDEP_BITS=3D15
> > > CONFIG_LOCKDEP_CHAINS_BITS=3D16
> > > CONFIG_LOCKDEP_STACK_TRACE_BITS=3D19
> > > CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=3D14
> > > CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=3D12
> > > # CONFIG_DEBUG_LOCKDEP is not set
> > > # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> > > # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> > > # CONFIG_LOCK_TORTURE_TEST is not set
> > > # CONFIG_WW_MUTEX_SELFTEST is not set
> > > # CONFIG_SCF_TORTURE_TEST is not set
> > > # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> > > # end of Lock Debugging (spinlocks, mutexes, etc...)
> > >
> > > CONFIG_TRACE_IRQFLAGS=3Dy
> > > CONFIG_TRACE_IRQFLAGS_NMI=3Dy
> > > # CONFIG_DEBUG_IRQFLAGS is not set
> > > CONFIG_STACKTRACE=3Dy
> > > # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> > > # CONFIG_DEBUG_KOBJECT is not set
> > >
> > > #
> > > # Debug kernel data structures
> > > #
> > > CONFIG_DEBUG_LIST=3Dy
> > > # CONFIG_DEBUG_PLIST is not set
> > > # CONFIG_DEBUG_SG is not set
> > > # CONFIG_DEBUG_NOTIFIERS is not set
> > > # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> > > # end of Debug kernel data structures
> > >
> > > # CONFIG_DEBUG_CREDENTIALS is not set
> > >
> > > #
> > > # RCU Debugging
> > > #
> > > CONFIG_PROVE_RCU=3Dy
> > > # CONFIG_RCU_SCALE_TEST is not set
> > > # CONFIG_RCU_TORTURE_TEST is not set
> > > # CONFIG_RCU_REF_SCALE_TEST is not set
> > > CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> > > # CONFIG_RCU_TRACE is not set
> > > # CONFIG_RCU_EQS_DEBUG is not set
> > > # end of RCU Debugging
> > >
> > > # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> > > # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> > > # CONFIG_LATENCYTOP is not set
> > > CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> > > CONFIG_NOP_TRACER=3Dy
> > > CONFIG_HAVE_FUNCTION_TRACER=3Dy
> > > CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> > > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> > > CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> > > CONFIG_HAVE_FENTRY=3Dy
> > > CONFIG_HAVE_OBJTOOL_MCOUNT=3Dy
> > > CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> > > CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=3Dy
> > > CONFIG_TRACE_CLOCK=3Dy
> > > CONFIG_RING_BUFFER=3Dy
> > > CONFIG_EVENT_TRACING=3Dy
> > > CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> > > CONFIG_PREEMPTIRQ_TRACEPOINTS=3Dy
> > > CONFIG_TRACING=3Dy
> > > CONFIG_GENERIC_TRACER=3Dy
> > > CONFIG_TRACING_SUPPORT=3Dy
> > > CONFIG_FTRACE=3Dy
> > > # CONFIG_BOOTTIME_TRACING is not set
> > > # CONFIG_FUNCTION_TRACER is not set
> > > # CONFIG_STACK_TRACER is not set
> > > # CONFIG_IRQSOFF_TRACER is not set
> > > # CONFIG_PREEMPT_TRACER is not set
> > > # CONFIG_SCHED_TRACER is not set
> > > # CONFIG_HWLAT_TRACER is not set
> > > # CONFIG_OSNOISE_TRACER is not set
> > > # CONFIG_TIMERLAT_TRACER is not set
> > > # CONFIG_MMIOTRACE is not set
> > > CONFIG_FTRACE_SYSCALLS=3Dy
> > > # CONFIG_TRACER_SNAPSHOT is not set
> > > CONFIG_BRANCH_PROFILE_NONE=3Dy
> > > # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> > > # CONFIG_PROFILE_ALL_BRANCHES is not set
> > > # CONFIG_BLK_DEV_IO_TRACE is not set
> > > CONFIG_KPROBE_EVENTS=3Dy
> > > CONFIG_UPROBE_EVENTS=3Dy
> > > CONFIG_DYNAMIC_EVENTS=3Dy
> > > CONFIG_PROBE_EVENTS=3Dy
> > > # CONFIG_SYNTH_EVENTS is not set
> > > # CONFIG_HIST_TRIGGERS is not set
> > > # CONFIG_TRACE_EVENT_INJECT is not set
> > > # CONFIG_TRACEPOINT_BENCHMARK is not set
> > > # CONFIG_RING_BUFFER_BENCHMARK is not set
> > > # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > > # CONFIG_FTRACE_STARTUP_TEST is not set
> > > # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > > # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> > > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > > # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> > > # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> > > # CONFIG_SAMPLES is not set
> > > CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy
> > > CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=3Dy
> > > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> > >
> > > #
> > > # x86 Debugging
> > > #
> > > CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy
> > > # CONFIG_X86_VERBOSE_BOOTUP is not set
> > > CONFIG_EARLY_PRINTK=3Dy
> > > # CONFIG_EARLY_PRINTK_DBGP is not set
> > > # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> > > # CONFIG_DEBUG_TLBFLUSH is not set
> > > CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> > > # CONFIG_X86_DECODER_SELFTEST is not set
> > > # CONFIG_IO_DELAY_0X80 is not set
> > > CONFIG_IO_DELAY_0XED=3Dy
> > > # CONFIG_IO_DELAY_UDELAY is not set
> > > # CONFIG_IO_DELAY_NONE is not set
> > > # CONFIG_DEBUG_BOOT_PARAMS is not set
> > > # CONFIG_CPA_DEBUG is not set
> > > # CONFIG_DEBUG_ENTRY is not set
> > > # CONFIG_DEBUG_NMI_SELFTEST is not set
> > > # CONFIG_X86_DEBUG_FPU is not set
> > > # CONFIG_PUNIT_ATOM_DEBUG is not set
> > > # CONFIG_UNWINDER_ORC is not set
> > > CONFIG_UNWINDER_FRAME_POINTER=3Dy
> > > # end of x86 Debugging
> > >
> > > #
> > > # Kernel Testing and Coverage
> > > #
> > > # CONFIG_KUNIT is not set
> > > # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> > > CONFIG_FUNCTION_ERROR_INJECTION=3Dy
> > > CONFIG_FAULT_INJECTION=3Dy
> > > # CONFIG_FAILSLAB is not set
> > > # CONFIG_FAIL_PAGE_ALLOC is not set
> > > # CONFIG_FAULT_INJECTION_USERCOPY is not set
> > > CONFIG_FAIL_MAKE_REQUEST=3Dy
> > > # CONFIG_FAIL_IO_TIMEOUT is not set
> > > # CONFIG_FAIL_FUTEX is not set
> > > CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> > > # CONFIG_FAIL_FUNCTION is not set
> > > CONFIG_ARCH_HAS_KCOV=3Dy
> > > CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
> > > # CONFIG_KCOV is not set
> > > # CONFIG_RUNTIME_TESTING_MENU is not set
> > > CONFIG_ARCH_USE_MEMTEST=3Dy
> > > # CONFIG_MEMTEST is not set
> > > # end of Kernel Testing and Coverage
> > > # end of Kernel hacking
> >
