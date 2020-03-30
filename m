Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36270C2D0ED
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C72206DB
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fxT0FW2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgC3Ce3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39240 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgC3Cdi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id f20so13936345qtq.6
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7es2W9CEqIB4GMVROiAy2JZJ57uZN4pFanE1V1uKhA=;
        b=fxT0FW2SkmPY/tTctVOOiNEaCQkEJhYBD9Ljg3DTwuJpXM6Z+pQuU2xjzrWckST7Wt
         kTky1ILPKzjvatfadFjqzTvUwv+sQZt7v+UsnxOvCkxsgAJran4D5XewUjyU9oT8+Jl+
         E6huwFcNFYQ0MuaqQftjvXLOI6/gzgK68TEnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7es2W9CEqIB4GMVROiAy2JZJ57uZN4pFanE1V1uKhA=;
        b=hTukuvWfYnDnqrKmNoxkb5Bq3oC4Ypf8KnLpwBA2ECM2nXOTDHb5z3dOXIEDKkMAag
         6OUpumyclwGx0w2rPHYS+yG+os5tMM0uNcPZyQGphjmscgSLQfUayQDt7Jaug8emPnSe
         apigko1Tfy/3+wP1g3/MoQBIiFooKOWD6Bw8qMD+ZsOfRkvrxV/XqMy3HSVrqXuR4dQW
         7L6DBdVu8jL6cRVJCC8mbrUhK4mZbmRNnXfwsl6KNONZ06iBDaGOm77y4pn7NFRZdqw7
         jUn4m3azlQi0iK5MP7PITrLFC0jNeSppnjuPTwvxePx0Lfavqg7B1SS5bes20sAtTJzg
         L/4w==
X-Gm-Message-State: ANhLgQ3jCuhJOIdtn62hyvpjjpB/lF1owcna6Dw5bz30w8Siv5AMeIK4
        leatXGHzl5ifFBCAIY8Vv9ZwwQ==
X-Google-Smtp-Source: ADFU+vs2ndobSCzogyfpMzEQcEldd3+b0TiV6qhu47wRBO4t65Nlw0iw94d+x/RbDFy/qTpIQuCBmQ==
X-Received: by 2002:aed:3c4b:: with SMTP id u11mr9819279qte.208.1585535616115;
        Sun, 29 Mar 2020 19:33:36 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:35 -0700 (PDT)
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
Subject: [PATCH 05/18] rcu: Rename kfree_call_rcu() to the kvfree_call_rcu().
Date:   Sun, 29 Mar 2020 22:32:35 -0400
Message-Id: <20200330023248.164994-6-joel@joelfernandes.org>
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

The reason is, it is capable of freeing vmalloc()
memory now.

Do the same with __kfree_rcu() macro, it becomes
__kvfree_rcu(), the reason is the same as pointed
above.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 8 ++++----
 include/linux/rcutiny.h  | 2 +-
 include/linux/rcutree.h  | 2 +-
 kernel/rcu/tree.c        | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c6f6a195cb1cd..edb6eeba49f83 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -830,10 +830,10 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 /*
  * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
  */
-#define __kfree_rcu(head, offset) \
+#define __kvfree_rcu(head, offset) \
 	do { \
 		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
-		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
+		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
 	} while (0)
 
 /**
@@ -852,7 +852,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kfree_rcu().  If this error is triggered, you can
+ * be generated in __kvfree_rcu(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -867,7 +867,7 @@ do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
 	if (___p)							\
-		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
 /**
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d77e11186afd1..5ba0bcb231976 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,7 +34,7 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
-static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	call_rcu(head, func);
 }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 45f3f66bb04df..3a7829d69fef8 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
 }
 
 void synchronize_rcu_expedited(void);
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1209945a34bfd..3fb19ea039912 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3082,18 +3082,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 }
 
 /*
- * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
+ * Queue a request for lazy invocation of kfree_bulk()/kvfree() after a grace
  * period. Please note there are two paths are maintained, one is the main one
  * that uses kfree_bulk() interface and second one is emergency one, that is
  * used only when the main path can not be maintained temporary, due to memory
  * pressure.
  *
- * Each kfree_call_rcu() request is added to a batch. The batch will be drained
+ * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
  * be free'd in workqueue context. This allows us to: batch requests together to
  * reduce the number of grace periods during heavy kfree_rcu() load.
  */
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
@@ -3142,7 +3142,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(kfree_call_rcu);
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
-- 
2.26.0.rc2.310.g2932bb562d-goog

