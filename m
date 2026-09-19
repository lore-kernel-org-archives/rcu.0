Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA82EB84E;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777743; cv=none; b=uulbjMmI1EdVAW0K32I9HAXxmdtsJqB8ZlRnw78rsB2g74V392lhJj6Uj5ShvchUlLO3VgPnSki+/fY3gvQ4KeXtZn8wQgdFZYfuLx9wuDBa7nTUfeQXj6HUBBg5k5gt5w5LpprzBNoS7N3HOXVBHjsi9y94el7YK2XmE5gIT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777743; c=relaxed/simple;
	bh=jRSA949A5wspjX5p87+QLwsJGx3QqRlWQ+q7KtAGYE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9aKnyrSJ23KEBQOdtdO1JyRu2606nEwzmiQW57AmSl/dpyTKVaj1MTFekrEcXUSFih+KJbpompbvA9DFir1HYoEqGnO8VASbyQYM41GEejjBCqYs9j7G/mtPD4dd9hSlZB+bY/gwnPj2rDMvYKL4zLQ527gxSRTaAsRY1tLJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAIPCaeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAIPCaeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7AB1F00899;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=NfRsui4HeEGNdMbX4Kuk3a2ehlsQZZj6609HvU+UOBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eAIPCaeAlaU+WiFOa/N9bLENaAvute8QCYcs16pOdjZU3IdNWqa+VKbV03f3ebRlN
	 9rrVZI3d07NIZIuSydAMWan2vXUJdMiMPHdUP57gFRTaqpSrfDAH6QqNKCqJq9peF0
	 ysWb3eiGnHRq0GF21Zm+GCrmWSl1bTRbFTLsF05dZIMfvmLBZxMY7/VW7d+ARgBN2J
	 ebb2yIrqTw3f3sZCp/hWiw86M1kE054/VtlDVGc9qhabgMQRwuFRTVJtbJg+xSMP5C
	 hxpdDvAfusq6RBXCrRxZqJFzCCHbrwhjFq0A5KCdNoiyG1VCxFfG/AS1B9yD4jmLP3
	 H9mnuwgxSWdfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D1EBCE17BD; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/9] rcu: Don't panic on already-ended RCU CPU stalls
Date: Fri, 18 Sep 2026 17:28:54 -0700
Message-Id: <20260919002900.3134117-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
References: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current RCU CPU stall-warning code can say "INFO: Stall ended before
state dump start" but then panic the system anyway.  This commit therefore
avoids panicking the system if the stall has already ended.

However, the sched_ext scheduler will still be ejected, as it might have
been the cause of the almost stall.  This can easily be changed if needed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h   |  2 +-
 kernel/rcu/tree_stall.h | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 81d42b6e2e31..01bdbd7e28cc 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -678,7 +678,7 @@ static void synchronize_rcu_expedited_wait(void)
 
 		nbcon_cpu_emergency_exit();
 
-		panic_on_rcu_stall(&rcu_exp_stall_cpumask);
+		panic_on_rcu_stall(&rcu_exp_stall_cpumask, NULL, 0);
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 091e7850ab6e..93ba31a619b6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -159,7 +159,8 @@ static int __init check_cpu_stall_init(void)
 early_initcall(check_cpu_stall_init);
 
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
-static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
+static void panic_on_rcu_stall(const struct cpumask *stalled_mask,
+			       unsigned long *gsp, unsigned long gp_seq)
 {
 	static int cpu_stall;
 
@@ -170,6 +171,11 @@ static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
 	if (scx_rcu_cpu_stall(stalled_mask))
 		return;
 
+	if (gsp && rcu_seq_current(gsp) != gp_seq) {
+		pr_err("INFO: Stall ended before panic check.\n");
+		return;
+	}
+
 	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
 		return;
 
@@ -703,7 +709,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall(&rcu_stall_cpumask);
+	panic_on_rcu_stall(&rcu_stall_cpumask, &rcu_state.gp_seq, gp_seq);
 
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
@@ -758,7 +764,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	cpumask_clear(&rcu_stall_cpumask);
 	cpumask_set_cpu(smp_processor_id(), &rcu_stall_cpumask);
-	panic_on_rcu_stall(&rcu_stall_cpumask);
+	panic_on_rcu_stall(&rcu_stall_cpumask, &rcu_state.gp_seq, gp_seq);
 
 	/*
 	 * Attempt to revive the RCU machinery by forcing a context switch.
-- 
2.40.1

