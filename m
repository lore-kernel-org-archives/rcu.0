Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD33E47B;
	Thu,  1 Aug 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510646; cv=none; b=hYYCCjgKBSatf/WHksrKC9UaRY7i/7pTRyZlZNbOJmmMLogAdp+dySwZxG/EZGFFOEp+ohlxea6V/B9XtP/1GH/vSHE8sUTLVMEOjhTRVKlTlwV8G14Bf0c4HP43Gktb8UpxxAIoKpZvORCB+HDqEYLfiZkL5GOJr+ovecfxXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510646; c=relaxed/simple;
	bh=PFMUxFCZQ0nyhURPBIyxiYN7UGFRLyXPUuOb3zjSHuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zgv2XdxPf735K0/bO6U5WD2/0jDL9zFqZSo/nkXNShr88jh4leazakjTj0VyF7WTXjBjbBqz6LIOSCEVzayw+T8qYly44M/2aUQ2A62nyL9jL62r9My+MegYYBmjvJWd4E5VH9780jip2ODpngqeylnnzjdHaFjrGEj1KHjegaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao+zpy2s; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao+zpy2s"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so10015845e87.2;
        Thu, 01 Aug 2024 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510642; x=1723115442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSkbAXCwM3DAAwgfxr2M2bZ6swlzH8a6m+I4eoubPtA=;
        b=Ao+zpy2s29wM3QsNV0MLLsIY5+9X3iT8U1443sL3OMmonrpYNfuSU8wFPiH0Y13Uuj
         1j1oPFIDB7RK17UjyNLL0QGz16IYw4D5tAY7zDtOkhY74+dij/6neGFAuPFefs5bkpk6
         cUI988PfbOSXrr43OaaZEPGXkf6GgM5q2BPDcstZIMSqN6E72gB60BnjDNCgEzFLFrqv
         rb7hgdTy5MSbh9j7Ib5ml/LYE6A/iQ6PUPk3b8hQrDPWu8jsA9IHHN3kANJ2/GFl041W
         D5HiB0vk7yaegAfSwZGI5Wb2kTJCBWxyH1lIm6jACdgQMWocCEMqhTGuTQYVLL6mMqHO
         sEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510642; x=1723115442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSkbAXCwM3DAAwgfxr2M2bZ6swlzH8a6m+I4eoubPtA=;
        b=Plf3et55+36xdvUih0JbJ3baMOJXZZncLKzZDb3rDugpbxkjqEl6G4AGubIE6drbgx
         YlvKcOSbdyfIlGbQby8Vrnlx2vcKwCFBzWggmmiBtdqYVSgAwbZ2V/dbP+KGWymabZzR
         4PhWXUEBiqXnzqEM6oY7oM8sLKYwWUklgrZzyxA7XFzcpTTlWHw/tYDLZJzZiXPlYV0O
         Ww9Pj7M+mfysLxixgpyPDsQ/+UWPvNBETGE7NZzJmy/d2VyUEqNy6AG8B8cLNoGf5riM
         vhNRLW6sq8FczCeOLF6G0dDgrelBEWv/OA8FKYrXksi04lJDyfUyogIlfxuRUu2boyWN
         DtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFMP/zDfnMN8lp7hjTB01unVCRsExs5vro7g3dr7ZFXKE/7RGresHTiwMxDmWlFqbBt5oNDe1jUdHAg5RGhP4H1j3NUWYuQW1ZUFJ0
X-Gm-Message-State: AOJu0YzWcsM1ZAieZwaQBfec0ReclRaArfzoFSRSwMHAk51DUN8ZVwVU
	9HWRojI1ewB1PYmmK4ToA3++dFKGCu2364+RUX1Lt+lOUfOAOvPm
X-Google-Smtp-Source: AGHT+IEE2HH6r9JP4OtVfWfBGZGdZnK+N4OKi1FfxZwOIbssFpMOHKopyv3/d/kzAzEZZJECAQe8wQ==
X-Received: by 2002:a05:6512:3d0a:b0:52f:159:2dc5 with SMTP id 2adb3069b0e04-530b61ec050mr1577846e87.42.1722510641720;
        Thu, 01 Aug 2024 04:10:41 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08e04sm2545711e87.144.2024.08.01.04.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:10:41 -0700 (PDT)
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
Subject: [PATCH] rcu/kvfree: Add kvfree_rcu_barrier() API
Date: Thu,  1 Aug 2024 13:10:39 +0200
Message-Id: <20240801111039.79656-1-urezki@gmail.com>
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
---
 include/linux/rcutiny.h |   5 ++
 include/linux/rcutree.h |   1 +
 kernel/rcu/tree.c       | 103 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 101 insertions(+), 8 deletions(-)

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
index 28c7031711a3..1423013f9fe6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3550,18 +3550,15 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
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
@@ -3600,11 +3597,27 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
@@ -3825,6 +3838,80 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
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

