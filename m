Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BD1C5480;
	Thu, 26 Dec 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735255871; cv=none; b=VYFziTjjh86gceeJgusmDaTlzVf0nH2Idj0o2HyUxoVnxpYtOLthI4RZ02BJq4clI4xsw1CoVK8RsbAbTWKBYCBlkQS9EIBWC+5OaMGENLtn/xasC5LFDAM2UFSp+EfPyjeX916d8ZltN1XXG0VXhb/76gG2YjGDL81686qlP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735255871; c=relaxed/simple;
	bh=4XJlEJ9fVTK9tGXPB9PrIK7zHpQ6Tjt7QYAknW3KOxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4j0+1paAYEc8vsk+HFSDRf6qMOMWOlsD61Ldb9qUy9UoqcUV2fen6mKxaN67L2YXViKJWxR5qVY7biOTK8O+XrCL/N+x7aUBiBCa+54uFrpuaTdRYXsx94qe3PkyGKIj//YKvIWQqg1ECp5k4tuACMp/5LLDgip02O8TsSS50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQoFprd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQoFprd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADF7C4CED7;
	Thu, 26 Dec 2024 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735255870;
	bh=4XJlEJ9fVTK9tGXPB9PrIK7zHpQ6Tjt7QYAknW3KOxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQoFprd7WFBDPOi+cZV4xpnqqxBVFos/iC1PpxabBni55tTZ6C4ygFWjLgfg8Ld7F
	 HmFI1qgShsCCg96ApnfdIOHJJWTU5k7njU6IgG0T4QAaqRZkc/zwyBaHvjWb5ArDVN
	 BaOQ+BjiZB9pldicojvXSoe4RCazn9h93px/d7Y6jg14qWLdyd/ZlRQ+//lChQ2OhO
	 WUDQovStdTFFqcpK86GmQP48Qqqbfn0mjEcBFKmuUvl3kJjvF7kXT+5lnU5wiw9o30
	 aIm22sO3Yw4izIuyGkzRLYA903cn63P1DL+TrSqKCsn6nrw5FhqLwKTNkEfMejgOkX
	 4wia2I4qviMBw==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	vlad.wing@gmail.com,
	rcu@vger.kernel.org,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	urezki@gmail.com,
	qiang.zhang1211@gmail.com,
	Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 2/3 v2] rcu: Remove swake_up_one_online() bandaid
Date: Fri, 27 Dec 2024 00:30:51 +0100
Message-ID: <20241226233052.145450-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241226233052.145450-1-frederic@kernel.org>
References: <20241226233052.145450-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's now ok to perform a wake-up from an offline CPU because the
resulting armed scheduler bandwidth hrtimers are now correctly targeted
by hrtimer infrastructure.

Remove the obsolete hackerry.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 34 +---------------------------------
 kernel/rcu/tree_exp.h  |  2 +-
 kernel/rcu/tree_nocb.h |  2 +-
 3 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff98233d4aa5..7c433c6b35ea 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1061,38 +1061,6 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 	return needmore;
 }
 
-static void swake_up_one_online_ipi(void *arg)
-{
-	struct swait_queue_head *wqh = arg;
-
-	swake_up_one(wqh);
-}
-
-static void swake_up_one_online(struct swait_queue_head *wqh)
-{
-	int cpu = get_cpu();
-
-	/*
-	 * If called from rcutree_report_cpu_starting(), wake up
-	 * is dangerous that late in the CPU-down hotplug process. The
-	 * scheduler might queue an ignored hrtimer. Defer the wake up
-	 * to an online CPU instead.
-	 */
-	if (unlikely(cpu_is_offline(cpu))) {
-		int target;
-
-		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
-					 cpu_online_mask);
-
-		smp_call_function_single(target, swake_up_one_online_ipi,
-					 wqh, 0);
-		put_cpu();
-	} else {
-		put_cpu();
-		swake_up_one(wqh);
-	}
-}
-
 /*
  * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
  * interrupt or softirq handler, in which case we just might immediately
@@ -1117,7 +1085,7 @@ static void rcu_gp_kthread_wake(void)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
-	swake_up_one_online(&rcu_state.gp_wq);
+	swake_up_one(&rcu_state.gp_wq);
 }
 
 /*
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fb664d3a01c9..17b1a5e3590c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -200,7 +200,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 		if (rnp->parent == NULL) {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			if (wake)
-				swake_up_one_online(&rcu_state.expedited_wq);
+				swake_up_one(&rcu_state.expedited_wq);
 
 			break;
 		}
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2605dd234a13..a43141a1b3a5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -216,7 +216,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 	if (needwake) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
-		swake_up_one_online(&rdp_gp->nocb_gp_wq);
+		swake_up_one(&rdp_gp->nocb_gp_wq);
 	}
 
 	return needwake;
-- 
2.46.0

