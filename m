Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3C4C54FCE
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880DF206F9
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5d3DlMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgCWLgk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:36:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41976 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgCWLgi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Mar 2020 07:36:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id z22so9925490lfd.8;
        Mon, 23 Mar 2020 04:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeerbHA789QqCt+ZvYPemD2jw89P7msksfF9sWBneFs=;
        b=Y5d3DlMnpQInC2H8nKjIrnogwXZqagx5Bgq1i/mYJf4YyeUXxA6PuyE2CEuC3ukvfD
         YihdtW0+yWX0oruTeI++aBf7HaoMKqC4mL6ehw08GwOmoNYajcAaWQwfs+rSz+FoJzFm
         T4cTuEQUyOCKV1h1Jaufv3Fp2f4LeWctLL4qi8mxgQaM1hqsBNemd4jLohbWzSG4Jy6l
         f+VRxob9f3i0FDbQc2aFh8ua6egfZNBeGhQHazK5H+h40/naKr5/K52/wF+1nZA9pSYL
         Ti7Dl39dyQRprMgWYs0Y5rnxhhncaHPfl6ab3Pmj5k8ciWcTl7J65iAtmZZedgXoHMiU
         PNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeerbHA789QqCt+ZvYPemD2jw89P7msksfF9sWBneFs=;
        b=KvcOY60F6+fRXBRFj8brGewMYwP3rbfZAC34RcC2hb9dddsabUx7kXOEC7cAJ0TlI9
         exfiDkEj+PGUvyOOhzCAlCYtXbAMmgdMoZo+KEASYF06Xg5laxC9+NfFgXj/ss4t1TJE
         25/LtYfKEqCM1S8vHBJvPtLRsSR6u5WFf8hkXuFDSzvVdmqgym3ooOMZXkkzRjCRE5LJ
         czqEXNeeu9gRBwIUWJrErMoJIkiJK8fcaJaClTqSU/9kJceqpf/cPjKHnjLhhuDshqBw
         cmmhc5ywRuPGWYaPw0RhTdPXEWApW38OFnlrn855/XIoqMJsb8P0nQMh/RKRZD9UjioD
         vcmQ==
X-Gm-Message-State: ANhLgQ0uzBRDTX5AWHcwFJMAQsJbIUnxz4mIDuHQZBEZ5TrHGokv0tur
        +n/jNijFEsxvfQK6H0KekyPtShWYYXE=
X-Google-Smtp-Source: ADFU+vtpZ76jZPBZZRvN+X7u8tZYTBIkD5o7HK5HtQ4sYl6OUhfXtEFLwN2h/ohKlICYbLX10lu5Qw==
X-Received: by 2002:a19:148:: with SMTP id 69mr5179274lfb.143.1584963395397;
        Mon, 23 Mar 2020 04:36:35 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r23sm8079268lfi.89.2020.03.23.04.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:36:35 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 4/7] rcu/tree: support reclaim for head-less object
Date:   Mon, 23 Mar 2020 12:36:18 +0100
Message-Id: <20200323113621.12048-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323113621.12048-1-urezki@gmail.com>
References: <20200323113621.12048-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Update the kvfree_call_rcu() with head-less support, it
means an object without any rcu_head structure can be
reclaimed after GP.

To store pointers there are two chain-arrays maintained
one for SLAB and another one is for vmalloc. Both types
of objects(head-less variant and regular one) are placed
there based on the type.

It can be that maintaining of arrays becomes impossible
due to high memory pressure. For such reason there is an
emergency path. In that case objects with rcu_head inside
are just queued building one way list. Later on that list
is drained.

As for head-less variant. Such objects do not have any
rcu_head helper inside. Thus it is dynamically attached.
As a result an object consists of back-pointer and regular
rcu_head. It implies that emergency path can detect such
object type, therefore they are tagged. So a back-pointer
could be freed as well as dynamically attached wrapper.

Even though such approach requires dynamic memory it needs
only sizeof(unsigned long *) + sizeof(struct rcu_head) bytes,
thus SLAB is used to obtain it. Finally if attaching of the
rcu_head and queuing get failed, the current context has
to follow might_sleep() annotation, thus below steps could
be applied:
   a) wait until a grace period has elapsed;
   b) direct inlining of the kvfree() call.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 94 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 869a72e25d38..5a64c92feafc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2892,19 +2892,34 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * when we could not allocate a bulk array.
 	 *
 	 * Under that condition an object is queued to the
-	 * list instead.
+	 * list instead. Please note that head-less objects
+	 * have dynamically attached rcu_head, so they also
+	 * contain a back-pointer that has to be freed.
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
-		void *ptr = (void *)head - offset;
+		bool headless;
+		void *ptr;
 
 		next = head->next;
+
+		/* We tag the headless object, if so adjust offset. */
+		headless = (((unsigned long) head - offset) & BIT(0));
+		if (headless)
+			offset -= 1;
+
+		ptr = (void *) head - offset;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
+
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
+			if (headless)
+				kvfree((void *) *((unsigned long *) ptr));
+
 			kvfree(ptr);
+		}
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3053,6 +3068,25 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	return true;
 }
 
+static inline struct rcu_head *
+attach_rcu_head_to_object(void *obj)
+{
+	unsigned long *ptr;
+
+	ptr = kmalloc(sizeof(unsigned long *) +
+			sizeof(struct rcu_head), GFP_NOWAIT | __GFP_NOWARN);
+
+	if (!ptr)
+		ptr = kmalloc(sizeof(unsigned long *) +
+				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
+
+	if (!ptr)
+		return NULL;
+
+	ptr[0] = (unsigned long) obj;
+	return ((struct rcu_head *) ++ptr);
+}
+
 /*
  * Queue a request for lazy invocation of appropriate free routine after a
  * grace period. Please note there are three paths are maintained, two are the
@@ -3071,20 +3105,37 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 	bool expedited_drain = false;
+	bool success;
 	void *ptr;
 
+	if (head) {
+		ptr = (void *) head - (unsigned long) func;
+	} else {
+		/*
+		 * Please note there is a limitation for the head-less
+		 * variant, that is why there is a clear rule for such
+		 * objects:
+		 *
+		 * use it from might_sleep() context only. For other
+		 * places please embed an rcu_head to your structures.
+		 */
+		might_sleep();
+		ptr = (unsigned long *) func;
+	}
+
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
 		spin_lock(&krcp->lock);
 
-	ptr = (void *)head - (unsigned long)func;
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
+
+		/* Mark as success and leave. */
+		success = true;
 		goto unlock_return;
 	}
 
@@ -3092,7 +3143,22 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr)) {
+	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	if (!success) {
+		/* Is headless object? */
+		if (head == NULL) {
+			head = attach_rcu_head_to_object(ptr);
+			if (head == NULL)
+				goto unlock_return;
+
+			/*
+			 * Tag the headless object. Such objects have a back-pointer
+			 * to the original allocated memory, that has to be freed as
+			 * well as dynamically attached wrapper/head.
+			 */
+			func = (rcu_callback_t) (sizeof(unsigned long *) + 1);
+		}
+
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
@@ -3104,15 +3170,15 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		 * appropriate free calls.
 		 */
 		expedited_drain = true;
+		success = true;
 	}
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-	    !krcp->monitor_todo) {
+			!krcp->monitor_todo) {
 		krcp->monitor_todo = true;
-
 		schedule_delayed_work(&krcp->monitor_work,
 			expedited_drain ? 0:KFREE_DRAIN_JIFFIES);
 	}
@@ -3121,6 +3187,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (krcp->initialized)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
+
+	/*
+	 * High memory pressure, so inline kvfree() after
+	 * synchronize_rcu(). We can do it from might_sleep()
+	 * context only, so the current CPU can pass the QS
+	 * state.
+	 */
+	if (!success) {
+		debug_rcu_head_unqueue(ptr);
+		synchronize_rcu();
+		kvfree(ptr);
+	}
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
-- 
2.20.1

