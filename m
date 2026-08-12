Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507BF2F9C37;
	Wed, 12 Aug 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500017; cv=none; b=E9GObGJjdMgHxpjMDH5XbgKWYCPsLAIXYzHDo0VIJ+aNSlF88QSAcXQH1nykhji7G1FIB8yRm/6UkKyZknnx3SHA/QgjgRXIdG2CuIGIxhR1qXOvOzTh1IgD43fC6/7nHT0cHLzEfJgk8pmCtT9WpXgI9eqNopZ/AdvUYnhI808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500017; c=relaxed/simple;
	bh=a7BPkV9J42lW3LnH8Mz46/Syaah1BJ/rpTAF4pZx/HA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B1SbahnWChqjHPgWj9H59mfpCL/IJIS6TXIYOcLEsdu60x3q1cDe6sLNC66b6d9D3d/KF/mskHoJ8bjdIgLG2J8qkne/K34PydMPcEFLHq/y6En+deddlaJtAGmTgMHT8WnrUkJW/ZUYwMPyzb5333si6/pAO+vLIQNGzYQD+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4wFqZ4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4wFqZ4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BAC1F000E9;
	Wed, 12 Aug 2026 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786500015;
	bh=7TMUOzQePGuu/SqEPMmcw24ap7Z1MiUnPb2XirHholk=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=g4wFqZ4mnInlJXo4Koq0b1GVrmWwMn7v74EFoT2zI/hAq91xnhwpJ5KmtZxnoY8cA
	 XYBo3vUwheWE9dQeuFkNuzAC8T3WC3Vq1TIK6D1s59jhc4dsewLiuPEAVjsIdLue6u
	 /x2+qTAxp1AXWzE0e5CPzXa95AxoRAh2bwLZGR4fUMVDMPs1CsBf3ER2iBu6SGJ71f
	 KVqr4+U+7T/Eq7ialpl8U9gfBG4ITGjryyOWqtwj1q4OrP+Io5tw77u9InV62TpgF5
	 Cx+i7SKnf+wrDCu/Z2Aqt9ohiSCXt6/Q02gRH4giQ1IA3A2gBlL/lMbXXWdXGnzzbd
	 vF+bAr5m2g/lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC6BFCE17BD; Tue, 11 Aug 2026 19:00:14 -0700 (PDT)
Date: Tue, 11 Aug 2026 19:00:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	David Dai <david.dai@linux.dev>
Subject: [PATCH RFC] rcu-tasks: Disable callback contend/collapse messages by
 default
Message-ID: <eb1c47d9-e694-407f-9e4c-3b7519f4ec46@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

New workloads can do large bursts of call_rcu_tasks() invocations in a
short time period, followed by a quiet time period long enough to drain
all of the callbacks, followed by another burst of call_rcu_tasks()
invocations.  This can cause RCU Tasks to switch back and forth between
queuing callbacks only on CPU 0 (during quiet periods) and on all CPUs
(during bursts).

Which is fine.  Except for the fact that each cycle from CPU-0-only to
all-CPUs queuing and back generates three console messages, one announcing
the shift to all-CPUs queuing, another announcing the start of the shift
back to CPU-0-only queuing, and the third announcing completion of this
shift after an RCU grace period.  And these console messages can overrun
console-log communications channels and obscure other console-message-based
debugging information.  And the only known use for these console messages
is debugging RCU Tasks itself.

This commit therefore adds a rcupdate.rcu_task_collapse_debug module
parameter that defaults to false (suppressing these console messages).
Those debugging or otherwise playing with RCU Tasks callback queuing
auto-adjustment can set this parameter to the value true.

Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: David Dai <david.dai@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

---

 Documentation/admin-guide/kernel-parameters.txt |    7 +++++++
 kernel/rcu/tasks.h                              |   15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6ebc1cd26c7c89..1a98b3b4ac34c7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6427,6 +6427,13 @@ Kernel parameters
 			period to instead use normal non-expedited
 			grace-period processing.
 
+	rcupdate.rcu_task_collapse_debug= [KNL]
+			Enable debugging prints that record when RCU Tasks
+			and RCU Tasks Trace expand to per-CPU callback
+			queuing and collapse back to CPU-0 queuing.
+			This is default-disabled due to the fact that
+			some workloads can make it quite noisy.
+
 	rcupdate.rcu_task_collapse_lim= [KNL]
 			Set the maximum number of callbacks present
 			at the beginning of a grace period that allows
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 627295396cd91d..1150a390f37efa 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -178,6 +178,8 @@ static int rcu_task_contend_lim __read_mostly = 100;
 module_param(rcu_task_contend_lim, int, 0444);
 static int rcu_task_collapse_lim __read_mostly = 10;
 module_param(rcu_task_collapse_lim, int, 0444);
+static bool rcu_task_collapse_debug __read_mostly = false;
+module_param(rcu_task_collapse_debug, bool, 0644);
 static int rcu_task_lazy_lim __read_mostly = 32;
 module_param(rcu_task_lazy_lim, int, 0444);
 
@@ -390,7 +392,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
 			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
 			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
-			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
+			if (data_race(rcu_task_collapse_debug))
+				pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
@@ -511,7 +514,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			gpdone = false;
-			pr_info("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
+			if (data_race(rcu_task_collapse_debug))
+				pr_info("Starting switch %s to CPU-0 callback queuing.\n",
+					rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
@@ -519,7 +524,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
 			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
-			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
+			if (data_race(rcu_task_collapse_debug))
+				pr_info("Completing switch %s to CPU-0 callback queuing.\n",
+					rtp->name);
 		}
 		if (rtp->percpu_dequeue_lim == 1) {
 			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
@@ -704,6 +711,8 @@ static void __init rcu_tasks_bootup_oddness(void)
 		pr_info("\tTasks-RCU CPU stall info multiplier clamped to %d (rcu_task_stall_info_mult).\n", rtsimc);
 		rcu_task_stall_info_mult = rtsimc;
 	}
+	if (rcu_task_collapse_debug)
+		pr_info("\tTasks-RCU callback contend/collapse debug enabled.\n");
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_RCU
 	pr_info("\tTrampoline variant of Tasks RCU enabled.\n");
