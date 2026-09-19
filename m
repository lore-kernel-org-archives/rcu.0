Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D522F7F0F;
	Sat, 19 Sep 2026 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777746; cv=none; b=DqCwTbEFf5fuSoBd2medooM6X78G+6Or53cCfxBMxFAS8U7co2UPqyncDFxglIJI6QXxc7WmtJTFmgsaHxdAqJEXvYFpYM2DOQzFaIOWmC0ZM2RD/yUN7FJBNskDENppOUBMbmtrMDFpkhulKkHlcSvkX4s2tGXxpUmq1tAmqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777746; c=relaxed/simple;
	bh=26DQof4abq0A0FqoOfdASAizC1uaVXPCIahuYEVs5Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDGa9ap7cm6fQ2FTg1WnEUWWbqWftCYfIx7WVPT3tSnzH5LDeCo9OKC32hzjFiRXpP+cnJFKrMoE7zlChJ4vV2gyqN9cIkP8McSccd7J+EB/jX4COUZqJjp5FvCPZXEA1OhfR4Tmv8UVg0/57N0Fx+Bx3wWymOyE5LSUcVbCJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcwwq01I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcwwq01I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E031F008A1;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=k511k02gfCtWdG2Iun8JhOui94P6oaUgfAJhQAFeNR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lcwwq01I7V85W/fBgEp92CFexvHZ7zMlj1P5JEZnYcSBC/3b70bNK3zmePSWOhJJW
	 BTCYi1Pdi+jIrAqw+C1Au+cf2RAzdK5o7160MRDzMcTa1jBDb+AOIEnV4+BpAY5vJJ
	 RGwoAhJpuTbrTKcbiPUjvwXkGzriqspAG8Y6uzmrt/QZO5Q/r43Gv8jqDhzXQ7sk9I
	 EaQNOG1gFt3Q/rYGRJYVyawgvwt7WhaSXY+vo8hdCUaPiLOYgdVPqRPCg4KWpN4r/o
	 TGuxTQoHNNMmVV2xaApHHaCDnw4pdvTX4AH3+g5yNIztJq9v3ViCjOddaeGYf2Hcg7
	 90k/l+g1Bnsqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5CE94CE1887; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	David Dai <david.dai@linux.dev>
Subject: [PATCH 9/9] rcu-tasks: Disable callback contend/collapse messages by default
Date: Fri, 18 Sep 2026 17:29:00 -0700
Message-Id: <20260919002900.3134117-9-paulmck@kernel.org>
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

[ paulmck: Apply Breno Leitao feedback. ]

Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: David Dai <david.dai@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 kernel/rcu/tasks.h                              | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 914b65ae9413..6cc6d45b59d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6405,6 +6405,13 @@ Kernel parameters
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
index 627295396cd9..fcac7361ec51 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -178,6 +178,8 @@ static int rcu_task_contend_lim __read_mostly = 100;
 module_param(rcu_task_contend_lim, int, 0444);
 static int rcu_task_collapse_lim __read_mostly = 10;
 module_param(rcu_task_collapse_lim, int, 0444);
+static bool rcu_task_collapse_debug __read_mostly;
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
-- 
2.40.1

