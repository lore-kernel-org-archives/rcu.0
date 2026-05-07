Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420733B9DBB;
	Thu,  7 May 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173040; cv=none; b=Ca3qN1tqLGd7wdGawWrSJexsN0j+wm4pI/b8mqn8EXLWuCaU1nzskc3lYm8LStYOinBb/4elbewrLMuWVM68XS7eC+DIG6nDp+xVrJC8SRuHsH5zmDkYrFBTiPkRtOxbQ0UtIHYB7jHMD/1sU2DSMjDrI+lqD+S3lG3w5jkY0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173040; c=relaxed/simple;
	bh=MpRH6xuulKXtAFEkNtlqtTW30yc5wEjTy550DrkiKM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hsyv/T+8/bHx4GhQ9sL0XCk7Pa9KQny5Za6lzPE2XkdktomNEmEWmG0DsoblS8NsaKkD0PVGQsRyReSWq1e8icZIVu/dKPzvUFtgrALH96+28CWadJVECOWkV5cNeXWEimm6eP/rzbTPVGKxdfjI77ydNefYKDLiCGwjaaC7vlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7Nlxhzh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7Nlxhzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67AEC2BCB2;
	Thu,  7 May 2026 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173039;
	bh=MpRH6xuulKXtAFEkNtlqtTW30yc5wEjTy550DrkiKM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7NlxhzhGB03JlqTROQbAv2KstlUTw0jcWvwGV9CXgHa7aFjl6+LJnr7RZidXE/A3
	 AI/lEus692aFL0ocU5SgyyO3m7pz30ybmdNaFHtlQMhCIHlKQqXyq8d27L6dkVvU6y
	 ARzsT1n6z7nBH69KahZXdsft8kY1zvD+33Bp+Q3OXUH+cE32dcxGJ0UyuYk0gV7B7Y
	 cB/5lQ4YDaFpFDqGgBLoaNzM1uwgs2AIxw1zwOE6UkdVWyBENknXsufl2jQ2FAKIBS
	 AHzYmnKpgnk4R629stUlkvg8T6k1kgj34cHW6niZqS/It2DmZ0JRf98w1juFLZ/T7e
	 xfU8bA5G24EBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9F873CE0863; Thu,  7 May 2026 09:57:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Subject: [PATCH 1/6] rcutorture: Fully test lazy RCU
Date: Thu,  7 May 2026 09:57:15 -0700
Message-Id: <20260507165718.2039781-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
References: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Questions for review:

1.	Should we avoid queueing work for RCU implementations not
	supporting lazy callbacks?

2.	Should we avoid queueing work in kernels built with
	CONFIG_RCU_LAZY=y, but that were not booted with the
	rcutree.enable_rcu_lazy kernel boot parameter set?  (Note that
	this requires some ugliness to access this parameter, and must
	also handle Tiny RCU.)

3.	Does the rcu_torture_ops structure need a ->call_hurry() field,
	and if so, why?  If not, why not?

4.	Your additional questions here!

Reported-by: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 590fd0138589b8..3c8e4cd5b83e60 100644
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
@@ -1667,6 +1679,7 @@ rcu_torture_writer(void *arg)
 		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
 			      HZ * (stall_cpu_repeat + 1);
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
+	INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
 	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
 			 " GP expediting controlled from boot/sysfs for %s.\n",
@@ -1895,6 +1908,8 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
+		if (IS_ENABLED(CONFIG_RCU_LAZY))
+			queue_work(system_percpu_wq, &lazy_work);
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
 		    !atomic_read(&rcu_fwd_cb_nodelay) &&
-- 
2.40.1

