Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D23C10DCE
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 21:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51203206BE
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584047449;
	bh=8/NVrAZcEgS19+54nRy9Op6UYRLTyni/t71ZvOcCbEQ=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=DWIFtVf3IF8eUvHq7I103N3A7j7oy4nDvIEHIrvXN/D4zIGYlI+745y+bFsDGhHhZ
	 tVIkTCgMPyjUOGxNTBNMfqYbRPNdKd9zTcz5jO6G2WwwTj5PpalMtEbN82Orb6t+6r
	 F+Nqf+FDITVQKjF2fbwnIy7xQDl/KLhi9Wvchfm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCLVKt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgCLVKs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 17:10:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E0920674;
        Thu, 12 Mar 2020 21:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584047447;
        bh=8/NVrAZcEgS19+54nRy9Op6UYRLTyni/t71ZvOcCbEQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ByPS8Puiscc71MpCt9AC9QvaYwoQoWRJrsFXFIBWcd+67qpK9P4JmIQI7aVD2G9c/
         6jgwG2XqJYMpRJ1doT5sDIc28SoscyPhfaeGPHAhM1ygG1B0CU+dbKVSnTma6114xO
         XkicT7DIgNfm2LR7DiMVaANnXJVLhYfEYoyS3a3s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1842535226D3; Thu, 12 Mar 2020 14:10:47 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:10:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        colin.king@canonical.com, edumazet@google.com, frextrite@gmail.com,
        jbi.octave@gmail.com, joel@joelfernandes.org,
        madhuparnabhowmik04@gmail.com, sjpark@amazon.de, urezki@gmail.com
Subject: [GIT PULL rcu/next] RCU commits for v5.7
Message-ID: <20200312211047.GA6096@paulmck-ThinkPad-P72>
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

	https://lore.kernel.org/lkml/20200214233848.GA12744@paulmck-ThinkPad-P72

2.	Miscellaneous fixes.

	https://lore.kernel.org/lkml/20200214235536.GA13364@paulmck-ThinkPad-P72

3.	Make kfree_rcu() use kfree_bulk() for added performance.

	https://lore.kernel.org/lkml/20200215000031.GA14315@paulmck-ThinkPad-P72

4.	Locking torture-test updates.

	https://lore.kernel.org/lkml/20200215000312.GA14585@paulmck-ThinkPad-P72

5.	Callback-overload handling updates.

	https://lore.kernel.org/lkml/20200215001816.GA15284@paulmck-ThinkPad-P72

6.	Tasks-RCU KCSAN and sparse updates.

	https://lore.kernel.org/lkml/20200215002446.GA15663@paulmck-ThinkPad-P72

7.	SRCU updates.

	https://lore.kernel.org/lkml/20200215002907.GA15895@paulmck-ThinkPad-P72

8.	Torture-test updates.

	https://lore.kernel.org/lkml/20200215003634.GA16227@paulmck-ThinkPad-P72

All of these have been subjected to the kbuild test robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to b5e91fead597a4eca629e0d2dcf767d49b79acb3:

  Merge branches 'doc.2020.02.27a', 'fixes.2020.02.27a', 'kfree_rcu.2020.02.20a', 'locktorture.2020.02.20a', 'ovld.2020.02.20a', 'rcu-tasks.2020.02.20a', 'srcu.2020.02.20a' and 'torture.2020.02.20a' into HEAD (2020-02-27 07:37:01 -0800)

There is a modest increase in code size of about 700 lines.  About 300
of these added lines were documentation, almost 200 more from adding
kfree_bulk() support to kfree_rcu(), about 150 from torture-test
improvements, and about 80 lines from improved callback-overload handling.
All in all, good value from this expansion.

----------------------------------------------------------------
Amol Grover (1):
      rculist: Add brackets around cond argument in __list_check_rcu macro

Colin Ian King (1):
      rcu: Fix spelling mistake "leval" -> "level"

Eric Dumazet (1):
      timer: Use hlist_unhashed_lockless() in timer_pending()

Joel Fernandes (Google) (2):
      rcuperf: Measure memory footprint during kfree_rcu() test
      doc: Add some more RCU list patterns in the kernel

Jules Irenge (4):
      rcu: Add missing annotation for rcu_nocb_bypass_lock()
      rcu/nocb: Add missing annotation for rcu_nocb_bypass_unlock()
      rcu: Add missing annotation for exit_tasks_rcu_start()
      rcu: Add missing annotation for exit_tasks_rcu_finish()

Madhuparna Bhowmik (1):
      nfs: Fix nfs_access_get_cached_rcu() sparse error

Paul E. McKenney (55):
      rcu: Warn on for_each_leaf_node_cpu_mask() from non-leaf
      rcu: Fix exp_funnel_lock()/rcu_exp_wait_wake() datarace
      rcu: Provide debug symbols and line numbers in KCSAN runs
      rcu: Add WRITE_ONCE() to rcu_node ->qsmask update
      rcu: Add WRITE_ONCE to rcu_node ->exp_seq_rq store
      rcu: Add READ_ONCE() to rcu_node ->gp_seq
      rcu: Add WRITE_ONCE() to rcu_state ->gp_req_activity
      rcu: Add WRITE_ONCE() to rcu_node ->qsmaskinitnext
      locking/rtmutex: rcu: Add WRITE_ONCE() to rt_mutex ->owner
      rcu: Add READ_ONCE() to rcu_segcblist ->tails[]
      rcu: Add *_ONCE() for grace-period progress indicators
      rcu: Add READ_ONCE() to rcu_data ->gpwrap
      rcu: Add *_ONCE() to rcu_data ->rcu_forced_tick
      rcu: Add *_ONCE() to rcu_node ->boost_kthread_status
      rcu: Remove dead code from rcu_segcblist_insert_pend_cbs()
      rcu: Add WRITE_ONCE() to rcu_state ->gp_start
      rcu: Fix rcu_barrier_callback() race condition
      rcu: Don't flag non-starting GPs before GP kthread is running
      rcu: Optimize and protect atomic_cmpxchg() loop
      rcu: Tighten rcu_lockdep_assert_cblist_protected() check
      rcu: Make nocb_gp_wait() double-check unexpected-callback warning
      locktorture: Print ratio of acquisitions, not failures
      locktorture: Allow CPU-hotplug to be disabled via --bootargs
      locktorture: Use private random-number generators
      locktorture: Forgive apparent unfairness if CPU hotplug
      rcu: Clear ->core_needs_qs at GP end or self-reported QS
      rcu: React to callback overload by aggressively seeking quiescent states
      rcu: React to callback overload by boosting RCU readers
      rcu: Update __call_rcu() comments
      rcu-tasks: *_ONCE() for rcu_tasks_cbs_head
      srcu: Fix __call_srcu()/process_srcu() datarace
      srcu: Fix __call_srcu()/srcu_get_delay() datarace
      srcu: Fix process_srcu()/srcu_batches_completed() datarace
      srcu: Hold srcu_struct ->lock when updating ->srcu_gp_seq
      rcutorture: Suppress forward-progress complaints during early boot
      torture: Make results-directory date format completion-friendly
      rcutorture: Refrain from callback flooding during boot
      torture: Forgive -EBUSY from boottime CPU-hotplug operations
      rcutorture: Allow boottime stall warnings to be suppressed
      rcutorture: Suppress boottime bad-sequence warnings
      torture: Allow disabling of boottime CPU-hotplug torture operations
      rcutorture: Add 100-CPU configuration
      rcutorture: Summarize summary of build and run results
      rcutorture: Make kvm-find-errors.sh abort on bad directory
      rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race
      rcutorture: Fix stray access to rcu_fwd_cb_nodelay
      rcutorture: Add READ_ONCE() to rcu_torture_count and rcu_torture_batch
      rcutorture: Annotation lockless accesses to rcu_torture_current
      rcutorture: Make rcu_torture_barrier_cbs() post from corresponding CPU
      rcutorture: Manually clean up after rcu_barrier() failure
      rcutorture: Set KCSAN Kconfig options to detect more data races
      doc: Add rcutorture scripting to torture.txt
      rcu: Mark rcu_state.gp_seq to detect concurrent writes
      rcu: Make rcu_barrier() account for offline no-CBs CPUs
      Merge branches 'doc.2020.02.27a', 'fixes.2020.02.27a', 'kfree_rcu.2020.02.20a', 'locktorture.2020.02.20a', 'ovld.2020.02.20a', 'rcu-tasks.2020.02.20a', 'srcu.2020.02.20a' and 'torture.2020.02.20a' into HEAD

SeongJae Park (8):
      rcu: Fix typos in file-header comments
      doc/RCU/Design: Remove remaining HTML tags in ReST files
      doc/RCU/listRCU: Fix typos in a example code snippets
      doc/RCU/listRCU: Update example function name
      doc/RCU/rcu: Use ':ref:' for links to other docs
      doc/RCU/rcu: Use absolute paths for non-rst files
      doc/RCU/rcu: Use https instead of http if possible
      Documentation/memory-barriers: Fix typos

Uladzislau Rezki (Sony) (2):
      rcu: Support kfree_bulk() interface in kfree_rcu()
      rcu: Add a trace event for kfree_rcu() use of kfree_bulk()

 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |   8 +-
 Documentation/RCU/listRCU.rst                      | 281 ++++++++++---
 Documentation/RCU/rcu.rst                          |  18 +-
 Documentation/RCU/torture.txt                      | 147 ++++++-
 Documentation/admin-guide/kernel-parameters.txt    |  19 +
 Documentation/memory-barriers.txt                  |   8 +-
 fs/nfs/dir.c                                       |   2 +-
 include/linux/rculist.h                            |   4 +-
 include/linux/rcutiny.h                            |   1 +
 include/linux/rcutree.h                            |   1 +
 include/linux/timer.h                              |   2 +-
 include/trace/events/rcu.h                         |  29 ++
 kernel/locking/locktorture.c                       |  15 +-
 kernel/locking/rtmutex.c                           |   2 +-
 kernel/rcu/Makefile                                |   4 +
 kernel/rcu/rcu.h                                   |  23 +-
 kernel/rcu/rcu_segcblist.c                         |   4 +-
 kernel/rcu/rcuperf.c                               |  14 +-
 kernel/rcu/rcutorture.c                            |  67 ++-
 kernel/rcu/srcutree.c                              |  18 +-
 kernel/rcu/tree.c                                  | 454 ++++++++++++++++-----
 kernel/rcu/tree.h                                  |   4 +
 kernel/rcu/tree_exp.h                              |  13 +-
 kernel/rcu/tree_plugin.h                           |  25 +-
 kernel/rcu/tree_stall.h                            |  41 +-
 kernel/rcu/update.c                                |  28 +-
 kernel/time/timer.c                                |   7 +-
 kernel/torture.c                                   |  29 +-
 .../testing/selftests/rcutorture/bin/functions.sh  |   2 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   2 +
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  17 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   2 +-
 .../selftests/rcutorture/configs/rcu/CFcommon      |   2 +
 .../selftests/rcutorture/configs/rcu/TREE10        |  18 +
 34 files changed, 1017 insertions(+), 294 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE10
