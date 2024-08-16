Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79422C6BB;
	Fri, 16 Aug 2024 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787593; cv=none; b=UgdtjYL567pIgvUQDDmZVLEhorzKvGy96h9ly0gQPatrPjqC3g0nQY2oov9ZibxwHLEFwxEdTxBNrQhAwcrrEmhQRMhNMLvI5e4cxTuJQ//2sekh/OF/ZmGdy9c1Wg0sfJCLy4GWBJv4BDI18Cr6U8qyn6ozC/3KYoUIeqk3k1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787593; c=relaxed/simple;
	bh=uPvfjpRFgcl2sPL51graSbouqQOd5j2RHeEHMv6k6as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sD0qslk3vBA//IUM363wCddMnM1GJlAZ+dKlaaxu14EvS1EXZm8Yxp+Ut8STnp8SeqhBC7+JGhsImbkUufzQeZPWIcr17ZK18ky/WgLuWdS0Yecu6ds6WMC89DMzkEmIb93/qAoD1Ihsf+ej5vtPK0JBff02snJEr3dpcBZPGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXlDP6bG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXlDP6bG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BF5C4AF09;
	Fri, 16 Aug 2024 05:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787593;
	bh=uPvfjpRFgcl2sPL51graSbouqQOd5j2RHeEHMv6k6as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fXlDP6bGXktnZSQmsCmCz8Cbelu2YTWjHV2zN7M2oE81INC+4MyStGR4pt7hRF787
	 QwU3m5HNmPlst0w1U5ENsGAcRqqSA5ov3OLY661CZ71SYVrpZm4SnRNHSoWF4uo24T
	 bYaqQtqtLfG5KbDuakd4f8umjMiD3ZJdcZeDr93Vv1Gd0lknuIaShhO/8M8QfhvjN2
	 UgqVrH39RM+NJUZvGaaaQkxjQmEkL7LbtlPUf1njT5lgaa8azjovOHq+Pv82m90rOu
	 nTYKOKCSE9ki8RxiR0z0k8nQwoBT6dzJoROm4iAy5dwddIPGdkW2CDt3sQ3eYubQSK
	 YAER6ZDg9Mipw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 3/8] rcutorture: Generic test for NUM_ACTIVE_*RCU_POLL*
Date: Fri, 16 Aug 2024 11:21:58 +0530
Message-Id: <20240816055203.43784-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
References: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcutorture test suite has specific tests for both of the
NUM_ACTIVE_RCU_POLL_OLDSTATE and NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE
macros provided for RCU polled grace periods.  However, with the
advent of NUM_ACTIVE_SRCU_POLL_OLDSTATE, a more generic test is needed.
This commit therefore adds ->poll_active and ->poll_active_full fields
to the rcu_torture_ops structure and converts the existing specific
tests to use these fields, when present.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b2e6201b4569..acf9f9945d2b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -373,6 +373,8 @@ struct rcu_torture_ops {
 	bool (*poll_need_2gp)(bool poll, bool poll_full);
 	void (*cond_sync)(unsigned long oldstate);
 	void (*cond_sync_full)(struct rcu_gp_oldstate *rgosp);
+	int poll_active;
+	int poll_active_full;
 	call_rcu_func_t call;
 	void (*cb_barrier)(void);
 	void (*fqs)(void);
@@ -558,6 +560,8 @@ static struct rcu_torture_ops rcu_ops = {
 	.poll_need_2gp		= rcu_poll_need_2gp,
 	.cond_sync		= cond_synchronize_rcu,
 	.cond_sync_full		= cond_synchronize_rcu_full,
+	.poll_active		= NUM_ACTIVE_RCU_POLL_OLDSTATE,
+	.poll_active_full	= NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE,
 	.get_gp_state_exp	= get_state_synchronize_rcu,
 	.start_gp_poll_exp	= start_poll_synchronize_rcu_expedited,
 	.start_gp_poll_exp_full	= start_poll_synchronize_rcu_expedited_full,
@@ -741,6 +745,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.get_gp_state	= srcu_torture_get_gp_state,
 	.start_gp_poll	= srcu_torture_start_gp_poll,
 	.poll_gp_state	= srcu_torture_poll_gp_state,
+	.poll_active	= NUM_ACTIVE_SRCU_POLL_OLDSTATE,
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
@@ -783,6 +788,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.get_gp_state	= srcu_torture_get_gp_state,
 	.start_gp_poll	= srcu_torture_start_gp_poll,
 	.poll_gp_state	= srcu_torture_poll_gp_state,
+	.poll_active	= NUM_ACTIVE_SRCU_POLL_OLDSTATE,
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
@@ -1374,13 +1380,15 @@ rcu_torture_writer(void *arg)
 	int i;
 	int idx;
 	int oldnice = task_nice(current);
-	struct rcu_gp_oldstate rgo[NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE];
+	struct rcu_gp_oldstate *rgo = NULL;
+	int rgo_size = 0;
 	struct rcu_torture *rp;
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
 	unsigned long stallsdone = jiffies;
 	bool stutter_waited;
-	unsigned long ulo[NUM_ACTIVE_RCU_POLL_OLDSTATE];
+	unsigned long *ulo = NULL;
+	int ulo_size = 0;
 
 	// If a new stall test is added, this must be adjusted.
 	if (stall_cpu_holdoff + stall_gp_kthread + stall_cpu)
@@ -1401,6 +1409,16 @@ rcu_torture_writer(void *arg)
 		torture_kthread_stopping("rcu_torture_writer");
 		return 0;
 	}
+	if (cur_ops->poll_active > 0) {
+		ulo = kzalloc(cur_ops->poll_active * sizeof(ulo[0]), GFP_KERNEL);
+		if (!WARN_ON(!ulo))
+			ulo_size = cur_ops->poll_active;
+	}
+	if (cur_ops->poll_active_full > 0) {
+		rgo = kzalloc(cur_ops->poll_active_full * sizeof(rgo[0]), GFP_KERNEL);
+		if (!WARN_ON(!rgo))
+			rgo_size = cur_ops->poll_active_full;
+	}
 
 	do {
 		rcu_torture_writer_state = RTWS_FIXED_DELAY;
@@ -1502,19 +1520,19 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_POLL_GET:
 				rcu_torture_writer_state = RTWS_POLL_GET;
-				for (i = 0; i < ARRAY_SIZE(ulo); i++)
+				for (i = 0; i < ulo_size; i++)
 					ulo[i] = cur_ops->get_comp_state();
 				gp_snap = cur_ops->start_gp_poll();
 				rcu_torture_writer_state = RTWS_POLL_WAIT;
 				while (!cur_ops->poll_gp_state(gp_snap)) {
 					gp_snap1 = cur_ops->get_gp_state();
-					for (i = 0; i < ARRAY_SIZE(ulo); i++)
+					for (i = 0; i < ulo_size; i++)
 						if (cur_ops->poll_gp_state(ulo[i]) ||
 						    cur_ops->same_gp_state(ulo[i], gp_snap1)) {
 							ulo[i] = gp_snap1;
 							break;
 						}
-					WARN_ON_ONCE(i >= ARRAY_SIZE(ulo));
+					WARN_ON_ONCE(ulo_size > 0 && i >= ulo_size);
 					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
 								  &rand);
 				}
@@ -1522,20 +1540,20 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_POLL_GET_FULL:
 				rcu_torture_writer_state = RTWS_POLL_GET_FULL;
-				for (i = 0; i < ARRAY_SIZE(rgo); i++)
+				for (i = 0; i < rgo_size; i++)
 					cur_ops->get_comp_state_full(&rgo[i]);
 				cur_ops->start_gp_poll_full(&gp_snap_full);
 				rcu_torture_writer_state = RTWS_POLL_WAIT_FULL;
 				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
 					cur_ops->get_gp_state_full(&gp_snap1_full);
-					for (i = 0; i < ARRAY_SIZE(rgo); i++)
+					for (i = 0; i < rgo_size; i++)
 						if (cur_ops->poll_gp_state_full(&rgo[i]) ||
 						    cur_ops->same_gp_state_full(&rgo[i],
 										&gp_snap1_full)) {
 							rgo[i] = gp_snap1_full;
 							break;
 						}
-					WARN_ON_ONCE(i >= ARRAY_SIZE(rgo));
+					WARN_ON_ONCE(rgo_size > 0 && i >= rgo_size);
 					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
 								  &rand);
 				}
@@ -1617,6 +1635,8 @@ rcu_torture_writer(void *arg)
 		pr_alert("%s" TORTURE_FLAG
 			 " Dynamic grace-period expediting was disabled.\n",
 			 torture_type);
+	kfree(ulo);
+	kfree(rgo);
 	rcu_torture_writer_state = RTWS_STOPPING;
 	torture_kthread_stopping("rcu_torture_writer");
 	return 0;
-- 
2.40.1

