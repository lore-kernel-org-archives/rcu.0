Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D10C71153
	for <rcu@archiver.kernel.org>; Mon, 28 Aug 2023 20:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjH1Uvu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjH1Uvb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Aug 2023 16:51:31 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D578139
        for <rcu@vger.kernel.org>; Mon, 28 Aug 2023 13:51:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-792979d4cb5so72923239f.2
        for <rcu@vger.kernel.org>; Mon, 28 Aug 2023 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693255886; x=1693860686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RRrCS1VOjSue2iqf5lDVAh4p7y1PlwPwihpyQqkBBI=;
        b=RU3s+/zpXsqwVIIxAeyU4TA7Zi8TUbfWRLx3PQEzSQR3GdAguMvp9rYYQBmYIzZtIx
         VTMdMlt0DYPRZN12Eg2XrC1xI7NHZ4eIm2FO6f2wQ7TBQencya+/XuIccapDWQqMO9rI
         pb+0K0X5KB6j7aif6r11JA+jOB9cyt5LHhQEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255886; x=1693860686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RRrCS1VOjSue2iqf5lDVAh4p7y1PlwPwihpyQqkBBI=;
        b=XaCpOGK2wKQjmWjfrvHRUhs9Qnszi1Ne2OTSTQmM5vQ3fQwEqc+Cc+HdK4OEBUDnYj
         VPDy7+EpXQO4y+aB2sYBOL8hBXsqL0N8LOjVLgHevixUgH//kfQ8kD4OuCs7sV2NV63g
         g5o6AmArBiggLptgpJKxlWtG1efaCVjJjV8k7RYwtYJcee6Kb9twjmLz7fWHxp4VlHjZ
         9IW85Dma0qswI3/wfDr0xa4XE/8qCaWnCUrCgD44XO4CXqp9YaXNLZgBt8W2Zf4zkkgY
         GyLtbwmye4OOFWCMlPyAdJZBjxQiy9C7LJgPJNlSn8avsnSQ02+s+xvyd/0ugJ7eMrYA
         n6cw==
X-Gm-Message-State: AOJu0YzhCcqV3kHDAn5giYakzKe77e6AzA+8nZOYmN85MCHSU8wVE8Bx
        Q7mbGrlNdvEbwFOrak8LzjFCNw==
X-Google-Smtp-Source: AGHT+IGOHHkHWDdYPEc57VIDJSmAi9D/bcAlPpB0fiy+mkf4XLdcr36knXBbP+o17hB3+49Ajt7HHA==
X-Received: by 2002:a05:6e02:1ca8:b0:345:fae5:666c with SMTP id x8-20020a056e021ca800b00345fae5666cmr20361505ill.4.1693255885813;
        Mon, 28 Aug 2023 13:51:25 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id z23-20020a02ceb7000000b0042b39f1c3d2sm2722979jaq.144.2023.08.28.13.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:51:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.15] rcu: Prevent expedited GP from enabling tick on offline CPU
Date:   Mon, 28 Aug 2023 20:51:21 +0000
Message-ID: <20230828205122.1659823-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 147f04b14adde831eb4a0a1e378667429732f9e8 ]

If an RCU expedited grace period starts just when a CPU is in the process
of going offline, so that the outgoing CPU has completed its pass through
stop-machine but has not yet completed its final dive into the idle loop,
RCU will attempt to enable that CPU's scheduling-clock tick via a call
to tick_dep_set_cpu().  For this to happen, that CPU has to have been
online when the expedited grace period completed its CPU-selection phase.

This is pointless:  The outgoing CPU has interrupts disabled, so it cannot
take a scheduling-clock tick anyway.  In addition, the tick_dep_set_cpu()
function's eventual call to irq_work_queue_on() will splat as follows:

smpboot: CPU 1 is now offline
WARNING: CPU: 6 PID: 124 at kernel/irq_work.c:95
+irq_work_queue_on+0x57/0x60
Modules linked in:
CPU: 6 PID: 124 Comm: kworker/6:2 Not tainted 5.15.0-rc1+ #3
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
+rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Workqueue: rcu_gp wait_rcu_exp_gp
RIP: 0010:irq_work_queue_on+0x57/0x60
Code: 8b 05 1d c7 ea 62 a9 00 00 f0 00 75 21 4c 89 ce 44 89 c7 e8
+9b 37 fa ff ba 01 00 00 00 89 d0 c3 4c 89 cf e8 3b ff ff ff eb ee <0f> 0b eb b7
+0f 0b eb db 90 48 c7 c0 98 2a 02 00 65 48 03 05 91
 6f
RSP: 0000:ffffb12cc038fe48 EFLAGS: 00010282
RAX: 0000000000000001 RBX: 0000000000005208 RCX: 0000000000000020
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9ad01f45a680
RBP: 000000000004c990 R08: 0000000000000001 R09: ffff9ad01f45a680
R10: ffffb12cc0317db0 R11: 0000000000000001 R12: 00000000fffecee8
R13: 0000000000000001 R14: 0000000000026980 R15: ffffffff9e53ae00
FS:  0000000000000000(0000) GS:ffff9ad01f580000(0000)
+knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000de0c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tick_nohz_dep_set_cpu+0x59/0x70
 rcu_exp_wait_wake+0x54e/0x870
 ? sync_rcu_exp_select_cpus+0x1fc/0x390
 process_one_work+0x1ef/0x3c0
 ? process_one_work+0x3c0/0x3c0
 worker_thread+0x28/0x3c0
 ? process_one_work+0x3c0/0x3c0
 kthread+0x115/0x140
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
---[ end trace c5bf75eb6aa80bc6 ]---

This commit therefore avoids invoking tick_dep_set_cpu() on offlined
CPUs to limit both futility and false-positive splats.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f46c0c1a5eb3..407941a2903b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -507,7 +507,10 @@ static void synchronize_rcu_expedited_wait(void)
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp = true;
-				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+				preempt_disable();
+				if (cpu_online(cpu))
+					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+				preempt_enable();
 			}
 		}
 		j = READ_ONCE(jiffies_till_first_fqs);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

