Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065517C98;
	Mon, 18 Nov 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923451; cv=none; b=LtBZvGx0lQq7uCKRL8ZPAgrg+iVYtmJHKtDeBBUgTKyQOXGBg+C5ZuMw+s1ILBOHU+RdU+CaAP/dSIYqB6pVz/kONzJycXHZ4AZHlQ/p9dIfoEH5iuNxSZLJ5g133nHtFys39DCluIoSAlqMft2nkoM8YIRuCnGUGBLLK4YmmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923451; c=relaxed/simple;
	bh=6oua1TOlnLY4qJYcC7RO2bwhdIIjnfnGNOMkRZw0kfM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nQGI0TLki3EBeVSNUrRuGvjVNwkkwsquiFJdrAGm3bqtgOnZi2e4M3O5ZBkp8EhkwnS9WWib0kPnoBSVkLGBR59907W2RuHwTQ1+6F3g7UB9C88RgV2qWElUKwMFWa0rtf1UVDuXYUqdVOyQrLkCRBeqcJIFw9eCN7fqDLufpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzDAwfRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzDAwfRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BA5C4CECC;
	Mon, 18 Nov 2024 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731923450;
	bh=6oua1TOlnLY4qJYcC7RO2bwhdIIjnfnGNOMkRZw0kfM=;
	h=Date:From:To:Cc:Subject:From;
	b=XzDAwfRAkif7r4K5XgvaO2s1UO7K2iE0FR0sgOk+P/9+AwFrf67pfwdNdMY0z18Yw
	 /NvSBNL4TYo9SgcjBDipBT8FTX+fxbhNilvoUiz+Uy5AcPVQaxRRblVIdhlVrOXRpN
	 Jgi6LY3+DHCQHpd81Mejhi6sjpvJ8qmfo7AupUoLUMJqqb5X6GuKg/X987ZDoBcUwR
	 LA8vXt4oLvWOxxgBNxvgQZcAqYSaDFJFhj5Rlry8yC1y0ArAWPgMRhr4zRtnPQt11m
	 MnYYW/YopvIlV3LqleBJJwknX1r9MbZlDRjQ3O7psePuNd9z0HP7rInpzGeOcGpsuI
	 IypVZtRzzTlGw==
Date: Mon, 18 Nov 2024 10:50:47 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [GIT PULL] RCU changes for v6.13
Message-ID: <ZzsN9wNpuDnGqKnM@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

The following changes since commit f7345ccc62a4b880cf76458db5f320725f28e400:

  rcu/nocb: Fix rcuog wake-up from offline softirq (2024-10-10 22:18:19 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.13

for you to fetch changes up to d8dfba2c606ac9fa763ce3c51dcbf7335544b815:

  Merge branches 'rcu/fixes', 'rcu/nocb', 'rcu/torture', 'rcu/stall' and 'rcu/srcu' into rcu/dev (2024-11-15 22:38:53 +0100)

----------------------------------------------------------------
RCU pull request for v6.13

SRCU:

	- Introduction of the new SRCU-lite flavour with a new pair of
	  srcu_read_[un]lock_lite() APIs. In practice the read side using
	  this flavour becomes lighter by removing a full memory barrier on
	  LOCK and a full memory barrier on UNLOCK. This comes at the
	  expense of a higher latency write side with two (in the best case
	  of a snaphot of unused read-sides) or more RCU grace periods on
	  the update side which now assumes by itself the whole full
	  ordering guarantee against the LOCK/UNLOCK counters on both
	  indexes, along with the accesses performed inside.

	  Uretprobes is a known potential user.

	  Note this doesn't replace the default normal flavour of SRCU which
	  still behaves the same as usual.

	- Add testing of SRCU-lite through rcutorture and rcuscale

	- Various cleanups on the way.

FIXES:

	- Allow short-circuiting RCU-TASKS-RUDE grace periods on architectures
	  that have sane noinstr boundaries forbidding tracing on low-level
	  idle and kernel entry code. RCU-TASKS is enough on such configurations
	  because it involves an RCU grace period that waits for all idle
	  tasks to either schedule out voluntarily or enter into RCU
	  unwatched noinstr code.

	- Allow and test start_poll_synchronize_rcu() with IRQs disabled.

	- Mention rcuog kthreads in relevant documentation and Kconfig help

	- Various fixes and consolidations

RCUTORTURE:

	- Add --no-affinity on tools to leave the affinity setting of guests
	  up to the user.

	- Add guest_os_delay parameter to rcuscale for better warm-up
	  control.

	- Fix and improve some rcuscale error handling.

	- Various cleanups and fixes

STALL:

	- Remove dead code

	- Stop dumping tasks if a stalled grace period eventually ended
	  midway as that only produces confusing output.

	- Optimize detection of stalling CPUs and avoid useless node
	  locking otherwise.

NOCB:

	- Fix rcu_barrier() hang due to a race against callbacks
	  deoffloading. This is not yet used, except by rcutorture, and
	  waits for its promised cpusets interface.

	- Remove leftover function declaration

----------------------------------------------------------------
Baruch Siach (1):
      doc: rcu: update printed dynticks counter bits

Frederic Weisbecker (1):
      Merge branches 'rcu/fixes', 'rcu/nocb', 'rcu/torture', 'rcu/stall' and 'rcu/srcu' into rcu/dev

Hongbo Li (1):
      rcu: Use bitwise instead of arithmetic operator for flags

Jinjie Ruan (1):
      rcu: Use the BITS_PER_LONG macro

Michal Schmidt (1):
      rcu/srcutiny: don't return before reenabling preemption

Paul E. McKenney (32):
      rcu: Delete unused rcu_gp_might_be_stalled() function
      rcu: Stop stall warning from dumping stacks if grace period ends
      srcu: Rename srcu_might_be_idle() to srcu_should_expedite()
      srcu: Introduce srcu_gp_is_expedited() helper function
      rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
      srcu: Renaming in preparation for additional reader flavor
      srcu: Bit manipulation changes for additional reader flavor
      srcu: Standardize srcu_data pointers to "sdp" and similar
      srcu: Improve srcu_read_lock{,_nmisafe}() comments
      srcu: Create CPP macros for normal and NMI-safe SRCU readers
      srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
      srcu: Allow inlining of __srcu_read_{,un}lock_lite()
      rcutorture: Expand RCUTORTURE_RDR_MASK_[12] to eight bits
      rcutorture: Add reader_flavor parameter for SRCU readers
      rcutorture: Add srcu_read_lock_lite() support to rcutorture.reader_flavor
      rcutorture: Add light-weight SRCU scenario
      refscale: Add srcu_read_lock_lite() support using "srcu-lite"
      srcu: Improve srcu_read_lock_lite() kernel-doc comment
      rcu: Add rcuog kthreads to RCU_NOCB_CPU help text
      doc: Add rcuog kthreads to kernel-per-CPU-kthreads.rst
      rcu: Allow short-circuiting of synchronize_rcu_tasks_rude()
      rcu: Permit start_poll_synchronize_rcu*() with interrupts disabled
      rcutorture: Test start-poll primitives with interrupts disabled
      doc: Remove kernel-parameters.txt entry for rcutorture.read_exit
      rcu-tasks: Remove open-coded one-byte cmpxchg() emulation
      torture: Add --no-affinity parameter to kvm.sh
      refscale: Correct affinity check
      rcuscale: Add guest_os_delay module parameter
      rcutorture: Avoid printing cpu=-1 for no-fault RCU boost failure
      srcu: Remove smp_mb() from srcu_read_unlock_lite()
      srcu: Check for srcu_read_lock_lite() across all CPUs
      srcu: Unconditionally record srcu_read_lock_lite() in ->srcu_reader_flavor

Uladzislau Rezki (Sony) (3):
      rcu/kvfree: Fix data-race in __mod_timer / kvfree_call_rcu
      rcuscale: Do a proper cleanup if kfree_scale_init() fails
      rcuscale: Remove redundant WARN_ON_ONCE() splat

Yue Haibing (1):
      rcu: Remove unused declaration rcu_segcblist_offload()

Zhen Lei (1):
      srcu: Replace WARN_ON_ONCE() with BUILD_BUG_ON() if possible

Zqiang (1):
      rcu/nocb: Fix missed RCU barrier on deoffloading

 Documentation/RCU/stallwarn.rst                    |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    |  13 +-
 .../admin-guide/kernel-per-CPU-kthreads.rst        |   2 +-
 include/linux/rcutiny.h                            |   1 -
 include/linux/rcutree.h                            |   1 -
 include/linux/srcu.h                               |  92 ++++++++++----
 include/linux/srcutiny.h                           |   3 +
 include/linux/srcutree.h                           |  67 ++++++++++-
 kernel/rcu/Kconfig                                 |  28 +++--
 kernel/rcu/rcu_segcblist.h                         |   1 -
 kernel/rcu/rcuscale.c                              |   8 +-
 kernel/rcu/rcutorture.c                            |  84 +++++++++----
 kernel/rcu/refscale.c                              |  56 ++++++++-
 kernel/rcu/srcutiny.c                              |   2 +-
 kernel/rcu/srcutree.c                              | 133 +++++++++++++--------
 kernel/rcu/tasks.h                                 |  20 +---
 kernel/rcu/tree.c                                  |  24 ++--
 kernel/rcu/tree_nocb.h                             |  13 +-
 kernel/rcu/tree_plugin.h                           |  22 ++--
 kernel/rcu/tree_stall.h                            |  57 +++------
 .../rcutorture/bin/kvm-test-1-run-batch.sh         |  43 +++----
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   6 +
 .../selftests/rcutorture/configs/rcu/CFLIST        |   1 +
 .../selftests/rcutorture/configs/rcu/SRCU-L        |  10 ++
 .../selftests/rcutorture/configs/rcu/SRCU-L.boot   |   3 +
 .../selftests/rcutorture/configs/rcu/SRCU-N.boot   |   1 +
 .../selftests/rcutorture/configs/rcu/TREE10        |   2 +-
 27 files changed, 468 insertions(+), 227 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
