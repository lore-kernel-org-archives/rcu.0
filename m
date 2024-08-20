Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5719148F;
	Tue, 20 Aug 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169582; cv=none; b=S2KVkw2Wg2MzYL0UNho9fDrGHrz8Ec81z4nmzUIwqiYR6XRWbHSMjRHojBFt3ELpE5w5OFzkYKb7zEd4SKgj3KsH9GT8wteYxJT1IMyo7/sIi/t/Dfk54Of6dN4FbaFd/CrqWHrOUJZkFY0CFxpGmdaGvyCOWHPQLSBE1XRtnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169582; c=relaxed/simple;
	bh=DR4NdoDmop9knrTbAlSlclRt8RahNtw9knSDCpq0byE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KKYY9PvO7qjdFWRe+WAnHMYYKC9F/hVFAD0sWBnHveliJ1R7/ha8OYR6AFFbEW7LVNnTKT/824IPt/eZsBPtufIe0L4t3PYxIK7X13fi4fMyoFaErU0yCeDwpcqZLPThleUE2C8e4kp2I+v+TqUDh63Bkp9L7rbjnsswt+3mUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaxZzF4G; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaxZzF4G"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f00ad303aso7349401e87.2;
        Tue, 20 Aug 2024 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724169579; x=1724774379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3uJH4RATQWUgqKfHPsSvsxb9nwM42H9IUEggYrsmmM=;
        b=KaxZzF4GBOj64uhEv56jdgtIQ/+asXUvLkWnbq6TmIQQCVmlLefVMlHnSNTGqDIUh4
         It60zG82i5xxtRiapHFsr5vIDHq3YAyYyv1n/H5H7mTVfNM93fCmcP6zKvmo1EVXmhax
         QXBN0eJTEQkSaZksBAlqh6EOV48MX4PVJaWBzkXAHBtH/aU1D76P+JuGksmRzm2araFn
         J1EFaLaTueM7yPyl4bc2lk86wWTEpvwuUWcojopVnmf5MuWXcZtIxDxn2xQR6jmKRk7S
         hm8YckiUxcG4wURdn/x07D3TtEn5rE6OPYl2zotGDvulcHJZXNCgUGZ05ayGqlgsDHVU
         lm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169579; x=1724774379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3uJH4RATQWUgqKfHPsSvsxb9nwM42H9IUEggYrsmmM=;
        b=fpV+4rOq+JsOdU5X30FxWqnfk5RpM3Trp5usHaGJt2PrAwGwjZ+/P5td26hfsMKlr0
         dqlFxTfleQykkSpKA+Xsgix/1mBTGAbwHOhVRHpmVoe48WOF8k3Gtr+/wPFDIa+CFmO7
         j58rNNgaWfoZFU6JSQprmaOERbbfbX/mLh28m9R7BjsH9AIoEMo7PeAPHdZ685oR2vYo
         oEiCXyaGQM/bZw/vAQWF10jdQBItplLew8MxwN70hurzU+YOMgEVfJg0kyc0wnHpYKsZ
         /LS646SWKtD+SvkjawLJo1jc3AsdQB05JFCa5fiZ+5GxCHyZ//ltkbNSD+lWjS9cjM1D
         hL6A==
X-Forwarded-Encrypted: i=1; AJvYcCVvKJTnn6qMrfESU8W+ev2Vj58YjCoFc1YU7Y+rBGWFyjYcfl1oHi9bDLvBzRLFQg3DR9/2KY+elkMveztUS6fVFPRIzprkh6jeKi4i
X-Gm-Message-State: AOJu0YyS4Rfi9kmQSYT44LUnbvUejM0LpyzQaf+Kd71S62Wn8PEMUal6
	1iQB07Szz7O7Qd8RLiA5SOk7YjxK5349f16N0CtMleYxrlg9PA4d
X-Google-Smtp-Source: AGHT+IHRV5C746URYAjDOuuf9WTSLKJFUSw745L3izU3wv7VC2xgRrolwQo3owV8LwzfD399Rfsx/g==
X-Received: by 2002:a05:6512:68c:b0:52e:d0f8:2d30 with SMTP id 2adb3069b0e04-5331c6ec41cmr9518037e87.59.1724169577827;
        Tue, 20 Aug 2024 08:59:37 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3b8f0fsm1853833e87.94.2024.08.20.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:59:37 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2] rcu/kvfree: Add kvfree_rcu_barrier() API
Date: Tue, 20 Aug 2024 17:59:35 +0200
Message-Id: <20240820155935.1167988-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kvfree_rcu_barrier() function. It waits until all
in-flight pointers are freed over RCU machinery. It does
not wait any GP completion and it is within its right to
return immediately if there are no outstanding pointers.

This function is useful when there is a need to guarantee
that a memory is fully freed before destroying memory caches.
For example, during unloading a kernel module.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/rcutiny.h |   5 ++
 include/linux/rcutree.h |   1 +
 kernel/rcu/tree.c       | 109 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d9ac7b136aea..522123050ff8 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -111,6 +111,11 @@ static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	kvfree(ptr);
 }
 
+static inline void kvfree_rcu_barrier(void)
+{
+	rcu_barrier();
+}
+
 #ifdef CONFIG_KASAN_GENERIC
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 #else
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 254244202ea9..58e7db80f3a8 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -35,6 +35,7 @@ static inline void rcu_virt_note_context_switch(void)
 
 void synchronize_rcu_expedited(void);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
+void kvfree_rcu_barrier(void);
 
 void rcu_barrier(void);
 void rcu_momentary_dyntick_idle(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..be00aac5f4e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3584,18 +3584,15 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 }
 
 /*
- * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
+ * Return: %true if a work is queued, %false otherwise.
  */
-static void kfree_rcu_monitor(struct work_struct *work)
+static bool
+kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
 {
-	struct kfree_rcu_cpu *krcp = container_of(work,
-		struct kfree_rcu_cpu, monitor_work.work);
 	unsigned long flags;
+	bool queued = false;
 	int i, j;
 
-	// Drain ready for reclaim.
-	kvfree_rcu_drain_ready(krcp);
-
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 
 	// Attempt to start a new batch.
@@ -3634,11 +3631,27 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queued = queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+	return queued;
+}
+
+/*
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
+ */
+static void kfree_rcu_monitor(struct work_struct *work)
+{
+	struct kfree_rcu_cpu *krcp = container_of(work,
+		struct kfree_rcu_cpu, monitor_work.work);
+
+	// Drain ready for reclaim.
+	kvfree_rcu_drain_ready(krcp);
+
+	// Queue a batch for a rest.
+	kvfree_rcu_queue_batch(krcp);
 
 	// If there is nothing to detach, it means that our job is
 	// successfully done here. In case of having at least one
@@ -3859,6 +3872,86 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
+/**
+ * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
+ *
+ * Note that a single argument of kvfree_rcu() call has a slow path that
+ * triggers synchronize_rcu() following by freeing a pointer. It is done
+ * before the return from the function. Therefore for any single-argument
+ * call that will result in a kfree() to a cache that is to be destroyed
+ * during module exit, it is developer's responsibility to ensure that all
+ * such calls have returned before the call to kmem_cache_destroy().
+ */
+void kvfree_rcu_barrier(void)
+{
+	struct kfree_rcu_cpu_work *krwp;
+	struct kfree_rcu_cpu *krcp;
+	bool queued;
+	int i, cpu;
+
+	/*
+	 * Firstly we detach objects and queue them over an RCU-batch
+	 * for all CPUs. Finally queued works are flushed for each CPU.
+	 *
+	 * Please note. If there are outstanding batches for a particular
+	 * CPU, those have to be finished first following by queuing a new.
+	 */
+	for_each_possible_cpu(cpu) {
+		krcp = per_cpu_ptr(&krc, cpu);
+
+		/*
+		 * Check if this CPU has any objects which have been queued for a
+		 * new GP completion. If not(means nothing to detach), we are done
+		 * with it. If any batch is pending/running for this "krcp", below
+		 * per-cpu flush_rcu_work() waits its completion(see last step).
+		 */
+		if (!need_offload_krc(krcp))
+			continue;
+
+		while (1) {
+			/*
+			 * If we are not able to queue a new RCU work it means:
+			 * - batches for this CPU are still in flight which should
+			 *   be flushed first and then repeat;
+			 * - no objects to detach, because of concurrency.
+			 */
+			queued = kvfree_rcu_queue_batch(krcp);
+
+			/*
+			 * Bail out, if there is no need to offload this "krcp"
+			 * anymore. As noted earlier it can run concurrently.
+			 */
+			if (queued || !need_offload_krc(krcp))
+				break;
+
+			/* There are ongoing batches. */
+			for (i = 0; i < KFREE_N_BATCHES; i++) {
+				krwp = &(krcp->krw_arr[i]);
+				flush_rcu_work(&krwp->rcu_work);
+			}
+		}
+	}
+
+	/*
+	 * Now we guarantee that all objects are flushed.
+	 */
+	for_each_possible_cpu(cpu) {
+		krcp = per_cpu_ptr(&krc, cpu);
+
+		/*
+		 * A monitor work can drain ready to reclaim objects
+		 * directly. Wait its completion if running or pending.
+		 */
+		cancel_delayed_work_sync(&krcp->monitor_work);
+
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			krwp = &(krcp->krw_arr[i]);
+			flush_rcu_work(&krwp->rcu_work);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-- 
2.39.2

