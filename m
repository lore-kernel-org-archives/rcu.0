Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA45485CF9;
	Fri, 16 Oct 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157617; cv=none; b=i7cWnnA+3puTYixpJYkqNhhcAN6AOH5FtCe8jeo2HwYZeGAJQLlEOpIxIVVohBvIPkybnBbMngS4EKlsOLsh9GiHIO+TOdfTbd7j8UIVBf5Jce7tH4ZzCS6eTBp2N3IO/TqYxbQP7dL0DGdATS39zgtaUH7t5ujwC4Yrlp9q2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157617; c=relaxed/simple;
	bh=7IbiRO3iW64RObNE6YKL1HPSnO5Mdyi6ohyFHjNlVwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpDKlPQhFJxh06oIedyxi7P9dxrxOGyxlTjzGE5weseB90oWhDGYYQ9bXIUjMXgeoujIhIF7OO1xPOoIA68P2IgofHYAkvnrQmxhhMNH/xdSgm+UXGt5UbGKd9l3POPZhZAMIApdUVc8Q0fpX4qO8UMSWmYHfaGOjs4TWRkGaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VftIvztM; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VftIvztM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157607;
	bh=KpRmAWxDpNspBMya+3VjBh2v+baGxypFrk7XaBx4Was=;
	h=From:To:Cc:Subject:Date:From;
	b=VftIvztM/p77pLiM4DNiu23vILhN5X/3cSdqLL4AjkjrlgINpmL+m4s7gwOGwyArd
	 HsLOOzrciZ1Of9XW/fwUiyX545suh5AOBHMJZNSAAr6uauLTaacV/yLwTacPrLGpOl
	 nB1NITCFco4ueREV57K0SMIdEwer0NDyZJQgCTdpyYUKqz5LPOKgHPeZBB/YcDypUo
	 qi2mL4BftTrpMWkRJ9DRuSEcDtS3jcfDs9+tL1JSsbKvpsfzc8IwypcXFQ4TqXuaoN
	 QZIREQT/8C9H8r43aNv2HkZZvzx9Fd8KoMARcPB7OBKBO0snDsNLdgSzdBAQmAdmi8
	 7pRNH9LW68hoA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9L6FyMznnZ;
	Fri, 16 Oct 2026 09:33:26 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	rcu@vger.kernel.org
Subject: [RFC PATCH 00/12] RCU pseudo-transactions
Date: Fri, 16 Oct 2026 09:33:07 -0400
Message-Id: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Earlier this year, I came up with a neat trick which reduces the mental
challenge of adapting data structures to RCU.  It turns out that it also
widens the applicability of RCU to additional classes of data
structures.

This is done by a low-overhead abstraction which I'm naming
"RCU Pseudo-Transactions" [1, 2]. I name this "pseudo" because unlike
classic transactions, the writers exclude each other, readers get no
snapshot, and there is no abort.

How it works:

- Reader (rcu_txn_dereference()):
  - Load (rcu_dereference()) pointer from slot.
  - Fast path (no proxy installed): unlikely low-bit tag test and
    conditional branch (not taken).
  - Slow path (proxy installed): low-bit tag test, taken branch,
    the proxy points at the slot's record, select old or new via the
    group selector word (0/1) (load-acquire).  Still wait-free.
  - Pointer constraint: Slots must hold pointers which are at least
    2-byte aligned when using the low bit as tag and must not use
    the low bit for anything else. NULL is handled as a plain value.

- Updater (caller provides mutual exclusion):
  - Allocate a transaction descriptor (gfp flags provided by the caller).
  - Append records to the descriptor.  (each slot appears at most once
    per transaction)
  - Commit (works in atomic context):
    - Install proxy pointers into each slot. (store-release)
    - Commit (flip group selector from 0 to 1). (store-release)
    - Settle (each slot loses the proxy, gets the new pointer value).
      (store-release)
  - kfree_rcu the transaction descriptor.

Here are the key highlights:

- It enables atomic publication of multiple pointers observed by
  concurrent RCU readers. It removes the tricky "but what if a
  reader observes this intermediate state" conundrum typically present
  when porting a data structure to RCU.  A reader that loads one slot
  before the commit and another after it sees old then new values,
  never the reverse along a chain of dependent loads (or with an acquire
  between them).

- It allows composing data structures: a node can be published
  atomically into many data structures (e.g. hash bucket list and
  LRU list).

- It removes ordering requirements on multiple object publication
  with respect to RCU traversal order.

- Can be used as a building block for fine-grained data structure
  locking (see the second example in this series).

- It enables RCU traversals of cyclic graphs with arbitrary traversal
  order.

- It allows replacing sequence locks and reader-writer locks in many
  use-cases, providing read-side wait-free progress guarantees, in
  scenarios where readers need a coherent walk rather than a snapshot of
  several fields.

- It removes the need to copy data structure nodes for updates:
  multiple pointer (and data field) updates can be performed
  in-place on memory that cannot be reallocated.

I have presented it at LPC [1] and uploaded an article [2] detailing
the idea as a defensive publication.  There are no patent claims on this
work.

In this RFC, I'm presenting a port of rcu_txn to the Linux kernel,
along with a list and hlist API built on top of it. You will also
find composed hash bucket list and LRU list examples near the end
of the series. I've implemented one example with a single mutex, and the
other using RCU for neighborhood lookup and fine-grained per-node
locking.

I considered various alternatives such as Paul McKenney's "existence
guarantees" work (2015), seqlock, rwlocks, RLU, MV-RLU, and k-CAS (all
discussed in the paper), but RCU pseudo-transactions performed better
than the alternatives in my benchmarks due to smaller cache footprint
and fewer read-side fast path instructions.  I have applied this to a
partial port of the dentry cache to userspace; compared to a straight
userspace port of the current kernel scheme, the rcu_txn variant shows
up to 6.75x speedup for reverse walk under concurrent renames, and up to
21.56x speedup on writer throughput when scaling to 8 writers with 184
concurrent readers under a leaf name exchange workload (see LPC slides).

About the development process of this feature: I have used an LLM coding
assistant (Claude) throughout the development of this feature. The novel
ideas are my own, and I have carefully followed its progress, guided it
towards acceptable solutions when it was hitting walls, and reviewed the
resulting code.

Origin story: I came up with this idea while working on a userspace RCU
trie data structure which I named Fractal Trie (still in development),
and I needed to be able to atomically publish parent/child pointer
updates on nodes which were controlled by the application (therefore not
mine to reallocate).

The series is based on v7.3-rc7.

- Patch 1: rcu_txn core API.
- Patch 2: KUnit tests for the core API.
- Patch 3: Bloom filter so appending a record to a large transaction
           does not require an O(n) scan for an existing record for that
           slot (O(n^2) overall).
- Patch 4: rcu_txn_adopt, debug config option for internal consistency
           checks.
- Patches 5-6: composable singly and doubly linked lists on top of rcu_txn.
- Patch 7: documentation.
- Patch 8: litmus tests.
- Patch 9: list writer stress test.
- Patch 10: test of commit in atomic context.
- Patches 11-12: usage example for composed data structures: a cache
                 whose nodes are present in both a bucket hlist and an
                 LRU list, one variant with a single mutex, the other
                 with RCU neighborhood lookup and per-node locking.

There are a few areas where I suspect this abstraction could help in the
Linux kernel, namely the VFS layer and mm_struct VMA tree / per-VMA
locking.  I'm interested to hear whether this is useful in other
subsystems.

I'd specifically like feedback on:

- Where this should live (kernel/rcu/, lib/?),

- Naming and API shape (descriptor + records),

- Whether the Bloom filter threshold should be a config knob,

- Subsystems where this could apply.

Enjoy!

Mathieu

References:
[1] "RCU Pseudo-Transactions: Bridging the gap between RCU and STM",
    Mathieu Desnoyers,
    Linux Plumbers Conference 2026 Refereed Track, October 2026.
    https://lpc.events/event/20/contributions/2348/

[2] "RCU Pseudo-Transactions and the Single-Writer Flip-Latch:
    Atomic Multi-Slot Publication for Read-Copy-Update Data Structures",
    Mathieu Desnoyers, October 2026.
    https://www.efficios.com/pub/rcu-txn/mathieu-desnoyers-rcu-pseudo-transactions.pdf

Mathieu Desnoyers (12):
  rcu_txn: Add single-writer RCU pseudo-transactions
  rcu_txn: Add KUnit tests
  rcu_txn: Skip the record lookup with a Bloom filter
  rcu_txn: Add CONFIG_DEBUG_RCU_TXN
  rcu_txn: Add an hlist edited through transactions
  rcu_txn: Add a doubly-linked list coherent in both directions
  Documentation/RCU: Describe RCU pseudo-transactions
  Documentation/litmus-tests: Add RCU pseudo-transaction tests
  rcu_txn: Test a list writer against concurrent readers
  rcu_txn: Test a commit from atomic context
  samples: Add a cache on RCU pseudo-transactions under one mutex
  samples: Add a cache on RCU pseudo-transactions with a lock per node

 Documentation/RCU/index.rst                   |    1 +
 Documentation/RCU/rcu_txn.rst                 |  255 ++
 Documentation/litmus-tests/README             |   37 +
 .../rcu/RCU-txn+install+once-install.litmus   |   55 +
 .../litmus-tests/rcu/RCU-txn+install.litmus   |   66 +
 .../RCU-txn+list+step-back+once-flip.litmus   |   78 +
 .../RCU-txn+list+step-back+once-settle.litmus |   78 +
 .../rcu/RCU-txn+list+step-back.litmus         |   85 +
 ...-txn+monotonic+acquire+once-resolve.litmus |   79 +
 .../rcu/RCU-txn+monotonic+acquire.litmus      |   81 +
 .../RCU-txn+monotonic+dep+once-flip.litmus    |   77 +
 .../RCU-txn+monotonic+dep+once-settle.litmus  |   77 +
 .../rcu/RCU-txn+monotonic+dep.litmus          |   83 +
 .../rcu/RCU-txn+monotonic+unordered.litmus    |   84 +
 .../rcu/RCU-txn+publish+once-install.litmus   |   60 +
 .../rcu/RCU-txn+publish+once-settle.litmus    |   60 +
 .../litmus-tests/rcu/RCU-txn+publish.litmus   |   71 +
 .../rcu/RCU-txn+remove+nolock.litmus          |   64 +
 .../rcu/RCU-txn+remove+nosync.litmus          |   64 +
 .../rcu/RCU-txn+remove+once-install.litmus    |   65 +
 .../litmus-tests/rcu/RCU-txn+remove.litmus    |   72 +
 .../rcu/RCU-txn+sync+free+nolock.litmus       |   55 +
 .../rcu/RCU-txn+sync+free+nosync.litmus       |   55 +
 .../litmus-tests/rcu/RCU-txn+sync+free.litmus |   60 +
 MAINTAINERS                                   |   11 +
 include/linux/rcu_txn.h                       | 1036 ++++++++
 include/linux/rcu_txn_bloom.h                 |  110 +
 include/linux/rcu_txn_hlist.h                 |  486 ++++
 include/linux/rcu_txn_list.h                  |  544 +++++
 kernel/rcu/Kconfig.debug                      |   16 +
 lib/Kconfig                                   |    3 +
 lib/Kconfig.debug                             |   13 +
 lib/Makefile                                  |    2 +
 lib/rcu_txn.c                                 |  142 ++
 lib/rcu_txn_internal.h                        |  129 +
 lib/tests/Makefile                            |    1 +
 lib/tests/rcu_txn_kunit.c                     | 2150 +++++++++++++++++
 samples/Kconfig                               |   13 +
 samples/Makefile                              |    1 +
 samples/rcu_txn/Makefile                      |    2 +
 samples/rcu_txn/rcu_txn_cache_mutex.c         |  354 +++
 samples/rcu_txn/rcu_txn_cache_node_lock.c     |  713 ++++++
 42 files changed, 7488 insertions(+)
 create mode 100644 Documentation/RCU/rcu_txn.rst
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+install+once-install.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+install.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-flip.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-settle.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+list+step-back.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire+once-resolve.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-flip.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-settle.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+unordered.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+publish+once-install.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+publish+once-settle.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+publish.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+remove+nolock.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+remove+nosync.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+remove+once-install.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+remove.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+sync+free+nolock.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+sync+free+nosync.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+sync+free.litmus
 create mode 100644 include/linux/rcu_txn.h
 create mode 100644 include/linux/rcu_txn_bloom.h
 create mode 100644 include/linux/rcu_txn_hlist.h
 create mode 100644 include/linux/rcu_txn_list.h
 create mode 100644 lib/rcu_txn.c
 create mode 100644 lib/rcu_txn_internal.h
 create mode 100644 lib/tests/rcu_txn_kunit.c
 create mode 100644 samples/rcu_txn/Makefile
 create mode 100644 samples/rcu_txn/rcu_txn_cache_mutex.c
 create mode 100644 samples/rcu_txn/rcu_txn_cache_node_lock.c


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.47.3

