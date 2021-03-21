Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEADC433DB
	for <rcu@archiver.kernel.org>; Sun, 21 Mar 2021 03:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D8261925
	for <rcu@archiver.kernel.org>; Sun, 21 Mar 2021 03:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCUDRu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 20 Mar 2021 23:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCUDRm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 20 Mar 2021 23:17:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B61C061574;
        Sat, 20 Mar 2021 20:17:42 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f8so2929426pgi.9;
        Sat, 20 Mar 2021 20:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgU6fuJp9DpWXQ69uJVg76blkp6etJcIK6Hc3Bi//BI=;
        b=PL40wP9n6copmBqtmTGF/bDsdvanX+6OKtvRyW2uCLzMndGT1+31TTGeABcieo6I86
         Kdsu9UYLWB4Eb+CJAUWJBmjcpxfLqSoSex/LWeG6V2qdgXDW1U59ApJLQpAxEtZBzCUP
         0E2bOj0jEfS3O16AmQLpHlVLSFpG7HBxGPx35rBKigmZUh58b0O4x4Mtwdj0wy/LUtbv
         /OUel/ILs/y9j7kvYUtmWl0u0fGRZS/Qaqw0xzfucHJJAvn4vy5GeZA75n2V++sKai1w
         Yg2w3ZLgdhxvmFlLahgUNOwmrR8Ra1GU9jclUc0edlUHkCvzCqYgnPP6irmgqUJhohb6
         qRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgU6fuJp9DpWXQ69uJVg76blkp6etJcIK6Hc3Bi//BI=;
        b=ZjB24j9fJwXbxeBB/ZzulZlCsSMBTNPnZkbU2R+4sLFqJ/nNXCJNYJglNCa/XFXS+O
         8K91e5b8gdAHyr3j2PiqAP3hCl+y8U8v9nWTbukKdQeo+18Y7x2oMhjRJdlAT3QDfAD/
         8F4tduvrHwdw7D/IFJfUgvuinwsSYwKVhszq5U15YRYJmEPn6D0uG/GWg60bnoaKtRDa
         od+30lYH7oSXAvWHmAlFXaurLAKudPZfdaSCcVoYqv2e13EyOHkRMxjvDhdNYf2KiRVh
         SAb4iyZCt8dbwkPHIIsicnYfYu0H99qHiEzBhHyBCri8MjfIqjwaq5T75OX3xQ/GkgNF
         PMcQ==
X-Gm-Message-State: AOAM5325XOStGeNihm+0rF1tQmsyJyiy1oZFKgAWrBlMr0wdZf5d1IvX
        sAkxTXi91jUj6vWza0tHZ0A=
X-Google-Smtp-Source: ABdhPJxEfNXspnU/dlcj6BVT6CMAra9IEJ3MWn3ru4JO+wIOyZaJzEX20t+qwF1wvUH1AppFDUVb6g==
X-Received: by 2002:a05:6a00:b86:b029:205:c773:5c69 with SMTP id g6-20020a056a000b86b0290205c7735c69mr15852456pfj.60.1616296661995;
        Sat, 20 Mar 2021 20:17:41 -0700 (PDT)
Received: from localhost.localdomain ([45.41.181.227])
        by smtp.gmail.com with ESMTPSA id w5sm9023311pge.55.2021.03.20.20.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 20:17:41 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     340442286@qq.com, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] RCU: some improvements to comments of tree.c
Date:   Sun, 21 Mar 2021 11:17:25 +0800
Message-Id: <20210321031725.15823-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During my study of RCU, I go through tree.c many times
and try to make some improvements to the comments.

Thanks a lot.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/rcu/tree.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f5213fb74..50c6b8fd8d08 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -201,7 +201,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  * the need for long delays to increase some race probabilities with the
  * need for fast grace periods to increase other race probabilities.
  */
-#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays. */
+#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays, for debug purpose. */
 
 /*
  * Compute the mask of online CPUs for the specified rcu_node structure.
@@ -835,9 +835,9 @@ void noinstr rcu_irq_exit(void)
 
 /**
  * rcu_irq_exit_preempt - Inform RCU that current CPU is exiting irq
- *			  towards in kernel preemption
+ *			  towards kernel preemption
  *
- * Same as rcu_irq_exit() but has a sanity check that scheduling is safe
+ * Same as rcu_irq_exit() but has some sanity checks that scheduling is safe
  * from RCU point of view. Invoked from return from interrupt before kernel
  * preemption.
  */
@@ -959,7 +959,7 @@ EXPORT_SYMBOL_GPL(rcu_idle_exit);
  */
 void noinstr rcu_user_exit(void)
 {
-	rcu_eqs_exit(1);
+	rcu_eqs_exit(true);
 }
 
 /**
@@ -1226,7 +1226,7 @@ EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 #endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
 
 /*
- * We are reporting a quiescent state on behalf of some other CPU, so
+ * We may reporting a quiescent state on behalf of some other CPU, so
  * it is our responsibility to check for and handle potential overflow
  * of the rcu_node ->gp_seq counter with respect to the rcu_data counters.
  * After all, the CPU might be in deep idle state, and thus executing no
@@ -1808,9 +1808,9 @@ static bool rcu_gp_init(void)
 		return false;
 	}
 
-	/* Advance to a new grace period and initialize state. */
-	record_gp_stall_check_time();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
+	record_gp_stall_check_time();
+	/* Advance to a new grace period and initialize state. */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
@@ -2630,7 +2630,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
  * state, for example, user mode or idle loop.  It also schedules RCU
  * core processing.  If the current grace period has gone on too long,
  * it will ask the scheduler to manufacture a context switch for the sole
- * purpose of providing a providing the needed quiescent state.
+ * purpose of providing the needed quiescent state.
  */
 void rcu_sched_clock_irq(int user)
 {
@@ -3260,7 +3260,7 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
 /*
  * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->bhead_free or ->head_free.
+ * It frees all the objects queued on ->bkvhead_free or ->head_free.
  */
 static void kfree_rcu_work(struct work_struct *work)
 {
@@ -3287,7 +3287,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	krwp->head_free = NULL;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-	// Handle two first channels.
+	// Handle first two channels.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
 		for (; bkvhead[i]; bkvhead[i] = bnext) {
 			bnext = bkvhead[i]->next;
@@ -3530,7 +3530,7 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 
 /*
  * Queue a request for lazy invocation of appropriate free routine after a
- * grace period. Please note there are three paths are maintained, two are the
+ * grace period. Please note there are three paths maintained, two are the
  * main ones that use array of pointers interface and third one is emergency
  * one, that is used only when the main path can not be maintained temporary,
  * due to memory pressure.
@@ -3813,7 +3813,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
 
 /*
  * Check to see if there is any immediate RCU-related work to be done by
- * the current CPU, returning 1 if so and zero otherwise.  The checks are
+ * the current CPU, returning 1 if so and 0 otherwise.  The checks are
  * in order of increasing expense: checks that can be carried out against
  * CPU-local state are performed first.  However, we must check for CPU
  * stalls first, else we might not get a chance.
@@ -4153,7 +4153,7 @@ int rcutree_online_cpu(unsigned int cpu)
 }
 
 /*
- * Near the beginning of the process.  The CPU is still very much alive
+ * Near the beginning of the offline process. The CPU is still very much alive
  * with pretty much all services enabled.
  */
 int rcutree_offline_cpu(unsigned int cpu)
@@ -4651,7 +4651,7 @@ void __init rcu_init(void)
 		rcutree_online_cpu(cpu);
 	}
 
-	/* Create workqueue for expedited GPs and for Tree SRCU. */
+	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
-- 
2.25.1

