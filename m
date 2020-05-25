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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC9CC433E1
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06299206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjVzJp58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbgEYVso (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbgEYVs2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B0C061A0E;
        Mon, 25 May 2020 14:48:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v16so22189532ljc.8;
        Mon, 25 May 2020 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eb8xq22KfAG6fp/WMem/0LimDG8xrTCxTTXXT11xHa8=;
        b=HjVzJp58HalgeSnFZ8TYNJeitRlinF1ZZkF3izRhYWt6NkUIcYxLzlJoz83pHJ1BhQ
         qs7zVnTCqZK7GtdZZCXle1gps0THusL1zrgZuTx63iamYpvBISPkP3J+gCTt7J0waglJ
         zm6U8EcJ2YZkrdedr9Tk4x2qU8xN8p24IB4in/1jru8iH50Eimv+4CTLSncK2ktoMFdU
         uWKFdC5LLSdFDv62aEdiJ3wzU26JFCT7Ptb+MgN8FySCeLwTLU23zrKdzH8jwuMmJZHx
         bGD0ZnkiqXtvi9Ld5J/siBePtEoJQpWfh0L8ooWrKPC1xSV+PoF4VAhi4MNb9zv/aJDy
         mgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb8xq22KfAG6fp/WMem/0LimDG8xrTCxTTXXT11xHa8=;
        b=sNX/wMMq2XWIHeE53z/Z+IL0NBUWaLRBJw82BYsS/aa9EFBQvkYgzzRqN7Xl9qzHqN
         9F6dSGNPDpmiU+EamrEm+j/C9oq7DPr85OfKgCjikGXRlP9kgBujorVetpQKWYMf+giR
         1w6DsVZl/VZexDgw8RSi4nv2eY76rhRuOQ45W6XkIJOc0zREZpPjBw+43nkGo+iztNx1
         fs8tfNO3+CmemkaVlzan97h4/XujYJeWHMY8xxRL51TW+8yLG79HTNrFsJ4KHepfd9Wp
         9RJfErNJKm2l6QUu/wC6X1tBJMUU493iVtPc5Xe3hIIUjCB+6QSMEeUj1Q5rzc041cLw
         iUkg==
X-Gm-Message-State: AOAM530cmLYZ2+g3s+0SN3ur8EwYL2Ng+14LqJf5R/7f0OK7XRlf2x5O
        dbrGPHFZCCKSHd7TDwpVC9HKEj1vCLiOmQ==
X-Google-Smtp-Source: ABdhPJxfYdA2lsbxwcu/cCC/8bfQhOexs2m2EigiwkWGZU776Hnc0bXM379NuIVU5PU462pBuLiVPQ==
X-Received: by 2002:a2e:9818:: with SMTP id a24mr1882342ljj.161.1590443306082;
        Mon, 25 May 2020 14:48:26 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:25 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 14/16] rcu: Support reclaim for head-less object
Date:   Mon, 25 May 2020 23:47:58 +0200
Message-Id: <20200525214800.93072-15-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Update the kvfree_call_rcu() function with head-less support.
This allows RCU to reclaim objects without an embedded rcu_head.

tree-RCU:
We introduce two chains of arrays to store SLAB-backed and vmalloc
pointers, each.  Storage in either of these arrays does not require
embedding an rcu_head within the object.

Maintaining the arrays may become impossible due to high memory
pressure. For such cases there is an emergency path. Objects with
rcu_head inside are just queued on a backup rcu_head list. Later on
that list is drained. As for the head-less variant, as the current
context can sleep, the following emergency measures are applied:
   a) Synchronously wait until a grace period has elapsed.
   b) Call kvfree().

tiny-RCU:
For double argument calls, there are no new changes in behavior. For
single argument call, kvfree() is directly inlined on the current
stack after a synchronize_rcu() call. Note that for tiny-RCU, any
call to synchronize_rcu() is actually a quiescent state, therefore
it does nothing.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcutiny.h | 18 ++++++++++++++++-
 kernel/rcu/tree.c       | 45 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 00bbd0e328c8..e7e4ec5938af 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -31,9 +31,25 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
+/*
+ * Add one more declaration of kvfree() here. It is
+ * not so straight forward to just include <linux/mm.h>
+ * where it is defined due to getting many compile
+ * errors caused by that include.
+ */
+extern void kvfree(const void *addr);
+
 static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	call_rcu(head, func);
+	if (head) {
+		call_rcu(head, func);
+		return;
+	}
+
+	// kvfree_rcu(one_arg) call.
+	might_sleep();
+	synchronize_rcu();
+	kvfree((void *) func);
 }
 
 void rcu_qs(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da29e6078392..2459830a3851 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3180,6 +3180,13 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			if (IS_ENABLED(CONFIG_PREEMPT_RT))
 				return false;
 
+			/*
+			 * NOTE: For one argument of kvfree_rcu() we can
+			 * drop the lock and get the page in sleepable
+			 * context. That would allow to maintain an array
+			 * for the CONFIG_PREEMPT_RT as well if no cached
+			 * pages are available.
+			 */
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
@@ -3219,16 +3226,33 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
+		 * objects: it can be used from might_sleep() context
+		 * only. For other places please embed an rcu_head to
+		 * your data.
+		 */
+		might_sleep();
+		ptr = (unsigned long *) func;
+	}
+
 	krcp = krc_this_cpu_lock(&flags);
-	ptr = (void *)head - (unsigned long)func;
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
+
+		// Mark as success and leave.
+		success = true;
 		goto unlock_return;
 	}
 
@@ -3236,10 +3260,16 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
+	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	if (!success) {
+		if (head == NULL)
+			// Inline if kvfree_rcu(one_arg) call.
+			goto unlock_return;
+
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
+		success = true;
 	}
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
@@ -3253,6 +3283,17 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
+
+	/*
+	 * Inline kvfree() after synchronize_rcu(). We can do
+	 * it from might_sleep() context only, so the current
+	 * CPU can pass the QS state.
+	 */
+	if (!success) {
+		debug_rcu_head_unqueue((struct rcu_head *) ptr);
+		synchronize_rcu();
+		kvfree(ptr);
+	}
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
-- 
2.20.1

