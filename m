Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15CA12CDBA;
	Fri, 16 Aug 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791048; cv=none; b=cLzzA6n7u7dfAatONp00CW/yd/iGarNydDgVtN8Jpaa+UgmURV6BrZVA+H+6ha0tD3SuYz6QoNLVs732NcnKJ6gGFuOCqB/1hWYpA72qDGF/ozpUOZh0xerYS+8avrF6nzrpVJZYnIIm9tAynLU8dZ9jh1e2GgaY/8BKOK+hqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791048; c=relaxed/simple;
	bh=UeCiYHs1vez36Tx9MRfvIOwMz1Q1YjwQeJtSjmbREkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ydkbkqu85oLCcAyaSjrBKpEO+7Vf9Spbdv8TSlS5rRFo6uddimi5+YoHi4qehPWGhF1Z59fS5VaJ5nFNCiQxQZ/UAXqu1KYouujhaf5q3rkuJGLacqwVRCwuAXMoP3fIAEfzvb3PrrGwsyPnMBNGTvA1i2XAZxBfPdTkX2J5UoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMEGnr9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMEGnr9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F95DC4AF0F;
	Fri, 16 Aug 2024 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791047;
	bh=UeCiYHs1vez36Tx9MRfvIOwMz1Q1YjwQeJtSjmbREkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMEGnr9/7eypT7eVq6nFKxLLMekYYnuKxYo6gxbAUW1YOzqcuTgoUz4QC+pWzDD42
	 Rqj7r/XDIn6rLR+6rxAnbm+6EZxqzfS0gNg8F5vRh8kMMMCAheAf3LMYr0bOwkjlDc
	 WZSMx74Y+1PdIqIQYuHkIHkwJCVt+gnd++UBxhTbGjJCF7Eaub/TnT6Vj/1tSkTA5b
	 ltQ8Fx7h7igek8cxPEI9S+OaIju5jmRMcUgAFdQ87SAEbMJRYQ4L6v1yofPuy/D+U/
	 +3p2bx/wY0NR5vlSR2MzjaqtRBpSEqvR8xkcGpGtuau/T9xxaWTwZLaGSiZvBsy1WH
	 IEkbOaylaPw7Q==
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
	frederic@kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH rcu 03/12] rcutorture: Stop testing RCU Tasks Rude asynchronous APIs
Date: Fri, 16 Aug 2024 12:19:12 +0530
Message-Id: <20240816064921.57645-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The call_rcu_tasks_rude() and rcu_barrier_tasks_rude() APIs are currently
unused.  Furthermore, the idea is to get rid of RCU Tasks Rude entirely
once all architectures have their deep-idle and entry/exit code correctly
marked as inline or noinstr.  As a first step towards this goal, this
commit therefore removes these two functions from rcutorture testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 08bf7c669dd3..cd8752b2a960 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -915,11 +915,6 @@ static struct rcu_torture_ops tasks_ops = {
  * Definitions for rude RCU-tasks torture testing.
  */
 
-static void rcu_tasks_rude_torture_deferred_free(struct rcu_torture *p)
-{
-	call_rcu_tasks_rude(&p->rtort_rcu, rcu_torture_cb);
-}
-
 static struct rcu_torture_ops tasks_rude_ops = {
 	.ttype		= RCU_TASKS_RUDE_FLAVOR,
 	.init		= rcu_sync_torture_init,
@@ -927,11 +922,8 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_torture_read_unlock_trivial,
 	.get_gp_seq	= rcu_no_completed,
-	.deferred_free	= rcu_tasks_rude_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_rude,
 	.exp_sync	= synchronize_rcu_tasks_rude,
-	.call		= call_rcu_tasks_rude,
-	.cb_barrier	= rcu_barrier_tasks_rude,
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
 	.get_gp_data	= rcu_tasks_rude_get_gp_data,
 	.cbflood_max	= 50000,
-- 
2.40.1

