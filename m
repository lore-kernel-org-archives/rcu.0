Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771ADC433F5
	for <rcu@archiver.kernel.org>; Tue,  9 Nov 2021 11:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5903060EE9
	for <rcu@archiver.kernel.org>; Tue,  9 Nov 2021 11:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbhKILZO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:25:14 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:40818 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245705AbhKILZN (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 9 Nov 2021 06:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636456947; x=1667992947;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=UfMxmfeG+OV9PUqypLyDpULeZYvXQcRmofkX/KynauU=;
  b=txs0ezC/ww8xj7L2E4SNxMxf6PPC95fkG62qefK2y+qPRZIKPszEG1O6
   JEVJOTo5Sn3EWMSOp87+eAKikpTLh5xvZcaYhxWL4vqVggDZ1V5aWS9Zp
   6Tw0CV2HBXW/0dzwVbYjvJKouHuGfh+WeyN/OLCRPMVg1Wi2s0vQBdgLI
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Nov 2021 03:22:25 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 03:22:25 -0800
Received: from localhost (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 9 Nov 2021
 03:22:24 -0800
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
To:     <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <urezki@gmail.com>, <frederic@kernel.org>, <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH] rcu-tasks: Inspect stalled task's trc state in locked state
Date:   Tue, 9 Nov 2021 16:52:14 +0530
Message-ID: <20211109112214.19618-1-quic_neeraju@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On RCU tasks trace stall, inspect the RCU-tasks-trace specific
states of stalled task in locked down state, using try_invoke_
on_locked_down_task(), to get reliable trc state of a non-running
stalled task.

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
---
 kernel/rcu/tasks.h | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e4a32db9f712..4e49b847971b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1073,25 +1073,50 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
 
+/* Communicate task state back to the RCU tasks trace stall warning request. */
+struct trc_stall_chk_rdr {
+	int nesting;
+	int ipi_to_cpu;
+	u8 needqs;
+};
+
+static bool trc_check_slow_task(struct task_struct *t, void *arg)
+{
+	struct trc_stall_chk_rdr *trc_rdrp = arg;
+
+	if (task_curr(t))
+		return false; // It is running, so decline to inspect it.
+	trc_rdrp->nesting = READ_ONCE(t->trc_reader_nesting);
+	trc_rdrp->ipi_to_cpu = READ_ONCE(t->trc_ipi_to_cpu);
+	trc_rdrp->needqs = READ_ONCE(t->trc_reader_special.b.need_qs);
+	return true;
+}
+
 /* Show the state of a task stalling the current RCU tasks trace GP. */
 static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 {
 	int cpu;
+	struct trc_stall_chk_rdr trc_rdr;
+	bool is_idle_tsk = is_idle_task(t);
 
 	if (*firstreport) {
 		pr_err("INFO: rcu_tasks_trace detected stalls on tasks:\n");
 		*firstreport = false;
 	}
-	// FIXME: This should attempt to use try_invoke_on_nonrunning_task().
 	cpu = task_cpu(t);
-	pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
-		 t->pid,
-		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) >= 0],
-		 ".i"[is_idle_task(t)],
-		 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
-		 READ_ONCE(t->trc_reader_nesting),
-		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
-		 cpu);
+	if (!try_invoke_on_locked_down_task(t, trc_check_slow_task, &trc_rdr))
+		pr_alert("P%d: %c\n",
+			 t->pid,
+			 ".i"[is_idle_tsk]);
+	else
+		pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
+			 t->pid,
+			 ".I"[trc_rdr.ipi_to_cpu >= 0],
+			 ".i"[is_idle_tsk],
+			 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
+			 trc_rdr.nesting,
+			 " N"[!!trc_rdr.needqs],
+			 cpu);
 	sched_show_task(t);
 }
 
-- 
2.17.1

