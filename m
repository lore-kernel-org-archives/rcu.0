Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFF4F5DED;
	Fri,  9 Oct 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570686; cv=none; b=uCXEQS+aHVaSUmRAf2fNTNY2c1DwRTkd8+6dAa1U2XRx33XnAQ2CXNQbuwcv9dcP7A4LmfughGJ6Tc4pPW8lxSUJsm1HWazzU1BmhLk40TTCBBBt3C9aynX+6M34wSR9U+qu53Cm/U6LiQen9V4DBWkLpFww9bb6oF/zw11ajcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570686; c=relaxed/simple;
	bh=43kU5rYck9x72SpLmu/7IOVO0qc5BFHhndssYyX1uF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpV5E4oEUb4oLH1bz7J7B0TpIVrlID1ua7ClmwfC+9Rqpvv2isDqrKYqVtfSAvclbnvI6stwXkWHRXf33B/W3OAuRjYX0/p/S8JtgIDDtKSK0UIIYAvMSxyNPDWMylIMsWVEc51sLa9hlBSFIXMlfh5BjfA57+biEHk4CW3/zds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DBHvMLkv; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DBHvMLkv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1791570109;
	bh=JDrZOtFBWf7Dd8+cVztxdzIHxxYfAS3JAMLz+tammXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBHvMLkvCbPROIyS66Yd7f3eJnw8hM1cQH3lKNpCpfD+iMsG1VHiX0zPZrzVVC6iP
	 Gmb9EpLj2wahICm7L2FCDVjazdXblPbI/fvCxbd/Bq/T3O7MUqgLX2/9p47vHKpo7L
	 tx7Tnc7nQDRPIsisvMBRM4aSZ57XlU+3zT8XlCPFaOUnUSiy5pQNaUexLIifVPRZAY
	 UEloO6Q1MfBcEuAhsW/KAvCHQs/kTxr/M08Aq7bvLdmRy1zDGx1Ho2fySFAmhfCqbJ
	 KLTnKosmBKM84ZLQg3fayGLG+TJIGI0WFYasrf+hLYKVxNMsIrrLN/Rx+ekSF8BuTI
	 3u0vCI4wJf5KQ==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j1ZvK4V7KzljQ;
	Fri, 09 Oct 2026 14:21:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev,
	Nikita Popov <github@npopov.com>,
	llvm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH hazptr v2 2/4] ptreq.h: Introduce ptr_eq() to preserve address dependency
Date: Fri,  9 Oct 2026 14:21:33 -0400
Message-ID: <20261009182142.6311-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
References: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler CSE and SSA GVN optimizations can cause the address dependency
of addresses returned by rcu_dereference to be lost when comparing those
pointers with either constants or previously loaded pointers.

Introduce ptr_eq() to compare two addresses while preserving the address
dependencies for later use of the address. It should be used when
comparing an address returned by rcu_dereference().

This is needed to prevent the compiler CSE and SSA GVN optimizations
from using @a (or @b) in places where the source refers to @b (or @a)
based on the fact that after the comparison, the two are known to be
equal, which does not preserve address dependencies and allows the
following misordering speculations:

- If @b is a constant, the compiler can issue the loads which depend
  on @a before loading @a.
- If @b is a register populated by a prior load, weakly-ordered
  CPUs can speculate loads which depend on @a before loading @a.

The same logic applies with @a and @b swapped.

The header "linux/ptreq.h" is the expected include target. It
contains the documentation of the ptr_eq() API.

An architecture specific implementation of the pointer comparison
can be implemented by each architecture as asm/ptreq.h. The x86
implementation is provided initially. If no implementation header is
present for the architecture, an arch-agnostic fallback based on
OPTIMIZER_HIDE_VAR is included from asm-generic.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: maged.michael@gmail.com
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: lkmm@lists.linux.dev
Cc: Nikita Popov <github@npopov.com>
Cc: llvm@lists.linux.dev
Cc: Lian Wang <lianux.mm@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
---
Changes since v1:
- Move to linux/ptreq.h, implement x86-specific comparison
  and asm-generic header (fallback).

Changes since v0:
- Include feedback from Alan Stern.
---
 arch/x86/include/asm/ptreq.h | 16 +++++++++
 include/asm-generic/Kbuild   |  1 +
 include/asm-generic/ptreq.h  | 16 +++++++++
 include/linux/ptreq.h        | 63 ++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 arch/x86/include/asm/ptreq.h
 create mode 100644 include/asm-generic/ptreq.h
 create mode 100644 include/linux/ptreq.h

diff --git a/arch/x86/include/asm/ptreq.h b/arch/x86/include/asm/ptreq.h
new file mode 100644
index 000000000000..593b45f80451
--- /dev/null
+++ b/arch/x86/include/asm/ptreq.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PTREQ_H
+#define _ASM_X86_PTREQ_H
+
+#include <linux/types.h>
+#include <asm/asm.h>
+
+static __always_inline
+bool ptr_eq(const volatile void *a, const volatile void *b)
+{
+	bool ret;
+	asm(__ASM_SIZE(cmp) " %1,%2" : "=@ccz" (ret) : "r" (a), "r" (b));
+	return ret;
+}
+
+#endif	/* _ASM_X86_PTREQ_H */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 2bc00c67dc54..e1d95dea09d5 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -47,6 +47,7 @@ mandatory-y += percpu.h
 mandatory-y += percpu_types.h
 mandatory-y += pgalloc.h
 mandatory-y += preempt.h
+mandatory-y += ptreq.h
 mandatory-y += rqspinlock.h
 mandatory-y += runtime-const.h
 mandatory-y += rwonce.h
diff --git a/include/asm-generic/ptreq.h b/include/asm-generic/ptreq.h
new file mode 100644
index 000000000000..db5a88628b1e
--- /dev/null
+++ b/include/asm-generic/ptreq.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_PTREQ_H
+#define __ASM_GENERIC_PTREQ_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+static __always_inline
+bool ptr_eq(const volatile void *a, const volatile void *b)
+{
+	OPTIMIZER_HIDE_VAR(a);
+	OPTIMIZER_HIDE_VAR(b);
+	return a == b;
+}
+
+#endif	/* __ASM_GENERIC_PTREQ_H */
diff --git a/include/linux/ptreq.h b/include/linux/ptreq.h
new file mode 100644
index 000000000000..5499f65da30a
--- /dev/null
+++ b/include/linux/ptreq.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PTREQ_H
+#define _LINUX_PTREQ_H
+
+/*
+ * Compare two addresses while preserving the address dependencies for
+ * later use of the address. It should be used when comparing an address
+ * returned by rcu_dereference().
+ *
+ * This is needed to prevent the compiler CSE and SSA GVN optimizations
+ * from using @a (or @b) in places where the source refers to @b (or @a)
+ * based on the fact that after the comparison, the two are known to be
+ * equal, which does not preserve address dependencies and allows the
+ * following misordering speculations:
+ *
+ * - If @b is a constant, the compiler can issue the loads which depend
+ *   on @a before loading @a.
+ * - If @b is a register populated by a prior load, weakly-ordered
+ *   CPUs can speculate loads which depend on @a before loading @a.
+ *
+ * The same logic applies with @a and @b swapped.
+ *
+ * Return value: true if pointers are equal, false otherwise.
+ *
+ * The compiler barrier() is ineffective at fixing this issue. It does
+ * not prevent the compiler CSE from losing the address dependency:
+ *
+ * int fct_2_volatile_barriers(void)
+ * {
+ *     int *a, *b;
+ *
+ *     do {
+ *         a = READ_ONCE(p);
+ *         asm volatile ("" : : : "memory");
+ *         b = READ_ONCE(p);
+ *     } while (a != b);
+ *     asm volatile ("" : : : "memory");  <-- barrier()
+ *     return *b;
+ * }
+ *
+ * With gcc 14.2 (arm64):
+ *
+ * fct_2_volatile_barriers:
+ *         adrp    x0, .LANCHOR0
+ *         add     x0, x0, :lo12:.LANCHOR0
+ * .L2:
+ *         ldr     x1, [x0]  <-- x1 populated by first load.
+ *         ldr     x2, [x0]
+ *         cmp     x1, x2
+ *         bne     .L2
+ *         ldr     w0, [x1]  <-- x1 is used for access which should depend on b.
+ *         ret
+ *
+ * On weakly-ordered architectures, this lets CPU speculation use the
+ * result from the first load to speculate "ldr w0, [x1]" before
+ * "ldr x2, [x0]".
+ * Based on the RCU documentation, the control dependency does not
+ * prevent the CPU from speculating loads.
+ */
+
+#include <asm/ptreq.h>
+
+#endif	/* _LINUX_PTREQ_H */
-- 
2.43.0

