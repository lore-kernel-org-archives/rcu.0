Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B63090C6;
	Mon,  1 Dec 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590736; cv=none; b=eATbaE3VagX4k8HgbOC/K/diDs3egGWohmtFmuLiVfln82Xv6p+wGNWJxHMMw3I7uQts2uZxWoGaTYWAwKnK2a03ecyTTX14rvIbpxvX1Cjr4eYKRe6KLveIht9YPXANKb1aLn9o374O3rVEr88NjL9QT115dca2ZMbughz6ZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590736; c=relaxed/simple;
	bh=9l8fSrFiMatebfiQz8uDjk8QT0IaLpuMf3QpfCnCMbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLmJlSpJ4tvCNqIjMiybS8j8NSkvnksB93ZLazCvwviJO7vl7ai+mOEAQ98jkhkcAyycqRWck2siakrH/Wn676oIXzdzWatOKU1qg+wkaZ2zlawwcXGkbvSQcANyCA6bAsRBvjw64GMl4puQBQUjnYraXFAukeJsRkbW6LZkTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/6qL47S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/6qL47S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67E1C113D0;
	Mon,  1 Dec 2025 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764590735;
	bh=9l8fSrFiMatebfiQz8uDjk8QT0IaLpuMf3QpfCnCMbg=;
	h=From:To:Cc:Subject:Date:From;
	b=b/6qL47SG0BsITxKKKWulBxih6ZrV4eodMjZuPiBq78px7mprdx6K0oFdUkrvccbR
	 +BPudYKlGGmlP8kvyj8R1LYHRzUrLlYB+oOmp3RLarRM02M7rBfsnCO9SDFQOmFDQT
	 B6k19Z1oXahtbKsucDTuq3nS4A1vttvXvlPMOQ6elPFrmGa0HaesQIs5uOp6EgC3H/
	 zgxVmgEtydjcS69aNoLZk2HT1uhYz6rLwMBjfde92eJtLnJSxvZemiiXGz7izMzopF
	 7l0Q3cUzT7XfpCQ+W3tW2M7CL+83CMbw4ApTxaSl9BUcutYshyDCC5fJJU0Vjuw8ie
	 BGGay7cewZ5tg==
From: Frederic Weisbecker <frederic@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [GIT PULL] RCU updates for v6.19
Date: Mon,  1 Dec 2025 13:05:24 +0100
Message-ID: <20251201120524.15568-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.19

for you to fetch changes up to 9a08942f17017b708991c5089843d4a1bfac4420:

  Merge branch 'rcu/misc' into next (2025-11-30 22:20:33 +0100)

----------------------------------------------------------------
RCU pull request for v6.19

SRCU
----

_ Properly handle SRCU readers within IRQ disabled sections in tiny SRCU

- Preparation to reimplement RCU Tasks Trace on top of SRCU fast:

    - Introduce API to expedite a grace period and test it through
      rcutorture.

    - Split srcu-fast in two flavours: SRCU-fast and SRCU-fast-updown.
      Both are still targeted toward faster readers (without full
      barriers on LOCK and UNLOCK) at the expense of heavier write side
      (using full RCU grace period ordering instead of simply full
      ordering) as compared to "traditional" non-fast SRCU. But those
      srcu-fast flavours are going to be optimized in two different
      ways:

         - SRCU-fast will become the reimplementation basis for
           RCU-TASK-TRACE for consolidation. Since RCU-TASK-TRACE must
           be NMI safe, SRCU-fast must be as well.

         - SRCU-fast-updown will be needed for uretprobes code in order
           to get rid of the read-side memory barriers while still
           allowing entering the reader at task level while exiting it
           in a timer handler. It is considered semaphore-like in that
           it can have different owners between LOCK and UNLOCK.
           However it is not NMI-safe.

      The actual optimizations are work in progress for the next cycle.
      Only the new interfaces are added for now, along with related
      torture and scalability test code.

- Create/document/debug/torture new proper initializers for RCU fast:
  DEFINE_SRCU_FAST() and init_srcu_struct_fast()

  This allows for using right away the proper ordering on the write
  side (either full ordering or full RCU grace period ordering) without
  waiting for the read side to tell which to use. Also this optimizes
  the read side altogether with moving flavour debug checks under debug
  config and with removing a costly RmW operation on their first call.

- Make some diagnostic functions tracing safe.

REFSCALE
-------

Add performance testing for common context synchronizations
(Preemption, IRQ, Softirq) and per-cpu increments. Those are
relevant comparisons against SRCU-fast read side APIs, especially
as they are planned to synchronize further tracing fast-path code.

MISCELLANOUS
------

- In order to prepare the layout for nohz_full work deferral to
  user exit, the context tracking state must shrink the counter
  of transitions to/from RCU not watching. The only possible hazard
  is to trigger wrap-around more easily, delaying a bit grace periods
  when that happens. This should be a rare event though. Yet add
  debugging and torture code to test that assumption.

- Fix memory leak on locktorture module

- Annotate accesses in rculist_nulls.h to prevent from KCSAN warnings.
  On recent discussions, we also concluded that all those WRITE_ONCE()
  and READ_ONCE() on list APIs deserve appropriate comments. Something
  to be expected for the next cycle.

- Provide a script to apply several configs to several commits with torture.

- Allow torture to reuse a build directory in order to save needless
  rebuild time.

- Various cleanups.

No known conflicts.

----------------------------------------------------------------
Frederic Weisbecker (3):
      Merge branch 'rcu/srcu' into next
      Merge branch 'rcu/refscale' into next
      Merge branch 'rcu/misc' into next

Paul E. McKenney (25):
      srcu: Permit Tiny SRCU srcu_read_unlock() with interrupts disabled
      srcu: Create an srcu_expedite_current() function
      rcutorture: Test srcu_expedite_current()
      srcu: Create a DEFINE_SRCU_FAST()
      srcu: Make grace-period determination use ssp->srcu_reader_flavor
      rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
      srcu: Require special srcu_struct define/init for SRCU-fast readers
      srcu: Make SRCU-fast readers enforce use of SRCU-fast definition/init
      doc: Update for SRCU-fast definitions and initialization
      torture: Add kvm-series.sh to test commit/scenario combination
      rcutorture: Permit kvm-again.sh to re-use the build directory
      rcutorture: Remove redundant rcutorture_one_extend() from rcu_torture_one_read()
      rcu: Mark diagnostic functions as notrace
      srcu: Add SRCU_READ_FLAVOR_FAST_UPDOWN CPP macro
      torture: Permit negative kvm.sh --kconfig numberic arguments
      refscale: Add local_irq_disable() and local_irq_save() readers
      refscale: Add local_bh_disable() readers
      refscale: Add preempt_disable() readers
      refscale: Add this_cpu_inc() readers
      refscale: Add non-atomic per-CPU increment readers
      refscale: Do not disable interrupts for tests involving local_bh_enable()
      srcu: Create an SRCU-fast-updown API
      rcutorture: Make srcu{,d}_torture_init() announce the SRCU type
      refscale: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
      refscale: Add SRCU-fast-updown readers

Valentin Schneider (2):
      rcu: Add a small-width RCU watching counter debug option
      rcutorture: Make TREE04 use CONFIG_RCU_DYNTICKS_TORTURE

Wang Liang (1):
      locktorture: Fix memory leak in param_set_cpumask()

Xuanqiang Luo (1):
      rcu: use WRITE_ONCE() for ->next and ->pprev of hlist_nulls

 .../RCU/Design/Requirements/Requirements.rst       |  33 +-
 Documentation/RCU/checklist.rst                    |  12 +-
 Documentation/RCU/whatisRCU.rst                    |   3 +
 include/linux/context_tracking_state.h             |  44 ++-
 include/linux/notifier.h                           |   2 +-
 include/linux/rculist_nulls.h                      |   6 +-
 include/linux/srcu.h                               | 147 ++++++--
 include/linux/srcutiny.h                           |  31 +-
 include/linux/srcutree.h                           |  99 ++++--
 kernel/locking/locktorture.c                       |   8 +-
 kernel/rcu/Kconfig.debug                           |  15 +
 kernel/rcu/rcutorture.c                            |  76 ++++-
 kernel/rcu/refscale.c                              | 379 ++++++++++++++++++++-
 kernel/rcu/srcutiny.c                              |  13 +-
 kernel/rcu/srcutree.c                              | 130 ++++++-
 kernel/rcu/tree.c                                  |   2 +-
 kernel/rcu/update.c                                |   8 +-
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |  56 ++-
 .../testing/selftests/rcutorture/bin/kvm-series.sh | 116 +++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   2 +-
 .../selftests/rcutorture/configs/rcu/TREE04        |   1 +
 21 files changed, 1041 insertions(+), 142 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-series.sh
