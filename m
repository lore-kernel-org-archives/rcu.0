Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C51C38A2D
	for <rcu@archiver.kernel.org>; Wed, 26 Oct 2022 03:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiJZD3N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Oct 2022 23:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiJZD2z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Oct 2022 23:28:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F2B978A
        for <rcu@vger.kernel.org>; Tue, 25 Oct 2022 20:27:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso1239688pjc.0
        for <rcu@vger.kernel.org>; Tue, 25 Oct 2022 20:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6LH6IiNFWyi/ibssVASH6BmuiSoyJlvWOFDaVBRdmg=;
        b=QpyfuegkQc21cz7UqkOxYdk3oyf81xK9sNtE7kWgLpDhjHldhMLGOIb/Lynh4jLDf0
         YBC4FH93/DQDQKa+5cLHrFEx/XJutmPhoK1xUdlVJQqkvaDUAjaFDMHvLoMQMxCYm59p
         k8JE3TcrEgXgEAHXy0hHGOCRts0bfW8EsU1AfHvU8M+SWFas5YS4V4hO2MNt4VMQQjRI
         Zm1nuD2YJ3WPGupTB0MQJEVCy1vOkwiHM6saQdvc0or5lLulYgsKq2fy3/n26XfuVuwh
         zz0B5YwK71ztE41Ya/fD5VYSgbicN22n6AQHTwwZX6MBD2xKl8HuTMevIamqetB+jImA
         OIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6LH6IiNFWyi/ibssVASH6BmuiSoyJlvWOFDaVBRdmg=;
        b=iCuLEV5cal1aV2i7hnPhd00PUtblHFJXlMgc7T6XCsEm3rFJsU1t9HjyDyVsRyrpHT
         UCRdrMsE+ieDBtdJBNbwex6IaqM+PuImCcV8n55qavZnoPEREFEsRJ0VMHVr0Zqx/6fH
         GVRbpaoR77qIa9hLb0v6w0OSLXisBCTit5NM1Z5Mvr+BBXWl0o/lhOD+Z7IZZc3yq3Fs
         5UXHi6X4aWtcfPQMXWmTMcrieN68xu8047VeFU7FFiIXpvrRV3etMeEfSJRlS+9wOQeg
         /DD9VYT970mYdfwhHSTo/hvPV8tBlGHojvdh5cqLXrtIxQ6y5Z6WPOqMZWhX/5szcSDp
         TaDQ==
X-Gm-Message-State: ACrzQf0k6/1UYvLcO3hVM9MBZ064y7dpSobZ7E4lHHJXXSErKlgTKUrd
        f1odgAJVNFoNDeiRTzEMuuyXO/nWYw==
X-Google-Smtp-Source: AMsMyM4nw2mIjfyhoejE5Y0x5ohZxjX66cI9BAyKho4t15TL53cvRdS6OymAgZN3JINGjH0AAEEShA==
X-Received: by 2002:a17:903:1d1:b0:17f:6494:f8c3 with SMTP id e17-20020a17090301d100b0017f6494f8c3mr41484758plh.157.1666754865890;
        Tue, 25 Oct 2022 20:27:45 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a2c0600b0020d9ac33fbbsm321838pjd.17.2022.10.25.20.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 20:27:45 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] srcu: Delegate work to the first online cpu if using SRCU_SIZE_SMALL
Date:   Wed, 26 Oct 2022 11:27:16 +0800
Message-Id: <20221026032716.78674-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

commit 994f706872e6 ("srcu: Make Tree SRCU able to operate without
snp_node array") assumes that cpu 0 is always online, but that is not
the truth when using maxcpus=1 in the command line for the kdump kernel.

On a PowerPC, the following kdump kernel hanging is observed:
...
[    1.740036] systemd[1]: Hostname set to <xyz.com>
[  243.686240] INFO: task systemd:1 blocked for more than 122 seconds.
[  243.686264]       Not tainted 6.1.0-rc1 #1
[  243.686272] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.686281] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
[  243.686296] Call Trace:
[  243.686301] [c000000016657640] [c000000016657670] 0xc000000016657670 (unreliable)
[  243.686317] [c000000016657830] [c00000001001dec0] __switch_to+0x130/0x220
[  243.686333] [c000000016657890] [c000000010f607b8] __schedule+0x1f8/0x580
[  243.686347] [c000000016657940] [c000000010f60bb4] schedule+0x74/0x140
[  243.686361] [c0000000166579b0] [c000000010f699b8] schedule_timeout+0x168/0x1c0
[  243.686374] [c000000016657a80] [c000000010f61de8] __wait_for_common+0x148/0x360
[  243.686387] [c000000016657b20] [c000000010176bb0] __flush_work.isra.0+0x1c0/0x3d0
[  243.686401] [c000000016657bb0] [c0000000105f2768] fsnotify_wait_marks_destroyed+0x28/0x40
[  243.686415] [c000000016657bd0] [c0000000105f21b8] fsnotify_destroy_group+0x68/0x160
[  243.686428] [c000000016657c40] [c0000000105f6500] inotify_release+0x30/0xa0
[  243.686440] [c000000016657cb0] [c0000000105751a8] __fput+0xc8/0x350
[  243.686452] [c000000016657d00] [c00000001017d524] task_work_run+0xe4/0x170
[  243.686464] [c000000016657d50] [c000000010020e94] do_notify_resume+0x134/0x140
[  243.686478] [c000000016657d80] [c00000001002eb18] interrupt_exit_user_prepare_main+0x198/0x270
[  243.686493] [c000000016657de0] [c00000001002ec60] syscall_exit_prepare+0x70/0x180
[  243.686505] [c000000016657e10] [c00000001000bf7c] system_call_vectored_common+0xfc/0x280
[  243.686520] --- interrupt: 3000 at 0x7fffa47d5ba4
[  243.686528] NIP:  00007fffa47d5ba4 LR: 0000000000000000 CTR: 0000000000000000
[  243.686538] REGS: c000000016657e80 TRAP: 3000   Not tainted  (6.1.0-rc1)
[  243.686548] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 42044440  XER: 00000000
[  243.686572] IRQMASK: 0
[  243.686572] GPR00: 0000000000000006 00007ffffa606710 00007fffa48e7200 0000000000000000
[  243.686572] GPR04: 0000000000000002 000000000000000a 0000000000000000 0000000000000001
[  243.686572] GPR08: 000001000c172dd0 0000000000000000 0000000000000000 0000000000000000
[  243.686572] GPR12: 0000000000000000 00007fffa4ff4bc0 0000000000000000 0000000000000000
[  243.686572] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  243.686572] GPR20: 0000000132dfdc50 000000000000000e 0000000000189375 0000000000000000
[  243.686572] GPR24: 00007ffffa606ae0 0000000000000005 000001000c185490 000001000c172570
[  243.686572] GPR28: 000001000c172990 000001000c184850 000001000c172e00 00007fffa4fedd98
[  243.686683] NIP [00007fffa47d5ba4] 0x7fffa47d5ba4
[  243.686691] LR [0000000000000000] 0x0
[  243.686698] --- interrupt: 3000
[  243.686708] INFO: task kworker/u16:1:24 blocked for more than 122 seconds.
[  243.686717]       Not tainted 6.1.0-rc1 #1
[  243.686724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.686733] task:kworker/u16:1   state:D stack:0     pid:24    ppid:2      flags:0x00000800
[  243.686747] Workqueue: events_unbound fsnotify_mark_destroy_workfn
[  243.686758] Call Trace:
[  243.686762] [c0000000166736e0] [c00000004fd91000] 0xc00000004fd91000 (unreliable)
[  243.686775] [c0000000166738d0] [c00000001001dec0] __switch_to+0x130/0x220
[  243.686788] [c000000016673930] [c000000010f607b8] __schedule+0x1f8/0x580
[  243.686801] [c0000000166739e0] [c000000010f60bb4] schedule+0x74/0x140
[  243.686814] [c000000016673a50] [c000000010f699b8] schedule_timeout+0x168/0x1c0
[  243.686827] [c000000016673b20] [c000000010f61de8] __wait_for_common+0x148/0x360
[  243.686840] [c000000016673bc0] [c000000010210840] __synchronize_srcu.part.0+0xa0/0xe0
[  243.686855] [c000000016673c30] [c0000000105f2c64] fsnotify_mark_destroy_workfn+0xc4/0x1a0
[  243.686868] [c000000016673ca0] [c000000010174ea8] process_one_work+0x2a8/0x570
[  243.686882] [c000000016673d40] [c000000010175208] worker_thread+0x98/0x5e0
[  243.686895] [c000000016673dc0] [c0000000101828d4] kthread+0x124/0x130
[  243.686908] [c000000016673e10] [c00000001000cd40] ret_from_kernel_thread+0x5c/0x64
[  366.566274] INFO: task systemd:1 blocked for more than 245 seconds.
[  366.566298]       Not tainted 6.1.0-rc1 #1
[  366.566305] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  366.566314] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
[  366.566329] Call Trace:
...

In that case, note that maxcpus=1 instead of nr_cpus=1 is used in the
kernel command line on the PowerPC platform. Consequently, the crash cpu
is the only onlined cpu in the kdump kernel, but with its logical id not
necessary 0. While SRCU queues a sdp->work on cpu 0, on which no worker
thread is created, so sdp->work will be never executed and
__synchronize_srcu() can not be completed.

Tackle this issue by queueing sdp->work on the first onlined cpu.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..f2df561e0995 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -663,7 +663,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	int state;
 
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-		sdp = per_cpu_ptr(ssp->sda, 0);
+		sdp = per_cpu_ptr(ssp->sda, cpumask_first(cpu_online_mask));
 	else
 		sdp = this_cpu_ptr(ssp->sda);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
@@ -774,7 +774,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	/* Initiate callback invocation as needed. */
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
-		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, 0), cbdelay);
+		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda,
+					cpumask_first(cpu_online_mask)), cbdelay);
 	} else {
 		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
 		srcu_for_each_node_breadth_first(ssp, snp) {
@@ -1093,7 +1094,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	idx = srcu_read_lock(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
-		sdp = per_cpu_ptr(ssp->sda, 0);
+		sdp = per_cpu_ptr(ssp->sda, cpumask_first(cpu_online_mask));
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_sdp_contention(sdp, &flags);
@@ -1429,7 +1430,8 @@ void srcu_barrier(struct srcu_struct *ssp)
 
 	idx = srcu_read_lock(ssp);
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
+		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda,
+					cpumask_first(cpu_online_mask)));
 	else
 		for_each_possible_cpu(cpu)
 			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
-- 
2.31.1

