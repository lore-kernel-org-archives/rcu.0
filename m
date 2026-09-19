Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F01AA797;
	Sat, 19 Sep 2026 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778135; cv=none; b=fS8jAuaVdief4hBlPzUpAuCcOqETnDruKwJqwfIKndbcY1i5PxumOaWGOiwCSGDi1hAuXR+3aU6lX8OiyRMqjB89Ts4Yx2w3ms4oic1ZAEuMwTL3EIKuYeKDftNVyZwhuxzoG2TKX6Hb3LH1lRJNBqfNj/DRp+KbBG7E402EMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778135; c=relaxed/simple;
	bh=/9HmLJfH3pFEXNnPopsEi2typ6ShsGIfRKjMFQ/wMLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cf9XMkPr7+t9D8dVQzHHiirQZviaHHKcQcS0Ap05uzW5NuIFAmZGjFBPi3x5dUju3p/lZ/nReXAydKugVvIFgjMmgCmzkeleubWfNonb0dE/Ul9UqZ5hT4rRUwY84jj3c376vrCCaoPq+jFORhRPnfIWxE6Glafcn+duPqcJydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbRjjhqe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbRjjhqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114D51F008A0;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=HVqP8Teu3futyaWMPpK/48WE/7HEC2PYevCXIKQw8Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbRjjhqeUtdH214/0wV/SC/w//sNpXENucqwLk3ETMT6LidnHpNMrIezBVMP9TfLQ
	 B7akFwl57LSJaMxeZmb1kZkCg/UEFJD73JO6HrcbEmj4IuMTnM4Hn7LrmmDyI3rzsg
	 x3GwNuGw775ivn/51vCpjeTdskrEWB94xhK97HixiP3sz5SY+IhSnQy1GISxIkgaUe
	 3BAVWjzbC5nX4ERG825NAOSs24i02veX9oH+Lzq1hNClDqPNmGe5qq9EQE5efdQnFL
	 Hd1dL1DRf4FYGzOvbM9yWgURclrhbbj+oTwe/8YApyMT1BP3zZ1paZe2m6zVmdARNy
	 PlMgE0BY8sG5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A0617CE1854; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 06/19] rcutorture: Add support for testing synchronize_srcu_atomic()
Date: Fri, 18 Sep 2026 17:35:08 -0700
Message-Id: <20260919003521.3134552-6-paulmck@kernel.org>
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

This commit adds support for the value 0x10 for reader_flavor, which
specifies SRCU_READ_FLAVOR_ATOMIC, that is, srcu_read_lock_atomic(),
srcu_read_unlock_atomic(), and synchronize_srcu_atomic().

[ paulmck: Apply Kunwu Chan feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 46 +++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4d1be2a49f01..182d47975efd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -710,10 +710,21 @@ static struct rcu_torture_ops rcu_busted_ops = {
 DEFINE_STATIC_SRCU(srcu_ctl);
 DEFINE_STATIC_SRCU_FAST(srcu_ctlf);
 DEFINE_STATIC_SRCU_FAST_UPDOWN(srcu_ctlfud);
+DEFINE_STATIC_SRCU_ATOMIC(srcu_ctla);
 static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
 static struct rcu_torture_ops srcud_ops;
 
+// Restrict APIs permitted for atomic SRCU.
+static void srcu_torture_init_forbidden_apis(void)
+{
+	cur_ops->call = NULL;
+	cur_ops->cb_barrier = NULL;
+	cur_ops->deferred_free = NULL;
+	cur_ops->exp_current = NULL;
+	cur_ops->start_gp_poll = NULL;
+}
+
 static void srcu_torture_init(void)
 {
 	rcu_sync_torture_init();
@@ -729,6 +740,11 @@ static void srcu_torture_init(void)
 		srcu_ctlp = &srcu_ctlfud;
 		VERBOSE_TOROUT_STRING("srcu_torture_init fast-up/down SRCU");
 	}
+	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC) {
+		srcu_ctlp = &srcu_ctla;
+		VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU");
+		srcu_torture_init_forbidden_apis();
+	}
 }
 
 static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
@@ -766,6 +782,11 @@ static int srcu_torture_read_lock(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 3;
 	}
+	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC) {
+		idx = srcu_read_lock_atomic(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 4;
+	}
 	return ret;
 }
 
@@ -785,7 +806,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 
 	delay = torture_random(rrsp) %
 		(nrealreaders * 2 * longdelay * uspertick);
-	if (!delay && !in_atomic() && !rcu_preempt_depth() && !irqs_disabled()) {
+	if (!delay && !in_atomic() && !rcu_preempt_depth() && !irqs_disabled() &&
+	    !(reader_flavor & SRCU_READ_FLAVOR_ATOMIC)) {
 		schedule_timeout_interruptible(longdelay);
 		rtrsp->rt_delay_jiffies = longdelay;
 	} else {
@@ -796,6 +818,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC)
+		srcu_read_unlock_atomic(srcu_ctlp, (idx & 0x10) >> 4);
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
 		srcu_read_unlock_fast_updown(srcu_ctlp,
 					     __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
@@ -875,7 +899,10 @@ static void srcu_torture_deferred_free(struct rcu_torture *rp)
 
 static void srcu_torture_synchronize(void)
 {
-	synchronize_srcu(srcu_ctlp);
+	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC)
+		synchronize_srcu_atomic(srcu_ctlp);
+	else
+		synchronize_srcu(srcu_ctlp);
 }
 
 static unsigned long srcu_torture_get_gp_state(void)
@@ -911,7 +938,10 @@ static void srcu_torture_stats(void)
 
 static void srcu_torture_synchronize_expedited(void)
 {
-	synchronize_srcu_expedited(srcu_ctlp);
+	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC)
+		synchronize_srcu_atomic(srcu_ctlp);
+	else
+		synchronize_srcu_expedited(srcu_ctlp);
 }
 
 static void srcu_torture_expedite_current(void)
@@ -969,6 +999,10 @@ static void srcud_torture_init(void)
 	} else if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
 		WARN_ON(init_srcu_struct_fast_updown(&srcu_ctld));
 		VERBOSE_TOROUT_STRING("srcud_torture_init fast-up/down SRCU");
+	} else if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC) {
+		WARN_ON(init_srcu_struct_atomic(&srcu_ctld));
+		VERBOSE_TOROUT_STRING("srcud_torture_init atomic SRCU");
+		srcu_torture_init_forbidden_apis();
 	} else {
 		WARN_ON(init_srcu_struct(&srcu_ctld));
 	}
@@ -1749,7 +1783,7 @@ rcu_torture_writer(void *arg)
 		pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
 			 torture_type, jiffies - j);
 
-	if (IS_ENABLED(CONFIG_RCU_LAZY))
+	if (IS_ENABLED(CONFIG_RCU_LAZY) && cur_ops->call)
 		INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
 
 	do {
@@ -1944,7 +1978,7 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
-		if (IS_ENABLED(CONFIG_RCU_LAZY))
+		if (IS_ENABLED(CONFIG_RCU_LAZY) && cur_ops->call)
 			queue_work(system_percpu_wq, &lazy_work);
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
@@ -1977,7 +2011,7 @@ rcu_torture_writer(void *arg)
 			 " Dynamic grace-period expediting was disabled.\n",
 			 torture_type);
 
-	if (IS_ENABLED(CONFIG_RCU_LAZY)) {
+	if (IS_ENABLED(CONFIG_RCU_LAZY) && cur_ops->call) {
 		cancel_work_sync(&lazy_work);
 		destroy_work_on_stack(&lazy_work);
 	}
-- 
2.40.1

