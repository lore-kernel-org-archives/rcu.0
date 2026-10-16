Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659044DD3AA;
	Fri, 16 Oct 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157622; cv=none; b=M9RlRO2/gHa0lQPacS7cjia5rN+KQ7zHUIiu1AmlBt9DPsryi+n0SU1SjOIQ/9PP2huECERtkin26TSjWQlu8D5X6qpN2s419FpWY0TWCsQgDMXlzTIPajB36mjhHEBOzNb1+o47GGPdGqKDxyesjZR66pQiI14Vtpui5Y1NQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157622; c=relaxed/simple;
	bh=amwELeKMgyqp7ByM2gnaS2c6sW7SrGjjHiAVVBs/dlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9G5bjB94qgKQvydrLNtNe7PR8v1L9YHDUlq02i1IimMKj/gn7oQkHgRbWZ+udpCPipMEGJxeWCS+qMDo1Fa2s5HPz+iSHH8ieP+rEwJrnxmgK4kM9WUOofQ+X1FWIX3b24aiIOkbQTeBGgM3zIPTlh3vURyf39efQjeMHBDxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=IMTE/Q91; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IMTE/Q91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157609;
	bh=KsVPHtv1QpDEkqRLnqTBF2WrWAtZMIannotWKe27+yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMTE/Q91EmIXqpfwzuJQCwZRwdKe2hXpINQ74unQk0dVjJLWz7gwRZ4VwPnMVa3hW
	 ZPIgzycjxKfF2kdfYSDkeq21Y4NqVDZHlCJJvDyo8rXJYH7VaEXg3XnK2JXO66SP4t
	 FYc9VIhRm/5H7rZhTuN/ii+rBxUAJ0DKhNKWqOJb83OAjcuCXh7+c4apQxkyynNscN
	 KCCh6SGYa7ojhDds4Hs8FTxuowwBuDsvskBjrSDeykQHjR35L66zRHIhjClcNMMGy9
	 1MDCO3alTmfMcFaDKqKYC42lYntCzbwipsCQm2xd1ERB0YsS3sTmA81l6gm5N6nGeM
	 B5wqJ315dgI/A==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9N6K8Mzmj9;
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
Subject: [RFC PATCH 10/12] rcu_txn: Test a commit from atomic context
Date: Fri, 16 Oct 2026 09:33:17 -0400
Message-Id: <20261016133319.433617-11-mathieu.desnoyers@efficios.com>
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

A hash table with hlist_bl buckets excludes its writers with a bit
spinlock.  On PREEMPT_RT a bit spinlock keeps the semantics of a raw
spinlock: nothing under it may take a sleeping lock, which rules out the
memory allocator.

Commit a transaction of two records under a bit spinlock, another under
a raw spinlock with interrupts off, and a single record and a cancel
under the bit spinlock, and check that neither lockdep nor the
might_sleep() checks report anything.  The transactions reserve their
records before they take the lock, so recording and committing allocate
nothing, and the descriptor of a commit that installed proxies goes to
kfree_rcu(), which is allowed there.  Each commit's return value is
checked once the lock is released, since a failed expectation allocates.

The test is only meaningful on a PREEMPT_RT kernel with lockdep,
PROVE_RAW_LOCK_NESTING and DEBUG_ATOMIC_SLEEP.  It passes there, and
fails as expected when a spinlock_t is taken under the bit spinlock.

The last two cases release a descriptor that installed no proxy, which
has to be kfree_rcu() on PREEMPT_RT.  They would pass with a kfree() as
well: a kfree() under a bit spinlock on PREEMPT_RT was reported by
neither lockdep nor the might_sleep() checks when tried.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 lib/tests/rcu_txn_kunit.c | 85 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/lib/tests/rcu_txn_kunit.c b/lib/tests/rcu_txn_kunit.c
index fa01dcb7df2b..c534d8962960 100644
--- a/lib/tests/rcu_txn_kunit.c
+++ b/lib/tests/rcu_txn_kunit.c
@@ -7,8 +7,11 @@
 
 #include <kunit/test.h>
 #include <linux/bug.h>
+#include <linux/debug_locks.h>
 #include <linux/kthread.h>
+#include <linux/list_bl.h>
 #include <linux/minmax.h>
+#include <linux/panic.h>
 #include <linux/rcu_txn.h>
 #include <linux/rcu_txn_hlist.h>
 #include <linux/rcu_txn_list.h>
@@ -1992,6 +1995,87 @@ static void rcu_txn_test_list_concurrent(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, cross_violations, 0);
 }
 
+/* Did the kernel report something since @tainted and @locks were sampled? */
+static void expect_no_report(struct kunit *test, bool tainted, int locks)
+{
+	KUNIT_EXPECT_EQ(test, test_taint(TAINT_WARN), tainted);
+	KUNIT_EXPECT_EQ(test, debug_locks, locks);
+}
+
+/*
+ * A commit from atomic context: under a bit spinlock, which is how a hash
+ * table with hlist_bl buckets excludes its writers, and under a raw spinlock.
+ * On PREEMPT_RT neither may take a sleeping lock, which lockdep and the
+ * might_sleep() checks would report.
+ *
+ * The transaction reserves its records before it takes the lock, so recording
+ * and committing allocate nothing, and the descriptor of a commit that
+ * installed proxies is handed to kfree_rcu().
+ *
+ * A descriptor that installed none is released under the lock as well, by a
+ * commit of one record or by a cancel.  On PREEMPT_RT that has to be
+ * kfree_rcu() too, but these checks did not report a kfree() there when
+ * tried: those two cases only exercise the path.
+ */
+static void rcu_txn_test_commit_atomic(struct kunit *test)
+{
+	static DEFINE_RAW_SPINLOCK(raw_lock);
+	void __rcu *s1 = RCU_INITIALIZER(T(0));
+	void __rcu *s2 = RCU_INITIALIZER(T(1));
+	bool tainted = test_taint(TAINT_WARN);
+	struct hlist_bl_head bucket;
+	int locks = debug_locks;
+	unsigned long flags;
+	struct rcu_txn txn;
+	int err;
+
+	INIT_HLIST_BL_HEAD(&bucket);
+
+	/* Two records, under a bit spinlock. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, rcu_txn_reserve(&txn, 2));
+	hlist_bl_lock(&bucket);
+	rcu_txn_record(&txn, &s1, T(0), T(10), TAG);
+	rcu_txn_record(&txn, &s2, T(1), T(11), TAG);
+	err = rcu_txn_commit(&txn);
+	hlist_bl_unlock(&bucket);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	expect_no_report(test, tainted, locks);
+
+	/* Two records, under a raw spinlock with interrupts off. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, rcu_txn_reserve(&txn, 2));
+	raw_spin_lock_irqsave(&raw_lock, flags);
+	rcu_txn_record(&txn, &s1, T(10), T(20), TAG);
+	rcu_txn_record(&txn, &s2, T(11), T(21), TAG);
+	err = rcu_txn_commit(&txn);
+	raw_spin_unlock_irqrestore(&raw_lock, flags);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	expect_no_report(test, tainted, locks);
+
+	/* One record. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, rcu_txn_reserve(&txn, 2));
+	hlist_bl_lock(&bucket);
+	rcu_txn_record(&txn, &s1, T(20), T(40), TAG);
+	err = rcu_txn_commit(&txn);
+	hlist_bl_unlock(&bucket);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	expect_no_report(test, tainted, locks);
+
+	/* A cancel of such a handle. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, rcu_txn_reserve(&txn, 2));
+	hlist_bl_lock(&bucket);
+	rcu_txn_record(&txn, &s1, T(40), T(50), TAG);
+	rcu_txn_cancel(&txn);
+	hlist_bl_unlock(&bucket);
+	expect_no_report(test, tainted, locks);
+
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s1), T(40));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s2), T(21));
+}
+
 static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_single_record),
 	KUNIT_CASE(rcu_txn_test_multi_record),
@@ -2051,6 +2135,7 @@ static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_list_compose_moves),
 	KUNIT_CASE(rcu_txn_test_list_debug_disjoint_compose),
 	KUNIT_CASE_SLOW(rcu_txn_test_list_concurrent),
+	KUNIT_CASE(rcu_txn_test_commit_atomic),
 	{}
 };
 
-- 
2.47.3

