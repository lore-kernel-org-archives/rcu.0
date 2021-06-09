Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E116AC48BCF
	for <rcu@archiver.kernel.org>; Wed,  9 Jun 2021 23:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF198613DF
	for <rcu@archiver.kernel.org>; Wed,  9 Jun 2021 23:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhFIXbc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Jun 2021 19:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhFIXbV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Jun 2021 19:31:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A66E613EF;
        Wed,  9 Jun 2021 23:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623281366;
        bh=4MAfEjmi2NviFj/PknXz3HGeF0MD+bvfD7FKYdpHBcc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=dPY8pUdoPx43msg3fUwjF3o3o/V11SUirp4yOzZfPF5fSSATXHFUH3637lXAX1V0C
         MnD/3acY2efj3HQrLbJZg9kSoPKkBgmbCwSvS4++NM3TXGMh1diFJoDOoM0XcMn3G+
         U2uTxpvpU0ww0AcJ8R/EXDgUIJ4Lbk8RmX91fembPv9CkaG3/T32lMP3T7OOGfjuYU
         OMsQGRLP2ru1ffu6OzLswm69tzw+bawGYM7pHuZE077vzIc8qRuZvrwiXy/1thNNqp
         4sbbliQIVkBns9Fgw0jR4jq3p/7q7Z4S5EfHDTlbbBsvoaOQRwQkF69xP4Zmz89GFd
         FxonA/OIvJKmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0F8315C08D8; Wed,  9 Jun 2021 16:29:26 -0700 (PDT)
Date:   Wed, 9 Jun 2021 16:29:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     eb@emlix.com, frederic@kernel.org, jbi.octave@gmail.com,
        maninder1.s@samsung.com, qiang.zhang@windriver.com,
        urezki@gmail.com, yury.norov@gmail.com, zhouzhouyi@gmail.com,
        mark.rutland@arm.com, elver@google.com, bjorn.topel@intel.com,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kasan-dev@googlegroups.com, tglx@linutronix.de
Subject: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.14
Message-ID: <20210609232926.GA1715440@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Ingo!

This pull request contains changes for RCU, KCSAN, and LKMM.  You can
pull the entire group using branch for-mingo.  Or, if you prefer, you
can pull them separately, using for-mingo-rcu to pull the RCU changes,
for-mingo-kcsan to pull the KCSAN changes, and for-mingo-lkmm to pull
the LKMM changes.

The changes are as follows:

1.	RCU changes (for-mingo-rcu):

	a.	Bitmap support for "all" as alias for all bits, and with
		modifiers allowed, courtesy of Yury Norov.  This change
		means that "rcu_nocbs=all:1/2" would offload all the
		even-numbered CPUs regardless of the number of CPUs on
		the system.
		https://lore.kernel.org/lkml/20210511224115.GA2892092@paulmck-ThinkPad-P17-Gen-1

	b.	Documentation updates.
		https://lore.kernel.org/lkml/20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1

	c.	Miscellaneous fixes.
		https://lore.kernel.org/lkml/20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1

	d.	kvfree_rcu updates, courtesy of Uladzislau Rezki and Zhang Qiang.
		https://lore.kernel.org/lkml/20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1

	e.	mm_dump_obj() updates, courtesy of Maninder Singh, acked
		by Vlastimil Babka.
		https://lore.kernel.org/lkml/20210511225744.GA2893615@paulmck-ThinkPad-P17-Gen-1

	f.	RCU callback offloading updates, courtesy of Frederic
		Weisbecker and Ingo Molnar.  ;-)
		https://lore.kernel.org/lkml/20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1

	g.	SRCU updates, courtesy of Frederic Weisbecker.
		https://lore.kernel.org/lkml/20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1

	h.	Tasks-RCU updates.
		https://lore.kernel.org/lkml/20210511230924.GA2894768@paulmck-ThinkPad-P17-Gen-1

	i.	Torture-test updates.
		https://lore.kernel.org/lkml/20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1

2.	Kernel concurrency sanitizer (KCSAN) updates from Marco Elver
	and Mark Rutland (for-mingo-kcsan).
	https://lore.kernel.org/lkml/20210511232324.GA2896130@paulmck-ThinkPad-P17-Gen-1

3.	Linux-kernel memory model (LKMM) updates courtesy of Björn Töpel
	(for-mingo-lkmm).
	https://lore.kernel.org/lkml/20210305102823.415900-1-bjorn.topel@gmail.com

All of the commits in this pull request have been subjected to subjected
to the kbuild test robot and -next testing, and are available in the
git repository based on v5.13-rc1 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 4b26c984195ecd203dd558226f2313b9582df851:

  Merge branch 'lkmm.2021.05.10c' into HEAD (2021-05-18 10:59:54 -0700)

----------------------------------------------------------------
Akira Yokosawa (1):
      kcsan: Use URL link for pointing access-marking.txt

Arnd Bergmann (1):
      kcsan: Fix debugfs initcall return type

Björn Töpel (1):
      tools/memory-model: Fix smp_mb__after_spinlock() spelling

Frederic Weisbecker (17):
      doc: Fix diagram references in memory-ordering document
      rcu/nocb: Use the rcuog CPU's ->nocb_timer
      timer: Revert "timer: Add timer_curr_running()"
      srcu: Remove superfluous sdp->srcu_lock_count zero filling
      srcu: Remove superfluous ssp initialization for early callbacks
      srcu: Unconditionally embed struct lockdep_map
      srcu: Initialize SRCU after timers
      srcu: Fix broken node geometry after early ssp init
      torture: Correctly fetch number of CPUs for non-English languages
      rcu/nocb: Directly call __wake_nocb_gp() from bypass timer
      rcu/nocb: Allow de-offloading rdp leader
      rcu/nocb: Cancel nocb_timer upon nocb_gp wakeup
      rcu/nocb: Delete bypass_timer upon nocb_gp wakeup
      rcu/nocb: Only cancel nocb timer if not polling
      rcu/nocb: Prepare for fine-grained deferred wakeup
      rcu/nocb: Unify timers
      srcu: Early test SRCU polling start

Ingo Molnar (1):
      rcu: Fix various typos in comments

Jules Irenge (1):
      rcu: Add missing __releases() annotation

Maninder Singh (2):
      mm/slub: Fix backtrace of objects to handle redzone adjustment
      mm/slub: Add Support for free path information of an object

Marco Elver (1):
      kcsan: Document "value changed" line

Mark Rutland (8):
      kcsan: Simplify value change detection
      kcsan: Distinguish kcsan_report() calls
      kcsan: Refactor passing watchpoint/other_info
      kcsan: Fold panic() call into print_report()
      kcsan: Refactor access_info initialization
      kcsan: Remove reporting indirection
      kcsan: Remove kcsan_report_type
      kcsan: Report observed value changes

Paul E. McKenney (50):
      doc: Fix statement of RCU's memory-ordering requirements
      tools/rcu: Add drgn script to dump number of RCU callbacks
      rcu-tasks: Add block comment laying out RCU Tasks design
      rcu-tasks: Add block comment laying out RCU Rude design
      torture: Fix remaining erroneous torture.sh instance of $*
      torture: Add "scenarios" option to kvm.sh --dryrun parameter
      torture: Make kvm-again.sh use "scenarios" rather than "batches" file
      refscale: Allow CPU hotplug to be enabled
      rcuscale: Allow CPU hotplug to be enabled
      torture: Add kvm-remote.sh script for distributed rcutorture test runs
      refscale: Add acqrel, lock, and lock-irq
      rcutorture: Abstract read-lock-held checks
      torture: Fix grace-period rate output
      torture: Abstract end-of-run summary
      torture: Make kvm.sh use abstracted kvm-end-run-stats.sh
      torture:  Make the build machine control N in "make -jN"
      torture: Make kvm-find-errors.sh account for kvm-remote.sh
      rcutorture: Judge RCU priority boosting on grace periods, not callbacks
      torture:  Set kvm.sh language to English
      rcutorture: Delay-based false positives for RCU priority boosting tests
      rcutorture: Consolidate rcu_torture_boost() timing and statistics
      rcutorture: Make rcu_torture_boost_failed() check for GP end
      rcutorture: Add BUSTED-BOOST to test RCU priority boosting tests
      rcutorture: Forgive RCU boost failures when CPUs don't pass through QS
      rcutorture: Don't count CPU-stalled time against priority boosting
      torture: Make kvm-remote.sh account for network failure in pathname checks
      torture: Don't cap remote runs by build-system number of CPUs
      rcutorture: Move mem_dump_obj() tests into separate function
      rcu: Remove the unused rcu_irq_exit_preempt() function
      rcu: Invoke rcu_spawn_core_kthreads() from rcu_spawn_gp_kthread()
      rcu: Add ->rt_priority and ->gp_start to show_rcu_gp_kthreads() output
      rcu: Add ->gp_max to show_rcu_gp_kthreads() output
      lockdep: Explicitly flag likely false-positive report
      rcu: Reject RCU_LOCKDEP_WARN() false positives
      rcu: Add quiescent states and boost states to show_rcu_gp_kthreads() output
      rcu: Make RCU priority boosting work on single-CPU rcu_node structures
      rcu: Make show_rcu_gp_kthreads() dump rcu_node structures blocking GP
      rcu: Restrict RCU_STRICT_GRACE_PERIOD to at most four CPUs
      rcu: Make rcu_gp_cleanup() be noinline for tracing
      rcu: Point to documentation of ordering guarantees
      rcu: Don't penalize priority boosting when there is nothing to boost
      rcu: Create an unrcu_pointer() to remove __rcu from a pointer
      rcu: Improve comments describing RCU read-side critical sections
      rcu: Remove obsolete rcu_read_unlock() deadlock commentary
      rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states
      tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline
      Merge branches 'bitmaprange.2021.05.10c', 'doc.2021.05.10c', 'fixes.2021.05.13a', 'kvfree_rcu.2021.05.10c', 'mmdumpobj.2021.05.10c', 'nocb.2021.05.12a', 'srcu.2021.05.12a', 'tasks.2021.05.18a' and 'torture.2021.05.10c' into HEAD
      kcsan: Add pointer to access-marking.txt to data_race() bullet
      Merge branch 'kcsan.2021.05.18a' into HEAD
      Merge branch 'lkmm.2021.05.10c' into HEAD

Rolf Eike Beer (1):
      rcu: Fix typo in comment: kthead -> kthread

Uladzislau Rezki (Sony) (6):
      kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
      kvfree_rcu: Add a bulk-list check when a scheduler is run
      kvfree_rcu: Update "monitor_todo" once a batch is started
      kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant
      kvfree_rcu: Fix comments according to current code
      kvfree_rcu: Refactor kfree_rcu_monitor()

Yury Norov (2):
      bitmap_parse: Support 'all' semantics
      rcu/tree_plugin: Don't handle the case of 'all' CPU range

Zhang Qiang (1):
      kvfree_rcu: Release a page cache under memory pressure

Zhouyi Zhou (1):
      rcu: Improve tree.c comments and add code cleanups

 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |   6 +-
 Documentation/admin-guide/kernel-parameters.rst    |   5 +
 Documentation/admin-guide/kernel-parameters.txt    |   5 +
 Documentation/dev-tools/kcsan.rst                  |  93 +++---
 include/linux/rcupdate.h                           |  84 +++---
 include/linux/rcutiny.h                            |   1 -
 include/linux/rcutree.h                            |   1 -
 include/linux/srcu.h                               |   6 +
 include/linux/srcutree.h                           |   2 -
 include/linux/timer.h                              |   2 -
 include/trace/events/rcu.h                         |   1 +
 init/main.c                                        |   2 +
 kernel/kcsan/core.c                                |  53 ++--
 kernel/kcsan/debugfs.c                             |   3 +-
 kernel/kcsan/kcsan.h                               |  39 ++-
 kernel/kcsan/report.c                              | 169 +++++------
 kernel/locking/lockdep.c                           |   6 +-
 kernel/rcu/Kconfig.debug                           |   2 +-
 kernel/rcu/rcu.h                                   |  14 +-
 kernel/rcu/rcutorture.c                            | 315 +++++++++++----------
 kernel/rcu/refscale.c                              | 109 ++++++-
 kernel/rcu/srcutree.c                              |  28 +-
 kernel/rcu/sync.c                                  |   4 +-
 kernel/rcu/tasks.h                                 |  58 +++-
 kernel/rcu/tiny.c                                  |   1 -
 kernel/rcu/tree.c                                  | 313 +++++++++++---------
 kernel/rcu/tree.h                                  |  14 +-
 kernel/rcu/tree_plugin.h                           | 239 ++++++++--------
 kernel/rcu/tree_stall.h                            |  84 +++++-
 kernel/rcu/update.c                                |   8 +-
 kernel/time/timer.c                                |  14 -
 lib/bitmap.c                                       |   9 +
 lib/test_bitmap.c                                  |   7 +
 mm/oom_kill.c                                      |   2 +-
 mm/slab.h                                          |   1 +
 mm/slab_common.c                                   |  12 +-
 mm/slub.c                                          |   8 +
 mm/util.c                                          |   2 +-
 tools/memory-model/Documentation/explanation.txt   |   2 +-
 tools/rcu/rcu-cbs.py                               |  46 +++
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |  33 +--
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   6 +-
 .../selftests/rcutorture/bin/kvm-end-run-stats.sh  |  40 +++
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   2 +-
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |   2 +-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh | 249 ++++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  61 ++--
 tools/testing/selftests/rcutorture/bin/torture.sh  |   2 +-
 .../selftests/rcutorture/configs/rcu/BUSTED-BOOST  |  17 ++
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot       |   8 +
 .../selftests/rcutorture/configs/rcuscale/TREE     |   2 +-
 .../selftests/rcutorture/configs/rcuscale/TREE54   |   2 +-
 .../rcutorture/configs/refscale/NOPREEMPT          |   2 +-
 .../selftests/rcutorture/configs/refscale/PREEMPT  |   2 +-
 .../rcutorture/formal/srcu-cbmc/src/locks.h        |   2 +-
 55 files changed, 1434 insertions(+), 766 deletions(-)
 create mode 100644 tools/rcu/rcu-cbs.py
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-remote.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
