Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843632DF132;
	Thu, 16 Jul 2026 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161529; cv=none; b=gl23ZYRDBaqdyBAvw0Q3tnSSsvKBQx4aVrgUhjd7wUAj+Kgvmw5T+6lUffuShaGAdlZdvZm+UG4zdEaDgkd2A0oT2czwY0YT0UgdJiWF7l/VDBWjLqFqMPIDHSB0S8uEktvwbUfZunOfYMxCEissB/uWV5AfY0AVfFdCgi4hB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161529; c=relaxed/simple;
	bh=sJ1SVhaxvni9Qc07RTKJ5sYtAbxY3Aea5ZR37XYDRFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wn60vyFdtu8HZ9M3pO+ZUjbO/yyAo5kDMEr+Rh4hNJ4mNMa0/54J8YAdqD9wHm2uxUTAveTb3DEPHbb9OojilPaiCf9Wg1o9orx+7fAE0MQM1CHiXq3n5yY1cfRULJbIw5L/II77QEAwYZsY35KcmonsTwtbBe+xFc2p/p6S3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNjCBeBJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNjCBeBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30D51F00ADE;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161522;
	bh=kYqIhYGIkpcAhqxrRXz1I/HJj9abQVlfXFliDeZQqpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YNjCBeBJrzmKBPL8C3q5j9b+/rGhRprL+YIM79RHYWIjv/kk9cZZCx5giq9DxbEFi
	 rHT4TouManOQm5lU8KHYvVxAArxIm6a/ajYAJxB8alWJMDbN0VOai6ftY3QxpI72hS
	 VHxn9GHcuSc4Yqci0FsEvPxkJzki5zbcP9WTMD/b3q4DeaKjOJOZnEdDt2oIHhyfyj
	 5nGQ7OH8sT9tBxP5gGNaR4/AA/2L2tuMUrvCuDbK/c4tw73/HC8PGoqW4GIA4MT2zy
	 0Z4cpPMcnKJL7V4vl6W27DqqXJJmeH7UjDqohLr2+Y13GRQa34oh8JdkidCmC+rP0r
	 pA3Y1fnBj5cXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8410ECE0E5D; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 09/11] rcutorture: Test RCU Tasks Trace GP implying RCU GP
Date: Wed, 15 Jul 2026 17:25:18 -0700
Message-Id: <20260716002520.11895-9-paulmck@kernel.org>
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

An RCU Tasks Trace grace period is supposed to imply an RCU grace period,
and this implication is relied on by BPF.  But this is not currently
tested.  This commit therefore makes tasks_tracing_torture_read_lock()
sometimes use rcu_read_lock() instead of rcu_read_lock_trace(), thus
testing the required implication.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a0d27756141846..c8118c38812aee 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -766,11 +766,12 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	const long uspertick = 1000000 / HZ;
 	const long longdelay = 10;
 
-	/* We want there to be long-running readers, but not all the time. */
+	// We want there to be long-running readers, but not all the time.
+	// The !rcu_preempt_depth() is for RCU Tasks Trace.
 
 	delay = torture_random(rrsp) %
 		(nrealreaders * 2 * longdelay * uspertick);
-	if (!delay && in_task() && !irqs_disabled()) {
+	if (!delay && !in_atomic() && !rcu_preempt_depth() && !irqs_disabled()) {
 		schedule_timeout_interruptible(longdelay);
 		rtrsp->rt_delay_jiffies = longdelay;
 	} else {
@@ -1219,15 +1220,24 @@ static struct rcu_torture_ops tasks_rude_ops = {
  * Definitions for tracing RCU-tasks torture testing.
  */
 
+// Note that an RCU Tasks Trace GP must imply an RCU GP.
 static int tasks_tracing_torture_read_lock(void)
 {
-	rcu_read_lock_trace();
-	return 0;
+	int use_rcu = !(jiffies & 0xff);
+
+	if (use_rcu)
+		rcu_read_lock();
+	else
+		rcu_read_lock_trace();
+	return use_rcu;
 }
 
-static void tasks_tracing_torture_read_unlock(int idx)
+static void tasks_tracing_torture_read_unlock(int use_rcu)
 {
-	rcu_read_unlock_trace();
+	if (use_rcu)
+		rcu_read_unlock();
+	else
+		rcu_read_unlock_trace();
 }
 
 static void rcu_tasks_tracing_torture_deferred_free(struct rcu_torture *p)
-- 
2.40.1

