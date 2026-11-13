Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530997;
	b=xianziwRT6ZTkWleokCzEzSe/LXJVyqkrKIVjonmC4+yOzReuYOWtvT0WgTmDCDw348O
	 UOBgRLb1FUKFXSU3y/+ma7NfWoTx33WurLk3mv4iK0UPg6zPdG7oWTP3yMPwdygQfyBgn
	 eHlPYLkll1XwdTvAPBhJ+PMSbBwsMcYonLwnmd1JG6uZgtPoIZVovWYiPZFxTxgtA9kuZ
	 0F/XWg3r5L0b1yZE51UArYd9nf52Fqs2UwgpbUASeawdxj+R8o54Tl4P6P6beWUecJpjL
	 6wjcJiGHwondU3vClRv676jxFRSRlLbH432+zl+WOxOoOQ/ME6y2auSBvfKrfJcEHuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530997;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=by4pnn7UUwtR1dcWkA5l3Hqdi+jnIaBieMR4UKUf5fA=;
	b=1TsmuZB9mRz+joqnYkgFsPcyFm6NIoy223TbGu7yEiFjyJsDq7+skCdEDqtiMWC9oxtu
	 giZQxPLNcYA8lPSasOEFG6Vl4GsBXdHqgWh3FMoXGhApNFZz7uErk8fR7C29vt+KM4DIM
	 tmCPTfv0nRdD4LJKSW0S5EOcxDZ4J51jmxNkDs4iaYZOqmU4W7EakVXV86PngOrqjLnnB
	 X9AW6FnI9ZVpJKRqQy5OGECAZlzfSJCYN42BFdL1cQOtLbQlyb1klDZHWvrHL3WheWyyy
	 A2nmWA65Yw/dqiZr4DGeVocXH5Pp8zbAVQyvFcq3KtjZQqwo9tDVQiJ2imBX/2mXwuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gk9kIc9Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7A660606A89E;
	Fri, 13 Nov 2026 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gk9kIc9Y
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C7FB61F000C5;
	Fri, 13 Nov 2026 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794530997;
	bh=by4pnn7UUwtR1dcWkA5l3Hqdi+jnIaBieMR4UKUf5fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gk9kIc9YfKPN1a+chXmm1fauIHMrlVr/P2bj4SxeKbeQkpToe7imgUW0S8uMk1a7w
	 bV/yDZ8EXQW6RaIzZX/MxuCui/o9E6sCkoXw6s3z/UX58q8Uyu8f5PhKV8SuZnp6cR
	 I2pSjyfpSzxP1n15wynJ0V/3p2+fj3DEwb9OZCg88lI3dngYBNk8Ddf/8s7AUX8kFC
	 Flg4wSK0UreVnLr8/62GQbhtXO6CM8/thpq3FUPMQerebR9PS1kuYARBsyAt1fyRyJ
	 wIeGD9w9CzmxMadKh6UjJhckeKjVTXFYfDVAvyyRJyq3LVhGEa9CTONB3GU1gWztmI
	 K9Q9VUPOq64mA==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: rcu@vger.kernel.org,
	Song Liu <song@kernel.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH for-v7.5 4/5] rcu-tasks: Use pr_debug() for callback contend/collapse messages
Date: Thu, 12 Nov 2026 19:49:43 -0500
Message-ID: <20261113004946.2758197-5-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113004946.2758197-1-jfern@kernel.org>
References: <20261113004946.2758197-1-jfern@kernel.org>
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

From: Song Liu <song@kernel.org>

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
Signed-off-by: Joel Fernandes <jfern@kernel.org>
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
index a59aa8b6ab05..0eec90464d64 100644
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
2.54.0

