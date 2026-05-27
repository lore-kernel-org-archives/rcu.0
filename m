Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FB221FC6;
	Wed, 27 May 2026 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914201; cv=none; b=hn4QJZOKKfKjdm6hV6a3D3f/l3q9IKzJV++1d/O59EP/MRfoO7zAPTpGhrcSGqDZk6eH69zwJ+NMMM5AAyV81pLAe2rbDqdt+35CC25SfNmEGihD+DHcUYNcVNcxoiGkYhc1q/MXpTNLXwsQzfZPWTmRo5neJ7vyrkCtKGooijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914201; c=relaxed/simple;
	bh=NqISEuG7fSrpvwe1cICHu5CYb5KtHWNYetOv4E75LnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/VTulM7gUmcdYxt0WVVxBLP4+PlQxO6Q0G4gEVmu3/uCoJVTB4uobpXms5XnXUBvjQpefUyod41ksIZYuvNEke1O0QD1JQCZXap4iWvCNbQJiTssg640JCdb8P+4mGQOOKXtAAf+pR91viqaKiZ7YlaPJbEsvM9Bj5XNCvlzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Qyz7gfKu; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Qyz7gfKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779914188; x=1780173388;
	bh=zXhpkly613yJT7sasmz6SpiRYeCLX/29ZfGzncBVYys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Qyz7gfKuBnToCo//o8QO3+W6bfgOVrpyFLCsD7MLw8UUZ1xbM0q3ZdWUVp6SE8oT/
	 u5v5PDPDuz2iu5PtdiIU7nX/ICNaABzsQkxD8lqKY6ZitKkSntXyqgBU3d2wy9k0SY
	 IY5d4BvyLnnQxRmRcHM3Od5Uq8YFh76SWt1O1q2psgFaY2KVZ/ADSVmiR8WYZQO80O
	 di70iBjju0uiPnBxXY9Q2n+9yOdWmsMmJi3SIJi2wbh5asdL95AuPu2pb7HEp0dwxm
	 th2ZnClMOakw6p4sgwRhBe1QAszvOvVIB2w7iwLnn3dJQfhRV+JnyIxayjSO/nf5dq
	 rWxdj1MUgPs2A==
X-Pm-Submission-Id: 4gQhGw13K4z2Scq5
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
Subject: [PATCH v6 2/4] srcu: expose srcu_readers_active()
Date: Wed, 27 May 2026 23:35:33 +0300
Message-ID: <20260527203615.163688-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260527203615.163688-1-work@onurozkan.dev>
References: <20260527203615.163688-1-work@onurozkan.dev>
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
index 79dd24a104ef..fa4b5879dda5 100644
--- a/rust/helpers/srcu.c
+++ b/rust/helpers/srcu.c
@@ -13,6 +13,11 @@ __rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
 #endif /* CONFIG_DEBUG_LOCK_ALLOC */
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

