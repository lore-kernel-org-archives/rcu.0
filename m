Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB951A4F09
	for <rcu@vger.kernel.org>; Thu,  6 Feb 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865869; cv=none; b=e3EteA+YRMRIRjQZamDvnqz/7cvVgBWzw4LBRD10Jh/Tgdt+4f8lLVPdVyxv/s02TKIBSUBCA/D8OzO+2Njf9OK2fyh81UOnK25RCTfVs/6QqlOeT/wmKHDOX35m4wTienPOgZh002l0yrVE7q703wIb6k6kqzz1lBazzZUEPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865869; c=relaxed/simple;
	bh=m2lB1MS02UfQGRvMOFdd1cz7mXWpeyn5Q1URRAUmMV4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pTTIWTdaGeW6RXMl8kARKiGTNZ80djGXTHBqouEMZiWDb0/Q93z6Oszo517ItgIDCrVFWw/r4BnER0KBrpWes83YJ+2fis6JHTbHtTQVZ2dXrhr03EYuvINc0WhdCsFXfBi2ATrA/qMYiFlu/7BBJvwgubz5WgPFMP66FK6HOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhLkmdet; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhLkmdet"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38db4eacf7aso281452f8f.3
        for <rcu@vger.kernel.org>; Thu, 06 Feb 2025 10:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738865865; x=1739470665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wjF/wnCzuGEvgHEer/kAKPbsva6fhifSjqXPblr3+7Y=;
        b=rhLkmdetqWlVudAi28NDS0DfLVpZPAmQdwjqFvruwJpU0HzoD417je1rSNvESdiDii
         o2vFtDYIliNqEuo3MjTC2F9R2Fq6UDt+LMqN9AnN0C4LZWJVz505UkTi+gw6gpsDvVxV
         cRaN/1bPgp5yqpJEETdth0lRM2SgDWK2WYW3ltMRfmUilVUwXhv79uYpuEPEcN5bXcFR
         AhjKVU07PeszQjxT5A9VFzgJZpYPb87ZEXr2QffPYlFQD3haZBqjogBvwQPUXIHUPh+i
         Py+hWNBA+HVtrOvUhjuwlMDjITbzdfCIuL/kKo96t2kkjxk/wsTRQAlG/qZLpx9pTLFq
         0QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865865; x=1739470665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjF/wnCzuGEvgHEer/kAKPbsva6fhifSjqXPblr3+7Y=;
        b=ftRYP8rW6ArL8dURJAxw3Bop+PPiA6lzDBMttMe3scLS1lPsMIhpc0HRhN49Y57OOH
         YbzfXOt4nxC62MNKsN/nHMT7NrKBIPQ9Vgtl/HTNt7f7RxFP/Ngj4zKLPUPW3tZC/8xG
         cLIq+ACNkvM5uspdxvqCksSSzKME6VNnd2LHE7X0G/82oDOzUwOj7kBl+z/BhI17DDUy
         NInInQEFeD1YLhnyDhAZQaxTjzComog862K+DeEWmSRvqMsaxQLQMm5BK6k2JxoIupFH
         6VKW711B3D8GQBjtXWHy1PR34bNgNgYsROpo/bQsEiD4yP3uJJRvLTTf8KgZ4xQ6135o
         2kiw==
X-Forwarded-Encrypted: i=1; AJvYcCVtHDceUTIGasnEjuqHo6HFZ/lkszj+dVICNOTu4xnN7iSPDiYQeU4vPDpRMjuklX9ELP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKup+QHYULGSEk0eYBupSp4Nz5sXO9SpiXXR0DNE5HipfiVbf
	/cKdhAlIe1g95Z54UG2FEZrnl8m2ZugPryTc4k2GsY4w4uZuE7vAsKgmbDPO2NZOibiQ3vJdBA=
	=
X-Google-Smtp-Source: AGHT+IHceiLqVjWoGH3yPpdLSANFr8o1qgOjW43BMYUdBqRdyMmyJgAZaJiMaJnNeWXnSRRf+gksH835TQ==
X-Received: from wrpc10.prod.google.com ([2002:adf:ef4a:0:b0:38b:ed0c:b648])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5849:0:b0:38d:b0fe:8c99
 with SMTP id ffacd0b85a97d-38db49101c1mr7178227f8f.48.1738865865616; Thu, 06
 Feb 2025 10:17:45 -0800 (PST)
Date: Thu,  6 Feb 2025 19:09:54 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206181711.1902989-1-elver@google.com>
Subject: [PATCH RFC 00/24] Compiler-Based Capability- and Locking-Analysis
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Note: Bart and I had concurrently been working on bringing Clang's
  -Wthread-safety to the kernel:
    https://lore.kernel.org/all/20250206175114.1974171-1-bvanassche@acm.org/
  Having both RFCs out should hopefully provide a good picture on these
  design points and trade-offs - the approaches differ significantly. ]

Capability analysis is a C language extension, which enables statically
checking that user-definable "capabilities" are acquired and released where
required. An obvious application is lock-safety checking for the kernel's
various synchronization primitives (each of which represents a "capability"),
and checking that locking rules are not violated.

Clang originally called the feature "Thread Safety Analysis" [1], with
some terminology still using the thread-safety-analysis-only names. This
was later changed and the feature became more flexible, gaining the
ability to define custom "capabilities". Its foundations can be found in
"capability systems", used to specify the permissibility of operations
to depend on some capability being held (or not held).

[1] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
[2] https://www.cs.cornell.edu/talc/papers/capabilities.pdf

Because the feature is not just able to express capabilities related to
synchronization primitives, the naming chosen for the kernel departs
from Clang's initial "Thread Safety" nomenclature and refers to the
feature as "Capability Analysis" to avoid confusion. The implementation
still makes references to the older terminology in some places, such as
`-Wthread-safety` being the warning enabled option that also still
appears in diagnostic messages.

Enabling capability analysis can be seen as enabling a dialect of Linux
C with a Capability System.

Additional details can be found in the added kernel-doc documentation.

=== Development Approach ===

Prior art exists in the form of Sparse's context tracking. Locking
annotations on functions exist, so the concept of analyzing locking rules
is not foreign to the kernel's codebase.

However, Clang's analysis is more complete vs. Sparse's, with the
typical trade-offs in static analysis: improved completeness is
sacrificed for more possible false positives or additional annotations
required by the programmer. Numerous options exist to disable or opt out
certain code from analysis.

This series aims to retain compatibility with Sparse, which can provide
tree-wide analysis of a subset of the capability analysis introduced.
For the most part, the new (and old) keywords used for annotations are
shared between Sparse and Clang.

One big question is how to enable this feature, given we end up with a
new dialect of C - 2 approaches have been considered:


	A. Tree-wide all-or-nothing approach. This approach requires
	   tree-wide changes, adding annotations or selective opt-outs.
	   Making additional primitives capability-enabled increases
	   churn, esp. where maintainers are unaware of the feature's
	   existence and how to use it.

Because we can't change the programming language (even if from one C
dialect to another) of the kernel overnight, a different approach might
cause less friction.

	B. A selective, incremental, and much less intrusive approach.
	   Maintainers of subsystems opt in their modules or directories
	   into "capability analysis" (via Makefile):

	     CAPABILITY_ANALYSIS_foo.o := y	# foo.o only
	     CAPABILITY_ANALYSIS := y  		# all TUs

	   Most (eventually all) synchronization primitives and more
	   capabilities (including ones that could track "irq disabled",
	   "preemption" disabled, etc.) could be supported.

The approach taken by this series if B. This ensures that only
subsystems where maintainers are willing to deal with any warnings one
way or another. Introducing the feature can be done incrementally,
without large tree-wide changes and adding numerous opt-outs and
annotations to the majority of code.

=== Initial Uses ===

With this initial series, the following synchronization primitives are
supported: `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`,
`seqlock_t`, `bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`,
`local_lock_t`.

As an initial proof-of-concept, this series also enables capability
analysis for the following subsystems: kfence, kcov, stackdepot,
rhashtable. (Those subsystems were chosen because I am familiar with
their locking rules; rhashtable was chosen semi-randomly as a test
because it combines a bunch of things: RCU, mutex, bit_spinlock.)

The initial benefits are static detection of violations of locking
rules. As more capabilities are added, we would see more static checking
beyond what regular C can provide, all while remaining easy (read quick)
to use via the Clang compiler.

=== Appendix ===

The following pending Clang patch is recommended, but not a strong
dependency:

	https://github.com/llvm/llvm-project/pull/123063

This series is also available at this Git tree:

	https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=cap-analysis

Marco Elver (24):
  compiler_types: Move lock checking attributes to
    compiler-capability-analysis.h
  compiler-capability-analysis: Rename __cond_lock() to __cond_acquire()
  compiler-capability-analysis: Add infrastructure for Clang's
    capability analysis
  compiler-capability-analysis: Add test stub
  Documentation: Add documentation for Compiler-Based Capability
    Analysis
  checkpatch: Warn about capability_unsafe() without comment
  cleanup: Basic compatibility with capability analysis
  lockdep: Annotate lockdep assertions for capability analysis
  locking/rwlock, spinlock: Support Clang's capability analysis
  compiler-capability-analysis: Change __cond_acquires to take return
    value
  locking/mutex: Support Clang's capability analysis
  locking/seqlock: Support Clang's capability analysis
  bit_spinlock: Include missing <asm/processor.h>
  bit_spinlock: Support Clang's capability analysis
  rcu: Support Clang's capability analysis
  srcu: Support Clang's capability analysis
  kref: Add capability-analysis annotations
  locking/rwsem: Support Clang's capability analysis
  locking/local_lock: Support Clang's capability analysis
  debugfs: Make debugfs_cancellation a capability struct
  kfence: Enable capability analysis
  kcov: Enable capability analysis
  stackdepot: Enable capability analysis
  rhashtable: Enable capability analysis

 .../dev-tools/capability-analysis.rst         | 149 ++++++
 Documentation/dev-tools/index.rst             |   1 +
 Documentation/dev-tools/sparse.rst            |   4 +
 Makefile                                      |   1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |   2 +-
 fs/dlm/lock.c                                 |   2 +-
 include/linux/bit_spinlock.h                  |  24 +-
 include/linux/cleanup.h                       |  18 +-
 include/linux/compiler-capability-analysis.h  | 407 +++++++++++++++
 include/linux/compiler_types.h                |  18 +-
 include/linux/debugfs.h                       |  12 +-
 include/linux/kref.h                          |   2 +
 include/linux/list_bl.h                       |   2 +
 include/linux/local_lock.h                    |  18 +-
 include/linux/local_lock_internal.h           |  41 +-
 include/linux/lockdep.h                       |  12 +-
 include/linux/mm.h                            |   6 +-
 include/linux/mutex.h                         |  29 +-
 include/linux/mutex_types.h                   |   4 +-
 include/linux/rcupdate.h                      |  73 ++-
 include/linux/refcount.h                      |   6 +-
 include/linux/rhashtable.h                    |  14 +-
 include/linux/rwlock.h                        |  27 +-
 include/linux/rwlock_api_smp.h                |  29 +-
 include/linux/rwlock_rt.h                     |  37 +-
 include/linux/rwlock_types.h                  |  10 +-
 include/linux/rwsem.h                         |  56 +-
 include/linux/sched/signal.h                  |   2 +-
 include/linux/seqlock.h                       |  24 +
 include/linux/seqlock_types.h                 |   5 +-
 include/linux/spinlock.h                      |  61 ++-
 include/linux/spinlock_api_smp.h              |  14 +-
 include/linux/spinlock_api_up.h               |  71 +--
 include/linux/spinlock_rt.h                   |  27 +-
 include/linux/spinlock_types.h                |  10 +-
 include/linux/spinlock_types_raw.h            |   5 +-
 include/linux/srcu.h                          |  61 ++-
 kernel/Makefile                               |   2 +
 kernel/kcov.c                                 |  40 +-
 kernel/time/posix-timers.c                    |   2 +-
 lib/Kconfig.debug                             |  43 ++
 lib/Makefile                                  |   6 +
 lib/rhashtable.c                              |  12 +-
 lib/stackdepot.c                              |  24 +-
 lib/test_capability-analysis.c                | 481 ++++++++++++++++++
 mm/kfence/Makefile                            |   2 +
 mm/kfence/core.c                              |  24 +-
 mm/kfence/kfence.h                            |  18 +-
 mm/kfence/kfence_test.c                       |   4 +
 mm/kfence/report.c                            |   8 +-
 net/ipv4/tcp_sigpool.c                        |   2 +-
 scripts/Makefile.capability-analysis          |   5 +
 scripts/Makefile.lib                          |  10 +
 scripts/checkpatch.pl                         |   8 +
 tools/include/linux/compiler_types.h          |   4 +-
 56 files changed, 1682 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/dev-tools/capability-analysis.rst
 create mode 100644 include/linux/compiler-capability-analysis.h
 create mode 100644 lib/test_capability-analysis.c
 create mode 100644 scripts/Makefile.capability-analysis

-- 
2.48.1.502.g6dc24dfdaf-goog

