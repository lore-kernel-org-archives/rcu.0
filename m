Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0A2D9EED;
	Fri, 31 Jul 2026 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460045; cv=none; b=pisbW2uUYnlSTqYUdhxjGHjowJ0QQUdyCDjwz10I6JJEcYveoFV9D04fJJ6kF0cKM08lCrfE0ORCmCbXxL/PNFYr1NSySXuIrV8gZc6KlFzutc1HL7mnqIlWkgiMfU08ns1j6dzckhsOIqItjoSu/ApUus7GPoUXXdNdvRhPKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460045; c=relaxed/simple;
	bh=OOSdQVrYwmh+RTss2fts75ttboe3Qa8Pwyl4rm5cL2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guIPBmqmK+h5842+S/ZOwqsMI4Z3sLEKDupvQxK/MndcvRTxWzJ9hnhxI60Qftzf3BVRhZc/GRoEPcaGPSQWhQ5ADTUwwA8E+K/18VMQceugApEhUXnuv39S0aEOI77yD/z6BxomjwXL9Zc2qaijdwv9dF2tfdqD5ubPrtd7s3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4oIRKoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4oIRKoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7D51F00ADB;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460041;
	bh=naLwP4ocZHefeFlWoSOcGsJA9i8DDPgQKHV4njTu0s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W4oIRKoUYb/AFRBO9EqnaIdpCdmAFxY+u6ZX/valb9ib/SD4Vuwpx2vLYAxybQK4B
	 ARNrqS5kq1YlPp8CjxPQzpvkPA9/YcaVKTULxjDyM0bH/41KzmOl24q/TRD8zUB0Vj
	 +cqDkKuQFPjgrdVWE9xUcI6KGWan4t5j23E5A6Nodwyg75NYpVImcofw3RP8bJd3LZ
	 4Qp9BUuFwNonO0he7H1ROHub6HIhvAnYquXKXNjyfvNktu6xzeevZq3yhTU76SlJAI
	 nP4Y1+ILzSF5mRXT5iQXOIoV/9NdCLwPjSmtS9pmoF8uYALaPYQ7Xz7Un9c5GHtLON
	 R72tQddIYAjYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9734DCE14D9; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 09/13] rcutorture: Make RCU Tasks Trace track Reader Batches
Date: Thu, 30 Jul 2026 18:07:15 -0700
Message-Id: <20260731010719.3531912-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
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

