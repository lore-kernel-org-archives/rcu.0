Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4473C433FE
	for <rcu@archiver.kernel.org>; Wed,  2 Nov 2022 14:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiKBOGm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiKBOGk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Nov 2022 10:06:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A232659D
        for <rcu@vger.kernel.org>; Wed,  2 Nov 2022 07:06:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j16so28379178lfe.12
        for <rcu@vger.kernel.org>; Wed, 02 Nov 2022 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=++xiXFbYgtOcd23CL9CtgicWCo2cfXy5yItxjaXdI/E=;
        b=dsfzQqG3L8jDOdeyuJN0XrtEcg1QfbswuTZDjKbjMwKMCZKAntGKlFOZ0KeOEOJEEa
         gCDxFvwNR+199rycROC4O8OMbreZ7j9jKiP/Cz+O286iBbOuSeuhdJXBNV3+jhpzSk2w
         tFLYTnDMGoPR71wEuN6sMGID/eJApNpQxVcF2dxNLy0qOSyzFPYpJ2gXvFqWwmpjMJaP
         VnFEuCPJFlF6zJ35NbPRPbV80OVmbWymJmroi1SEeTBOy7pcun2xxxqQgtREhupfQZfh
         /V6FLAbXFwg4PMdcJv6F3fGwbTaJ4NYA0qUwsLvP52rqaeaOASdr04/m4h8k7hdtIj4i
         PgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++xiXFbYgtOcd23CL9CtgicWCo2cfXy5yItxjaXdI/E=;
        b=BRXWDyxGKsmQ1oBOkX6FtJiaPiIR10in1n+c1v4fWujTtwg5TswXwp4lQbuGu+L9jj
         RXPDI3MmTpnsBsnO6xclfyqSxnJg7rxVtMwhYbb5AqYFbHEITtykc8GUg4dWwfmYUjij
         6TYWIboZqI3XBUv1bycCdIxUfefDjVRIksFVNWJN6pYdIn+epwZM0QaF41Jj2eeq8MIE
         o2k82V1BGs+cDHrrto2mOV3Ln8cqbFgyyqBgtbCe2GDY3RbdadtOHYZ7hdc/icaZU+j3
         IGvxzb208JD2Ayw/S5Mm2nLlBanjXWhuIOdIFJrW5Ja6PwL35qmXKuhxgsfiJZGn9fCr
         7wTQ==
X-Gm-Message-State: ACrzQf2h36Z68QdNkdzBqsCGq/Y6aRxL2RBMimruZfJ9Xr7OMJ5x34z9
        9hFC8shFvID3ovYVhD/UL/+IuDszuxJb+oV2wA==
X-Google-Smtp-Source: AMsMyM731Ue6bENPIgOfSe7A6pZo5dMC50/PXgQaWUdKATlS+BPjYngU3zno987dVi+5IuTPAV90/H3+DbCaI+lc+wE=
X-Received: by 2002:ac2:57c5:0:b0:4a4:4f15:44ec with SMTP id
 k5-20020ac257c5000000b004a44f1544ecmr9126605lfo.526.1667397996423; Wed, 02
 Nov 2022 07:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221026032716.78674-1-kernelfans@gmail.com> <PH0PR11MB5880F4D3045159634170EFD0DA309@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAFgQCTsFoS2qmF8N3KsQzKStPJesAqbNQK=VxhEs825OqfW2Kw@mail.gmail.com>
 <20221026135552.GJ5600@paulmck-ThinkPad-P17-Gen-1> <Y1n1GT4HSxUEGYlT@piliu.users.ipa.redhat.com>
 <20221027165200.GZ5600@paulmck-ThinkPad-P17-Gen-1> <Y1utslDY9Su3t7FM@piliu.users.ipa.redhat.com>
 <20221028181305.GQ5600@paulmck-ThinkPad-P17-Gen-1> <Y18o1x0F3EcZtskH@piliu.users.ipa.redhat.com>
 <PH0PR11MB5880917B88DB5B45CDE63153DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880917B88DB5B45CDE63153DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 2 Nov 2022 22:06:24 +0800
Message-ID: <CAFgQCTvmxaaBm=M7F_6csCGbpxj=LkQWjovS_Ra0O64DGHvtFQ@mail.gmail.com>
Subject: Re: [PATCH] srcu: Delegate work to the first online cpu if using SRCU_SIZE_SMALL
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Zqiang,

On Wed, Nov 2, 2022 at 2:07 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>
> On Fri, Oct 28, 2022 at 11:13:05AM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 28, 2022 at 06:23:46PM +0800, Pingfan Liu wrote:
> > > Some stuff is PowerPC specific, CC PowerPC experts, please correct me if
> > > I make a mistake.
> > >
> > > On Thu, Oct 27, 2022 at 09:52:00AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Oct 27, 2022 at 11:03:53AM +0800, Pingfan Liu wrote:
> > > > > On Wed, Oct 26, 2022 at 06:55:52AM -0700, Paul E. McKenney wrote:
> > > > > > On Wed, Oct 26, 2022 at 04:21:26PM +0800, Pingfan Liu wrote:
> > > > > > > On Wed, Oct 26, 2022 at 12:36 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
> > > > > > > >
> > > > > > > > >
> > > > > > > > >commit 994f706872e6 ("srcu: Make Tree SRCU able to operate without
> > > > > > > > >snp_node array") assumes that cpu 0 is always online, but that is not
> > > > > > > > >the truth when using maxcpus=1 in the command line for the kdump kernel.
> > > > > > > > >
> > > > > > > > >On a PowerPC, the following kdump kernel hanging is observed:
> > > > > > > > >...
> > > > > > > > >[    1.740036] systemd[1]: Hostname set to <xyz.com>
> > > > > > > > >[  243.686240] INFO: task systemd:1 blocked for more than 122 seconds.
> > > > > > > > >[  243.686264]       Not tainted 6.1.0-rc1 #1
> > > > > > > > >[  243.686272] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > > > > >[  243.686281] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
> > > > > > > > >[  243.686296] Call Trace:
> > > > > > > > >[  243.686301] [c000000016657640] [c000000016657670] 0xc000000016657670 (unreliable)
> > > > > > > > >[  243.686317] [c000000016657830] [c00000001001dec0] __switch_to+0x130/0x220
> > > > > > > > >[  243.686333] [c000000016657890] [c000000010f607b8] __schedule+0x1f8/0x580
> > > > > > > > >[  243.686347] [c000000016657940] [c000000010f60bb4] schedule+0x74/0x140
> > > > > > > > >[  243.686361] [c0000000166579b0] [c000000010f699b8] schedule_timeout+0x168/0x1c0
> > > > > > > > >[  243.686374] [c000000016657a80] [c000000010f61de8] __wait_for_common+0x148/0x360
> > > > > > > > >[  243.686387] [c000000016657b20] [c000000010176bb0] __flush_work.isra.0+0x1c0/0x3d0
> > > > > > > > >[  243.686401] [c000000016657bb0] [c0000000105f2768] fsnotify_wait_marks_destroyed+0x28/0x40
> > > > > > > > >[  243.686415] [c000000016657bd0] [c0000000105f21b8] fsnotify_destroy_group+0x68/0x160
> > > > > > > > >[  243.686428] [c000000016657c40] [c0000000105f6500] inotify_release+0x30/0xa0
> > > > > > > > >[  243.686440] [c000000016657cb0] [c0000000105751a8] __fput+0xc8/0x350
> > > > > > > > >[  243.686452] [c000000016657d00] [c00000001017d524] task_work_run+0xe4/0x170
> > > > > > > > >[  243.686464] [c000000016657d50] [c000000010020e94] do_notify_resume+0x134/0x140
> > > > > > > > >[  243.686478] [c000000016657d80] [c00000001002eb18] interrupt_exit_user_prepare_main+0x198/0x270
> > > > > > > > >[  243.686493] [c000000016657de0] [c00000001002ec60] syscall_exit_prepare+0x70/0x180
> > > > > > > > >[  243.686505] [c000000016657e10] [c00000001000bf7c] system_call_vectored_common+0xfc/0x280
> > > > > > > > >[  243.686520] --- interrupt: 3000 at 0x7fffa47d5ba4
> > > > > > > > >[  243.686528] NIP:  00007fffa47d5ba4 LR: 0000000000000000 CTR: 0000000000000000
> > > > > > > > >[  243.686538] REGS: c000000016657e80 TRAP: 3000   Not tainted  (6.1.0-rc1)
> > > > > > > > >[  243.686548] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 42044440  XER: 00000000
> > > > > > > > >[  243.686572] IRQMASK: 0
> > > > > > > > >[  243.686572] GPR00: 0000000000000006 00007ffffa606710 00007fffa48e7200 0000000000000000
> > > > > > > > >[  243.686572] GPR04: 0000000000000002 000000000000000a 0000000000000000 0000000000000001
> > > > > > > > >[  243.686572] GPR08: 000001000c172dd0 0000000000000000 0000000000000000 0000000000000000
> > > > > > > > >[  243.686572] GPR12: 0000000000000000 00007fffa4ff4bc0 0000000000000000 0000000000000000
> > > > > > > > >[  243.686572] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > > > >[  243.686572] GPR20: 0000000132dfdc50 000000000000000e 0000000000189375 0000000000000000
> > > > > > > > >[  243.686572] GPR24: 00007ffffa606ae0 0000000000000005 000001000c185490 000001000c172570
> > > > > > > > >[  243.686572] GPR28: 000001000c172990 000001000c184850 000001000c172e00 00007fffa4fedd98
> > > > > > > > >[  243.686683] NIP [00007fffa47d5ba4] 0x7fffa47d5ba4
> > > > > > > > >[  243.686691] LR [0000000000000000] 0x0
> > > > > > > > >[  243.686698] --- interrupt: 3000
> > > > > > > > >[  243.686708] INFO: task kworker/u16:1:24 blocked for more than 122 seconds.
> > > > > > > > >[  243.686717]       Not tainted 6.1.0-rc1 #1
> > > > > > > > >[  243.686724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > > > > >[  243.686733] task:kworker/u16:1   state:D stack:0     pid:24    ppid:2      flags:0x00000800
> > > > > > > > >[  243.686747] Workqueue: events_unbound fsnotify_mark_destroy_workfn
> > > > > > > > >[  243.686758] Call Trace:
> > > > > > > > >[  243.686762] [c0000000166736e0] [c00000004fd91000] 0xc00000004fd91000 (unreliable)
> > > > > > > > >[  243.686775] [c0000000166738d0] [c00000001001dec0] __switch_to+0x130/0x220
> > > > > > > > >[  243.686788] [c000000016673930] [c000000010f607b8] __schedule+0x1f8/0x580
> > > > > > > > >[  243.686801] [c0000000166739e0] [c000000010f60bb4] schedule+0x74/0x140
> > > > > > > > >[  243.686814] [c000000016673a50] [c000000010f699b8] schedule_timeout+0x168/0x1c0
> > > > > > > > >[  243.686827] [c000000016673b20] [c000000010f61de8] __wait_for_common+0x148/0x360
> > > > > > > > >[  243.686840] [c000000016673bc0] [c000000010210840] __synchronize_srcu.part.0+0xa0/0xe0
> > > > > > > > >[  243.686855] [c000000016673c30] [c0000000105f2c64] fsnotify_mark_destroy_workfn+0xc4/0x1a0
> > > > > > > > >[  243.686868] [c000000016673ca0] [c000000010174ea8] process_one_work+0x2a8/0x570
> > > > > > > > >[  243.686882] [c000000016673d40] [c000000010175208] worker_thread+0x98/0x5e0
> > > > > > > > >[  243.686895] [c000000016673dc0] [c0000000101828d4] kthread+0x124/0x130
> > > > > > > > >[  243.686908] [c000000016673e10] [c00000001000cd40] ret_from_kernel_thread+0x5c/0x64
> > > > > > > > >[  366.566274] INFO: task systemd:1 blocked for more than 245 seconds.
> > > > > > > > >[  366.566298]       Not tainted 6.1.0-rc1 #1
> > > > > > > > >[  366.566305] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > > > > >[  366.566314] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
> > > > > > > > >[  366.566329] Call Trace:
> > > > > > > > >...
> > > > > > > > >
> > > > > > > > >In that case, note that maxcpus=1 instead of nr_cpus=1 is used in the
> > > > > > > > >kernel command line on the PowerPC platform. Consequently, the crash cpu
> > > > > > > > >is the only onlined cpu in the kdump kernel, but with its logical id not
> > > > > > > > >necessary 0. While SRCU queues a sdp->work on cpu 0, on which no worker
> > > > > > > > >thread is created, so sdp->work will be never executed and
> > > > > > > > >__synchronize_srcu() can not be completed.
> > > > > > > > >
> > > > > > > > >Tackle this issue by queueing sdp->work on the first onlined cpu.
> > > > > > > > >
> > > > > > > > >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > > > > >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > > > > >Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > > > > >Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > > > > >Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > > > >To: rcu@vger.kernel.org
> > > > > > > > >---
> > > > > > > > > kernel/rcu/srcutree.c | 10 ++++++----
> > > > > > > > > 1 file changed, 6 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > > > >index 1c304fec89c0..f2df561e0995 100644
> > > > > > > > >--- a/kernel/rcu/srcutree.c
> > > > > > > > >+++ b/kernel/rcu/srcutree.c
> > > > > > > > >@@ -663,7 +663,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
> > > > > > > > >       int state;
> > > > > > > > >
> > > > > > > > >       if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> > > > > > > > >-              sdp = per_cpu_ptr(ssp->sda, 0);
> > > > > > > > >+              sdp = per_cpu_ptr(ssp->sda, cpumask_first(cpu_online_mask));
> > > > > > > > >       else
> > > > > > > > >               sdp = this_cpu_ptr(ssp->sda);
> > > > > > > > >       lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
> > > > > > > > >@@ -774,7 +774,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > > > > > > > >       /* Initiate callback invocation as needed. */
> > > > > > > > >       ss_state = smp_load_acquire(&ssp->srcu_size_state);
> > > > > > > > >       if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
> > > > > > > > >-              srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, 0), cbdelay);
> > > > > > > > >+              srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda,
> > > > > > > > >+                                      cpumask_first(cpu_online_mask)), cbdelay);
> > > > > > > > >       } else {
> > > > > > > > >               idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
> > > > > > > > >               srcu_for_each_node_breadth_first(ssp, snp) {
> > > > > > > > >@@ -1093,7 +1094,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > > > > > > > >       idx = srcu_read_lock(ssp);
> > > > > > > > >       ss_state = smp_load_acquire(&ssp->srcu_size_state);
> > > > > > > > >       if (ss_state < SRCU_SIZE_WAIT_CALL)
> > > > > > > > >-              sdp = per_cpu_ptr(ssp->sda, 0);
> > > > > > > > >+              sdp = per_cpu_ptr(ssp->sda, cpumask_first(cpu_online_mask));
> > > > > > > >
> > > > > > > > Hi Pingfan
> > > > > > > >
> > > > > > > > If CPU0 support hotplug.
> > > > > > > > For example , in this time cpumask_first(cpu_online_mask) return 0
> > > > > > > >
> > > > > > > > >       else
> > > > > > > > >               sdp = raw_cpu_ptr(ssp->sda);
> > > > > > > > >       spin_lock_irqsave_sdp_contention(sdp, &flags);
> > > > > > > > >@@ -1429,7 +1430,8 @@ void srcu_barrier(struct srcu_struct *ssp)
> > > > > > > > >
> > > > > > > > >       idx = srcu_read_lock(ssp);
> > > > > > > > >       if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> > > > > > > > >-              srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
> > > > > > > > >+              srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda,
> > > > > > > > >+                                      cpumask_first(cpu_online_mask)));
> > > > > > > >
> > > > > > > > Due to CPU hotplug, CPU0 have been offline, assume srcu_size_state is still SRCU_SIZE_WAIT_CALL.
> > > > > > > > in this time, cpumask_first(cpu_online_mask) not return 0,  this will cause the srcu barrier to return directly.
> > > > > > >
> > > > > > > Thanks for catching this bug.
> > > > > >
> > > > > > Indeed, good catch!
> > > > > >
> > > > > > > It seems that get_boot_cpu_id() can tackle the whole issue.  I will
> > > > > > > wait for more comments and send out V2.
> > > > > >
> > > > > > Does your patch require the CPU indicated by get_boot_cpu_id() to always
> > > > > > stay online?  If so, is that CPU guaranteed to always stay online?
> > > > >
> > > > > No, it is just a replacement for cpu 0.
> > > > >
> > > > > A qualified candidate should meet two requirements:
> > > > > -1. worker_pool is initialized, so it has worker thread to dispatch
> > > > > work. This is satisfied by once the cpu was onlined.
> > > > >
> > > > > -2. this cpu id is persistent as Zqiang pointed out.
> > > > >
> > > > > For hotplug, it is the same as cpu 0, which is taken care of by the
> > > > > workqueue infrastructure.
> > > > >
> > > > > > I am still asking my question about PowerPC booting with a non-zero CPU.
> > > > > > After all, if all remaining architectures always boot with CPU 0, then
> > > > > > perhaps some simplification is in order.
> > > > >
> > > > > As my understanding, it is not easy. Let us unfold the discussion in
> > > > > another thread post by you.
> > > >
> > > > As you wish...
> > > >
> > > > First, let me see if I understand the options.
> > > >
> > > > 1.        Take your initial patch, but fixing the issue pointed out by
> > > >   Zhang Qiang.  One issue is that cpu_online_mask is not initialized
> > > >   until boot_cpu_init() is invoked.  Given that SRCU is used by
> > > >   tracing, we must correctly handle early boot usage.
> > >
> > > The hotplug issue takes some effort to fix, so if there is a better way
> > > to go, it should be avoided.
> > >
> > > But you make me aware that I miss the early boot usage.
> > > I think it carefully and hope I can learn from this lesson. Please
> > > correct me if I am wrong in the following assumption.
> > >
> > > Since ftrace_init() comes after srcu_init(), so before srcu_init(), only
> > > _mcount has the opportunity to use SRCU, right?
> > >
> > > If that part does not use the SRCU function like srcu_barrier(), it will
> > > not a problem. Right?
> >
> > We would need to ask the ftrace and bpf people to make sure.  Except that
> > in the past, my fond assumptions about things not happening before
> > some point in boot have almost always been rudely invalidated, just so
> > you know.  ;-)
> >
> > > > 2.        Update your initial patch to fix the issue pointed out by Zhang
> > > >   Qiang and also to use get_boot_cpu_id() as you suggested earlier.
> > > >   Except that the __boot_cpu_id variable read by get_boot_cpu_id()
> > > >   is also initialized by boot_cpu_init(), and is zero up to
> > > >   that point.  So this has the same problem as #1 above.
> > >
> > > This is the way that I want to take.
> > >
> > > On the PowerPC, #define raw_smp_processor_id() (local_paca->paca_index),
> > > instead of (*raw_cpu_ptr(&cpu_number)).
> > > So in fact, boot_cpu_init()->smp_processor_id() gets the "boot_cpuid",
> > > which is assigned to __boot_cpu_id() later.
> >
> > I have to ask...  What does "boot_cpu_init()->smp_processor_id()" mean?
> >
> >
> >void __init boot_cpu_init(void)
> >{
> >        int cpu = smp_processor_id();
> >                  ^^^ This is specific on PowerPC, which is finally implemented by "#define raw_smp_processor_id() (local_paca->paca_index)"
> >                     And it is not zero up at this point. For the initialization of ->paca_index, please refer to the old comment just right after this function.
> >
> >
> >        /* Mark the boot cpu "present", "online" etc for SMP and UP case */
> >        set_cpu_online(cpu, true);
> >        set_cpu_active(cpu, true);
> >        set_cpu_present(cpu, true);
> >        set_cpu_possible(cpu, true);
> >
> >#ifdef CONFIG_SMP
> >        __boot_cpu_id = cpu;
> >                       ^^^ Actually, cpu will not be zero up
> >#endif
> >}
> >
>
> > > For boot_cpuid, early_init_devtree()->early_init_dt_scan_cpus() decides
> > > it. Then early_init_devtree()->allocate_paca(boot_cpuid)->initialise_paca(),
> > > where new_paca->paca_index = cpu;
> > >
> > > All these are done before start_kernel().
> > >
> >
> >More accurate info:
> >arch/powerpc/kernel/head_64.S:973:   LOAD_REG_ADDR(r12, DOTSYM(early_setup))  results in the calling to early_setup()
> ->early_init_devtree(), which finally sets up the local_paca->paca_index
> >
> >Then
> >arch/powerpc/kernel/head_64.S:1002:  bl      start_kernel
> >
> >So before the common kernel starts, PowerPC has made its effort so that
> >get_boot_cpu_id() can keep its semantic.
> >
> > > I have tested a patch adopting this method. It works.
> >
> > Could you please send the actual patch?
> >
> >
> >Sure, I will sent out it right after finishing this mail.
> >
> > > > 3.        As in #2 above, but modify srcu_init() to check for SRCU callbacks
> > > >   queued on CPU 0 when boot_cpu_init() returns non-zero.  In this
> > > >   case, move those SRCU callbacks to the srcu_data structure
> > > >   indicated by boot_cpu_init().
> > > >
> > > > 4.        Leave the SRCU code alone, but boot your crash kernel with
> > > >   srcutree.big_cpu_lim=0.  This would switch all srcu_struct
> > > >   structures to big mode at initialization time.  Once this switch
> > > >   completed, CPUs would queue SRCU callbacks on their own srcu_data
> > > >   structure's ->srcu_cblist.
> > > >
> > > >   I am not optimistic about this one, but could you please try it?
> > >
> > > I have tested it five times. It works.
> >
> > Given that it seems to work, I find this approach extremely attractive.
> > Hence my question about CPU 0's per-CPU variables in my recent email to
> > Michael Ellerman.
> >
> >
> >Sorry that I can not get your point. Are you suggesting to append an extra
> >kernel param to the kdump kernel?
> >
> >
> >Thanks,
> >
> >       Pingfan
> >
> >
> > > > 5.        Start over with the current SRCU code.  Make srcu_delay_timer()
> > > >   and srcu_queue_delayed_work_on() check to see if sdp->cpu is
> > > >   online, and if not, use queue_work() instead of queue_work_on().
> > > >   There might be other adjustments required, but I am not
> > > >   immediately seeing them.
> > > >
>
> Hi Pingfan, does this change look clearer?
>
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -745,19 +745,23 @@ static void srcu_gp_start(struct srcu_struct *ssp)
>         WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
>  }
>
> +static inline int sdp_cpu(struct srcu_data *sdp)
> +{
> +       return cpu_online(sdp->cpu) ? sdp->cpu : raw_smp_processor_id();
> +}
>
>  static void srcu_delay_timer(struct timer_list *t)
>  {
>         struct srcu_data *sdp = container_of(t, struct srcu_data, delay_work);
>
> -       queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> +       queue_work_on(sdp_cpu(sdp), rcu_gp_wq, &sdp->work);
>  }
>
>  static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
>                                        unsigned long delay)
>  {
>         if (!delay) {
> -               queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> +               queue_work_on(sdp_cpu(sdp), rcu_gp_wq, &sdp->work);

I think that in this way, srcu_barrier() can not work, since it
expects a fixed cpu. But now srcu_queue_delayed_work_on() queues work
on a dynamic cpu.

And I post V2: https://lore.kernel.org/all/20221031015237.10294-1-kernelfans@gmail.com/

It replaces cpu 0 with boot cpu id, so it meets both the fix and
once-onlined requirement.


Thanks,

    Pingfan
