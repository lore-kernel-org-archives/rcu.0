Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E336D9F8
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522095; cv=none; b=ewYKZld4CJuTTXU/RcZDSW7DTUxDOYawlCxKv+fXMz9piQTcKCPLHsN9I8oKjZ1MOlgA7qCcMxK4UTWAGsgcuk6pYotidYFqnP6SMCZzrHpu69AFJra8pEmJL3hZ5ZWIHJki5V+kybT31SagsXHLaLApLGIT+uAfv3flrBkkasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522095; c=relaxed/simple;
	bh=oyj44b2X/gf31b64EzcddFgoIyjqK3vIjWVheZ8B7eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7PtdkMmrDdpfu91s3QXyDCl+RxXYS0bILb/5e0Kgqw4hWyJU2efSCm5N4Tn0qUniGpPy5qV57KpfgEyOClQBO4Eeb9Oq87A4ppAccdfzRQOdA/U65V/4kuKfJ+jWb6Mz1IfdzieeNPe98yxLex85r0NB6rxOK0IOONBXSXl9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv/J9Thq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv/J9Thq"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39389398838so39313231fa.3
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522091; x=1779126891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oypEOShKaWqUxhXIr4cP4ZN66BvXq7YgjyA1BVRqQPI=;
        b=Nv/J9Thq3cIO0IrDdR14mNu+Ftsovebz083cmpMNlbsQ9y0UQ0f93ivOvtqz+azcsb
         Mu7IOxOsUBtdgFFbUYa905zEx4nVL5LmiyvzrqCw6RKqQxLj2076yFg2opprrsuLNLTd
         PZNcSFOQjhe8gLIfSEGBdJoT2s3B2mAfwJTfZjZTb3s1SzbwQH7u961x8tTzP9D6oZmw
         QtkIvx+3FQXFJTBw43Sk1XgZjkkOace+/AoP04o8UuGdSPDiY8lj7Jm/4WlxT7V69n7A
         A9auCqW26wzCMk/40nlvcAuGLHgOosNvKPeyRJ1LPKEbVE1d/PE3D5cuWQWyvPwP1ok1
         omPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522091; x=1779126891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oypEOShKaWqUxhXIr4cP4ZN66BvXq7YgjyA1BVRqQPI=;
        b=Y1Z5FQR3/yqIWsdpqUUTikvOevWogjnZ/EapUt7LAzstqLp5+GZHBylCiO7ID4tFk6
         OcLKjOch5KB0rxTAMonyBNB7OeZOGN5PRde3lkc39YSP1U+5U3J8jLGlrE6o8KpkVhNX
         g6WrwKQGupPWPVfVZ9fkY2zAAHzDT5aWH62pRZ+upr/Ka3tdJPT+AkYDg86eYtw76YXP
         2ajAO8OgI0ERE3Uv6qblJnXDVjU+7HDSQ/36y7RSkvPwsUP0ZchtgjVQ0aroFXlhJ39S
         1A8CBSy5Xk+aSOrL3jvBuX+IxIeKUKCdW5/MrdqUlA0ZI3q+oYiq01kc464kiTxpKJQC
         OgjA==
X-Gm-Message-State: AOJu0YzRokNqjCsOZ0mAaX0vIZwybFPLrGOep22TT1nmsGWH1pqVuBJw
	ThRHcK0pu4oEeDfrdEpr+oC4NHWmet/TWZTSIgS+Chc1J4v70GDNcW8o
X-Gm-Gg: Acq92OGRoBMOLjDbWFw9NCgVrHE/zM4jhKnRsAkioZlSN0TGavI2gh+7lOZRb9IEOjX
	WQa/rjZRQOCM1iWcwchKfxyAtAus8CSv5QFRHFBXys2DIF6QjInWNQGhdlD7KerCAKa+ZWQwroj
	n5NBUjlzr/ORjhSIWKdNM99D80w+K5Z1j9eCQVkwsS65PUnzG6JMOcKmlVKb7AAI6LjWo47VK63
	6MT7hhH14dNqfSdiHhJiG6FD5dPHk/IwhzjQYssDBmJCzpaWNbol602ilYnydftyPsz2wpz1U7x
	Y4SeTVYxmteq4s1BjA6euNB400TXL68oOFc0Wg1cQ2aGSo7uQYDtz+1tzE7EV7WnAH1woddxu5d
	kdBIHcMe9Cezuyyg8JGpmiq9QIQ08wPIrX+vkHrxTVvUa3rEa7oN+VHSiOka44Ah6HN/XF3E75D
	EKRXYCuDSNvtonmrY=
X-Received: by 2002:a05:651c:1448:b0:393:7ab7:2c9f with SMTP id 38308e7fff4ca-393c4324db2mr89692671fa.31.1778522091287;
        Mon, 11 May 2026 10:54:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:50 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Saravana Kannan <saravanak@kernel.org>
Subject: [PATCH -next v1 01/12] rcutorture: Fully test lazy RCU
Date: Mon, 11 May 2026 19:54:37 +0200
Message-ID: <20260511175448.153326-2-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
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
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5f2848b828dc..91ba3160ba6a 100644
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
2.47.3

