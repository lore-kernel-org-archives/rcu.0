Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5762C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94EB20774
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974740;
	bh=rI7AX8rsb9mXZ1Wzm69REtFbe0HjVRp0TOpmkxBoWlw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=G7J6qcktURdokKWkoTtGzjCEYdvRjQNCig4jlreP03WIJX5dvdohtI04grlmsgtzg
	 OEZWCVI9Q4Nxp5/341ONj4p/xs1xYU/gZBS+4z2K4NGwaPI/1z9ZhASfH7I+qDfbrk
	 3XhA+FkPGdVwKr+jhO9tny4b5n8/0zpm/mgdSWCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436604AbgDOSTA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436573AbgDOSS6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:18:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD60B2076D;
        Wed, 15 Apr 2020 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974736;
        bh=rI7AX8rsb9mXZ1Wzm69REtFbe0HjVRp0TOpmkxBoWlw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T8vg5fbTTSzfFjv7DQYG1DJnbsJDZowl6yZwUq42YOUI7CZn2GXWaFoiUVCfMxNLM
         FzHwuzYYoJMzKNXZdyocHRH1HyiBmOv342yMAIDfr3RyYaDKAQMcIkaJbVzNuaW7y1
         MrcPDUkRTKAZqJ2sL3l1eoHdVpZarmS7/Vd6vg64=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A2BBF3522AD1; Wed, 15 Apr 2020 11:18:56 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:18:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH v4 tip/core/rcu 0/38] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200327222346.GA12082@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides a non-RFC posting for two variants of Tasks RCU, a
rude variant inspired by Steven Rostedt's use of schedule_on_each_cpu(),
and a tracing variant requested by the BPF folks to be used (for example)
to protect BPF programs that unconditionally access userspace memory,
and thus might occasionally take a page fault, resulting in a voluntary
context switch.

The rude variant uses context switches and offline as its quiescent
states, so that preempt-disabled regions of code executing on online
CPUs form the tasks rude RCU readers.

The tracing variant has explicit read-side markers to permit finite grace
periods even given in-kernel loops in PREEMPT=n builds.  These markers
are rcu_read_lock_trace() and rcu_read_unlock_trace(), so that any code
not under rcu_read_lock_trace() is a quiescent state.  This variant
also protects marked code in the idle loop, on exception entry/exit
paths, and on the various CPU-hotplug online/offline code paths, thus
having protection properties similar to SRCU.  However, unlike SRCU,
this variant avoids expensive instructions in the read-side primitives,
thus having read-side overhead similar to that of preemptible RCU.
This difference is important for some BPF programs, according to
benchmarking from Alexei Starovoitov:

https://lore.kernel.org/lkml/20200310014043.4dbagqbr2wsbuarm@ast-mbp/

There are of course downsides.  The grace-period code can send IPIs to
CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
However, this version enlists the aid of the context-switch hooks,
which eliminates the need for IPIs in context-switch-heavy workloads.
It also prohibits sending of IPIs early in the grace period based on a
new rcupdate.rcu_task_ipi_delay kernel boot parameter, which provides
additional opportunity for the hooks to do their job.  Finally, a new
TASKS_TRACE_RCU_READ_MB Kconfig option avoids sending IPIs to tasks
executing userspace or in the idle loop, at the expense of higher overhead
readers during kernel entry/exit code and in the idle loop.

It is also necessary to scan the full tasklist, much as for Tasks RCU.
There is a single callback queue guarded by a single lock, again, much
as for Tasks RCU.  If needed, these downsides can be at least partially
remedied.

Perhaps most important, this variant of RCU does not affect the vanilla
flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
readers can operate from idle, offline, and exception entry/exit in no
way allows rcu_preempt and rcu_sched readers to also do so.

The RCU tasks trace mechanism is based off of RCU tasks rather than
SRCU because the latter is more complex and also because the latter
uses a CPU-by-CPU approach to tracking quiescent states instead of the
task-by-task approach that is needed.  It is in theory possible to mash
RCU tasks trace into the Tree SRCU implementation, but there will need
to be extremely good reasons for doing so.  The vanilla RCU mechanism
could in theory be used in CONFIG_PREEMPT=y kernels, but fails utterly
in CONFIG_PREEMPT=n kernels.  Tasks RCU does not work because page
faults can result in a voluntary context switch, which prevents it from
protecting a BPF program that page faults.  The new "rude" variant only
protected preempt-disable regions of code, thus also failing to protect
BPF programs that page fault.

This effort benefited greatly from off-list discussions of BPF
requirements with Alexei Starovoitov and Andrii Nakryiko, as well as from
numerous on-list discussions, at least some of which are captured in the
"Link:" tags on the patches themselves.

The patches in this series are as follows, with asterisks indicating
significant change from v3:

1*.	Add comments marking transitions between RCU watching and not.

2*.	rcu-tasks: Use context-switch hook for PREEMPT=y kernels.

3.	sched/core: Add function to sample state of locked-down task.

4.	Add per-task state to RCU CPU stall warnings.

5.	rcu-tasks: Move Tasks RCU to its own file.

6.	rcu-tasks: Create struct to hold state information.

7.	Reinstate synchronize_rcu_mult().

8.	Add a test for synchronize_rcu_mult().

9.	rcu-tasks: Refactor RCU-tasks to allow variants to be added.

10.	rcu-tasks: Add an RCU-tasks rude variant.

11.	Add torture tests for RCU Tasks Rude.

12.	rcu-tasks: Use unique names for RCU-Tasks kthreads and messages.

13.	rcu-tasks: Further refactor RCU-tasks to allow adding more variants.

14.	rcu-tasks: Code movement to allow more Tasks RCU variants.

15.	rcu-tasks: Add an RCU Tasks Trace to simplify protection of
	tracing hooks.

16.	Add torture tests for RCU Tasks Trace.

17.	rcu-tasks: Add stall warnings for RCU Tasks Trace.

18.	rcu-tasks: Move #ifdef into tasks.h.

19.	rcu-tasks: Add RCU tasks to rcutorture writer stall output.

20.	rcu-tasks: Make rcutorture writer stall output include GP state.

21.	rcu-tasks: Make RCU Tasks Trace make use of RCU scheduler hooks.

22.	rcu-tasks: Add a grace-period start time for throttling and debug.

23.	rcu-tasks: Provide boot parameter to delay IPIs until late in
	grace period.

24.	rcu-tasks: Split ->trc_reader_need_end.

25.	rcu-tasks: Add grace-period and IPI counts to statistics.

26.	rcu-tasks: Add Kconfig option to mediate smp_mb() vs. IPI.

27.	rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built.

28.	rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks.

29.	rcu-tasks: Disable CPU hotplug across RCU tasks trace scans.

30.	rcu-tasks: Handle the running-offline idle-task special case.

31.	rcu-tasks: Make RCU tasks trace also wait for idle tasks.

32.	rcu-tasks: Add rcu_dynticks_zero_in_eqs() effectiveness statistics.

33.	rcu-tasks: Add count for idle tasks on offline CPUs.

34.	Add TRACE02 scenario enabling RCU Tasks Trace IPIs.

35.	rcu-tasks: Add IPI failure count to statistics.

36*.	rcu-tasks: Allow standalone use of TASKS_{TRACE_,}RCU.

37*.	Use synchronize_rcu_tasks_rude() instead of ftrace_sync().

38*.	Don't acquire lock in NMI handler in rcu_nmi_enter_common().

This code has passed serious rcutorture testing.  It should therefore
be ready for production use (famous last words!).

Changes since v3:

o	Fix #ifdef issues preventing standalone use of RCU tasks rude.

o	Apply RCU tasks rude to ftrace.

o	Added commit enabling the RCU-tasks context-switch hook for
	PREEMPT=y kernels.

o	Prevent rcu_nmi_enter_common() from acquiring locks within NMI
	handlers.  (Added due to inter-commit dependencies.)

o	Comment the transitions between RCU watching and not.  (Also added
	due ot inter-commit dependencies.)

Changes since v2:

o	Leveraged idle entry/exit hooks to reduce IPIing of idle and
	userspace tasks.

o	Switch to read-side memory barriers during idle and userspace
	execution in kernels built for real-time or battery-powered use,
	mediated by a new TASKS_TRACE_RCU_READ_MB Kconfig option.  Also
	add an rcutorture test scenario for this option.

o	Adjust rcutorture to better test the IPI path.  (Seeing zero IPIs
	might be satisfying to me personally, but it is a lousy test
	strategy!)

o	Added more information to stall warnings and rcutorture
	end-of-test printout.

o	Make rcu_read_unlock_trace() usable when invoked with
	scheduler locks held.

o	Make rcu_read_unlock_trace() usable in interrupt and NMI
	handlers.

o	Fix handling of idle tasks, including those "running" on
	offline CPUs.

o	Fixed a number of other bugs found during testing and responded
	to review feedback.

Changes since v1:

o	Updated this cover letter to provide more detail, including
	on roads not taken.

o	Updated commit logs based on feedback from v1.

o	Updated the function providing a consistent view of the
	specified non-running task's state to invoke the specified
	function even if the task is currently running.  This will
	be necessary to safely eliminate IPIs for long-term idle and
	userspace execution.  The function may also now return false
	to transmit a failure indication to the caller, for example,
	if the function cannot handle being invoked on a running CPU.
	The function is now passed the relevant task_struct pointer as
	well as the specified argument.

	Changes were of course made to use the new API.

o	Leveraged context-switch hooks to avoid unnecessary IPIs.

o	Held off IPIs for the first half second (by default) of each
	grace period to give the context-switch hooks a better chance
	to do their job.

o	Lots of testing.

o	Fixed a number of bugs and responded to v2 feedback.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt             |    7 
 include/linux/rcupdate.h                                    |   53 
 include/linux/rcupdate_trace.h                              |   98 
 include/linux/rcupdate_wait.h                               |   19 
 include/linux/rcutiny.h                                     |    2 
 include/linux/sched.h                                       |   12 
 include/linux/wait.h                                        |    2 
 init/init_task.c                                            |    5 
 kernel/fork.c                                               |    5 
 kernel/rcu/Kconfig                                          |   50 
 kernel/rcu/Kconfig.debug                                    |    4 
 kernel/rcu/rcu.h                                            |    5 
 kernel/rcu/rcutorture.c                                     |   84 
 kernel/rcu/tasks.h                                          | 2143 +++++++++---
 kernel/rcu/tree.c                                           |   55 
 kernel/rcu/tree.h                                           |    2 
 kernel/rcu/tree_plugin.h                                    |   26 
 kernel/rcu/tree_stall.h                                     |   40 
 kernel/rcu/update.c                                         |  375 --
 kernel/sched/core.c                                         |   48 
 kernel/trace/Kconfig                                        |    1 
 kernel/trace/ftrace.c                                       |   17 
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST       |    3 
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01       |   10 
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot  |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01      |   11 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02      |   11 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot |    1 
 29 files changed, 2193 insertions(+), 898 deletions(-)
