Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C31FF1B5;
	Thu, 16 Jul 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161094; cv=none; b=fQQjTmKnYUqUvDUlanA6eJeQ18YjPJ4xVSom8T06aLX0xBySLTo7kWF9tGEhDzgjp+SK5OnLoyy8Hmqj7FlmChaxS25EdmL+McVjdP03eOP4lp2s0Q9pHjZAtfzBUoBXT5jBD6ld2JXRCExAbm7tOCzpOd+5+fQVTMUPpJpcl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161094; c=relaxed/simple;
	bh=Q6bgJqNPOT9m4p4ZMYGtiBC53GoA2H3n/hREj9jILi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXzsPFev3vlzBR3iXMEjReOpcvIsi97Any4fARIO9xH3V9oGx13fqQ3oIlu9PnPYXm7wCZOJsUSGJRMYSh0O/cwXyvQpf57CCEGQlqhXBo5XuCywbBFQBitwAsOAsd9FAGiQUIf+Nv6sAoWetNolzIgMbaEzYJqVsJZFKPVkmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbB3zntv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbB3zntv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A366C1F0155C;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=urMuuqdtRK9CjaXQHSEO2Bp6QaroTLrsoc3/R9EDtnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PbB3zntvn2YYAJaA0jtXQ5+5gnbf712eJZaiAkzTKCGl/ynwiveALMT9musImqaZO
	 RSLh9r8pn9EijXM0iJJ/AJyXYqxgeJjM1umVmVqX7bWIIntMpt0hVOWLZ/keW/WVmJ
	 HBBIpr7IWJ1f6sEMrrlDenKpwKInm5uwy9qwAvelL9nd7MVeN9mNafyUkpL05YYQ1I
	 JIq5f2L3cfnSOvx6C+Ip8HOd6Pz2KidhW43+ZuGeVQtukvYcwitJX4C7odeSCRpRn2
	 0pxi1J4CclppkLAP6sakmNxd9kFb8GVGtamCb2c1JH6x4FHOI26VvWQwe7garjl7cL
	 Iwf0eN+Lk5oAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E395CE0E8B; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 11/24] hazptrtorture: Defer release of hazard pointers
Date: Wed, 15 Jul 2026 17:17:56 -0700
Message-Id: <20260716001809.11084-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit creates the defer_modulus module parameter, so that the
releases of one out of defer_modulus hazard-pointer acquisitions will
be deferred.  This parameter defaults to -1, which results in a value
of 1000*nr_cpu_ids to be used.

This parameter must be zero for hazptr_torture runs that set
cur_ops->onstack_ctx, because otherwise we would get on-stack data races.
It must also be zero when the kthread_do_pending_ms module parameter
is zero.  Setting the defer_modulus module parameter to a value less
than -1 will result in disabling hazard-pointer deferral.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 87 +++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index de2b4e45d9599a..8b1315e2d1d1a6 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -30,6 +30,7 @@ MODULE_DESCRIPTION("Hazard-pointer module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmckrcu@meta.com>");
 
+torture_param(int, defer_modulus, -1, "Defer once per specified # of hazptr ops, zero to disable");
 torture_param(int, kthread_do_pending_ms, -1,
 	      "Delay between cleanups for deferred hazard pointers (ms), zero to disable");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
@@ -187,7 +188,7 @@ hazptr_torture_pipe_update(struct hazptr_torture *old_rp)
 struct hazptr_torture_ops {
 	void (*init)(void);
 	void (*cleanup)(void);
-	struct hazptr_torture *((*readlock)(struct hazptr_ctx **hcpp));
+	struct hazptr_torture *((*readlock)(struct hazptr_ctx *hcpp));
 	void (*read_delay)(struct torture_random_state *rrsp);
 	void (*readunlock)(struct hazptr_ctx *hcp, struct hazptr_torture *htp);
 	void (*sync)(void *htp);
@@ -203,14 +204,12 @@ static struct hazptr_torture_ops *cur_ops;
  * structures.
  */
 
-static struct hazptr_torture *hazptr_torture_read_lock(struct hazptr_ctx **hcpp)
+static struct hazptr_torture *hazptr_torture_read_lock(struct hazptr_ctx *hcpp)
 {
-	struct hazptr_ctx *hcp = kmalloc(sizeof(*hcp), GFP_KERNEL);
+	struct hazptr_torture *htp;
 
-	*hcpp = hcp;
-	if (!hcp)
-		return NULL;
-	return (struct hazptr_torture *)hazptr_acquire(hcp, (void *)&hazptr_torture_current);
+	htp = (struct hazptr_torture *)hazptr_acquire(hcpp, (void *)&hazptr_torture_current);
+	return htp;
 }
 
 static void hazptr_read_delay(struct torture_random_state *rrsp)
@@ -241,8 +240,6 @@ static void hazptr_torture_read_unlock(struct hazptr_ctx *hcp, struct hazptr_tor
 {
 	if (hcp) {
 		hazptr_release(hcp, htp);
-		if (cur_ops->onstack_ctx)
-			kfree(hcp);
 	}
 }
 
@@ -266,17 +263,9 @@ static struct hazptr_torture_ops hazptr_ops = {
  * hazptr_ctx structures.
  */
 
-static struct hazptr_torture *hazptr_torture_read_lock_stack(struct hazptr_ctx **hcpp)
-{
-	struct hazptr_torture *htp;
-
-	htp = (struct hazptr_torture *)hazptr_acquire(*hcpp, (void *)&hazptr_torture_current);
-	return htp;
-}
-
 static struct hazptr_torture_ops hazptr_stack_ops = {
 	.init			= hazptr_sync_torture_init,
-	.readlock		= hazptr_torture_read_lock_stack,
+	.readlock		= hazptr_torture_read_lock,
 	.read_delay		= hazptr_read_delay,
 	.readunlock		= hazptr_torture_read_unlock,
 	.sync			= hazptr_synchronize,
@@ -387,6 +376,20 @@ static void hazptr_torture_reader_tail(struct hazptr_ctx *hcp, struct hazptr_tor
 	cur_ops->readunlock(hcp, htp);
 }
 
+/*
+ * Defer the specified hazard pointer to some other context.
+ */
+static void hazptr_torture_defer(struct hazptr_pending *hppp, struct torture_random_state *trsp)
+{
+	int cpu = torture_random(trsp) % nr_cpu_ids;
+	struct llist_head *llhp;
+
+	guard(preempt)();
+	cpu = cpumask_next_wrap(cpu, cpu_online_mask);
+	llhp = per_cpu_ptr(&hazptr_pending, cpu);
+	llist_add(&hppp->hpp_node, llhp);
+}
+
 /*
  * Hazard-pointer torture reader kthread.  Repeatedly dereferences
  * hazptr_torture_current, incrementing the corresponding element of the
@@ -395,9 +398,9 @@ static void hazptr_torture_reader_tail(struct hazptr_ctx *hcp, struct hazptr_tor
  */
 static int hazptr_torture_reader(void *arg)
 {
-	struct hazptr_ctx hc;
-	struct hazptr_ctx *hcp = &hc;
-	struct hazptr_torture *htp;
+	bool can_defer = !cur_ops->onstack_ctx && kthread_do_pending_ms && defer_modulus;
+	struct hazptr_pending hpp;
+	struct hazptr_pending *hppp = cur_ops->onstack_ctx ? &hpp : NULL;
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
 	int mynumonline = myid % nr_cpu_ids;
@@ -406,10 +409,17 @@ static int hazptr_torture_reader(void *arg)
 	VERBOSE_TOROUT_STRING("hazptr_torture_reader task started");
 	set_user_nice(current, MAX_NICE);
 	do {
-		htp = cur_ops->readlock(&hcp);
-		if (!htp) {
-			// Still starting up or allocation failure,
-			// so get out of the way.
+		if (!hppp) {
+			hppp = kmalloc_obj(*hppp, GFP_KERNEL);
+			if (!hppp) {
+				// Allocation failure, so get out of the way.
+				schedule_timeout_interruptible(HZ / 10);
+				continue;
+			}
+		}
+		hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+		if (!hppp->hpp_htp) {
+			// Still starting up, so get out of the way.
 			schedule_timeout_interruptible(HZ / 10);
 			continue;
 		}
@@ -417,7 +427,12 @@ static int hazptr_torture_reader(void *arg)
 			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
-		hazptr_torture_reader_tail(hcp, htp, &rand);
+		if (can_defer && !(torture_random(&rand) % defer_modulus)) {
+			hazptr_torture_defer(hppp, &rand);
+			hppp = NULL;
+		} else {
+			hazptr_torture_reader_tail(&hppp->hpp_hc, hppp->hpp_htp, &rand);
+		}
 		while (!torture_must_stop() &&
 		       (torture_num_online_cpus() < mynumonline || !rcu_inkernel_boot_has_ended()))
 			schedule_timeout_interruptible(HZ / 5);
@@ -478,7 +493,10 @@ static int hazptr_torture_do_pending(void *arg)
 static int hazptr_torture_do_pending_init(void)
 {
 	if (kthread_do_pending_ms == -1)
-		kthread_do_pending_ms = cur_ops->onstack_ctx ? 0 : 3;
+		kthread_do_pending_ms = (cur_ops->onstack_ctx || defer_modulus == 0) ? 0 : 3;
+	if (defer_modulus == -1)
+		defer_modulus = (cur_ops->onstack_ctx ||
+				 kthread_do_pending_ms == 0) ? 0 : 1000 * nr_cpu_ids;
 	if (kthread_do_pending_ms < 0) {
 		pr_alert("Cannot have negative kthread_do_pending_ms, disabling deferral.\n");
 		goto err_out;
@@ -487,6 +505,16 @@ static int hazptr_torture_do_pending_init(void)
 		pr_alert("Cannot defer onstack hazptr_ctx, disabling deferral.\n");
 		goto err_out;
 	}
+	if (defer_modulus < 0) {
+		pr_alert("Cannot have negative defer_modulus (%d), disabling deferral.\n",
+			 defer_modulus);
+		goto err_out;
+	}
+	if (!kthread_do_pending_ms != !defer_modulus) {
+		pr_alert("Pending kthread (%d) & deferral (%d) don't match, disabling deferral.\n",
+			 kthread_do_pending_ms, defer_modulus);
+		goto err_out;
+	}
 	if (!kthread_do_pending_ms)
 		return 0;
 	return torture_create_kthread(hazptr_torture_do_pending, NULL, do_pending_task);
@@ -494,6 +522,7 @@ static int hazptr_torture_do_pending_init(void)
 err_out:
 	WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST));
 	kthread_do_pending_ms = 0;
+	defer_modulus = 0;
 	return 0;
 }
 
@@ -606,14 +635,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 {
 	pr_alert("%s" TORTURE_FLAG
 		 "--- %s: nreaders=%d "
-		 "kthread_do_pending_ms=%d "
+		 "defer_modulus=%d kthread_do_pending_ms=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
 		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders,
-		 kthread_do_pending_ms,
+		 defer_modulus, kthread_do_pending_ms,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
 		 reader_sleep_us,
-- 
2.40.1

