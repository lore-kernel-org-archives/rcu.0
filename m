Return-Path: <SRS0=gxlL=AZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E71C433DF
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 17:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B293A22519
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594747623;
	bh=zftzRFW56Uz2UhoHBNV9X5R5uepJrxyztoOfkOo2fbM=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=DgXnJgqdNzCz59YshuSrZY+0OCh7Pv2Il2sg6wubwPgNxd39kv0pXgVYYgp9AXq6v
	 1eUz0Yhb9XEW0Onn8c+GUR/2+4aLTs4v7EQZzHB/xaYVqiqt+opTZgPVfzb7jVSR9v
	 EOoSBjyinzX+9Q7GC5iDMEC4NCDJtxjB5QBXHrow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGNR1D (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgGNR1C (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jul 2020 13:27:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9396222518;
        Tue, 14 Jul 2020 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594747621;
        bh=zftzRFW56Uz2UhoHBNV9X5R5uepJrxyztoOfkOo2fbM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=dxEPSdM/5J4lbH0XPb/hELxTAVH6Eo6vyaNii/AWR5O+G6cXp68L1mtOYT6o23h2I
         kho2GvVb8zAlYl6yf7yjXkWDVrz4WPJU0pEpsp/om+J52G2Y/o3NcRoEyvZr9OI/6X
         EI9ZM/00sHFJUiL2XPzm8Ip6L2y3y+BPEoyPqbZQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 721C4352262C; Tue, 14 Jul 2020 10:27:01 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:27:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org, arnd@arndb.de,
        bigeasy@linutronix.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, paulmck@kernel.org,
        peter.enderborg@sony.com, rdunlap@infradead.org,
        richard.weiyang@linux.alibaba.com, urezki@gmail.com,
        zou_wei@huawei.com, tglx@linutronix.de
Subject: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200714172701.GA31369@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Ingo!

This pull request contains the following changes:

1.	Documentation updates.

	https://lore.kernel.org/lkml/20200623000923.GA25047@paulmck-ThinkPad-P72

2.	Miscellaneous fixes.

	https://lore.kernel.org/lkml/20200623002128.GA25456@paulmck-ThinkPad-P72

3.	kfree_rcu updates.

	https://lore.kernel.org/lkml/20200624201200.GA28901@paulmck-ThinkPad-P72

4.	RCU tasks updates.

	https://lore.kernel.org/lkml/20200623002423.GA25869@paulmck-ThinkPad-P72

5.	Read-side scalability tests.

	https://lore.kernel.org/lkml/20200623002941.GA26089@paulmck-ThinkPad-P72

6.	SRCU updates.

	https://lore.kernel.org/lkml/20200623003310.GA26539@paulmck-ThinkPad-P72

7.	Torture-test updates.

	https://lore.kernel.org/lkml/20200623003731.GA26717@paulmck-ThinkPad-P72

All of these have been subjected to the kbuild test robot and -next
testing, and are available in the git repository based on v5.8-rc3 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 13625c0a4074d3bab61b1dc70a828b574255f339:

  Merge branches 'doc.2020.06.29a', 'fixes.2020.06.29a', 'kfree_rcu.2020.06.29a', 'rcu-tasks.2020.06.29a', 'scale.2020.06.29a', 'srcu.2020.06.29a' and 'torture.2020.06.29a' into HEAD (2020-06-29 12:03:15 -0700)

----------------------------------------------------------------
Arnd Bergmann (1):
      refperf: Work around 64-bit division

Ethon Paul (1):
      srcu: Fix a typo in comment "amoritized"->"amortized"

Frederic Weisbecker (1):
      tick/nohz: Narrow down noise while setting current task's tick dependency

Joel Fernandes (Google) (5):
      rcu/tree: Keep kfree_rcu() awake during lock contention
      rcu/tree: Skip entry into the page allocator for PREEMPT_RT
      rcu/tree: Make debug_objects logic independent of rcu_head
      rcuperf: Remove useless while loops around wait_event
      refperf: Add a test to measure performance of read-side synchronization

Jules Irenge (2):
      rcu: Replace 1 with true
      rcu/rcutorture: Replace 0 with false

Lihao Liang (1):
      rcu: Update comment from rsp->rcu_gp_seq to rsp->gp_seq

Madhuparna Bhowmik (1):
      trace: events: rcu: Change description of rcu_dyntick trace event

Marco Elver (1):
      torture: Pass --kmake-arg to all make invocations

Mauro Carvalho Chehab (10):
      docs: RCU: Convert checklist.txt to ReST
      docs: RCU: Convert lockdep-splat.txt to ReST
      docs: RCU: Convert lockdep.txt to ReST
      docs: RCU: Convert rculist_nulls.txt to ReST
      docs: RCU: Convert torture.txt to ReST
      docs: RCU: Convert rcuref.txt to ReST
      docs: RCU: Convert stallwarn.txt to ReST
      docs: RCU: Don't duplicate chapter names in rculist_nulls.rst
      rcu: Fix some kernel-doc warnings
      rcu: Fix a kernel-doc warnings for "count"

Paul E. McKenney (65):
      doc: Timer problems can cause RCU CPU stall warnings
      doc: Tasks RCU must protect instructions before trampoline
      mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls
      rcu: Add callbacks-invoked counters
      rcu: Add comment documenting rcu_callback_map's purpose
      rcu: Grace-period-kthread related sleeps to idle priority
      rcu: Priority-boost-related sleeps to idle priority
      rcu: No-CBs-related sleeps to idle priority
      rcu: Expedited grace-period sleeps to idle priority
      fs/btrfs: Add cond_resched() for try_release_extent_mapping() stalls
      rcu: Remove initialized but unused rnp from check_slow_task()
      rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr
      lockdep: Complain only once about RCU in extended quiescent state
      rcu-tasks: Convert sleeps to idle priority
      rcu-tasks: Make rcu_tasks_postscan() be static
      rcu-tasks: Add #include of rcupdate_trace.h to update.c
      rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()
      rcu-tasks: Fix code-style issues
      rcuperf: Add comments explaining the high reader overhead
      torture: Add refperf to the rcutorture scripting
      refperf: Add holdoff parameter to allow CPUs to come online
      refperf: Hoist function-pointer calls out of the loop
      refperf: Allow decimal nanoseconds
      refperf: Convert nreaders to a module parameter
      refperf: Provide module parameter to specify number of experiments
      refperf: Dynamically allocate experiment-summary output buffer
      refperf: Dynamically allocate thread-summary output buffer
      refperf: Make functions static
      refperf: Tune reader measurement interval
      refperf: Convert reader_task structure's "start" field to int
      refperf: More closely synchronize reader start times
      refperf: Add warmup and cooldown processing phases
      refperf: Label experiment-number column "Runs"
      refperf: Output per-experiment data points
      refperf: Simplify initialization-time wakeup protocol
      refperf: Add read-side delay module parameter
      refperf: Adjust refperf.loop default value
      doc: Document rcuperf's module parameters
      refperf: Change readdelay module parameter to nanoseconds
      refperf: Add test for RCU Tasks Trace readers.
      refperf: Add test for RCU Tasks readers
      rcu-tasks: Fix synchronize_rcu_tasks_trace() header comment
      refperf: Rename RCU_REF_PERF_TEST to RCU_REF_SCALE_TEST
      refperf: Rename refperf.c to refscale.c and change internal names
      refscale: Change --torture type from refperf to refscale
      torture:  Remove qemu dependency on EFI firmware
      torture: Add script to smoke-test commits in a branch
      rcutorture: Add races with task-exit processing
      torture: Set configfile variable to current scenario
      rcutorture: Handle non-statistic bang-string error messages
      rcutorture: NULL rcu_torture_current earlier in cleanup code
      torture: Remove whitespace from identify_qemu_vcpus output
      torture: Add --allcpus argument to the kvm.sh script
      torture: Create qemu-cmd in --buildonly runs
      torture: Add a stop-run capability
      torture: Abstract out console-log error detection
      rcutorture: Check for unwatched readers
      torture: Correctly summarize build-only runs
      torture: Improve diagnostic for KCSAN-incapable compilers
      torture: Add more tracing crib notes to kvm.sh
      torture: Add kvm-tranform.sh script for qemu-cmd files
      torture: Dump ftrace at shutdown only if requested
      torture: Avoid duplicate specification of qemu command
      torture: Remove obsolete "cd $KVM"
      Merge branches 'doc.2020.06.29a', 'fixes.2020.06.29a', 'kfree_rcu.2020.06.29a', 'rcu-tasks.2020.06.29a', 'scale.2020.06.29a', 'srcu.2020.06.29a' and 'torture.2020.06.29a' into HEAD

Peter Enderborg (1):
      rcu: Stop shrinker loop

Randy Dunlap (1):
      kernel/rcu/tree.c: Fix kernel-doc warnings

Sebastian Andrzej Siewior (2):
      rcu/tree: Use static initializer for krc.lock
      srcu: Avoid local_irq_save() before acquiring spinlock_t

Uladzislau Rezki (Sony) (12):
      rcu/tree: Repeat the monitor if any free channel is busy
      rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
      rcu/tree: Move kfree_rcu_cpu locking/unlocking to separate functions
      rcu/tree: cache specified number of objects
      rcu/tree: Maintain separate array for vmalloc ptrs
      rcu/tiny: support vmalloc in tiny-RCU
      rcu: Rename *_kfree_callback/*_kfree_rcu_offset/kfree_call_*
      mm/list_lru.c: Rename kvfree_rcu() to local variant
      rcu: Introduce 2 arg kvfree_rcu() interface
      rcu: Support reclaim for head-less object
      rcu: Introduce single argument kvfree_rcu() interface
      lib/test_vmalloc.c: Add test cases for kvfree_rcu()

Wei Yang (5):
      rcu: Initialize and destroy rcu_synchronize only when necessary
      rcu: Simplify the calculation of rcu_state.ncpus
      rcu: gp_max is protected by root rcu_node's lock
      rcu: grplo/grphi just records CPU number
      rcu: grpnum just records group number

Zou Wei (1):
      locktorture: Use true and false to assign to bool variables

 .../RCU/Design/Requirements/Requirements.rst       |   7 +-
 Documentation/RCU/{checklist.txt => checklist.rst} |  17 +-
 Documentation/RCU/index.rst                        |   9 +
 .../RCU/{lockdep-splat.txt => lockdep-splat.rst}   | 109 ++--
 Documentation/RCU/{lockdep.txt => lockdep.rst}     |  12 +-
 Documentation/RCU/rculist_nulls.rst                | 200 ++++++
 Documentation/RCU/rculist_nulls.txt                | 172 -----
 Documentation/RCU/{rcuref.txt => rcuref.rst}       | 199 +++---
 Documentation/RCU/{stallwarn.txt => stallwarn.rst} |  62 +-
 Documentation/RCU/{torture.txt => torture.rst}     | 117 ++--
 Documentation/admin-guide/kernel-parameters.txt    |  68 ++
 Documentation/locking/locktorture.rst              |   2 +-
 MAINTAINERS                                        |   4 +-
 fs/btrfs/extent_io.c                               |   2 +
 include/linux/rculist.h                            |   2 +-
 include/linux/rculist_nulls.h                      |   2 +-
 include/linux/rcupdate.h                           |  53 +-
 include/linux/rcupdate_trace.h                     |   4 +-
 include/linux/rcutiny.h                            |  20 +-
 include/linux/rcutree.h                            |   2 +-
 include/linux/torture.h                            |   5 +
 include/trace/events/rcu.h                         |  19 +-
 kernel/locking/lockdep.c                           |   4 +-
 kernel/locking/locktorture.c                       |  14 +-
 kernel/rcu/Kconfig.debug                           |  19 +
 kernel/rcu/Makefile                                |   1 +
 kernel/rcu/rcuperf.c                               |  25 +-
 kernel/rcu/rcutorture.c                            | 119 +++-
 kernel/rcu/refscale.c                              | 717 +++++++++++++++++++++
 kernel/rcu/srcutree.c                              |  16 +-
 kernel/rcu/tasks.h                                 |  37 +-
 kernel/rcu/tiny.c                                  |   7 +-
 kernel/rcu/tree.c                                  | 407 ++++++++----
 kernel/rcu/tree.h                                  |  15 +-
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_plugin.h                           |   4 +-
 kernel/rcu/tree_stall.h                            |   9 +-
 kernel/rcu/update.c                                |  16 +-
 kernel/time/tick-sched.c                           |  22 +-
 kernel/torture.c                                   |   6 +-
 lib/test_vmalloc.c                                 | 103 ++-
 mm/list_lru.c                                      |   6 +-
 mm/mmap.c                                          |   1 +
 net/core/sock.c                                    |   4 +-
 .../testing/selftests/rcutorture/bin/configinit.sh |   4 +-
 .../selftests/rcutorture/bin/console-badness.sh    |  16 +
 .../testing/selftests/rcutorture/bin/functions.sh  |  23 +-
 tools/testing/selftests/rcutorture/bin/jitter.sh   |   6 +
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   6 +
 .../selftests/rcutorture/bin/kvm-check-branches.sh | 108 ++++
 .../rcutorture/bin/kvm-recheck-refscale.sh         |  71 ++
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  20 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  27 +-
 .../selftests/rcutorture/bin/kvm-transform.sh      |  51 ++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  19 +-
 .../selftests/rcutorture/bin/parse-console.sh      |  27 +-
 .../selftests/rcutorture/configs/refscale/CFLIST   |   2 +
 .../selftests/rcutorture/configs/refscale/CFcommon |   2 +
 .../rcutorture/configs/refscale/NOPREEMPT          |  18 +
 .../selftests/rcutorture/configs/refscale/PREEMPT  |  18 +
 .../rcutorture/configs/refscale/ver_functions.sh   |  16 +
 61 files changed, 2395 insertions(+), 680 deletions(-)
 rename Documentation/RCU/{checklist.txt => checklist.rst} (98%)
 rename Documentation/RCU/{lockdep-splat.txt => lockdep-splat.rst} (54%)
 rename Documentation/RCU/{lockdep.txt => lockdep.rst} (96%)
 create mode 100644 Documentation/RCU/rculist_nulls.rst
 delete mode 100644 Documentation/RCU/rculist_nulls.txt
 rename Documentation/RCU/{rcuref.txt => rcuref.rst} (50%)
 rename Documentation/RCU/{stallwarn.txt => stallwarn.rst} (88%)
 rename Documentation/RCU/{torture.txt => torture.rst} (76%)
 create mode 100644 kernel/rcu/refscale.c
 create mode 100755 tools/testing/selftests/rcutorture/bin/console-badness.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-transform.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
