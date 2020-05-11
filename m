Return-Path: <SRS0=Rnls=6Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27325C47255
	for <rcu@archiver.kernel.org>; Mon, 11 May 2020 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04AA620746
	for <rcu@archiver.kernel.org>; Mon, 11 May 2020 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589211849;
	bh=XQZ4bTetd/fEUJV+XnMbIowvtB5da1w3aAqHnAGU8c0=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=clByAM9pKx7Q98MiTqtApQ7Hmzu4z/EtcYcTwqS5cMKOhEI35L35zn2rK+BfxhU5Y
	 rsa5L/XTLih2sFhzE8en087eCjOetYsErj1nj0oIOi/CVjVqKOYCBpS13xx9KPAlLR
	 280R0r5Fbfd4BW3Faroh+EarCs1SwZVXADXywqTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgEKPoI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 May 2020 11:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgEKPoI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 May 2020 11:44:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD632206A3;
        Mon, 11 May 2020 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589211846;
        bh=XQZ4bTetd/fEUJV+XnMbIowvtB5da1w3aAqHnAGU8c0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=MLqDZakSYs62ZPuIZdkUfcpRX9x9SmZmITSckPBAOmUgYYWJ+stI3msZLLOCWXoeZ
         MReq5d0k1wS7QuCmt2vb3etQdAG7uL5Eu7hvc2FZ8dg+SO7mX0lQqmgdVA/m5eMv+n
         lZ7s9ASHMmU7a3K7WpQwKQjD/AKSK9+b3nHh2XaU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5C42135226DF; Mon, 11 May 2020 08:44:06 -0700 (PDT)
Date:   Mon, 11 May 2020 08:44:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-team@vger.kernel.org, jbi.octave@gmail.com,
        j.neuschaefer@gmx.net, joel@joelfernandes.org,
        laijs@linux.alibaba.com, mchehab+huawei@kernel.org,
        rdunlap@infradead.org, yanaijie@huawei.com, zhangzl2013@126.com
Subject: [GIT PULL tip/core/rcu] RCU commits for v5.8
Message-ID: <20200511154406.GA32144@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This pull request contains the following changes:

1.	Miscellaneous fixes.

	https://lore.kernel.org/lkml/20200415171017.GA7821@paulmck-ThinkPad-P72

2.	kfree_rcu() updates.

	https://lore.kernel.org/lkml/20200415171924.GA9270@paulmck-ThinkPad-P72

3.	Remove scheduler locking restriction

	https://lore.kernel.org/lkml/20200415175543.GA10416@paulmck-ThinkPad-P72

4.	RCU-tasks update, including addition of RCU Tasks Trace for
	BPF use and RCU Tasks Rude.  (This branch is on top of #3 due
	to overlap of changed code.)

	https://lore.kernel.org/lkml/20200415181856.GA11037@paulmck-ThinkPad-P72

5.	RCU CPU stall warning updates.

	https://lore.kernel.org/lkml/20200415172341.GA9519@paulmck-ThinkPad-P72

6.	Torture-test updates.

	https://lore.kernel.org/lkml/20200415173037.GA9768@paulmck-ThinkPad-P72

All of these have been subjected to the kbuild test robot and -next
testing, and are available in the git repository based on v5.7-rc2 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to f736e0f1a55a88cb258b73da77463573739e9ac9:

  Merge branches 'fixes.2020.04.27a', 'kfree_rcu.2020.04.27a', 'rcu-tasks.2020.04.27a', 'stall.2020.04.27a' and 'torture.2020.05.07a' into HEAD (2020-05-07 10:18:32 -0700)

----------------------------------------------------------------
Jason Yan (1):
      rcutorture: Make rcu_fwds and rcu_fwd_emergency_stop static

Joel Fernandes (Google) (3):
      rcuperf: Add ability to increase object allocation size
      rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu() batching
      rcu/tree: Count number of batched kfree_rcu() locklessly

Jonathan Neuschäfer (1):
      Revert "rculist: Describe variadic macro argument in a Sphinx-compatible way"

Jules Irenge (2):
      rcu: Replace assigned pointer ret value by corresponding boolean value
      rcu: Replace 1 by true

Lai Jiangshan (3):
      rcu: Don't set nesting depth negative in rcu_preempt_deferred_qs()
      rcu: Remove unused ->rcu_read_unlock_special.b.deferred_qs field
      rcu: Don't use negative nesting depth in __rcu_read_unlock()

Mauro Carvalho Chehab (1):
      rcu: Get rid of some doc warnings in update.c

Paul E. McKenney (74):
      rcu: Add KCSAN stubs
      srcu: Add KCSAN stubs
      rcu: Mark rcu_state.ncpus to detect concurrent writes
      rcu: Add *_ONCE() and data_race() to rcu_node ->exp_tasks plus locking
      rcu: Add READ_ONCE and data_race() to rcu_node ->boost_tasks
      srcu: Add data_race() to ->srcu_lock_count and ->srcu_unlock_count arrays
      rcu: Add WRITE_ONCE() to rcu_node ->boost_tasks
      rcu: Use data_race() for RCU CPU stall-warning prints
      drm: Make drm_dp_mst_dsc_aux_for_port() safe for old compilers
      rcu: Expedite first two FQS scans under callback-overload conditions
      rcu: Mark rcu_state.gp_seq to detect more concurrent writes
      rcu: Convert ULONG_CMP_GE() to time_after() for jiffy comparison
      rcu: Convert rcu_initiate_boost() ULONG_CMP_GE() to time_after()
      rcu: Convert rcu_nohz_full_cpu() ULONG_CMP_LT() to time_before()
      rcu: Add rcu_gp_might_be_stalled()
      rcu: Add KCSAN stubs to update.c
      rcu: Make rcu_read_unlock_special() safe for rq/pi locks
      rcutorture: Add test of holding scheduler locks across rcu_read_unlock()
      rcu: Add comments marking transitions between RCU watching and not
      rcu-tasks: Use context-switch hook for PREEMPT=y kernels
      sched/core: Add function to sample state of locked-down task
      rcu: Add per-task state to RCU CPU stall warnings
      rcu-tasks: Move Tasks RCU to its own file
      rcu-tasks: Create struct to hold state information
      rcu: Reinstate synchronize_rcu_mult()
      rcutorture: Add a test for synchronize_rcu_mult()
      rcu-tasks: Refactor RCU-tasks to allow variants to be added
      rcu-tasks: Add an RCU-tasks rude variant
      rcutorture: Add torture tests for RCU Tasks Rude
      rcu-tasks: Use unique names for RCU-Tasks kthreads and messages
      rcu-tasks: Further refactor RCU-tasks to allow adding more variants
      rcu-tasks: Code movement to allow more Tasks RCU variants
      rcu-tasks: Add an RCU Tasks Trace to simplify protection of tracing hooks
      rcutorture: Add torture tests for RCU Tasks Trace
      rcu-tasks: Add stall warnings for RCU Tasks Trace
      rcu-tasks: Move #ifdef into tasks.h
      rcu-tasks: Add RCU tasks to rcutorture writer stall output
      rcu-tasks: Make rcutorture writer stall output include GP state
      rcu-tasks: Make RCU Tasks Trace make use of RCU scheduler hooks
      rcu-tasks: Add a grace-period start time for throttling and debug
      rcu-tasks: Provide boot parameter to delay IPIs until late in grace period
      rcu-tasks: Split ->trc_reader_need_end
      rcu-tasks: Add grace-period and IPI counts to statistics
      rcu-tasks: Add Kconfig option to mediate smp_mb() vs. IPI
      rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built
      rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
      rcu-tasks: Disable CPU hotplug across RCU tasks trace scans
      rcu-tasks: Handle the running-offline idle-task special case
      rcu-tasks: Make RCU tasks trace also wait for idle tasks
      rcu-tasks: Add rcu_dynticks_zero_in_eqs() effectiveness statistics
      rcu-tasks: Add count for idle tasks on offline CPUs
      rcutorture: Add TRACE02 scenario enabling RCU Tasks Trace IPIs
      rcu-tasks: Add IPI failure count to statistics
      rcu-tasks: Allow standalone use of TASKS_{TRACE_,}RCU
      ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()
      rcu: Use data_race() for RCU expedited CPU stall-warning prints
      rcu: When GP kthread is starved, tag idle threads as false positives
      rcu: Remove self-stack-trace when all quiescent states seen
      rcutorture: Add KCSAN stubs
      rcutorture: Make kvm-recheck-rcu.sh handle truncated lines
      rcutorture: Mark data-race potential for rcu_barrier() test statistics
      rcutorture: Add flag to produce non-busy-wait task stalls
      rcutorture: Right-size TREE10 CPU consumption
      rcu: Allow rcutorture to starve grace-period kthread
      torture: Add --kcsan argument to top-level kvm.sh script
      torture: Make --kcsan argument also create a summary
      torture: Eliminate duplicate #CHECK# from ConfigFragment
      torture: Abstract application of additional Kconfig options
      torture: Allow --kconfig options to override --kcsan defaults
      torture: Allow scenario-specific Kconfig options to override CFcommon
      torture: Save a few lines by using config_override_param initially
      torture: Add a --kasan argument
      rcutorture: Convert ULONG_CMP_LT() to time_before()
      Merge branches 'fixes.2020.04.27a', 'kfree_rcu.2020.04.27a', 'rcu-tasks.2020.04.27a', 'stall.2020.04.27a' and 'torture.2020.05.07a' into HEAD

Randy Dunlap (1):
      locktorture.c: Fix if-statement empty body warnings

Zhaolong Zhang (1):
      rcu: Fix the (t=0 jiffies) false positive

 .../RCU/Design/Requirements/Requirements.rst       |   61 +-
 Documentation/admin-guide/kernel-parameters.txt    |   19 +
 drivers/gpu/drm/drm_dp_mst_topology.c              |    2 +-
 include/linux/rculist.h                            |    4 +-
 include/linux/rcupdate.h                           |   53 +-
 include/linux/rcupdate_trace.h                     |   88 ++
 include/linux/rcupdate_wait.h                      |   19 +
 include/linux/rcutiny.h                            |    3 +-
 include/linux/rcutree.h                            |    1 +
 include/linux/sched.h                              |   10 +-
 include/linux/torture.h                            |    2 +-
 include/linux/wait.h                               |    2 +
 init/init_task.c                                   |    5 +
 kernel/fork.c                                      |    5 +
 kernel/rcu/Kconfig                                 |   46 +-
 kernel/rcu/Kconfig.debug                           |    4 +
 kernel/rcu/rcu.h                                   |    7 +
 kernel/rcu/rcuperf.c                               |    5 +-
 kernel/rcu/rcutorture.c                            |  155 ++-
 kernel/rcu/srcutree.c                              |   21 +-
 kernel/rcu/tasks.h                                 | 1193 ++++++++++++++++++++
 kernel/rcu/tree.c                                  |  179 ++-
 kernel/rcu/tree.h                                  |    3 +
 kernel/rcu/tree_exp.h                              |   50 +-
 kernel/rcu/tree_plugin.h                           |   86 +-
 kernel/rcu/tree_stall.h                            |  144 ++-
 kernel/rcu/update.c                                |  394 +------
 kernel/sched/core.c                                |   48 +
 kernel/trace/Kconfig                               |    1 +
 kernel/trace/ftrace.c                              |   17 +-
 .../selftests/rcutorture/bin/kcsan-collapse.sh     |   22 +
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |   16 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |    9 +
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |   52 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   11 +
 .../selftests/rcutorture/configs/rcu/CFLIST        |    3 +
 .../selftests/rcutorture/configs/rcu/RUDE01        |   10 +
 .../selftests/rcutorture/configs/rcu/RUDE01.boot   |    1 +
 .../selftests/rcutorture/configs/rcu/TRACE01       |   11 +
 .../selftests/rcutorture/configs/rcu/TRACE01.boot  |    1 +
 .../selftests/rcutorture/configs/rcu/TRACE02       |   11 +
 .../selftests/rcutorture/configs/rcu/TRACE02.boot  |    1 +
 .../selftests/rcutorture/configs/rcu/TREE10        |    2 +-
 43 files changed, 2156 insertions(+), 621 deletions(-)
 create mode 100644 include/linux/rcupdate_trace.h
 create mode 100644 kernel/rcu/tasks.h
 create mode 100755 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/RUDE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
