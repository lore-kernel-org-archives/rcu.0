Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490657;
	b=1ER9+nMF+uH2ONvT1mjryhVYWH+VDAKkI5/DhRAtvGIkGrcGdtSnYr1g/da57lgdPxmM
	 Rh9hwXVMUihQn+1Kg/v6v6GngqHFnnaJr8B37GoXE3qY9ylgv8M7s9iXxhWEZ0xkMet/r
	 dasUhZ1V4E9wSQ6u8arSMYVTg3XKPc25i2+0xRfgZMkkILyK5rCb6QQX5vkMFfYO1yYKX
	 2/OL0ESgtC49xVZY8RYka8T6QU2uGb3FXCBZAKHHkEeO0+eT8tP8Wqk9STHXBv2RrqVhX
	 71VaR1sDElGexZrmLJlDi3NHD5wSSc2+oad06hZozEOVRLYczBPQ9lV1CCcuLUk0PZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490657;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rO1xAnF69QJdu3yDEfoUWAjZ9BxKbU/wKr/MN/Ya5cs=;
	b=Cqy2mlk9LMdwyBX4oHpyQUq+VuhiqsdgTUjOAu+zejYT3+gCzuZpRCxdN4E9+F1/+zMa
	 oEn6VU9B7UGZjG6QNsca9GAJaObQ7ARctQbnrP52QfmExuWMb4J9sFJmjJgzB/lP8j/wZ
	 enCxmFIyGgWLDzIxseoBS3o2BrWlAXVaripNXP9cs7C2IQW2om0WdLO+X69QWADk++MrU
	 YPH3BowzRw5A0uDro6BjvloQO6jWRpSHFWXZStJjNyp3bhMBlJo+jsG9mx6IqR6vzd+7i
	 M9F+BPRLJZYX6n7blwwP0IMiIz4ZFzxp3KK4lSFFFWGoBm5nmwANIbgLzpu3r9n9snA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=uimbO5Mq;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404EA606A887;
	Thu, 12 Nov 2026 13:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404EA606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=uimbO5Mq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794490655;
	bh=rO1xAnF69QJdu3yDEfoUWAjZ9BxKbU/wKr/MN/Ya5cs=;
	h=From:To:Cc:Subject:Date:From;
	b=uimbO5Mq2Hi+QVVub4lTxLfA3wl48baRk0gICzVzGF4pGSF8cJy+gNx4yW41rjWri
	 3DefiGaCd/TBwGwJcTvGGi7Bfa5dTjuzFUt1NG78h7yXJg7qv+LHIP6NPJl/2QJste
	 aZcVQPIUziq0ZEEe1bU8NPmuVo9DiZzfqGQJuvzStZHQU9vf+wOg2UbQ1yhuxAHU92
	 P3r7LU9suGvGXW0XGKRzjMlA+7xnZShOwEuinD4uuNrQ7flhdAJyivaUN7A/gfxCq3
	 0yised0Fu2cO2ji2u8uQcHPZFu95jM/c7iRoTEB9pjnbU3H3+rkolwexPkheSohmAi
	 1OYSyEiZjCq0g==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQLzg0WMhzPNm;
	Thu, 12 Nov 2026 08:37:35 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rcu@vger.kernel.org
Subject: [PATCH v3 0/7] srcu: NMI-safe atomic SRCU readers, and their irqsave forms
Date: Thu, 12 Nov 2026 08:37:24 -0500
Message-Id: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paul,

This series adapts atomic SRCU to the needs of RCU pseudo-transactions
[1], as we discussed [2].  Their readers resolve a proxy within a short
section, in any context, NMI included.  A writer waits for these
sections without sleeping, from task, softirq or hardirq context.
Atomic SRCU fits, with one fix, one rule made explicit and two
additions:

- Patch 1 fixes Tiny synchronize_srcu_atomic().  With
  CONFIG_PREEMPTION=y, it called synchronize_rcu(), which ends an RCU
  grace period on Tiny RCU.  That is wrong when the caller is in an
  interrupt handler or within rcu_read_lock().
- Patch 2 is about calling synchronize_srcu_atomic() from an interrupt
  handler.  All calls on that srcu_struct, task context included, must
  then disable interrupts around it.  Otherwise, the interrupt handler
  may spin forever on the CPU of a waiter it interrupted.  Patch 2
  documents this rule, and warns when it is broken.
- Patch 3 makes the atomic readers NMI-safe.  They use the counter
  increments of __srcu_read_lock_nmisafe(), which keep the full barriers
  that synchronize_srcu_atomic() pairs with.
- Patch 4 adds srcu_read_lock_atomic_irqsave() and
  srcu_read_unlock_atomic_irqrestore().  They disable interrupts instead
  of preemption, for a domain whose writers wait with interrupts
  disabled.
- Patch 5 makes rcutorture run readers from NMI, for the NMI-safe reader
  flavors.
- Patch 6 makes rcutorture alternate the atomic readers of each CPU with
  irqsave readers, with a new atomic_irqsave parameter.  It also adds an
  SRCU-P run of this mode to torture.sh.
- Patch 7 makes rcutorture check what patch 1 fixes.

Patch 2 does not make synchronize_srcu_atomic() disable interrupts
itself.  A reader that disables only preemption may wait for an IPI to
the waiter's CPU, and that IPI would never run.  Only the caller knows
that its readers disable interrupts.

On architectures without NMI-safe this_cpu_inc(), every atomic reader
now pays an atomic increment at lock and at unlock.  The update side is
unchanged.  On architectures with NMI-safe this_cpu_inc(), such as x86,
the readers use the same counter increments as before.  David agreed to
the change, as long as synchronize_srcu_atomic() stays within the 4-16us
it was designed for [3].

Changes since v2 [4]
--------------------

No code change.  One comment changed in patch 5.

- Added the tags received on v2:
  - Reviewed-by from Paul on all patches;
  - Tested-by from David on all patches;
  - Reviewed-by from Kunwu on patches 1 to 3.
- Patch 2, message: the last sentence now says that the waiter still
  hangs after the warning.
- Patch 5, message and comment of rcu_torture_nmi_read(): lockdep is off
  in NMI.  v2 said that the NMI may interrupt lockdep.
- Patch 5, message: new paragraph.  The readers in NMI need a PMU in
  the guest.  The paragraph gives the kvm.sh argument for it.

Changes since v1 [5]
--------------------

- Rebased on v7.4-rc2.  Patch 5 (v1 patch 3) no longer applied,
  because of the kzalloc_objs() conversion in rcutorture.
- New patches 1 and 7, the Tiny SRCU fix above and its test.  Paul,
  please check that nothing needs an atomic SRCU grace period to imply
  an RCU grace period.  Tree SRCU never provided that.
- New patch 2, the rule above.  A prototype KUnit test of RCU
  pseudo-transactions hit the hang: it waits from a task, and from an
  IPI on the same CPU.  RCU pseudo-transactions now disable interrupts
  around their wait.
- Patch 5 (v1 patch 3), after your review: the readers in NMI count
  their pipe and batch values in atomic arrays of their own.  The
  statistics print them as "NMI Reader Pipe:" and "NMI Reader Batch:".
  A too-short grace period seen in NMI now gets "!!!" and a warning.
- Patch 6 (v1 patch 4), after your review:
  - the atomic_irqsave description says that the readers alternate per
    CPU, which also holds for a single reader;
  - SRCU_TORTURE_IRQSAVE is 0x80, defined next to RCUTORTURE_RDR_MASK_1
    and _2;
  - the irqsave readers run only when ->extendables is zero, instead of
    clearing extendables.

Testing
-------

The code is the same as in v2, so these are the v2 results.  Testing
was on x86_64 under QEMU/KVM, with CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y:

- SRCU-P with atomic readers alternating with irqsave readers, for 5
  minutes: no error.  It ran 40876 grace periods and 94824 readers in
  NMI.  The same without irqsave readers, for 2 minutes: no error.
- SRCU-P with the NMI-safe reader flavor, then with the fast one, for 2
  minutes each: no error.  Both ran readers in NMI.
- SRCU-T (Tiny SRCU) with atomic and irqsave readers, for 2 minutes: no
  error.
- The srcu_lockdep.sh cases of synchronize_srcu_atomic() give their
  expected results.  A wait within rcu_read_lock() (61 to 63) gets no
  lockdep warning.  A reader that ran with interrupts enabled, then a
  wait from an IPI (1071 to 1073), still gets
  "inconsistent {HARDIRQ-ON-R}".
- A throwaway KUnit test waits from an IPI on the CPU of a waiter in
  task context.  The new check warns, then the wait hangs, as the rule
  says it must.  With every caller disabling interrupts, the same test
  passes.

Each new check fails when what it checks is broken:

- A reader's counter update is split in two, with an NMI reader in
  between: the writer stalls in its grace period.
- The flavor check rejects atomic readers in NMI: it warns.
- An irqsave unlock restores interrupts while another irqsave reader of
  its CPU is held: the new check in rcutorture warns.
- Every reader in NMI sees a pipe count of 2: rcutorture prints "!!!"
  and warns of a too-short grace period in NMI.
- Patch 1 is reverted, on SRCU-T: the check of patch 7 warns.  lockdep
  also reports "Illegal synchronize_rcu() in RCU read-side critical
  section".

The readers in NMI need a PMU in the guest.  kvm.sh starts x86 guests
with -cpu kvm64, which has none.  So these runs added --qemu-args
"-cpu host,pmu=on".  Without it, rcutorture reports that NMIs went
untested.  This also holds for the existing test of ->call() from NMI.

This series was developed with assistance from an LLM.  I reviewed the
code and the tests.

The series is based on v7.4-rc2.

[1] https://lore.kernel.org/all/20261016133319.433617-1-mathieu.desnoyers@efficios.com/
[2] https://lore.kernel.org/all/853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop/
[3] https://lore.kernel.org/all/84fdca577207092bd16fc8f3949c9b7a776750ba.camel@infradead.org/
[4] https://lore.kernel.org/all/20261111145949.70845-1-mathieu.desnoyers@efficios.com/
[5] https://lore.kernel.org/all/20261110192844.44713-1-mathieu.desnoyers@efficios.com/

Thanks,

Mathieu

Mathieu Desnoyers (7):
  srcutiny: Do not call synchronize_rcu() from synchronize_srcu_atomic()
  srcu: Rule for using synchronize_srcu_atomic() from interrupt handlers
  srcu: Make atomic SRCU readers NMI-safe
  srcu: Add irqsave variants of the atomic SRCU readers
  rcutorture: Run NMI-safe SRCU readers from NMI
  rcutorture: Test the irqsave forms of atomic SRCU readers
  rcutorture: Check an atomic SRCU wait within an RCU reader

 include/linux/srcu.h                          | 108 +++++++---
 kernel/rcu/rcutorture.c                       | 197 +++++++++++++++++-
 kernel/rcu/srcutiny.c                         |   7 +-
 kernel/rcu/srcutree.c                         |  18 +-
 .../selftests/rcutorture/bin/torture.sh       |   6 +
 5 files changed, 296 insertions(+), 40 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.47.3

