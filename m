Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2D152181;
	Tue,  7 May 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074544; cv=none; b=GRu9heq8WmjPn5wahgfQ9mVeKUORyu3LzCy8jxdjo0rSk7xfHJCr35L+D9YpFmOWk2YWIt6m3a0939IrNI4gLDSRC3QipeHuKwX1GWkqAnDHU9Z2hqsatP1THuCNki3ua/KcWeYU7nFQRSP2tt7RyVik/DCSNVWyjeWqWKbk+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074544; c=relaxed/simple;
	bh=1pd6CZTByaXHSagaB3Jstn7bSvLFY2rnruSLMRHxzDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0c5CRjK+xGIoDDMURAKe6Rxyxs9PnC6KKHF5Y1s5+avXoJXf4kUYJrTCFz1hnfUV7+NK/Ty9xFb6di/6ssXAniSoxcTz1clB8ltUUShCp1f1FYIsgpAzhSJgYzcLPgmhB5dzS9YRFyJqKNvKnirOd0g09Cqecb451Bwp2vHvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nabvQoMS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nabvQoMS"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e2a4c20870so37450141fa.3;
        Tue, 07 May 2024 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074541; x=1715679341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzO2bnnbUb7qNypPC+CxtK/Lg/bpaDGc7T8gLSepklU=;
        b=nabvQoMSgORpLmkJZ6mXmq1bsrCOtm9j4yZs/XF+Xn8K+0S25T/GP0N2TYIXzm4kO5
         UPAOtYAAjz/jpoCYh3AbS2xNLGtGHN0k4v9AxLmTgkd1MFtm+PC8fIr7SnzM3gPD6YaH
         t4sHW00LMaU/ccdJd47sTgmNYTVcdNmbv5/CKPznHh8A1TN7cGa42ACGpvPuXqb9CALG
         cLUGqWy80m73FuJ8RYzfDC4TE9fCXhPoFvO3UMtFQBosKlmdh5EyoDsM+7XyEb0z4ENX
         s3oUSrzT1lesJaRWwhF+Z7Z7BP4R6U3O6dL8nkYJ7WermqE8cWx0GnVEHhJPpA3J4Run
         xCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074541; x=1715679341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzO2bnnbUb7qNypPC+CxtK/Lg/bpaDGc7T8gLSepklU=;
        b=pb/gpbei4UTdoWSYSvwwW5kYBiKaYS7iGB2nnl9DeaylX9HKcUmJ4EHB+FxLDuuRw2
         WxHugryT5lnW51iN22PVlowM3X6AhD4D1sb0kdHXa0FCv7A7OqMe3h3bJnQwostaPgED
         gsoGcqdHAY+eHPNmK0tv1VckCGAhTrBu/OAiaypP9HvYp7+97R7UNkl7UVLNrkCH/toI
         7ZemMiBOcH1OI7HwDYvNaGfGOrQp4ld1Lzr7r5EfUzsimWsVzOrTL0ajclWmGqONruGn
         3zLPg1veQVtYiOVCzzI/dxMxoRJAWnRiDZOoMPijD8TPFo1t1NYlQ4TwRtPoVXj2UNWb
         bkLw==
X-Forwarded-Encrypted: i=1; AJvYcCWAXhCGYsb1GCHX8UhKJ3iX2qR3fVGAP+2TDPOtzSiA+iv7hLINpBSPRblca1HS0pUY8ngexXnrTIRN7Z3rlQ20UTuoOqAUMDlbd+tf
X-Gm-Message-State: AOJu0YxyOFcYYJWWFDRKaJxqXPaqPYonY30xySXfy3dHhGk6J5wNdu9m
	5EzXz55mvq87YRl+GxE72j3/EwgTjxTMCxRX+G22XCaBNHkTg5qE
X-Google-Smtp-Source: AGHT+IGk4IpW7lK7tqjt58cDW+WdfWWjXdflP1wpka7DMwPhr9TOj4rpi+dt3MiwYN198X6DRzkCDQ==
X-Received: by 2002:a2e:3510:0:b0:2dd:bd92:63a with SMTP id z16-20020a2e3510000000b002ddbd92063amr8237859ljz.34.1715074540489;
        Tue, 07 May 2024 02:35:40 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:40 -0700 (PDT)
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
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 08/48] rcu-tasks: Make Tasks RCU wait idly for grace-period delays
Date: Tue,  7 May 2024 11:34:50 +0200
Message-Id: <20240507093530.3043-9-urezki@gmail.com>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, all waits for grace periods sleep at TASK_UNINTERRUPTIBLE,
regardless of RCU flavor.  This has worked well, but there have been
cases where a longer-than-average Tasks RCU grace period has triggered
softlockup splats, many of them, before the Tasks RCU CPU stall warning
appears.  These softlockup splats unnecessarily consume console bandwidth
and complicate diagnosis of the underlying problem.  Plus a long but not
pathologically long Tasks RCU grace period might trigger a few softlockup
splats before completing normally, which generates noise for no good
reason.

This commit therefore causes Tasks RCU grace periods to sleep at TASK_IDLE
priority.  If there really is a persistent problem, the eventual Tasks
RCU CPU stall warning will flag it, and without the extra noise.

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate_wait.h | 18 +++++++++---------
 kernel/rcu/tasks.h            |  6 +++++-
 kernel/rcu/update.c           |  4 ++--
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index d07f0848802e..303ab9bee155 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -19,18 +19,18 @@ struct rcu_synchronize {
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
-void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
+void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *crcu_array,
 		   struct rcu_synchronize *rs_array);
 
-#define _wait_rcu_gp(checktiny, ...) \
-do {									\
-	call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };		\
-	struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];	\
-	__wait_rcu_gp(checktiny, ARRAY_SIZE(__crcu_array),		\
-			__crcu_array, __rs_array);			\
+#define _wait_rcu_gp(checktiny, state, ...) \
+do {												\
+	call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };					\
+	struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];				\
+	__wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array, __rs_array);	\
 } while (0)
 
-#define wait_rcu_gp(...) _wait_rcu_gp(false, __VA_ARGS__)
+#define wait_rcu_gp(...) _wait_rcu_gp(false, TASK_UNINTERRUPTIBLE, __VA_ARGS__)
+#define wait_rcu_gp_state(state, ...) _wait_rcu_gp(false, state, __VA_ARGS__)
 
 /**
  * synchronize_rcu_mult - Wait concurrently for multiple grace periods
@@ -54,7 +54,7 @@ do {									\
  * grace period.
  */
 #define synchronize_rcu_mult(...) \
-	_wait_rcu_gp(IS_ENABLED(CONFIG_TINY_RCU), __VA_ARGS__)
+	_wait_rcu_gp(IS_ENABLED(CONFIG_TINY_RCU), TASK_UNINTERRUPTIBLE, __VA_ARGS__)
 
 static inline void cond_resched_rcu(void)
 {
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 147b5945d67a..82e458ea0728 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -74,6 +74,7 @@ struct rcu_tasks_percpu {
  * @holdouts_func: This flavor's holdout-list scan function (optional).
  * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
+ * @wait_state: Task state for synchronous grace-period waits (default TASK_UNINTERRUPTIBLE).
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
  * @percpu_enqueue_lim: Number of per-CPU callback queues in use for enqueuing.
@@ -107,6 +108,7 @@ struct rcu_tasks {
 	holdouts_func_t holdouts_func;
 	postgp_func_t postgp_func;
 	call_rcu_func_t call_func;
+	unsigned int wait_state;
 	struct rcu_tasks_percpu __percpu *rtpcpu;
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
@@ -134,6 +136,7 @@ static struct rcu_tasks rt_name =							\
 	.tasks_gp_mutex = __MUTEX_INITIALIZER(rt_name.tasks_gp_mutex),			\
 	.gp_func = gp,									\
 	.call_func = call,								\
+	.wait_state = TASK_UNINTERRUPTIBLE,						\
 	.rtpcpu = &rt_name ## __percpu,							\
 	.lazy_jiffies = DIV_ROUND_UP(HZ, 4),						\
 	.name = n,									\
@@ -638,7 +641,7 @@ static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 
 	// If the grace-period kthread is running, use it.
 	if (READ_ONCE(rtp->kthread_ptr)) {
-		wait_rcu_gp(rtp->call_func);
+		wait_rcu_gp_state(rtp->wait_state, rtp->call_func);
 		return;
 	}
 	rcu_tasks_one_gp(rtp, true);
@@ -1160,6 +1163,7 @@ static int __init rcu_spawn_tasks_kthread(void)
 	rcu_tasks.postscan_func = rcu_tasks_postscan;
 	rcu_tasks.holdouts_func = check_all_holdout_tasks;
 	rcu_tasks.postgp_func = rcu_tasks_postgp;
+	rcu_tasks.wait_state = TASK_IDLE;
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks);
 	return 0;
 }
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 46aaaa9fe339..f8436969e0c8 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -408,7 +408,7 @@ void wakeme_after_rcu(struct rcu_head *head)
 }
 EXPORT_SYMBOL_GPL(wakeme_after_rcu);
 
-void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
+void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *crcu_array,
 		   struct rcu_synchronize *rs_array)
 {
 	int i;
@@ -440,7 +440,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 			if (crcu_array[j] == crcu_array[i])
 				break;
 		if (j == i) {
-			wait_for_completion(&rs_array[i].completion);
+			wait_for_completion_state(&rs_array[i].completion, state);
 			destroy_rcu_head_on_stack(&rs_array[i].head);
 		}
 	}
-- 
2.39.2

