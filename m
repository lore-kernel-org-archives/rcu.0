Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C713B38B5;
	Sun, 27 Sep 2026 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524324; cv=none; b=OG8dz6xvCM+r4PY1okTMSHYupIo6DSYBpsEeT/e0I1uPOc3Jbhh0xxrnGR3D2u5XWpbKQS2w1JB9TY79iMz85ckn1jwsoC8dGXSY9ZlaszDJKL2lgYiqqri/0f18XunId8F5Gxq4CGgLvesHaJIjHvtiSBnaLeBMC9jVe4FjvHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524324; c=relaxed/simple;
	bh=5k5pyln1qvBoHHcFnrp7Br7iLO4KbmwH1xjkVMxxL0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCkLv5xfa6UGYywm5IUhfVRX8EkVTYyCFTAdBu9zuKp+RPX0xLsLRpmlu0UMOt4Sp7tIDMsfFfiVK68Z5wn/oByKty3PZIgNQ0GReGA9iXQK+DngNXSLUCzgsulKJoAO8aFROH2HFrULGx9zib0z5cQ4uEhtVOZImtJKQ4XP3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Kqoo/x0g; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Kqoo/x0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1790524309;
	bh=XJZtRM91aHOzDwlGhUn7K80dltrSbiTp//FJp6Ow9Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kqoo/x0gU6cfO/dozoCRndXnjMUQnvEWJJqFnRL1KdacbB59t9bFJQG+UrLMt9tht
	 JQanVvci7golgHlE/4H1F11J8dkXRmYG4XDEpC1otXSWcNaErQEtJwaeBd6mhKlUYd
	 U/cut1gZY/CaDNZMmfIj/C7f35+t0E3/qeiRiCfMAjr0BI3Tx2YDfBIcxJbgyXCXka
	 U44m3Z5cb2VK15CWDdBSrLC2egudDHuOJlGE3cGylihTjJkXeWL9eQA0PIT2kaYuoa
	 9A/Nr9p9y0kIJk+Lb3Xo4zcgkUaj854GniG3SpgzjdfY+H/E31k0oQfKD+WEU7QrFE
	 UB7zoVT5J5Yzw==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ht87n48FjzhGy;
	Sun, 27 Sep 2026 11:51:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev,
	Nikita Popov <github@npopov.com>,
	llvm@lists.linux.dev
Subject: [PATCH hazptr 2/4] compiler.h: Introduce ptr_eq() to preserve address dependency
Date: Sun, 27 Sep 2026 11:51:29 -0400
Message-ID: <20260927155134.4740-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
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

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: "Paul E. McKenney" <paulmck@kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
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
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: lkmm@lists.linux.dev
Cc: Nikita Popov <github@npopov.com>
Cc: llvm@lists.linux.dev
---
Changes since v0:
- Include feedback from Alan Stern.
---
 include/linux/compiler.h | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 70cb31d60538..0a8c8e53cdad 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -166,6 +166,69 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__PASTE(name,						\
 	__PASTE(_, __COUNTER__)))
 
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
+static __always_inline
+int ptr_eq(const volatile void *a, const volatile void *b)
+{
+	OPTIMIZER_HIDE_VAR(a);
+	OPTIMIZER_HIDE_VAR(b);
+	return a == b;
+}
+
 /**
  * data_race - mark an expression as containing intentional data races
  *
-- 
2.43.0

