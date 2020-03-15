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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F38C10F29
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF0206B1
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbeKzjFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgCOSS7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:18:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34419 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgCOSS6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 14:18:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id s13so16067019ljm.1;
        Sun, 15 Mar 2020 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ennBV0rolZgo9XEo6yfY9a0l7Nm234OpnkqabpWqAnQ=;
        b=CbeKzjFoPjc28j47jR2EuEgHRqofcBJKJBdHlcpbXtc+nL5wasLzQUcPDcgcFUfQJ5
         Fu2trknPU8OP5E5meKTpkvXP1MCbhkcrPBvD2kae+rQQZPkwVKCUxHJx+DB7mY14GnuQ
         Vakf4kpqz8UqPOHkS+iU/qDObyNINupWMGyh17Ez4NO8jO7lm9RHJy679uwYBuGZe3WH
         o34aLJhRIUYPEN60ISlR9s7MMQcrWIed7OeDwsh1NL2wvR8bXAkrgBA1xXfdLzamCkDT
         tHBrRr++9vFMQb0r+CUZ3ndZX3/FPDAEr7/y4d45uGWnMTqfuGA5cwKo3V2zdD+tHv8S
         4vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ennBV0rolZgo9XEo6yfY9a0l7Nm234OpnkqabpWqAnQ=;
        b=DgyNBOvYg5CNtYg7Q18KuID7dBBFhFF6ipchKIK6QxAFTaW/hqKKx/lmjvOilg/lOW
         qVQNHoguCSSrOdWWFQftuEUFMa61w7BM3jdM8Pth57T+aEqD3tv7bk/9cPJ0yu2KMDRD
         lAgD1bEIo7desjT+7udBNx47MuTqVgf3YrvTwnvCQiPs07TaB/Fpv8VcY4foVJrt8rpi
         sO/brUNxylk/RuKVlnCDM7P1MWVWCcIHtbHIOPQMiJzs7tf28c639MqDffTLT9zfxraB
         t5J3JbgyYuGWWSqdJpDj5RnrSUTQsVyzlwba90s1N/kpclPVQQRPyEOvwFOlE4zsXZ2V
         eIYg==
X-Gm-Message-State: ANhLgQ2+LjvSjJ6vx63PU0ptjjZTDmIsQwViOLHOUADE8oBAYE8krxlP
        Afo3VMfDdTahTuG4Ti50wVq/7j2EvJYWBg==
X-Google-Smtp-Source: ADFU+vuKQPAhcuOBrQYm7BDpZsBgGdsgBpzDGwMBJ70PcdxGaIXnZT96obi45yOZ5qWRXGuEJ9wpGg==
X-Received: by 2002:a2e:9605:: with SMTP id v5mr14447189ljh.0.1584296333786;
        Sun, 15 Mar 2020 11:18:53 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o15sm3040629ljj.55.2020.03.15.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 11:18:53 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 5/6] rcu: rename kfree_call_rcu()/__kfree_rcu()
Date:   Sun, 15 Mar 2020 19:18:39 +0100
Message-Id: <20200315181840.6966-6-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315181840.6966-1-urezki@gmail.com>
References: <20200315181840.6966-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename kfree_call_rcu() to the kvfree_call_rcu().
The reason is, it is capable of freeing vmalloc()
memory now.

Do the same with __kfree_rcu() macro, it becomes
__kvfree_rcu(), the reason is the same as pointed
above.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 8 ++++----
 include/linux/rcutiny.h  | 2 +-
 include/linux/rcutree.h  | 2 +-
 kernel/rcu/tree.c        | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e4961631a44f..6c660fa1f551 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -805,10 +805,10 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
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
@@ -827,7 +827,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kfree_rcu().  If this error is triggered, you can
+ * be generated in __kvfree_rcu(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -842,7 +842,7 @@ do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
 	if (___p)							\
-		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
 /**
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 045c28b71f4f..4cae3dd77173 100644
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
index 45f3f66bb04d..3a7829d69fef 100644
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
index bb9544238396..19e6cb970c38 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3054,18 +3054,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
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
@@ -3112,7 +3112,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(kfree_call_rcu);
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
 void __init kfree_rcu_scheduler_running(void)
 {
-- 
2.20.1

