Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338942;
	b=txwRpUBnUYumAMlYF655gv7vxN1F5Kbq++SeezAn5LHi4/7YPuwbg9IItXrTZbEpYjOp
	 IlymWMvWphDGo1Rj+/IOvQZs9rFOPoDNe1wVoyz4C2YK/eMt5cK9dBmstQoRbmfhSAKEJ
	 PFzXdixgk6qnFB2Ib7G9zRu5bzAwr0glkZQJGPPUCzCocw5dHgsrWr4DRCrzv+igaDn83
	 c5un17UHQFkklK2Q68WutHNWwtBcPzGC4+bN7B0KZnMrN2U/auYVMswkUyYwukwaXnrJT
	 yWIFZPc7ysADOvAmCxynCD4ZZQ0WtGHH7nPf91Xn8eE6MI9c3GVrrbD1l8uOuknLesQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338942;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=n1H4QNpDBy4aWkOux/dhtpS2bAHRAJO/VY+m1BphVGg=;
	b=awrIGPWQiayFuGzd57BwN5LoI4Z8cGr7n77qq3i84k4GoEsmPxdvTnaJBwISDBIHKvGy
	 TQ8OCiugly1dgTv4XSjjG9XJIBQgE3+GcVOnV6C24qGzvZ6oWWWolxKlmhWA0SWAQq32Z
	 ug0O1ycpqcmP+mjbbrcyj3MBCNLC8CphDaVq3PDYEunBtBsRJsA3K5pKEzca0CAQ2NK6k
	 eaAT1P1hmuf/AP6QE2ENLSOO4+MgAVZpUta7Veqqa+TtHy9fL6m6slbV07RtBoGczBTtM
	 RFCjglx8TbyrCmxVraib9Hh6ejOwXlU9PZUlcwTP3HafMdU92vlLco7g7chz1EzU96w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=KHgoTazw;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F4606A320;
	Tue, 10 Nov 2026 19:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 451F4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=KHgoTazw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794338934;
	bh=n1H4QNpDBy4aWkOux/dhtpS2bAHRAJO/VY+m1BphVGg=;
	h=From:To:Cc:Subject:Date:From;
	b=KHgoTazwjMdG/KBFjIUYXjG0XchaqcRZ11++MACoi3M/MICYnfIZx/HalagUuihVE
	 BTHyjDYEdUErVxCOEl3SJXatwZQHC14s5OlWVmHnbX4c/spUvDUp8PEzRM1Hw/u4I9
	 HPLPEt4sBmLgBsoCMJ1p7fN2ra6+CLc82bO0p8sgjvsdWv8dRqIOnkA6PzG9b0pUwD
	 TEAf5zMgwHxXclrzzvFX3RP5KHch1JCwwUe0dgjIuBHNMPtTvm9O/F1rwgYF9DQwqA
	 stLFAveTgUtR8yU9Hob0Hh/VR4m5HonEuU5KOkvvS5o/pnOEBR8NJEowk5NKNtpovw
	 1xGufckoowQRw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPGsy1yKBzNR6;
	Tue, 10 Nov 2026 14:28:54 -0500 (EST)
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
Subject: [PATCH 0/4] srcu: NMI-safe atomic SRCU readers, and their irqsave forms
Date: Tue, 10 Nov 2026 14:28:40 -0500
Message-Id: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
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
sections without sleeping, sometimes with interrupts disabled.  Atomic
SRCU fits, with two additions:

- Patch 1 makes the atomic readers NMI-safe.  They use the counter
  increments of __srcu_read_lock_nmisafe(), which keep the full barriers
  that synchronize_srcu_atomic() pairs with.
- Patch 2 adds srcu_read_lock_atomic_irqsave() and
  srcu_read_unlock_atomic_irqrestore().  They disable interrupts instead
  of preemption, for a domain whose writers wait with interrupts
  disabled.
- Patch 3 makes rcutorture run readers from NMI, for the NMI-safe reader
  flavors.
- Patch 4 makes rcutorture use the irqsave forms for half of the atomic
  readers, with a new atomic_irqsave parameter.  It also adds an SRCU-P
  run of this mode to torture.sh.

On architectures without NMI-safe this_cpu_inc(), every atomic reader
now pays an atomic increment at lock and at unlock.  The update side is
unchanged.  On architectures with NMI-safe this_cpu_inc(), such as x86,
the readers use the same counter increments as before.  David agreed to
the change, as long as synchronize_srcu_atomic() stays within the 4-16us
it was designed for [3].

Testing was on x86_64 under QEMU/KVM, with
CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y:

- SRCU-P with atomic readers, half of them irqsave, for 5 minutes: no
  error.  It ran 32529 grace periods and 104114 readers in NMI.
- SRCU-P with the NMI-safe reader flavor, then with the fast one, for 2
  minutes each: no error.  Both ran readers in NMI.
- SRCU-T (Tiny SRCU) with atomic readers, half of them irqsave, for 2
  minutes: no error.

Each new check fails when what it checks is broken:

- A reader's counter update is split in two, with an NMI reader in
  between: the writer stalls in its grace period.
- The flavor check rejects atomic readers in NMI: it warns.
- An irqsave unlock restores interrupts while another irqsave reader of
  its CPU is held: the new check in rcutorture warns.

The readers in NMI need a PMU in the guest.  kvm.sh starts x86 guests
with -cpu kvm64, which has none.  So these runs added --qemu-args
"-cpu host,pmu=on".  Without it, rcutorture reports that NMIs went
untested.  This also holds for the existing test of ->call() from NMI.

This series was developed with assistance from an LLM.  I reviewed the
code and the tests.

The series is based on 8a36f53fd5ec of Linus' master (7.4 merge
window).

[1] https://lore.kernel.org/all/20261016133319.433617-1-mathieu.desnoyers@efficios.com/
[2] https://lore.kernel.org/all/853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop/
[3] https://lore.kernel.org/all/84fdca577207092bd16fc8f3949c9b7a776750ba.camel@infradead.org/

Thanks,

Mathieu

Mathieu Desnoyers (4):
  srcu: Make atomic SRCU readers NMI-safe
  srcu: Add irqsave variants of the atomic SRCU readers
  rcutorture: Run NMI-safe SRCU readers from NMI
  rcutorture: Test the irqsave forms of atomic SRCU readers

 include/linux/srcu.h                          | 108 ++++++++++----
 kernel/rcu/rcutorture.c                       | 134 ++++++++++++++++--
 kernel/rcu/srcutree.c                         |   3 +-
 .../selftests/rcutorture/bin/torture.sh       |   6 +
 4 files changed, 216 insertions(+), 35 deletions(-)


base-commit: 8a36f53fd5ec3eff01f1b637d42cbdc3821d0493
-- 
2.47.3

