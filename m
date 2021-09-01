Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08083C4320E
	for <rcu@archiver.kernel.org>; Wed,  1 Sep 2021 06:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E098E6101A
	for <rcu@archiver.kernel.org>; Wed,  1 Sep 2021 06:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbhIAGs3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Sep 2021 02:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242346AbhIAGs3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Sep 2021 02:48:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94357C061575
        for <rcu@vger.kernel.org>; Tue, 31 Aug 2021 23:47:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r7so2254514edd.6
        for <rcu@vger.kernel.org>; Tue, 31 Aug 2021 23:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEwQFqSQuhp1iQWPoEU85Xv7s9pAts70QYOC9bZTmAA=;
        b=NQ93e/JtD5aFGxlreLCTrpFijelBgg0BlNAgdgkZQidKYP/0pogTn17fPml12F+jva
         u87jm/DUguque+Xl5KyYE5+5vXBS2+9QMCAyZGStAPAMRRbWGvzEruWoc/Gqjw92++ZC
         oH5gySdRV7DwjLs+IqFQBN4kYoA67f4kFf5PjK3QjU9W7DYOX2ItwrWqZnarDAY52gMR
         FETjJpl28J/ojfZsJk9x02mLIYD69DyWglNEUd+jBS2gr+z7lKaeWGv6C2i6ukjaUEbg
         Ka7kYiraVgtbPxAvkd6KLq/gnXC96YG2LvZYeIIZGFswBqcXNd0uJp+4GjXlPfc0ZC1b
         kSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEwQFqSQuhp1iQWPoEU85Xv7s9pAts70QYOC9bZTmAA=;
        b=ktx71LYxBTfdWltfZ0eTY5fq1P2mu6bp3U+Ih6P2j9S8Dx3bhk2vr4C92DG4EEwnt0
         O7aAJ4aGn2kdvjtu/MnhBH6XTXhnLf5QJyV29S+0oW7Qc1lNBn0BkkdNIlPsY2GvWqKL
         I+Z7J66jZhVnvlhA5soiqenERIvsnqPn81NByy6OS2X/sdNUIgrHAsZ+O+9oPiSALBuu
         EiJ6vYvYvQJBlEwM79D6KDXPbEjPqJ0AKFaPI5hH3ti1GXpABeS+xVCGxWDtNYvQoQH8
         +iFDsGoy7oJSOATQG+zF6bAWNBKCUdcXNBq2c+kkCki4qggla6hxDT0My1mKq8SDNv8M
         CRYg==
X-Gm-Message-State: AOAM530iqghnxPxhE69izhHiXyEYYZ77VBph+dcdzfDK+Su/zB2Iidn8
        NxoIBum63y6EpOY4Au+38ep0QjPBM/xoSeJvC1k=
X-Google-Smtp-Source: ABdhPJyVpkCSNQLUPBLFMqC8Rl33Vn6B1RfYHVShW+5gsmdXb/pZnMH64OEPZc5lF/G5v/84Mw8akeg8G9MJKt3hgk0=
X-Received: by 2002:a05:6402:221b:: with SMTP id cq27mr22841118edb.374.1630478851091;
 Tue, 31 Aug 2021 23:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210831152144.GA28128@trex> <CAABZP2xGnSLVbgxqjKMq=Oj_H7rYfYjuCvmBpmZ4tRptGs3SEw@mail.gmail.com>
 <CAABZP2wUdToiAWOAgqDZrZtkuEdrXEv9GDgbioW3PZAyseOSgA@mail.gmail.com>
 <CAABZP2zg8c_gkm4+h4-mPCv_uDf5-iJFHEExCDFoES0jmBeuKw@mail.gmail.com> <2712e554-2058-d3c3-72ae-cca7562a2ec7@codeaurora.org>
In-Reply-To: <2712e554-2058-d3c3-72ae-cca7562a2ec7@codeaurora.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 1 Sep 2021 14:47:18 +0800
Message-ID: <CAABZP2w5tqwKBEh7gJ8h02ZVj6gGdYnPy1gBsD7DEbtbA-9KxQ@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
List-Id: <soc.lore.kernel.org>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Neeraj

Thank you for reviewing the original logs provided by jorge and my new
test logs.

On Wed, Sep 1, 2021 at 12:08 PM Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
>
> Hi,
>
>  >[   62.603086] rcu: rcu_preempt kthread starved for 5258 jiffies!
> g3017 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
>  >[   62.613246] rcu:     Unless rcu_preempt kthread gets sufficient CPU
> time, OOM is now expected behavior.
>
> These logs tells us, rcu_preempt thread is in RUNNING state, however,
> the thread is not scheduled for long. So, can you please check the
> activity (scheduler traces, runqueue) on the CPU where rcu_preempt
> kthread is running (->cpu=1 in this case) , to see why rcu_preempt
> is starved of CPU cycles?

I start the qemu virtual machine with gdb remote debugging
kvm -cpu host -smp 8 -s -S -hda ./debian10.qcow2 -m 8192 -net
user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
-vnc :30&
gdb ./vmlinux
gdb)target remote :1234
gdb)break rcu_check_gp_kthread_starvation
gdb) continue

then rerun my second test case (2.  # CONFIG_RCU_BOOST is not set)
the gdb breakpoint does not get a hit!
then I use gdb command info threads, the system seems to struggling
with memory subsystem
(gdb) info threads
  Id   Target Id         Frame
  8    Thread 8 (CPU#7 [running]) check_preemption_disabled (
    what1=0xffffffff82604e07 "__this_cpu_",
    what2=0xffffffff82589772 "add_return") at lib/smp_processor_id.c:14
  7    Thread 7 (CPU#6 [running]) __lock_is_held (read=<optimized out>,
    lock=<optimized out>) at kernel/locking/lockdep.c:5366
  6    Thread 6 (CPU#5 [running]) nfsd_reply_cache_count (
    shrink=0xffff88804d10fd10, sc=0xffffc9000eb4f788) at fs/nfsd/nfscache.c:295
  5    Thread 5 (CPU#4 [running]) preempt_count ()
    at ./arch/x86/include/asm/preempt.h:27
  4    Thread 4 (CPU#3 [running]) rcu_read_lock ()
    at ./include/linux/rcupdate.h:688
  3    Thread 3 (CPU#2 [running]) 0xffffffff812c3b34 in find_next_bit (
    offset=<optimized out>, size=<optimized out>, addr=<optimized out>)
    at ./include/asm-generic/bitops/find.h:36
* 2    Thread 2 (CPU#1 [running]) do_shrink_slab (
    shrinkctl=0xffffc9000031f820, shrinker=0xffff888191c2c510, priority=1)
    at mm/vmscan.c:659
  1    Thread 1 (CPU#0 [running]) check_wait_context (next=<optimized out>,
    curr=<optimized out>) at kernel/locking/lockdep.c:4715
(gdb) bt
#0  do_shrink_slab (shrinkctl=0xffffc9000031f820, shrinker=0xffff888191c2c510,
    priority=1) at mm/vmscan.c:659
#1  0xffffffff812c3c75 in shrink_slab (gfp_mask=17829066, nid=0,
    memcg=0xffff888100322000, priority=1) at mm/vmscan.c:872
#2  0xffffffff812c656f in shrink_node_memcgs (sc=<optimized out>,
    pgdat=<optimized out>) at mm/vmscan.c:2879
#3  shrink_node (pgdat=0xffffc9000031f820, sc=0xffffc9000031f978)
    at mm/vmscan.c:2994
#4  0xffffffff812c6b9d in shrink_zones (sc=<optimized out>,
    zonelist=<optimized out>) at mm/vmscan.c:3197
#5  do_try_to_free_pages (zonelist=0xffff88823fffba00, sc=0xffffc9000031f978)
    at mm/vmscan.c:3252
#6  0xffffffff812c8357 in try_to_free_pages (zonelist=0xffff88823fffba00,
    order=0, gfp_mask=<optimized out>, nodemask=<optimized out>)
    at mm/vmscan.c:3491
#7  0xffffffff81315a9e in __perform_reclaim (ac=<optimized out>,
    ac=<optimized out>, order=<optimized out>, gfp_mask=<optimized out>)
    at mm/page_alloc.c:4607
#8  __alloc_pages_direct_reclaim (did_some_progress=<optimized out>,
    ac=<optimized out>, alloc_flags=<optimized out>, order=<optimized out>,
    gfp_mask=<optimized out>) at mm/page_alloc.c:4628
#9  __alloc_pages_slowpath (gfp_mask=3274784, order=17829066,
    ac=0xffffc9000031faf8) at mm/page_alloc.c:5032
---Type <return> to continue, or q <return> to quit---
#10 0xffffffff81316b53 in __alloc_pages (gfp=17829066, order=0,
    preferred_nid=<optimized out>, nodemask=0x0 <fixed_percpu_data>)
    at mm/page_alloc.c:5403
#11 0xffffffff81334f13 in alloc_pages_vma (gfp=17829066, order=0,
    vma=0xffff888107ed4cc0, addr=<optimized out>, node=0,
    hugepage=<optimized out>) at mm/mempolicy.c:2208
#12 0xffffffff8131ee1e in __read_swap_cache_async (entry=...,
    gfp_mask=17829066, vma=0x1 <fixed_percpu_data+1>, addr=0,
    new_page_allocated=0x1 <fixed_percpu_data+1>) at mm/swap_state.c:459
#13 0xffffffff8131f0b8 in read_swap_cache_async (entry=...,
    gfp_mask=<optimized out>, vma=<optimized out>, addr=<optimized out>,
    do_poll=true) at mm/swap_state.c:525
#14 0xffffffff8131f2bd in swap_cluster_readahead (entry=...,
    gfp_mask=17829066, vmf=0x6d3b4) at mm/swap_state.c:661
#15 0xffffffff8131f4c5 in swapin_readahead (entry=..., gfp_mask=2445460752,
    vmf=0x1 <fixed_percpu_data+1>) at mm/swap_state.c:853
#16 0xffffffff812efcf0 in do_swap_page (vmf=0xffffc9000031fe00)
    at mm/memory.c:3551
#17 0xffffffff812f3a7d in handle_pte_fault (vmf=<optimized out>)
    at mm/memory.c:4562
#18 __handle_mm_fault (vma=<optimized out>, address=<optimized out>,
    flags=<optimized out>) at mm/memory.c:4693
#19 0xffffffff812f4633 in handle_mm_fault (vma=0xffff888107ed4cc0,
---Type <return> to continue, or q <return> to quit---
    address=140202217193320, flags=596, regs=0xffffc9000031ff58)
    at mm/memory.c:4791
#20 0xffffffff8110e36e in do_user_addr_fault (regs=0xffffc9000031f820,
    error_code=18446612688810460432, address=1) at arch/x86/mm/fault.c:1390
#21 0xffffffff81c13d69 in handle_page_fault (address=<optimized out>,
    error_code=<optimized out>, regs=<optimized out>)
    at arch/x86/mm/fault.c:1475
#22 exc_page_fault (regs=0xffffc9000031f820, error_code=18446612688810460432)
    at arch/x86/mm/fault.c:1531
#23 0xffffffff81e00ace in asm_exc_page_fault ()
    at ./arch/x86/include/asm/idtentry.h:568
#24 0x0000000000000016 in fixed_percpu_data ()
#25 0x0000000000000000 in ?? ()

So, I guess jorge's test may be more instructive than mine ;-)

>
>
> Thanks
> Neeraj
>
> On 9/1/2021 6:33 AM, Zhouyi Zhou wrote:
> > Hi,
> >
> > I  perform following two new rounds of experiments:
> >
> >
> > Test environment (x86_64 debian10 virtual machine: kvm -cpu host -smp
> > 8 -hda ./debian10.qcow2 -m 4096 -net
> > user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
> > -vnc :30)
> >
> > 1.   CONFIG_RCU_BOOST=y
> > 1.1 as root, run #stress-ng --sequential 100  --class scheduler -t 5m --times
> > 1.2 as regular user at the same time, run $stress-ng --sequential 100
> > --class scheduler -t 5m --times
> >
> > System begin OOM kill after 6 minutes:
> > 31 19:41:12 debian kernel: [  847.171884] task:kworker/1:0     state:D
> > stack:    0 pid: 1634 ppid:     2 flag\
> > s:0x00004000
> > Aug 31 19:41:12 debian kernel: [  847.171890] Workqueue: ipv6_addrconf
> > addrconf_verify_work
> > Aug 31 19:41:12 debian kernel: [  847.171897] Call Trace:
> > Aug 31 19:41:12 debian kernel: [  847.171903]  __schedule+0x368/0xa40
> > Aug 31 19:41:12 debian kernel: [  847.171915]  schedule+0x44/0xe0
> > Aug 31 19:41:12 debian kernel: [  847.171921]
> > schedule_preempt_disabled+0x14/0x20
> > Aug 31 19:41:12 debian kernel: [  847.171924]  __mutex_lock+0x4b1/0xa10
> > Aug 31 19:41:12 debian kernel: [  847.171935]  ? addrconf_verify_work+0xa/0x20
> > Aug 31 19:41:12 debian kernel: [  847.171948]  ? addrconf_verify_work+0xa/0x20
> > Aug 31 19:41:12 debian kernel: [  847.171951]  addrconf_verify_work+0xa/0x20
> > Aug 31 19:41:12 debian kernel: [  847.171955]  process_one_work+0x1fa/0x5b0
> > Aug 31 19:41:12 debian kernel: [  847.171967]  worker_thread+0x64/0x3d0
> > Aug 31 19:41:12 debian kernel: [  847.171974]  ? process_one_work+0x5b0/0x5b0
> > Aug 31 19:41:12 debian kernel: [  847.171978]  kthread+0x131/0x180
> > Aug 31 19:41:12 debian kernel: [  847.171982]  ? set_kthread_struct+0x40/0x40
> > Aug 31 19:41:12 debian kernel: [  847.171989]  ret_from_fork+0x1f/0x30
> > Aug 31 19:41:12 debian kernel: [  847.176007]
> > Aug 31 19:41:12 debian kernel: [  847.176007] Showing all locks held
> > in the system:
> > Aug 31 19:41:12 debian kernel: [  847.176016] 1 lock held by khungtaskd/56:
> > Aug 31 19:41:12 debian kernel: [  847.176018]  #0: ffffffff82918b60
> > (rcu_read_lock){....}-{1:2}, at: debug_show_a\
> > ll_locks+0xe/0x1a0
> >
> > 2.  # CONFIG_RCU_BOOST is not set
> > 2.1 as root, run #stress-ng --sequential 100  --class scheduler -t 5m --times
> > 2.2 as regular user at the same time, run $stress-ng --sequential 100
> > --class scheduler -t 5m --times
> > System begin OOM kill after 6 minutes:
> > The system is so dead, that I can't save the backtrace to file nor did
> > kernel has a chance to save the log to /var/log/messages
> >
> > Thanks
> > Zhouyi
> >
> > On Wed, Sep 1, 2021 at 1:11 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >>
> >> followings are some of my kernel config options:
> >> CONFIG_PREEMPT=y
> >> CONFIG_PREEMPT_COUNT=y
> >> CONFIG_PREEMPTION=y
> >> CONFIG_PREEMPT_DYNAMIC=y
> >> CONFIG_PREEMPT_RCU=y
> >> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> >> CONFIG_TREE_RCU=y
> >> CONFIG_PREEMPT_RCU=y
> >> CONFIG_RCU_EXPERT=y
> >> CONFIG_SRCU=y
> >> CONFIG_TREE_SRCU=y
> >> CONFIG_TASKS_RCU_GENERIC=y
> >> CONFIG_TASKS_RCU=y
> >> CONFIG_TASKS_RUDE_RCU=y
> >> CONFIG_TASKS_TRACE_RCU=y
> >> CONFIG_RCU_STALL_COMMON=y
> >> CONFIG_RCU_NEED_SEGCBLIST=y
> >> CONFIG_RCU_FANOUT=64
> >> CONFIG_RCU_FANOUT_LEAF=16
> >> # CONFIG_RCU_FAST_NO_HZ is not set
> >> # CONFIG_RCU_BOOST is not set
> >> CONFIG_RCU_NOCB_CPU=y
> >> # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
> >> # end of RCU Subsystem
> >> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> >> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> >> # RCU Debugging
> >> CONFIG_PROVE_RCU=y
> >> # CONFIG_PROVE_RCU_LIST is not set
> >> # CONFIG_RCU_SCALE_TEST is not set
> >> CONFIG_RCU_TORTURE_TEST=m
> >> # CONFIG_RCU_REF_SCALE_TEST is not set
> >> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> >> # CONFIG_RCU_TRACE is not set
> >> # CONFIG_RCU_EQS_DEBUG is not set
> >>
> >> Thanks
> >> Zhouyi
> >>
> >> On Wed, Sep 1, 2021 at 1:01 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >>>
> >>> I did an experiment just now on x86_64 virtual machines, rcu did not
> >>> complain after 10 minutes's test, I hope my effort can provide some
> >>> clue.
> >>>
> >>> 1. I clone the fresh new linux kernel (git clone
> >>> https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git)
> >>> 2. compile the kernel without CONFIG_RCU_BOOST (: # CONFIG_RCU_BOOST is not set)
> >>> 3. boot the kernel on a x86_64 VM (kvm -cpu host -smp 16  -hda
> >>> ./debian10.qcow2 -m 4096 -net
> >>> user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
> >>> -vnc :30)
> >>> 4. run the test (stress-ng --sequential 16  --class scheduler -t 5m --times)
> >>> 5. monitor the system by constantly typing top and dmesg
> >>> 6. after 10 minutes, nothing else happens except that the dmesg report
> >>> following two messages
> >>> [  672.528192] sched: DL replenish lagged too much
> >>> [  751.127790] hrtimer: interrupt took 12143 ns
> >>>
> >>> So, I guess CONFIG_RCU_BOOST is not necessary for x86_64 virtual machines
> >>>
> >>> Zhouyi
> >>>
> >>> On Tue, Aug 31, 2021 at 11:24 PM Jorge Ramirez-Ortiz, Foundries
> >>> <jorge@foundries.io> wrote:
> >>>>
> >>>> Hi
> >>>>
> >>>> When enabling CONFIG_PREEMPT and running the stress-ng scheduler class
> >>>> tests on arm64 (xilinx zynqmp and imx imx8mm SoCs) we are observing the following.
> >>>>
> >>>> [   62.578917] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >>>> [   62.585015]  (detected by 0, t=5253 jiffies, g=3017, q=2972)
> >>>> [   62.590663] rcu: All QSes seen, last rcu_preempt kthread activity 5254 (4294907943-4294902689), jiffies_till_next_fqs=1, root
> >>>> +->qsmask 0x0
> >>>> [   62.603086] rcu: rcu_preempt kthread starved for 5258 jiffies! g3017 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> >>>> [   62.613246] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> >>>> [   62.622359] rcu: RCU grace-period kthread stack dump:
> >>>> [   62.627395] task:rcu_preempt     state:R  running task     stack:    0 pid:   14 ppid:     2 flags:0x00000028
> >>>> [   62.637308] Call trace:
> >>>> [   62.639748]  __switch_to+0x11c/0x190
> >>>> [   62.643319]  __schedule+0x3b8/0x8d8
> >>>> [   62.646796]  schedule+0x4c/0x108
> >>>> [   62.650018]  schedule_timeout+0x1ac/0x358
> >>>> [   62.654021]  rcu_gp_kthread+0x6a8/0x12b8
> >>>> [   62.657933]  kthread+0x14c/0x158
> >>>> [   62.661153]  ret_from_fork+0x10/0x18
> >>>> [   62.682919] BUG: scheduling while atomic: stress-ng-hrtim/831/0x00000002
> >>>> [   62.689604] Preemption disabled at:
> >>>> [   62.689614] [<ffffffc010059418>] irq_enter_rcu+0x30/0x58
> >>>> [   62.698393] CPU: 0 PID: 831 Comm: stress-ng-hrtim Not tainted 5.10.42+ #5
> >>>> [   62.706296] Hardware name: Zynqmp new (DT)
> >>>> [   62.710115] Call trace:
> >>>> [   62.712548]  dump_backtrace+0x0/0x240
> >>>> [   62.716202]  show_stack+0x2c/0x38
> >>>> [   62.719510]  dump_stack+0xcc/0x104
> >>>> [   62.722904]  __schedule_bug+0x78/0xc8
> >>>> [   62.726556]  __schedule+0x70c/0x8d8
> >>>> [   62.730037]  schedule+0x4c/0x108
> >>>> [   62.733259]  do_notify_resume+0x224/0x5d8
> >>>> [   62.737259]  work_pending+0xc/0x2a4
> >>>>
> >>>> The error results in OOM eventually.
> >>>>
> >>>> RCU priority boosting does work around this issue but it seems to me
> >>>> a workaround more than a fix (otherwise boosting would be enabled
> >>>> by CONFIG_PREEMPT for arm64 I guess?).
> >>>>
> >>>> The question is: is this an arm64 bug that should be investigated? or
> >>>> is this some known corner case of running stress-ng that is already
> >>>> understood?
> >>>>
> >>>> thanks
> >>>> Jorge
> >>>>
> >>>>
> >>>>
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
Thanks
Zhouyi
