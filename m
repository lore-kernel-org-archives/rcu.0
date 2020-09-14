Return-Path: <SRS0=r7Mw=CX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44308C433E2
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086B5208B3
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600105574;
	bh=3wv5YYaOrtwO17mATcoJS3+/FHc69mJnFaSTkKbnTVo=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=Rac6+KYQ2OiMZPRfUAGXogv/rGMi1oargYHu2DnFhlmLicQ6R1NVqemQsjWoznDE0
	 bnK2mI2AqwfbYx85NX5QO5sj8tSSzxbL5z8yu2TEezAjcPodG+HVveHjsSQITn6sWG
	 PNvLjb+2OELZ8xHSvL48G3s8qz6EGaH9vYFUYGEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgINRqM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgINRqI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Sep 2020 13:46:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B880F20759;
        Mon, 14 Sep 2020 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600105567;
        bh=3wv5YYaOrtwO17mATcoJS3+/FHc69mJnFaSTkKbnTVo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Kw1qKfruwUZ1BsB+fT0TQAz1qtOTq5XgFUYqCtidQOVyotF7es3WLj+oShzjCBKIu
         0A73Q5YgwYRXvP3RKyiSIu2XMlB1Tlh2aQ/0Ztg8sLUI90cohJ0ALimIxIoaUeF4hs
         23YEL+cFl3CttK+flMJhAsuzfuY3R+EqKcj1zKNI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 80E453522BA0; Mon, 14 Sep 2020 10:46:07 -0700 (PDT)
Date:   Mon, 14 Sep 2020 10:46:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        colin.king@canonical.com, grandmaster@al2klimov.de,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com,
        neeraju@codeaurora.org, paul.gortmaker@windriver.com,
        qiang.zhang@windriver.com, rdunlap@infradead.org,
        tklauser@distanz.ch, weiyongjun1@huawei.com, kernel-team@fb.com
Subject: [GIT PULL tip/core/rcu] RCU commits for v5.10
Message-ID: <20200914174607.GA12722@paulmck-ThinkPad-P72>
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

	https://lore.kernel.org/lkml/20200831175419.GA31013@paulmck-ThinkPad-P72

2.	Miscellaneous fixes.

	https://lore.kernel.org/lkml/20200831180050.GA32590@paulmck-ThinkPad-P72

3.	Torture-test updates.

	https://lore.kernel.org/lkml/20200831180348.GA416@paulmck-ThinkPad-P72

4.	New smp_call_function() torture test.

	https://lore.kernel.org/lkml/20200831180731.GA582@paulmck-ThinkPad-P72

5.	Strict grace periods for KASAN.  The point of this series is to find
	RCU-usage bugs, so the corresponding new RCU_STRICT_GRACE_PERIOD
	Kconfig option depends on both DEBUG_KERNEL and RCU_EXPERT, and is
	further disabled by dfefault.  Finally, the help text includes
	a goodly list of scary caveats.

	https://lore.kernel.org/lkml/20200831181101.GA950@paulmck-ThinkPad-P72

6.	Debugging for smp_call_function().

	https://lore.kernel.org/lkml/20200831181356.GA1224@paulmck-ThinkPad-P72

The fix for the kvfree_rcu() issue noted by Sebastian in response to my
v5.9 pull request is still in the works, as was discussed at the end
of the Real Time Microconference at Linux Plumbers Conference a few
weeks ago.  Uladislau has produced early prototype patches following
the plan outlined at that Microconference.  Initial testing results
are encouraging, so I hope to be able to include them in my v5.11 pull
request.  I had of course hoped to include these fixes in this pull
request, and the reason for the additional delay is that the first N
proposed solutions all had fatal flaws.  I nevertheless have high hopes
for the current proposed solution N+1.

In the meantime, all of the commits in this pull request have been
subjected to the kbuild test robot and -next testing, and are available
in the git repository based on 5.9-rc1 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 6fe208f63a79f4f726f3be2b78ea3dd40487b657:

  Merge branch 'csd.2020.09.04a' into HEAD (2020-09-04 11:54:52 -0700)

----------------------------------------------------------------
Alexander A. Klimov (1):
      rcutorture: Replace HTTP links with HTTPS ones

Colin Ian King (1):
      refperf: Avoid null pointer dereference when buf fails to allocate

Joel Fernandes (Google) (6):
      rcu/trace: Print negative GP numbers correctly
      rcu/trace: Use gp_seq_req in acceleration's rcu_grace_period tracepoint
      rcu: Clarify comments about FQS loop reporting quiescent states
      rcu: Make FQS more aggressive in complaining about offline CPUs
      rcutorture: Output number of elapsed grace periods
      rcu/segcblist: Prevent useless GP start if no CBs to accelerate

Madhuparna Bhowmik (2):
      rculist: Introduce list/hlist_for_each_entry_srcu() macros
      kvm: mmu: page_track: Fix RCU list API usage

Neeraj Upadhyay (2):
      rcu/tree: Force quiescent state on callback overload
      rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp()

Paul E. McKenney (60):
      lib: Add backtrace_idle parameter to force backtrace of idle CPUs
      rcu: Remove KCSAN stubs
      rcu: Remove KCSAN stubs from update.c
      srcu: Remove KCSAN stubs
      rcu: Initialize at declaration time in rcu_exp_handler()
      nocb: Clarify RCU nocb CPU error message
      nocb: Remove show_rcu_nocb_state() false positive printout
      rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor
      rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_resched_ns
      rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_kick_kthreads
      rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_cpu_stall_ftrace_dump
      rcu: Move rcu_cpu_started per-CPU variable to rcu_data
      rcu/nocb: Add a warning for non-GP kthread running GP code
      rcu: Remove unused __rcu_is_watching() function
      scftorture: Add smp_call_function() torture test
      torture: Declare parse-console.sh independence from rcutorture
      torture: Add scftorture to the rcutorture scripting
      scftorture: Implement weighted primitive selection
      tick-sched: Clarify "NOHZ: local_softirq_pending" warning
      scftorture: Summarize per-thread statistics
      scftorture: Add smp_call_function_single() memory-ordering checks
      scftorture: Add smp_call_function_many() memory-ordering checks
      scftorture: Add smp_call_function() memory-ordering checks
      scftorture: Consolidate scftorture_invoke_one() check and kfree()
      scftorture: Consolidate scftorture_invoke_one() scf_check initialization
      scftorture: Flag errors in torture-compatible manner
      scftorture: Prevent compiler from reducing race probabilities
      scftorture: Check unexpected "switch" statement value
      scftorture: Block scftorture_invoker() kthreads for offline CPUs
      scftorture: Adapt memory-ordering test to UP operation
      scftorture: Add cond_resched() to test loop
      rcuperf: Change rcuperf to rcuscale
      rcu: Add Kconfig option for strict RCU grace periods
      rcu: Reduce leaf fanout for strict RCU grace periods
      rcu: Restrict default jiffies_till_first_fqs for strict RCU GPs
      rcu: Force DEFAULT_RCU_BLIMIT to 1000 for strict RCU GPs
      rcu: Always set .need_qs from __rcu_read_lock() for strict GPs
      rcu: Do full report for .need_qs for strict GPs
      rcu: Attempt QS when CPU discovers GP for strict GPs
      rcu: IPI all CPUs at GP start for strict GPs
      rcu: IPI all CPUs at GP end for strict GPs
      rcu: Provide optional RCU-reader exit delay for strict GPs
      rcu: Execute RCU reader shortly after rcu_core for strict GPs
      rcu: Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs
      rcu: Remove unused "cpu" parameter from rcu_report_qs_rdp()
      rcutorture: Remove KCSAN stubs
      torture: Update initrd documentation
      rcutorture: Add CONFIG_PROVE_RCU_LIST to TREE05
      torture: Add kvm.sh --help and update help message
      rcutorture: Properly set rcu_fwds for OOM handling
      rcutorture: Properly synchronize with OOM notifier
      rcutorture: Hoist OOM registry up one level
      rcutorture: Allow pointer leaks to test diagnostic code
      torture: Add gdb support
      Merge branches 'doc.2020.08.24a', 'fixes.2020.09.03b' and 'torture.2020.08.24a' into HEAD
      Merge branch 'scftorture.2020.08.24a' into HEAD
      Merge branch 'strictgp.2020.08.24a' into HEAD
      smp: Add source and destination CPUs to __call_single_data
      kernel/smp: Provide CSD lock timeout diagnostics
      Merge branch 'csd.2020.09.04a' into HEAD

Paul Gortmaker (1):
      torture: document --allcpus argument added to the kvm.sh script

Randy Dunlap (2):
      doc: Drop doubled words from RCU Data-Structures.rst
      doc: Drop doubled words from RCU requirements documentation

Tobias Klauser (2):
      docs: Fix typo in synchronize_rcu() function name
      rcu: Fix kerneldoc comments in rcupdate.h

Wei Yongjun (3):
      scftorture: Make symbol 'scf_torture_rand' static
      locktorture: Make function torture_percpu_rwsem_init() static
      smp: Make symbol 'csd_bug_count' static

Zqiang (1):
      rcu: Shrink each possible cpu krcp

 .../RCU/Design/Data-Structures/Data-Structures.rst |   2 +-
 .../RCU/Design/Requirements/Requirements.rst       |   4 +-
 Documentation/RCU/whatisRCU.rst                    |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    | 153 +++++-
 MAINTAINERS                                        |   3 +-
 arch/x86/kvm/mmu/page_track.c                      |   6 +-
 include/linux/rculist.h                            |  48 ++
 include/linux/rcupdate.h                           |  19 +-
 include/linux/rcutiny.h                            |   1 -
 include/linux/rcutree.h                            |   1 -
 include/linux/smp.h                                |   3 +
 include/linux/smp_types.h                          |   3 +
 include/trace/events/rcu.h                         |  54 +-
 kernel/Makefile                                    |   2 +
 kernel/entry/common.c                              |   2 +-
 kernel/locking/locktorture.c                       |   2 +-
 kernel/rcu/Kconfig                                 |   8 +-
 kernel/rcu/Kconfig.debug                           |  17 +-
 kernel/rcu/Makefile                                |   2 +-
 kernel/rcu/rcu_segcblist.c                         |  10 +-
 kernel/rcu/{rcuperf.c => rcuscale.c}               | 330 ++++++------
 kernel/rcu/rcutorture.c                            |  61 ++-
 kernel/rcu/refscale.c                              |   8 +-
 kernel/rcu/srcutree.c                              |  13 -
 kernel/rcu/tree.c                                  | 165 ++++--
 kernel/rcu/tree.h                                  |   2 +
 kernel/rcu/tree_exp.h                              |   6 +-
 kernel/rcu/tree_plugin.h                           |  40 +-
 kernel/rcu/tree_stall.h                            |   8 +-
 kernel/rcu/update.c                                |  13 -
 kernel/scftorture.c                                | 575 +++++++++++++++++++++
 kernel/smp.c                                       | 134 +++++
 kernel/time/tick-sched.c                           |   2 +-
 lib/Kconfig.debug                                  |  21 +
 lib/nmi_backtrace.c                                |   6 +-
 ...rf-ftrace.sh => kvm-recheck-rcuscale-ftrace.sh} |   6 +-
 ...-recheck-rcuperf.sh => kvm-recheck-rcuscale.sh} |  14 +-
 .../selftests/rcutorture/bin/kvm-recheck-scf.sh    |  38 ++
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  33 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  36 +-
 .../selftests/rcutorture/bin/parse-console.sh      |  11 +-
 .../selftests/rcutorture/configs/rcu/TREE05        |   1 +
 .../selftests/rcutorture/configs/rcuperf/CFcommon  |   2 -
 .../configs/{rcuperf => rcuscale}/CFLIST           |   0
 .../selftests/rcutorture/configs/rcuscale/CFcommon |   2 +
 .../rcutorture/configs/{rcuperf => rcuscale}/TINY  |   0
 .../rcutorture/configs/{rcuperf => rcuscale}/TREE  |   0
 .../configs/{rcuperf => rcuscale}/TREE54           |   0
 .../configs/{rcuperf => rcuscale}/ver_functions.sh |   4 +-
 .../selftests/rcutorture/configs/scf/CFLIST        |   2 +
 .../selftests/rcutorture/configs/scf/CFcommon      |   2 +
 .../selftests/rcutorture/configs/scf/NOPREEMPT     |   9 +
 .../rcutorture/configs/scf/NOPREEMPT.boot          |   1 +
 .../selftests/rcutorture/configs/scf/PREEMPT       |   9 +
 .../rcutorture/configs/scf/ver_functions.sh        |  30 ++
 tools/testing/selftests/rcutorture/doc/initrd.txt  |  36 +-
 .../selftests/rcutorture/doc/rcu-test-image.txt    |  41 +-
 57 files changed, 1582 insertions(+), 421 deletions(-)
 rename kernel/rcu/{rcuperf.c => rcuscale.c} (64%)
 create mode 100644 kernel/scftorture.c
 rename tools/testing/selftests/rcutorture/bin/{kvm-recheck-rcuperf-ftrace.sh => kvm-recheck-rcuscale-ftrace.sh} (92%)
 rename tools/testing/selftests/rcutorture/bin/{kvm-recheck-rcuperf.sh => kvm-recheck-rcuscale.sh} (84%)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/CFLIST (100%)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TINY (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TREE (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TREE54 (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/ver_functions.sh (88%)
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
