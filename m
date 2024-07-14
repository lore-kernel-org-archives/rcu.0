Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED753389;
	Sun, 14 Jul 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720975425; cv=none; b=DtRqM5LZc8ciKflgPyFc3aA4vDsmPM2dC3507JwiGZr8t48HHKfnshfOuY6khrCt/Ui5KtjdKkcfPLrAuW3hntQgR/7OCXYmAiKQ3zz67P3mk80xLnq1kkyUqC2QTvqM5taIGQk1V9BKV0wI9pVi3k5FuTGjz2/KtA5dalWlgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720975425; c=relaxed/simple;
	bh=Bv8Vsfv9FUrCSHbCSe7Yyi93IbUqroEiRbR7NWZY7CA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=amW72n7EQ79fEDxXb3JFpHbAXUAYbiz+kh1ZIAqy1j7jqJy0pCIwf+kuj8sK/FNGq8C5ZGJseItUi5M710uyDXRajDYb97iqPE343pHiJcsH8KfhVpl1i6uK+anoeB1Aspv+N/rn2HIaCUMEKj3YWHemdk8FbWTnvozJw28F2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUPy9xBz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUPy9xBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141C1C116B1;
	Sun, 14 Jul 2024 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720975425;
	bh=Bv8Vsfv9FUrCSHbCSe7Yyi93IbUqroEiRbR7NWZY7CA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=XUPy9xBz4RuqfpK9bHGSwzOxpZD4uEFogbP7MsPsnhHeMhE4H3jT1uKIYQFdwnGGB
	 2ZgjmkJJmQlq7BLupn/vDM+8snziRr/G1yC+wTGXBAI2jMPdOPRF00w2VaMmphW6fR
	 fVOcW4LUTLM1g9oV9Rq7nVST6+vfWnoxr/cS08sM52nHcb8BrHbZKFIxqDm5Q26PeB
	 0mNsdw2LGaPiYr4C95beG6yXkoUz2cTlFpyoHnvWY5oa/JjtvxAKyrLhTRdO/CBZCe
	 n+fHLWnT7SCC3PmQgaEBkhCIcKE8Tj4af1ZXizTWnSF8Advs8ppaIZYz6WZ4gpCPZc
	 iaZkvVawfRWRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A0177CE0B34; Sun, 14 Jul 2024 09:43:44 -0700 (PDT)
Date: Sun, 14 Jul 2024 09:43:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@kernel.org,
	tglx@linutronix.de, rcu@vger.kernel.org, joel@joelfernandes.org,
	oleg@redhat.com, frederic@kernel.org, qiang.zhang1211@gmail.com,
	quic_jjohnson@quicinc.com
Subject: [GIT PULL] RCU changes for v6.11
Message-ID: <22048c72-ae8c-47c0-9cd8-3a64f84fcaea@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

When the merge window opens, please pull this RCU update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2024.07.12a
  # HEAD: 02219caa92b5b0ed97f8d8b9cf580f6f34a9be31: Merge branches 'doc.2024.06.06a', 'fixes.2024.07.04a', 'mb.2024.06.28a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a', 'rcutorture.2024.06.06a' and 'srcu.2024.06.18a' into HEAD (2024-07-04 13:54:17 -0700)

----------------------------------------------------------------
RCU pull request for v6.11

doc.2024.06.06a: Update Tasks RCU and Tasks Rude RCU description in
	Requirements.rst and clarify rcu_assign_pointer() and
	rcu_dereference() ordering properties.

fixes.2024.07.04a: Add lockdep assertions for RCU readers, limit inline
	wakeups for callback-bypass synchronize_rcu(), add an
	rcutree.nohz_full_patience_delay to reduce nohz_full OS jitter,
	add Uladzislau Rezki as RCU maintainer, and fix a subtle
	callback-migration memory-ordering issue.

mb.2024.06.28a: Remove a number of redundant memory barriers.

nocb.2024.06.03a: Remove unnecessary bypass-list lock-contention
	mitigation, use parking API instead of open-coded ad-hoc
	equivalent, and upgrade obsolete comments.

rcu-tasks.2024.06.06a: Revert avoidance of a deadlock that can no
	longer occur and properly synchronize Tasks Trace RCU checking
	of runqueues.

rcutorture.2024.06.06a: Add tests for handling of double-call_rcu()
	bug, add missing MODULE_DESCRIPTION, and add a script that
	histograms the number of calls to RCU updaters.

srcu.2024.06.18a: Fill out SRCU polled-grace-period API.

----------------------------------------------------------------
Frederic Weisbecker (13):
      rcu/nocb: Fix segcblist state machine comments about bypass
      rcu/nocb: Fix segcblist state machine stale comments about timers
      rcu/nocb: Use kthread parking instead of ad-hoc implementation
      rcu/nocb: Remove buggy bypass lock contention mitigation
      Revert "rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()"
      rcu/tasks: Fix stale task snaphot for Tasks Trace
      rcu: Remove full ordering on second EQS snapshot
      rcu: Remove superfluous full memory barrier upon first EQS snapshot
      rcu/exp: Remove superfluous full memory barrier upon first EQS snapshot
      rcu: Remove full memory barrier on boot time eqs sanity check
      rcu: Remove full memory barrier on RCU stall printout
      rcu/exp: Remove redundant full memory barrier at the end of GP
      rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation

Jeff Johnson (1):
      rcutorture: Add missing MODULE_DESCRIPTION() macros

Joel Fernandes (Google) (1):
      rcu/tree: Reduce wake up for synchronize_rcu() common case

Oleg Nesterov (1):
      rcu: Eliminate lockless accesses to rcu_sync->gp_count

Paul E. McKenney (13):
      rcu: Add lockdep_assert_in_rcu_read_lock() and friends
      doc: Update Tasks RCU and Tasks Rude RCU description in Requirements.rst
      doc: Clarify rcu_assign_pointer() and rcu_dereference() ordering
      rcutorture: Fix rcu_torture_fwd_cb_cr() data race
      tools/rcu: Add rcu-updaters.sh script
      rcu: Disable interrupts directly in rcu_gp_init()
      srcu: Disable interrupts directly in srcu_gp_end()
      srcu: Add NUM_ACTIVE_SRCU_POLL_OLDSTATE
      srcu: Update cleanup_srcu_struct() comment
      srcu: Fill out polled grace-period APIs
      rcu: Add rcutree.nohz_full_patience_delay to reduce nohz_full OS jitter
      MAINTAINERS: Add Uladzislau Rezki as RCU maintainer
      Merge branches 'doc.2024.06.06a', 'fixes.2024.07.04a', 'mb.2024.06.28a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a', 'rcutorture.2024.06.06a' and 'srcu.2024.06.18a' into HEAD

Zqiang (1):
      rcutorture: Make rcutorture support srcu double call test

 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |   6 +-
 .../RCU/Design/Requirements/Requirements.rst       |  16 +++
 Documentation/RCU/whatisRCU.rst                    |  30 +++--
 Documentation/admin-guide/kernel-parameters.txt    |   8 ++
 MAINTAINERS                                        |   1 +
 include/linux/rcu_segcblist.h                      |  88 ++++++------
 include/linux/rcupdate.h                           |  62 ++++++++-
 include/linux/srcu.h                               |  35 +++++
 kernel/pid_namespace.c                             |  17 ---
 kernel/rcu/rcuscale.c                              |   1 +
 kernel/rcu/rcutorture.c                            |  49 ++++---
 kernel/rcu/refscale.c                              |   1 +
 kernel/rcu/srcutiny.c                              |   3 +-
 kernel/rcu/srcutree.c                              |  13 +-
 kernel/rcu/sync.c                                  |  12 +-
 kernel/rcu/tasks.h                                 |  26 ++--
 kernel/rcu/tree.c                                  |  92 +++++++++----
 kernel/rcu/tree.h                                  |   2 +-
 kernel/rcu/tree_exp.h                              |  24 +++-
 kernel/rcu/tree_nocb.h                             | 147 ++++++---------------
 kernel/rcu/tree_plugin.h                           |  14 +-
 kernel/rcu/tree_stall.h                            |   4 +-
 kernel/sched/core.c                                |  14 +-
 tools/rcu/rcu-updaters.sh                          |  52 ++++++++
 24 files changed, 439 insertions(+), 278 deletions(-)
 create mode 100755 tools/rcu/rcu-updaters.sh
