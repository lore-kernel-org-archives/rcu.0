Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F8236A64;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=gnDWzYzaTyOo4xEONRIZULcb93gXKNzp9sFaz7fNS5xHkcQomK9yih+bkOARCGQo0iSA0hZ1kSSzzpsCw2eoumb2zK4aG9SoqxGxoEsME4dLP+lSnUo24Ew/Q/GCb6wEOmf48FZz/rkNdMcUC69UT5zzJMHkr6GEl9+gQMExh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=llFo4LYRbOuDKXW49Xlffc6rJzI12H86h8RHpABsdnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXW5L4AsvRZUDNGg+3srDUlYciYocD+i71A+UNRrNPlLzIgQhVLKlaOwEkwR7n6Yfo7LRxMJM2+esO/Zey4nOwZZqkQBHmlyzN7qqs9BMPoFKhJvcncuYQmf2glo02U9E5PvhNjpED+2XCmA4HalhZ7/RssajaAh7x4zsxNznus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/jbuhKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/jbuhKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43B9C4CEE6;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058409;
	bh=llFo4LYRbOuDKXW49Xlffc6rJzI12H86h8RHpABsdnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/jbuhKCNzxTuE04nNGyBL9b1VlsbRJ+6UlSoyh8f/Png73slw3dJfiIssubp5H0s
	 m7Stq3zqmrpZuGx+oXXyCHuL3nsLYTI/dfldiipywH16yLYTIvb8115RE/+j93P01d
	 LLqnSv03/uPzAZF3eYlwm1lEjX+TnpKADTKTU2Se6d1faA3ahIgJi4RrFaoIStr8O6
	 vqwDfjeDXcd7Y9uslYwCuqflQLxk0SrT1Gtd/mwmbk4FLGmmSwLr34XZOCPrscyN9M
	 K6SflJYxu+kCQCdCobSPSVC1gZNKlmmE4tGfAyZTEDNEZQKNGhRfzmcPF55BdEKOPp
	 9+iNBnEjcTQHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54015CE37C1; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 5/9] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Thu, 16 Jan 2025 12:13:23 -0800
Message-Id: <20250116201327.3782963-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
References: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
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
index b025e95ede053..f444e8d3f68b4 100644
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

