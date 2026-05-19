Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19920313545
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219930; cv=none; b=BrXdu0wUyh0C6xlan5uVtrlQa3fr2r7RCQ2CLx9f0qguKpG9QTxjCpZdlD0yCUzD+EgwO3JKdsVd/iweoiignIrBrvM0D4na1/IWu00y7LdRrIBqYkftSp33Qc48fg4DZOzx3SfPt+NjBwv/2oYup1taq70KqY63EXC9N66QEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219930; c=relaxed/simple;
	bh=8U4fZXYxpP9EpOFHCwVetdbSURz8u4Tv2owOwveJqRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ga2RXzXksVrqHyWT4D+faIICacB1siCv/V1h8ojFfxPoqRQ+5m6tdpmmk+dhbNDozg683j7B/XI6ZPA6N7RmbU+77a1pUx1+yWvwGrKGq7afxPlQ0NfhMgExN3ZVy1R9MUmRbz5WOtqoqCUzVBoX3IsBjBipqgfGd8KXj0NeVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2Alyiku; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2Alyiku"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-394095009beso35724711fa.3
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219927; x=1779824727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT2OSOzkk3PaChfF7Nt8KGAWk9wIlHl4cNM3shxKASk=;
        b=D2AlyikubquxQqSRzUllPlJEY1lRFweJ8qaADgEi9N0z6su6vLKGHU+zXTy5hvhT8O
         VM6hwbXEShP6QK9XXbvhtAPImZGxs7fF27K35cPF65nXHKJOwaqtfqT9ZFokxDJhFZ7T
         TPCQVMGt2O4nYVqx3vk8WaXdoGoK6XL1dKvsLs0qqwITx8lopxWdIJpaDswf2iQWTFhJ
         xhtiKPsDzQ2VPfwZE6WNG5+tmXqJ9o5AxKKnnNS4eiRZYx+S+tJFhAvoo6BLvJ7QN3/c
         PBMgMC44P9q/H66MZajiSlQ5EABQGzhHa47cVHwGLieUd7++bntWf2/BG/tunAwigc80
         q7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219927; x=1779824727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IT2OSOzkk3PaChfF7Nt8KGAWk9wIlHl4cNM3shxKASk=;
        b=fTg6ZZ8c7fa7GzGg5HKdm5H6F2mQoS5qs4XuPrT/vCHiMY1PlEey/GUWsoMABcGK2I
         3EwcRFUIWw4LYLR9NpGPXlHpZh9zvfdKBzIqb0OI5de1ztKgCTepImhW/K3OSP4f2Ndi
         UqDC2lGba7kdiyIoekJtD5bepZkR7EZvaUCplJOLi52oTUSFIZuzBSi4FUITvZ6PCxOh
         FcY7gWjvex6MmnqUfth6CjDqt0b1mnTdVSF5IuKA/wg2Wp3fmXokUEQj0kOSYJ4fZVQw
         tHOjDizyzhROhFII72H0bAsJUmWYE9/WysBsVq16nWzI3B7V295EUVBUNkyXXo8kJQTe
         h/6w==
X-Gm-Message-State: AOJu0YwTBcgKiX9GOzGjkw9d9d699uTkde9yojaBh/OzbxTjk2ySatXS
	CzE5LslVdOlUfxVPps5dnLNEJUz/xAcKg46i3I22BgdkvUqpab6X2JcI
X-Gm-Gg: Acq92OGvifs+Now80jQIhZ+SvCdXj+rcfruKChKZeieKiwJXRWgQWhloIsxNsCWSGu8
	URIJXoUFx+3rIIlTpnUHt5tKh6qAXg3ImUlDZez5n0qV1ScOTkX8K+HVjy1REdhgxrRU+aQfKJE
	6K2/g5QDeyppBLqwW0HSN0E//byJ2fRht+7mCuFi3KkmEAfYQQdTP+hYqKexlr66IV0rZtZ2QqK
	POIdJPXgzKao0mfDABF3P9yFLoiCKcO2x3R+siM3fJQVr49/Vj0iVUJ63N1PB9mu1zFb/DIInX/
	G5oFbYNYldND/2m455iiVtCp1uvkx1TIE9CsqOAl7hiiNPfxi4uuNZj2fu3mrs42m85C/cvArWV
	LeAWA+w6htGeXX4jIzcBcQoHOHkcJIc4+Gw9+xZDThZcC5bFyQNehzC/duWpQzSZ0xAuX7ChtcJ
	ohqhAbpy9FvxF8vpI=
X-Received: by 2002:a05:651c:324b:b0:38e:8503:6fb5 with SMTP id 38308e7fff4ca-39561da4fccmr63360581fa.30.1779219927034;
        Tue, 19 May 2026 12:45:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:26 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Saravana Kannan <saravanak@kernel.org>
Subject: [PATCH -next v2 01/11] rcutorture: Fully test lazy RCU
Date: Tue, 19 May 2026 21:45:14 +0200
Message-ID: <20260519194524.158515-2-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, rcutorture bypasses lazy RCU by using call_rcu_hurry().
This works, avoiding the dreaded rtort_pipe_count WARN(), but fails to
fully test lazy RCU.  The rtort_pipe_count WARN() splats because lazy RCU
could delay the start of an RCU grace period for a full stutter period,
which defaults to only three seconds.

This commit therefore reverts the call_rcu_hurry() instances
back to call_rcu(), but, in kernels built with CONFIG_RCU_LAZY=y,
queues a workqueue handler just before the call to stutter_wait() in
rcu_torture_writer().  This workqueue handler invokes rcu_barrier(),
which motivates any lingering lazy callbacks, thus avoiding the splat.

Reported-by: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5f2848b828dc..882a158ada7b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -572,7 +572,7 @@ static unsigned long rcu_no_completed(void)
 
 static void rcu_torture_deferred_free(struct rcu_torture *p)
 {
-	call_rcu_hurry(&p->rtort_rcu, rcu_torture_cb);
+	call_rcu(&p->rtort_rcu, rcu_torture_cb);
 }
 
 static void rcu_sync_torture_init(void)
@@ -619,7 +619,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.poll_gp_state_exp	= poll_state_synchronize_rcu,
 	.cond_sync_exp		= cond_synchronize_rcu_expedited,
 	.cond_sync_exp_full	= cond_synchronize_rcu_expedited_full,
-	.call			= call_rcu_hurry,
+	.call			= call_rcu,
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
 	.gp_kthread_dbg		= show_rcu_gp_kthreads,
@@ -1145,7 +1145,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
 
 static void synchronize_rcu_mult_test(void)
 {
-	synchronize_rcu_mult(call_rcu_tasks, call_rcu_hurry);
+	synchronize_rcu_mult(call_rcu_tasks, call_rcu);
 }
 
 static struct rcu_torture_ops tasks_ops = {
@@ -1631,6 +1631,17 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
 		cpus_read_unlock();
 }
 
+/*
+ * Do an rcu_barrier() to motivate lazy callbacks during a stutter
+ * pause.  Without this, we can get false-positives rtort_pipe_count
+ * splats.
+ */
+static void rcu_torture_writer_work(struct work_struct *work)
+{
+	if (cur_ops->cb_barrier)
+		cur_ops->cb_barrier();
+}
+
 /*
  * RCU torture writer kthread.  Repeatedly substitutes a new structure
  * for that pointed to by rcu_torture_current, freeing the old structure
@@ -1651,6 +1662,7 @@ rcu_torture_writer(void *arg)
 	int i;
 	int idx;
 	unsigned long j;
+	struct work_struct lazy_work;
 	int oldnice = task_nice(current);
 	struct rcu_gp_oldstate *rgo = NULL;
 	int rgo_size = 0;
@@ -1703,6 +1715,9 @@ rcu_torture_writer(void *arg)
 		pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
 			 torture_type, jiffies - j);
 
+	if (IS_ENABLED(CONFIG_RCU_LAZY))
+		INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
+
 	do {
 		rcu_torture_writer_state = RTWS_FIXED_DELAY;
 		torture_hrtimeout_us(500, 1000, &rand);
@@ -1895,6 +1910,8 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
+		if (IS_ENABLED(CONFIG_RCU_LAZY))
+			queue_work(system_percpu_wq, &lazy_work);
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
 		    !atomic_read(&rcu_fwd_cb_nodelay) &&
@@ -1925,6 +1942,12 @@ rcu_torture_writer(void *arg)
 		pr_alert("%s" TORTURE_FLAG
 			 " Dynamic grace-period expediting was disabled.\n",
 			 torture_type);
+
+	if (IS_ENABLED(CONFIG_RCU_LAZY)) {
+		cancel_work_sync(&lazy_work);
+		destroy_work_on_stack(&lazy_work);
+	}
+
 	kfree(ulo);
 	kfree(rgo);
 	rcu_torture_writer_state = RTWS_STOPPING;
-- 
2.47.3

