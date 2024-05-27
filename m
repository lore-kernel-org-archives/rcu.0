Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DC13AD09;
	Mon, 27 May 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791911; cv=none; b=nFvMF/mo7vyeNwZEIvny/Au8GxyenH4/GNR2t7EDM2+uapgCF4+2UTkifEbN8RMtRY1OMsPiVC3FJyFJnYGckiFpPHlIh9/GBCD6hr87kYgxJQpkgggqKWbbxHFuVaBJ/tOHfu9VJHYMx9NyYoIpRHtpSlZnKr8Bjh/BVKdt9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791911; c=relaxed/simple;
	bh=BVmTMTHIl4VcjgHY9wVIlpHojyLzzqPGNXbUpXRogjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LddIvI77yyfWfWCQkkRFnJbSM+zYzuFjpjCOq8TL0x5wnAJBOx8aUcGp17HM5ujZX6xk/qk30uyYNIhUz7DNYCoeYn2cUQEHNTe54xWxBtsrTw4ZPqk4HdTgZUuTfDaTktyHNg1WrXL+dratjAfk68YReHYZxnGKMIOhmLxWid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbFiw7CL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DqWpYgWn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbFiw7CL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DqWpYgWn"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUJvi+cl+GnqVsi++YuWZL/DyNvN7UuVo3PX6B/yVfw=;
	b=AbFiw7CLQJ1nj4ywxswQa0dzSU2n+uowAMd95BAdErQTiLj35MbBTxJ8Rwv0LXw++ITn4d
	z5pH2QlZ9AaO4Zqyg3XFDAKzYODXH+N9tsqGwwEPQ5r5ZALIJtoi6Tlw3VFCWGTuHZ1AnU
	abb+ycMIEB5Eh68kIkANZc/4U4CveyjlNpdp+XR57G+tH+6bVXGRlRFDgiEhLiyI/78Cn8
	4IwKuL125x2dK87X0uXNKD9EfGE7Eo48wyayFVG5peFp5OsYoEvFLZ9S0pYwjUSrpRGo7j
	uRdXrWqv3zKiumOUGHL5VrI+bfA7xzIzgZIuOG0wLZFwW6yMPCCST0cCEtGV8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUJvi+cl+GnqVsi++YuWZL/DyNvN7UuVo3PX6B/yVfw=;
	b=DqWpYgWnBbiXMTm9JFCIOFAqdixpYrPH/RlzRjAJc/jDdHZGMlbIQks2XV6NTzxHTcU1Pn
	uOSHzlQ2x8XykwAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH printk v6 29/30] rcu: Mark emergency sections in rcu stalls
Date: Mon, 27 May 2024 08:43:48 +0206
Message-Id: <20240527063749.391035-30-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark emergency sections wherever multiple lines of
rcu stall information are generated. In an emergency
section the CPU will not perform console output for the
printk() calls. Instead, a flushing of the console
output is triggered when exiting the emergency section.
This allows the full message block to be stored as
quickly as possible in the ringbuffer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/rcu/tree_exp.h   |  9 +++++++++
 kernel/rcu/tree_stall.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6b83537480b1..94457e36388f 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -7,6 +7,7 @@
  * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/lockdep.h>
 
 static void rcu_exp_handler(void *unused);
@@ -571,6 +572,9 @@ static void synchronize_rcu_expedited_wait(void)
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
+
+		nbcon_cpu_emergency_enter();
+
 		j = jiffies;
 		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
@@ -620,10 +624,14 @@ static void synchronize_rcu_expedited_wait(void)
 				preempt_disable(); // For smp_processor_id() in dump_cpu_task().
 				dump_cpu_task(cpu);
 				preempt_enable();
+				nbcon_cpu_emergency_flush();
 			}
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+
+		nbcon_cpu_emergency_exit();
+
 		panic_on_rcu_stall();
 	}
 }
@@ -792,6 +800,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 */
 		touch_nmi_watchdog();
 		sched_show_task(t);
+		nbcon_cpu_emergency_flush();
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..1ca0826545c1 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,7 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
 
@@ -260,6 +261,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 */
 		touch_nmi_watchdog();
 		sched_show_task(t);
+		nbcon_cpu_emergency_flush();
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
@@ -522,6 +524,7 @@ static void print_cpu_stall_info(int cpu)
 	       falsepositive ? " (false positive?)" : "");
 
 	print_cpu_stat_info(cpu);
+	nbcon_cpu_emergency_flush();
 }
 
 /* Complain about starvation of grace-period kthread.  */
@@ -604,6 +607,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -655,6 +660,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
@@ -675,6 +682,8 @@ static void print_cpu_stall(unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on ourselves...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -703,6 +712,8 @@ static void print_cpu_stall(unsigned long gps)
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	/*
-- 
2.39.2

