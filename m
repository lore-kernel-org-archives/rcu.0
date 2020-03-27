Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68FBC43331
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4822072F
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347828;
	bh=SY+0Q13cdiLCyweJl9Y4ZF897cLrmmwILPQHft8+ITw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=L37udMkZkHSv70Rlgyygr18bNPnUYcuTAUpN56Vuqo2UdqDevenaZ99vwlOOD3nYZ
	 mXji4ms0JdUZebDfX7dIHB+6r6bnJTT7hTGveH+t+hhKYBOQbQLhg96B6LdAO3xRkl
	 YlJjoXFwbg5ZiV5sCFkECQ94Pg1b+Xs+8ZhNhma4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgC0WXs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgC0WXs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 18:23:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C6E206DB;
        Fri, 27 Mar 2020 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347827;
        bh=SY+0Q13cdiLCyweJl9Y4ZF897cLrmmwILPQHft8+ITw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=grtF2meVq8NWC3HzSp4Xqd3Hft6LG4JWajJb09mvAUZy4rL6F65Zvg1D04ZfmgKCy
         S97/kP/BYuljczbbgxht3ZQWTyLXxcJcQLvCuuueGuFjNvMumy1BHe/0mwRLcZl1tP
         g1u+nKNuKx89PSjL4Dctkmsxv8vYDYcjpF5IT8TY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EE73D35226D5; Fri, 27 Mar 2020 15:23:46 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:23:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH RFC v3 tip/core/rcu 0/34] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200319001024.GA28798@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides two variants of Tasks RCU, a rude variant inspired
by Steven Rostedt's use of schedule_on_each_cpu(), and a tracing variant
requested by the BPF folks to be used (for example) to protect BPF
programs that unconditionally access userspace memory, and thus might
occasionally take a page fault, resulting in a voluntary context switch.

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
significant change from v1:

1*.	Add function to sample state of a locked-down task.  Added
	the task_struct argument to the callback function.

2*.	Use the above function to add per-task state to RCU CPU stall
	warnings.  This commit was adapted to the updated API.

3.	Add rcutorture module parameter to produce non-busy-wait task
	stalls, thus allowing the above RCU CPU stall change to be
	exercised.

4.	Move Tasks RCU to its own file.

5.	Create struct to hold RCU-tasks state information.

6.	Reinstate synchronize_rcu_mult(), as there will likely once
	again be a need to wait on multiple flavors of RCU.

7.	Add an rcutorture test for synchronize_rcu_mult().

8.	Refactor RCU-tasks to allow variants to be added.

9*.	Add an RCU-tasks rude variant, based on Steven Rostedt's
	use of schedule_on_each_cpu().  Updated Kconfig default
	to rely on default default value, updated help text, and
	updated the header comment.

10.	Add torture tests for RCU Tasks Rude.

11.	Use unique names for RCU-Tasks kthreads and messages.

12.	Further refactor RCU-tasks to allow adding even more variants.

13.	Code movement to allow even more Tasks RCU variants.

14*.	Add an RCU Tasks Trace to simplify protection of tracing hooks,
	including BPF.  This version fixes even more bugs and adds a
	URL to an email explaining the memory ordering.  It also updates
	the Kconfig default and updates the help text.  Furthermore, it
	moves a misplaced comment update.  Finally, it makes the
	rcu_read_unlock_trace() function safe for scheduler locks,
	interrupt handlers, and NMI handlers.

15.	Add torture tests for RCU Tasks Trace.

16.	Add stall warnings for RCU Tasks Trace.

17.	Move #ifdef into tasks.h to ease addition of Kconfig-dependent APIs.

18.	Add RCU-tasks-specific information to rcutorture writer stall
	output, easing debugging of these RCU variants.

19.	Make the above rcutorture writer stall output include
	grace-period state.

20.	Cause RCU tasks trace to take advantage of RCU scheduler hooks,
	thus reducing the number of IPIs.

21.	Record grace-period start time for RCU tasks variants for
	IPI throttling and for debugging.

22.	Provide a kernel boot parameter to delay IPIs until a given grace
	period reaches the specified age, with this age defaulting to
	half a second, further reducing the number of IPIs.  To zero on
	context-switch-heavy workloads.

23*.	Split ->trc_reader_need_end to make room for memory-barrier
	indication.

24*.	Add grace-period and IPI counts to statistics.

25*.	Add Kconfig option to mediate smp_mb() vs. IPI.

26*.	Avoid IPIing userspace/idle tasks if kernel is so built.

27*.	Allow rcu_read_unlock_trace() under scheduler locks.

28*.	Disable CPU hotplug across RCU tasks trace scans.  This enables
	detection of idle tasks for offline CPUs.

29*.	Handle the running-offline idle-task special case.

30*.	Make RCU tasks trace also wait for idle tasks.

31*.	Add rcu_dynticks_zero_in_eqs() effectiveness statistics.

32*.	Add count for idle tasks on offline CPUs.

33*.	Add TRACE02 scenario enabling RCU Tasks Trace IPIs.
	The existing TRACE01 scenario avoids IPIs to userspace
	and idle CPUs.

34*.	Add IPI failure count to statistics.

These new versions of Tasks RCU now pass heavy rcutorture testing, and
should thus be fine for experimental use.  The original Tree RCU went
upstream with less testing than this has seen, but then again those were
simpler times.  ;-)

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

Todo:

o	Even more testing.

o	If all goes well, post a non-RFC series.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt             |   12 
 include/linux/rcupdate.h                                    |   48 
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
 kernel/rcu/rcutorture.c                                     |   99 
 kernel/rcu/tasks.h                                          | 2089 +++++++++---
 kernel/rcu/tree.c                                           |   24 
 kernel/rcu/tree.h                                           |    2 
 kernel/rcu/tree_plugin.h                                    |   24 
 kernel/rcu/tree_stall.h                                     |   40 
 kernel/rcu/update.c                                         |  375 --
 kernel/sched/core.c                                         |   48 
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST       |    3 
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01       |   10 
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot  |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01      |   11 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02      |   11 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot |    1 
 27 files changed, 2140 insertions(+), 861 deletions(-)
