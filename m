Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525926AFB;
	Sun,  4 Aug 2024 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732718; cv=none; b=T3/60Y9VYCYCG8G1V9WQgkZW/fzNLiMIISMREQ7eB3XJxjpQRl59onurk2a+xCmXvfsFPs8ODZaQDoEkU85zhh5xZCLMFqcgwZzqUkkGt7HnsIi/CZPtPZE3s8vc8g4ahim40MmGDmqxVqmm20p41IkvmU0xMR5eH5jn/hHMAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732718; c=relaxed/simple;
	bh=/gP8ujgnDmo/PH09xoPdDL8CnHUSID9dOyO0b21i7JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLVtvWvXeTOJBFf5wr/DeXWT6ykcduyUGjOBolQag+fruoIxdIYbbsJjykGsv8HZvbbbq6m1kjhE+NZV0KKpb3u8BFhYDX3Wt+6RNgkYFMpbnuNuaD4zIeLmKIJQG+kgQ0JUdlQxt6o/LwSPn18uQpIS2tSgIHxYuz6t3EaPJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIf7HXDI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suroxdUF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIf7HXDI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suroxdUF"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J3uNsDrypTBncR2y3/sDGkKGKO6SJ0tlRYJyvsQeNQ=;
	b=TIf7HXDIY0ugmmNb4KJw92Zvct+hsyeRHu07SMfhx7m1OdVEvQwyeyOVAkEpzwHkzMJ/qL
	n8cLKA/joazxCvGboBUfsmgkCRv4EyDckVTDIZcUUORy6S81j/v+CUxY6IxGqz/oGlnRUo
	dOOsAZa6Dj2gOV/8nDZ0M5ESfBRZaq8BW+MjbcgNhY3pjMLCZFT8WUgNOdnt5JsalQXkps
	6jAvlwsn17pHLNjrS3wPGrGTnY8ATDlz1d6NoP2whr9TeYe9kcwz9W6UkuWMXKntBrD7Dl
	km2fDLDrBwqcnq0/l5Q1/nefvClFwAfhV8Z1LTEEho/X6tcIQKFjKbrzHNZwWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J3uNsDrypTBncR2y3/sDGkKGKO6SJ0tlRYJyvsQeNQ=;
	b=suroxdUFbfVnC9Q5kzl6xAIA7Od+lvUWGLp/3RKKUwKdfAbRamDIA4OzjF+RMb7YDR1WWp
	hz75EGEgWXGWrIAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH printk v7 34/35] rcu: Mark emergency sections in rcu stalls
Date: Sun,  4 Aug 2024 02:57:37 +0206
Message-Id: <20240804005138.3722656-35-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark emergency sections wherever multiple lines of
rcu stall information are generated. In an emergency
section, every printk() call will attempt to directly
flush to the consoles using the EMERGENCY priority.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/rcu/tree_exp.h   | 7 +++++++
 kernel/rcu/tree_stall.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4acd29d16fdb..f6b35a0585a8 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -7,6 +7,7 @@
  * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/lockdep.h>
 
 static void rcu_exp_handler(void *unused);
@@ -590,6 +591,9 @@ static void synchronize_rcu_expedited_wait(void)
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
+
+		nbcon_cpu_emergency_enter();
+
 		j = jiffies;
 		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
@@ -643,6 +647,9 @@ static void synchronize_rcu_expedited_wait(void)
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+
+		nbcon_cpu_emergency_exit();
+
 		panic_on_rcu_stall();
 	}
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4b0e9d7c4c68..b3a6943127bc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,7 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
 
@@ -605,6 +606,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -657,6 +660,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
@@ -677,6 +682,8 @@ static void print_cpu_stall(unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on ourselves...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -706,6 +713,8 @@ static void print_cpu_stall(unsigned long gps)
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	/*
-- 
2.39.2

