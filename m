Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8330567F;
	Sun, 23 Aug 2026 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787528514; cv=none; b=u5sCpSIDtd1z+pms2dZlkBOhizlGkn+pigxNXNHbR2pzl0hE67s8+cCq9nENBqGVYTSbr6EG7rQx7N3EIig31E3DBqy70NeFc6UlUyb7jA2DY1GSS5nsfwxy+z21qU6v4Eo+bVmoO1rtMGWeybHQ5ZponqdUbL0JcaZ3Xnn/TZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787528514; c=relaxed/simple;
	bh=nPGK12TWlPjGS4e4CIfRJiJqpkdIcZbv51xEnw2VVz8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AyGsYtKEcI0LsJU+wxBp5sUOgoGg7dU3y4vmIUu5gu97FDvsprbSYI+txBlNL9/KDpVqwgS1bDQ59wSwxEp4MNpwBgWcD2jJUc6Jp2RtJR9+B2UvdkET9/+fc1k2LA4KzyiyEktjkHNFc4Gtlu16MogRadR7brzrMRYzA4INi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeKM/h6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeKM/h6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57781F000E9;
	Sun, 23 Aug 2026 23:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787528512;
	bh=0KI2O9a6bywg6PkIzf7Dk275K2FWzW7jGmdN8tKIx78=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=AeKM/h6AOIsIZ6eXKk8q9fEFyzj+7z7ysoZAIbVGgeudzAA436bV9b8Mi3jcKgjHn
	 TiVCmhpbKYaHhAKLNZdcUnCdPB9m5g1IWUvV8MayLc1YODwIsyf49cRTcGZsIQhNVi
	 FL8czIJ5VBdTUsQ1wNSx6Eq2S/erX0tIknKjpBx1RnTGOog8VjyrrXWrdCfireY4yf
	 na3GAD1BE+LLlqgwyk+NIxX6YsWexPQCM33GU2ytENbplpG+Q8Tvtj+1ZpWtQKPl6n
	 linRYo9bYExWsiV2+DLBOnXuinpMGvZObif2C9BU1O+xelFy2NxV5kqZt4TITwEGsQ
	 U2NE7y06WvErg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5FD9BCE09CD; Sun, 23 Aug 2026 16:41:52 -0700 (PDT)
Date: Sun, 23 Aug 2026 16:41:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org,
	puranjay@kernel.org, kunwu.chan@gmail.com, manuelebner@mailbox.org,
	joelagnelf@nvidia.com, qiang.zhang@linux.dev,
	itai.handler@gmail.com, work@onurozkan.dev
Subject: [GIT PULL] RCU changes for v7.3
Message-ID: <930b6c91-c426-46f0-b193-22c1e984f5e2@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, Linus,

Please pull this RCU update:
  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux tags/rcu.2026.08.18a
  # HEAD: 9cc63f8bcd560c760d0b12e15bba8f81c86237cf: Merge branches 'expcb.2026.07.24a', 'misc.2026.07.30a', 'rcu-tasks.2026.07.30a', 'srcu.2026.08.11a' and 'torture.2026.08.14a' into HEAD (2026-08-14 15:43:51 -0700)

----------------------------------------------------------------
RCU updates:

Make expedited grace periods expedite normal RCU callbacks

Miscellaneous fixes:
 * Improve diagnostic output with character task states.
 * Mark accesses to inform KCSAN of concurrency design.
 * Move from kmalloc() to kmalloc_obj().
 * Documentation updates.
 * Improve handling of RCU deferred quiescent states.
 * Clean up unused function arguments and structure fields.
 * Reduce show_rcu_gp_kthreads() stack space.

Tasks RCU updates:
 * Clean up after SRCU re-implementation of Tasks Trace RCU.
 * Mark accesses to inform KCSAN of concurrency design.
 * Add ->lazy_timer status to diagnostic output.
 * Remove an unnecessary memory barrier.
 * Fix a data race, courtesy of KCSAN.
 * Documentation updates.
 * Convert cond_resched_tasks_rcu_qs() from macro to static inline
   function.

SRCU updates:
 * Add Rust helpers for SRCU.
 * Avoid losing queued work at cleanup_srcu_struct() time.

Torture-test updates:
 * Preparation work for immediate RCU priority deboosting.
 * Test RCU readers from real interrupt handlers (as opposed to softirq).
 * Simplify code through use of cpumask_next_wrap().
 * Improve diagnostic output with character task states.
 * Add rcutorture.nwriters parameter to allow lightweight stall testing,
   and rcutorture.stall_only to make doing so easier.
 * Test an RCU Tasks Trace grace period implying an RCU grace period.
 * Make RCU Tasks Trace torturing track reader batches.
 * Fix a data race, courtesy of KCSAN.
 * Plug a shuffle_tmp_mask memory leak on kthread spawn failure.

----------------------------------------------------------------
Itai Handler (1):
      rcu: Mark accesses to ->rcu_urgent_qs and ->rcu_need_heavy_qs

Joel Fernandes (6):
      rcu: Remove unused rdp parameter from trace_rcu_this_gp()
      rcu: introduce rcu_defer_qs_clear() helper
      rcu: clear defer_qs_pending in deferred-QS bail when nesting > 0
      rcu: Remove unused expedited_need_qs field from rcu_state
      rcu: Remove unused func parameter from callback-enqueue functions
      torture: Don't leak shuffle_tmp_mask when shuffler kthread fails to start

Kunwu Chan (2):
      rcu: Use task_state_to_char() in stall-warning prints
      rcutorture: Use task_state_to_char() for task-state reporting

Manuel Ebner (2):
      doc: RCU: Adopt new coding style of type-aware kmalloc-family - part 2/2
      doc: RCU: Fix brackets

Onur Özkan (5):
      srcu: make init_srcu_struct() consistently wrap __init_srcu_struct()
      rust: helpers: add SRCU helpers
      srcu: expose srcu_readers_active()
      rust: sync: add SRCU abstraction
      MAINTAINERS: add Rust SRCU files to SRCU entry

Paul E. McKenney (23):
      rcu-tasks: TASKS_TRACE_RCU doesn't need IRQ_WORK
      rcutorture: Abstract reader-segment dump into rcu_torture_dump_read_segs()
      rcu: Mark __rcu_access_pointer() as context_unsafe()
      rcu-tasks: Apply READ_ONCE() and WRITE_ONCE() to fix data race
      rcu: Use this_cpu_{read,write}() for ->cpu_no_qs.b.exp
      rcu: Use WRITE_ONCE() for ->rcu_need_heavy_qs
      rcu: Mark accesses to rdp->rcu_cpu_has_work
      rcu-tasks: Fix IRQ read lock/unlock data race
      rcu: Mark interrupts-enabled accesses to rdp->cpu_no_qs.b.norm
      rcu: Mark interrupts-enabled accesses to rdp->cpu_no_qs.s
      rcu-tasks: Convert cond_resched_tasks_rcu_qs() to static inline
      rcutorture: Check for immediate deboosting at reader end
      rcutorture: Test RCU readers from hardware interrupt handlers
      rcutorture: Use cpumask_next_wrap() in rcu_torture_preempt()
      rcutorture: Add nwriters module parameter
      rcutorture: Add a stall_only module parameter
      rcutorture: Test RCU Tasks Trace GP implying RCU GP
      rcutorture: Make RCU Tasks Trace track Reader Batches
      rcutorture: Use this_cpu_inc() for rcu_torture_count[] and rcu_torture_batch[]
      rcutorture: Announce declining to forward-progress test
      rcutorture: Make {,s}rcu_read_delay() better handle forward-progress testing
      rcu: Add closing parenthesis in comment in rcu_read_unlock_strict()
      Merge branches 'expcb.2026.07.24a', 'misc.2026.07.30a', 'rcu-tasks.2026.07.30a', 'srcu.2026.08.11a' and 'torture.2026.08.14a' into HEAD

Puranjay Mohan (11):
      rcu: Rename struct rcu_gp_oldstate to rcu_gp_seq
      rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
      rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
      rcu/segcblist: Track segment grace periods with struct rcu_gp_seq
      rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited GPs
      rcu: Enable RCU callbacks to benefit from expedited grace periods
      rcu: Update comments for gp_seq and expedited GP tracking
      rcu: Wake NOCB rcuog kthreads on expedited grace period completion
      rcu: Detect expedited grace period completion in rcu_pending()
      rcu: Advance callbacks for expedited GP completion in rcu_core()
      rcuscale: Add concurrent expedited GP threads for callback scaling tests

Zqiang (10):
      rcu-tasks: Remove unused struct rcu_tasks's->n_ipis_fails variables
      rcu-tasks: Dump rcu tasks status when the boot-test failed
      rcu-tasks: Remove smp_mb() in rcu_spawn_tasks_kthread_generic()
      rcu-tasks: Update comments in call_rcu_tasks_generic()
      rcu-tasks: Dump rtpcp->lazy_timer status in show_rcu_tasks_generic_gp_kthread()
      rcu: Remove unused rdp parameter from rcu_check_gp_start_stall()
      rcu: Reduce stack usage in show_rcu_gp_kthreads()
      rcu-tasks: Rename tasks_rcu_exit_srcu_stall_timer to tasks_rcu_exit_stall_timer
      rcu-tasks: Fix some comments for call_rcu_tasks() and call_rcu_tasks_rude()
      srcu: Queue sdp->work when the delay timer is successfully deleted

 .../Expedited-Grace-Periods.rst                    |   2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |   2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg      |   2 +-
 .../RCU/Design/Requirements/Requirements.rst       |   2 +-
 Documentation/RCU/rcu_dereference.rst              |   4 +-
 Documentation/admin-guide/kernel-parameters.txt    |  14 +
 MAINTAINERS                                        |   3 +
 include/linux/rcu_segcblist.h                      |  16 +-
 include/linux/rcupdate.h                           |  29 +-
 include/linux/rcupdate_trace.h                     |  19 +-
 include/linux/rcupdate_wait.h                      |   2 +-
 include/linux/rcutiny.h                            |  36 +-
 include/linux/rcutree.h                            |  29 +-
 include/linux/srcu.h                               |  29 +-
 include/linux/srcutiny.h                           |  13 +
 include/linux/srcutree.h                           |  24 ++
 include/trace/events/rcu.h                         |   5 +-
 kernel/rcu/Kconfig                                 |   1 -
 kernel/rcu/rcu.h                                   |  20 +-
 kernel/rcu/rcu_segcblist.c                         | 139 +++++---
 kernel/rcu/rcu_segcblist.h                         |   8 +-
 kernel/rcu/rcuscale.c                              |  84 ++++-
 kernel/rcu/rcutorture.c                            | 374 ++++++++++++++-------
 kernel/rcu/srcutiny.c                              |  14 +-
 kernel/rcu/srcutree.c                              |  57 ++--
 kernel/rcu/tasks.h                                 |  62 ++--
 kernel/rcu/tiny.c                                  |   4 +-
 kernel/rcu/tree.c                                  | 195 +++++++----
 kernel/rcu/tree.h                                  |  14 +-
 kernel/rcu/tree_exp.h                              |  24 +-
 kernel/rcu/tree_nocb.h                             | 126 +++++--
 kernel/rcu/tree_plugin.h                           |  93 ++++-
 kernel/rcu/tree_stall.h                            |  64 ++--
 kernel/torture.c                                   |   7 +-
 mm/slab_common.c                                   |   6 +-
 rust/helpers/helpers.c                             |   1 +
 rust/helpers/srcu.c                                |  35 ++
 rust/kernel/sync.rs                                |   2 +
 rust/kernel/sync/srcu.rs                           | 171 ++++++++++
 39 files changed, 1251 insertions(+), 481 deletions(-)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs
