Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12028D8D5;
	Wed,  9 Jul 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057601; cv=none; b=k/SitUqwDJek22m9QPTkEIBvObgFe05zI6Gbzkae+8MqKMLHKnGWQREI1ZVB3S7iMVkOT08dZPH0Civ9OZFj3YH0nKTnkO4PrHOurALZ+8cw3AexVfmW+P74HQ/e0rFVOuAD2+BKxZvQ1vuHiepm+YfOvgVGBPnc6XFbyPsDbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057601; c=relaxed/simple;
	bh=d0jNauGDQgc7MQrmLvQ3Mcsdm9lf6ZQmo/JtMesLTDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzZj/AiJfvyhx+vcm2uwMYF+ephixhmv752Dub+dcQBBRnsH7JEFhg7PFX44EK9gS5FNUgy027VyIMf2v5b5T/MFEWFpO+l/5L0IuEEWlg2rGdm+qCauzI0sZC3SBT3wnUcBJZfCoJ6ei8E927mJ7kTUN+tliZKxjOwox9poGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKJTddOw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKJTddOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0656C4CEF4;
	Wed,  9 Jul 2025 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057601;
	bh=d0jNauGDQgc7MQrmLvQ3Mcsdm9lf6ZQmo/JtMesLTDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKJTddOwwjfnAUWDCR9ajJk9gz84/1RgTjYn80d3gMlI/LuwMa2OvtOY86Rwe2+I/
	 SCB+LvlZ+pxzur8alaWG4ZZB4dtLfjDZLmFQXBeIAIFlrAMLrGas8nsNAp130U/RPD
	 Z65SiKVsbT91kuRSnZ5t+6vLFu8tZ+ui+M9bZnTNvhKqg5jVytPM6fToFPAB5zhkfa
	 fb8xFiMyhX89tK15gYkMF4ylr3eDNKoRqAe3ROCHdU+ky9EEr5pon/MbJAZM2IGK0a
	 tf/dYwdNf44+JHll4tMZMUpdV4W/yDzc0yi8VuEBoRY8+bteEFSRHTQZnF1UrqfHhd
	 TjbPF+ZD0Xp4w==
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
Subject: [PATCH rcu 3/5] rcu/exp: Remove needless CPU up quiescent state report
Date: Wed,  9 Jul 2025 16:09:07 +0530
Message-Id: <20250709103909.15498-4-neeraj.upadhyay@kernel.org>
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

A CPU coming online checks for an ongoing grace period and reports
a quiescent state accordingly if needed. This special treatment that
shortcuts the expedited IPI finds its origin as an optimization purpose
on the following commit:

	338b0f760e84 (rcu: Better hotplug handling for synchronize_sched_expedited()

The point is to avoid an IPI while waiting for a CPU to become online
or failing to become offline.

However this is pointless and even error prone for several reasons:

* If the CPU has been seen offline in the first round scanning offline
  and idle CPUs, no IPI is even tried and the quiescent state is
  reported on behalf of the CPU.

* This means that if the IPI fails, the CPU just became offline. So
  it's unlikely to become online right away, unless the cpu hotplug
  operation failed and rolled back, which is a rare event that can
  wait a jiffy for a new IPI to be issued.

* But then the "optimization" applying on failing CPU hotplug down only
  applies to !PREEMPT_RCU.

* This force reports a quiescent state even if ->cpu_no_qs.b.exp is not
  set. As a result it can race with remote QS reports on the same rdp.
  Fortunately it happens to be OK but an accident is waiting to happen.

For all those reasons, remove this optimization that doesn't look worthy
to keep around.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c     |  2 --
 kernel/rcu/tree_exp.h | 45 ++-----------------------------------------
 2 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 14d4499c6fc3..0bda23fec690 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -160,7 +160,6 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
-static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
@@ -4268,7 +4267,6 @@ int rcutree_online_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return 0; /* Too early in boot for scheduler work. */
-	sync_sched_exp_online_cleanup(cpu);
 
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2fa7aa9155bd..6058a734090c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -751,12 +751,8 @@ static void rcu_exp_handler(void *unused)
 	struct task_struct *t = current;
 
 	/*
-	 * First, is there no need for a quiescent state from this CPU,
-	 * or is this CPU already looking for a quiescent state for the
-	 * current grace period?  If either is the case, just leave.
-	 * However, this should not happen due to the preemptible
-	 * sync_sched_exp_online_cleanup() implementation being a no-op,
-	 * so warn if this does happen.
+	 * WARN if the CPU is unexpectedly already looking for a
+	 * QS or has already reported one.
 	 */
 	ASSERT_EXCLUSIVE_WRITER_SCOPED(rdp->cpu_no_qs.b.exp);
 	if (WARN_ON_ONCE(!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
@@ -803,11 +799,6 @@ static void rcu_exp_handler(void *unused)
 	WARN_ON_ONCE(1);
 }
 
-/* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
-static void sync_sched_exp_online_cleanup(int cpu)
-{
-}
-
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
  * sections, printing out the tid of each that is blocking the current
@@ -885,38 +876,6 @@ static void rcu_exp_handler(void *unused)
 	rcu_exp_need_qs();
 }
 
-/* Send IPI for expedited cleanup if needed at end of CPU-hotplug operation. */
-static void sync_sched_exp_online_cleanup(int cpu)
-{
-	unsigned long flags;
-	int my_cpu;
-	struct rcu_data *rdp;
-	int ret;
-	struct rcu_node *rnp;
-
-	rdp = per_cpu_ptr(&rcu_data, cpu);
-	rnp = rdp->mynode;
-	my_cpu = get_cpu();
-	/* Quiescent state either not needed or already requested, leave. */
-	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
-	    READ_ONCE(rdp->cpu_no_qs.b.exp)) {
-		put_cpu();
-		return;
-	}
-	/* Quiescent state needed on current CPU, so set it up locally. */
-	if (my_cpu == cpu) {
-		local_irq_save(flags);
-		rcu_exp_need_qs();
-		local_irq_restore(flags);
-		put_cpu();
-		return;
-	}
-	/* Quiescent state needed on some other CPU, send IPI. */
-	ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
-	put_cpu();
-	WARN_ON_ONCE(ret);
-}
-
 /*
  * Because preemptible RCU does not exist, we never have to check for
  * tasks blocked within RCU read-side critical sections that are
-- 
2.40.1

