Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23733123F;
	Thu, 28 May 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949710; cv=none; b=EHTHw3qbD9en8ennNHVOX1U68nMt4qUumwQV9v8uVK4HTxuZfHo/qbS5O5/1o1B/DNnVm+Btc4gra9LjEBwFDWOUeAIeFRNLkrKyvihc6mKKJ/xLv/XDeTK7boFEF43TteDJEw57NgaUREvnFY0BVBUkSXlDmKX2dEjk2pvklZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949710; c=relaxed/simple;
	bh=Cph4dXyUFtaIRhYtuZAcg75IYZZfyBZFccAjo5vxo+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMs1vqKsbS/PR//zBVO5vFvciD63cNfhCTnTOVLtXdVp7RqWuhHcWrNR+6pJvU8hPyDOTFIdVoXaNWXXAnh/uSapWpy4m7zGSEviDLPQJzkb+iX1vde0h9z5OdTVBEn9caLTIhv2VweB9o7oS+X+8/EDw9+z6WFWpWIPmUOm14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=sqi3YDm6; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="sqi3YDm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779949703; x=1780208903;
	bh=6Y43LTgZywEkysAuCinLIc4XYSbGTte742wmYzuT/wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sqi3YDm6csxQUFRInc9oMCvp8UlK+K6NFnw/ijHDj4q6JAc165J5B/y+Eh1qKaAHH
	 VymxJbVPIjGOBhwL7rLn/3ZuB+knsi4srDjAo87yDxr9NULzuwFWg2vPwU1ggF3O1m
	 w3K+afVCT+i98pRlxOtCe5t+G1iUny1Mf0o8BFGY+brsQ35Y4UxPykqPg4inUNCHbx
	 wiO6BZd2bMBC4lA31Gykqt487CDtPq8ji9eKh61QmclrQ1QV6YandIkxTppQ6Jgkhi
	 HCIkRUgAR33oMQLMtZVII6joZo4NvAD39fZmhGMsLy+Vo54xrvGE0V3Si8YD8etemo
	 FivHfAWEA+LWQ==
X-Pm-Submission-Id: 4gQxPt0dY3z2Scq2
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v7 2/4] srcu: expose srcu_readers_active()
Date: Thu, 28 May 2026 09:27:34 +0300
Message-ID: <20260528062810.256212-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260528062810.256212-1-work@onurozkan.dev>
References: <20260528062810.256212-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is needed by rust/helpers/srcu.c which now adds
rust_helper_srcu_readers_active() as a wrapper around the SRCU helper
for Rust callers.

To achive this:

1- Move the srcu_readers_active() implementation from
   "kernel/rcu/srcutree.c" to "include/linux/srcutree.h".

2- Implement a matching srcu_readers_active() in
   "include/linux/srcutiny.h" and use it on the existing open-coded
   WARN_ON() check in cleanup_srcu_struct().

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 include/linux/srcutiny.h | 13 +++++++++++++
 include/linux/srcutree.h | 24 ++++++++++++++++++++++++
 kernel/rcu/srcutiny.c    |  2 +-
 kernel/rcu/srcutree.c    | 25 -------------------------
 rust/helpers/srcu.c      |  5 +++++
 5 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 905b629e8fa3..fbcf13bc12d1 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -154,4 +154,17 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 		 data_race(READ_ONCE(ssp->srcu_idx_max)));
 }
 
+/**
+ * srcu_readers_active - returns true if there are readers. and false otherwise.
+ * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
+ *
+ * Note that this is not an atomic primitive, and can therefore suffer
+ * severe errors when invoked on an active srcu_struct. That said, it
+ * can be useful as an error check at cleanup time.
+ */
+static inline bool srcu_readers_active(struct srcu_struct *ssp)
+{
+	return READ_ONCE(ssp->srcu_lock_nesting[0]) || READ_ONCE(ssp->srcu_lock_nesting[1]);
+}
+
 #endif
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index fd1a9270cb9a..75e54e4f963f 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -374,4 +374,28 @@ static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flav
 		__srcu_check_read_flavor(ssp, read_flavor);
 }
 
+/**
+ * srcu_readers_active - returns true if there are readers. and false otherwise.
+ * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
+ *
+ * Note that this is not an atomic primitive, and can therefore suffer
+ * severe errors when invoked on an active srcu_struct. That said, it
+ * can be useful as an error check at cleanup time.
+ */
+static inline bool srcu_readers_active(struct srcu_struct *ssp)
+{
+	int cpu;
+	unsigned long sum = 0;
+
+	for_each_possible_cpu(cpu) {
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
+
+		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
+		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
+		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
+		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
+	}
+	return sum;
+}
+
 #endif
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index a2e2d516e51b..5dc26af604bf 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -85,7 +85,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
  */
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
-	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
+	WARN_ON(srcu_readers_active(ssp));
 	irq_work_sync(&ssp->srcu_irq_work);
 	flush_work(&ssp->srcu_work);
 	WARN_ON(ssp->srcu_gp_running);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0d01cd8c4b4a..b1e97ba2e53f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -598,31 +598,6 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
 }
 
-/**
- * srcu_readers_active - returns true if there are readers. and false
- *                       otherwise
- * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
- *
- * Note that this is not an atomic primitive, and can therefore suffer
- * severe errors when invoked on an active srcu_struct.  That said, it
- * can be useful as an error check at cleanup time.
- */
-static bool srcu_readers_active(struct srcu_struct *ssp)
-{
-	int cpu;
-	unsigned long sum = 0;
-
-	for_each_possible_cpu(cpu) {
-		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
-
-		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
-		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
-		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
-		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
-	}
-	return sum;
-}
-
 /*
  * We use an adaptive strategy for synchronize_srcu() and especially for
  * synchronize_srcu_expedited().  We spin for a fixed time period
diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
index 225b3bf9334a..1a2f563640e0 100644
--- a/rust/helpers/srcu.c
+++ b/rust/helpers/srcu.c
@@ -9,6 +9,11 @@ __rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
 	return __init_srcu_struct(ssp, name, key);
 }
 
+__rust_helper bool rust_helper_srcu_readers_active(struct srcu_struct *ssp)
+{
+	return srcu_readers_active(ssp);
+}
+
 __rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
 {
 	return srcu_read_lock(ssp);
-- 
2.51.2

