Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA83AAF43;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406767; cv=none; b=gi12gwfW25v6ZmWro/gVi156D8UlR0M6mak9Eh4MP9BpRGArwA3cwpKrmF1i41FLgd0nMtb/Jls0MjMJE/kY8HOqjYdPhPjbsib+FzFcU6YRJXnSZ4LH5/h7Mlj5gIkzG0WCllLFFt5yogls+YJfunD48DWGITX8cA/7KBwEJ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406767; c=relaxed/simple;
	bh=yAyGexfoOxATpQ4FzYCn2SPjFLup3MKE9xnk2RRptoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxmEsfoBMDHTh6x+nixMRHORLvmTJJ/Kr3WTuzfwxUd+4xFHdJq6onVUfFXBlC8xQn2kwEongRJ8Zcurl1IYlSlnYUnoDLQgmgNP4WsUpYovDq0CwCSwFFeSoCa3MDb5QOdB91O4NXR7X+3RletPQ6oubkIPeGP8yi8sl4OYoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdfEHTAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdfEHTAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792561F0089D;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=E/iTkSni7ho8TtVQKz6QPR7DNGXIpz7xnBizUY6Aw40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SdfEHTASFdUhI36YUH+QTyjYttmbJ3RDssrnIf+j9N7lgKXexVVjV1ZbkS9YAM+LB
	 mdYflVuOx8OLBxI4487YRV3u5M/4+SUkNABdEdXCq4ns5G2mnbcnI5nGymFePl5sbT
	 7CoTG/DVd9I+FYLyUmjohgPQk1LXvQEaUCNkFqW5198uyQWnUicZ0Lf+4MXzHBGH5q
	 VMhG+Cp0qkeXIjA1BmfnHfivmhREXU/UI1R+Hu4F2xcIaosnRStgf2tK1w1HhPCj+v
	 LwQuXai2fxRnGuFwy79QMGeTtw3P0fyKGKPe5XM0q+Y4EPn9OAcLpgfR3xJ0auVQ6K
	 J3csMmo/pUXSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1C417CE26CA; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 05/21] srcutiny: Add an atomic Tiny SRCU
Date: Wed,  7 Oct 2026 13:59:08 -0700
Message-Id: <20261007205924.1983367-5-paulmck@kernel.org>
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

[ paulmck: Apply Kunwu Chan and Joel Fernandes feedback. ]

Co-developed-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Assisted-by: Claude:claude-mythos-5
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h |  6 +++
 kernel/rcu/srcutiny.c    | 80 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 85b5de438450b..47a368f945e34 100644
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
index 32b37d63d58aa..08e089e3e969e 100644
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
@@ -339,6 +340,80 @@ void synchronize_srcu(struct srcu_struct *ssp)
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
+	ssp->srcu_atomic_gp_flag = 1;  // Acquire SRCU grace-period "lock".
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
+	ssp->srcu_atomic_gp_flag = 0; // Release SRCU grace-period "lock".
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
+
 /* Register any deferred callbacks, then wait for all in-flight ones. */
 void srcu_barrier(struct srcu_struct *ssp)
 {
@@ -367,6 +442,11 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
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

