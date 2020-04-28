Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD7C83004
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838DF2072A
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6UTV9hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgD1U7z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726968AbgD1U7z (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD452C03C1AC;
        Tue, 28 Apr 2020 13:59:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so222210ljl.6;
        Tue, 28 Apr 2020 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=66vSg9Njt1sZCB7M+dj1UlLLZ6BR/zJPh4B9KJb+CwY=;
        b=d6UTV9hymGMssr4fjOWqvH+tmH1+vbRR4+2M9oD8d4EnJPh0SHe7iRFDylZiDMGjHA
         JlfOILnK2hmlYxoV47p3bLx2RydaXS6tJMVboKMWS3J8iNzcIpksYLgp/hd+/iSk52Bc
         FZhx5LS9U3kAaoLzsoB7gF3Q0P1aqNetJLXUwXOBjG3pjd0reRTStlPB2nNHtf9WfeoT
         2EHBK9+AmhcjSLEoej6QDrJTRpP2yLaiB4jWVvMEkjn88sYmZ4aIjGiBMeZZ7I/uEEYs
         9rUx8KLuPJKJ3kSF3zVDbspnnrRzPN9vo8j5JP4VGPefcIr7ikAmm1mmSg//aGSaCJU5
         UzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66vSg9Njt1sZCB7M+dj1UlLLZ6BR/zJPh4B9KJb+CwY=;
        b=krCY5d4nYi12OVJFnuZ9oLlcL8+p/bUx+9JI+d6idVAcOYENZ7RphbQovYcOCx/+A4
         THVErlJWST3zw7ebFhpPhCD51uIPdMfdNPLyIfAUV6NEubhOT9AJ+xQLJrnYyUiDdIWT
         CWfjOxnKkL14RWPRxvke3lnYT6xplT1NeWIYqTj1FWPXxAUp3cWTORdsENpmsVhI4e0C
         zntvDiDW8L7h3YT9OwPP74LczN4vMM8zcHEmBHhChrtu32y5oTUkgO822k1qhPA93NiF
         y4KiATXtTjcZXbEkoTTR2irTnI5hc8yPARwQDbgI3KzNxdbRIz1IXwVyrE48fWjKfCzb
         cBZA==
X-Gm-Message-State: AGi0Pubs9Xr2hQAVrEbf622JJV/gCVaTEOI0xCORx2l1LpjpumnaWsnY
        TywOx1LozL4h36PRXRDe59HYowAJFVZWag==
X-Google-Smtp-Source: APiQypJwT3gU3ag2Y4efeBkFASGSObeuAOyEJgCNhNbI+6xXdAvu4anqfWejz6vVzioHPMcJxp3dYQ==
X-Received: by 2002:a2e:9818:: with SMTP id a24mr18725795ljj.126.1588107592738;
        Tue, 28 Apr 2020 13:59:52 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:51 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 19/24] rcu/tree: Support reclaim for head-less object
Date:   Tue, 28 Apr 2020 22:58:58 +0200
Message-Id: <20200428205903.61704-20-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
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

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 102 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51726e4c3b4d..501cac02146d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3072,15 +3072,31 @@ static void kfree_rcu_work(struct work_struct *work)
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
+
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
+			/*
+			 * If headless free the back-pointer first.
+			 */
+			if (headless)
+				kvfree((void *) *((unsigned long *) ptr));
+
 			kvfree(ptr);
+		}
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3221,6 +3237,13 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			if (IS_ENABLED(CONFIG_PREEMPT_RT))
 				return false;
 
+			/*
+			 * TODO: For one argument of kvfree_rcu() we can
+			 * drop the lock and get the page in sleepable
+			 * context. That would allow to maintain an array
+			 * for the CONFIG_PREEMPT_RT as well. Thus we could
+			 * get rid of dynamic rcu_head attaching code.
+			 */
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
@@ -3244,6 +3267,23 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	return true;
 }
 
+static inline struct rcu_head *
+attach_rcu_head_to_object(void *obj)
+{
+	unsigned long *ptr;
+
+	ptr = kmalloc(sizeof(unsigned long *) +
+			sizeof(struct rcu_head), GFP_NOWAIT |
+				__GFP_RECLAIM |	/* can do direct reclaim. */
+				__GFP_NORETRY |	/* only lightweight one.  */
+				__GFP_NOWARN);	/* no failure reports. */
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
@@ -3260,16 +3300,34 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
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
+		 * it can be used from might_sleep() context only. For
+		 * other places please embed an rcu_head to your data.
+		 */
+		might_sleep();
+		ptr = (unsigned long *) func;
+	}
+
 	krcp = krc_this_cpu_lock(&flags);
-	ptr = (void *)head - (unsigned long)func;
 
 	/* Queue the object but don't yet schedule the batch. */
 	if (debug_rcu_head_queue(ptr)) {
 		/* Probable double kfree_rcu(), just leak. */
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
+
+		/* Mark as success and leave. */
+		success = true;
 		goto unlock_return;
 	}
 
@@ -3277,10 +3335,34 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
+	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	if (!success) {
+		if (head == NULL) {
+			/*
+			 * Headless(one argument kvfree_rcu()) can sleep.
+			 * Drop the lock and tack it back. So it can do
+			 * direct lightweight reclaim.
+			 */
+			krc_this_cpu_unlock(krcp, flags);
+			head = attach_rcu_head_to_object(ptr);
+			krcp = krc_this_cpu_lock(&flags);
+
+			if (head == NULL)
+				goto unlock_return;
+
+			/*
+			 * Tag the headless object. Such objects have a
+			 * back-pointer to the original allocated memory,
+			 * that has to be freed as well as dynamically
+			 * attached wrapper/head.
+			 */
+			func = (rcu_callback_t) (sizeof(unsigned long *) + 1);
+		}
+
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
+		success = true;
 	}
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
@@ -3294,6 +3376,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
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

