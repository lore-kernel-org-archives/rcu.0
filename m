Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC1C2ED;
	Sat, 14 Sep 2024 02:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726281941; cv=none; b=itYJYwuPiKUJPhk/3D7XXb4gNN3vcmvujeyRLykKSAwhA0/gHlw5fjEllnzhC2q4Y6dQXeaP9LgkJuar5ePzvmebIwHV1pMhjhqGhUha7yme8c1F/vMDAofHCFF4P8YCtDsc12NMpiYK5lW8hMOIEu+MkhyDKlp75btrKUXm/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726281941; c=relaxed/simple;
	bh=5AxYVcABsLCF+P51XGiSpMnYAUJ1kg68YBtA7JBt/Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y242cPa2iJ0pwxbgGEt5DHK+JqdGVHFhBkVZSm3Ui2o0NTfosNOSwc36CCiMo9ID2qgly40bN0gKu6OLBc3ucvN0eUWbQN1dA8VA0p4UeVB2eMklUc1z3+ezeBoVBCwhNB/8Mf5byh1mHR1TlMpAlHUHBVrvB4+b962OElagDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTE47Svt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTE47Svt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05799C4CEC0;
	Sat, 14 Sep 2024 02:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726281940;
	bh=5AxYVcABsLCF+P51XGiSpMnYAUJ1kg68YBtA7JBt/Lk=;
	h=Date:From:To:Cc:Subject:From;
	b=JTE47Svtr91dX2hBvWXi0dlbMlrvU6Ke2ILdn4UNMwp/ywHNUuHnJx/TYOdvymPcT
	 2ECXDuGDZkVH68udrGHnXQ5wf7DTBe4Vp/+ppOVlkJVZ+pHfHSQYhlKOCkeDQqPJvb
	 h54CQau+nnQkh9CMZh9cXLOv7jssGY1kEsb3i5gYEOnmJcGiwLom4mxQ6H5uRNNqFa
	 wJJ6EauGgxnps9CVFXH0fG5pyb2BzuBYG14ywnDmXe3WrfTV39r1y60uKr6V2SL6Wc
	 DkkBIKJuYDiqWQJ2u5yaqF/LX+gzC/1qmBjKOY8+OiB0ome7Kvgn3pAhrha06Aq5Yp
	 gdTyWvMzuIiiw==
Date: Sat, 14 Sep 2024 08:15:27 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: torvalds@linux-foundation.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com, neeraj.iitr10@gmail.com,
	christophe.jaillet@wanadoo.fr, inwardvessel@gmail.com,
	riel@surriel.com, takakura@valinux.co.jp, seanjc@google.com,
	thorsten.blum@toblux.com, vschneid@redhat.com, longman@redhat.com,
	zhouzhouyi@gmail.com, qiang.zhang1211@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Subject: [GIT PULL] RCU changes for v6.12
Message-ID: <20240914024527.GA492739@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

When the merge window opens, please pull this RCU update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.12

  # HEAD: 355debb83bf79853cde43579f88eed16adb1da29: Merge branches 'context_tracking.15.08.24a', 'csd.lock.15.08.24a', 'nocb.09.09.24a', 'rcutorture.14.08.24a', 'rcustall.09.09.24a', 'srcu.12.08.24a', 'rcu.tasks.14.08.24a', 'rcu_scaling_tests.15.08.24a', 'fixes.12.08.24a' and 'misc.11.08.24a' into next.09.09.24a (2024-09-09 00:09:47 +0530)


Following are the merge conflicts with other trees:

1. Merge conflicts with slab tree

Stephen's resolution: https://lore.kernel.org/lkml/20240812124748.3725011b@canb.auug.org.au/

In case you might want to refer to it, a sample tree with resolutions applied is at
git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git heads/rcu.v6.12.slab.tree.conflict_res


2. Merge conflict with kvm-fixes tree

Stephen's resolution: https://lore.kernel.org/lkml/20240905154122.4d1f8ca5@canb.auug.org.au/

In case you might want to refer to it, a sample tree with resolutions applied is at
git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git heads/rcu.v6.12.kvm-fixes.tree.conflict_res

----------------------------------------------------------------
RCU pull request for v6.12

This pull request contains the following branches:

context_tracking.15.08.24a: Rename context tracking state related
        symbols and remove references to "dynticks" in various context
        tracking state variables and related helpers; force
        context_tracking_enabled_this_cpu() to be inlined to avoid
        leaving a noinstr section.

csd.lock.15.08.24a: Enhance CSD-lock diagnostic reports; add an API
        to provide an indication of ongoing CSD-lock stall.

nocb.09.09.24a: Update and simplify RCU nocb code to handle
        (de-)offloading of callbacks only for offline CPUs; fix RT
        throttling hrtimer being armed from offline CPU.

rcutorture.14.08.24a: Remove redundant rcu_torture_ops get_gp_completed
        fields; add SRCU ->same_gp_state and ->get_comp_state
        functions; add generic test for NUM_ACTIVE_*RCU_POLL* for
        testing RCU and SRCU polled grace periods; add CFcommon.arch
        for arch-specific Kconfig options; print number of update types
        in rcu_torture_write_types();
        add rcutree.nohz_full_patience_delay testing to the TREE07
        scenario; add a stall_cpu_repeat module parameter to test
        repeated CPU stalls; add argument to limit number of CPUs a
        guest OS can use in torture.sh;

rcustall.09.09.24a: Abbreviate RCU CPU stall warnings during CSD-lock
        stalls; Allow dump_cpu_task() to be called without disabling
        preemption; defer printing stall-warning backtrace when holding
        rcu_node lock.

srcu.12.08.24a: Make SRCU gp seq wrap-around faster; add KCSAN checks
        for concurrent updates to ->srcu_n_exp_nodelay and
        ->reschedule_count which are used in heuristics governing
        auto-expediting of normal SRCU grace periods and
        grace-period-state-machine delays; mark idle SRCU-barrier
        callbacks to help identify stuck SRCU-barrier callback.

rcu.tasks.14.08.24a: Remove RCU Tasks Rude asynchronous APIs as they
        are no longer used; stop testing RCU Tasks Rude asynchronous
        APIs; fix access to non-existent percpu regions; check
        processor-ID assumptions during chosen CPU calculation for
        callback enqueuing; update description of rtp->tasks_gp_seq
        grace-period sequence number; add rcu_barrier_cb_is_done()
        to identify whether a given rcu_barrier callback is stuck;
        mark idle Tasks-RCU-barrier callbacks; add
        *torture_stats_print() functions to print detailed
        diagnostics for Tasks-RCU variants; capture start time of
        rcu_barrier_tasks*() operation to help distinguish a hung
        barrier operation from a long series of barrier operations.

rcu_scaling_tests.15.08.24a:
        refscale: Add a TINY scenario to support tests of Tiny RCU
        and Tiny SRCU; Optimize process_durations() operation;

        rcuscale: Dump stacks of stalled rcu_scale_writer() instances;
        dump grace-period statistics when rcu_scale_writer() stalls;
        mark idle RCU-barrier callbacks to identify stuck RCU-barrier
        callbacks; print detailed grace-period and barrier diagnostics
        on rcu_scale_writer() hangs for Tasks-RCU variants; warn if
        async module parameter is specified for RCU implementations
        that do not have async primitives such as RCU Tasks Rude;
        make all writer tasks report upon hang; tolerate repeated
        GFP_KERNEL failure in rcu_scale_writer(); use special allocator
        for rcu_scale_writer(); NULL out top-level pointers to heap
        memory to avoid double-free bugs on modprobe failures; maintain
        per-task instead of per-CPU callbacks count to avoid any issues
        with migration of either tasks or callbacks; constify struct
        ref_scale_ops.

fixes.12.08.24a: Use system_unbound_wq for kfree_rcu work to avoid
        disturbing isolated CPUs.

misc.11.08.24a: Warn on unexpected rcu_state.srs_done_tail state;
        Better define "atomic" for list_replace_rcu() and
        hlist_replace_rcu() routines; annotate struct
        kvfree_rcu_bulk_data with __counted_by().

----------------------------------------------------------------
Christophe JAILLET (2):
      refscale: Optimize process_durations()
      refscale: Constify struct ref_scale_ops

Frederic Weisbecker (14):
      rcu/nocb: Introduce RCU_NOCB_LOCKDEP_WARN()
      rcu/nocb: Move nocb field at the end of state struct
      rcu/nocb: Assert no callbacks while nocb kthread allocation fails
      rcu/nocb: Introduce nocb mutex
      rcu/nocb: (De-)offload callbacks on offline CPUs only
      rcu/nocb: Remove halfway (de-)offloading handling from bypass
      rcu/nocb: Remove halfway (de-)offloading handling from rcu_core()'s QS reporting
      rcu/nocb: Remove halfway (de-)offloading handling from rcu_core
      rcu/nocb: Remove SEGCBLIST_RCU_CORE
      rcu/nocb: Remove SEGCBLIST_KTHREAD_CB
      rcu/nocb: Simplify (de-)offloading state machine
      rcu/nocb: Fix RT throttling hrtimer armed from offline CPU
      rcu/nocb: Conditionally wake up rcuo if not already waiting on GP
      rcu/nocb: Remove superfluous memory barrier after bypass enqueue

JP Kobryn (1):
      srcu: faster gp seq wrap-around

Neeraj Upadhyay (1):
      Merge branches 'context_tracking.15.08.24a', 'csd.lock.15.08.24a', 'nocb.09.09.24a', 'rcutorture.14.08.24a', 'rcustall.09.09.24a', 'srcu.12.08.24a', 'rcu.tasks.14.08.24a', 'rcu_scaling_tests.15.08.24a', 'fixes.12.08.24a' and 'misc.11.08.24a' into next.09.09.24a

Paul E. McKenney (41):
      rcutorture: Remove redundant rcu_torture_ops get_gp_completed fields
      rcutorture: Add SRCU ->same_gp_state and ->get_comp_state functions
      rcutorture: Generic test for NUM_ACTIVE_*RCU_POLL*
      rcutorture: Make rcu_torture_write_types() print number of update types
      tools/rcu: Remove RCU Tasks Rude asynchronous APIs from rcu-updaters.sh
      rcu/kfree: Warn on unexpected tail state
      locking/csd_lock: Print large numbers as negatives
      rcu: Better define "atomic" for list replacement
      rcutorture: Add rcutree.nohz_full_patience_delay to TREE07
      srcu: Check for concurrent updates of heuristics
      srcu: Mark callbacks not currently participating in barrier operation
      rcutorture: Add a stall_cpu_repeat module parameter
      torture: Add torture.sh --guest-cpu-limit argument for limited hosts
      doc: Remove RCU Tasks Rude asynchronous APIs
      rcutorture: Stop testing RCU Tasks Rude asynchronous APIs
      rcuscale: Stop testing RCU Tasks Rude asynchronous APIs
      rcu-tasks: Remove RCU Tasks Rude asynchronous APIs
      rcu/tasks: Check processor-ID assumptions
      rcu/tasks: Update rtp->tasks_gp_seq comment
      rcu: Provide rcu_barrier_cb_is_done() to check rcu_barrier() CBs
      rcu/tasks: Mark callbacks not currently participating in barrier operation
      rcu/tasks: Add detailed grace-period and barrier diagnostics
      rcu/tasks: Add rcu_barrier_tasks*() start time to diagnostics
      refscale: Add TINY scenario
      rcuscale: Save a few lines with whitespace-only change
      rcuscale: Dump stacks of stalled rcu_scale_writer() instances
      rcuscale: Dump grace-period statistics when rcu_scale_writer() stalls
      rcu: Mark callbacks not currently participating in barrier operation
      rcuscale: Print detailed grace-period and barrier diagnostics
      locking/csd_lock: Provide an indication of ongoing CSD-lock stall
      locking/csd-lock: Use backoff for repeated reports of same incident
      rcu: Summarize RCU CPU stall warnings during CSD-lock stalls
      rcu: Extract synchronize_rcu_expedited_stall() from synchronize_rcu_expedited_wait()
      rcu: Summarize expedited RCU CPU stall warnings during CSD-lock stalls
      rcuscale: Provide clear error when async specified without primitives
      rcuscale: Make all writer tasks report upon hang
      rcuscale: Make rcu_scale_writer() tolerate repeated GFP_KERNEL failure
      rcuscale: Use special allocator for rcu_scale_writer()
      rcuscale: NULL out top-level pointers to heap memory
      rcuscale: Count outstanding callbacks per-task rather than per-CPU
      rcu: Defer printing stall-warning backtrace when holding rcu_node lock

Rik van Riel (1):
      smp: print only local CPU info when sched_clock goes backward

Ryo Takakura (1):
      rcu: Let dump_cpu_task() be used without preemption disabled

Sean Christopherson (1):
      context_tracking: Tag context_tracking_enabled_this_cpu() __always_inline

Thorsten Blum (1):
      rcu: Annotate struct kvfree_rcu_bulk_data with __counted_by()

Valentin Schneider (25):
      treewide: context_tracking: Rename CONTEXT_* into CT_STATE_*
      context_tracking, rcu: Rename RCU_DYNTICKS_IDX into CT_RCU_WATCHING
      context_tracking, rcu: Rename ct_dynticks() into ct_rcu_watching()
      context_tracking, rcu: Rename ct_dynticks_cpu() into ct_rcu_watching_cpu()
      context_tracking, rcu: Rename ct_dynticks_cpu_acquire() into ct_rcu_watching_cpu_acquire()
      context_tracking, rcu: Rename struct context_tracking .dynticks_nesting into .nesting
      context_tracking, rcu: Rename ct_dynticks_nesting() into ct_nesting()
      context_tracking, rcu: Rename ct_dynticks_nesting_cpu() into ct_nesting_cpu()
      context_tracking, rcu: Rename struct context_tracking .dynticks_nmi_nesting into .nmi_nesting
      context_tracking, rcu: Rename ct_dynticks_nmi_nesting() into ct_nmi_nesting()
      context_tracking, rcu: Rename ct_dynticks_nmi_nesting_cpu() into ct_nmi_nesting_cpu()
      context_tracking, rcu: Rename DYNTICK_IRQ_NONIDLE into CT_NESTING_IRQ_NONIDLE
      context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*()
      context_tracking, rcu: Rename rcu_dynticks_curr_cpu_in_eqs() into rcu_is_watching_curr_cpu()
      rcu: Rename rcu_dynticks_eqs_online() into rcu_watching_online()
      rcu: Rename rcu_dynticks_in_eqs() into rcu_watching_snap_in_eqs()
      rcu: Rename rcu_dynticks_in_eqs_since() into rcu_watching_snap_stopped_since()
      rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
      rcu: Rename struct rcu_data .dynticks_snap into .watching_snap
      rcu: Rename struct rcu_data .exp_dynticks_snap into .exp_watching_snap
      rcu: Rename dyntick_save_progress_counter() into rcu_watching_snap_save()
      rcu: Rename rcu_implicit_dynticks_qs() into rcu_watching_snap_recheck()
      rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()
      rcu: Update stray documentation references to rcu_dynticks_eqs_{enter, exit}()
      context_tracking, rcu: Rename rcu_dyntick trace event into rcu_watching

Waiman Long (1):
      rcu: Use system_unbound_wq to avoid disturbing isolated CPUs

Zhouyi Zhou (1):
      rcutorture: Add CFcommon.arch for arch-specific Kconfig options

Zqiang (1):
      rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()

 Documentation/RCU/Design/Data-Structures/Data-Structures.rst          |  28 +++---
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |   8 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg          |   8 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg           |   8 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg               |   8 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg          |   4 +-
 Documentation/RCU/Design/Requirements/Requirements.rst                |   3 +-
 Documentation/RCU/checklist.rst                                       |  61 ++++++------
 Documentation/RCU/whatisRCU.rst                                       |   2 +-
 Documentation/admin-guide/kernel-parameters.txt                       |  20 ++--
 arch/Kconfig                                                          |   2 +-
 arch/arm64/kernel/entry-common.c                                      |   2 +-
 arch/powerpc/include/asm/interrupt.h                                  |   6 +-
 arch/powerpc/kernel/interrupt.c                                       |   6 +-
 arch/powerpc/kernel/syscall.c                                         |   2 +-
 arch/x86/entry/common.c                                               |   2 +-
 include/linux/context_tracking.h                                      |  32 ++++---
 include/linux/context_tracking_state.h                                |  60 ++++++------
 include/linux/entry-common.h                                          |   2 +-
 include/linux/rcu_segcblist.h                                         |   6 +-
 include/linux/rculist.h                                               |   9 +-
 include/linux/rcupdate.h                                              |  15 ++-
 include/linux/rcutiny.h                                               |   2 +-
 include/linux/rcutree.h                                               |   2 +-
 include/linux/smp.h                                                   |   6 ++
 include/linux/srcutree.h                                              |  15 ++-
 include/trace/events/rcu.h                                            |  20 ++--
 kernel/context_tracking.c                                             | 140 ++++++++++++++--------------
 kernel/entry/common.c                                                 |   2 +-
 kernel/rcu/rcu.h                                                      |  12 ++-
 kernel/rcu/rcu_segcblist.c                                            |  11 ---
 kernel/rcu/rcu_segcblist.h                                            |  11 +--
 kernel/rcu/rcuscale.c                                                 | 214 ++++++++++++++++++++++++++++++++++++------
 kernel/rcu/rcutorture.c                                               | 121 +++++++++++++++---------
 kernel/rcu/refscale.c                                                 |  67 ++++++-------
 kernel/rcu/srcutree.c                                                 |  11 ++-
 kernel/rcu/tasks.h                                                    | 214 ++++++++++++++++++++++++++++--------------
 kernel/rcu/tree.c                                                     | 174 ++++++++++++++++------------------
 kernel/rcu/tree.h                                                     |  10 +-
 kernel/rcu/tree_exp.h                                                 | 121 +++++++++++++-----------
 kernel/rcu/tree_nocb.h                                                | 279 +++++++++++++++++++++----------------------------------
 kernel/rcu/tree_plugin.h                                              |  11 ++-
 kernel/rcu/tree_stall.h                                               |  16 +++-
 kernel/sched/core.c                                                   |   6 +-
 kernel/smp.c                                                          |  38 +++++++-
 kernel/stop_machine.c                                                 |   2 +-
 kernel/trace/trace_osnoise.c                                          |   4 +-
 lib/Kconfig.debug                                                     |   1 +
 tools/rcu/rcu-updaters.sh                                             |   2 -
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh              |   2 +
 tools/testing/selftests/rcutorture/bin/torture.sh                     |  38 +++++---
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon               |   2 -
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686          |   2 +
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le       |   1 +
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64        |   2 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot            |   1 +
 tools/testing/selftests/rcutorture/configs/refscale/TINY              |  20 ++++
 57 files changed, 1088 insertions(+), 786 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/TINY
