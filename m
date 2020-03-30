Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F482C2D0E7
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB58720780
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EZj/LdDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgC3Cee (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33089 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgC3Cdg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id c14so13969101qtp.0
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SHLAtJMh4QvoU/qfwuEaXXVei4ZAh6L5O9IfzaCS1DM=;
        b=EZj/LdDIb8HO3LYMjwICXSEVb7Ug5CB6y+9yeeADTqwVWhn/iu4pUuRlJQp8IWjNRv
         ZHhEK+CiED++Nq7ZmpKIIk9AzYqhwZhx4OfWzy5quBd5oc00JjePZcq6xqYMOn+tAGOG
         pzdgsMtvd6/BeARibxZlYR4poF6nx+XzQnoHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHLAtJMh4QvoU/qfwuEaXXVei4ZAh6L5O9IfzaCS1DM=;
        b=D1uwAVB/E5I3Y+aYqBSoc9kFb7bDDWQMny8NuuLtoRTXdmXcb3MtglY5db7NEqLAKQ
         xHAkDxhq4LaxS4RptmrAutnNwNXLM25mOPrvMY7rdT0TscrDp76J6zfCMVKF6VTP40Pi
         1PgoMnvMK61aQV0EUyxI4f5uQvLiQ9TFiqGmyEh0VgNWjQNOHnI5hT7kxrReheqZhXXb
         WVdzzx//7qPz+E5duAkNWr6kLIDV5EmudtokONOkJce4cxCZJsZrpCtFkgBDtMdGZHCB
         IfzE2FfS5Af9TSp+iAl6lVY42K/LVVL4xu8ZhJQHRKmKa3TD410+qrMhhPOHxacPaNH5
         j+Yw==
X-Gm-Message-State: ANhLgQ3obKEAdELpyjaSPnP/waPvhwTMtOVymsTDgfhVYAIhmJX6ty+p
        NBIk5++ScuUQgHcTB5uQieRruA==
X-Google-Smtp-Source: ADFU+vt25iE1CsRcLCeax/iZQAcxxqmJ1TSX0Yl3KB0TJZ2nCudJEfCk4XFJ5v786E3wtic9LAXdDA==
X-Received: by 2002:aed:2535:: with SMTP id v50mr10066898qtc.354.1585535613043;
        Sun, 29 Mar 2020 19:33:33 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 02/18] rcu: Introduce kvfree_rcu() interface
Date:   Sun, 29 Mar 2020 22:32:32 -0400
Message-Id: <20200330023248.164994-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

kvfree_rcu() can deal with an allocated memory that is obtained
via kvmalloc(). It can return two types of allocated memory or
"pointers", one can belong to regular SLAB allocator and another
one can be vmalloc one. It depends on requested size and memory
pressure.

Based on that, two streams are split, thus if a pointer belongs
to vmalloc allocator it is queued to the list, otherwise SLAB
one is queued into "bulk array" for further processing.

The main reason of such splitting is:
    a) to distinguish kmalloc()/vmalloc() ptrs;
    b) there is no vmalloc_bulk() interface.

As of now we have list_lru.c user that needs such interface,
also there will be new comers. Apart of that it is preparation
to have a head-less variant later.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h |  9 +++++++++
 kernel/rcu/tiny.c        |  3 ++-
 kernel/rcu/tree.c        | 17 ++++++++++++-----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 3598bbb5ff407..8b7128d0860e2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -870,6 +870,15 @@ do {									\
 		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
+/**
+ * kvfree_rcu() - kvfree an object after a grace period.
+ * @ptr:	pointer to kvfree
+ * @rhf:	the name of the struct rcu_head within the type of @ptr.
+ *
+ * Same as kfree_rcu(), just simple alias.
+ */
+#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+
 /*
  * Place this after a lock-acquisition primitive to guarantee that
  * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dd572ce7c7479..4b99f7b88beec 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/prefetch.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 #include "rcu.h"
 
@@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	rcu_lock_acquire(&rcu_callback_map);
 	if (__is_kfree_rcu_offset(offset)) {
 		trace_rcu_invoke_kfree_callback("", head, offset);
-		kfree((void *)head - offset);
+		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4eb424eb44acb..2d10c50621c38 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2925,9 +2925,9 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 
 	/*
-	 * Emergency case only. It can happen under low memory
-	 * condition when an allocation gets failed, so the "bulk"
-	 * path can not be temporary maintained.
+	 * vmalloc() pointers end up here also emergency case. It can
+	 * happen under low memory condition when an allocation gets
+	 * failed, so the "bulk" path can not be temporary maintained.
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
@@ -2938,7 +2938,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
-			kfree((void *)head - offset);
+			kvfree((void *)head - offset);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3112,10 +3112,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	/*
+	 * We do not queue vmalloc pointers into array,
+	 * instead they are just queued to the list. We
+	 * do it because of:
+	 *    a) to distinguish kmalloc()/vmalloc() ptrs;
+	 *    b) there is no vmalloc_bulk() interface.
+	 *
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
+	if (is_vmalloc_addr((void *) head - (unsigned long) func) ||
+			!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func)) {
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
-- 
2.26.0.rc2.310.g2932bb562d-goog

