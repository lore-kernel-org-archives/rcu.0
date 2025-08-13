Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F787261D
	for <rcu@vger.kernel.org>; Wed, 13 Aug 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091818; cv=none; b=E1RZF4Ev8g86DHulYIOyANYQewUTvJ+/Orw85KXC7p4cjEUkVjDbIBJ2jkxFYp2E7PAxSzq5gXkvX6ClHkfXX3qUOEZzqx/C/17YglbCHhxwrwvSS8jhXQ2xXgk4ZWT+xEbu/O4AWyrLz8GG2XkPD/wJP+11vt5srV5B+opW+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091818; c=relaxed/simple;
	bh=iQ9b0Cb8eF9TBVdPOCV8KSZn7JCwi53K7e/ZpVLsCJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjldiHdX5eN1C7B7+W2jikTuY8dKRoEBOk2VieEJQGUsCifv1aVtCGfSK/iWa1g4tH9Fus3JzwA2/fUt2jOkOe+FuAbqZKge++wBIN0mKZeFskD+gfD0Hvfms2nPlZf0SMwMoT3KG7LLyS/yXbDZ6yL5p+10nPRPdj0skaX1HyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a+Lih0xD; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a+Lih0xD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755091814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zu+JuYXJn+DWqUaruHg9PtZqk5MrbwXE71fqX0qJjiE=;
	b=a+Lih0xDiGZnJDe7EoXbqPfjIdRoFduhJjlyTxerTymULt7RSOa8yH0eENVThqElhFy6M3
	pyPGGL+GZRu4m7lMLBYsDp0aVklV4AkDS0tmm9+OZqW44AaPerkC5UDxEfngsmO0RoxjOD
	aJRCy76/g8yPHU9aa6cXBQXFUrmm8BU=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun.feng@gmail.com,
	urezki@gmail.com
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org
Subject: [PATCH v2] rcu: Remove local_irq_save/restore() in rcu_preempt_deferred_qs_handler()
Date: Wed, 13 Aug 2025 21:30:02 +0800
Message-ID: <20250813133002.331879-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the per-cpu rcu_data structure's->defer_qs_iw is initialized by
IRQ_WORK_INIT_HARD(), this means the rcu_preempt_deferred_qs_handler()
always be executed in the hardirq context of irq-disabled.
This commit therefore remove local_irq_save/restore() operations in
rcu_preempt_deferred_qs_handler() and add lockdep_assert_irqs_disabled()
check, if someone mistakenly invokes this function in hardirq enabled
context will splat.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tree_plugin.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fc14adf15cbb..57e2ae51c0b2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -626,11 +626,10 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
-	unsigned long flags;
 	struct rcu_data *rdp;
 
+	lockdep_assert_irqs_disabled();
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
-	local_irq_save(flags);
 
 	/*
 	 * If the IRQ work handler happens to run in the middle of RCU read-side
@@ -647,8 +646,6 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 */
 	if (rcu_preempt_depth() > 0)
 		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
-
-	local_irq_restore(flags);
 }
 
 /*
-- 
2.48.1

