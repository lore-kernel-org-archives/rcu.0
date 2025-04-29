Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902F2D29CE;
	Tue, 29 Apr 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934199; cv=none; b=XYxB5UkMu9LDDWjW19j9s9KrldZdRVEumgauODphsgpwHDdJq/IBaCsBjZkOaFGUacwTjoziIW2DTq6CYuOluJe9ghCNNXdUpCknxaC1+1Pv7oDPKBCElZpSWW1988XAXRdSVBFreaK6Wr/dYD/CTeyQ1TEqgb4ZYsECEXnI9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934199; c=relaxed/simple;
	bh=LvEdS+axYlVyjNN2L87xRki9bE4HGFdIFlgLzqRz9hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbsCTy2QQbCCMuEjE4KXammipsyqjwbFzTX+h6Jzl3v8cvLLBG7CAnj550HnaTfvYXCkESpAWqeTK1xd8Dt6mJRDRAvAUTCm1ldxDPZYt9kkaFz+1cJ6WTHRQO6pmd3y34VXnPYFAOEZQo9QoxagF75L8sobkEbIlU200ivePWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOIJScua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOIJScua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD579C4CEEF;
	Tue, 29 Apr 2025 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745934198;
	bh=LvEdS+axYlVyjNN2L87xRki9bE4HGFdIFlgLzqRz9hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZOIJScuaU9C52Q+ifn1DYPpGcsSA1pgol9svBU+GOhXoe9pDPk0S0y/DBF7nd4+WX
	 tGQOiCAfDQzep1JPJ7Im70eujuh2QAgXrp6vVomDUR58P/2NuaMg8lKipAh0pOQVi7
	 hxDYKVXXzFm/QN/o3416NULWAT2fFgpKqZWz4gP/hN6ivBvN5Rvsan2lYmmQp4jlCb
	 cGwCBrZzmMR+3l3AVs47C9ckEnNbKpKkPOmHmMN6VXcqYGg0/7oFZspQC417L758IR
	 YvT1Ux3jQkaBk5x7sJ+MA685GdNkjdgAf5uz9a4ES789iOcWioocahdeAJQITEAer1
	 arkvvdo4U0AdQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 3/5] rcu/exp: Remove needless CPU up quiescent state report
Date: Tue, 29 Apr 2025 15:43:02 +0200
Message-ID: <20250429134304.3824863-4-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429134304.3824863-1-frederic@kernel.org>
References: <20250429134304.3824863-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c     |  2 --
 kernel/rcu/tree_exp.h | 45 ++-----------------------------------------
 2 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 90d0214c05c7..5be292667385 100644
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
@@ -4264,7 +4263,6 @@ int rcutree_online_cpu(unsigned int cpu)
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
2.48.1

