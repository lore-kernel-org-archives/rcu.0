Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8F1F0E47;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263324; cv=none; b=dYKDdwiFpzIDB5Oz2GWJi6kOnVeWYNizDocl3ujn/guvKxvQRq/Qe3dpKFHozcU2Ul1ft5tfxqqqanFdtnXN1pSHFWUXBECofyx0Ow9Rwy7KX9yFKPbPzOI6edIkVZGI49rPZZDoUj0Jhtsz/DHPjiPPlUbO0caz15Q9oy5Ivw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263324; c=relaxed/simple;
	bh=6fgztZJ4uUwMxEH3zc+IRUO+CqURXhb/5/6czN/rBXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oU/k164GsAi3/M7IYI4OVz+/P0+SG7uC4ytcd9C3vOWPUqS5nHQ1P6LWr9XxUSQhoO8tC1p2zayA0npNK5MCIfSauqdDYV8KVHd5JBuzgo3ygY0WllQKJhugggOv26gznTN8XN99jzvreETqI/E9Xi2v5SRTeQN+toOIRK++atk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJYY6V5h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJYY6V5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C09C4CEE4;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263324;
	bh=6fgztZJ4uUwMxEH3zc+IRUO+CqURXhb/5/6czN/rBXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJYY6V5hMiFAhmPT4Vpwwnxwl0r93v+ZxUmVVljOG8FwMxckDlpf1A9kZuPiuDXtM
	 jKLMzbO/XUTZdEjkNdCJ0I1jL7Lc4VHgDKudDcVQ3S5asNSXkmi27Zu/vYYlBYVcLN
	 rPnnkQNIOFbNMAuX27astZAvqLcZZPW3BLhJqwo/dMXoCbEUMDbgGTL4g/afTMJ37+
	 lUFHr2SFDBmbLTdSnVzhTMG/y+D4d4ZCtCEtQll7oEEkDzGHjjbhCsbZmrR3lEUCRk
	 N/qt0mVJNwlCW51TDjvSkfE+LuuuoyXBYkZMdT8fIgI0g1WeI0QpBbqUhpN3evR9mA
	 hnNVgFKk4ewtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90B94CE37DF; Thu, 30 Jan 2025 10:55:23 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu v2] 5/9] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Thu, 30 Jan 2025 10:55:18 -0800
Message-Id: <20250130185522.1652093-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
References: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was needed: lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a
read-side critical section or not.

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), we get (PREEMPT_COUNT=y,
PREEMPT_RCU=n). In this configuration cond_resched() is a stub and
does not provide quiescent states via rcu_all_qs().
(PREEMPT_RCU=y provides this information via rcu_read_unlock() and
its nesting counter.)

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b025e95ede05..f444e8d3f68b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -984,13 +984,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      (preempt_count() == HARDIRQ_OFFSET))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding the task preempt count
+		 * (with PREEMPT_COUNT=y). In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.40.1

