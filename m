Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD44DA9D0;
	Fri, 16 Oct 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157625; cv=none; b=EaSbf0kIX6NP/+ZT02JclmSlh3KJp9zV/Vgepq/n2huGoTzQJEErEAlCmvb13vh5kldXZQKvmwhhH8tnyRakj7KknZFogE9Bw7Oo3ko1siM9lN6NbTkJvedYcpcInXsr8A8QXcXpPQkUT8C/TNOGkSYnFHliIZ1KrylHEksS7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157625; c=relaxed/simple;
	bh=eOaASmnEFbdDst6gq0sq76N8i2tHtYdXqsc0HXD6JpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djA3ER+x9SXVzfbgkdUTHSj8Y4FE3xI0Y+dwt634j8aa5HQobx55VIdlW2OW81yMRxVkJNguaLfdd4OiXV3L2jQ/EmA5WuV+0PzXiky+Zob/lyLNcaabxguNsEgP7I1yclHdpvqPs+jm+HZVbY0CY5bJE5R+IR61Sa9hFGid5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tTEZkFMU; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tTEZkFMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157608;
	bh=GlGhImcOfoboZa41698M/H9jtuQQROZC0bTojg9ck6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTEZkFMUYyaWgxdalycnIenPP6dCJxR5lAXSgw8sy1Qb2a4/Nqk6ahlTvmVVqQujw
	 YlpOMhhTAwsaYzpRv6P/1EntPjtfr7RE0baBOnIhZ1T1nfJR1uVuX6hngOxwtyruMt
	 RfF7E5a9Jc79hYOhHGhrGhjqmfbMSPrZ1ANsnZByHEcn/tcRuO9VarG6rGjhg+J6dU
	 N5gd9WMGCS40JVCPDSCQ3Pnev5TzWuuVvbfp7SutPkY+3zuCoXGlJcTx/6CngXhrRb
	 /2cnNKHochmTjZn72svM5J2L+4UILc7OrxI8YV1W1Ouu4YztOnMaRI40dUjxhNR9yR
	 k8W/7htruUvdw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9N3KGdzmKg;
	Fri, 16 Oct 2026 09:33:28 -0400 (EDT)
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
Subject: [RFC PATCH 08/12] Documentation/litmus-tests: Add RCU pseudo-transaction tests
Date: Fri, 16 Oct 2026 09:33:15 -0400
Message-Id: <20261016133319.433617-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Model the memory ordering of RCU pseudo-transactions with the Linux
kernel memory model: the store-release / load-acquire pairs that
<linux/rcu_txn.h> documents, and the guarantee they give readers.

 - RCU-txn+install: a reader that finds a proxy reads its record
   initialized.
 - RCU-txn+monotonic+dep and +acquire: the slots of one transaction
   resolve old, then new, never new then old, along a chain of dependent
   loads or with a load-acquire between the loads.
 - RCU-txn+list+step-back: a reader of an rcu_txn_list that steps
   forward onto a node being inserted, then back, never skips it.
 - RCU-txn+sync+free: a reader never reads a record freed after a grace
   period.
 - RCU-txn+publish and RCU-txn+remove: a transaction end to end, with
   the writer doing every step.  A reader of a transaction that
   publishes an object sees the record initialized and the object built.
   A reader of one that removes an object, which the writer frees with
   the descriptor after a grace period, sees the record initialized, and
   reads neither of them freed.

Each test checks an outcome that the code forbids, and herd7 finds that
it never happens.  Error-injection variants validate that the model
catches a missing ordering: each drops one ordering that its test relies
on, and herd7 then finds the outcome possible.  A store-release or a
load-acquire becomes a plain access, the grace period or the read-side
critical section goes, or, in RCU-txn+monotonic+unordered, the reader's
two loads are left with neither a dependency nor a load-acquire between
them.

herd7 can express neither a structure nor a tagged pointer: a record is
a few variables, and the reader's tag test compares the loaded value
with the record's address.  Nor does it have arrays: where the code
indexes the record's targets with the selector, an address dependency,
the reader branches on the selector, and a branch orders no later load.
The model thus orders less than the code, and an outcome that it
forbids, the code forbids as well.  For the same reason, the selector's
load-acquire is dropped only in RCU-txn+monotonic+acquire+once-resolve,
whose reader loads slot b independently of slot a: for a reader whose
next load depends on the target it resolved, the code's address
dependency still orders that load.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Documentation/RCU/rcu_txn.rst                 | 12 +++
 Documentation/litmus-tests/README             | 37 ++++++++
 .../rcu/RCU-txn+install+once-install.litmus   | 55 ++++++++++++
 .../litmus-tests/rcu/RCU-txn+install.litmus   | 66 ++++++++++++++
 .../RCU-txn+list+step-back+once-flip.litmus   | 78 +++++++++++++++++
 .../RCU-txn+list+step-back+once-settle.litmus | 78 +++++++++++++++++
 .../rcu/RCU-txn+list+step-back.litmus         | 85 +++++++++++++++++++
 ...-txn+monotonic+acquire+once-resolve.litmus | 79 +++++++++++++++++
 .../rcu/RCU-txn+monotonic+acquire.litmus      | 81 ++++++++++++++++++
 .../RCU-txn+monotonic+dep+once-flip.litmus    | 77 +++++++++++++++++
 .../RCU-txn+monotonic+dep+once-settle.litmus  | 77 +++++++++++++++++
 .../rcu/RCU-txn+monotonic+dep.litmus          | 83 ++++++++++++++++++
 .../rcu/RCU-txn+monotonic+unordered.litmus    | 84 ++++++++++++++++++
 .../rcu/RCU-txn+publish+once-install.litmus   | 60 +++++++++++++
 .../rcu/RCU-txn+publish+once-settle.litmus    | 60 +++++++++++++
 .../litmus-tests/rcu/RCU-txn+publish.litmus   | 71 ++++++++++++++++
 .../rcu/RCU-txn+remove+nolock.litmus          | 64 ++++++++++++++
 .../rcu/RCU-txn+remove+nosync.litmus          | 64 ++++++++++++++
 .../rcu/RCU-txn+remove+once-install.litmus    | 65 ++++++++++++++
 .../litmus-tests/rcu/RCU-txn+remove.litmus    | 72 ++++++++++++++++
 .../rcu/RCU-txn+sync+free+nolock.litmus       | 55 ++++++++++++
 .../rcu/RCU-txn+sync+free+nosync.litmus       | 55 ++++++++++++
 .../litmus-tests/rcu/RCU-txn+sync+free.litmus | 60 +++++++++++++
 MAINTAINERS                                   |  1 +
 24 files changed, 1519 insertions(+)
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

diff --git a/Documentation/RCU/rcu_txn.rst b/Documentation/RCU/rcu_txn.rst
index 6e48306ebc19..7bac4bd02456 100644
--- a/Documentation/RCU/rcu_txn.rst
+++ b/Documentation/RCU/rcu_txn.rst
@@ -220,6 +220,18 @@ the engine, both data structures and the debug checks::
 		--kconfig_add CONFIG_DEBUG_RCU_TXN=y \
 		'rcu_txn*'
 
+The litmus tests ``Documentation/litmus-tests/rcu/RCU-txn+*.litmus`` model the
+memory ordering of the engine and of ``rcu_txn_list`` with the Linux kernel
+memory model.  Each test checks an outcome that the code forbids, and herd7
+finds that it never happens.  Error-injection variants validate that the model
+catches a missing ordering: each drops one ordering that its test relies on, and
+herd7 then finds the outcome possible.  With herd7 installed as
+``tools/memory-model/README`` says::
+
+	cd tools/memory-model
+	scripts/checktheselitmus.sh --timeout 1h -- \
+		../../Documentation/litmus-tests/rcu/RCU-txn+*.litmus
+
 API
 ===
 
diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 6c666f3422ea..e18995b421a8 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -78,3 +78,40 @@ RCU+sync+read.litmus
 RCU+sync+free.litmus
     Both the above litmus tests demonstrate the RCU grace period guarantee
     that an RCU read-side critical section can never span a grace period.
+
+RCU-txn+install.litmus
+    Demonstrates that the install of an RCU pseudo-transaction
+    (include/linux/rcu_txn.h) publishes its record: a reader that finds a
+    proxy reads the record initialized.
+
+RCU-txn+monotonic+dep.litmus
+RCU-txn+monotonic+acquire.litmus
+    Demonstrate that the slots of one RCU pseudo-transaction resolve old,
+    then new, never new then old, along a chain of dependent loads or with
+    a load-acquire between the loads.
+
+RCU-txn+list+step-back.litmus
+    Demonstrates that a reader of an rcu_txn_list that steps forward onto
+    a node being inserted, then back, never skips it.
+    NOTE: herd7 takes about half an hour on it, and on its variants.
+
+RCU-txn+sync+free.litmus
+    Demonstrates that a reader never reads the record of an RCU
+    pseudo-transaction once it is freed after a grace period.
+
+RCU-txn+publish.litmus
+RCU-txn+remove.litmus
+    Demonstrate RCU pseudo-transactions end to end, the writer doing every
+    step: a reader sees the record initialized and a published object
+    built, and never reads a removed object, nor the record, once they are
+    freed after a grace period.
+
+RCU-txn+*+once-*.litmus
+RCU-txn+monotonic+unordered.litmus
+RCU-txn+remove+nolock.litmus
+RCU-txn+remove+nosync.litmus
+RCU-txn+sync+free+nolock.litmus
+RCU-txn+sync+free+nosync.litmus
+    Error injection into the above RCU-txn tests.  Each variant drops one
+    ordering that its test relies on, and herd7 then finds the outcome
+    possible, which validates that the model catches the missing ordering.
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+install+once-install.litmus b/Documentation/litmus-tests/rcu/RCU-txn+install+once-install.litmus
new file mode 100644
index 000000000000..7aca7fc07162
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+install+once-install.litmus
@@ -0,0 +1,55 @@
+C RCU-txn+install+once-install
+
+(*
+ * Result: Sometimes
+ *
+ * Without the store-release of the install, a reader can find the proxy
+ * before the record it points at is written.
+ *
+ * Error injection into RCU-txn+install: everything else is as there.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int o = 1;
+int n = 1;
+int *a = &o;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *o, int *n)
+{
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, o);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, n);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	WRITE_ONCE(*a, rg);		// then the proxy, unordered
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {			// a proxy: resolve it
+		r1 = READ_ONCE(*r0);		// proxy->group
+		r2 = smp_load_acquire(r1);	// group->selector
+		if (r2) {
+			t = READ_ONCE(*rn);	// proxy->ptr[1]
+		} else {
+			t = READ_ONCE(*ro);	// proxy->ptr[0]
+		}
+	} else {
+		t = r0;
+	}
+	rcu_read_unlock();
+}
+
+exists (1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+install.litmus b/Documentation/litmus-tests/rcu/RCU-txn+install.litmus
new file mode 100644
index 000000000000..aafda3b7bc42
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+install.litmus
@@ -0,0 +1,66 @@
+C RCU-txn+install
+
+(*
+ * Result: Never
+ *
+ * The install of a proxy publishes its record: a reader that finds the proxy
+ * in the slot reads the record's group, the selector's initial 0 and the
+ * record's old target, never what was there before.
+ *
+ * The record is modeled by three variables: rg holds its group (the address
+ * of the selector), ro and rn its old and new targets.  The slot holds the
+ * address of rg when it holds the proxy; the reader's tag test is the
+ * comparison with that address.  Before the writer runs, every one of them
+ * holds garbage: junk, or 2 for the selector.
+ *
+ * The code resolves a proxy by indexing the record's targets with the
+ * selector, an address dependency.  herd7 has no arrays, so the reader here
+ * branches on the selector instead, and a branch orders no later load: the
+ * model orders less than the code, and an outcome that it forbids, the code
+ * forbids as well.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int o = 1;
+int n = 1;
+int *a = &o;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *o, int *n)
+{
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, o);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, n);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	rcu_assign_pointer(*a, rg);	// then the proxy
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {			// a proxy: resolve it
+		r1 = READ_ONCE(*r0);		// proxy->group
+		r2 = smp_load_acquire(r1);	// group->selector
+		if (r2) {
+			t = READ_ONCE(*rn);	// proxy->ptr[1]
+		} else {
+			t = READ_ONCE(*ro);	// proxy->ptr[0]
+		}
+	} else {
+		t = r0;
+	}
+	rcu_read_unlock();
+}
+
+exists (1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-flip.litmus b/Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-flip.litmus
new file mode 100644
index 000000000000..200adbb9b25b
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-flip.litmus
@@ -0,0 +1,78 @@
+C RCU-txn+list+step-back+once-flip
+
+(*
+ * Result: Sometimes
+ *
+ * Without the store-release of the flip, a reader can resolve P->next to its
+ * new target, then find N->prev still holding its old one.
+ *
+ * Error injection into RCU-txn+list+step-back: everything else is as there.
+ *)
+
+{
+int sel = 0;
+int nodep = 0;
+int *nprev = &nodep;
+int *pnext = &nprev;
+int *xnext = &nprev;
+int *rpg = &sel;
+int *rpo = &nprev;
+int *rpn = &xnext;
+int *rng = &sel;
+int *rno = &nodep;
+int *rnn = &xnext;
+}
+
+P0(int **pnext, int **nprev, int **xnext, int **rpg, int **rng, int *sel)
+{
+	rcu_assign_pointer(*pnext, rpg);	// install
+	rcu_assign_pointer(*nprev, rng);
+	WRITE_ONCE(*sel, 1);			// flip, unordered
+	rcu_assign_pointer(*pnext, xnext);	// settle
+	rcu_assign_pointer(*nprev, xnext);
+}
+
+P1(int **pnext, int **xnext, int **rpg, int **rpo, int **rpn, int **rng, int **rno, int **rnn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int *u;
+	int *s0;
+	int *s1;
+	int s2;
+	int *back;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*pnext);		// forward from P
+	if (r0 == rpg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rpn);
+		} else {
+			t = READ_ONCE(*rpo);
+		}
+	} else {
+		t = r0;
+	}
+	if (t == xnext) {
+		u = rcu_dereference(*t);	// forward from X, onto N
+		s0 = rcu_dereference(*u);	// back from N
+		if (s0 == rng) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				back = READ_ONCE(*rnn);
+			} else {
+				back = READ_ONCE(*rno);
+			}
+		} else {
+			back = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:t=xnext /\ 1:back=nodep)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-settle.litmus b/Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-settle.litmus
new file mode 100644
index 000000000000..0ead3863fc9d
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-settle.litmus
@@ -0,0 +1,78 @@
+C RCU-txn+list+step-back+once-settle
+
+(*
+ * Result: Sometimes
+ *
+ * Without the store-release of the settle of P->next, a reader can find the
+ * new target settled there, then N->prev still holding its old one.
+ *
+ * Error injection into RCU-txn+list+step-back: everything else is as there.
+ *)
+
+{
+int sel = 0;
+int nodep = 0;
+int *nprev = &nodep;
+int *pnext = &nprev;
+int *xnext = &nprev;
+int *rpg = &sel;
+int *rpo = &nprev;
+int *rpn = &xnext;
+int *rng = &sel;
+int *rno = &nodep;
+int *rnn = &xnext;
+}
+
+P0(int **pnext, int **nprev, int **xnext, int **rpg, int **rng, int *sel)
+{
+	rcu_assign_pointer(*pnext, rpg);	// install
+	rcu_assign_pointer(*nprev, rng);
+	smp_store_release(sel, 1);		// flip
+	WRITE_ONCE(*pnext, xnext);		// settle, unordered
+	rcu_assign_pointer(*nprev, xnext);
+}
+
+P1(int **pnext, int **xnext, int **rpg, int **rpo, int **rpn, int **rng, int **rno, int **rnn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int *u;
+	int *s0;
+	int *s1;
+	int s2;
+	int *back;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*pnext);		// forward from P
+	if (r0 == rpg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rpn);
+		} else {
+			t = READ_ONCE(*rpo);
+		}
+	} else {
+		t = r0;
+	}
+	if (t == xnext) {
+		u = rcu_dereference(*t);	// forward from X, onto N
+		s0 = rcu_dereference(*u);	// back from N
+		if (s0 == rng) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				back = READ_ONCE(*rnn);
+			} else {
+				back = READ_ONCE(*rno);
+			}
+		} else {
+			back = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:t=xnext /\ 1:back=nodep)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+list+step-back.litmus b/Documentation/litmus-tests/rcu/RCU-txn+list+step-back.litmus
new file mode 100644
index 000000000000..85d96e1ebec6
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+list+step-back.litmus
@@ -0,0 +1,85 @@
+C RCU-txn+list+step-back
+
+(*
+ * Result: Never
+ *
+ * An insertion of X between P and N into an rcu_txn_list switches P->next and
+ * N->prev in one transaction.  A reader standing on P that steps forward onto
+ * X, forward again onto N, then back, comes back to X: it never finds the new
+ * forward edge and then the old backward one, which would take it back to P
+ * past X.
+ *
+ * A node is modeled by the address of the link a reader follows from it: X by
+ * its next link xnext, built pointing at N before the insertion, and N by its
+ * prev link nprev.  P, which the reader only stands on, is nodep.  P's next
+ * link is pnext.  The records of the two slots are rp* and rn* (see
+ * RCU-txn+install).
+ *)
+
+{
+int sel = 0;
+int nodep = 0;
+int *nprev = &nodep;
+int *pnext = &nprev;
+int *xnext = &nprev;
+int *rpg = &sel;
+int *rpo = &nprev;
+int *rpn = &xnext;
+int *rng = &sel;
+int *rno = &nodep;
+int *rnn = &xnext;
+}
+
+P0(int **pnext, int **nprev, int **xnext, int **rpg, int **rng, int *sel)
+{
+	rcu_assign_pointer(*pnext, rpg);	// install
+	rcu_assign_pointer(*nprev, rng);
+	smp_store_release(sel, 1);		// flip
+	rcu_assign_pointer(*pnext, xnext);	// settle
+	rcu_assign_pointer(*nprev, xnext);
+}
+
+P1(int **pnext, int **xnext, int **rpg, int **rpo, int **rpn, int **rng, int **rno, int **rnn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int *u;
+	int *s0;
+	int *s1;
+	int s2;
+	int *back;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*pnext);		// forward from P
+	if (r0 == rpg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rpn);
+		} else {
+			t = READ_ONCE(*rpo);
+		}
+	} else {
+		t = r0;
+	}
+	if (t == xnext) {
+		u = rcu_dereference(*t);	// forward from X, onto N
+		s0 = rcu_dereference(*u);	// back from N
+		if (s0 == rng) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				back = READ_ONCE(*rnn);
+			} else {
+				back = READ_ONCE(*rno);
+			}
+		} else {
+			back = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:t=xnext /\ 1:back=nodep)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire+once-resolve.litmus b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire+once-resolve.litmus
new file mode 100644
index 000000000000..8e8114bf66b6
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire+once-resolve.litmus
@@ -0,0 +1,79 @@
+C RCU-txn+monotonic+acquire+once-resolve
+
+(*
+ * Result: Sometimes
+ *
+ * Without the load-acquire of the selector when it resolves slot a, nothing
+ * orders the reader's load of slot b after its load of the selector: the
+ * reader can resolve slot a to its new target, then find slot b still holding
+ * its old one.
+ *
+ * Error injection into RCU-txn+monotonic+acquire: everything else is as there.
+ *)
+
+{
+int sel = 0;
+int aold = 0;
+int bold = 0;
+int bnew = 0;
+int *b = &bold;
+int *a = &aold;
+int *rag = &sel;
+int *rao = &aold;
+int *ran = &b;
+int *rbg = &sel;
+int *rbo = &bold;
+int *rbn = &bnew;
+}
+
+P0(int **a, int **b, int **rag, int **rbg, int *sel, int *bnew)
+{
+	rcu_assign_pointer(*a, rag);	// install
+	rcu_assign_pointer(*b, rbg);
+	smp_store_release(sel, 1);	// flip
+	rcu_assign_pointer(*a, b);	// settle: a now points to b's node
+	rcu_assign_pointer(*b, bnew);
+}
+
+P1(int **a, int **b, int **rag, int **rao, int **ran, int **rbg, int **rbo, int **rbn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *ta;
+	int *s0;
+	int *s1;
+	int s2;
+	int *tb;
+
+	rcu_read_lock();
+	r0 = smp_load_acquire(a);
+	if (r0 == rag) {
+		r1 = READ_ONCE(*r0);
+		r2 = READ_ONCE(*r1);
+		if (r2) {
+			ta = READ_ONCE(*ran);
+		} else {
+			ta = READ_ONCE(*rao);
+		}
+	} else {
+		ta = r0;
+	}
+	if (ta == b) {
+		s0 = rcu_dereference(*b);
+		if (s0 == rbg) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				tb = READ_ONCE(*rbn);
+			} else {
+				tb = READ_ONCE(*rbo);
+			}
+		} else {
+			tb = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:ta=b /\ 1:tb=bold)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire.litmus b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire.litmus
new file mode 100644
index 000000000000..681e42b1d469
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire.litmus
@@ -0,0 +1,81 @@
+C RCU-txn+monotonic+acquire
+
+(*
+ * Result: Never
+ *
+ * As RCU-txn+monotonic+dep, for a reader that loads slot b independently of
+ * slot a, and orders its two loads with a load-acquire of slot a.
+ *
+ * One transaction switches slot a from aold to anew and slot b from bold to
+ * bnew: the writer installs both proxies, flips the selector, then settles
+ * both slots.  ra* and rb* are the two records (see RCU-txn+install).  A node
+ * is modeled by the address of the link a reader follows from it: anew, the
+ * new target of slot a, is the node whose link is slot b.
+ *)
+
+{
+int sel = 0;
+int aold = 0;
+int bold = 0;
+int bnew = 0;
+int *b = &bold;
+int *a = &aold;
+int *rag = &sel;
+int *rao = &aold;
+int *ran = &b;
+int *rbg = &sel;
+int *rbo = &bold;
+int *rbn = &bnew;
+}
+
+P0(int **a, int **b, int **rag, int **rbg, int *sel, int *bnew)
+{
+	rcu_assign_pointer(*a, rag);	// install
+	rcu_assign_pointer(*b, rbg);
+	smp_store_release(sel, 1);	// flip
+	rcu_assign_pointer(*a, b);	// settle: a now points to b's node
+	rcu_assign_pointer(*b, bnew);
+}
+
+P1(int **a, int **b, int **rag, int **rao, int **ran, int **rbg, int **rbo, int **rbn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *ta;
+	int *s0;
+	int *s1;
+	int s2;
+	int *tb;
+
+	rcu_read_lock();
+	r0 = smp_load_acquire(a);
+	if (r0 == rag) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			ta = READ_ONCE(*ran);
+		} else {
+			ta = READ_ONCE(*rao);
+		}
+	} else {
+		ta = r0;
+	}
+	if (ta == b) {
+		s0 = rcu_dereference(*b);
+		if (s0 == rbg) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				tb = READ_ONCE(*rbn);
+			} else {
+				tb = READ_ONCE(*rbo);
+			}
+		} else {
+			tb = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:ta=b /\ 1:tb=bold)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-flip.litmus b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-flip.litmus
new file mode 100644
index 000000000000..4eafbb122e20
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-flip.litmus
@@ -0,0 +1,77 @@
+C RCU-txn+monotonic+dep+once-flip
+
+(*
+ * Result: Sometimes
+ *
+ * Without the store-release of the flip, a reader can resolve slot a to its
+ * new target, then find slot b still holding its old one.
+ *
+ * Error injection into RCU-txn+monotonic+dep: everything else is as there.
+ *)
+
+{
+int sel = 0;
+int aold = 0;
+int bold = 0;
+int bnew = 0;
+int *b = &bold;
+int *a = &aold;
+int *rag = &sel;
+int *rao = &aold;
+int *ran = &b;
+int *rbg = &sel;
+int *rbo = &bold;
+int *rbn = &bnew;
+}
+
+P0(int **a, int **b, int **rag, int **rbg, int *sel, int *bnew)
+{
+	rcu_assign_pointer(*a, rag);	// install
+	rcu_assign_pointer(*b, rbg);
+	WRITE_ONCE(*sel, 1);		// flip, unordered
+	rcu_assign_pointer(*a, b);	// settle: a now points to b's node
+	rcu_assign_pointer(*b, bnew);
+}
+
+P1(int **a, int **b, int **rag, int **rao, int **ran, int **rbg, int **rbo, int **rbn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *ta;
+	int *s0;
+	int *s1;
+	int s2;
+	int *tb;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rag) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			ta = READ_ONCE(*ran);
+		} else {
+			ta = READ_ONCE(*rao);
+		}
+	} else {
+		ta = r0;
+	}
+	if (ta == b) {
+		s0 = rcu_dereference(*ta);
+		if (s0 == rbg) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				tb = READ_ONCE(*rbn);
+			} else {
+				tb = READ_ONCE(*rbo);
+			}
+		} else {
+			tb = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:ta=b /\ 1:tb=bold)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-settle.litmus b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-settle.litmus
new file mode 100644
index 000000000000..7052aa325694
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-settle.litmus
@@ -0,0 +1,77 @@
+C RCU-txn+monotonic+dep+once-settle
+
+(*
+ * Result: Sometimes
+ *
+ * Without the store-release of the settle of slot a, a reader can find the
+ * new target settled there, then slot b still holding its old one.
+ *
+ * Error injection into RCU-txn+monotonic+dep: everything else is as there.
+ *)
+
+{
+int sel = 0;
+int aold = 0;
+int bold = 0;
+int bnew = 0;
+int *b = &bold;
+int *a = &aold;
+int *rag = &sel;
+int *rao = &aold;
+int *ran = &b;
+int *rbg = &sel;
+int *rbo = &bold;
+int *rbn = &bnew;
+}
+
+P0(int **a, int **b, int **rag, int **rbg, int *sel, int *bnew)
+{
+	rcu_assign_pointer(*a, rag);	// install
+	rcu_assign_pointer(*b, rbg);
+	smp_store_release(sel, 1);	// flip
+	WRITE_ONCE(*a, b);		// settle, unordered: a points to b's node
+	rcu_assign_pointer(*b, bnew);
+}
+
+P1(int **a, int **b, int **rag, int **rao, int **ran, int **rbg, int **rbo, int **rbn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *ta;
+	int *s0;
+	int *s1;
+	int s2;
+	int *tb;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rag) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			ta = READ_ONCE(*ran);
+		} else {
+			ta = READ_ONCE(*rao);
+		}
+	} else {
+		ta = r0;
+	}
+	if (ta == b) {
+		s0 = rcu_dereference(*ta);
+		if (s0 == rbg) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				tb = READ_ONCE(*rbn);
+			} else {
+				tb = READ_ONCE(*rbo);
+			}
+		} else {
+			tb = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:ta=b /\ 1:tb=bold)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep.litmus b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep.litmus
new file mode 100644
index 000000000000..e60b43e9f76b
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep.litmus
@@ -0,0 +1,83 @@
+C RCU-txn+monotonic+dep
+
+(*
+ * Result: Never
+ *
+ * A reader that resolves slot a to its new target, then follows that target to
+ * slot b, resolves slot b to its new target as well: the slots of one
+ * transaction resolve old, then new, never new then old, along a chain of
+ * dependent loads.
+ *
+ * One transaction switches slot a from aold to anew and slot b from bold to
+ * bnew: the writer installs both proxies, flips the selector, then settles
+ * both slots.  ra* and rb* are the two records (see RCU-txn+install).  A node
+ * is modeled by the address of the link a reader follows from it: anew, the
+ * new target of slot a, is the node whose link is slot b.
+ *)
+
+{
+int sel = 0;
+int aold = 0;
+int bold = 0;
+int bnew = 0;
+int *b = &bold;
+int *a = &aold;
+int *rag = &sel;
+int *rao = &aold;
+int *ran = &b;
+int *rbg = &sel;
+int *rbo = &bold;
+int *rbn = &bnew;
+}
+
+P0(int **a, int **b, int **rag, int **rbg, int *sel, int *bnew)
+{
+	rcu_assign_pointer(*a, rag);	// install
+	rcu_assign_pointer(*b, rbg);
+	smp_store_release(sel, 1);	// flip
+	rcu_assign_pointer(*a, b);	// settle: a now points to b's node
+	rcu_assign_pointer(*b, bnew);
+}
+
+P1(int **a, int **b, int **rag, int **rao, int **ran, int **rbg, int **rbo, int **rbn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *ta;
+	int *s0;
+	int *s1;
+	int s2;
+	int *tb;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rag) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			ta = READ_ONCE(*ran);
+		} else {
+			ta = READ_ONCE(*rao);
+		}
+	} else {
+		ta = r0;
+	}
+	if (ta == b) {
+		s0 = rcu_dereference(*ta);
+		if (s0 == rbg) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				tb = READ_ONCE(*rbn);
+			} else {
+				tb = READ_ONCE(*rbo);
+			}
+		} else {
+			tb = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:ta=b /\ 1:tb=bold)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+monotonic+unordered.litmus b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+unordered.litmus
new file mode 100644
index 000000000000..7591d5c048da
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+monotonic+unordered.litmus
@@ -0,0 +1,84 @@
+C RCU-txn+monotonic+unordered
+
+(*
+ * Result: Sometimes
+ *
+ * Without a dependency or a load-acquire between its two loads, a reader can
+ * resolve slot a to its new target, then find slot b still holding its old one.
+ *
+ * Error injection into RCU-txn+monotonic+dep and RCU-txn+monotonic+acquire:
+ * the reader loads slot b independently of slot a.
+ *
+ * One transaction switches slot a from aold to anew and slot b from bold to
+ * bnew: the writer installs both proxies, flips the selector, then settles
+ * both slots.  ra* and rb* are the two records (see RCU-txn+install).  A node
+ * is modeled by the address of the link a reader follows from it: anew, the
+ * new target of slot a, is the node whose link is slot b.
+ *)
+
+{
+int sel = 0;
+int aold = 0;
+int bold = 0;
+int bnew = 0;
+int *b = &bold;
+int *a = &aold;
+int *rag = &sel;
+int *rao = &aold;
+int *ran = &b;
+int *rbg = &sel;
+int *rbo = &bold;
+int *rbn = &bnew;
+}
+
+P0(int **a, int **b, int **rag, int **rbg, int *sel, int *bnew)
+{
+	rcu_assign_pointer(*a, rag);	// install
+	rcu_assign_pointer(*b, rbg);
+	smp_store_release(sel, 1);	// flip
+	rcu_assign_pointer(*a, b);	// settle: a now points to b's node
+	rcu_assign_pointer(*b, bnew);
+}
+
+P1(int **a, int **b, int **rag, int **rao, int **ran, int **rbg, int **rbo, int **rbn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *ta;
+	int *s0;
+	int *s1;
+	int s2;
+	int *tb;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rag) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			ta = READ_ONCE(*ran);
+		} else {
+			ta = READ_ONCE(*rao);
+		}
+	} else {
+		ta = r0;
+	}
+	if (ta == b) {
+		s0 = rcu_dereference(*b);
+		if (s0 == rbg) {
+			s1 = READ_ONCE(*s0);
+			s2 = smp_load_acquire(s1);
+			if (s2) {
+				tb = READ_ONCE(*rbn);
+			} else {
+				tb = READ_ONCE(*rbo);
+			}
+		} else {
+			tb = s0;
+		}
+	}
+	rcu_read_unlock();
+}
+
+exists (1:ta=b /\ 1:tb=bold)
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+publish+once-install.litmus b/Documentation/litmus-tests/rcu/RCU-txn+publish+once-install.litmus
new file mode 100644
index 000000000000..bcfc5a2841d6
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+publish+once-install.litmus
@@ -0,0 +1,60 @@
+C RCU-txn+publish+once-install
+
+(*
+ * Result: Sometimes
+ *
+ * Without the store-release of the install, a reader can find the proxy
+ * before the record it points at is written.
+ *
+ * Error injection into RCU-txn+publish: everything else is as there.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int n = 0;
+int *a = 0;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *n)
+{
+	WRITE_ONCE(*n, 1);		// build the new object
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, NULL);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, n);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	WRITE_ONCE(*a, rg);		// then the proxy
+	smp_store_release(sel, 1);	// __rcu_txn_group_commit()
+	rcu_assign_pointer(*a, n);	// __rcu_txn_record_settle()
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int d;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	if (t)
+		d = READ_ONCE(*t);
+	rcu_read_unlock();
+}
+
+exists ((1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk)) \/ (1:t=n /\ 1:d=0))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+publish+once-settle.litmus b/Documentation/litmus-tests/rcu/RCU-txn+publish+once-settle.litmus
new file mode 100644
index 000000000000..251832e9bbb3
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+publish+once-settle.litmus
@@ -0,0 +1,60 @@
+C RCU-txn+publish+once-settle
+
+(*
+ * Result: Sometimes
+ *
+ * Without the store-release of the settle, a reader can find the new object
+ * in the slot before the object is built.
+ *
+ * Error injection into RCU-txn+publish: everything else is as there.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int n = 0;
+int *a = 0;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *n)
+{
+	WRITE_ONCE(*n, 1);		// build the new object
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, NULL);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, n);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	rcu_assign_pointer(*a, rg);	// then the proxy
+	smp_store_release(sel, 1);	// __rcu_txn_group_commit()
+	WRITE_ONCE(*a, n);		// __rcu_txn_record_settle()
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int d;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	if (t)
+		d = READ_ONCE(*t);
+	rcu_read_unlock();
+}
+
+exists ((1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk)) \/ (1:t=n /\ 1:d=0))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+publish.litmus b/Documentation/litmus-tests/rcu/RCU-txn+publish.litmus
new file mode 100644
index 000000000000..7a619330109f
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+publish.litmus
@@ -0,0 +1,71 @@
+C RCU-txn+publish
+
+(*
+ * Result: Never
+ *
+ * A transaction publishes a new object, end to end: the writer builds the
+ * object, initializes the record, installs the proxy, flips the selector and
+ * settles the slot.  A reader that finds the proxy reads the record
+ * initialized, and a reader that reaches the object, through the proxy or in
+ * the slot once settled, reads it built.
+ *
+ * Slot a switches from NULL to the new object n, built by storing 1 to it.
+ * The record is rg, ro and rn (see RCU-txn+install), garbage before the writer
+ * runs: junk, or 2 for the selector.
+ *
+ * The object is built before the install, whose store-release orders it for a
+ * reader that finds the proxy: without the flip's store-release, this outcome
+ * stays forbidden.  The flip's store-release orders the installs of a
+ * transaction before its selector, for a reader that resolves several of its
+ * slots: see RCU-txn+monotonic+dep+once-flip.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int n = 0;
+int *a = 0;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *n)
+{
+	WRITE_ONCE(*n, 1);		// build the new object
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, NULL);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, n);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	rcu_assign_pointer(*a, rg);	// then the proxy
+	smp_store_release(sel, 1);	// __rcu_txn_group_commit()
+	rcu_assign_pointer(*a, n);	// __rcu_txn_record_settle()
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int d;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	if (t)
+		d = READ_ONCE(*t);
+	rcu_read_unlock();
+}
+
+exists ((1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk)) \/ (1:t=n /\ 1:d=0))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+remove+nolock.litmus b/Documentation/litmus-tests/rcu/RCU-txn+remove+nolock.litmus
new file mode 100644
index 000000000000..d32fe9a34d42
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+remove+nolock.litmus
@@ -0,0 +1,64 @@
+C RCU-txn+remove+nolock
+
+(*
+ * Result: Sometimes
+ *
+ * Without an RCU read-side critical section around the load and the
+ * resolution, the grace period does not wait for the reader, which can then
+ * read the record or the object after it is freed.
+ *
+ * Error injection into RCU-txn+remove: everything else is as there.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int o = 1;
+int *a = &o;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *o, int *junk)
+{
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, o);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, NULL);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	rcu_assign_pointer(*a, rg);	// then the proxy
+	smp_store_release(sel, 1);	// __rcu_txn_group_commit()
+	rcu_assign_pointer(*a, NULL);	// __rcu_txn_record_settle()
+	synchronize_rcu();		// both kfree_rcu()
+	WRITE_ONCE(*o, 0);		// the allocator reuses the object
+	WRITE_ONCE(*sel, 2);		// and the descriptor
+	WRITE_ONCE(*rg, junk);
+	WRITE_ONCE(*ro, junk);
+	WRITE_ONCE(*rn, junk);
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int d;
+
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	if (t)
+		d = READ_ONCE(*t);
+}
+
+exists ((1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk)) \/ (1:t=o /\ 1:d=0))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+remove+nosync.litmus b/Documentation/litmus-tests/rcu/RCU-txn+remove+nosync.litmus
new file mode 100644
index 000000000000..76b2ed36b99e
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+remove+nosync.litmus
@@ -0,0 +1,64 @@
+C RCU-txn+remove+nosync
+
+(*
+ * Result: Sometimes
+ *
+ * Without a grace period between the settle and the frees, a reader can read
+ * the record or the object after it is freed.
+ *
+ * Error injection into RCU-txn+remove: everything else is as there.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int o = 1;
+int *a = &o;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *o, int *junk)
+{
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, o);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, NULL);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	rcu_assign_pointer(*a, rg);	// then the proxy
+	smp_store_release(sel, 1);	// __rcu_txn_group_commit()
+	rcu_assign_pointer(*a, NULL);	// __rcu_txn_record_settle()
+	WRITE_ONCE(*o, 0);		// the allocator reuses the object
+	WRITE_ONCE(*sel, 2);		// and the descriptor
+	WRITE_ONCE(*rg, junk);
+	WRITE_ONCE(*ro, junk);
+	WRITE_ONCE(*rn, junk);
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int d;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	if (t)
+		d = READ_ONCE(*t);
+	rcu_read_unlock();
+}
+
+exists ((1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk)) \/ (1:t=o /\ 1:d=0))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+remove+once-install.litmus b/Documentation/litmus-tests/rcu/RCU-txn+remove+once-install.litmus
new file mode 100644
index 000000000000..514ff3c12e63
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+remove+once-install.litmus
@@ -0,0 +1,65 @@
+C RCU-txn+remove+once-install
+
+(*
+ * Result: Sometimes
+ *
+ * Without the store-release of the install, a reader can find the proxy
+ * before the record it points at is written.
+ *
+ * Error injection into RCU-txn+remove: everything else is as there.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int o = 1;
+int *a = &o;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *o, int *junk)
+{
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, o);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, NULL);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	WRITE_ONCE(*a, rg);		// then the proxy
+	smp_store_release(sel, 1);	// __rcu_txn_group_commit()
+	rcu_assign_pointer(*a, NULL);	// __rcu_txn_record_settle()
+	synchronize_rcu();		// both kfree_rcu()
+	WRITE_ONCE(*o, 0);		// the allocator reuses the object
+	WRITE_ONCE(*sel, 2);		// and the descriptor
+	WRITE_ONCE(*rg, junk);
+	WRITE_ONCE(*ro, junk);
+	WRITE_ONCE(*rn, junk);
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int d;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	if (t)
+		d = READ_ONCE(*t);
+	rcu_read_unlock();
+}
+
+exists ((1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk)) \/ (1:t=o /\ 1:d=0))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+remove.litmus b/Documentation/litmus-tests/rcu/RCU-txn+remove.litmus
new file mode 100644
index 000000000000..a1bedc74c238
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+remove.litmus
@@ -0,0 +1,72 @@
+C RCU-txn+remove
+
+(*
+ * Result: Never
+ *
+ * A transaction removes an object, end to end: the writer initializes the
+ * record, installs the proxy, flips the selector, settles the slot to NULL,
+ * then frees the descriptor and the object after a grace period, as their
+ * kfree_rcu() does.  A reader that finds the proxy reads the record initialized
+ * and not yet freed, and a reader that reaches the object, in the slot before
+ * the install or through the proxy, never reads it freed.
+ *
+ * Slot a switches from the object o to NULL.  The record is rg, ro and rn (see
+ * RCU-txn+install), garbage before the writer runs: junk, or 2 for the
+ * selector.  Freeing stores 0 into the object and garbage into the descriptor,
+ * as the allocator may.
+ *)
+
+{
+int junk = 9;
+int sel = 2;
+int *rg = &junk;
+int *ro = &junk;
+int *rn = &junk;
+int o = 1;
+int *a = &o;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *o, int *junk)
+{
+	WRITE_ONCE(*sel, 0);		// __rcu_txn_group_init()
+	WRITE_ONCE(*ro, o);		// __rcu_txn_record_set()
+	WRITE_ONCE(*rn, NULL);
+	WRITE_ONCE(*rg, sel);		// __rcu_txn_record_install(): r->group,
+	rcu_assign_pointer(*a, rg);	// then the proxy
+	smp_store_release(sel, 1);	// __rcu_txn_group_commit()
+	rcu_assign_pointer(*a, NULL);	// __rcu_txn_record_settle()
+	synchronize_rcu();		// both kfree_rcu()
+	WRITE_ONCE(*o, 0);		// the allocator reuses the object
+	WRITE_ONCE(*sel, 2);		// and the descriptor
+	WRITE_ONCE(*rg, junk);
+	WRITE_ONCE(*ro, junk);
+	WRITE_ONCE(*rn, junk);
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+	int d;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	if (t)
+		d = READ_ONCE(*t);
+	rcu_read_unlock();
+}
+
+exists ((1:r0=rg /\ (1:r1=junk \/ 1:r2=2 \/ 1:t=junk)) \/ (1:t=o /\ 1:d=0))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+sync+free+nolock.litmus b/Documentation/litmus-tests/rcu/RCU-txn+sync+free+nolock.litmus
new file mode 100644
index 000000000000..3c4afa728506
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+sync+free+nolock.litmus
@@ -0,0 +1,55 @@
+C RCU-txn+sync+free+nolock
+
+(*
+ * Result: Sometimes
+ *
+ * Without an RCU read-side critical section around the load and the
+ * resolution, the grace period does not wait for the reader, which can then
+ * read the record after it is freed.
+ *
+ * Error injection into RCU-txn+sync+free: everything else is as there.
+ *)
+
+{
+int junk = 9;
+int sel = 0;
+int o = 1;
+int n = 1;
+int *rg = &sel;
+int *ro = &o;
+int *rn = &n;
+int *a = &rg;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *n, int *junk)
+{
+	smp_store_release(sel, 1);	// flip
+	rcu_assign_pointer(*a, n);	// settle
+	synchronize_rcu();		// kfree_rcu() of the descriptor
+	WRITE_ONCE(*rg, junk);
+	WRITE_ONCE(*ro, junk);
+	WRITE_ONCE(*rn, junk);
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+}
+
+exists (1:r0=rg /\ (1:r1=junk \/ 1:t=junk))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+sync+free+nosync.litmus b/Documentation/litmus-tests/rcu/RCU-txn+sync+free+nosync.litmus
new file mode 100644
index 000000000000..85a69ea6edb4
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+sync+free+nosync.litmus
@@ -0,0 +1,55 @@
+C RCU-txn+sync+free+nosync
+
+(*
+ * Result: Sometimes
+ *
+ * Without a grace period between the settle and the free, a reader that
+ * loaded the proxy can read the record after it is freed.
+ *
+ * Error injection into RCU-txn+sync+free: everything else is as there.
+ *)
+
+{
+int junk = 9;
+int sel = 0;
+int o = 1;
+int n = 1;
+int *rg = &sel;
+int *ro = &o;
+int *rn = &n;
+int *a = &rg;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *n, int *junk)
+{
+	smp_store_release(sel, 1);	// flip
+	rcu_assign_pointer(*a, n);	// settle
+	WRITE_ONCE(*rg, junk);
+	WRITE_ONCE(*ro, junk);
+	WRITE_ONCE(*rn, junk);
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	rcu_read_unlock();
+}
+
+exists (1:r0=rg /\ (1:r1=junk \/ 1:t=junk))
diff --git a/Documentation/litmus-tests/rcu/RCU-txn+sync+free.litmus b/Documentation/litmus-tests/rcu/RCU-txn+sync+free.litmus
new file mode 100644
index 000000000000..d9dc0a833993
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU-txn+sync+free.litmus
@@ -0,0 +1,60 @@
+C RCU-txn+sync+free
+
+(*
+ * Result: Never
+ *
+ * A record outlives every reader that may hold its proxy: commit() frees the
+ * descriptor with kfree_rcu() after the settle, and a reader loads a slot and
+ * resolves what it loaded within one RCU read-side critical section.  Such a
+ * reader never reads the freed record.
+ *
+ * The record is rg, ro and rn (see RCU-txn+install), installed when the writer
+ * starts.  After the flip, the settle and a grace period, the writer stores
+ * junk into the record, as the allocator may once kfree_rcu() has run.
+ *)
+
+{
+int junk = 9;
+int sel = 0;
+int o = 1;
+int n = 1;
+int *rg = &sel;
+int *ro = &o;
+int *rn = &n;
+int *a = &rg;
+}
+
+P0(int **a, int **rg, int **ro, int **rn, int *sel, int *n, int *junk)
+{
+	smp_store_release(sel, 1);	// flip
+	rcu_assign_pointer(*a, n);	// settle
+	synchronize_rcu();		// kfree_rcu() of the descriptor
+	WRITE_ONCE(*rg, junk);
+	WRITE_ONCE(*ro, junk);
+	WRITE_ONCE(*rn, junk);
+}
+
+P1(int **a, int **rg, int **ro, int **rn)
+{
+	int *r0;
+	int *r1;
+	int r2;
+	int *t;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*a);
+	if (r0 == rg) {
+		r1 = READ_ONCE(*r0);
+		r2 = smp_load_acquire(r1);
+		if (r2) {
+			t = READ_ONCE(*rn);
+		} else {
+			t = READ_ONCE(*ro);
+		}
+	} else {
+		t = r0;
+	}
+	rcu_read_unlock();
+}
+
+exists (1:r0=rg /\ (1:r1=junk \/ 1:t=junk))
diff --git a/MAINTAINERS b/MAINTAINERS
index f34040369eb4..e0dd49be20f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22858,6 +22858,7 @@ M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	rcu@vger.kernel.org
 S:	Maintained
 F:	Documentation/RCU/rcu_txn.rst
+F:	Documentation/litmus-tests/rcu/RCU-txn+*
 F:	include/linux/rcu_txn*.h
 F:	lib/rcu_txn*
 F:	lib/tests/rcu_txn_kunit.c
-- 
2.47.3

