Return-Path: <SRS0=wCpI=5A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6BFC18E5B
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71089206EB
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+wR7ORw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgCOSSy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:18:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34356 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgCOSSy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 14:18:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id f3so1805347lfc.1;
        Sun, 15 Mar 2020 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcieLQwgRPobTGTFCGVDjA15PZoxugef2NVvCh5oHyg=;
        b=F+wR7ORw89SUUyhXdX3kXNqVbSugrhsLf+OLAwBGxbTvWNziZQknfYEQy0j4eRck/N
         jJXh20EOq/ZcxPGu2AuZBe/affKQMwK5tnmXHQSKbSWgjJOA4ayz0w5HECOfKdgCIImj
         F8b82w5AJTEwN3MJ8Gn8G4NRWz+UoOwQJfGYiHpGSowtr7cpK729NdTNG2IHo9suspQr
         qp7+DE+gmLnrSgb1s4P4ono4tlyonQYJP8IwWyS15e/hbkQ4N0d5pHQUbXF8AVD2c8kP
         bIknF4PtXbXnABGcFWqozBomWTZl+nrMum4eb2StAaRStkRkb1M8QZ1dxkvGhxWpRlj/
         ke3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcieLQwgRPobTGTFCGVDjA15PZoxugef2NVvCh5oHyg=;
        b=f3z/sFCOVGJLP67PN5B5kycK62P1MV7tuwarOekE/pj7yMIeoND7/soGawGMX8Gq0n
         9PA0QIdZSCGQuIwP3IHDqRFh9Q6vl3M8wpSASW21+2s1bRKYCbcoEKM1aN5iuN/oDD9k
         bRwczm11ZpxSosyuPaJ/SYwWtxwFGfKkWBWYtSft5yMakh/fwGDaujQlyoHJY/jGSHvA
         pJf4M90zjk2H2My2REFMqm+FG8vqn59yPE98l7RsCMMuauOmpRc9I/y65fw3KUYgV5vY
         ESs5ua8ROSYft4BezKQqcCfVwy5jeQzRyLEJPucfj48of/g0CUacUaHqgbXkR/99sNNw
         bvVw==
X-Gm-Message-State: ANhLgQ1NjFXAJgEZKsNV+5aluP8+njHPZgan09wZ8sybb0G9tCmGVG4E
        +wXDIvtT3l1a+p8TGmug5zeFkjGa6a+9mg==
X-Google-Smtp-Source: ADFU+vskGyffAvBa1bBcP45iJ3QAoF/GEnt3fKiez/l55yWIYhj9ZAQyLrguh4z6SvZP60KYtomW4Q==
X-Received: by 2002:a19:f70d:: with SMTP id z13mr2253159lfe.58.1584296330653;
        Sun, 15 Mar 2020 11:18:50 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o15sm3040629ljj.55.2020.03.15.11.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 11:18:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 2/6] rcu: introduce kvfree_rcu() interface
Date:   Sun, 15 Mar 2020 19:18:36 +0100
Message-Id: <20200315181840.6966-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315181840.6966-1-urezki@gmail.com>
References: <20200315181840.6966-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

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
---
 include/linux/rcupdate.h |  9 +++++++++
 kernel/rcu/tiny.c        |  3 ++-
 kernel/rcu/tree.c        | 17 ++++++++++++-----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2be97a83f266..bb270221dbdc 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -845,6 +845,15 @@ do {									\
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
index dd572ce7c747..4b99f7b88bee 100644
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
index 2f4c91a3713a..1c0a73616872 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2899,9 +2899,9 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -2912,7 +2912,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
-			kfree((void *)head - offset);
+			kvfree((void *)head - offset);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3084,10 +3084,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
2.20.1

