Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409198;
	b=OHXCoyowrUa/c/nam9TJD7o8olWXrWDpVVEOO1ip3alCIz+uDGDxGWQXGTAaUrF2AIIc
	 hoqOKLvqGgwNx6dCol4bOaskvYW/Vm/D+VAwJ7Gst7G1cTo5GsjahQ886SLUugYkS06b/
	 9rB36clTa9bLowN7nMHc9YUiX6lRZQQJKXLdgvfY+KC73x+6o4dZJ94jCWIrZ3RCYKKOd
	 CxXWchXE7n6Vg/sd+R0yUWaHZlzTK7N7gf6/AWZjfb42pvfwrmZqZdlVvViFjG1X1S606
	 35Kb6lof/D54OgZgFtGgbBc+TN2Xxzt1/0lNH70ozwn+5kkq7vn2PMC8bARVdFO8nOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409198;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NIxDKafVKhl+NZKvyfRMWl4kVgZrd86/HCyuIjFUBPg=;
	b=fknZRQUfNBfg1ep5vA9TlVuSNxqIp4KP/ERHWetKYmInukKUeNMHWO79QizotentT5h+
	 zDTTGn9tYoaGBnE9HCbdJ4dPybivA0lVbvM4L2oUDSs89QvhvZFVSDrLYM46gDkAS3gAL
	 2z6yq2YHkRzZBe6hb4RHMoejxJ46wBvmuf0lFne0AIWVoU7ceBvCI1S+2AYNxxA5d8/q3
	 LHbKgMr5zndqKLYw0trfaF6+vWI5VXhLRUh2X+JCJCMzAAFZWWkEc8TSW9H9T97c3AuVV
	 NVljR1rtWHaT38AfmxiHHiEVPMRZBihL7xyEqo0lUR18UdzlrYLH9EXtvs0ExW8yCSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="N9eBvr/a";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA7606A33F;
	Wed, 11 Nov 2026 14:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53CA7606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=N9eBvr/a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794409197;
	bh=NIxDKafVKhl+NZKvyfRMWl4kVgZrd86/HCyuIjFUBPg=;
	h=From:To:Cc:Subject:Date:From;
	b=N9eBvr/asFYiK+fIRcW9i5aHZ7q8pqc1gZYQbpv2Cxmg/1HnnQxMnJ2wJWO207ylO
	 Vo1/P0/NIEG89ADPu2Ar+F38LV5u++RS8/nQiDpHquUck64oen3Ss0UNoWrrerERpp
	 mrRskv9IXiLP/a9iA16c3vIeeg/yGTSJbEZeLVS1Fiap4a3rV7fyXWNePPWmyuNbqO
	 rKpAbIPjKmparTDRHLC/7WydL+cIlgWBA225puOvvmvCZLb/e+fqgpjgQV5EBfDgjd
	 WvA4MyReMWyx/gIZyarGyDya9DsgmOLlmZI695cyHyXV8V0IsJS/CyOM+Hr6rQ/Pi4
	 GnwXSIIMtoXpw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPms91n3VzNgg;
	Wed, 11 Nov 2026 09:59:57 -0500 (EST)
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
Subject: [PATCH v2 0/7] srcu: NMI-safe atomic SRCU readers, and their irqsave forms
Date: Wed, 11 Nov 2026 09:59:42 -0500
Message-Id: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
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

Changes since v1 [4]
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

Testing was on x86_64 under QEMU/KVM, with
CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y:

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
[4] https://lore.kernel.org/all/20261110192844.44713-1-mathieu.desnoyers@efficios.com/

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

