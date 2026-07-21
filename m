Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21358446BFD
	for <rcu@vger.kernel.org>; Tue, 21 Jul 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627318; cv=none; b=o0PTpJQCrJgUPPJrq2lAamr+k67ZIwW4atXRT5cuAwPb4hhPUyNFf/1S+onAg8OFJ0s9hpJg84VKJ5H2o1uWgnjBP2bhzxxeM1JhyswbmpbRgCAHa1+4VaGft+0FgJsZwS8YZ+J81LgD0zNr5aoBfc6WsJXG3ltgMkPPCEli/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627318; c=relaxed/simple;
	bh=fKvbbPeOHnxFNZhFd55l+6Ynf02jUaf5YImjLvpoSb0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JUO/7EJmns4xriKOz9HmSDRBDck+HlXHdsD82pgt8bgcE0R9DpT8xyMHezO5z7jna+g4l/830AlpREg64+lsWqagB61d7Zr2LqSZowfbsfzA5vRb/viLBRJ4VKHsKB/FcI3/mwXE8LCG8j4OEb6hVftCpjk8xbRelZ9iXxye7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lyv7+LLp; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lyv7+LLp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784627312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=lkHXHSLlXCbzPWG5YPRvkNL6a0OBNolRLqUL8BFOTL4=;
	b=lyv7+LLpfwBfOHit3OT3sHGFA7I8OglVKDf9Q/5Efmlo1tryWZUI/DX03wDUxCnAZ5r1Az
	n7lqHC+xWi0MXk6aOOULZlr2+0JRlXV+eAZjV6stKpBr5DF/wjmJE/Q7DybxU3/ccQHezl
	SBEsIVJdiHOw1G8AHG6AZv4+ldw6ez4=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Fix some comments for call_rcu_tasks() and call_rcu_tasks_rude()
Date: Tue, 21 Jul 2026 17:48:07 +0800
Message-Id: <20260721094807.4957-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The comments for call_rcu_tasks() and call_rcu_tasks_rude() referred
to "RCU read-side critical sections", which is ambiguous. specify
"rcu-tasks" and "rcu-tasks rude" respectively to match the actual
flavor being described.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 35d73f1aa7c4..6d50a9c8e950 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1179,7 +1179,7 @@ static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
  * @func: actual callback function to be invoked after the grace period
  *
  * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
+ * period elapses, in other words after all currently executing rcu-tasks
  * read-side critical sections have completed. call_rcu_tasks() assumes
  * that the read-side critical sections end at a voluntary context
  * switch (not a preemption!), cond_resched_tasks_rcu_qs(), entry into idle,
@@ -1365,8 +1365,8 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * @func: actual callback function to be invoked after the grace period
  *
  * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_tasks_rude()
+ * period elapses, in other words after all currently executing rude
+ * rcu-tasks read-side critical sections have completed. call_rcu_tasks_rude()
  * assumes that the read-side critical sections end at context switch,
  * cond_resched_tasks_rcu_qs(), or transition to usermode execution (as
  * usermode execution is schedulable). As such, there are no read-side
@@ -1390,7 +1390,7 @@ static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
  *
  * Control will return to the caller some time after a rude rcu-tasks
  * grace period has elapsed, in other words after all currently
- * executing rcu-tasks read-side critical sections have elapsed.  These
+ * executing rude rcu-tasks read-side critical sections have elapsed. These
  * read-side critical sections are delimited by calls to schedule(),
  * cond_resched_tasks_rcu_qs(), userspace execution (which is a schedulable
  * context), and (in theory, anyway) cond_resched().
-- 
2.17.1

