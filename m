Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D002C83007
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB32206F0
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBNRUevw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD1U7i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbgD1U7g (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463FEC03C1AE;
        Tue, 28 Apr 2020 13:59:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b2so244591ljp.4;
        Tue, 28 Apr 2020 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSPDLCw928vWc9z2Vz2mWvGeAMzP8/jPehX8Io29R/M=;
        b=fBNRUevwPDJSM6q61fYhtsse5IE6E2y49tzY82VPIID1sRrr24Y4C3aaCE9B4T1ysJ
         mOluuoskKtW7BHBxKOgr9NHqfsm0tFoVS2yZiEKTY/jXHX2nvMQJlIcXwoKnTU43WNfI
         rfVhpIDwCGbdAbrwRJ9hnIG8ov2eLEn5/PxoYgnyh9/NCqjGM8OvzN5YXwHuOgpPQudb
         wXIItywWBp9ndAHZ5asj6ggkGlspU+FNJ1tWf1RJ3hfOwwS6RF5xvPHNaI/EBRqoATpG
         oLR9O8UiOtqpy4TSULHeReidBctk5DOOnqlEdLtR8zvnc2ZMQj6x1wnzz/ToBD3zaXP6
         HgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSPDLCw928vWc9z2Vz2mWvGeAMzP8/jPehX8Io29R/M=;
        b=m10o5iTpPSv5MwvlkUlZ6uV/kV6wHm40s0tMpTXR1XzgsHoHuMJyxjRA8jH5xONDyo
         AaGL6xTCy1r+6oPUZ7hB/BSCLTsBFVKT2PmQSJ55AGSo6EUN3lUNRbyFLT0bT6h570Vp
         GDzAVq+ZH52xdtX7cOu0FCh3Ga6OiW5YWwEUZrOPo1jUYIi0VBiJOMPRTY6TLG5DUQz3
         7fknAl6B9OL2GWQNA7VwHNsOcgKa2urVmjIUztuSkE58++le5zY3tpoSpEKsIrsgeldH
         oOQDaVAQa6EwKbozdiL568IdlBG77CZ15uLT5hKZKtzgbtzjT6gzu3dCgLSR720vFQpY
         1AGw==
X-Gm-Message-State: AGi0PuagLdcPRaa6wlrnM7cFAKcJccy9mLJoxVmYvyxn86Xl64h6/OK1
        OuQoiEGr4rOOW9JBz3vZFUptkA0mqq0wLg==
X-Google-Smtp-Source: APiQypJOSkeM4KBluNbofCs+yZeBUUC4FcCWL6GUCvKOg8yk0RnaTVgUFbftNLX0tMsTwccEtDwwkw==
X-Received: by 2002:a2e:b5d2:: with SMTP id g18mr18864979ljn.51.1588107574209;
        Tue, 28 Apr 2020 13:59:34 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:33 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 05/24] rcu/tree: Simplify debug_objects handling
Date:   Tue, 28 Apr 2020 22:58:44 +0200
Message-Id: <20200428205903.61704-6-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In order to prepare for future changes for headless RCU support, make the
debug_objects handling in kfree_rcu use the final 'pointer' value of the
object, instead of depending on the head.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0762ac06f0b7..767aed49d7fd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2860,13 +2860,11 @@ EXPORT_SYMBOL_GPL(call_rcu);
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
@@ -2916,11 +2914,13 @@ struct kfree_rcu_cpu {
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
 
@@ -2950,7 +2950,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; bhead; bhead = bnext) {
 		bnext = bhead->next;
 
-		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
+		debug_rcu_bhead_unqueue(bhead);
 
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
@@ -2972,14 +2972,15 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3118,18 +3119,11 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
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
@@ -3153,14 +3147,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	void *ptr;
 
 	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
 		raw_spin_lock(&krcp->lock);
 
+	ptr = (void *)head - (unsigned long)func;
+
 	/* Queue the object but don't yet schedule the batch. */
-	if (debug_rcu_head_queue(head)) {
+	if (debug_rcu_head_queue(ptr)) {
 		/* Probable double kfree_rcu(), just leak. */
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
-- 
2.20.1

