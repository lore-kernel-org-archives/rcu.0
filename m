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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFF9C8300E
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A13220737
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7vt3KAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD1U7u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgD1U7t (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E28C03C1AC;
        Tue, 28 Apr 2020 13:59:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w20so269181ljj.0;
        Tue, 28 Apr 2020 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcJCHqE992p8lsmYiNcd24tMBqJtWQITQ3c5M8uA1SE=;
        b=B7vt3KAj4STTD+aKk+oKLMBs8qtai99+vCn8DipCi33bQwwq8BigFQl81rlWBL8xxm
         5XMRocUMMayL6zNBfm8OnD5TDM6DSKI0IpCsuXRept5MT/XdGUKtiPMkbvt60gd5dq7O
         J1fDvz0SaOMR9WdM0zfuglp5AG/s4mH9e85cU5CT18sNbyTiVWN7lhYDQVVQ3CDH1ehB
         X4ON7co7BedfN0OLXCG5hwNQabjo2tdqaRqOpbKUSSrYTH6tV9P1jPvDlf+sLgzoENaB
         T4kOKoIQxciE6zMh912qt9MwSEmpnpTfeuxC4eTn0tSzskHowIUzt3PV0p5W3M82w6MV
         5+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcJCHqE992p8lsmYiNcd24tMBqJtWQITQ3c5M8uA1SE=;
        b=XFwm2qvuDV8zsefHRF3S5H52stXzctLf5m4KUBVnC0EmYwC2RIneMmFbn2oMBZLpH1
         vqkJDOHhCFXmqM8OILLmRw7X/7eH/D1BCWdg4WBbrgfAcqck0ONAazhAGJt2/pMSQMhk
         NZc5FEV+QD7ttu1nOGwzPOTr1KPIXJQiyO13z+1zZTcymPclWsWWXdh1KqLS52q4eMA4
         ppuFtAbbUnwS9yZIYE3W8RsmqsOibIHS1k0bw/X7q02sdUMOKY6FNxm0h2rgO1v8QwDP
         GniHhYoSxUeromrCIj6uA5A9zWmIdxXn+g5Li/5zLqanHbq9DBEI8hzUO11PXq5eSogO
         V7EQ==
X-Gm-Message-State: AGi0PuYcDaTga5zVQznAnOjzKoCYkXH+h6ikKd5y4lZLTv1gTIfPNpgA
        jQnYfwFeUkl9F0iG4vHpAZLwBLjHFZjnCA==
X-Google-Smtp-Source: APiQypIZsg28yYvjCdQRmrdaF5z9OdGgbIG1meF5iEoqlsZSntvvbPCTGsJPR0M5i7zF9h+4vPIP2A==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr19047796lji.279.1588107587186;
        Tue, 28 Apr 2020 13:59:47 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:46 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 15/24] rcu: Rename kfree_call_rcu() to the kvfree_call_rcu().
Date:   Tue, 28 Apr 2020 22:58:54 +0200
Message-Id: <20200428205903.61704-16-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

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
 kernel/rcu/tree.c        | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1d25e6c23ebd..b344fc800a9b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -835,10 +835,10 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
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
index 3465ba704a11..0c6315c4a0fe 100644
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
index fbc26274af4d..4d2732442013 100644
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
index 5f53368f2554..51726e4c3b4d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3251,12 +3251,12 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
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
@@ -3295,7 +3295,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
 }
-EXPORT_SYMBOL_GPL(kfree_call_rcu);
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
-- 
2.20.1

