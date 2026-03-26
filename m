Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66F3C2798;
	Thu, 26 Mar 2026 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520787; cv=none; b=Bv63qxqbFRHfUNDlrZ/HPCPhiOxk+igWPHEl69jZFq4eqCsWopDfyWrAejeoB6JfiLntT9JvrLIxdPTxs5Wnst2o8XIXEDA+MGgFjUb/KhLhUVTSfQ+HSbzEUuA19XNdlxZzTFSmCMdsuSiOiGpZ96/+2YXW5iwGiqnt1yb0IdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520787; c=relaxed/simple;
	bh=TdkzCZHdM28WDeRmdIvcgFU3uvexxFP8El/TM/03qtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRAeSdNvA/SW1SBILu1yB2F8kmI7WCZS1qTJVvjD5vS+AjwPEmeQ+dZYdEyAqa46UQ78SHUeuosajaJ7KRekGYyRRCcRPCL+1Zt+ZQeSD5NFdni3AGISgHQMpWA2doeiI+/K3hQeuk9rwrx4EKklNy5zfjF+i7WQjFbEABAs5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/VSRvxC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/VSRvxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2702C116C6;
	Thu, 26 Mar 2026 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774520787;
	bh=TdkzCZHdM28WDeRmdIvcgFU3uvexxFP8El/TM/03qtw=;
	h=From:To:Cc:Subject:Date:From;
	b=V/VSRvxCVfDYVqCtIIYKoADCz1gpKAW6BUfAPB/MKMG0pPNkgCqdm0JfoJekUn30b
	 izWSuouSKsjIYcfVhUra68PhlulZMcmokh8D+NqknxV3iOH34jKaLP2VWMb6Ousxe8
	 A2t83pmVirg7a7KnWH8KPIF/ycD6aarUfROWrvJGb1e+G6E4DUOR0vhm6HRgI3NqNV
	 T/7bwq8gz7KOz8oYbpa8lQfDbTxAaK1frEzrgbJSXIOqpm7/0PYS/xsjb2eDeXP6Sf
	 /RQMI4VW13l/e9M4QezgYLQpVACTeK/Zb2ztqfVlyfAG+Gz4x6JLTFQzTXq+VIrQn3
	 jYkeuWd/+SK5Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH] srcu: Optimize SRCU-fast per-CPU counter increments on arm64
Date: Thu, 26 Mar 2026 03:26:07 -0700
Message-ID: <20260326102608.1855088-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On architectures like arm64, this_cpu_inc() wraps the underlying atomic
instruction (ldadd) with preempt_disable/enable to prevent migration
between the per-CPU address calculation and the atomic operation.
However, SRCU does not need this protection because it sums counters
across all CPUs for grace-period detection, so operating on a "stale"
CPU's counter after migration is harmless.

This commit therefore introduces srcu_percpu_counter_inc(), which
consolidates the SRCU-fast reader counter updates into a single helper,
replacing the if/else dispatch between this_cpu_inc() and
atomic_long_inc(raw_cpu_ptr(...)) that was previously open-coded at
each call site.

On arm64, this helper uses atomic_long_fetch_add_relaxed(), which
compiles to the value-returning ldadd instruction.  This is preferred
over atomic_long_inc()'s non-value-returning stadd because ldadd is
resolved in L1 cache whereas stadd may be resolved further out in the
memory hierarchy [1].

On x86, where this_cpu_inc() compiles to a single "incl %gs:offset"
instruction with no preempt wrappers, the helper falls through to
this_cpu_inc(), so there is no change.  Architectures with
NEED_SRCU_NMI_SAFE continue to use atomic_long_inc(raw_cpu_ptr(...)),
again with no change.  All remaining architectures also use the
this_cpu_inc() path, again with no change.

refscale measurements on a 72-CPU arm64 Neoverse-V2 system show ~11%
improvement in SRCU-fast reader duration:

  Unpatched: median 9.273 ns, avg 9.319 ns (min 9.219, max 9.853)
    Patched: median 8.275 ns, avg 8.411 ns (min 8.186, max 9.183)

  Command: kvm.sh --torture refscale --duration 1 --cpus 72 \
           --configs NOPREEMPT --trust-make --bootargs \
           "refscale.scale_type=srcu-fast refscale.nreaders=72 \
           refscale.nruns=100"

[1] https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/srcutree.h | 51 +++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index fd1a9270cb9a..4ff18de3edfd 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -286,15 +286,43 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * on architectures that support NMIs but do not supply NMI-safe
  * implementations of this_cpu_inc().
  */
+
+/*
+ * Atomically increment a per-CPU SRCU counter.
+ *
+ * On most architectures, this_cpu_inc() is optimal (e.g., on x86 it is
+ * a single "incl %gs:offset" instruction).  However, on architectures
+ * like arm64, s390, and loongarch, this_cpu_inc() wraps the underlying
+ * atomic instruction with preempt_disable/enable to prevent migration
+ * between the per-CPU address calculation and the atomic operation.
+ * SRCU does not need this protection because it sums counters across
+ * all CPUs for grace-period detection, so operating on a "stale" CPU's
+ * counter after migration is harmless.
+ *
+ * On arm64, use atomic_long_fetch_add_relaxed() which compiles to the
+ * value-returning ldadd instruction instead of atomic_long_inc()'s
+ * non-value-returning stadd, because ldadd is resolved in L1 cache
+ * whereas stadd may be resolved further out in the memory hierarchy.
+ * https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop
+ */
+static __always_inline void
+srcu_percpu_counter_inc(atomic_long_t __percpu *v)
+{
+#ifdef CONFIG_ARM64
+	(void)atomic_long_fetch_add_relaxed(1, raw_cpu_ptr(v));
+#elif IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE)
+	atomic_long_inc(raw_cpu_ptr(v));
+#else
+	this_cpu_inc(v->counter);
+#endif
+}
+
 static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct srcu_struct *ssp)
 	__acquires_shared(ssp)
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_locks.counter); // Y, and implicit RCU reader.
-	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU reader.
+	srcu_percpu_counter_inc(&scp->srcu_locks); // Y, and implicit RCU reader.
 	barrier(); /* Avoid leaking the critical section. */
 	__acquire_shared(ssp);
 	return scp;
@@ -315,10 +343,7 @@ __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 {
 	__release_shared(ssp);
 	barrier();  /* Avoid leaking the critical section. */
-	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
-	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
+	srcu_percpu_counter_inc(&scp->srcu_unlocks);  // Z, and implicit RCU reader.
 }
 
 /*
@@ -335,10 +360,7 @@ struct srcu_ctr __percpu notrace *__srcu_read_lock_fast_updown(struct srcu_struc
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_locks.counter); // Y, and implicit RCU reader.
-	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU reader.
+	srcu_percpu_counter_inc(&scp->srcu_locks); // Y, and implicit RCU reader.
 	barrier(); /* Avoid leaking the critical section. */
 	__acquire_shared(ssp);
 	return scp;
@@ -359,10 +381,7 @@ __srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __percpu
 {
 	__release_shared(ssp);
 	barrier();  /* Avoid leaking the critical section. */
-	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
-	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
+	srcu_percpu_counter_inc(&scp->srcu_unlocks);  // Z, and implicit RCU reader.
 }
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);

base-commit: 16ad40d1089c5f212d7d87babc2376284f3bf244
-- 
2.52.0

