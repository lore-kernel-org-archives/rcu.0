Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C1C4320A
	for <rcu@archiver.kernel.org>; Fri, 27 Aug 2021 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA1F60FD9
	for <rcu@archiver.kernel.org>; Fri, 27 Aug 2021 08:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbhH0IOb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:14:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:33647 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhH0IOa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Aug 2021 04:14:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630052021; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=k7nqBAfvjs11JfMoilWyeU5K2v0rFIQpzU1EeMLoAxA=; b=dQCLwT0vZaCeGlzc5IFOkTq1lOqmdIHhNtL54MoMAHLQBCwPpX2R6svCQngTM1FQOeOkbShw
 8jbK3/tdv/IuDYXQeNb4l3rVmIR5Ac6l6U5OJnuXg5TuvQz5jT7SbYh2Yx9n2mTWd+kNLzQS
 z/3XGDuaOm7nxUUGB7T5FjGXzpE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61289eb5b52e91333cf73d2b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Aug 2021 08:13:41
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DDAD9C4338F; Fri, 27 Aug 2021 08:13:40 +0000 (UTC)
Received: from localhost (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B41B2C4338F;
        Fri, 27 Aug 2021 08:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B41B2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu-tasks: Correct IPI failure handling in trc_wait_for_one_reader
Date:   Fri, 27 Aug 2021 13:43:35 +0530
Message-Id: <1630052015-16600-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The trc_wait_for_one_reader() function is called at multiple stages
of trace rcu-tasks GP function, rcu_tasks_wait_gp():

- First, it is called as part of per task function -
  rcu_tasks_trace_pertask(), for all non-idle tasks. As part of per task
  processing, this function add the task in the holdout list and if the
  task is currently running on a CPU, it sends IPI to the task's CPU.
  The IPI handler takes action depending on whether task is in trace
  rcu-tasks read side critical section or not:

  - a. If the task is in trace rcu-tasks read side critical section
       (t->trc_reader_nesting != 0), the IPI handler sets the task's
       ->trc_reader_special.b.need_qs, so that this task notifies exit
       from its outermost read side critical section (by decrementing
       trc_n_readers_need_end) to the GP handling function.
       trc_wait_for_one_reader() also increments trc_n_readers_need_end,
       so that the trace rcu-tasks GP handler function waits for this
       task's read side exit notification. The IPI handler also sets
       t->trc_reader_checked to true, and no further IPIs are sent for
       this task, for this trace rcu-tasks grace period and this
       task can be removed from holdout list.

  - b. If the task is in the process of exiting its trace rcu-tasks
       read side critical section, (t->trc_reader_nesting < 0), defer
       this task's processing to future calls to trc_wait_for_one_reader().

  - c. If task is not in rcu-task read side critical section,
       t->trc_reader_nesting == 0, ->trc_reader_checked is set for this
       task, so that, this task is removed from holdout list.

- Second, trc_wait_for_one_reader() is called as part of post scan, in
  function rcu_tasks_trace_postscan(), for all idle tasks.

- Third, in function check_all_holdout_tasks_trace(), for each task in
  the holdout list, this function is called, if there isn't a pending IPI
  for the task (->trc_ipi_to_cpu == -1). This function removed the task
  from holdout list, if IPI handler has completed the required work,
  to ensure that the current trace rcu-tasks grace period either waits
  for this task, or this task is not in a trace rcu-tasks read side
  critical section.

Now, considering the scenario where smp_call_function_single() fails in
first case, inside rcu_tasks_trace_pertask(). In this case,
->trc_ipi_to_cpu is set to the current CPU for that task. This will
result in trc_wait_for_one_reader() getting skipped in third case,
inside check_all_holdout_tasks_trace(), for this task. This further
results in ->trc_reader_checked never getting set for this task,
and the task not getting removed from holdout list. This can cause
the current trace rcu-tasks grace period to stall.

Fix the above problem, by resetting ->trc_ipi_to_cpu to -1, on
smp_call_function_single() failure, so that future IPI calls can
be send for this task. As all three callers (rcu_tasks_trace_pertask(),
rcu_tasks_trace_postscan(), check_all_holdout_tasks_trace())
of trc_wait_for_one_reader() run with CPU read lock held,
smp_call_function_single() cannot race with CPU hotplug. So,
also add a warning, to report and identify any such failure.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---

Ran rcutorture TRACE01 tree for 10 hrs with below commandline, didn't
observe warning:

Command line: debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug
console=ttyS0 rcutree.rcu_fanout_leaf=4 nohz_full=1-N rcutorture.onoff_interval=1000
rcutorture.onoff_holdoff=30 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15
rcutorture.shutdown_secs=36000 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1
rcutorture.torture_type=tasks-tracing

 kernel/rcu/tasks.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e6f0def..c110fd0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1014,9 +1014,11 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 		if (smp_call_function_single(cpu, trc_read_check_handler, t, 0)) {
 			// Just in case there is some other reason for
 			// failure than the target CPU being offline.
+			WARN_ONCE(1, "%s():  smp_call_function_single() failed for CPU: %d\n",
+				  __func__, cpu);
 			rcu_tasks_trace.n_ipis_fails++;
 			per_cpu(trc_ipi_to_cpu, cpu) = false;
-			t->trc_ipi_to_cpu = cpu;
+			t->trc_ipi_to_cpu = -1;
 		}
 	}
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

