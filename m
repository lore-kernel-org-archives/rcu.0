Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B20C4332D
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A03220767
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576625;
	bh=vkH/uBpyOPFdlnW8XBVDmFvXyn1F4pEchT6CoAHsPZA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=R1LoUtEGeClqf5EZMcF1zFCN05Cly+o4tcGCbNs0MQEvzh+aWc0GHNIPR3GxpxOJw
	 tMXrWjvmlQqvJVaypeDtLC9hOjZV7Hxp9TgcIrYGyrbJq6JNxxJx4e3KkdS6lx4Vh4
	 G07RolQ1fG7jMYmIZWCebRW9v1LM/qP5EDBq+I/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCSAKZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSAKY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:10:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D2F20752;
        Thu, 19 Mar 2020 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576624;
        bh=vkH/uBpyOPFdlnW8XBVDmFvXyn1F4pEchT6CoAHsPZA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a89rhbLZYXZc4gAS+g9S4e4UmbbAZHGSicjcCqUEPqd88+ZYN2se/P9kMBeMMvqdB
         5gvs+G0xtRBan9YOFcrMczJ6PCVu/Z4ZrcthBrg6swL1b/H9W6ZI3/b/8E1pgMdHuP
         ATt6hObTN9FvLnT4aQ8aVnF72O/gOcg7DXphpKVc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 16852352275A; Wed, 18 Mar 2020 17:10:24 -0700 (PDT)
Date:   Wed, 18 Mar 2020 17:10:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH RFC v2 tip/core/rcu 0/22] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides two variants of Tasks RCU, a rude variant inspired
by Steven Rostedt's use of schedule_on_each_cpu(), and a tracing variant
requested by the BPF folks and perhaps also of use for other tracing
use cases.

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

There are of course downsides.  The grace-period code can send IPIs to
CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
However, this version enlists the aid of the context-switch hooks,
which eliminates the need for IPIs in context-switch-heavy workloads.
It also prohibits sending of IPIs early in the grace period, which
provides additional opportunity for the hooks to do their job.  Additional
IPI-reduction mechanisms are under development.

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
task-by-task approach that is needed.  It is in theory possible to
mash RCU tasks trace into the Tree SRCU implementation, but there
will need to be extremely good reasons for doing so.

This effort benefited greatly from off-list discussions of BPF
requirements with Alexei Starovoitov and Andrii Nakryiko, as well as from
numerous on-list discussions, at least some of which are captured in the
"Link:" tags on the patches themselves.

The patches in this series are as follows, with asterisks indicating
significant change from v1:

1*.	Add function to sample state of a locked-down task.  I would
	still guess that the API is still subject to change.  ;-)

2*.	Use the above function to add per-task state to RCU CPU stall
	warnings.  This commit was adapted to the new API.

3.	Add rcutorture module parameter to produce non-busy-wait task
	stalls, thus allowing the above RCU CPU stall change to be
	exercised.

4.	Move Tasks RCU to its own file.

5.	Create struct to hold RCU-tasks state information.

6.	Reinstate synchronize_rcu_mult(), as there will likely once
	again be a need to wait on multiple flavors of RCU.

7.	Add an rcutorture test for synchronize_rcu_mult().

8.	Refactor RCU-tasks to allow variants to be added.

9.	Add an RCU-tasks rude variant, based on Steven Rostedt's
	use of schedule_on_each_cpu().

10.	Add torture tests for RCU Tasks Rude.

11.	Use unique names for RCU-Tasks kthreads and messages.

12.	Further refactor RCU-tasks to allow adding even more variants.

13.	Code movement to allow even more Tasks RCU variants.

14*.	Add an RCU Tasks Trace to simplify protection of tracing hooks,
	including BPF.  This version fixes a number of bugs and adapts
	to the new lockdown-task API.

15.	Add torture tests for RCU Tasks Trace.

16.	Add stall warnings for RCU Tasks Trace.

17*.	Move #ifdef into tasks.h to ease addition of Kconfig-dependent APIs.

18*.	Add RCU-tasks-specific information to rcutorture writer stall
	output, easing debugging of these RCU variants.

19*.	Make the above rcutorture writer stall output include
	grace-period state.

20*.	Cause RCU tasks trace to take advantage of RCU scheduler hooks,
	thus reducing the number of IPIs.

21*.	Record grace-period start time for RCU tasks variants for
	IPI throttling and for debugging.

22*.	Provide a kernel boot parameter to delay IPIs until a given grace
	period reaches the specified age, with this age defaulting to
	half a second, further reducing the number of IPIs.  To zero on
	context-switch-heavy workloads.

These new versions of Tasks RCU now pass heavy rcutorture testing,
and should thus be fine for experimental use.

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

o	Fixed a number of bugs.

Todo:

o	Leverage idle entry/exit hooks to reduce IPIing of idle tasks.

o	Switch to read-side memory barriers during idle and userspace
	execution in kernels built for real-time or battery-powered use.
	As currently planned, nohz_full CPUs would be IPIed only during
	long-running loops in the kernel (as in more than half a second
	of such execution by default).

	Although this does add a branch to rcu_read_lock_trace() in
	kernels built to take this approach, the check involves only
	a cache-hot byte.  However, rcu_read_unlock_trace() executes
	the same sequence of instructions as before in the case where
	no memory barrier is required even in kernels built to take
	this approach.

o	Context-switch hooks and delayed IPIs could potentially also be
	applied to reduce the IPI intensity of RCU-tasks rude, but I do
	not yet know of any reason to do this.  If you believe that this
	is needed, please let me know.

o	Lots more testing.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt             |   12 
 include/linux/rcupdate.h                                    |   48 
 include/linux/rcupdate_trace.h                              |   84 
 include/linux/rcupdate_wait.h                               |   19 
 include/linux/rcutiny.h                                     |    2 
 include/linux/sched.h                                       |    8 
 include/linux/wait.h                                        |    2 
 init/init_task.c                                            |    4 
 kernel/fork.c                                               |    4 
 kernel/rcu/Kconfig                                          |   34 
 kernel/rcu/Kconfig.debug                                    |    4 
 kernel/rcu/rcu.h                                            |    3 
 kernel/rcu/rcutorture.c                                     |   99 
 kernel/rcu/tasks.h                                          | 1925 +++++++++---
 kernel/rcu/tree_plugin.h                                    |    6 
 kernel/rcu/tree_stall.h                                     |   40 
 kernel/rcu/update.c                                         |  374 --
 kernel/sched/core.c                                         |   48 
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST       |    2 
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01       |   10 
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot  |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01      |   10 
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot |    1 
 23 files changed, 1926 insertions(+), 814 deletions(-)
