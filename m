Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42C41A902;
	Wed,  7 Oct 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406769; cv=none; b=nZ8q4pkh/4J5vNqvl8LeWp5u/5A3q/lPeC7/zdcRvxDxfaSjyIufGuO25D+nU5GFHjszbuid1Uc7n/wUxdQYCpbdZbIBqLUxqR7exw3ebUgdEJl8NHdq8YmfHtpRuE39Shx/ooDul/MLvGa5Bva2BpB+8iDkoQq0hfKtQ7Rp+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406769; c=relaxed/simple;
	bh=IprSojNDv0Xa3zHoMEapBIlM+mOv2VzZff4M85xHwU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+K14St32rLLQCqr327YM86Esl8EUjgEbJxgW4EI+617oZacL16wbWGFE40DWDeyxkdyEELzHK1iJb+oh+1Z9vNvP8yHpLc9qe5EjYCFjKoe45IWbcQt4QvYYs+7Vdv8QUxvwKqiDRI62dLvrFcXXsb341nCOkci8QuUSyh8YfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJrRXAam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJrRXAam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81951F008A1;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=rua0O72KZ/QGJ6XqBtRxG+LSz/0k9q7Qki6PnyneR84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BJrRXAamo6hvzi/1dZDI91QNnmi5i4bMXXlWlnc4ptGA3Zk098swijdGCY6u+2tW4
	 pofJ7p5NkMOrsHQkCBLMlXqitUEBtwIF0H76x708ExUYVknTDsP0kuaZ2O7yRKTgBc
	 idZQSJAHe+Vpe9sEw1LmxjhBsg55XopHPesVem+ax3GK2m1MeM0KKrGBdTzE/c7+E6
	 0JI6S8AfdN5cG6xjj/k2MjpFv7NLgAuSU6iqOMVgq97iq7oCBl4VlDWGiNy9THU01H
	 XMNZG8gOYjjWygk6sK2fvWyPOVxTiih1NUOeE1P1zWERAbBBH7q7RW2fuhdAA5jcWE
	 PkMGrP7lpZ7nQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2DD5DCE275A; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 12/21] srcutree: Add reader-free fastpath to synchronize_srcu_atomic()
Date: Wed,  7 Oct 2026 13:59:15 -0700
Message-Id: <20261007205924.1983367-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

synchronize_srcu_atomic() is restricted to srcu_read_lock_atomic() and
srcu_read_unlock_atomic(), whose read-side critical sections disable
preemption.  In the common case where there are no readers at all, the
grace period therefore need not do the index flip.  Add a fastpath
that sums both ranks of the per-CPU ->srcu_ctrs[] counters and, if the
lock counts match the unlock counts on both ranks, ends the grace
period immediately, skipping the srcu_advance_state() scans, mirroring
the similar Tiny SRCU fastpath.

Correctness requires the counter-sum proof to follow the grace-period
anchor written by srcu_gp_start(); placing it before the anchor could
let this grace period miss a pre-existing reader and return without
waiting for it.  The smp_mb() between the unlock and lock sums pairs
with the smp_mb() in __srcu_read_lock().  The grace period is ended
manually under ->lock and ->srcu_atomic_gp_flag.

In theory, this is slower than David Woodhouse's earlier patch, but
David's measurements showed that the performance was close enough
that it makes sense to keep the get_state_synchronize_srcu() and
poll_state_synchronize_srcu semantics.

Link: https://lore.kernel.org/all/20260907075829.2073224-4-kunwu.chan@linux.dev/
Link: https://lore.kernel.org/all/0f4dea21bac43685d3286df329401177e4452b36.camel@infradead.org/
Link: https://lore.kernel.org/all/0d4af6318ac67486858be1df8d436147b444a2d2.camel@infradead.org/
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 kernel/rcu/srcutree.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 64081c8eacc84..93b8d1088abe8 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2119,6 +2119,8 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 {
 	unsigned long srcu_state;
 	struct srcu_usage *sup = ssp->srcu_sup;
+	unsigned long rdm0, rdm1;
+	unsigned long unlocks0, unlocks1;
 
 	// Initialize.	Either init_srcu_struct() was invoked or
 	// DEFINE_SRCU() or similar was used.  Therefore, no allocation
@@ -2154,6 +2156,52 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	srcu_gp_start(ssp);
 	raw_spin_unlock_irq_rcu_node(sup);
 
+	//
+	// Fastpath:  If there are no readers at all, neither grace-period
+	// scan need wait, so both can be satisfied at once without doing
+	// the index flip.  The counter-sum proof is the same as that of
+	// srcu_readers_active_idx_check(), but spanning both indices.
+	// Atomic SRCU guarantees that all readers are of
+	// SRCU_READ_FLAVOR_ATOMIC, so the SLOWGP check never triggers and
+	// the ->srcu_reader_flavor masks returned by
+	// srcu_readers_unlock_idx() are unused.
+	//
+	// This proof must follow the grace-period anchor written by the
+	// srcu_gp_start() above, never precede it.  With the anchor first,
+	// a reader whose lock increment is missed by the sums below cannot
+	// have incremented its lock counter before the anchor, and therefore
+	// cannot be a pre-existing reader of this grace period.  Placing the
+	// proof before the anchor would let this grace period miss a
+	// pre-existing reader and return without waiting for it.
+	//
+	// The smp_mb() pairs with the smp_mb() in __srcu_read_lock()
+	// (store-buffering pattern), which guarantees that a lock is always
+	// counted if the corresponding unlock is counted, the same
+	// memory-ordering guarantee as is provided by
+	// srcu_readers_active_idx_check().
+	//
+	unlocks0 = srcu_readers_unlock_idx(ssp, 0, &rdm0);
+	unlocks1 = srcu_readers_unlock_idx(ssp, 1, &rdm1);
+	smp_mb(); /* A */
+	if (srcu_readers_lock_idx(ssp, 0, false, unlocks0) &&
+	    srcu_readers_lock_idx(ssp, 1, false, unlocks1)) {
+		// No readers, so end this grace period manually, skipping
+		// the index flip.  Advancing the sequence number via
+		// rcu_seq_start() in srcu_gp_start() above and rcu_seq_end()
+		// below keeps get_state_synchronize_srcu() and
+		// poll_state_synchronize_srcu() working, all under ->lock
+		// and ->srcu_atomic_gp_flag, which excludes concurrent
+		// sequence-number updates.
+		raw_spin_lock_irq_rcu_node(sup);
+		rcu_seq_end(&sup->srcu_gp_seq);
+		raw_spin_unlock_irq_rcu_node(sup);
+		WARN_ON_ONCE(!poll_state_synchronize_srcu(ssp, srcu_state));
+		atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
+		preempt_enable();
+		non_block_end();
+		return;
+	}
+
 	// Wait for it to complete, helping it along.
 	while (!poll_state_synchronize_srcu(ssp, srcu_state)) {
 		cpu_relax();
-- 
2.40.1

