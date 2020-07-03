Return-Path: <SRS0=lcpH=AO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D40C433E0
	for <rcu@archiver.kernel.org>; Fri,  3 Jul 2020 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1FC207D4
	for <rcu@archiver.kernel.org>; Fri,  3 Jul 2020 14:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIRZRhi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGCOIr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCOIr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Jul 2020 10:08:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5CC08C5C1;
        Fri,  3 Jul 2020 07:08:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bj10so7472067plb.11;
        Fri, 03 Jul 2020 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k/gZbbxBL1FbsdsVnJIS8VLOXXgMCD5muIiPxPAUrTs=;
        b=LIRZRhi1L6yqzhld/qIfRUiAfbyTldJkKDgAEsIiXJYp63oZny4YhOrRj2EySB+Mgf
         e0gYoJx6I74SVZW84PnUPeODuvY6G9wMg4nh6sGlZwOLLj2eNcJkvNPJ06d0NK6VqiXA
         AV41mV7+4J9cGM1dNpLeWhiVSXvuVrSBiot3SKoD5wIz8MbAqgz82JSVj+aw7YnnXXFN
         ob7/xovanE6chUy77OCqFOnfDu6ZJyHp850yy7qwhBfZlySWXr1jCvq598zj6wU/EVsJ
         yYEQ1IPVEfDmyDWzn4JXOHeei159aUQ8+IHh0xsHrCGE/OjTjtsT7lkgrRnyh3npK9E8
         cQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k/gZbbxBL1FbsdsVnJIS8VLOXXgMCD5muIiPxPAUrTs=;
        b=RFXj46aTm86nrYcD9xJTKijNff6YVcfGcDNcMx9efc7+VpSo4UWwhIRkBz5OYZU/Lt
         u6kPEeantWQ+WW8LubEUoEtSZflRt6VWL/sYrTi5XGJwKOf5hkGaeVFOLk25qWWnMu4h
         VqudqUH9pDPzl3Zs6ZkZZTWA7CewBdhVchQpa4ezqHWqeW6xWW8Rxjq5pPHwN+3Gl2eQ
         VY01/GKNhdrfYM5PWw8AzCXlsAzbYqjQ6mXLxIe92E7LpCcOPbnbcJCdZewUooxPblew
         JGEqCyUjdevvaRfcrbRtS9nlVe37GVQL1SRNQUp0ruf6xk95098BFOvrekCmFvYuesNK
         mkzQ==
X-Gm-Message-State: AOAM531qAp2X2piEyoLxIivX7rXEYhy9R9CJ+UQSz3Z9QCtZzouPqyW7
        xkab/QjIj+5v5IbvxEw6BX6jpgmlnQ==
X-Google-Smtp-Source: ABdhPJyr9YJiZW6MQ7ITqj8LfQfQzNVw7oEYTTL4iOiZNLhRm0+ISkeVTjCNFiV4WuHXeJvHUytDyQ==
X-Received: by 2002:a17:902:8f89:: with SMTP id z9mr29549487plo.229.1593785326385;
        Fri, 03 Jul 2020 07:08:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:4071:e03:4d74:9625:37f3:4070:3272])
        by smtp.gmail.com with ESMTPSA id cl17sm10906217pjb.50.2020.07.03.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 07:08:45 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, frextrite@gmail.com,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] rculist : Introduce list/hlist_for_each_entry_srcu() macros
Date:   Fri,  3 Jul 2020 19:38:28 +0530
Message-Id: <20200703140828.7016-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

list/hlist_for_each_entry_rcu() provides an optional cond argument
to specify the lock held in the updater side.
However for SRCU read side, not providing the cond argument results
into false positive as whether srcu_read_lock is held or not is not
checked implicitly. Therefore, on read side the lockdep expression
srcu_read_lock_held(srcu struct) can solve this issue.

However, the function still fails to check the cases where srcu
protected list is traversed with rcu_read_lock() instead of
srcu_read_lock(). Therefore, to remove the false negative,
this patch introduces two new list traversal primitives :
list_for_each_entry_srcu() and hlist_for_each_entry_srcu().

Both of the functions have non-optional cond argument
as it is required for both read and update side, and simply checks
if the cond is true.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 include/linux/rculist.h | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index df587d181844..04a7e5791c39 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -63,9 +63,17 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
 			 "RCU-list traversed in non-reader section!");	\
 	})
+
+#define __list_check_srcu(cond)					 \
+	({								 \
+	RCU_LOCKDEP_WARN(!(cond),					 \
+		"RCU-list traversed without holding the required lock!");\
+	})
 #else
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({ check_arg_count_one(extra); })
+
+#define __list_check_srcu(cond)
 #endif
 
 /*
@@ -383,6 +391,23 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 		&pos->member != (head);					\
 		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
 
+/**
+ * list_for_each_entry_srcu	-	iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ * @cond:	lockdep expression for the lock required to traverse the list.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as list_add_rcu()
+ * as long as the traversal is guarded by srcu_read_lock().
+ */
+#define list_for_each_entry_srcu(pos, head, member, cond)		\
+	for (__list_check_srcu(cond),					\
+	     pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
+		&pos->member != (head);					\
+		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
+
 /**
  * list_entry_lockless - get the struct for this entry
  * @ptr:        the &struct list_head pointer.
@@ -681,6 +706,25 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
 		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
 			&(pos)->member)), typeof(*(pos)), member))
 
+/**
+ * hlist_for_each_entry_srcu - iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ * @cond:	lockdep expression for the lock required to traverse the list.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as hlist_add_head_rcu()
+ * as long as the traversal is guarded by srcu_read_lock().
+ */
+#define hlist_for_each_entry_srcu(pos, head, member, cond)		\
+	for (__list_check_srcu(cond),					\
+	     pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
+			typeof(*(pos)), member);			\
+		pos;							\
+		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
+			&(pos)->member)), typeof(*(pos)), member))
+
 /**
  * hlist_for_each_entry_rcu_notrace - iterate over rcu list of given type (for tracing)
  * @pos:	the type * to use as a loop cursor.
-- 
2.17.1

