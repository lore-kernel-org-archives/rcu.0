Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068472472AE;
	Sun, 18 Oct 2026 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792283129; cv=none; b=WjWaVQtGsmYggLrRbzk2E/BA5KI76MYk5GL7gDzpAUXW46jLdNMOSBJl85dEJKOa93zQGz8PV84cUdUWUl/5HOOdieGYqWGNrlqqml7TC2FwWGmgN3ia7qmN+QafzKdE8oERCoB1xdv7zCgtT2driJIXp9raCDyryowKVsQuIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792283129; c=relaxed/simple;
	bh=0iTlyyb80tJ+ZXrZ9oijfrFxGUcpJypCtmeNET/Zq7E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mekKJ2n+aQakJJGiZfgHyB/hTbkjfk1U3F0iOO4ti37ADDAZ6iZ9c0TE28y0Ma9+XuXD1lVCK6BpwRLc1VR53DD54Ty63vSx0idfsEZ8AtytFCRg8fvLv1oSuSQ5FdcJ9jL36k5jTSzTu2NBTgWDfdov+nVrNOMlYOBaXSXznAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFHBLsBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFHBLsBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8487E1F000C4;
	Sun, 18 Oct 2026 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792283127;
	bh=fZ+3MtclH7KdZVW1BOOkqeYkmKjrlG0xiTX/foFj0mg=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=OFHBLsBw+Kq1C55a1kWHlPeZqj0B1eprlqSR+q/AQqdUgmvAY6Koo/69WN0lYm8F+
	 R/WDsEXrMD20Gvha6oDKaHNVOypVb5Ye++spiviZBB6KLeVZPksDoSWhh86wDEYH6r
	 4c1yBAQ+r4X9kLVqgEE5ntkN2U+j32D5HUHeKokJZjyYTFTMQ/6rDtb5MPS3fj+ZwS
	 GEQOVgII077v84N1kzFkI+LrZ5csKk12yhqjzGaG/cE2OECjntHxt2bfbUJbWb6/3N
	 +Xmuz+UlQwTAerFaPB4NpZ0X6amPaUy51p9o6KcCvjhJaDPolewK5mZJxOwi0mSvic
	 fRXp3NuDBjiRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B922CE1ADC; Sat, 17 Oct 2026 17:25:27 -0700 (PDT)
Date: Sat, 17 Oct 2026 17:25:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org,
	Puranjay Mohan <puranjay@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kunwu Chan <kunwu.chan@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [GIT PULL] RCU updates for v7.4
Message-ID: <720d335d-17f1-48e7-b5e6-49352712cdca@paulmck-laptop>
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

Once the merge window opens, please pull this RCU update:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.2026.10.12b
  # HEAD: d9011419496a3dc6b455b5308846684c63c18de5: Merge branches 'misc.2026.10.06a' and 'torture.2026.10.12a' into HEAD (2026-10-12 16:53:20 -0700)

----------------------------------------------------------------
RCU updates:

Execution contexts and call_rcu() and call_srcu():
 * Make call_rcu() and call_srcu invocable from NMI handlers and while
   holding scheduler locks (using irq-work handlers).
 * Add rcutorture and BPF tests calling these functions from these
   contexts.
 * Disable rcutorture overload testing for RCU readers that are "fragile",
   that is, that do not either disable preemption or have some form of
   RCU priority boosting.

SRCU updates:
 * Add an atomic SRCU where readers run with preemption disabled and
   grace periods can be invoked from atomic contexts.  David Woodhouse
   has a patch series exploiting this for GPC.
 * Add torture and lockdep tests for atomic SRCU.
 * Add numerous optimizations for atomic SRCU based on the fact that it
   does not have callbacks, for example, eliminating any transition to
   "big" srcu_struct structures even on systems that configure these to
   happen at initialization time.

Additional torture-test updates:
 * Fix a divide-by-zero bug in forward-progress testing.
 * Synchronously wait for all IRQ-queued callbacks to complete.
 * Allow alternative "ssh" commands to be specified for use by
   kvm-remote.sh.
 * Fix kvm-again.sh re-run failure on PowerPC.
 * Add additional lockdep testing for atomic SRCU.
 * Fix error double-counting in srcu_lockdep.sh.
 * Add atomic SRCU cross-CPU IRQ context mismatch testing, with the
 * trick being that the atomic SRCU readers context must be at least as
   strict as that of the atomic SRCU grace-period wait.  So for example,
   if the readers have IRQs disabled, so must the grace-period wait.

Miscellaneous updates:
 * Update stallwarn.rst documentation for the re-implementation of RCU
   Tasks Trace in terms of SRCU.
 * Fix the lazy-callback shrink scanner budget computation so that it
   honors the reclaim budget.
 * Avoid panicking on RCU CPU stalls that end before the warning can
   be printed.
 * Add "running" and "boosted" indications to the RCU task stall warning
   output.
 * People have been (incorrectly) relying on rcu_barrier() to wait for
   kfree_rcu() callbacks and processing.  But it turns out to be easier to
   fix rcu_barrier() to meet their expectations than to fix their code to
   live within the earlier rcu_barrier() specification.  So rcu_barrier()
   now waits on kfree_rcu() callbacks and processing.
 * Disable RCU Tasks console output that track when this RCU flavor
   switches between per-CPU and global callback queuing.  New use cases
   appeared that generated enough console traffic to cause trouble, and
   no one seemed to care about these messages.  For those needing those
   messages, there is a new rcupdate.rcu_task_collapse_debug kernel boot
   parameter.
 * Fix __rcu pointer attribute handling to eliminate false positives.
 * Fix typos and drop redundant #include directives.

----------------------------------------------------------------
Bradley Morgan (1):
      rcu: Drop the private tick-internal.h include from tree.c

Hemanth Selam (1):
      rcu: Fix typo "upto" in comment

Karl Mehltretter (1):
      rcuref: Fix the rcuread_is_dead reference in rcuref_read() kernel-doc

Kunwu Chan (16):
      rcutorture: Add atomic-SRCU support to torture.sh
      srcutree: Add reader-free fastpath to synchronize_srcu_atomic()
      srcutree: Skip callback scheduling for atomic SRCU grace periods
      srcutree: Remove srcu_barrier() sleep for atomic SRCU
      srcu: Restrict atomic-SRCU non_block annotation to task context
      srcutree: Make init_srcu_struct_atomic() prevent transition to big
      srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
      srcutree: Skip torture to-big transition for atomic SRCU
      srcutree: Add lockdep and early-boot checks to synchronize_srcu_atomic()
      srcutiny: Add lockdep and early-boot checks to synchronize_srcu_atomic()
      srcutree: Preserve IRQ state in synchronize_srcu_atomic() callchain
      rcutorture: Fix divide-by-zero with fwd_progress_div=1
      rcutorture: Add atomic SRCU lockdep support
      selftests/rcutorture: Wire atomic SRCU into srcu_lockdep.sh
      selftests/rcutorture: Fix double nerrs count in srcu_lockdep.sh
      rcutorture: Add atomic SRCU cross-CPU IRQ context mismatch test

Longlong Xia (1):
      rcu: fix shrink budget underflow in lazy_rcu_shrink_scan

Matthias Goergens (1):
      rcu: Make userspace barrier hook drain kvfree_rcu work

Paul E. McKenney (16):
      doc: Update stallwarn.rst based on RCU Tasks Trace as SRCU
      rcu: Don't panic on already-ended RCU CPU stalls
      rcutorture:  Disable fragile readers during overload testing
      srcutiny: Make a Tiny SRCU grace period imply an RCU grace period
      srcutree: Suppress srcu_advance_state() mutex_lock in atomic
      srcutree: Suppress to-big transition for atomic SRCU
      rcu: Add running and boosted indications to RCU task stall dump
      rcu-tasks: Disable callback contend/collapse messages by default
      srcutree: Add an atomic Tree SRCU
      srcutiny: Add an atomic Tiny SRCU
      rcutorture: Add support for testing synchronize_srcu_atomic()
      srcutree: Disable preemption across synchronize_srcu_atomic()
      srcutree: Warn if Tiny SRCU readers are preempted
      srcutree: Explicitly note DEFINE_SRCU() needs for srcu_barrier()
      torture:  Allow specifying alternative ssh command to kvm-remote.sh
      Merge branches 'misc.2026.10.06a' and 'torture.2026.10.12a' into HEAD

Puranjay Mohan (6):
      rcu: Make call_rcu() safe to call from any context
      rcu: Make Tiny call_rcu() safe to call from any context
      srcu: Make call_srcu() safe to call from any context
      srcu: Make Tiny call_srcu() safe to call from any context
      rcutorture: Exercise ->call() from NMI context
      selftests/bpf: Add a call_srcu() re-entry reproducer

Ricardo Ribalda (1):
      rcu: Drop the address space qualifier from the dereference macros

Sebastian Andrzej Siewior (1):
      srcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work

Sunho Park (1):
      srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in cleanup_srcu_struct()

Zhouyi Zhou (1):
      rcutorture: Fix kvm-again.sh re-run failure on ppc64

Zqiang (1):
      rcutorture: Synchronously wait for all rcu_torture_irq() callbacks to complete

 Documentation/RCU/stallwarn.rst                    |  22 +-
 Documentation/admin-guide/kernel-parameters.txt    |  23 +-
 include/linux/compiler.h                           |  17 +
 include/linux/rcupdate.h                           |  10 +-
 include/linux/rcuref.h                             |   2 +-
 include/linux/srcu.h                               |  83 +++-
 include/linux/srcutiny.h                           |  18 +-
 include/linux/srcutree.h                           |  19 +-
 kernel/rcu/Kconfig                                 |   6 +
 kernel/rcu/rcu.h                                   |  14 +
 kernel/rcu/rcutorture.c                            | 317 ++++++++++++-
 kernel/rcu/srcutiny.c                              | 189 +++++++-
 kernel/rcu/srcutree.c                              | 504 ++++++++++++++++++---
 kernel/rcu/tasks.h                                 |  15 +-
 kernel/rcu/tiny.c                                  | 127 +++++-
 kernel/rcu/tree.c                                  | 164 ++++++-
 kernel/rcu/tree.h                                  |   6 +
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_nocb.h                             |   3 +-
 kernel/rcu/tree_plugin.h                           |   2 -
 kernel/rcu/tree_stall.h                            |  36 +-
 .../testing/selftests/bpf/prog_tests/rcu_reentry.c |  93 ++++
 tools/testing/selftests/bpf/progs/rcu_reentry.c    |  51 +++
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |  11 +-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |  22 +-
 .../selftests/rcutorture/bin/srcu_lockdep.sh       |  77 +++-
 tools/testing/selftests/rcutorture/bin/torture.sh  |  24 +
 27 files changed, 1677 insertions(+), 180 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c
