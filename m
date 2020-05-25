Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07333C433E1
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A3D206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmwS9Hf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbgEYVtE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgEYVsS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91122C05BD43;
        Mon, 25 May 2020 14:48:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l15so21806104lje.9;
        Mon, 25 May 2020 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+GYAs311TuxCys/vNhpiV48XtphGpyqwqArPir1vEA=;
        b=HmwS9Hf5tRNKvWpc7rChtGmNKH52OEpaRZEDcq2huMBobbMyLS3W1ri6fqOH6hgQQm
         dG8FebHg4aifOm/2Bg1ujIP8FaUkppUxbOB2jSwctvALRBMUoibtEF+HaPmPZPfedZsm
         oOVCM1JwKFjxgUm/qo9NvVy0Wp18aqk63ujpfc9n8eVcRZT4l7Hg50gRWZ/SdD9MygYu
         Ysol6j+BrzySzgXdYFG0LsAI+D8so936BDFRNUcMfzlu/tKyy64WhJWvLbfnK66KIw1Q
         PHG0Zzki3cI/PupjxDSg7HRujzu71cGxzTjnE4mhSNOVjAnOIgZYytfQQzW56ODvkLKK
         Sq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+GYAs311TuxCys/vNhpiV48XtphGpyqwqArPir1vEA=;
        b=fF6mh3aYsTN+TEUi2MkYRATkHlv86+blGOvcS7/HcmXMUxUFeomwR+ZhXvyxUWXw/H
         1LZsCQYHanzOOB1fQvrutZTOfW2+uuH+plZK3H+UxgXr4b6td+fe78MHBrYm3WTwiiz7
         XrtTL2l2TmaTYLfiIAC/D1DQeOmPvcmedneQrS6PHLtwai9ZsmmkkM+MnwqkgO+VQcmj
         0wGwBde4+Zzbd9K8SLhxBpVkqoh5VKAl7HNwIbJCAbjHNUgOPUEk9TzB+K22+icc+CR8
         gjp9EVz7hA40sjqSIXkdFtZJbGGBm/gMpvp+DReha9Pr0Gg4tNalrHHCeh1hGt33Mqj9
         x/bQ==
X-Gm-Message-State: AOAM5329ql+4K1Cn0H8gjk/vYxt+ulx/nqm9qfzAwtNlVtuvivSvb6ht
        8SLgK8Uti5rcHtLjhgbO+lYLnNKNFuCvPA==
X-Google-Smtp-Source: ABdhPJw5QAHid24LqXhonjXjabD4R74L3No12FclTCqfTQczerEPg5Pgt8IKgCuBPeR0GAgrgoM5Ow==
X-Received: by 2002:a2e:9081:: with SMTP id l1mr15678344ljg.81.1590443294766;
        Mon, 25 May 2020 14:48:14 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:14 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 04/16] rcu/tree: Make debug_objects logic independent of rcu_head
Date:   Mon, 25 May 2020 23:47:48 +0200
Message-Id: <20200525214800.93072-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 kernel/rcu/tree.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ae21e1bddd3e..776ccf858154 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2836,13 +2836,11 @@ EXPORT_SYMBOL_GPL(call_rcu);
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
@@ -2892,11 +2890,13 @@ struct kfree_rcu_cpu {
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
 
@@ -2926,7 +2926,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; bhead; bhead = bnext) {
 		bnext = bhead->next;
 
-		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
+		debug_rcu_bhead_unqueue(bhead);
 
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
@@ -2948,14 +2948,15 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3094,18 +3095,11 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
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
@@ -3129,14 +3123,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
2.20.1

