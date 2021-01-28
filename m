Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2082DC433E6
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D7264D99
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 01:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhA1BQi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 27 Jan 2021 20:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231469AbhA1BGU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 27 Jan 2021 20:06:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7063161492;
        Thu, 28 Jan 2021 01:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611795877;
        bh=BjkrDH+dXmUmh6iw8omprF8cTWR/vYfwapmMn+1Lzas=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=bHRtFzICT/n8Dpp6qZksx8bqmBoKTvloo0J94ISaczttSdstNJvXqQ/rSm9xHjCEk
         oDSKOR4NCcKNRrwFSn1Uxzj1+dEXZyGWb3Ou+r09AkTVw6YuZaEGjHInVPfIfwadPh
         tpbW0bB5SYtsYRlKMmgzdnXF8jHgfgz9knlc6WCGMIZPmH3cHcDK70+NaE3Mbm8gFr
         /8+HlNOq69X2dib8lMsKOTsnn0hUyfZ6H7OlIVs/7gflyDSZtzQDlJmDTURLvMILvr
         E7km7I37ZqFlgtcedHoZk+QI4OCgtb9CW1EAAjAfLniUKYc100cYLIZ2zypxsx+KIm
         qa1JUsYNNgEyw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0F25B352260C; Wed, 27 Jan 2021 17:04:37 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:04:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     akiyks@gmail.com, bigeasy@linutronix.de, elver@google.com,
        frederic@kernel.org, joel@joelfernandes.org, julia@ni.com,
        mchehab+huawei@kernel.org, neeraju@codeaurora.org,
        paul.gortmaker@windriver.com, peterz@infradead.org,
        qiang.zhang@windriver.com, swood@redhat.com, urezki@gmail.com,
        w@1wt.eu, wangqing@vivo.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kernel-team@fb.com, tglx@linutronix.de
Subject: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.12
Message-ID: <20210128010437.GA32221@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Ingo!

This pull request contains changes for RCU, KCSAN, LKMM, and nolibc.
You can pull the entire group using branch for-mingo.  Or, if you prefer,
you can pull them separately, using for-mingo-rcu to pull the RCU changes,
for-mingo-kcsan to pull the KCSAN changes, for-mingo-lkmm to pull the
LKMM changes, and for-mingo-nolibc to pull the noclib changes.

The changes are as follows:

1.	RCU updates (for-mingo-rcu):

	a.	Documentation updates.
		https://lore.kernel.org/lkml/20210106005334.GA12159@paulmck-ThinkPad-P72/

	b.	Miscellaneous fixes.
		https://lore.kernel.org/lkml/20210106005713.GA12492@paulmck-ThinkPad-P72/

	c.	kfree_rcu() updates from Uladzislau Rezki.
		https://lore.kernel.org/lkml/20210106010102.GA12737@paulmck-ThinkPad-P72/

	d.	Addition of mem_dump_obj() to provide allocator return
		addresses to more easily locate bugs.  This has a
		couple of RCU-related commits, but is mostly MM.  I am
		including it here because Andrew Morton pulled them in,
		but then removed them stating that they were already in
		a maintainer tree, namely -rcu.
		https://lore.kernel.org/lkml/20210106011603.GA13180@paulmck-ThinkPad-P72/

	e.	Per-callback-batch tracking of numbers of callbacks,
		which enables better debugging information and smarter
		reactions to large numbers of callbacks.
		https://lore.kernel.org/lkml/20210106012541.GA13972@paulmck-ThinkPad-P72/

	f.	The first round of Frederic Weisbecker's changes to allow
		CPUs to be runtime switched from and to callback-offloaded
		state.
		https://lore.kernel.org/lkml/20210106013950.GA14663@paulmck-ThinkPad-P72/

	g.	CONFIG_PREEMPT_RT-related changes.
		https://lore.kernel.org/lkml/20210106164746.GA19969@paulmck-ThinkPad-P72/

	h.	RCU CPU stall warning updates.
		https://lore.kernel.org/lkml/20210106165210.GA20296@paulmck-ThinkPad-P72/

	i.	Addition of polling grace-period APIs for SRCU, requested
		by Kent Overstreet.
		https://lore.kernel.org/lkml/20210106165511.GA20555@paulmck-ThinkPad-P72/

	j.	Torture-test and torture-test scripting updates, including
		a "torture everything" script that runs rcutorture,
		locktorture, scftorture, rcuscale, and refscale.
		Plus does a allmodconfig built.
		https://lore.kernel.org/lkml/20210106171532.GA20769@paulmck-ThinkPad-P72/
		https://lore.kernel.org/lkml/20210106172547.GA22404@paulmck-ThinkPad-P72/
		https://lore.kernel.org/lkml/20210106173056.GA23035@paulmck-ThinkPad-P72/

2.	Kernel concurrency sanitizer (KCSAN) updates from Marco Elver.
	https://lore.kernel.org/lkml/20210106173323.GA23292@paulmck-ThinkPad-P72/

3.	Linux-kernel memory model (LKMM) updates.
	https://lore.kernel.org/lkml/20210106173548.GA23664@paulmck-ThinkPad-P72/

4.	Fixes to nolibc that allows it to run once again on ARMv8.
	https://lore.kernel.org/lkml/20210121072031.23777-1-w@1wt.eu/

All of the commits in this pull request have been subjected to subjected
to the kbuild test robot and -next testing, and are available in the
git repository based on v5.11-rc1 and v5.11-rc3 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to c8c430f4a2fb91b9804ed2f749364fc0dcd663fe:

  Merge branch 'nolibc.2021.01.21a' into HEAD (2021-01-22 15:28:38 -0800)

----------------------------------------------------------------
Akira Yokosawa (2):
      tools/memory-model: Remove redundant initialization in litmus tests
      tools/memory-model: Fix typo in klitmus7 compatibility table

Frederic Weisbecker (17):
      tools/rcutorture: Make identify_qemu_vcpus() independent of local language
      rcu/nocb: Turn enabled/offload states into a common flag
      rcu/nocb: Provide basic callback offloading state machine bits
      rcu/nocb: Always init segcblist on CPU up
      rcu/nocb: De-offloading CB kthread
      rcu/nocb: Don't deoffload an offline CPU with pending work
      rcu/nocb: De-offloading GP kthread
      rcu/nocb: Re-offload support
      rcu/nocb: Shutdown nocb timer on de-offloading
      rcu/nocb: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
      rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
      rcu/nocb: Only cond_resched() from actual offloaded batch processing
      rcu/nocb: Process batch locally as long as offloading isn't complete
      rcu/nocb: Locally accelerate callbacks as long as offloading isn't complete
      cpu/hotplug: Add lockdep_is_cpus_held()
      timer: Add timer_curr_running()
      tools/rcutorture: Support nocb toggle in TREE01

Joel Fernandes (Google) (6):
      rcu/tree: Make rcu_do_batch count how many callbacks were executed
      rcu/segcblist: Add additional comments to explain smp_mb()
      rcu/segcblist: Add counters to segcblist datastructure
      rcu/tree: segcblist: Remove redundant smp_mb()s
      rcu/trace: Add tracing for how segcb list changes
      rcu/segcblist: Add debug checks for segment lengths

Julia Cartwright (1):
      rcu: Enable rcu_normal_after_boot unconditionally for RT

Marco Elver (2):
      kcsan: Rewrite kcsan_prandom_u32_max() without prandom_u32_state()
      random32: Re-enable KCSAN instrumentation

Mauro Carvalho Chehab (1):
      list: Fix a typo at the kernel-doc markup

Neeraj Upadhyay (1):
      rcu: Check and report missed fqs timer wakeup on RCU stall

Paul E. McKenney (88):
      docs: Remove redundant "``" from Requirements.rst
      doc: Remove obsolete RCU-bh and RCU-sched update-side API members
      doc: Update RCU requirements RCU_INIT_POINTER() description
      doc: Remove obsolete rcutree.rcu_idle_lazy_gp_delay boot parameter
      srcu: Make Tiny SRCU use multi-bit grace-period counter
      srcu: Provide internal interface to start a Tiny SRCU grace period
      srcu: Provide internal interface to start a Tree SRCU grace period
      srcu: Provide polling interfaces for Tiny SRCU grace periods
      srcu: Provide polling interfaces for Tree SRCU grace periods
      srcu: Document polling interfaces for Tree SRCU grace periods
      srcu: Add comment explaining cookie overflow/wrap
      rcutorture: Prepare for ->start_gp_poll and ->poll_gp_state
      rcutorture: Add writer-side tests of polling grace-period API
      rcutorture: Add reader-side tests of polling grace-period API
      rcutorture: Add testing for RCU's global memory ordering
      scftorture: Add debug output for wrong-CPU warning
      rcu: Mark obtuse portion of stall warning as internal debug
      rcu: For RCU grace-period kthread starvation, dump last CPU it ran on
      rcu: Do not NMI offline CPUs
      torture: Make --kcsan specify lockdep
      torture: Make kvm.sh "--dryrun sched" summarize number of batches
      torture: Make kvm.sh "--dryrun sched" summarize number of builds
      torture: Allow kvm.sh --datestamp to specify subdirectories
      torture: Prepare for splitting qemu execution from kvm-test-1-run.sh
      torture: Add config2csv.sh script to compare torture scenarios
      torture: Make kvm.sh "Test Summary" date be end of test
      torture: Make kvm.sh arguments accumulate
      torture: Print run duration at end of kvm.sh execution
      torture: Make kvm.sh return failure upon build failure
      torture: Make kvm.sh include --kconfig arguments in CPU calculation
      torture: Add kvm.sh test summary to end of log file
      torture: Stop hanging on panic
      torture: Add --dryrun batches to help schedule a distributed run
      torture: s/STOP/STOP.1/ to avoid scenario collision
      torture: Simplify exit-code plumbing for kvm-recheck.sh and kvm-find-errors.sh
      torture: Remove "Failed to add ttynull console" false positive
      torture: Allow standalone kvm-recheck.sh run detect --trust-make
      tools/memory-model: Tie acquire loads to reads-from
      rcu: Add lockdep_assert_irqs_disabled() to rcu_sched_clock_irq() and callees
      rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
      rcu: Make TASKS_TRACE_RCU select IRQ_WORK
      torture: Do Kconfig analysis only once per scenario
      rcutorture: Test runtime toggling of CPUs' callback offloading
      rcu/nocb: Add grace period and task state to show_rcu_nocb_state() output
      rcu/nocb: Add nocb CB kthread list to show_rcu_nocb_state() output
      rcu/nocb: Code-style nits in callback-offloading toggling
      rcu: Do any deferred nocb wakeups at CPU offline time
      torture: Add torture.sh torture-everything script
      torture: Make torture.sh use common time-duration bash functions
      torture: Remove use of "eval" in torture.sh
      torture: Add "make allmodconfig" to torture.sh
      torture: Auto-size SCF and scaling runs based on number of CPUs
      torture: Enable torture.sh argument checking
      torture: Make torture.sh rcuscale and refscale deal with allmodconfig
      torture: Make torture.sh refscale runs use verbose_batched module parameter
      torture: Create doyesno helper function for torture.sh
      torture: Make torture.sh allmodconfig retain and label output
      torture: Make torture.sh throttle VERBOSE_TOROUT_*() for refscale
      torture: Make torture.sh refuse to do zero-length runs
      torture: Drop log.long generation from torture.sh
      torture: Allow scenarios to be specified to torture.sh
      torture: Add command and results directory to torture.sh log
      torture: Add --kcsan-kmake-arg to torture.sh for KCSAN
      torture: Compress KASAN vmlinux files
      refscale: Allow summarization of verbose output
      rcutorture: Require entire stutter period be post-boot
      rcutorture: Make synctype[] and nsynctype be static global
      rcutorture: Make rcu_torture_fakewriter() use blocking wait primitives
      torture: Add fuzzed hrtimer-based sleep functions
      rcutorture: Use torture_hrtimeout_jiffies() to avoid busy-waits
      torture: Make stutter use torture_hrtimeout_*() functions
      rcutorture: Use hrtimers for reader and writer delays
      torture: Make refscale throttle high-rate printk()s
      torture: Throttle VERBOSE_TOROUT_*() output
      rcutorture: Make object_debug also double call_rcu() heap object
      torture: Clean up after torture-test CPU hotplugging
      torture: Maintain torture-specific set of CPUs-online books
      rcutorture: Add rcutree.use_softirq=0 to RUDE01 and TASKS01
      mm: Add mem_dump_obj() to print source of memory block
      mm: Make mem_dump_obj() handle NULL and zero-sized pointers
      mm: Make mem_dump_obj() handle vmalloc() memory
      mm: Make mem_obj_dump() vmalloc() dumps include start and length
      rcu: Make call_rcu() print mem_dump_obj() info for double-freed callback
      percpu_ref: Dump mem_dump_obj() info upon reference-count underflow
      Merge branches 'doc.2021.01.06a', 'fixes.2021.01.04b', 'kfree_rcu.2021.01.04a', 'mmdumpobj.2021.01.22a', 'nocb.2021.01.06a', 'rt.2021.01.04a', 'stall.2021.01.06a', 'torture.2021.01.12a' and 'tortureall.2021.01.06a' into HEAD
      Merge branch 'kcsan.2021.01.04a' into HEAD
      Merge branch 'lkmm.2021.01.04a' into HEAD
      Merge branch 'nolibc.2021.01.21a' into HEAD

Paul Gortmaker (1):
      docs: Fix typos and drop/fix dead links in RCU documentation

Peter Zijlstra (1):
      sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled

Scott Wood (1):
      rcu: Unconditionally use rcuc threads on PREEMPT_RT

Sebastian Andrzej Siewior (3):
      rcu: Make RCU_BOOST default on CONFIG_PREEMPT_RT
      doc: Update RCU's requirements page about the PREEMPT_RT wiki
      doc: Use CONFIG_PREEMPTION

Uladzislau Rezki (Sony) (3):
      rcu: Introduce kfree_rcu() single-argument macro
      rcu: Eliminate the __kvfree_rcu() macro
      rcu-tasks: Add RCU-tasks self tests

Wang Qing (1):
      locking: Remove duplicate include of percpu-rwsem.h

Willy Tarreau (10):
      tools/nolibc: Add the definition for dup()
      tools/nolibc: Make dup2() rely on dup3() when available
      tools/nolibc: Make getpgrp() fall back to getpgid(0)
      tools/nolibc: Implement fork() based on clone()
      tools/nolibc: Implement poll() based on ppoll()
      tools/nolibc: Get timeval, timespec and timezone from linux/time.h
      tools/nolibc: Remove incorrect definitions of __ARCH_WANT_*
      tools/nolibc: Emit detailed error for missing alternate syscall number definitions
      tools/nolibc: Fix position of -lgcc in the documented example
      tools/rcutorture: Fix position of -lgcc in mkinitrd.sh

Zqiang (1):
      rcu: Record kvfree_call_rcu() call stack for KASAN

 .../Expedited-Grace-Periods.rst                    |   4 +-
 .../RCU/Design/Requirements/Requirements.rst       | 732 +++++++++++----------
 Documentation/RCU/checklist.rst                    |  10 +-
 Documentation/RCU/rcubarrier.rst                   |   6 +-
 Documentation/RCU/stallwarn.rst                    |  27 +-
 Documentation/RCU/whatisRCU.rst                    |  10 +-
 Documentation/admin-guide/kernel-parameters.txt    |  39 +-
 include/linux/cpu.h                                |   2 +
 include/linux/list.h                               |   2 +-
 include/linux/mm.h                                 |   2 +
 include/linux/rcu_segcblist.h                      | 120 +++-
 include/linux/rcupdate.h                           |  42 +-
 include/linux/slab.h                               |   2 +
 include/linux/srcu.h                               |   3 +
 include/linux/srcutiny.h                           |   7 +-
 include/linux/timer.h                              |   2 +
 include/linux/torture.h                            |  27 +-
 include/linux/vmalloc.h                            |   6 +
 include/trace/events/rcu.h                         |  26 +
 kernel/cpu.c                                       |   7 +
 kernel/kcsan/core.c                                |  26 +-
 kernel/locking/locktorture.c                       |   1 -
 kernel/rcu/Kconfig                                 |   5 +-
 kernel/rcu/rcu.h                                   |  16 +-
 kernel/rcu/rcu_segcblist.c                         | 216 ++++--
 kernel/rcu/rcu_segcblist.h                         |  57 +-
 kernel/rcu/rcutorture.c                            | 395 +++++++++--
 kernel/rcu/refscale.c                              |  23 +-
 kernel/rcu/srcutiny.c                              |  77 ++-
 kernel/rcu/srcutree.c                              | 147 ++++-
 kernel/rcu/tasks.h                                 |  79 +++
 kernel/rcu/tree.c                                  | 101 ++-
 kernel/rcu/tree.h                                  |   2 +
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_plugin.h                           | 367 ++++++++++-
 kernel/rcu/tree_stall.h                            |  60 +-
 kernel/rcu/update.c                                |   4 +-
 kernel/scftorture.c                                |   6 +-
 kernel/sched/core.c                                |   9 +-
 kernel/time/timer.c                                |  14 +
 kernel/torture.c                                   | 167 ++++-
 lib/Makefile                                       |   3 -
 lib/percpu-refcount.c                              |  12 +-
 mm/slab.c                                          |  20 +
 mm/slab.h                                          |  12 +
 mm/slab_common.c                                   |  75 +++
 mm/slob.c                                          |   6 +
 mm/slub.c                                          |  40 ++
 mm/util.c                                          |  31 +
 mm/vmalloc.c                                       |  13 +
 tools/include/nolibc/nolibc.h                      | 153 +++--
 tools/memory-model/Documentation/glossary.txt      |  12 +-
 tools/memory-model/README                          |   2 +-
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
 .../MP+fencewmbonceonce+fencermbonceonce.litmus    |   5 +-
 .../litmus-tests/MP+onceassign+derefonce.litmus    |   4 +-
 .../MP+polockmbonce+poacquiresilsil.litmus         |   5 +-
 .../MP+polockonce+poacquiresilsil.litmus           |   5 +-
 tools/memory-model/litmus-tests/MP+polocks.litmus  |   6 +-
 .../litmus-tests/MP+poonceonces.litmus             |   5 +-
 .../MP+pooncerelease+poacquireonce.litmus          |   5 +-
 .../memory-model/litmus-tests/MP+porevlocks.litmus |   6 +-
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
 .../testing/selftests/rcutorture/bin/config2csv.sh |  67 ++
 .../selftests/rcutorture/bin/console-badness.sh    |   1 +
 .../testing/selftests/rcutorture/bin/functions.sh  |  36 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   9 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   3 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  12 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 103 ++-
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |   2 +-
 .../selftests/rcutorture/bin/parse-build.sh        |   2 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   2 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  | 442 +++++++++++++
 .../selftests/rcutorture/configs/rcu/RUDE01.boot   |   1 +
 .../selftests/rcutorture/configs/rcu/TASKS01.boot  |   1 +
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |   4 +-
 99 files changed, 3163 insertions(+), 917 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/config2csv.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/torture.sh
