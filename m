Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2162AD0C;
	Sat, 28 Feb 2026 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772239142; cv=none; b=u2i0KFHJYu93ag2fDw7/2yTo4vEda1iW94ux6XUJNdU8Hq2472fkPESSei/fo4l2kWBUlgeamfC4gTtc0rIq/08JLF4+6KnWMWZ+2DkYkFmBLgV6MS/mQdvwXvGUaAs7zdfRizY+y3l622n5kxWe6tjoeYE5nCNS9UeP49ZAsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772239142; c=relaxed/simple;
	bh=9L8LRyexCp4C9Jc6U4wax2v7eRGVqWOYEyd2kmyBLHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UC0XXVkYtnDUGQ2LaEyENG1Bjin2hwjMTarpkF2hGejrgTczmLGb8Acy5fRj1WUtYvhZk5Qjl/ToPdm3GPaz3AvOgCIHOOp1MFH+egsTkEvdWuZyfYCU0S4u02Nyi992m1RaboOf/2qfDCR11CltE4pRd+6n9h7xBs11X01IXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiQGydGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiQGydGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8E1C116C6;
	Sat, 28 Feb 2026 00:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772239142;
	bh=9L8LRyexCp4C9Jc6U4wax2v7eRGVqWOYEyd2kmyBLHk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=MiQGydGPgq1bt1IJypWuaRevQpzdwtM0YZxXT+pBcmcP5pcdI50Q85P1VPa9yfSmE
	 205XyeNVvCwL6tM/+OFQSNtt3hyfDSnJXvnBmaYaQq44HgvVFVMr7/G/0Cp8pLkfV0
	 qfW8yUZrQ0qKYMXqSntBv2CfplU1pyQOqOlMx9NOeNDvTcVnwJFJ9FEAaFh8EocG59
	 oJTNJiEN8iKO/t34vKdK1icBnJ6JPSRW9n1C8DYeWMipEbB/DpHaS3TgZq2JDZ+Api
	 jbGzAmwXfOH3jvlqd98sdxSYvZcKHmFQL8jPJVO6eBMIxZppVJHfo0sM0/sPxvZ47Z
	 vZhpXTgtzvu5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A52A0CE0F4C; Fri, 27 Feb 2026 16:39:01 -0800 (PST)
Date: Fri, 27 Feb 2026 16:39:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>
Subject: [PATCH RFC] rcutorture: Fully test lazy RCU
Message-ID: <07395baa-806d-4e12-84b2-c393aee064cd@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c7958a3f8d673..270d551d66482 100644
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
@@ -1138,7 +1138,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
 
 static void synchronize_rcu_mult_test(void)
 {
-	synchronize_rcu_mult(call_rcu_tasks, call_rcu_hurry);
+	synchronize_rcu_mult(call_rcu_tasks, call_rcu);
 }
 
 static struct rcu_torture_ops tasks_ops = {
@@ -1624,6 +1624,17 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
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
@@ -1644,6 +1655,7 @@ rcu_torture_writer(void *arg)
 	int i;
 	int idx;
 	unsigned long j;
+	struct work_struct lazy_work;
 	int oldnice = task_nice(current);
 	struct rcu_gp_oldstate *rgo = NULL;
 	int rgo_size = 0;
@@ -1660,6 +1672,7 @@ rcu_torture_writer(void *arg)
 		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
 			      HZ * (stall_cpu_repeat + 1);
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
+	INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
 	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
 			 " GP expediting controlled from boot/sysfs for %s.\n",
@@ -1888,6 +1901,8 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
+		if (IS_ENABLED(CONFIG_RCU_LAZY))
+			queue_work(system_percpu_wq, &lazy_work);
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
 		    !atomic_read(&rcu_fwd_cb_nodelay) &&
