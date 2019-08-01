Return-Path: <SRS0=/vWc=V5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFAAC433FF
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CB121726
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VabVNgdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbfHASOd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:14:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbfHASOd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Aug 2019 14:14:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id r22so7044032pgk.10
        for <rcu@vger.kernel.org>; Thu, 01 Aug 2019 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMoKIvzU7SGDzv+dfWl+OsxgZj4/x/JQB4odRYODuPQ=;
        b=VabVNgdyVNxtWaL1BNmduYnPkYBOmdH6UIdMCOApVFDpeMxer77abQ/nb6gonRHrZ/
         oBqNnIcqL14P7nZsLeNsTpVTTKn1sy4r6iJl6/K9nmoZFHOGZfCNzyttKQ/uOuVoslAt
         lkgLZUv0QNH1xlm0ty0avWd7kcud1XcjSoQOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMoKIvzU7SGDzv+dfWl+OsxgZj4/x/JQB4odRYODuPQ=;
        b=kN0jGxGy339AKDNNqDleqSYg2RGnEkcMn8c/6XoSV3yY0Ka5ItspFBtv54a06zB6ue
         Gvg6KwbS1gH6kixq7wbkhhee69n+w4V5YYzGjjsdyieSZc/epwDHjBGYUGhoBFbf9tOA
         zJDVjcbBgSqWOmRWYOWDN04CWGzNqQySFE5VdcMJjwZ0Fkki2HDqC/xMYKUJjJLvUuaP
         8rWTks2FghGGGo7LRHRPgyr7gZOT1utSKluOjcKNmm3I5W3i5obUIY8AZHZXnTQjG0QN
         eu6aVPevsqcbrV2RyvR40eDEhRwih4AWT4XlozC0x3NGYgdfOcG5b7HoDpj4IizhfojV
         GVmg==
X-Gm-Message-State: APjAAAXd36fx/PNW+fh6Hx910vuB2jYVQ+jvKTzpaqskWGAOVzVEVckN
        kSSautyX/w3fLLPfOMh1/jQ=
X-Google-Smtp-Source: APXvYqyQQmkSwKJS1cVIb4raUBaBnCl5g1ZtptIjJ+VfBjYB1Y/Y5NsoLhSKZItM0+Bt9oKzIZnV3w==
X-Received: by 2002:a17:90a:d593:: with SMTP id v19mr97223pju.1.1564683272233;
        Thu, 01 Aug 2019 11:14:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g8sm82089165pgk.1.2019.08.01.11.14.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:14:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: [PATCH 7/9] Revert "Revert "treewide: Rename rcu_dereference_raw_notrace() to _check()""
Date:   Thu,  1 Aug 2019 14:14:09 -0400
Message-Id: <20190801181411.96429-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801181411.96429-1-joel@joelfernandes.org>
References: <20190801181411.96429-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This reverts commit 61d814760f1d2dffdc8db636f70bbef07c30acd5.
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 arch/powerpc/include/asm/kvm_book3s_64.h               | 2 +-
 include/linux/rculist.h                                | 6 +++---
 include/linux/rcupdate.h                               | 2 +-
 kernel/trace/ftrace_internal.h                         | 8 ++++----
 kernel/trace/trace.c                                   | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index a33b5fb331b4..0b222469d7ce 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1997,7 +1997,7 @@ Tracing and RCU
 ~~~~~~~~~~~~~~~
 
 It is possible to use tracing on RCU code, but tracing itself uses RCU.
-For this reason, ``rcu_dereference_raw_notrace()`` is provided for use
+For this reason, ``rcu_dereference_raw_check()`` is provided for use
 by tracing, which avoids the destructive recursion that could otherwise
 ensue. This API is also used by virtualization in some architectures,
 where RCU readers execute in environments in which tracing cannot be
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index bb7c8cc77f1a..04b2b927bb5a 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -535,7 +535,7 @@ static inline void note_hpte_modification(struct kvm *kvm,
  */
 static inline struct kvm_memslots *kvm_memslots_raw(struct kvm *kvm)
 {
-	return rcu_dereference_raw_notrace(kvm->memslots[0]);
+	return rcu_dereference_raw_check(kvm->memslots[0]);
 }
 
 extern void kvmppc_mmu_debugfs_init(struct kvm *kvm);
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index e91ec9ddcd30..932296144131 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -622,7 +622,7 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define hlist_for_each_entry_rcu(pos, head, member)			\
-	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
+	for (pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
 			typeof(*(pos)), member);			\
 		pos;							\
 		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
@@ -642,10 +642,10 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * not do any RCU debugging or tracing.
  */
 #define hlist_for_each_entry_rcu_notrace(pos, head, member)			\
-	for (pos = hlist_entry_safe (rcu_dereference_raw_notrace(hlist_first_rcu(head)),\
+	for (pos = hlist_entry_safe(rcu_dereference_raw_check(hlist_first_rcu(head)),\
 			typeof(*(pos)), member);			\
 		pos;							\
-		pos = hlist_entry_safe(rcu_dereference_raw_notrace(hlist_next_rcu(\
+		pos = hlist_entry_safe(rcu_dereference_raw_check(hlist_next_rcu(\
 			&(pos)->member)), typeof(*(pos)), member))
 
 /**
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 8f7167478c1d..bfcafbc1e301 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -476,7 +476,7 @@ do {									      \
  * The no-tracing version of rcu_dereference_raw() must not call
  * rcu_read_lock_held().
  */
-#define rcu_dereference_raw_notrace(p) __rcu_dereference_check((p), 1, __rcu)
+#define rcu_dereference_raw_check(p) __rcu_dereference_check((p), 1, __rcu)
 
 /**
  * rcu_dereference_protected() - fetch RCU pointer when updates prevented
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 0515a2096f90..0456e0a3dab1 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -6,22 +6,22 @@
 
 /*
  * Traverse the ftrace_global_list, invoking all entries.  The reason that we
- * can use rcu_dereference_raw_notrace() is that elements removed from this list
+ * can use rcu_dereference_raw_check() is that elements removed from this list
  * are simply leaked, so there is no need to interact with a grace-period
- * mechanism.  The rcu_dereference_raw_notrace() calls are needed to handle
+ * mechanism.  The rcu_dereference_raw_check() calls are needed to handle
  * concurrent insertions into the ftrace_global_list.
  *
  * Silly Alpha and silly pointer-speculation compiler optimizations!
  */
 #define do_for_each_ftrace_op(op, list)			\
-	op = rcu_dereference_raw_notrace(list);			\
+	op = rcu_dereference_raw_check(list);			\
 	do
 
 /*
  * Optimized for just a single item in the list (as that is the normal case).
  */
 #define while_for_each_ftrace_op(op)				\
-	while (likely(op = rcu_dereference_raw_notrace((op)->next)) &&	\
+	while (likely(op = rcu_dereference_raw_check((op)->next)) &&	\
 	       unlikely((op) != &ftrace_list_end))
 
 extern struct ftrace_ops __rcu *ftrace_ops_list;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 525a97fbbc60..642474b26ba7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2642,10 +2642,10 @@ static void ftrace_exports(struct ring_buffer_event *event)
 
 	preempt_disable_notrace();
 
-	export = rcu_dereference_raw_notrace(ftrace_exports_list);
+	export = rcu_dereference_raw_check(ftrace_exports_list);
 	while (export) {
 		trace_process_export(export, event);
-		export = rcu_dereference_raw_notrace(export->next);
+		export = rcu_dereference_raw_check(export->next);
 	}
 
 	preempt_enable_notrace();
-- 
2.22.0.770.g0f2c4a37fd-goog

