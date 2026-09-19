Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0832FC876;
	Sat, 19 Sep 2026 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778133; cv=none; b=BjXjq3Ee24eBp3lZLWzXkl2BIPcsmaJ7mfXQ8UVLxbbO1hgkRm80nAQsgMKqG/nN3IgMcezP0FGNNmIBn7XpLwAC/P49y104oXyuxUEMI4eqfN1OFEDE6jp85a058HZikGG3vIP+V3+GAxiQs7jXleAtJY4OZnMwPL+ZEkV0FBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778133; c=relaxed/simple;
	bh=eLTMvWpJ+IE+fM1bG2IsU538AWbkMyJbbVaCRTfw2yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLe/5Acn5wFrkmZxaBklevAVCqyXIKK5RHyfsvM/yhRXgCQCs339+DVkF9oeUXLEZXXYVYu7jLHSxyl6GqabrdcXpR5/C2IPFjWW2SPQubX5jsE+/VCdMS+4D/kEyVknMJMnz99S0Hqet7RFtDwz6JqTIfIWENjSxTtBN4/kg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTYaEITm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTYaEITm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C2F1F00899;
	Sat, 19 Sep 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778122;
	bh=3WKLSW7owY/hXStlzUINu+/mrjIEAzUbywdkGSblpCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTYaEITmq6DWJy5kuHnBN+tpmlOSXqAu8yMUDr/TApynayrwGqZp2qqTpJPbMN8/+
	 dPifpuWhvJgBebopaG1t/VuzVvFtjrjJEB3CGQltNKwvf94BMm/rOtyyPLS/K3IANs
	 9FK17owneX+P/3ypSx4WTxZbq7JR8WaM4/A89FHwN6Gu0DT8olkYcz8qg1+uMN7cAC
	 GcV14AibUyzRMkaf5t4L8kFm15NaqPJA4cthtYBvX3kdeOnVtnRpaWErHDY9qS5rhT
	 Ys8hnEDq6ZGkfUDUpvYvhS2BXgborb8Gg0nnhDvEFMizJNCZATiIR1ZPBOfPGyTbBZ
	 XwNhkthHiNFXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9836DCE17BD; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 03/19] srcutree: Suppress to-big transition for atomic SRCU
Date: Fri, 18 Sep 2026 17:35:05 -0700
Message-Id: <20260919003521.3134552-3-paulmck@kernel.org>
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

Initially (and perhaps forever), call_srcu() will not be available for
atomic srcu_struct structures.  There is therefore no reason to transition
such a structure to big, because the main purpose of such a transition
is to reduce lock contention for concurrent SRCU callback queueing.

This commit therefore adds an is_atomic parameter to both the
check_init_srcu_struct() and init_srcu_struct_fields() functions, which
suppresses the initialization-time transition to big that is enabled by
default on large systems.

It will still be possible to force a transition using rcutorture as a
destructive test.  This might (or might not) be adjusted later.

[ paulmck: Apply feedback from Kunwu Chan. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index dc063eb49b0d..c611a7168c70 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -238,8 +238,10 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
  * Initialize non-compile-time initialized fields, including the
  * associated srcu_node and srcu_data structures.  The is_static parameter
  * tells us that ->sda has already been wired up to srcu_data.
+ * The is_atomic parameter tells us that there is no reason to
+ * ever transition to big.
  */
-static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
+static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static, bool is_atomic)
 {
 	if (!is_static)
 		ssp->srcu_sup = kzalloc_obj(*ssp->srcu_sup);
@@ -267,7 +269,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	init_srcu_struct_data(ssp);
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
-	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
+	if (!is_atomic &&
+	    READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!preemptible())
 			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_ALLOC);
 		else if (init_srcu_struct_nodes(ssp, GFP_KERNEL))
@@ -301,7 +304,7 @@ __init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock
 	/* Don't re-initialize a lock while it is held. */
 	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
 	lockdep_init_map(&ssp->dep_map, name, key, 0);
-	return init_srcu_struct_fields(ssp, false);
+	return init_srcu_struct_fields(ssp, false, false);
 }
 
 int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
@@ -343,7 +346,7 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
 int init_srcu_struct_generic(struct srcu_struct *ssp)
 {
 	ssp->srcu_reader_flavor = 0;
-	return init_srcu_struct_fields(ssp, false);
+	return init_srcu_struct_fields(ssp, false, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_generic);
 
@@ -360,7 +363,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_generic);
 int init_srcu_struct_fast(struct srcu_struct *ssp)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
-	return init_srcu_struct_fields(ssp, false);
+	return init_srcu_struct_fields(ssp, false, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_fast);
 
@@ -378,7 +381,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_fast);
 int init_srcu_struct_fast_updown(struct srcu_struct *ssp)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST_UPDOWN;
-	return init_srcu_struct_fields(ssp, false);
+	return init_srcu_struct_fields(ssp, false, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_fast_updown);
 
@@ -470,9 +473,11 @@ static void raw_spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsign
  * done with compile-time initialization, so this check is added
  * to each update-side SRCU primitive.  Use ssp->lock, which -is-
  * compile-time initialized, to resolve races involving multiple
- * CPUs trying to garner first-use privileges.
+ * CPUs trying to garner first-use privileges.  The is_atomic
+ * parameter tells us that there will never be a reason to
+ * transition to big.
  */
-static void check_init_srcu_struct(struct srcu_struct *ssp)
+static void check_init_srcu_struct(struct srcu_struct *ssp, bool is_atomic)
 {
 	unsigned long flags;
 
@@ -484,7 +489,7 @@ static void check_init_srcu_struct(struct srcu_struct *ssp)
 		raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 		return;
 	}
-	init_srcu_struct_fields(ssp, true);
+	init_srcu_struct_fields(ssp, true, is_atomic);
 	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
@@ -1279,7 +1284,7 @@ static bool srcu_should_expedite(struct srcu_struct *ssp)
 	unsigned long t;
 	unsigned long tlast;
 
-	check_init_srcu_struct(ssp);
+	check_init_srcu_struct(ssp, false);
 	/* If _lite() readers, don't do unsolicited expediting. */
 	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_SLOWGP)
 		return false;
@@ -1338,7 +1343,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	struct srcu_node *sdp_mynode;
 	int ss_state;
 
-	check_init_srcu_struct(ssp);
+	check_init_srcu_struct(ssp, false);
 	/*
 	 * While starting a new grace period, make sure we are in an
 	 * SRCU read-side critical section so that the grace-period
@@ -1617,7 +1622,7 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return;
 	might_sleep();
-	check_init_srcu_struct(ssp);
+	check_init_srcu_struct(ssp, false);
 	init_completion(&rcu.completion);
 	init_rcu_head_on_stack(&rcu.head);
 	__call_srcu(ssp, &rcu.head, wakeme_after_rcu, do_norm);
@@ -1827,7 +1832,7 @@ void srcu_barrier(struct srcu_struct *ssp)
 	int idx;
 	unsigned long s;
 
-	check_init_srcu_struct(ssp);
+	check_init_srcu_struct(ssp, false);
 
 	/*
 	 * Register any deferred callbacks before snapshotting the sequence.  The
-- 
2.40.1

