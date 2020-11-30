Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98256C64E7B
	for <rcu@archiver.kernel.org>; Mon, 30 Nov 2020 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D5220709
	for <rcu@archiver.kernel.org>; Mon, 30 Nov 2020 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti0uX6Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgK3Tka (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Nov 2020 14:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbgK3Tk3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Nov 2020 14:40:29 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F6820709;
        Mon, 30 Nov 2020 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606765188;
        bh=BWcYsJPYjLHPBXxuOJgo/q65lIh28JQBq6wuw8SzUgw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ti0uX6Ibl0e/PzdlzWVffXK3KCO8tUcKV3Ic2gpiV/sL5ah7pzM3WSP3Mj4YgINe7
         ql2vsWdLcEAt6act5voW+WVOPyB1mdbfqcWnl09cspo8w+ZyLXHtveX3Igziwqq0tZ
         jKj9CtoUAJRebGNFtGATrIpuoGEpVUnDPUnGMIAI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 121173522B57; Mon, 30 Nov 2020 11:39:48 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:39:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     tglx@linutronix.de, stern@rowland.harvard.edu,
        anna-maria@linutronix.de, b00073877@aus.edu, unixbhaskar@gmail.com,
        foxhlchen@gmail.com, frederic@kernel.org, houtao1@huawei.com,
        sh_def@163.com, kuba@kernel.org, joe@perches.com,
        joel@joelfernandes.org, elver@google.com,
        mchehab+huawei@kernel.org, neeraju@codeaurora.org,
        peterz@infradead.org, sam.hernandez.amador@gmail.com,
        urezki@gmail.com, zhouzhouyi@gmail.com, chao@eero.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.11
Message-ID: <20201130193948.GA21812@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Ingo!

This pull request contains changes for RCU, KCSAN, and LKMM.  You can pull
the group using branch for-mingo.  Or, if you prefer, you can pull them
separately, using for-mingo-rcu to pull the RCU changes, for-mingo-kcsan
to pull the KCSAN changes, and for-mingo-lkmm to pull the LKMM changes.

The changes are as follows:

1.	RCU updates (for-mingo-rcu):

	a.	Avoid cpuinfo-induced IPI pileups and idle-CPU IPIs.

	b.	Documentation updates.

	c.	Miscellaneous fixes.  These include a long-awaited fix
		for that bug reported by Sebastian Andrzej Siewior, which
		has been since pulled into mainline.  (But mentioned
		here in case you thought that I had forgotten about it.)

	d.	Lockdep-RCU updates reducing the need for __maybe_unused.

	e.	Tasks-RCU updates.

	f.	Torture-test updates.

2.	KCSAN updates (for-mingo-kcsan) for selftests, avoiding setting
	watchpoints on NULL pointers, and a fix to watchpoint encoding.

3.	LKMM updates (for-mingo-lkmm) for documentation along with some
	updates to example-code litmus tests.

All of the commits in this pull request have been subjected to subjected
to the kbuild test robot and -next testing, and are available in the
git repository based on 5.10-rc1 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 50df51d12c3175573de9c94968639bdd625ec549:

  Merge branch 'lkmm.2020.11.06a' into HEAD (2020-11-19 19:38:53 -0800)

----------------------------------------------------------------
Alan Stern (1):
      tools: memory-model: Document that the LKMM can easily miss control dependencies

Anna-Maria Behnsen (1):
      tools/rcutorture: Fix BUG parsing of console.log

Asif Rasheed (1):
      list.h: Update comment to explicitly note circular lists

Bhaskar Chowdhury (1):
      tools/nolibc:  Fix a spelling error in a comment

Fox Chen (1):
      docs/memory-barriers.txt: Fix a typo in CPU MEMORY BARRIERS section

Frederic Weisbecker (1):
      rcu: Implement rcu_segcblist_is_offloaded() config dependent

Hou Tao (2):
      locktorture: Ignore nreaders_stress if no readlock support
      locktorture: Invoke percpu_free_rwsem() to do percpu-rwsem cleanup

Hui Su (1):
      docs/rcu: Update the call_rcu() API

Jakub Kicinski (7):
      sched: Un-hide lockdep_tasklist_lock_is_held() for !LOCKDEP
      rcu: Un-hide lockdep maps for !LOCKDEP
      net: Un-hide lockdep_sock_is_held() for !LOCKDEP
      net: sched: Remove broken definitions and un-hide for !LOCKDEP
      srcu: Use a more appropriate lockdep helper
      lockdep: Provide dummy forward declaration of *_is_held() helpers
      rcu: Prevent RCU_LOCKDEP_WARN() from swallowing the condition

Joe Perches (1):
      rcu/tree: Make struct kernel_param_ops definitions const

Joel Fernandes (Google) (3):
      docs: Update RCU's hotplug requirements with a bit about design
      rcu/tree: Add a warning if CPU being onlined did not report QS already
      rcu/tree: nocb: Avoid raising softirq for offloaded ready-to-execute CBs

Marco Elver (3):
      kcsan: selftest: Ensure that address is at least PAGE_SIZE
      kcsan: Never set up watchpoints on NULL pointers
      kcsan: Fix encoding masks and regain address bit

Mauro Carvalho Chehab (1):
      docs: RCU: Requirements.rst: Fix a list block

Neeraj Upadhyay (2):
      rcu: Fix single-CPU check in rcu_blocking_is_gp()
      rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config

Paul E. McKenney (44):
      tools/memory-model: Move Documentation description to Documentation/README
      doc: Present the role of READ_ONCE()
      rcutorture: Make preemptible TRACE02 enable lockdep
      rcu-tasks: Convert rcu_tasks_wait_gp() for-loop to while-loop
      rcutorture: Make grace-period kthread report match RCU flavor being tested
      refscale: Bounds-check module parameters
      torture: Don't kill gdb sessions
      x86/cpu: Avoid cpuinfo-induced IPI pileups
      x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs
      locktorture: Track time of last ->writeunlock()
      torture: Periodically pause in stutter_wait()
      torture: Make torture_stutter() use hrtimer
      scftorture: Add an alternative IPI vector
      rcuscale: Add RCU Tasks Trace
      rcuscale: Avoid divide by zero
      torture: Exclude "NOHZ tick-stop error" from fatal errors
      rcuscale: Prevent hangs for invalid arguments
      refscale: Prevent hangs for invalid arguments
      rcutorture: Adjust scenarios SRCU-t and SRCU-u to make kconfig happy
      locktorture: Prevent hangs for invalid arguments
      torture: Prevent jitter processes from delaying failed run
      rcutorture: Prevent hangs for invalid arguments
      torture: Force weak-hashed pointers on console log
      rcutorture:  Make stutter_wait() caller restore priority
      torture: Accept time units on kvm.sh --duration argument
      rcutorture: Small code cleanups
      torture: Allow alternative forms of kvm.sh command-line arguments
      scftorture: Add full-test stutter capability
      rcutorture: Don't do need_resched() testing if ->sync is NULL
      torture: Make kvm-check-branches.sh use --allcpus
      rcu-tasks: Make the units of ->init_fract be jiffies
      tools/memory-model: Document categories of ordering primitives
      tools/memory-model: Add a glossary of LKMM terms
      tools/memory-model: Add types to litmus tests
      tools/memory-model: Use "buf" and "flag" for message-passing tests
      tools/memory-model: Label MP tests' producers and consumers
      rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
      x86/smpboot:  Move rcu_cpu_starting() earlier
      rcu: Prevent lockdep-RCU splats on lock acquisition/release
      rcu: Do not report strict GPs for outgoing CPUs
      srcu: Take early exit on memory-allocation failure
      Merge branches 'cpuinfo.2020.11.06a', 'doc.2020.11.06a', 'fixes.2020.11.19b', 'lockdep.2020.11.02a', 'tasks.2020.11.06a' and 'torture.2020.11.06a' into HEAD
      Merge branch 'kcsan.2020.11.06a' into HEAD
      Merge branch 'lkmm.2020.11.06a' into HEAD

Peter Zijlstra (2):
      rcu: Allow rcu_irq_enter_check_tick() from NMI
      rcu,ftrace: Fix ftrace recursion

Samuel Hernandez (1):
      rcutorture/nolibc: Fix a typo in header file

Uladzislau Rezki (Sony) (1):
      rcu/tree: Defer kvfree_rcu() allocation to a clean context

Zhouyi Zhou (1):
      rcu: Fix a typo in rcu_blocking_is_gp() header comment

chao (1):
      rcu: Panic after fixed number of stalls

 .../RCU/Design/Requirements/Requirements.rst       |  50 +-
 Documentation/RCU/checklist.rst                    |   7 +
 Documentation/RCU/rcu_dereference.rst              |   6 +
 Documentation/RCU/whatisRCU.rst                    |   3 +-
 Documentation/memory-barriers.txt                  |   2 +-
 arch/x86/kernel/cpu/aperfmperf.c                   |  16 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c                    |   2 -
 arch/x86/kernel/smpboot.c                          |   1 +
 include/linux/kernel.h                             |   1 +
 include/linux/list.h                               |   2 +-
 include/linux/lockdep.h                            |   6 +
 include/linux/rcupdate.h                           |  11 +-
 include/linux/rcupdate_trace.h                     |   4 +-
 include/linux/rcutiny.h                            |   2 +
 include/linux/rcutree.h                            |   1 +
 include/linux/sched/task.h                         |   2 -
 include/net/sch_generic.h                          |  12 -
 include/net/sock.h                                 |   2 -
 kernel/kcsan/encoding.h                            |  20 +-
 kernel/kcsan/selftest.c                            |   3 +
 kernel/locking/locktorture.c                       |  36 +-
 kernel/rcu/Kconfig                                 |  20 +-
 kernel/rcu/rcu.h                                   |  16 +
 kernel/rcu/rcu_segcblist.h                         |   2 +-
 kernel/rcu/rcuscale.c                              |  37 +-
 kernel/rcu/rcutorture.c                            |  52 +-
 kernel/rcu/refscale.c                              |  11 +-
 kernel/rcu/srcutree.c                              |   6 +-
 kernel/rcu/tasks.h                                 |  49 +-
 kernel/rcu/tree.c                                  | 200 +++++---
 kernel/rcu/tree.h                                  |   2 +
 kernel/rcu/tree_plugin.h                           |   2 +-
 kernel/rcu/tree_stall.h                            |  28 +-
 kernel/scftorture.c                                |  49 +-
 kernel/sysctl.c                                    |  11 +
 kernel/torture.c                                   |  34 +-
 tools/include/nolibc/nolibc.h                      |   4 +-
 tools/memory-model/Documentation/README            |  76 +++
 .../Documentation/control-dependencies.txt         | 258 ++++++++++
 tools/memory-model/Documentation/glossary.txt      | 172 +++++++
 tools/memory-model/Documentation/litmus-tests.txt  |  17 +
 tools/memory-model/Documentation/ordering.txt      | 556 +++++++++++++++++++++
 tools/memory-model/README                          |  22 +-
 .../litmus-tests/CoRR+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoRW+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoWR+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoWW+poonceonce.litmus            |   4 +-
 .../IRIW+fencembonceonces+OnceOnce.litmus          |   5 +-
 .../litmus-tests/IRIW+poonceonces+OnceOnce.litmus  |   5 +-
 .../ISA2+pooncelock+pooncelock+pombonce.litmus     |   7 +-
 .../litmus-tests/ISA2+poonceonces.litmus           |   6 +-
 ...cerelease+poacquirerelease+poacquireonce.litmus |   6 +-
 .../LB+fencembonceonce+ctrlonceonce.litmus         |   5 +-
 .../LB+poacquireonce+pooncerelease.litmus          |   5 +-
 .../litmus-tests/LB+poonceonces.litmus             |   5 +-
 .../MP+fencewmbonceonce+fencermbonceonce.litmus    |  19 +-
 .../litmus-tests/MP+onceassign+derefonce.litmus    |  15 +-
 .../MP+polockmbonce+poacquiresilsil.litmus         |   8 +-
 .../MP+polockonce+poacquiresilsil.litmus           |   8 +-
 tools/memory-model/litmus-tests/MP+polocks.litmus  |  20 +-
 .../litmus-tests/MP+poonceonces.litmus             |  19 +-
 .../MP+pooncerelease+poacquireonce.litmus          |  19 +-
 .../memory-model/litmus-tests/MP+porevlocks.litmus |  20 +-
 .../litmus-tests/R+fencembonceonces.litmus         |   5 +-
 .../memory-model/litmus-tests/R+poonceonces.litmus |   5 +-
 .../S+fencewmbonceonce+poacquireonce.litmus        |   5 +-
 .../memory-model/litmus-tests/S+poonceonces.litmus |   5 +-
 .../litmus-tests/SB+fencembonceonces.litmus        |   5 +-
 .../litmus-tests/SB+poonceonces.litmus             |   5 +-
 .../litmus-tests/SB+rfionceonce-poonceonces.litmus |   5 +-
 .../litmus-tests/WRC+poonceonces+Once.litmus       |   5 +-
 .../WRC+pooncerelease+fencermbonceonce+Once.litmus |   5 +-
 .../Z6.0+pooncelock+poonceLock+pombonce.litmus     |   7 +-
 .../Z6.0+pooncelock+pooncelock+pombonce.litmus     |   7 +-
 ...release+poacquirerelease+fencembonceonce.litmus |   6 +-
 .../selftests/rcutorture/bin/console-badness.sh    |   3 +-
 .../testing/selftests/rcutorture/bin/functions.sh  |   1 +
 .../selftests/rcutorture/bin/kvm-check-branches.sh |   5 +-
 .../rcutorture/bin/kvm-recheck-rcuscale.sh         |   2 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  19 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  29 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   2 +-
 .../selftests/rcutorture/configs/rcu/SRCU-t        |   3 +-
 .../selftests/rcutorture/configs/rcu/SRCU-u        |   3 +-
 .../selftests/rcutorture/configs/rcu/TRACE01       |   6 +-
 .../selftests/rcutorture/configs/rcu/TRACE02       |   6 +-
 .../selftests/rcutorture/configs/rcuscale/CFcommon |   3 +
 .../selftests/rcutorture/configs/rcuscale/TRACE01  |  15 +
 .../rcutorture/configs/rcuscale/TRACE01.boot       |   1 +
 89 files changed, 1839 insertions(+), 325 deletions(-)
 create mode 100644 tools/memory-model/Documentation/README
 create mode 100644 tools/memory-model/Documentation/control-dependencies.txt
 create mode 100644 tools/memory-model/Documentation/glossary.txt
 create mode 100644 tools/memory-model/Documentation/ordering.txt
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
