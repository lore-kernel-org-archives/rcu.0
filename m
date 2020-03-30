Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75175C2D0E7
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439262078B
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n8ZFtlSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgC3Cdk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:33:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34202 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgC3Cdj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id i6so17556158qke.1
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SC1wb04vPFRHvA69idHFJ/D6TQHtUQk5KfrhqDEopc=;
        b=n8ZFtlSWpZkaejINrNFAgQe81mPm1qWw92alN9sRCcqMfUbbD+oO2me5NN9T23SnJB
         OGq7zOh2DqT7DRspsD/Mnk5C1Al6o2RjKHcfVq86GVhWCuMmRlVru+fvyVpWfYwn5FAV
         qQNh0nYHY0ZBoY2rruGIs8jCY5RCLAvmcz604=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SC1wb04vPFRHvA69idHFJ/D6TQHtUQk5KfrhqDEopc=;
        b=V0Xn7ODIuhsxUoXRXYKrgaXvWtSXaJoS+vueir01umY2dGjL7tfAz/S57GUbZi6cPl
         2B4V8BkKu72wiaFc1ImH6mw97eIv88FDIy5Cvva30cGvGF062ipfJJmV2gsOYVjW66a4
         b30m7o4HTSwVTa0DzQLJ+4KhPi3SNWqaT9g8lcJ+m+ex90ARWayfchd+erNhTmGhLaan
         gTdsxqBBIgHDdbGDQpXctx2yF+plD8ZCEwLzferVhIhhaojW4jmNc3zfWslHVSf5gJOu
         a4LzfueyjcZ4jHVA38wvjWEi66JyyplQSnq+p/McRm00ZttPWvYdiR9uym56g6mb7Kdl
         gqGQ==
X-Gm-Message-State: ANhLgQ0LITi7KmjLg+Xhr3Qlp7ylw1lN1QZocjhTyKPmzskRqqyWRIp7
        YzCGKumsy9wQSgRPPnnZM0Mueg==
X-Google-Smtp-Source: ADFU+vszNuc31kIyM2RoqVUpLdVvAYIJ6JetNU3ZOQhTJ5Je0FGvESstvuE4ZqfTJltehBQY4GpxHg==
X-Received: by 2002:a37:db0a:: with SMTP id e10mr9787278qki.273.1585535618038;
        Sun, 29 Mar 2020 19:33:38 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 07/18] rcu/tree: Simplify debug_objects handling
Date:   Sun, 29 Mar 2020 22:32:37 -0400
Message-Id: <20200330023248.164994-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to prepare for future changes for headless RCU support, make the
debug_objects handling in kfree_rcu use the final 'pointer' value of the
object, instead of depending on the head.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3fb19ea039912..95d1f5e20d5ec 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2825,7 +2825,6 @@ struct kfree_rcu_bulk_data {
 	unsigned long nr_records;
 	void *records[KFREE_BULK_MAX_ENTR];
 	struct kfree_rcu_bulk_data *next;
-	struct rcu_head *head_free_debug;
 };
 
 /**
@@ -2875,11 +2874,11 @@ struct kfree_rcu_cpu {
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
 static __always_inline void
-debug_rcu_head_unqueue_bulk(struct rcu_head *head)
+debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 {
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	for (; head; head = head->next)
-		debug_rcu_head_unqueue(head);
+	for (int i = 0; i < bhead->nr_records; i++)
+		debug_rcu_head_unqueue((struct rcu_head *)(bhead->records[i]));
 #endif
 }
 
@@ -2909,7 +2908,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; bhead; bhead = bnext) {
 		bnext = bhead->next;
 
-		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
+		debug_rcu_bhead_unqueue(bhead);
 
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
@@ -2931,14 +2930,15 @@ static void kfree_rcu_work(struct work_struct *work)
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
+		void *ptr = (void *)head - offset;
 
 		next = head->next;
-		debug_rcu_head_unqueue(head);
+		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
-			kvfree((void *)head - offset);
+			kvfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3062,18 +3062,11 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
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
@@ -3097,14 +3090,17 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	void *ptr;
 
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
 		spin_lock(&krcp->lock);
 
+	ptr = (void *)head - (unsigned long)func;
+
 	// Queue the object but don't yet schedule the batch.
-	if (debug_rcu_head_queue(head)) {
+	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
@@ -3121,8 +3117,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (is_vmalloc_addr((void *) head - (unsigned long) func) ||
-			!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func)) {
+	if (is_vmalloc_addr(ptr) ||
+	    !kfree_call_rcu_add_ptr_to_bulk(krcp, head, func)) {
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
-- 
2.26.0.rc2.310.g2932bb562d-goog

