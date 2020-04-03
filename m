Return-Path: <SRS0=jERE=5T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86F1C43331
	for <rcu@archiver.kernel.org>; Fri,  3 Apr 2020 17:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F55920737
	for <rcu@archiver.kernel.org>; Fri,  3 Apr 2020 17:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAay2PCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404284AbgDCRbE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:31:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45302 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403981AbgDCRbD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Apr 2020 13:31:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so7751982ljc.12;
        Fri, 03 Apr 2020 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVqBZ94a4HEstbBLSWVTsFmo6x6cOoQ//AL6Z+R7tCU=;
        b=fAay2PCE6inyHjltPP6nyM1oOF+qQlVoNXAdmxUCyzZ8AJO7z2635/HnBPrXeQis2u
         Jc17f6memMmt/SVpzRMd6x6y5utyBBwAZKcfMuFIy1540+FD50t3qqTAUVb9vpUMxCbA
         KPR6ImC39fIP/nArf+HPyuVPLUWrjRqj/EnksJBVLlB5dyuAzziZR4yCQN5GW9+cDRsy
         GKAFHt6bmaxAPAW6Qn+LLXaJD6GZESgSnBFSDrcw6LbNu9EaxrS7ximNF5LjwnwTyLUD
         zRRIv9N8Ve7arXnEbegecU93po19tRVbDVzloJPAQ3xop9aY8DPSsjHo1quxJLx6EdcD
         w55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVqBZ94a4HEstbBLSWVTsFmo6x6cOoQ//AL6Z+R7tCU=;
        b=cRg8jKIohGhg5uhM9QqBSklLgRS8HZ7ko4IyFQWMcVoR9HHslkrTXjRnmKbJ5p2oxa
         tJQuRlDrD78Ix0i2GkoG1L03hmVylC78WoF9x1jNg65bcUPKCzJiC3TUgVQw+60YvCNZ
         fcBCbUDjQT7Cp7eXfEg2HHCfpTnabbAdBw8Bm3NTbMRwIfNcQuwf+pD3eWqBxymaJ7FE
         LbrI0Zq+8mqS4O75JbLzzWCXYQmYncJ5jxO7IgPvyTfh0UgIYV5JxzdXbas0QnlTSV9G
         d+7RjmzC/bAOn7A77SOgmdFQpE8p7qAqI+yXiWlz1cfCkVhjnzz+QIywLUzg0g/ATa60
         ShcQ==
X-Gm-Message-State: AGi0PuZsCG4MWLcmGdsWKDSQdGL7hH9HndFUFwpXhmjuadSR44+xwpal
        EIHIDs9CtjejOdfK4S7QFfQmpJQCkZo=
X-Google-Smtp-Source: APiQypI4NRa4Jcb9XKuzs/Ix5nIkcm9i/uSYAufTGJYbbcDZzrVP5NWyS/lI2TyFlK+32XesnYs/Mg==
X-Received: by 2002:a2e:b611:: with SMTP id r17mr5543922ljn.62.1585935060470;
        Fri, 03 Apr 2020 10:31:00 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z9sm7237112lfh.45.2020.04.03.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 10:30:59 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Date:   Fri,  3 Apr 2020 19:30:51 +0200
Message-Id: <20200403173051.4081-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Maintain an emergency pool for each CPU with some
extra objects. There is read-only sysfs attribute,
the name is "rcu_nr_emergency_objs". It reflects
the size of the pool. As for now the default value
is 3.

The pool is populated when low memory condition is
detected. Please note it is only for headless case
it means when the regular SLAB is not able to serve
any request, the pool is used.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 133 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 36 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5e26145e9ead..f9f1f935ab0b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -114,6 +114,14 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
 int rcu_kfree_nowarn;
 module_param(rcu_kfree_nowarn, int, 0444);
 
+/*
+ * For headless variant. Under memory pressure an
+ * emergency pool can be used if the regular SLAB
+ * is not able to serve some memory for us.
+ */
+int rcu_nr_emergency_objs = 3;
+module_param(rcu_nr_emergency_objs, int, 0444);
+
 /* Number of rcu_nodes at specified level. */
 int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
@@ -2877,6 +2885,12 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	// Number of objects for which GP not started
 	int count;
+
+	/*
+	 * Reserved emergency pool for headless variant.
+	 */
+	int nr_emergency;
+	void **emergency;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
@@ -2892,6 +2906,27 @@ debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
 #endif
 }
 
+static inline struct kfree_rcu_cpu *
+krc_this_cpu_lock(unsigned long *flags)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
+	krcp = this_cpu_ptr(&krc);
+	if (likely(krcp->initialized))
+		spin_lock(&krcp->lock);
+
+	return krcp;
+}
+
+static inline void
+krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
+{
+	if (likely(krcp->initialized))
+		spin_unlock(&krcp->lock);
+	local_irq_restore(flags);
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -2974,6 +3009,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
+		unsigned long flags;
 		bool headless;
 		void *ptr;
 
@@ -2991,10 +3027,23 @@ static void kfree_rcu_work(struct work_struct *work)
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
-			if (headless)
+			if (headless) {
 				kvfree((void *) *((unsigned long *) ptr));
 
-			kvfree(ptr);
+				krcp = krc_this_cpu_lock(&flags);
+				if (krcp->emergency) {
+					if (krcp->nr_emergency < rcu_nr_emergency_objs) {
+						krcp->emergency[krcp->nr_emergency++] = ptr;
+
+						/* Bypass freeing of it, it is in emergency pool. */
+						ptr = NULL;
+					}
+				}
+				krc_this_cpu_unlock(krcp, flags);
+			}
+
+			if (ptr)
+				kvfree(ptr);
 		}
 
 		rcu_lock_release(&rcu_callback_map);
@@ -3144,40 +3193,26 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	return true;
 }
 
-static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
+static inline struct rcu_head *
+set_ptr_in_rcu_head_obj(void *ptr, unsigned long *rho)
+{
+	rho[0] = (unsigned long) ptr;
+	return ((struct rcu_head *) ++rho);
+}
+
+static inline struct rcu_head *
+alloc_rcu_head_obj(void *ptr)
 {
-	unsigned long *ptr;
+	unsigned long *rho;
 
 	/* Try hard to get the memory. */
-	ptr = kmalloc(sizeof(unsigned long *) +
+	rho = kmalloc(sizeof(unsigned long *) +
 		sizeof(struct rcu_head), GFP_KERNEL |
 			__GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL);
-	if (!ptr)
+	if (!rho)
 		return NULL;
 
-	ptr[0] = (unsigned long) obj;
-	return ((struct rcu_head *) ++ptr);
-}
-
-static inline struct kfree_rcu_cpu *
-krc_this_cpu_lock(unsigned long *flags)
-{
-	struct kfree_rcu_cpu *krcp;
-
-	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
-	krcp = this_cpu_ptr(&krc);
-	if (likely(krcp->initialized))
-		spin_lock(&krcp->lock);
-
-	return krcp;
-}
-
-static inline void
-krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
-{
-	if (likely(krcp->initialized))
-		spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	return set_ptr_in_rcu_head_obj(ptr, rho);
 }
 
 /*
@@ -3237,15 +3272,31 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (!success) {
 		/* Is headless object? */
 		if (head == NULL) {
-			/* Drop the lock. */
+			/*
+			 * Drop the lock to use more permissive
+			 * parameters, after that take it back.
+			 */
 			krc_this_cpu_unlock(krcp, flags);
+			head = alloc_rcu_head_obj(ptr);
+			krcp = krc_this_cpu_lock(&flags);
 
-			head = attach_rcu_head_to_object(ptr);
-			if (head == NULL)
-				goto inline_return;
+			/*
+			 * Use emergency pool if still fails.
+			 */
+			if (head == NULL) {
+				if (!krcp->nr_emergency)
+					goto unlock_return;
 
-			/* Take it back. */
-			krcp = krc_this_cpu_lock(&flags);
+				head = set_ptr_in_rcu_head_obj(ptr,
+					krcp->emergency[--krcp->nr_emergency]);
+
+				/*
+				 * We do not need to do it. But just in case
+				 * let's set the pulled slot to NULL to avoid
+				 * magic issues.
+				 */
+				krcp->emergency[krcp->nr_emergency] = NULL;
+			}
 
 			/*
 			 * Tag the headless object. Such objects have a back-pointer
@@ -3282,7 +3333,6 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
 
-inline_return:
 	/*
 	 * High memory pressure, so inline kvfree() after
 	 * synchronize_rcu(). We can do it from might_sleep()
@@ -4272,6 +4322,17 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+
+		/*
+		 * The poll will be populated when low memory condition
+		 * is detected. Therefore we do not fill it in here.
+		 */
+		krcp->emergency = kmalloc_array(rcu_nr_emergency_objs,
+			sizeof(void *), GFP_NOWAIT);
+
+		if (!krcp->emergency)
+			pr_err("Failed to create emergency pool for %d CPU!\n", cpu);
+
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.20.1

