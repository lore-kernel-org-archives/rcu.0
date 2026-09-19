Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9032F60CC;
	Sat, 19 Sep 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776065; cv=none; b=kGVysOInBZ0rq0lnV8AvGUMT0Gx4EXfv9qxDU4iaeTntjimE+xkcWQgSFgiCcBJqKG6p+IQM+q7VfwDgzZJRFD6poi2tuKbSnz+Y6e49Lo2T1hMLWmMPVFb5C+77m3Wu/900GZUV1B6fP8kVLzA441Zl9fAxWeyJaUMePcKVDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776065; c=relaxed/simple;
	bh=61CsDYD42Hn4RmaJTwo/FFWzeZtval50mJNbZdB8ALk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=asJ9qyVS3S1NztD1yWEdhFTF36vHRHYf+ZlBQtk23z9trVCp3MCAT711aW/y8oQe1fJL0ELCl25rIstcZ+11vxTC6Toootp/eialZNfj+ecsNRPY1y63mllsOhzWRAWkzoiLGiWVWnVLYK9Hlbz84BogoplVE2je1xzNu2sbHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGqaNz6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGqaNz6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F11F008A5;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=FLPv1yzHxy7boTo89t3qhl8/USKRoVHawqm+eZOunzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGqaNz6MoBWMEuys74XnWgZB904OztciyGf1HN0WPEIULbEifMRpvkT4VfhRkiHIS
	 7n+/3s2nFHmpOqi8UpW9jOBIdfdfsEgXLpNTjz8+JKyNs0/5VrptFgay13uf+0yop0
	 MbbIeP9EqMO0h88JafC8M3xeyNKEVUFCHb0fGrz7lETMpIO3AvBPRRATW9EqhL6Glm
	 lfVn/OAMMkP7uCYgZiArXHeEx3jb+nHBOyNtgRA5+LQz/7c4bsG5I1p+Z3A62Y03xY
	 8rkWexKJH/QxNFqeEgFIp24RhZvX2U2ODbLCTHwHV/dZJTafpVwzt0b49yag5yCk+a
	 NGfv97k3YN7Ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69AC6CE0BA3; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 11/28] hazptrtorture: Defer release of hazard pointers
Date: Fri, 18 Sep 2026 17:00:39 -0700
Message-Id: <20260919000056.3132131-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
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
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 87 +++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 97663f22b36f..ff253fe35ca2 100644
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
 
@@ -605,14 +634,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
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

