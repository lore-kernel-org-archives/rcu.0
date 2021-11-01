Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602D2C433F5
	for <rcu@archiver.kernel.org>; Mon,  1 Nov 2021 23:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4039F60C40
	for <rcu@archiver.kernel.org>; Mon,  1 Nov 2021 23:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKAX1y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Nov 2021 19:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhKAX1y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Nov 2021 19:27:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D2E96052B;
        Mon,  1 Nov 2021 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635809120;
        bh=clP3yqJcSXQ6ame+5rr8ly27eeKVg3wmuJgS67JA07Q=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ZdJD5wR91PVyzEX6xmWe1Bh3YPcG9nuuWxYcSSAqAM8khYLoCbIVwJllwwAloAVDI
         k648MWl512GZOn4EjVUv3mbGAP63LsFFin+NTykl9czkeJpWxxtBnS4MzXWvhAvXli
         MWFhRMSLu+pHtjd34g1SzWHWalRtndu1+33f/YPer6HpHpX5o+G6nXo3lgL7NdF3CL
         Ywns7c2gVKj+rt8QPuWIFjfsy/LK9uBHXEIZpVQidoRgujS937ZiyV346/VmvtziDa
         4ikInym9x4867VoxuoOFrT1rvZ/mBN6uLsKNYnajMYPugKrUooe0GzGEL+zmCpIvK2
         X0fi1IGxFYnhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D6FA25C06BA; Mon,  1 Nov 2021 16:25:19 -0700 (PDT)
Date:   Mon, 1 Nov 2021 16:25:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, juri.lelli@redhat.com,
        longman@redhat.com, neeraju@codeaurora.org, peterz@infradead.org,
        swood@redhat.com, zhouzhouyi@gmail.com
Subject: [GIT PULL] RCU changes for v5.16
Message-ID: <20211101232519.GA508858@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Linus,

Please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2021.11.01a
  # HEAD: dd1277d2ad95e7f0de1b79c70fdfe635d9df0f80 Merge branches 'fixes.2021.10.07a', 'scftorture.2021.09.16a', 'tasks.2021.09.15a', 'torture.2021.09.13b' and 'torturescript.2021.09.16a' into HEAD

RCU changes for this cycle were:

o	Miscellaneous fixes.

o	Torture-test updates for smp_call_function(), most notably
	improved checking of module parameters.

o	Tasks-trace RCU updates that fix a number of rare but important
	race-condition bugs.

o	Other torture-test updates, most notably better checking of
	module parameters.  In addition, rcutorture may once again be
	run on CONFIG_PREEMPT_RT kernels.

o	Torture-test scripting updates, most notably specifying the new
	CONFIG_KCSAN_STRICT kconfig option rather than maintaining an
	ever-changing list of individual KCSAN kconfig options.

As noted by Stephen Rothwell, this pull request conflicts with commit
9b3c4ab3045e ("sched,rcu: Rework try_invoke_on_locked_down_task()")
from the -tip tree, which is now in mainline.  Stephen's suggested
conflict-resolution patch [1] works and has been heavily tested.
An example merge commit based on his approach (lightly tested, but
with identical diffs) may be found at branch rcu-merge.2021.11.01a in
the -rcu tree.

							Thanx, Paul

[1] https://lore.kernel.org/all/20211012154828.312f870f@canb.auug.org.au/

----------------------------------------------------------------
Juri Lelli (2):
      rcu: Make rcu_normal_after_boot writable again
      rcu: Make rcu update module parameters world-readable

Neeraj Upadhyay (7):
      rcu: Fix existing exp request check in sync_sched_exp_online_cleanup()
      rcu-tasks: Fix s/rcu_add_holdout/trc_add_holdout/ typo in comment
      rcu-tasks: Correct firstreport usage in check_all_holdout_tasks_trace
      rcu-tasks: Correct comparisons for CPU numbers in show_stalled_task_trace
      rcu-tasks: Clarify read side section info for rcu_tasks_rude GP primitives
      rcu-tasks: Fix read-side primitives comment for call_rcu_tasks_trace
      rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader

Paul E. McKenney (33):
      torture: Apply CONFIG_KCSAN_STRICT to kvm.sh --kcsan argument
      rcu: Mark accesses to rcu_state.n_force_qs
      rcu-nocb: Fix a couple of tree_nocb code-style nits
      rcu: Eliminate rcu_implicit_dynticks_qs() local variable rnhqp
      rcu: Eliminate rcu_implicit_dynticks_qs() local variable ruqp
      doc: Add another stall-warning root cause in stallwarn.rst
      rcu: Comment rcu_gp_init() code waiting for CPU-hotplug operations
      rcu: Move rcu_dynticks_eqs_online() to rcu_cpu_starting()
      rcu: Simplify rcu_report_dead() call to rcu_report_exp_rdp()
      rcu: Make rcutree_dying_cpu() use its "cpu" parameter
      rcu-tasks: Wait for trc_read_check_handler() IPIs
      rcutorture: Suppressing read-exit testing is not an error
      rcutorture: Warn on individual rcu_torture_init() error conditions
      locktorture: Warn on individual lock_torture_init() error conditions
      refscale: Warn on individual ref_scale_init() error conditions
      rcuscale: Warn on individual rcu_scale_init() error conditions
      rcutorture: Don't cpuhp_remove_state() if cpuhp_setup_state() failed
      torture: Make torture.sh print the number of files to be compressed
      rcu-tasks: Simplify trc_read_check_handler() atomic operations
      rcu-tasks: Add trc_inspect_reader() checks for exiting critical section
      rcu-tasks: Remove second argument of rcu_read_unlock_trace_special()
      rcu-tasks: Fix s/instruction/instructions/ typo in comment
      rcu-tasks: Move RTGS_WAIT_CBS to beginning of rcu_tasks_kthread() loop
      rcu-tasks: Update comments to cond_resched_tasks_rcu_qs()
      scftorture: Allow zero weight to exclude an smp_call_function*() category
      scftorture: Shut down if nonsensical arguments given
      scftorture: Account for weight_resched when checking for all zeroes
      scftorture: Count reschedule IPIs
      scftorture: Warn on individual scf_torture_init() error conditions
      tools/rcu: Add an extract-stall script
      torture: Allot 1G of memory for scftorture runs
      torture: Make kvm-remote.sh print size of downloaded tarball
      Merge branches 'fixes.2021.10.07a', 'scftorture.2021.09.16a', 'tasks.2021.09.15a', 'torture.2021.09.13b' and 'torturescript.2021.09.16a' into HEAD

Peter Zijlstra (2):
      rcu: Always inline rcu_dynticks_task*_{enter,exit}()
      rcu: Fix rcu_dynticks_curr_cpu_in_eqs() vs noinstr

Scott Wood (1):
      rcutorture: Avoid problematic critical section nesting on PREEMPT_RT

Waiman Long (1):
      rcu: Avoid unneeded function call in rcu_read_unlock()

Zhouyi Zhou (1):
      rcu: Fix undefined Kconfig macros

 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |  69 ++++++-------
 Documentation/RCU/stallwarn.rst                    |  10 ++
 arch/sh/configs/sdk7786_defconfig                  |   1 -
 arch/xtensa/configs/nommu_kc705_defconfig          |   1 -
 include/linux/rcupdate.h                           |   3 +-
 include/linux/rcupdate_trace.h                     |   5 +-
 include/linux/torture.h                            |   8 ++
 kernel/locking/locktorture.c                       |  14 +--
 kernel/rcu/rcuscale.c                              |  10 +-
 kernel/rcu/rcutorture.c                            |  86 ++++++++++------
 kernel/rcu/refscale.c                              |   6 +-
 kernel/rcu/tasks.h                                 | 109 ++++++++++-----------
 kernel/rcu/tree.c                                  |  36 +++----
 kernel/rcu/tree_exp.h                              |   3 +-
 kernel/rcu/tree_nocb.h                             |   2 +-
 kernel/rcu/tree_plugin.h                           |  11 +--
 kernel/rcu/update.c                                |   8 +-
 kernel/scftorture.c                                |  43 ++++----
 tools/rcu/extract-stall.sh                         |  34 +++++++
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |   1 +
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   2 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  |  11 ++-
 22 files changed, 273 insertions(+), 200 deletions(-)
 create mode 100644 tools/rcu/extract-stall.sh
