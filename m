Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D7C38A2D
	for <rcu@archiver.kernel.org>; Wed, 26 Oct 2022 08:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiJZIVp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Oct 2022 04:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiJZIVn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Oct 2022 04:21:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9941B7EF1
        for <rcu@vger.kernel.org>; Wed, 26 Oct 2022 01:21:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j4so27204073lfk.0
        for <rcu@vger.kernel.org>; Wed, 26 Oct 2022 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34Oi4GiKGEagLyw/4x12s/w+YdPKSCgmMxAOUOL2N/g=;
        b=cHl2jUWzqssC+bSjP6CdTZogNODVrfh/1mxR1/w2umAs9YIx47C7lU20FhOz3zFa59
         zqIgt7bEgHGUkthhLj0Zzr1k+RFdH99I4Pp5GCQrdVhg+lS+AUf8RWHSB3uJSy8ij7kn
         FcXB/iqYoQVkZL8nM/F2gLRome5rBMtKqivbbqIoCSk6VziqeuAqdY8QkTZGSPVzGC0n
         AULri5DjRy/cONULILRYMN2Esk6TZYSoH8W2BrsAZ2ORL2WhQ7CjtshtBEkvAIbqaODO
         PVmr6gDo/OnYPki3irVY4rOLpkMLWk3kZwbdUpHWeM79H/ouRT043mXkL1ZEnUD8Agdy
         EfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34Oi4GiKGEagLyw/4x12s/w+YdPKSCgmMxAOUOL2N/g=;
        b=2BaCYOqgEztzTBTjUkVSPDaKNmHy/nrc/vZdcqldsT+1KpotFk6seH1bSbH5YvfHCC
         cC1w36OWEeZU1/vwBDl17Og7ex5UKNmd9VUGLc6FHENPdRwV2IjzOrZ3kyWhQ4a3GT+d
         3eIYanQcfK2+38Zpbbd8Wjs9DCQn2WHuYRcK0wdUoGkP+t25zbLWYgNDaBKL3P3BWklE
         ocCI91L/Tbxrx+8f+pNsgSIpRmmJY+z49LRy8LYHHKIp5gJNe0u9w/BpK8Gll7Fp9+Y3
         +mDneKnx/1HRu9M5tJm3c2RpTQotq40Eol0GskLJOI86ALcXbwXfSU3FvHos5f+wm/Hu
         0pSA==
X-Gm-Message-State: ACrzQf0y2ripde5A1YzoStKtWkri22w9dpD5UToYe+Z/kH5s+//c3k53
        gZOhJsw3TFIMgXeumQkdwDKAlYhi06WykCcysw==
X-Google-Smtp-Source: AMsMyM7oVilaUGx0d4msnnFEwZvFTe9qu9QHzBOIJNjtN+HmfKULm0f+zm3to+efBhp7+IH8TIC4OW1BY2TblAMBhoE=
X-Received: by 2002:a05:6512:e83:b0:4a2:cdaa:5e3e with SMTP id
 bi3-20020a0565120e8300b004a2cdaa5e3emr14962624lfb.308.1666772497927; Wed, 26
 Oct 2022 01:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221026032716.78674-1-kernelfans@gmail.com> <PH0PR11MB5880F4D3045159634170EFD0DA309@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880F4D3045159634170EFD0DA309@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 26 Oct 2022 16:21:26 +0800
Message-ID: <CAFgQCTsFoS2qmF8N3KsQzKStPJesAqbNQK=VxhEs825OqfW2Kw@mail.gmail.com>
Subject: Re: [PATCH] srcu: Delegate work to the first online cpu if using SRCU_SIZE_SMALL
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 26, 2022 at 12:36 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>
> >
> >commit 994f706872e6 ("srcu: Make Tree SRCU able to operate without
> >snp_node array") assumes that cpu 0 is always online, but that is not
> >the truth when using maxcpus=1 in the command line for the kdump kernel.
> >
> >On a PowerPC, the following kdump kernel hanging is observed:
> >...
> >[    1.740036] systemd[1]: Hostname set to <xyz.com>
> >[  243.686240] INFO: task systemd:1 blocked for more than 122 seconds.
> >[  243.686264]       Not tainted 6.1.0-rc1 #1
> >[  243.686272] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >[  243.686281] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
> >[  243.686296] Call Trace:
> >[  243.686301] [c000000016657640] [c000000016657670] 0xc000000016657670 (unreliable)
> >[  243.686317] [c000000016657830] [c00000001001dec0] __switch_to+0x130/0x220
> >[  243.686333] [c000000016657890] [c000000010f607b8] __schedule+0x1f8/0x580
> >[  243.686347] [c000000016657940] [c000000010f60bb4] schedule+0x74/0x140
> >[  243.686361] [c0000000166579b0] [c000000010f699b8] schedule_timeout+0x168/0x1c0
> >[  243.686374] [c000000016657a80] [c000000010f61de8] __wait_for_common+0x148/0x360
> >[  243.686387] [c000000016657b20] [c000000010176bb0] __flush_work.isra.0+0x1c0/0x3d0
> >[  243.686401] [c000000016657bb0] [c0000000105f2768] fsnotify_wait_marks_destroyed+0x28/0x40
> >[  243.686415] [c000000016657bd0] [c0000000105f21b8] fsnotify_destroy_group+0x68/0x160
> >[  243.686428] [c000000016657c40] [c0000000105f6500] inotify_release+0x30/0xa0
> >[  243.686440] [c000000016657cb0] [c0000000105751a8] __fput+0xc8/0x350
> >[  243.686452] [c000000016657d00] [c00000001017d524] task_work_run+0xe4/0x170
> >[  243.686464] [c000000016657d50] [c000000010020e94] do_notify_resume+0x134/0x140
> >[  243.686478] [c000000016657d80] [c00000001002eb18] interrupt_exit_user_prepare_main+0x198/0x270
> >[  243.686493] [c000000016657de0] [c00000001002ec60] syscall_exit_prepare+0x70/0x180
> >[  243.686505] [c000000016657e10] [c00000001000bf7c] system_call_vectored_common+0xfc/0x280
> >[  243.686520] --- interrupt: 3000 at 0x7fffa47d5ba4
> >[  243.686528] NIP:  00007fffa47d5ba4 LR: 0000000000000000 CTR: 0000000000000000
> >[  243.686538] REGS: c000000016657e80 TRAP: 3000   Not tainted  (6.1.0-rc1)
> >[  243.686548] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 42044440  XER: 00000000
> >[  243.686572] IRQMASK: 0
> >[  243.686572] GPR00: 0000000000000006 00007ffffa606710 00007fffa48e7200 0000000000000000
> >[  243.686572] GPR04: 0000000000000002 000000000000000a 0000000000000000 0000000000000001
> >[  243.686572] GPR08: 000001000c172dd0 0000000000000000 0000000000000000 0000000000000000
> >[  243.686572] GPR12: 0000000000000000 00007fffa4ff4bc0 0000000000000000 0000000000000000
> >[  243.686572] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> >[  243.686572] GPR20: 0000000132dfdc50 000000000000000e 0000000000189375 0000000000000000
> >[  243.686572] GPR24: 00007ffffa606ae0 0000000000000005 000001000c185490 000001000c172570
> >[  243.686572] GPR28: 000001000c172990 000001000c184850 000001000c172e00 00007fffa4fedd98
> >[  243.686683] NIP [00007fffa47d5ba4] 0x7fffa47d5ba4
> >[  243.686691] LR [0000000000000000] 0x0
> >[  243.686698] --- interrupt: 3000
> >[  243.686708] INFO: task kworker/u16:1:24 blocked for more than 122 seconds.
> >[  243.686717]       Not tainted 6.1.0-rc1 #1
> >[  243.686724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >[  243.686733] task:kworker/u16:1   state:D stack:0     pid:24    ppid:2      flags:0x00000800
> >[  243.686747] Workqueue: events_unbound fsnotify_mark_destroy_workfn
> >[  243.686758] Call Trace:
> >[  243.686762] [c0000000166736e0] [c00000004fd91000] 0xc00000004fd91000 (unreliable)
> >[  243.686775] [c0000000166738d0] [c00000001001dec0] __switch_to+0x130/0x220
> >[  243.686788] [c000000016673930] [c000000010f607b8] __schedule+0x1f8/0x580
> >[  243.686801] [c0000000166739e0] [c000000010f60bb4] schedule+0x74/0x140
> >[  243.686814] [c000000016673a50] [c000000010f699b8] schedule_timeout+0x168/0x1c0
> >[  243.686827] [c000000016673b20] [c000000010f61de8] __wait_for_common+0x148/0x360
> >[  243.686840] [c000000016673bc0] [c000000010210840] __synchronize_srcu.part.0+0xa0/0xe0
> >[  243.686855] [c000000016673c30] [c0000000105f2c64] fsnotify_mark_destroy_workfn+0xc4/0x1a0
> >[  243.686868] [c000000016673ca0] [c000000010174ea8] process_one_work+0x2a8/0x570
> >[  243.686882] [c000000016673d40] [c000000010175208] worker_thread+0x98/0x5e0
> >[  243.686895] [c000000016673dc0] [c0000000101828d4] kthread+0x124/0x130
> >[  243.686908] [c000000016673e10] [c00000001000cd40] ret_from_kernel_thread+0x5c/0x64
> >[  366.566274] INFO: task systemd:1 blocked for more than 245 seconds.
> >[  366.566298]       Not tainted 6.1.0-rc1 #1
> >[  366.566305] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >[  366.566314] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
> >[  366.566329] Call Trace:
> >...
> >
> >In that case, note that maxcpus=1 instead of nr_cpus=1 is used in the
> >kernel command line on the PowerPC platform. Consequently, the crash cpu
> >is the only onlined cpu in the kdump kernel, but with its logical id not
> >necessary 0. While SRCU queues a sdp->work on cpu 0, on which no worker
> >thread is created, so sdp->work will be never executed and
> >__synchronize_srcu() can not be completed.
> >
> >Tackle this issue by queueing sdp->work on the first onlined cpu.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> >Cc: Josh Triplett <josh@joshtriplett.org>
> >Cc: Steven Rostedt <rostedt@goodmis.org>
> >Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >To: rcu@vger.kernel.org
> >---
> > kernel/rcu/srcutree.c | 10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> >
> >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >index 1c304fec89c0..f2df561e0995 100644
> >--- a/kernel/rcu/srcutree.c
> >+++ b/kernel/rcu/srcutree.c
> >@@ -663,7 +663,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
> >       int state;
> >
> >       if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> >-              sdp = per_cpu_ptr(ssp->sda, 0);
> >+              sdp = per_cpu_ptr(ssp->sda, cpumask_first(cpu_online_mask));
> >       else
> >               sdp = this_cpu_ptr(ssp->sda);
> >       lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
> >@@ -774,7 +774,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >       /* Initiate callback invocation as needed. */
> >       ss_state = smp_load_acquire(&ssp->srcu_size_state);
> >       if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
> >-              srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, 0), cbdelay);
> >+              srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda,
> >+                                      cpumask_first(cpu_online_mask)), cbdelay);
> >       } else {
> >               idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
> >               srcu_for_each_node_breadth_first(ssp, snp) {
> >@@ -1093,7 +1094,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >       idx = srcu_read_lock(ssp);
> >       ss_state = smp_load_acquire(&ssp->srcu_size_state);
> >       if (ss_state < SRCU_SIZE_WAIT_CALL)
> >-              sdp = per_cpu_ptr(ssp->sda, 0);
> >+              sdp = per_cpu_ptr(ssp->sda, cpumask_first(cpu_online_mask));
>
> Hi Pingfan
>
> If CPU0 support hotplug.
> For example , in this time cpumask_first(cpu_online_mask) return 0
>
> >       else
> >               sdp = raw_cpu_ptr(ssp->sda);
> >       spin_lock_irqsave_sdp_contention(sdp, &flags);
> >@@ -1429,7 +1430,8 @@ void srcu_barrier(struct srcu_struct *ssp)
> >
> >       idx = srcu_read_lock(ssp);
> >       if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> >-              srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
> >+              srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda,
> >+                                      cpumask_first(cpu_online_mask)));
>
> Due to CPU hotplug, CPU0 have been offline, assume srcu_size_state is still SRCU_SIZE_WAIT_CALL.
> in this time, cpumask_first(cpu_online_mask) not return 0,  this will cause the srcu barrier to return directly.
>

Thanks for catching this bug.

It seems that get_boot_cpu_id() can tackle the whole issue.  I will
wait for more comments and send out V2.

Thanks,

    Pingfan
