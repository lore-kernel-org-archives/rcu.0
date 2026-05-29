Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F83DC85B
	for <rcu@vger.kernel.org>; Fri, 29 May 2026 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055112; cv=none; b=OVqe2UmrqeCLGbLPhfEQKkbb5GvnSxKR8CpdKP46fzNxiSPaIbJ3cFYkE7yILbOJegjBuxW+NXQQUpHG0iYvLx0biOdDKm4SRT69rB+kyy/EiSL+1SFdk6/UY6HobHYjE4gHX8A832ZIOVpKScZlHY2Xu7UDMLLrqJfoEZYncLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055112; c=relaxed/simple;
	bh=Gf4nwf51LU3Y41oMuMGwxT9VF2DEQE9hIiYQyC6AcbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TN4Sld2FcpMUr61ZfXJoJl/ck2tspagBKvDV13m5rECPAUvUUCaCrbrgMFLegDnE0E4ZeNcXR+v9AHvHy0KwPDpUwJbTN3VouENJ6ItR34LLn1weM8QiR3Bk2fLOKoPapEZa6IQQaBngXjGJLVJe5sxlYgKE812NC2SITPf3pH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=bg432rWA; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="bg432rWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780055101; x=1780314301;
	bh=kAf7Lbzg2leq75Z5omF805aT0mQKkkvBR2f7Gn/YlLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bg432rWATzvmRtOvqeqZx9RZcfDkKK/eC8VG+Ekrsfw7Q/Qq5LsJrfXRzvHL5hR2V
	 VmEum+hnZrNrOIGOWn4LvHu+5x2BlYO0vymrIzgVTWTTdrJu8+pWf0geNCGzsB/Eki
	 1ZlJ1HSlFBGl+byjAYBTM9Z/ZP/DRVBJyBFb8DaBO/u5AqC3wxxd5XsV9Sesn+7cG5
	 oBRF10N92KkPcJmK7pb/8KDxZy6Ypc73r5ZJED1jf8XrCmA+gFHswDLGCiCBNEM/DY
	 So9ZAncWmDfhjxksa0YrVCG4LEr2lWa/xrV9k1xD88O3iRWdZlt+doLVSxea+c3780
	 LAYCLAZYfPJKA==
X-Pm-Submission-Id: 4gRhNp62MCz1DF70
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
Subject: [PATCH v8 2/4] srcu: expose srcu_readers_active()
Date: Fri, 29 May 2026 14:43:51 +0300
Message-ID: <20260529114449.112066-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260529114449.112066-1-work@onurozkan.dev>
References: <20260529114449.112066-1-work@onurozkan.dev>
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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

