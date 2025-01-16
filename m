Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BB234D00;
	Thu, 16 Jan 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057946; cv=none; b=tSZ096OAhX7oiZNBL3PzXwxWNH0YDVFFJcTi5j/ah5uCebyQ/KX/5Od8S3wikDkvv4ae32MIeFk0yV8+1+iYcuV+F3mKZ1V/WiWIFNCIXDijijVoafdFxt5n+t51YgLBzeHJ/gREojI0wkt2csenNZNb+zx6t8nY89zq6y+9RCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057946; c=relaxed/simple;
	bh=yHSEYo1yMi2XoWvkgiqu3Uvnki/MK7OFLB78k2z+u9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5SfBDTgNzJUOJHjUT4xgCfP1ip3sqfi73pjQbkigH0gnIcAOQvMkvpfO26dW0tJU7XNu4Tnnky/r7AYMtdEpGVekWy3nFyMfopKKSDzcNCLPQS+iIxXKPM4Sl5xQO75dj/GovTP1vxLaome64cFaP6oJcOsYmSJtWXWoCGDzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPVNSuvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPVNSuvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672EAC4AF0B;
	Thu, 16 Jan 2025 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057945;
	bh=yHSEYo1yMi2XoWvkgiqu3Uvnki/MK7OFLB78k2z+u9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPVNSuvJfNNQoXOHUhovEMHQJXkn2TomzR2GxXijjKLFHVxZ9FJf36cUZQ8LQvdDx
	 3k9PrKWiN/X6lBxclYD+qRDfCByWv1TCcvXF01LQOFfDw2A2fwM96/ajCSbEno9aoA
	 +sBxU0HxNXrgBK49GJyWvAz1ywul3XAMgZJPAw7CCliSKF2RRgOqMhhiW0ntAMYH3G
	 AUI4I/EjYRjC8w+uRwmvHdYRrCnfX9ug07NG7Ne9KvSuDxq3ryXusrqpg+sPUCH4Du
	 XvpkOGaB/KiE2VHV+wg2G5bBktZlzEztyjWYUaE5fpsAJstWMTfbLK+z0pEun5/vHL
	 tDJZWpzYloxAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 09E48CE37B6; Thu, 16 Jan 2025 12:05:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH rcu 4/5] rcu-tasks: Move RCU Tasks self-tests to core_initcall()
Date: Thu, 16 Jan 2025 12:05:42 -0800
Message-Id: <20250116200543.3782539-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
References: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timer and hrtimer softirq processing has moved to dedicated threads
for kernels built with CONFIG_IRQ_FORCED_THREADING=y.  This results in
timers not expiring until later in early boot, which in turn causes the
RCU Tasks self-tests to hang in kernels built with CONFIG_PROVE_RCU=y,
which further causes the entire kernel to hang.  One fix would be to
make timers work during this time, but there are no known users of RCU
Tasks grace periods during that time, so no justification for the added
complexity.  Not yet, anyway.

This commit therefore moves the call to rcu_init_tasks_generic() from
kernel_init_freeable() to a core_initcall().  This works because the
timer and hrtimer kthreads are created at early_initcall() time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>
---
 include/linux/rcupdate.h | 6 ------
 init/main.c              | 1 -
 kernel/rcu/tasks.h       | 5 ++++-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 3bb554723074d..c6c4aee47df2c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -121,12 +121,6 @@ void rcu_init(void);
 extern int rcu_scheduler_active;
 void rcu_sched_clock_irq(int user);
 
-#ifdef CONFIG_TASKS_RCU_GENERIC
-void rcu_init_tasks_generic(void);
-#else
-static inline void rcu_init_tasks_generic(void) { }
-#endif
-
 #ifdef CONFIG_RCU_STALL_COMMON
 void rcu_sysrq_start(void);
 void rcu_sysrq_end(void);
diff --git a/init/main.c b/init/main.c
index 00fac1170294f..fb880b6fb524b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1562,7 +1562,6 @@ static noinline void __init kernel_init_freeable(void)
 
 	init_mm_internals();
 
-	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
 	lockup_detector_init();
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 59314da5eb604..466668eb4fadf 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -2256,7 +2256,7 @@ void __init tasks_cblist_init_generic(void)
 #endif
 }
 
-void __init rcu_init_tasks_generic(void)
+static int __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
 	rcu_spawn_tasks_kthread();
@@ -2272,7 +2272,10 @@ void __init rcu_init_tasks_generic(void)
 
 	// Run the self-tests.
 	rcu_tasks_initiate_self_tests();
+
+	return 0;
 }
+core_initcall(rcu_init_tasks_generic);
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-- 
2.40.1

