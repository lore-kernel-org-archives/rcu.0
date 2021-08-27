Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F605C432BE
	for <rcu@archiver.kernel.org>; Fri, 27 Aug 2021 21:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B1F60FD8
	for <rcu@archiver.kernel.org>; Fri, 27 Aug 2021 21:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhH0Vxh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231906AbhH0Vxh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Aug 2021 17:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACC4760C40;
        Fri, 27 Aug 2021 21:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630101167;
        bh=MeVrs+QwEmHv2FM/WqCkqjlYLXtPrTGBHIHlx5hcLS8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jE6N8IxaLlRoksFZaRXeOdb14s4+xNszl131HWKQFl+sAaMg27SIzSwpfJYbrMhAn
         4f4trs66ddXZqvaYpPkXW5p9LmTfZFwMazNfX3B9Am2p3EEP/2A1xKGqMnh0rrgGeG
         7UqrQtKDmQJ/yFxB5iwnpZnkbY7S1Bcx/VMJa0iNB1EtNUIZmUk5Dw8C9/+5uAuiN9
         Vbi7qURvKKY9d0846ln7c1JS8U1nJ5Dico4pMpNKyzL25j8cw1BXyg2w2SCHUVGSAw
         wlFjxwgYZPcXF2P+aNv2400/bIjM7WdBJGmXWlzd+0eF7lmpaoWKrB4n/XlPZOC012
         CK6mxtY419ZcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6CC745C059E; Fri, 27 Aug 2021 14:52:47 -0700 (PDT)
Date:   Fri, 27 Aug 2021 14:52:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        frederic@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH] rcu-tasks: Correct IPI failure handling in
 trc_wait_for_one_reader
Message-ID: <20210827215247.GQ4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1630052015-16600-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630052015-16600-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 27, 2021 at 01:43:35PM +0530, Neeraj Upadhyay wrote:
> The trc_wait_for_one_reader() function is called at multiple stages
> of trace rcu-tasks GP function, rcu_tasks_wait_gp():
> 
> - First, it is called as part of per task function -
>   rcu_tasks_trace_pertask(), for all non-idle tasks. As part of per task
>   processing, this function add the task in the holdout list and if the
>   task is currently running on a CPU, it sends IPI to the task's CPU.
>   The IPI handler takes action depending on whether task is in trace
>   rcu-tasks read side critical section or not:
> 
>   - a. If the task is in trace rcu-tasks read side critical section
>        (t->trc_reader_nesting != 0), the IPI handler sets the task's
>        ->trc_reader_special.b.need_qs, so that this task notifies exit
>        from its outermost read side critical section (by decrementing
>        trc_n_readers_need_end) to the GP handling function.
>        trc_wait_for_one_reader() also increments trc_n_readers_need_end,
>        so that the trace rcu-tasks GP handler function waits for this
>        task's read side exit notification. The IPI handler also sets
>        t->trc_reader_checked to true, and no further IPIs are sent for
>        this task, for this trace rcu-tasks grace period and this
>        task can be removed from holdout list.
> 
>   - b. If the task is in the process of exiting its trace rcu-tasks
>        read side critical section, (t->trc_reader_nesting < 0), defer
>        this task's processing to future calls to trc_wait_for_one_reader().
> 
>   - c. If task is not in rcu-task read side critical section,
>        t->trc_reader_nesting == 0, ->trc_reader_checked is set for this
>        task, so that, this task is removed from holdout list.
> 
> - Second, trc_wait_for_one_reader() is called as part of post scan, in
>   function rcu_tasks_trace_postscan(), for all idle tasks.
> 
> - Third, in function check_all_holdout_tasks_trace(), for each task in
>   the holdout list, this function is called, if there isn't a pending IPI
>   for the task (->trc_ipi_to_cpu == -1). This function removed the task
>   from holdout list, if IPI handler has completed the required work,
>   to ensure that the current trace rcu-tasks grace period either waits
>   for this task, or this task is not in a trace rcu-tasks read side
>   critical section.
> 
> Now, considering the scenario where smp_call_function_single() fails in
> first case, inside rcu_tasks_trace_pertask(). In this case,
> ->trc_ipi_to_cpu is set to the current CPU for that task. This will
> result in trc_wait_for_one_reader() getting skipped in third case,
> inside check_all_holdout_tasks_trace(), for this task. This further
> results in ->trc_reader_checked never getting set for this task,
> and the task not getting removed from holdout list. This can cause
> the current trace rcu-tasks grace period to stall.
> 
> Fix the above problem, by resetting ->trc_ipi_to_cpu to -1, on
> smp_call_function_single() failure, so that future IPI calls can
> be send for this task. As all three callers (rcu_tasks_trace_pertask(),
> rcu_tasks_trace_postscan(), check_all_holdout_tasks_trace())
> of trc_wait_for_one_reader() run with CPU read lock held,
> smp_call_function_single() cannot race with CPU hotplug. So,
> also add a warning, to report and identify any such failure.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
> 
> Ran rcutorture TRACE01 tree for 10 hrs with below commandline, didn't
> observe warning:
> 
> Command line: debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug
> console=ttyS0 rcutree.rcu_fanout_leaf=4 nohz_full=1-N rcutorture.onoff_interval=1000
> rcutorture.onoff_holdoff=30 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15
> rcutorture.shutdown_secs=36000 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1
> rcutorture.torture_type=tasks-tracing

Very good, thank you!

I queued this for v5.16 (not the upcoming merge window, but the one after
that) and for review and further testing.  I did a little wordsmithing,
so could you please check to make sure that I didn't mess something up?

							Thanx, Paul

------------------------------------------------------------------------

commit 2717b14fb5fc57e5f131cc0bac26c85fc03a0cd2
Author: Neeraj Upadhyay <neeraju@codeaurora.org>
Date:   Fri Aug 27 13:43:35 2021 +0530

    rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader
    
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

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e6f0def1cb60..c110fd080c5b 100644
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
