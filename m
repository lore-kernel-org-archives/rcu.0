Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69C188737;
	Sat, 28 Sep 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531636; cv=none; b=nIPSOr7Y9aVuU7mGcy/Rrc8ha5420y9abJwYBdAuH32kfAj9w1zy7m0yJX7LazuRXpBC01nqL+iUeWv71HP6RpFCun+pqxhnYDlpJGwTDm7y9smvyE0rbPJK1feu5TH+d2zuc38VHNfPBlmR2aJ3EGrEbrKWaOxqPDab7gSBsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531636; c=relaxed/simple;
	bh=Yoa1DIcV0GIQnMAvyo+KjzEmi28ghhiEBWS5v4mrukA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXb42zDyEI4hxhn4J5Xb2DOp2SrM6ByF65Z5eU3dd6BeObKNRW+fk9rx+mjre610cBhkq2dxOlFQDxHwWCs3CxlBNz0Zrf1A2Z9bQ8P3ytHypP+Qxq32qgVoembBUpyzz0XR/pSOdiP/Smmxpy/9e2n8KWIKaa6XKiD95cOEszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=u/VZHw1O; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="u/VZHw1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727531632;
	bh=Yoa1DIcV0GIQnMAvyo+KjzEmi28ghhiEBWS5v4mrukA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/VZHw1OSex3HiP1nB/019K3dUqOdR3fLwG+PFqz5kjTu+u8bcZgLZJPQdyu1RP1Z
	 4nBIeK3PByR5f51paXn+oRvKMbngH0Wbv2O7xrjoojShmJS6IoMygb+Xy8BnUf5iSH
	 gEpEPRsJhW3ZpwYI8R3012VQE07oUoLoXdVQL9CM5s1+9goUwG8YIDQaivZBdA30lo
	 7FqF1UHUPbBawL51Pta6ZfvWTRBu3la9C0P4Acp6wa8SWckijYCPOq2xYrQUAfqGse
	 /677HPW+5WA60VD8EKgnRjGmqkFIhuNTeXOv7NBdt8t4V4igWiCUJ5nh4YCBc2XmmW
	 KDvjMvgbIsB4w==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XG8280b5dz1c1M;
	Sat, 28 Sep 2024 09:53:52 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address dependency
Date: Sat, 28 Sep 2024 09:51:27 -0400
Message-Id: <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
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
from replacing the registers holding @a or @b based on their
equality, which does not preserve address dependencies and allows the
following misordering speculations:

- If @b is a constant, the compiler can issue the loads which depend
  on @a before loading @a.
- If @b is a register populated by a prior load, weakly-ordered
  CPUs can speculate loads which depend on @a before loading @a.

The same logic applies with @a and @b swapped.

The compiler barrier() is ineffective at fixing this issue.
It does not prevent the compiler CSE from losing the address dependency:

int fct_2_volatile_barriers(void)
{
    int *a, *b;

    do {
        a = READ_ONCE(p);
        asm volatile ("" : : : "memory");
        b = READ_ONCE(p);
    } while (a != b);
    asm volatile ("" : : : "memory");  <----- barrier()
    return *b;
}

With gcc 14.2 (arm64):

fct_2_volatile_barriers:
        adrp    x0, .LANCHOR0
        add     x0, x0, :lo12:.LANCHOR0
.L2:
        ldr     x1, [x0]    <------ x1 populated by first load.
        ldr     x2, [x0]
        cmp     x1, x2
        bne     .L2
        ldr     w0, [x1]    <------ x1 is used for access which should depend on b.
        ret

On weakly-ordered architectures, this lets CPU speculation use the
result from the first load to speculate "ldr w0, [x1]" before
"ldr x2, [x0]".
Based on the RCU documentation, the control dependency does not prevent
the CPU from speculating loads.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: "Paul E. McKenney" <paulmck@kernel.org>
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
---
 include/linux/compiler.h | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2df665fa2964..f26705c267e8 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -186,6 +186,68 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
+/*
+ * Compare two addresses while preserving the address dependencies for
+ * later use of the address. It should be used when comparing an address
+ * returned by rcu_dereference().
+ *
+ * This is needed to prevent the compiler CSE and SSA GVN optimizations
+ * from replacing the registers holding @a or @b based on their
+ * equality, which does not preserve address dependencies and allows the
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
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 /**
-- 
2.39.2

