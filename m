Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842D1649C2;
	Tue,  7 May 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074579; cv=none; b=nZ+TJvh8eWYRvRR0BcwfDOSp10v5q9sfKdL8nfVZY824AFtFYlLUYSILG5go/GAPzgZUxUcYladF0yXcBHJ4arblMD+nmKLfF6eI7n8GCEzTHcsGuPoZo0uQRISUSm6UdpRFvhFBmEcrMVH4oz7FleTy/SvkuQosGqiHa0wweGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074579; c=relaxed/simple;
	bh=W6srazA8My9c3VJNvGbQUH5pt6lz0Yqm91b96E1iJC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXX+My/wJe4CwUTHvFasaQWdinaoooG92BGyGJUrbxny/9Gl9wTFT+v7MpjVJiv5vf41Zvv2uHgNrSV72A3wWzchhN1T3zH6BUGiGSeeDoqK/CbarQE80C3U4YXGNi14gayxInv2V1dsJKfzS9ONo6OMbMNTqWYTzJAmsQcDvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF1VS3y7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF1VS3y7"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e1d6166521so42223761fa.1;
        Tue, 07 May 2024 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074575; x=1715679375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDYWUjC6b4I7IdmUpsXl93lsJEyU12nmQdU8PFGVoCc=;
        b=NF1VS3y74I2yWSryeRbp9UTvN2fHopppZkainLRbjt1Ihm6q4zQgNM42tTaRM04w4n
         ma9vYK9js2xUL15EhIC5mPg4dPLK2vBv64iceD+h5a9jz4CmpJK7VibhB7/W9A0WGKZ9
         LgBjyY8HPs4PE7HiaAQ+56buDTHmFi3QiIVXUDukjf1zRTXXTejJJEsuZ6It8lecxI0o
         x5SNkzs20MZNh1kd61geRkxNDfbnyEVJCOnSOt8e8k57FLV7y6LlBbrZrEWB11GGqDjF
         zqwyskSLGWsmneR16CZHl+tVmgojGNiuWW7vo/kBCqvLkL5PsW4PTPk3PfbulNTd5LPp
         6mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074575; x=1715679375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDYWUjC6b4I7IdmUpsXl93lsJEyU12nmQdU8PFGVoCc=;
        b=UlzN6rHJBkKcTWT+ExlWfc2iY4YAmZvsEC2GhFgwmBdBW0u/W9q8Hw8Uh/rgGWEHoh
         QPrlbNtI6Ps74oNffvFmS6HdH0ZPiGswfEAEXlx2rS0rrgeuSx5xlB0Y0aSu8dze8rJe
         jtBdyFo68aoSQMb+HKsLrnodwDeOSVY5jBcWTmlh0d1XUBnxxXJfkcP6N05Sn4P4USy3
         Xor6PFiGwDlT1ng5O8pIa3QAeksQjy9TlycpJSb9aIsHsIlUYMEks58lFVDy8f+wWwdQ
         HHy2FCC3n9EFYGYpgDMwMd3ZI756m8+zS6wP7fRNHhHVIdOhz6EvnF3qsRfqLol+1zGG
         b7ww==
X-Forwarded-Encrypted: i=1; AJvYcCWT/tvILQEDFkfAveyKIOzoWh62DgfQ+ZKZJyFLg1AcHe+/MaG3Ug2b3rQz3uIKjB/JzlDKNdguzVkuLHHLYPGLzHVAm+j1SybrD3LQ
X-Gm-Message-State: AOJu0YxIaYKeW7+9M0PC0tceCc+FoeCXOAhhjJKYXv1u4KFrUMd9pzHe
	wwNacKPi0KsPk2tKboyBu4hZYtLm8Vkyr4ueccuCKJlvpKdy9Fcr
X-Google-Smtp-Source: AGHT+IF5ANK6BXj2T316aF2QXq49wXZTyUybiVKnKcxza7ZVo3XWc+5D77IR8mAefAImTNYRFu4GKQ==
X-Received: by 2002:a2e:9450:0:b0:2e2:88:1205 with SMTP id o16-20020a2e9450000000b002e200881205mr686973ljh.3.1715074574823;
        Tue, 07 May 2024 02:36:14 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:14 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 43/48] rcutorture: Make rcutorture support print rcu-tasks gp state
Date: Tue,  7 May 2024 11:35:25 +0200
Message-Id: <20240507093530.3043-44-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

This commit make rcu-tasks related rcutorture test support rcu-tasks
gp state printing when the writer stall occurs or the at the end of
rcutorture test, and generate rcu_ops->get_gp_data() operation to
simplify the acquisition of gp state for different types of rcutorture
tests.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcu.h        | 20 ++++++++++----------
 kernel/rcu/rcutorture.c | 26 ++++++++++++++++++--------
 kernel/rcu/srcutree.c   |  5 +----
 kernel/rcu/tasks.h      | 21 +++++++++++++++++++++
 kernel/rcu/tree.c       | 13 +++----------
 5 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 86fce206560e..38238e595a61 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -522,12 +522,18 @@ static inline void show_rcu_tasks_gp_kthreads(void) {}
 
 #ifdef CONFIG_TASKS_RCU
 struct task_struct *get_rcu_tasks_gp_kthread(void);
+void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq);
 #endif // # ifdef CONFIG_TASKS_RCU
 
 #ifdef CONFIG_TASKS_RUDE_RCU
 struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
+void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq);
 #endif // # ifdef CONFIG_TASKS_RUDE_RCU
 
+#ifdef CONFIG_TASKS_TRACE_RCU
+void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
+#endif
+
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void tasks_cblist_init_generic(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
@@ -557,8 +563,7 @@ static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
 #endif
 
 #if defined(CONFIG_TREE_RCU)
-void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
-			    unsigned long *gp_seq);
+void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq);
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
 			       unsigned long secs,
@@ -566,8 +571,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
 #else
-static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
-					  int *flags, unsigned long *gp_seq)
+static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
 	*flags = 0;
 	*gp_seq = 0;
@@ -587,20 +591,16 @@ static inline void rcu_gp_set_torture_wait(int duration) { }
 
 #ifdef CONFIG_TINY_SRCU
 
-static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
-					   struct srcu_struct *sp, int *flags,
+static inline void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 					   unsigned long *gp_seq)
 {
-	if (test_type != SRCU_FLAVOR)
-		return;
 	*flags = 0;
 	*gp_seq = sp->srcu_idx;
 }
 
 #elif defined(CONFIG_TREE_SRCU)
 
-void srcutorture_get_gp_data(enum rcutorture_type test_type,
-			     struct srcu_struct *sp, int *flags,
+void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 			     unsigned long *gp_seq);
 
 #endif
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2f43d31fb7a5..85ff8a32f75a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -381,6 +381,7 @@ struct rcu_torture_ops {
 	void (*gp_kthread_dbg)(void);
 	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
+	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.gp_kthread_dbg		= show_rcu_gp_kthreads,
 	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
+	.get_gp_data		= rcutorture_get_gp_data,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -628,6 +630,11 @@ static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
 static struct rcu_torture_ops srcud_ops;
 
+static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	srcutorture_get_gp_data(srcu_ctlp, flags, gp_seq);
+}
+
 static int srcu_torture_read_lock(void)
 {
 	if (cur_ops == &srcud_ops)
@@ -736,6 +743,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.get_gp_data	= srcu_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
@@ -774,6 +782,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.get_gp_data	= srcu_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
@@ -882,6 +891,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.call		= call_rcu_tasks,
 	.cb_barrier	= rcu_barrier_tasks,
 	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
+	.get_gp_data	= rcu_tasks_get_gp_data,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -922,6 +932,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.call		= call_rcu_tasks_rude,
 	.cb_barrier	= rcu_barrier_tasks_rude,
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
+	.get_gp_data	= rcu_tasks_rude_get_gp_data,
 	.cbflood_max	= 50000,
 	.fqs		= NULL,
 	.stats		= NULL,
@@ -974,6 +985,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
 	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
+	.get_gp_data    = rcu_tasks_trace_get_gp_data,
 	.cbflood_max	= 50000,
 	.fqs		= NULL,
 	.stats		= NULL,
@@ -2264,10 +2276,8 @@ rcu_torture_stats_print(void)
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
-		rcutorture_get_gp_data(cur_ops->ttype,
-				       &flags, &gp_seq);
-		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
-					&flags, &gp_seq);
+		if (cur_ops->get_gp_data)
+			cur_ops->get_gp_data(&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
 		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
 			 rcu_torture_writer_state_getname(),
@@ -3390,8 +3400,8 @@ rcu_torture_cleanup(void)
 		fakewriter_tasks = NULL;
 	}
 
-	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
-	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	if (cur_ops->get_gp_data)
+		cur_ops->get_gp_data(&flags, &gp_seq);
 	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
 		 cur_ops->name, (long)gp_seq, flags,
 		 rcutorture_seq_diff(gp_seq, start_gp_seq));
@@ -3762,8 +3772,8 @@ rcu_torture_init(void)
 			nrealreaders = 1;
 	}
 	rcu_torture_print_module_parms(cur_ops, "Start of test");
-	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
-	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	if (cur_ops->get_gp_data)
+		cur_ops->get_gp_data(&flags, &gp_seq);
 	start_gp_seq = gp_seq;
 	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
 		 cur_ops->name, (long)gp_seq, flags);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e4d673fc30f4..bc4b58b0204e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1826,12 +1826,9 @@ static void process_srcu(struct work_struct *work)
 	srcu_reschedule(ssp, curdelay);
 }
 
-void srcutorture_get_gp_data(enum rcutorture_type test_type,
-			     struct srcu_struct *ssp, int *flags,
+void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
 			     unsigned long *gp_seq)
 {
-	if (test_type != SRCU_FLAVOR)
-		return;
 	*flags = 0;
 	*gp_seq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
 }
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 147b5945d67a..a1af7dadc0f7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1178,6 +1178,13 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
 
+void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_get_gp_data);
+
 /*
  * Protect against tasklist scan blind spot while the task is exiting and
  * may be removed from the tasklist.  Do this by adding the task to yet
@@ -1358,6 +1365,13 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_rude_gp_kthread);
 
+void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
+
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
@@ -2010,6 +2024,13 @@ struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
 
+void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
+
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d9642dd06c25..60e79ed73700 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -508,17 +508,10 @@ static struct rcu_node *rcu_get_root(void)
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
-void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
-			    unsigned long *gp_seq)
+void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
-	switch (test_type) {
-	case RCU_FLAVOR:
-		*flags = READ_ONCE(rcu_state.gp_flags);
-		*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
-		break;
-	default:
-		break;
-	}
+	*flags = READ_ONCE(rcu_state.gp_flags);
+	*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
-- 
2.39.2

