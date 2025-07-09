Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED828D8D6;
	Wed,  9 Jul 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057614; cv=none; b=sVcNG+VxDpUXlrAnzcVp3sZzEb+283Wbg1VDKnrOQepUSN1bRdTb9G/qB6X+4LRTz8zodhDrES9+qAVKxrUwu916mKMF9NhMrh838HAizVagjY4Nnm7Rg8Cq/+0AMx3oJrZ+SGkSaKL1VXe4WO0SDYYDsc4W1c1cWE39QkmuO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057614; c=relaxed/simple;
	bh=C0U4dlo4faHf+FVuL2gY/gpjRyDf6ZQoyRlsTiHuD7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUo0RT0w3WDlJkOTjhsPRHCyj0FyjMBcHa1tqsrEObdVubP0u/O0YYC1KOoQpEcT+zE+bjS6QdNX1sSBFAdEU1JPHuswa2xaELhzcZQU3w28P6lSYKxmyxCGhPps35gmYOb9TNn5j7BkHINoATz0VPaiczaynfBuBbBYkN7+2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orse9NAH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orse9NAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626EFC4CEEF;
	Wed,  9 Jul 2025 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057613;
	bh=C0U4dlo4faHf+FVuL2gY/gpjRyDf6ZQoyRlsTiHuD7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orse9NAH1bs2QKfRJs5XM7Q5p1aWBq1YhoYwHYRl2cQVnsfepgJsDFy3kgA7GpmoT
	 Jo4vC6HT1coJ740sk7NEGJ1/YPW+l2pkUMnrOnvEYRIpAs18CKZttxks5JY/hjolmo
	 jf0G9IC/3EsIY9DeeyrrRl5+jCHP3v1bS+gIM+juD3m7ouzTsl9zF3cmhND5d1m3Fg
	 Px6D/T+yX6FOJB3eefi9/scy0kFSIeOV6e1bTZkLU5r4156LUjQ1m9Btk4AbGJeWqW
	 dpvwfmuKxJqDzxFXRxXqPJWYe0QxOJAaK1Ezh+/r09T1beW9JMjKI4p/dQfX4Q1ZAW
	 q36RjJoQz0+aA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 5/5] rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot
Date: Wed,  9 Jul 2025 16:09:09 +0530
Message-Id: <20250709103909.15498-6-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709103909.15498-1-neeraj.upadhyay@kernel.org>
References: <20250709103909.15498-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

A CPU within hotplug operations can make the RCU exp kworker lagging if:

* The dying CPU is running after CPUHP_TEARDOWN_CPU but before
  rcutree_report_cpu_dead(). It is too late to send an IPI but RCU is
  still watching the CPU. Therefore the exp kworker can only wait for
  the target to reach rcutree_report_cpu_dead().

* The booting CPU is running after rcutree_report_cpu_starting() but
  before set_cpu_online(). RCU is watching the CPU but it is too early
  to be able to send an IPI. Therefore the exp kworker can only wait
  until it observes the CPU as officially online.

Such a lag is expected to be very short. However #VMEXIT and other
hazards can stay on the way. Report long delays, 50 jiffies is
considered a high threshold already.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[neeraj: Change max retries to 50 jiffies]
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_exp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6058a734090c..076ad61e42f4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -406,8 +406,18 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 		unsigned long mask = rdp->grpmask;
+		int nr_retries = 0;
 
 retry_ipi:
+		/*
+		 * In case of retrying, CPU either is lagging:
+		 *
+		 * - between CPUHP_TEARDOWN_CPU and rcutree_report_cpu_dead()
+		 * or:
+		 * - between rcutree_report_cpu_starting() and set_cpu_online()
+		 */
+		WARN_ON_ONCE(nr_retries++ > 50);
+
 		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
 			mask_ofl_test |= mask;
 			continue;
-- 
2.40.1

