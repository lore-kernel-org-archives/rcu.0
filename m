Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806502D7DE7;
	Thu, 16 Jul 2026 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161532; cv=none; b=Wty8dXFs1n59AA5cTrT1Wv7FOi6B9s0ZPnil3ZM1v+4qSqOJbYWy1D6NP2ft/rg8np4Y5UMtYcRCGnZECWuUEnuo9Wd+k0FVyjct5SCYNslfey3t+rNasUdfp+ZcbqpSvYijCbtKH64OXFTKhCbWNNeCSWCFeoUczWAGHQpZT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161532; c=relaxed/simple;
	bh=OOSdQVrYwmh+RTss2fts75ttboe3Qa8Pwyl4rm5cL2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RfAaEI10z/xtA5UeMSUM+RkEvxMPnLvkvSuY3sQ1CB4g2/orsaVYGzP1bU4sEIHr50t/iJg/OYLdlDBO61LSYTBvkRUcl1ibxlZLjtoayFyaNoZKgiNehHt1b6n8Oym8D9LBo+02DZsd4XuftisKWjgGryRkjiMhDH62aOpYxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AST3j8zB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AST3j8zB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85BA1F0155A;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161523;
	bh=naLwP4ocZHefeFlWoSOcGsJA9i8DDPgQKHV4njTu0s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AST3j8zBSDnM4FSjLVEsmolw0UkmYrf8Kdb244HtyD1AaygesW6KfRCMJ/PSWNQmd
	 /YuG6iZCtZZEPm38uXhMmnrj5DVIn3bKrQFlbO00p92EV7EbIVFMY+MoXSxUWTvGMG
	 PBeM7KbE22JlGZWkaJJ35rIyzOH9j2XVjzIyVLFo31h1gLQ2SHQ2d6BndcAhZTKvr4
	 R9qOv79BDnc7m6UsSvLZq8BD4ERclmyt3uTsfURM9oN/PQN6wb5M9eI52cw4D/CCuX
	 2eAKvsxx+2NMwjbr2QLHc72bwWL0uNzGNnvDrau0B/2URtpH2Pazjf9G0ctLfBcHMw
	 +xm4b6nAAEhTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 865F8CE0E86; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 10/11] rcutorture: Make RCU Tasks Trace track Reader Batches
Date: Wed, 15 Jul 2026 17:25:19 -0700
Message-Id: <20260716002520.11895-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
References: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the ->get_sp_seq and ->gp_diff fields to the
tasks_tracing_ops structure so that RCU Tasks Trace rcutorture runs will
track Reader Batch.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h | 3 +++
 kernel/rcu/rcutorture.c        | 3 ++-
 kernel/rcu/tasks.h             | 6 ++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index cee89e51e45cbb..f2c4173bf14fde 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -198,10 +198,13 @@ static inline void rcu_tasks_trace_expedite_current(void)
 	srcu_expedite_current(&rcu_tasks_trace_srcu_struct);
 }
 
+unsigned long rcu_tasks_trace_batches_completed(void);
+
 // Placeholders to enable stepwise transition.
 void __init rcu_tasks_trace_suppress_unused(void);
 
 #else
+static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0; }
 /*
  * The BPF JIT forms these addresses even when it doesn't call these
  * functions, so provide definitions that result in runtime errors.
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c8118c38812aee..8514fef3ec10b6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1252,7 +1252,8 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.read_delay	= srcu_read_delay,  /* just reuse srcu's version. */
 	.readunlock	= tasks_tracing_torture_read_unlock,
 	.readlock_held	= rcu_read_lock_trace_held,
-	.get_gp_seq	= rcu_no_completed,
+	.get_gp_seq	= rcu_tasks_trace_batches_completed,
+	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f4da5fad70f516..496acac8796fa7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1606,4 +1606,10 @@ static inline void rcu_tasks_bootup_oddness(void) {}
 DEFINE_SRCU_FAST(rcu_tasks_trace_srcu_struct);
 EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
 
+unsigned long rcu_tasks_trace_batches_completed(void)
+{
+	return srcu_batches_completed(&rcu_tasks_trace_srcu_struct);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_batches_completed);
+
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-- 
2.40.1

