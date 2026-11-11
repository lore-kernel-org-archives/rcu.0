Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375358;
	b=GF+sG/woqWC24lmIVahZqj3tkxo4lvX4EVBqg4oXEUTtsbmS+cYMw+ZGSO+6+PBxdyUA
	 uuRfuwAobH3Xp6e48/pa5lW6x65kX2R3J7WfwIgUDC5thqssK5kJ9JkJjegrTkyOv2Y4h
	 KlHhcUJO9ioiIGLmd+WUpzojyDve8B3+BBrHM0tvhEFF+duO8Jn0ObESKJwrNPYEjCUgO
	 I2Cok4N+rygwVtg+/ppN1F/R5tBJZmZ0e1Hg/PQ4aBj0Uy7Ws0wOdbirC8v58/vP8OOfB
	 BgTCvgib30SKuK+Ha4w1+r2Wx73pdR7liYMTaJ/doyD6YrTz9he1XKhM4jACCf/Z/ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AlOVI4d/PmC2P0LcNq83nBnChqQ4tWInDLtYGmrQi7k=;
	b=rGRoWYp6ITEHj0bg/F2dQ32XOPRaGFjYViq1gvJmdksxRs6FLklmxx1S1xORYj9Sx4Pr
	 Mwn539YU2mA/UUt1rsskr7kiQ/WJhjtMhb/KXE9VRCwvyVURNPkpQWdai3l32lj+deOkW
	 yMsc+/dfOhs3DFAi1F+opRLqdLvWqrsYbgyBNHc5pWGRr31QTFR8l9o77aSYwl1QtIE6M
	 lDnrwfD0LDHWUz2HdRh/XXfkNF+OdCHcBgO4UDHE06BeFF4ObRU33q2QWpNfICDxL2C6k
	 ifI57HXcQjjFpIE5IU4xOfDsviqsyS27T9/CK1xL+wXXpPoEWpF1tZvBT3VlRn/Bc8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEqaARNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4C606A31C;
	Wed, 11 Nov 2026 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEqaARNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E331F0089F;
	Wed, 11 Nov 2026 05:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794375357;
	bh=AlOVI4d/PmC2P0LcNq83nBnChqQ4tWInDLtYGmrQi7k=;
	h=From:To:Cc:Subject:Date;
	b=OEqaARNZkqEx+i4XhyraBVxOnG+gYMMjxqZQ22YA9vbUF3MI9SKCp3OP3I2Ty7vJn
	 z6ZOyuh0RLOKOsrbe9tWFoEU1RcaLMhmxgxr+aim6N6SMERx6+teo4w28lYZFbIpLD
	 ohtV9B50I55TCGDKIS/MAEpAM5Ww+DEsczlDwqkmoMGzlL2OMvQWy8wjjvFigN8vRb
	 xdHnwnq7U3Da/ig+C3rG9eHeh+9g1uEoZg50/Ev/fZJTCsLYjTqBk55O9cvYpLB2Sr
	 aRQnz3LO+djRI2m3LYJZaSO767GDOzRhhbSr1gEidHuUvz6+R6+/ciwJJGZRW0idBA
	 f0nP3dIv//DnQ==
From: Song Liu <song@kernel.org>
To: rcu@vger.kernel.org,
	paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	leitao@debian.org,
	david.dai@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH] rcu-tasks: Use pr_debug() for callback contend/collapse messages
Date: Tue, 10 Nov 2026 21:35:51 -0800
Message-ID: <20261111053551.3367903-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5de907d24919 ("rcu-tasks: Disable callback contend/collapse
messages by default") added the rcupdate.rcu_task_collapse_debug module
parameter to gate the three pr_info() messages that report RCU Tasks
switching between CPU-0 and per-CPU callback queuing.

The kernel already has a mechanism for debug-only messages that are off
by default: pr_debug().  Use pr_debug() for these messages, and remove
the rcu_task_collapse_debug module parameter, its documentation, and
its boot-time announcement.

The messages stay off by default.  On CONFIG_DYNAMIC_DEBUG=y kernels,
they can be enabled at boot with:

  dyndbg="file kernel/rcu/tasks.h +p"

or at runtime with:

  echo 'file kernel/rcu/tasks.h +p' > /proc/dynamic_debug/control

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 -------
 kernel/rcu/tasks.h                              | 15 +++------------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..176648941aec 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6369,13 +6369,6 @@ Kernel parameters
 			period to instead use normal non-expedited
 			grace-period processing.
 
-	rcupdate.rcu_task_collapse_debug= [KNL]
-			Enable debugging prints that record when RCU Tasks
-			and RCU Tasks Trace expand to per-CPU callback
-			queuing and collapse back to CPU-0 queuing.
-			This is default-disabled due to the fact that
-			some workloads can make it quite noisy.
-
 	rcupdate.rcu_task_collapse_lim= [KNL]
 			Set the maximum number of callbacks present
 			at the beginning of a grace period that allows
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fcac7361ec51..743f777b4c18 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -178,8 +178,6 @@ static int rcu_task_contend_lim __read_mostly = 100;
 module_param(rcu_task_contend_lim, int, 0444);
 static int rcu_task_collapse_lim __read_mostly = 10;
 module_param(rcu_task_collapse_lim, int, 0444);
-static bool rcu_task_collapse_debug __read_mostly;
-module_param(rcu_task_collapse_debug, bool, 0644);
 static int rcu_task_lazy_lim __read_mostly = 32;
 module_param(rcu_task_lazy_lim, int, 0444);
 
@@ -392,8 +390,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
 			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
 			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
-			if (data_race(rcu_task_collapse_debug))
-				pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
+			pr_debug("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
@@ -514,9 +511,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			gpdone = false;
-			if (data_race(rcu_task_collapse_debug))
-				pr_info("Starting switch %s to CPU-0 callback queuing.\n",
-					rtp->name);
+			pr_debug("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
@@ -524,9 +519,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
 			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
-			if (data_race(rcu_task_collapse_debug))
-				pr_info("Completing switch %s to CPU-0 callback queuing.\n",
-					rtp->name);
+			pr_debug("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
 		if (rtp->percpu_dequeue_lim == 1) {
 			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
@@ -711,8 +704,6 @@ static void __init rcu_tasks_bootup_oddness(void)
 		pr_info("\tTasks-RCU CPU stall info multiplier clamped to %d (rcu_task_stall_info_mult).\n", rtsimc);
 		rcu_task_stall_info_mult = rtsimc;
 	}
-	if (rcu_task_collapse_debug)
-		pr_info("\tTasks-RCU callback contend/collapse debug enabled.\n");
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_RCU
 	pr_info("\tTrampoline variant of Tasks RCU enabled.\n");
-- 
2.53.0-Meta

