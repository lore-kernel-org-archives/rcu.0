Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C12475CB;
	Sat, 19 Sep 2026 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777745; cv=none; b=n58pdEQmD+MZm8wva10LF1XhwfQJf7qlry/jBw1yzj9fzRD1W6avZmLe7ovTTSpMriLXgBBQXKPAiYGjz7Xh6V/p4j7j22h7zGx7Z3LaQMG5/oWTTB44Tt20iObnq7oyzsMsPmxu35NqbMbc929tAe3vFujqyx09uVTiOX1fTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777745; c=relaxed/simple;
	bh=gOLZQ90+I60sskjiHhMMABQawj2aU10Iy1mmEoSqBVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mL9cAj5y9cstq5FW7X2YNjAHx/q8Z7ixzny5fBY35gyLufoNutbCrwdZKQOw2hZWmrRi9jTjMsqoq7AD5F60MMBEKNG5phzRNrr/ex6fvTQpT6knFg04MlanBIw3fAyHVy2jKD7BdHSuCwiNiVGzJWsiOk7meG8naf0IlDMmVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBvq6i7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBvq6i7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D591B1F008A0;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=2acwy5S0Y6OqMD9j/FW+Yh3HE5CYSItOLVtPngvIFPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBvq6i7gAfO/0ZZq60Al7+Sy8aE1kfWFEMfI3Wokwf2y74WCd/uEyP0O8vt/F48IH
	 60qpRfyVNmgncFi+Rb12hYxuW+8LJBy5i6QkynZScexL2Vd2tOvESHdU7GDJ+XGZzW
	 ao0bwEdlhSywXhvdnh2Y5k/16Pkgqj/9Z5osoV3g7RgyTeSyS0xewemWWTKTRcoNs2
	 lcYEla8pSyGD0mIyerVbJZRyeVFIfITobJAbXqfkq0HHiL2ELQ+BLUdOBo+Ky3mKxe
	 l8rSXOeICGCqkvDT5TN5q1FiQBRDs7JYoA1LSRkhhK4CFGowstdc8wD1D4fmnW4eMC
	 egzEB8hIlIjJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 57CB7CE1855; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Matthias Goergens <matthias.goergens@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 7/9] rcu: Make userspace barrier hook drain kvfree_rcu work
Date: Fri, 18 Sep 2026 17:28:58 -0700
Message-Id: <20260919002900.3134117-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
References: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthias Goergens <matthias.goergens@gmail.com>

The bcachefs ktest allocation-leak check writes rcutree.do_rcu_barrier
before reading /proc/allocinfo. While testing bcachefs performance
changes, small objects released with kfree_rcu() remained visible after
repeated writes to the hook and 20 seconds of waiting, causing otherwise
clean tests to fail their leak check.

The test assumes a stronger contract than the hook currently documents:
rcu_barrier() waits for ordinary callbacks, but does not flush objects
still held in kfree_rcu() batching or per-CPU SLUB sheaves. The retained
population eventually fell as a sheaf filled; there is no evidence here
of unbounded growth or OOM.

Changing the hook to drain kvfree_rcu() work let the same unmodified
bcachefs workload pass its allocation check. All eight checkpoints in
one VM, after 50 through 400 option changes, reported zero retained
reconcile_scan objects. This motivated the separate private-cache test
used to isolate the incomplete drain from bcachefs.

Calling kvfree_rcu_barrier() from rcu_barrier_throttled() was proposed
when kvfree_rcu_barrier() was added in 2024, to restore a clean baseline
between userspace benchmark runs. The discussion concluded that keeping
the existing hook name, adding the second operation and documenting both
was the safest compatibility choice, but the follow-up was not added.

Add that drain and document the stronger test interface. Always retain
the existing start-rate limit and perform the kvfree_rcu() drain: an
unrelated ordinary barrier does not establish that this work completed.

Retain the entry ordinary-barrier sequence snapshot. After draining,
skip the final ordinary barrier only if that snapshot is complete,
preserving the memory barrier on the completion path. Otherwise, invoke
rcu_barrier() explicitly. This keeps the ordinary-callback guarantee
independent of whether kvfree_rcu_barrier() embeds an ordinary barrier.

Clarify that the documented completion guarantee covers work queued
before the request, without preventing new work from being queued.

Earlier validation of the unconditional-drain version used four fresh
VM pairs with a private-cache fixture: controls retained the queued
object (60 to 60 active objects), and treatments drained it (60 to 59).
An ordinary-callback test passed on both kernels. Those runs predated
the guarded skip and do not validate that change. No elapsed-time
improvement is claimed.

Link: https://lore.kernel.org/all/20240820155935.1167988-1-urezki@gmail.com/
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++--
 kernel/rcu/tree.c                             | 30 ++++++++++++-------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..914b65ae9413 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5699,9 +5699,12 @@ Kernel parameters
 			there is an ongoing too-long CSD-lock wait.
 
 	rcutree.do_rcu_barrier=	[KNL]
-			Request a call to rcu_barrier().  This is
-			throttled so that userspace tests can safely
-			hammer on the sysfs variable if they so choose.
+			Wait for deferred kfree_rcu() frees and ordinary
+			call_rcu() callbacks queued before this request to
+			complete.  This does not prevent new work from being
+			queued concurrently.  Requests are throttled so that
+			userspace tests can safely hammer on the sysfs
+			variable if they so choose.
 			If triggered before the RCU grace-period machinery
 			is fully active, this will error out with EAGAIN.
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 338737b9781c..f60252390d5d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3988,12 +3988,12 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
 static unsigned long rcu_barrier_last_throttle;
 
 /**
- * rcu_barrier_throttled - Do rcu_barrier(), but limit to one per second
+ * rcu_barrier_throttled - Drain deferred RCU frees, but rate-limit starts
  *
- * This can be thought of as guard rails around rcu_barrier() that
- * permits unrestricted userspace use, at least assuming the hardware's
- * try_cmpxchg() is robust.  There will be at most one call per second to
- * rcu_barrier() system-wide from use of this function, which means that
+ * This can be thought of as guard rails around the deferred-free barriers
+ * that permit unrestricted userspace use, at least assuming the hardware's
+ * try_cmpxchg() is robust.  There will be at most one drain operation started
+ * per sixteenth of a second from use of this function, which means that
  * callers might needlessly wait a second or three.
  *
  * This is intended for use by test suites to avoid OOM by flushing RCU
@@ -4015,14 +4015,24 @@ static void rcu_barrier_throttled(void)
 	while (time_in_range(j, old, old + HZ / 16) ||
 	       !try_cmpxchg(&rcu_barrier_last_throttle, &old, j)) {
 		schedule_timeout_idle(HZ / 16);
-		if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
-			smp_mb(); /* caller's subsequent code after above check. */
-			return;
-		}
 		j = jiffies;
 		old = READ_ONCE(rcu_barrier_last_throttle);
 	}
-	rcu_barrier();
+	/*
+	 * kfree_rcu() can retain objects outside the ordinary callback lists in
+	 * per-CPU SLUB sheaves and kvfree_rcu batches.  Always drain those queues:
+	 * an ordinary barrier does not establish that this work was drained.
+	 */
+	kvfree_rcu_barrier();
+	/*
+	 * A completed barrier can still cover ordinary callbacks queued before
+	 * our entry snapshot.  Otherwise, retain an explicit ordinary barrier
+	 * without depending on the implementation of kvfree_rcu_barrier().
+	 */
+	if (rcu_seq_done(&rcu_state.barrier_sequence, s))
+		smp_mb(); /* caller's subsequent code after above check. */
+	else
+		rcu_barrier();
 }
 
 /*
-- 
2.40.1

