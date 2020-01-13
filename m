Return-Path: <SRS0=HcES=3C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B43C33CA9
	for <rcu@archiver.kernel.org>; Mon, 13 Jan 2020 18:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19518214AF
	for <rcu@archiver.kernel.org>; Mon, 13 Jan 2020 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578940925;
	bh=MURr2vjR+RksL79GigkRXShyvpHbLclCsHVgzeS59Jc=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=b3u1PTniR91OA/oj5HR6kZ1v6Z7zS/ynFlJJjCDWQAPYIZsftTyJHRO4W8HBqd9VF
	 isDkf0W3bsSTRuFnxduN5x8fjMfUAd6/tNvyt6ZItxVebTfXe5CdsgBq3AU2FamO/w
	 aNkW1yj3hEzBmjdGqhtbYCaL30cdDHMPKCBexWno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgAMSmF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMSmE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jan 2020 13:42:04 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D7F20CC7;
        Mon, 13 Jan 2020 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578940923;
        bh=MURr2vjR+RksL79GigkRXShyvpHbLclCsHVgzeS59Jc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=TIcl3nU2a5ohIaW6/ud9aTf8pyLq3FGuHr5NGh5xTSPJbgTpxQ/Lnm3peiSMGRmXN
         FLZ4484YHx5DR9v/SBED8Z9qHCLfRYiBMyJjPxQjBW0sZ8eVArp8Ycp1UOLaziMlU9
         t4YGJIrHlN2x1P9jzGE9NCiZ274tIgyIslYS6mTw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B09CC3522798; Mon, 13 Jan 2020 10:42:02 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:42:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, bigeasy@linutronix.de,
        boqun.feng@gmail.com, edumazet@google.com, elver@google.com,
        frextrite@gmail.com, j.neuschaefer@gmx.net, joel@joelfernandes.org,
        laijs@linux.alibaba.com, madhuparnabhowmik04@gmail.com,
        neeraju@codeaurora.org, stefan@pimaker.at, tranmanphong@gmail.com,
        will@kernel.org
Subject: [GIT PULL rcu/next + kcsan] RCU and KCSAN commits for v5.6
Message-ID: <20200113184202.GA11426@paulmck-ThinkPad-P72>
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

Hello, Ingo, and Happy New Year!

This pull request contains the following changes:

1.	Documentation updates.

	https://lore.kernel.org/lkml/20191210035539.GA792@paulmck-ThinkPad-P72

2.	Expedited grace-period updates.

	https://lore.kernel.org/lkml/20191210040122.GA2419@paulmck-ThinkPad-P72

3.	Miscellaneous fixes.

	https://lore.kernel.org/lkml/20191210223825.GS2889@paulmck-ThinkPad-P72
	https://lore.kernel.org/lkml/20191211231239.GK2889@paulmck-ThinkPad-P72
	https://lore.kernel.org/lkml/20191210040714.GA2715@paulmck-ThinkPad-P72

4.	kfree_rcu() updates.

	https://lore.kernel.org/lkml/20191210041118.GA3115@paulmck-ThinkPad-P72

5.	RCU list updates.

	https://lore.kernel.org/lkml/20191210041938.GA3367@paulmck-ThinkPad-P72

6.	Preemptible RCU updates.

	https://lore.kernel.org/lkml/20191210042606.GA3624@paulmck-ThinkPad-P72

7.	Torture-test updates.

	https://lore.kernel.org/lkml/20191210034119.GA32711@paulmck-ThinkPad-P72

8.	Kernel Concurrency Sanitizer (KCSAN) updates.

	https://lore.kernel.org/lkml/20191119185742.GB68739@google.com
	https://lore.kernel.org/lkml/20191126140406.164870-1-elver@google.com
	https://lore.kernel.org/lkml/20191126140406.164870-2-elver@google.com
	https://lore.kernel.org/lkml/20191212000709.166889-1-elver@google.com
	https://lore.kernel.org/lkml/20191212000709.166889-2-elver@google.com

All of these have been subjected to the kbuild test robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 330692eb36b9cf0f9534d8ba68f87610cff2d5fc:

  Merge branch 'kcsan.2020.01.07a' into HEAD (2020-01-10 14:06:37 -0800)

There is a significant size increase of about 3,000 lines.  This is due
to quite a few different categories of changes:

o	KCSAN, courtesy of Marco Elver.  Note that the diffstat below
	counts the commits already in -tip courtesy of "git request-pull"
	or perhaps just me not knowing how to use this command properly.

o	Untangling kfree_rcu() from core RCU and related rcuperf
	tests, courtesy of Joel Fernandes.  This should allow use of
	kfree_bulk(), and there is already a patch from Uladzislau Rezki
	proposing this, which might make my v5.7 pull request.

o	The beginning of a series of changes that will hopefully allow
	inlining of RCU-preempt rcu_read_lock() and rcu_read_unlock(),
	courtesy of Lai Jiangshan.

o	Converting documentation to .rst and addition of more docbook
	header comments, courtesy of Madhuparna Bhowmik, Phong Tran,
	and Amol Grover.

o	Grace-period forward-progress improvements and related rcutorture
	testing.  These improvements help reduce memory footprint because
	they reduce the number of outstanding callbacks).

o	The first few changes to allow rcutorture to gracefully handle
	large systems that take many tens of seconds to boot.

Given the magnitude of these changes, this increase in size is quite
reasonable.

----------------------------------------------------------------
Amol Grover (2):
      doc: Convert to rcu_dereference.txt to rcu_dereference.rst
      doc: Convert to rcubarrier.txt to ReST

Ben Dooks (1):
      rcu: Move rcu_{expedited,normal} definitions into rcupdate.h

Boqun Feng (1):
      rcu: Avoid modifying mask_ofl_ipi in sync_rcu_exp_select_node_cpus()

Eric Dumazet (2):
      list: Add hlist_unhashed_lockless()
      rcu: Avoid data-race in rcu_gp_fqs_check_wake()

Ingo Molnar (2):
      Merge branch 'for-mingo' of git://git.kernel.org/.../paulmck/linux-rcu into locking/kcsan
      kcsan: Improve various small stylistic details

Joel Fernandes (1):
      rcu: Make kfree_rcu() use a non-atomic ->monitor_todo

Joel Fernandes (Google) (6):
      rcu: Add basic support for kfree_rcu() batching
      rcuperf: Add kfree_rcu() performance Tests
      rcu: Add multiple in-flight batches of kfree_rcu() work
      rcu: Add support for debug_objects debugging for kfree_rcu()
      rcu: Remove kfree_rcu() special casing and lazy-callback handling
      rcu: Remove kfree_call_rcu_nobatch()

Jonathan Neuschäfer (1):
      rculist: Describe variadic macro argument in a Sphinx-compatible way

Lai Jiangshan (9):
      rcu: Make PREEMPT_RCU be a modifier to TREE_RCU
      rcu: Rename some instance of CONFIG_PREEMPTION to CONFIG_PREEMPT_RCU
      rcu: Clear .exp_hint only when deferred quiescent state has been reported
      rcu: Clear ->rcu_read_unlock_special only once
      rcu: Provide wrappers for uses of ->rcu_read_lock_nesting
      rcu: Fix harmless omission of "CONFIG_" from #if condition
      rcu: Fix tracepoint tracking RCU CPU kthread utilization
      rcu: Remove the declaration of call_rcu() in tree.h
      rcu: Move gp_state_names[] and gp_state_getname() to tree_stall.h

Madhuparna Bhowmik (6):
      doc: Convert arrayRCU.txt to arrayRCU.rst
      doc: Converted NMI-RCU.txt to NMI-RCU.rst.
      doc: Updated full list of RCU API in whatisRCU.rst
      rculist_nulls: Add docbook comments
      rculist_nulls: Change docbook comment headers
      rculist.h: Add list_tail_rcu()

Marco Elver (15):
      kcsan: Add Kernel Concurrency Sanitizer infrastructure
      include/linux/compiler.h: Introduce data_race(expr) macro
      kcsan: Add Documentation entry in dev-tools
      objtool, kcsan: Add KCSAN runtime functions to whitelist
      build, kcsan: Add KCSAN build exceptions
      seqlock, kcsan: Add annotations for KCSAN
      seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
      locking/atomics, kcsan: Add KCSAN instrumentation
      x86, kcsan: Enable KCSAN for x86
      rcu: Fix data-race due to atomic_t copy-by-value
      kcsan, ubsan: Make KCSAN+UBSAN work together
      asm-generic/atomic: Use __always_inline for pure wrappers
      asm-generic/atomic: Use __always_inline for fallback wrappers
      kcsan: Document static blacklisting options
      kcsan: Add __no_kcsan function attribute

Neeraj Upadhyay (2):
      rcu: Fix missed wakeup of exp_wq waiters
      rcu: Allow only one expedited GP to run concurrently with wakeups

Paul E. McKenney (35):
      rcu: Use *_ONCE() to protect lockless ->expmask accesses
      rcu: Substitute lookup for bit-twiddling in sync_rcu_exp_select_node_cpus()
      rcu: Rename sync_rcu_preempt_exp_done() to sync_rcu_exp_done()
      rcu: Update tree_exp.h function-header comments
      rcu: Replace synchronize_sched_expedited_wait() "_sched" with "_rcu"
      rcu: Enable tick for nohz_full CPUs slow to provide expedited QS
      rcu: Use lockdep rather than comment to enforce lock held
      rcu: Use READ_ONCE() for ->expmask in rcu_read_unlock_special()
      rcu: Avoid tick_dep_set_cpu() misordering
      torture: Use gawk instead of awk for systime() function
      rcutorture: Dispense with Dracut for initrd creation
      torture: Handle jitter for CPUs that cannot be offlined
      torture: Handle systems lacking the mpstat command
      rcutorture: Add worst-case call_rcu() forward-progress results
      rcutorture: Pull callback forward-progress data into rcu_fwd struct
      rcutorture: Thread rcu_fwd pointer through forward-progress functions
      rcutorture: Move to dynamic initialization of rcu_fwds
      rcutorture: Complete threading rcu_fwd pointers through functions
      rcutorture: Dynamically allocate rcu_fwds structure
      torture: Allow "CFLIST" to specify default list of scenarios
      torture: Hoist calls to lscpu to higher-level kvm.sh script
      doc: Fix typo "deference" to "dereference"
      net/tipc: Replace rcu_swap_protected() with rcu_replace_pointer()
      wireless/mediatek: Replace rcu_swap_protected() with rcu_replace_pointer()
      rcu: Remove rcu_swap_protected()
      rcu: Mark non-global functions and variables as static
      rcu: Switch force_qs_rnp() to for_each_leaf_node_cpu_mask()
      srcu: Apply *_ONCE() to ->srcu_last_gp_end
      .mailmap: Add entries for old paulmck@kernel.org addresses
      rcu: Remove unused stop-machine #include
      rcu: Use WRITE_ONCE() for assignments to ->pprev for hlist_nulls
      rcu: Add and update docbook header comments in list.h
      rcu: Add a hlist_nulls_unhashed_lockless() function
      Merge branches 'doc.2019.12.10a', 'exp.2019.12.09a', 'fixes.2019.12.12a', 'kfree_rcu.2019.12.09a', 'list.2020.01.10a', 'preempt.2019.12.09a' and 'torture.2019.12.09a' into HEAD
      Merge branch 'kcsan.2020.01.07a' into HEAD

Phong Tran (1):
      doc: Convert whatisRCU.txt to .rst

Sebastian Andrzej Siewior (1):
      rcu: Use CONFIG_PREEMPTION where appropriate

Stefan Reiter (1):
      rcu/nocb: Fix dump_tree hierarchy print always active

Will Deacon (1):
      powerpc: Remove comment about read_barrier_depends()

 .mailmap                                           |   4 +
 Documentation/RCU/{NMI-RCU.txt => NMI-RCU.rst}     |  53 +-
 Documentation/RCU/{arrayRCU.txt => arrayRCU.rst}   |  34 +-
 Documentation/RCU/index.rst                        |   5 +
 Documentation/RCU/lockdep-splat.txt                |   2 +-
 .../{rcu_dereference.txt => rcu_dereference.rst}   |  75 ++-
 .../RCU/{rcubarrier.txt => rcubarrier.rst}         | 222 ++++---
 Documentation/RCU/stallwarn.txt                    |  11 +-
 Documentation/RCU/{whatisRCU.txt => whatisRCU.rst} | 291 ++++++---
 Documentation/admin-guide/kernel-parameters.txt    |  13 +
 Documentation/dev-tools/index.rst                  |   1 +
 Documentation/dev-tools/kcsan.rst                  | 266 ++++++++
 MAINTAINERS                                        |  11 +
 Makefile                                           |   3 +-
 arch/powerpc/include/asm/barrier.h                 |   2 -
 arch/x86/Kconfig                                   |   1 +
 arch/x86/boot/Makefile                             |   2 +
 arch/x86/boot/compressed/Makefile                  |   2 +
 arch/x86/entry/vdso/Makefile                       |   3 +
 arch/x86/include/asm/bitops.h                      |   6 +-
 arch/x86/kernel/Makefile                           |   4 +
 arch/x86/kernel/cpu/Makefile                       |   3 +
 arch/x86/lib/Makefile                              |   4 +
 arch/x86/mm/Makefile                               |   4 +
 arch/x86/purgatory/Makefile                        |   2 +
 arch/x86/realmode/Makefile                         |   3 +
 arch/x86/realmode/rm/Makefile                      |   3 +
 drivers/firmware/efi/libstub/Makefile              |   2 +
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |   4 +-
 include/asm-generic/atomic-instrumented.h          | 722 +++++++++++----------
 include/asm-generic/atomic-long.h                  | 331 +++++-----
 include/linux/atomic-fallback.h                    | 340 +++++-----
 include/linux/compiler-clang.h                     |  11 +-
 include/linux/compiler-gcc.h                       |   6 +
 include/linux/compiler.h                           |  60 +-
 include/linux/kcsan-checks.h                       |  93 +++
 include/linux/kcsan.h                              | 108 +++
 include/linux/list.h                               | 136 +++-
 include/linux/list_nulls.h                         |  30 +-
 include/linux/rcu_segcblist.h                      |   2 -
 include/linux/rculist.h                            |  38 +-
 include/linux/rculist_nulls.h                      |  20 +-
 include/linux/rcupdate.h                           |  28 +-
 include/linux/rcutiny.h                            |   1 +
 include/linux/rcutree.h                            |   1 +
 include/linux/sched.h                              |   4 +
 include/linux/seqlock.h                            |  51 +-
 include/linux/tick.h                               |   5 +-
 include/trace/events/rcu.h                         |  40 +-
 init/init_task.c                                   |   8 +
 init/main.c                                        |   2 +
 kernel/Makefile                                    |   6 +
 kernel/kcsan/Makefile                              |  12 +
 kernel/kcsan/atomic.h                              |  27 +
 kernel/kcsan/core.c                                | 621 ++++++++++++++++++
 kernel/kcsan/debugfs.c                             | 271 ++++++++
 kernel/kcsan/encoding.h                            |  95 +++
 kernel/kcsan/kcsan.h                               | 109 ++++
 kernel/kcsan/report.c                              | 318 +++++++++
 kernel/kcsan/test.c                                | 121 ++++
 kernel/rcu/Kconfig                                 |  17 +-
 kernel/rcu/Makefile                                |   1 -
 kernel/rcu/rcu.h                                   |  33 +-
 kernel/rcu/rcu_segcblist.c                         |  25 +-
 kernel/rcu/rcu_segcblist.h                         |  25 +-
 kernel/rcu/rcuperf.c                               | 173 ++++-
 kernel/rcu/rcutorture.c                            | 141 ++--
 kernel/rcu/srcutiny.c                              |   2 +-
 kernel/rcu/srcutree.c                              |  11 +-
 kernel/rcu/tiny.c                                  |  28 +-
 kernel/rcu/tree.c                                  | 324 +++++++--
 kernel/rcu/tree.h                                  |  18 +-
 kernel/rcu/tree_exp.h                              | 147 +++--
 kernel/rcu/tree_plugin.h                           | 168 +++--
 kernel/rcu/tree_stall.h                            |  34 +-
 kernel/rcu/update.c                                |  14 +-
 kernel/sched/Makefile                              |   6 +
 kernel/sysctl.c                                    |   2 +-
 lib/Kconfig.debug                                  |   2 +
 lib/Kconfig.kcsan                                  | 116 ++++
 lib/Makefile                                       |   4 +
 mm/Makefile                                        |   8 +
 net/tipc/crypto.c                                  |   5 +-
 scripts/Makefile.kcsan                             |   6 +
 scripts/Makefile.lib                               |  10 +
 scripts/atomic/fallbacks/acquire                   |   2 +-
 scripts/atomic/fallbacks/add_negative              |   2 +-
 scripts/atomic/fallbacks/add_unless                |   2 +-
 scripts/atomic/fallbacks/andnot                    |   2 +-
 scripts/atomic/fallbacks/dec                       |   2 +-
 scripts/atomic/fallbacks/dec_and_test              |   2 +-
 scripts/atomic/fallbacks/dec_if_positive           |   2 +-
 scripts/atomic/fallbacks/dec_unless_positive       |   2 +-
 scripts/atomic/fallbacks/fence                     |   2 +-
 scripts/atomic/fallbacks/fetch_add_unless          |   2 +-
 scripts/atomic/fallbacks/inc                       |   2 +-
 scripts/atomic/fallbacks/inc_and_test              |   2 +-
 scripts/atomic/fallbacks/inc_not_zero              |   2 +-
 scripts/atomic/fallbacks/inc_unless_negative       |   2 +-
 scripts/atomic/fallbacks/read_acquire              |   2 +-
 scripts/atomic/fallbacks/release                   |   2 +-
 scripts/atomic/fallbacks/set_release               |   2 +-
 scripts/atomic/fallbacks/sub_and_test              |   2 +-
 scripts/atomic/fallbacks/try_cmpxchg               |   2 +-
 scripts/atomic/gen-atomic-fallback.sh              |   2 +
 scripts/atomic/gen-atomic-instrumented.sh          |  20 +-
 scripts/atomic/gen-atomic-long.sh                  |   3 +-
 tools/objtool/check.c                              |  18 +
 tools/testing/selftests/rcutorture/bin/cpus2use.sh |  11 +-
 tools/testing/selftests/rcutorture/bin/jitter.sh   |  30 +-
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |   3 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  13 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  30 +-
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  55 +-
 114 files changed, 4619 insertions(+), 1577 deletions(-)
 rename Documentation/RCU/{NMI-RCU.txt => NMI-RCU.rst} (73%)
 rename Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} (85%)
 rename Documentation/RCU/{rcu_dereference.txt => rcu_dereference.rst} (88%)
 rename Documentation/RCU/{rcubarrier.txt => rcubarrier.rst} (72%)
 rename Documentation/RCU/{whatisRCU.txt => whatisRCU.rst} (84%)
 create mode 100644 Documentation/dev-tools/kcsan.rst
 create mode 100644 include/linux/kcsan-checks.h
 create mode 100644 include/linux/kcsan.h
 create mode 100644 kernel/kcsan/Makefile
 create mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/core.c
 create mode 100644 kernel/kcsan/debugfs.c
 create mode 100644 kernel/kcsan/encoding.h
 create mode 100644 kernel/kcsan/kcsan.h
 create mode 100644 kernel/kcsan/report.c
 create mode 100644 kernel/kcsan/test.c
 create mode 100644 lib/Kconfig.kcsan
 create mode 100644 scripts/Makefile.kcsan
