Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76E2848BE;
	Sat, 19 Sep 2026 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778131; cv=none; b=OElCX+IFRrAUGpDS0nnbTivv06VK/DlGGnXF3DHxRgw0TkqyLntH4DIGp6BDl7nr7nscr8WZPP06/NsShuT7Nv6Aka27LzAM0OS6LjzwE/pH28mK7yVj7TCoTOp6zPZncIQNeoFcbv05ojfp/3tPuE9/XAKqU8lpvAqxICoUhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778131; c=relaxed/simple;
	bh=6gEqzQhpOPhOLSXIF8m7r7HaxBUDINbKhBo/BKtmBdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9EsEiQ+2gYnYbta9X19Hl8fG6CyH75Tw8maCw1YMsxy/u/OEA+S+ztkW3J+99gByOJ/S2yt95NOpsSQSzAJHRnspkc5t5wKIifkwb8YA7h3gJA8EhxCJpToSR9NiA7rnCC7iQ2qU+roCotZxEEF631fyeDZGZypTwhMyWt75Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8683jwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8683jwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9541F0089E;
	Sat, 19 Sep 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=Ze6k73lncP6LYkq3ZndiSWsaU73cxqiRJr9WE0HIlJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S8683jwiVx3DW4eFBBjC9PSE2bOi4bRGWcgWt9N+7fdSV4/+JQbpE0oV4pPkWOxdj
	 8jzJZ8UmcoJyiJDz74xuND2fcIKk8Ye194w0a/ssQJ9QvXUsygyL1NAbkFlYg287pO
	 HJj+iZtSvX7ztMOURM4oQ4VuIW52wHPsQIBdqKGzkjXSUEDj5BFnedl5ArqYde0QpD
	 PRFm1Zm1sm9uq8WnKAXTWRfu74El89l4dSOJA2uo5JPJcbexZWwpn6GMPHl6nZW/HY
	 JUYGm3ffNI1pAQU5wbn7HRWKOOxGWgeKLOWd8KWSx/jZfgkHE+IRKP4J+oO8Hohuon
	 FOS2exaYilnTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9DEF6CE1853; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 05/19] srcutiny: Add an atomic Tiny SRCU
Date: Fri, 18 Sep 2026 17:35:07 -0700
Message-Id: <20260919003521.3134552-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the Tiny SRCU counterpart to Tree SRCU's
synchronize_srcu_atomic().  One might hope that this could be as trivial
as Tiny RCU's synchronize_rcu(), and there was a time when it would
have been.  But lazy preemption really can preempt an SRCU read-side
critical section, which means that synchronize_srcu_atomic() really must
be prepared to spin waiting for it.

This spinning currently consists of cond_resched_tasks_rcu_qs()
and cpu_relax().  It would be better to have some way of telling the
scheduler that there is nothing useful for us to do.  We cannot use
the traditional wait_event() approach because synchronize_srcu_atomic()
is not permitted to block.

[ paulmck: Apply Kunwu Chan feedback. ]

Co-developed-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Assisted-by: Claude:claude-mythos-5
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h |  6 +++
 kernel/rcu/srcutiny.c    | 79 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 85b5de438450..47a368f945e3 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -19,6 +19,7 @@ struct srcu_struct {
 	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
 	u8 srcu_gp_running;		/* GP workqueue running? */
 	u8 srcu_gp_waiting;		/* GP waiting for readers? */
+	u8 srcu_atomic_gp_flag;		/* Serialize atomic GP work.*/
 	unsigned long srcu_idx;		/* Current reader array element in bit 0x2. */
 	unsigned long srcu_idx_max;	/* Furthest future srcu_idx request. */
 	struct swait_queue_head srcu_wq;
@@ -64,15 +65,20 @@ void srcu_defer_drain(struct irq_work *irq_work);
 #define DEFINE_SRCU_FAST_UPDOWN(name) DEFINE_SRCU(name)
 #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
 	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+#define DEFINE_SRCU_ATOMIC(name) DEFINE_SRCU(name)
+#define DEFINE_STATIC_SRCU_ATOMIC(name) \
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
 
 // Dummy structure for srcu_notifier_head.
 struct srcu_usage { };
 #define __SRCU_USAGE_INIT(name) { }
 #define __init_srcu_struct_fast __init_srcu_struct
 #define __init_srcu_struct_fast_updown __init_srcu_struct
+#define __init_srcu_struct_atomic __init_srcu_struct
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 #define init_srcu_struct_fast init_srcu_struct
 #define init_srcu_struct_fast_updown init_srcu_struct
+#define init_srcu_struct_atomic init_srcu_struct
 #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
 
 void synchronize_srcu(struct srcu_struct *ssp);
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 32b37d63d58a..c6a2b74ae9d6 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -41,6 +41,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 	ssp->srcu_cb_tail = &ssp->srcu_cb_head;
 	ssp->srcu_gp_running = false;
 	ssp->srcu_gp_waiting = false;
+	ssp->srcu_atomic_gp_flag = 0;
 	ssp->srcu_idx = 0;
 	ssp->srcu_idx_max = 0;
 	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
@@ -339,6 +340,79 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/*
+ * synchronize_srcu_atomic - spinning grace period for atomic-reader domains
+ * @ssp: srcu_struct with which to synchronize.
+ *
+ * On !SMP this cannot spin: a reader observed mid-section is preempted
+ * or interrupted-out, and can only finish if we yield the CPU. But it
+ * is also never needed: an atomic-flavor reader (preemption disabled)
+ * cannot be observed mid-section from process context on the sole CPU.
+ * So a reader observed here has broken the atomic-domain promise, and
+ * the only correct wait for it is a real grace period.
+ *
+ * (Actual kernel-doc header is in Tree SRCU.)
+ */
+void synchronize_srcu_atomic(struct srcu_struct *ssp)
+{
+	int idx;
+	bool ret;
+	unsigned long srcu_state = get_state_synchronize_srcu(ssp);
+
+	srcu_lock_sync(&ssp->dep_map);
+
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
+				   // And in Tiny RCU, it is near zero cost and doesn't block.
+
+	// Usually, there will be no readers.
+	preempt_disable();  // Guard against lazy preemption and some other grace period.
+	ret = !READ_ONCE(ssp->srcu_lock_nesting[0]) && !READ_ONCE(ssp->srcu_lock_nesting[1]);
+	if (ret) {
+		WRITE_ONCE(ssp->srcu_idx_max, ssp->srcu_idx + 2);
+		WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 2);
+		preempt_enable();
+		return;
+	}
+
+	// Wait to drive a grace period or for someone else to do it
+	// for us while we are lazily preempted.
+	while (ssp->srcu_atomic_gp_flag) {
+		if (poll_state_synchronize_srcu(ssp, srcu_state)) {
+			preempt_enable();
+			return;
+		}
+		preempt_enable();
+		cpu_relax();
+		cond_resched_tasks_rcu_qs();
+		preempt_disable();
+	}
+	ssp->srcu_atomic_gp_flag = 1;
+	preempt_enable();
+
+	// We get here if a reader has been lazily preempted.
+	// First, wait for old readers, which are quite unlikely.
+	WRITE_ONCE(ssp->srcu_idx_max, get_state_synchronize_srcu(ssp));
+	idx = !(((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1);
+	while (READ_ONCE(ssp->srcu_lock_nesting[idx])) {
+		cond_resched_tasks_rcu_qs();
+		cpu_relax();
+	}
+
+	// Next, flip the index and wait for the other group of readers.
+	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
+	idx = !idx;
+	while (READ_ONCE(ssp->srcu_lock_nesting[idx])) {
+		cond_resched_tasks_rcu_qs();
+		cpu_relax();
+	}
+
+	// Finally, flip the index again for poll_state_synchronize_srcu().
+	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
+	WARN_ON_ONCE(!poll_state_synchronize_srcu(ssp, srcu_state));
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
+
 /* Register any deferred callbacks, then wait for all in-flight ones. */
 void srcu_barrier(struct srcu_struct *ssp)
 {
@@ -367,6 +441,11 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
  * The difference between this and get_state_synchronize_srcu() is that
  * this function ensures that the poll_state_synchronize_srcu() will
  * eventually return the value true.
+ *
+ * This function cannot be used with atomic SRCU, which only has
+ * atomic grace periods.  Doing so will silently corrupt internal
+ * SRCU state.  Tree SRCU has appropriate checking with splats,
+ * so please test with CONFIG_SMP=y as well as CONFIG_SMP=n.
  */
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
-- 
2.40.1

