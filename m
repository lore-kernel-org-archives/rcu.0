Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1C7C433E0
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830B72084D
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029607;
	bh=R9LbkAo9jKwjkjclV3oodsP6eF1VffMzNtlLMYCzz44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkI1D7w8MGb4jamT2maHpGyaLtcxKB2CehO0n9z7UaYY/uxPM+sDh9Pr28KTTJj4c
	 qiilDI5EA1xVKLvMQLuqRf5ZaQ2JQjLwCtJLqc9yHhQ1ojUZqxnidu4hNBOEfsX+Bi
	 i4nkSxJTFxRmTDUcd9sgXhQIatF5ZqzAkKWCP6qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406518AbgFXUN1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406380AbgFXUMa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 054D720B80;
        Wed, 24 Jun 2020 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029549;
        bh=R9LbkAo9jKwjkjclV3oodsP6eF1VffMzNtlLMYCzz44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anWb0gy5nSKcvywWwZc1+oR8+w6JhPwt8Um1eMNDIfx7BymseDl7zLdh5E7a7rAFI
         Ct0PDG4YgcnMgNhbO8OU8tRVYXz41YSCBdBjBiuhqAZpz+llOqA70eC1cKnCOPoScF
         vVNqOcyylPbvCjPO21+SsrorTn7c71J5h6dhPclc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/17] rcu/tree: Make debug_objects logic independent of rcu_head
Date:   Wed, 24 Jun 2020 13:12:14 -0700
Message-Id: <20200624201226.21197-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

kfree_rcu()'s debug_objects logic uses the address of the object's
embedded rcu_head to queue/unqueue. Instead of this, make use of the
object's address itself as preparation for future headless kfree_rcu()
support.

Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31d3b2c..dc5369a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2952,13 +2952,11 @@ EXPORT_SYMBOL_GPL(call_rcu);
  * @nr_records: Number of active pointers in the array
  * @records: Array of the kfree_rcu() pointers
  * @next: Next bulk object in the block chain
- * @head_free_debug: For debug, when CONFIG_DEBUG_OBJECTS_RCU_HEAD is set
  */
 struct kfree_rcu_bulk_data {
 	unsigned long nr_records;
 	void *records[KFREE_BULK_MAX_ENTR];
 	struct kfree_rcu_bulk_data *next;
-	struct rcu_head *head_free_debug;
 };
 
 /**
@@ -3008,11 +3006,13 @@ struct kfree_rcu_cpu {
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
 static __always_inline void
-debug_rcu_head_unqueue_bulk(struct rcu_head *head)
+debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 {
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	for (; head; head = head->next)
-		debug_rcu_head_unqueue(head);
+	int i;
+
+	for (i = 0; i < bhead->nr_records; i++)
+		debug_rcu_head_unqueue((struct rcu_head *)(bhead->records[i]));
 #endif
 }
 
@@ -3042,7 +3042,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; bhead; bhead = bnext) {
 		bnext = bhead->next;
 
-		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
+		debug_rcu_bhead_unqueue(bhead);
 
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
@@ -3064,14 +3064,15 @@ static void kfree_rcu_work(struct work_struct *work)
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
+		void *ptr = (void *)head - offset;
 
 		next = head->next;
-		debug_rcu_head_unqueue(head);
+		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
-			kfree((void *)head - offset);
+			kfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3210,18 +3211,11 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
 		bnode->next = krcp->bhead;
-		bnode->head_free_debug = NULL;
 
 		/* Attach it to the head. */
 		krcp->bhead = bnode;
 	}
 
-#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	head->func = func;
-	head->next = krcp->bhead->head_free_debug;
-	krcp->bhead->head_free_debug = head;
-#endif
-
 	/* Finally insert. */
 	krcp->bhead->records[krcp->bhead->nr_records++] =
 		(void *) head - (unsigned long) func;
@@ -3245,14 +3239,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	void *ptr;
 
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
 		raw_spin_lock(&krcp->lock);
 
+	ptr = (void *)head - (unsigned long)func;
+
 	// Queue the object but don't yet schedule the batch.
-	if (debug_rcu_head_queue(head)) {
+	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
-- 
2.9.5

