Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7411C43219
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29CC61157
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhIOXrb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233156AbhIOXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B89E6120E;
        Wed, 15 Sep 2021 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=pqavdQ+8z9itHv3jTA1bXCKUTfXuAXnpeSPkY1/BtVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cT9zI4aAnCGbKNDKnxjRRmwdawsLuzugziQwZF3/BbGXZQDVtvSIEMPDHV5JB9SZX
         As2CzJXustujPyIU74h/lEUWrTDIqdLPRUw/b1xyLW1ZNvjIYpcsb+eGJo1tjcOASp
         VkmxMB8Rl5qUQ4zjl50xJd7F3CEWzK8kX68cp9MrTIbkza6O7nwZw76VhH9mwoW5V6
         9vnS4wi8gfvFIo0al6IvZC4TMx8I03CWs9ApeNKlBqMZrX3DEy3X7MK5AmMHLFTYlg
         Hek8dHJETxeZOR4fJva+QpWX8n053jWQhA0nlFOhuKdhJ6F7UcgybBLaUCrXq5sV50
         J0WX9Nt6pkdTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D3CBA5C0DBF; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/13] rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader
Date:   Wed, 15 Sep 2021 16:46:03 -0700
Message-Id: <20210915234604.3907802-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

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
       task, so that this task is removed from holdout list.

- Second, trc_wait_for_one_reader() is called as part of post scan, in
  function rcu_tasks_trace_postscan(), for all idle tasks.

- Third, in function check_all_holdout_tasks_trace(), this function is
  called for each task in the holdout list, but only if there isn't
  a pending IPI for the task (->trc_ipi_to_cpu == -1). This function
  removed the task from holdout list, if IPI handler has completed the
  required work, to ensure that the current trace rcu-tasks grace period
  either waits for this task, or this task is not in a trace rcu-tasks
  read side critical section.

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
be send for this task.

Note that all three of the trc_wait_for_one_reader() function's
callers (rcu_tasks_trace_pertask(), rcu_tasks_trace_postscan(),
check_all_holdout_tasks_trace()) hold cpu_read_lock().  This means
that smp_call_function_single() cannot race with CPU hotplug, and thus
should never fail.  Therefore, also add a warning in order to report
any such failure in case smp_call_function_single() grows some other
reason for failure.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 47a29e411217..0c10c8407dca 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1012,9 +1012,11 @@ static void trc_wait_for_one_reader(struct task_struct *t,
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
2.31.1.189.g2e36527f23

