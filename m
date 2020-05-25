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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF59C433E0
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85359206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1kObcKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbgEYVsv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgEYVs0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6005C061A0E;
        Mon, 25 May 2020 14:48:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so22188640ljj.1;
        Mon, 25 May 2020 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVqcxSq1IHpUHDxIjujLZwaSnFa1mBd5ODxuoqnxOWA=;
        b=W1kObcKMmw8db+H82bam2fXJtsL+RpuxspHFM85/znh15bqmGkM2LK8yiecdHxavau
         5rbjeeajSMABKzCcMX0ppELr77h303g+JN4aOaln/vZw83FJj+NiX40fsk1DzGTKaaA6
         x5HDk/LCR5djU6Xrczr6HmtesEspGaWmBDmbsEjjSZMIC4u02J+YBsNj3QM2dqpQxO9g
         LMTcTw9D5UaI8L3bqGdD1V1y6f2/BXZIxnwQjXFS790lBc+RM41Uq379XYAvH575i3Cf
         lwZpdL3SgNohpk8XjXVoichtVmT0Rb8IsVKrh1hS/r57tLNBg0HmPQZtdmGtc8fIkJ0z
         pFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVqcxSq1IHpUHDxIjujLZwaSnFa1mBd5ODxuoqnxOWA=;
        b=KWkbmnLYmjSNEoGDnLZZeRIv+P7TXQ/PrHpGxFbENEloJ3ohVJ3xuizw68RjXHoROo
         uE13rNOqnJzMC3P3YsLfWZ8FQwU2s1MaPMU8M9cal0TOjfp7rqi16oJk8k1hOtlcnUAx
         +fXFRHWMkQJlwktsDMhucasPXlbqXAeaWq6UX8mXaPqLEg9vexWeg1HVGr9ioQBEFoDS
         Z/Ho1WLKIdujb1QlbciZsLXTvofK5Xj/VLl/O7hgCXMCEiSx/0TtkZ5g373xr7yi5kM4
         ugTE508kBs9hE/cGjamdLJVwH2AFSWy2ravdZUcZghMkysWnZRCl0DxQm9E7Smf6cZ/9
         +0aA==
X-Gm-Message-State: AOAM530CWzumujQjhos+fdRY00y7/UApmQmO3iC5BPbaqvGbulrp52lU
        dLINRBpzUvA4UdJRa120rmPk6JfytH+0Ug==
X-Google-Smtp-Source: ABdhPJy5wxypVh6TqdurvHEZ33pvAl6udqz8cV6qgmsGA6MyBy7ubUq3lXafMzI84W3ObCIKF2Eb6g==
X-Received: by 2002:a2e:1515:: with SMTP id s21mr12431951ljd.306.1590443302949;
        Mon, 25 May 2020 14:48:22 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:22 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 11/16] rcu: Rename *_kfree_callback/*_kfree_rcu_offset/kfree_call_*
Date:   Mon, 25 May 2020 23:47:55 +0200
Message-Id: <20200525214800.93072-12-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The following changes are introduced:

1. Rename rcu_invoke_kfree_callback() to rcu_invoke_kvfree_callback(),
as well as the associated trace events, so the rcu_kfree_callback(),
becomes rcu_kvfree_callback(). The reason is to be aligned with kvfree()
notation.

2. Rename __is_kfree_rcu_offset to __is_kvfree_rcu_offset. All RCU
paths use kvfree() now instead of kfree(), thus rename it.

3. Rename kfree_call_rcu() to the kvfree_call_rcu(). The reason is,
it is capable of freeing vmalloc() memory now. Do the same with
__kfree_rcu() macro, it becomes __kvfree_rcu(), the goal is the
same.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h   | 14 +++++++-------
 include/linux/rcutiny.h    |  2 +-
 include/linux/rcutree.h    |  2 +-
 include/trace/events/rcu.h |  8 ++++----
 kernel/rcu/tiny.c          |  4 ++--
 kernel/rcu/tree.c          | 16 ++++++++--------
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 659cbfa7581a..b344fc800a9b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -828,17 +828,17 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /*
  * Does the specified offset indicate that the corresponding rcu_head
- * structure can be handled by kfree_rcu()?
+ * structure can be handled by kvfree_rcu()?
  */
-#define __is_kfree_rcu_offset(offset) ((offset) < 4096)
+#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
 /*
  * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
  */
-#define __kfree_rcu(head, offset) \
+#define __kvfree_rcu(head, offset) \
 	do { \
-		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
-		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
+		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
 	} while (0)
 
 /**
@@ -857,7 +857,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kfree_rcu().  If this error is triggered, you can
+ * be generated in __kvfree_rcu(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -872,7 +872,7 @@ do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
 	if (___p)							\
-		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
 /*
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8b851904efed..00bbd0e328c8 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -31,7 +31,7 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
-static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	call_rcu(head, func);
 }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 9366fa4d0717..da07f8dc05c6 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
 }
 
 void synchronize_rcu_expedited(void);
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 02dcd119f326..9d34ee810894 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -509,13 +509,13 @@ TRACE_EVENT_RCU(rcu_callback,
 
 /*
  * Tracepoint for the registration of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU type, the second argument
+ * kvfree() form.  The first argument is the RCU type, the second argument
  * is a pointer to the RCU callback, the third argument is the offset
  * of the callback within the enclosing RCU-protected data structure,
  * the fourth argument is the number of lazy callbacks queued, and the
  * fifth argument is the total number of callbacks queued.
  */
-TRACE_EVENT_RCU(rcu_kfree_callback,
+TRACE_EVENT_RCU(rcu_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
 		 long qlen),
@@ -599,12 +599,12 @@ TRACE_EVENT_RCU(rcu_invoke_callback,
 
 /*
  * Tracepoint for the invocation of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU flavor, the second
+ * kvfree() form.  The first argument is the RCU flavor, the second
  * argument is a pointer to the RCU callback, and the third argument
  * is the offset of the callback within the enclosing RCU-protected
  * data structure.
  */
-TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
+TRACE_EVENT_RCU(rcu_invoke_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset),
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4b99f7b88bee..aa897c3f2e92 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -85,8 +85,8 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kfree_rcu_offset(offset)) {
-		trace_rcu_invoke_kfree_callback("", head, offset);
+	if (__is_kvfree_rcu_offset(offset)) {
+		trace_rcu_invoke_kvfree_callback("", head, offset);
 		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9f84ff80bc25..da29e6078392 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2771,8 +2771,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kfree_rcu_offset((unsigned long)func))
-		trace_rcu_kfree_callback(rcu_state.name, head,
+	if (__is_kvfree_rcu_offset((unsigned long)func))
+		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
 	else
@@ -3012,7 +3012,7 @@ static void kfree_rcu_work(struct work_struct *work)
 					bkvhead[i]->records);
 			} else { // vmalloc() / vfree().
 				for (j = 0; j < bkvhead[i]->nr_records; j++) {
-					trace_rcu_invoke_kfree_callback(
+					trace_rcu_invoke_kvfree_callback(
 						rcu_state.name,
 						bkvhead[i]->records[j], 0);
 
@@ -3045,9 +3045,9 @@ static void kfree_rcu_work(struct work_struct *work)
 		next = head->next;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
+		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
 			kvfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
@@ -3210,12 +3210,12 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
  * one, that is used only when the main path can not be maintained temporary,
  * due to memory pressure.
  *
- * Each kfree_call_rcu() request is added to a batch. The batch will be drained
+ * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
  * be free'd in workqueue context. This allows us to: batch requests together to
  * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
  */
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
@@ -3254,7 +3254,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
 }
-EXPORT_SYMBOL_GPL(kfree_call_rcu);
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
-- 
2.20.1

