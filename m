Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2264C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 09:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDE561185
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 09:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhIOJEs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhIOJEr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 05:04:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF95C061574;
        Wed, 15 Sep 2021 02:03:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t18so2748844wrb.0;
        Wed, 15 Sep 2021 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5f950YmmuOfk9ahrUtpdqdSexft8w91ageq9dJH/RtM=;
        b=YrN6QlMtOLKlyYsPG7sfRv9LlrYfZHosLhPS4Fsyl3I0VHTte1QTcbnLCoqMg+KCiX
         f7KF3wF3zrv03I2+Lvtl6PU3Lzetj23bywGeLbPq4BXRbsfWCrYDH21BPZpFyJDCUQUZ
         zemoH0EEtmWmdSlQnxNiQFohOq3wzkfg4AurJQjlxWRiuTdgwmMmV824y4kqePuGRLmZ
         3LKKFxWzvaAXi04c1nTG1PzSyMFYbLDLnUD/WYd+Aa8TTg2TvNQCRBiCeSoTCiQ7zqaN
         gUn95PypRTBOacnj+0TvRAr52sTI9EbhkGTYPmyRLovPG086u8q98hPUSe8duU866qPd
         TCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5f950YmmuOfk9ahrUtpdqdSexft8w91ageq9dJH/RtM=;
        b=qnAaeF5hQnt5KwNq34cwCcDlcgpJ/eTz0mn8N9M0AfOMZiW5096GoDMfgsMMv4omQ0
         qge9ji0sfyXsiZJ60DqciKXaH0BIyXQEmXEowJIr+Dwc+sYOUxfFU8BIgxiGmtYlYQJL
         kMhqIexwHqutIOyaoAxQckNgtpJFZWsbBvznt4jJDpxIfpuUebwgZaQe3HTwOZd00Duh
         oY/7HEpJDBJowQmKK5duhsrfkkos+nj5g8O3hEFK0/8setmbupo8GZIsdQhBLK8+AROq
         u5LH1bkEpgtgdBQ/R6ijTpGC73qumerDvMVjVzNNiigvC6bQCNA18vYeMEsGX62ipZUK
         9+vA==
X-Gm-Message-State: AOAM530or+RNbmd/Jz9J3pbPa1XEO8NtzflOU6kAlh8EhbiSj5+ir2cI
        YOU1qHF+oUrtjPjDjdBuIio=
X-Google-Smtp-Source: ABdhPJx49D+BGl7kqn6f1+NVBI2L3h5lUA0kMd1fdyQTyVRD2El/sdMp6YQPtF7r0eumEQzf/7i75Q==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr3754371wro.203.1631696606810;
        Wed, 15 Sep 2021 02:03:26 -0700 (PDT)
Received: from ubuntu.localdomain ([77.109.178.123])
        by smtp.gmail.com with ESMTPSA id f25sm3556432wml.38.2021.09.15.02.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:03:26 -0700 (PDT)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chun-Hung Tseng <henrybear327@gmail.com>,
        Jim Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH v2] rcu: replace ________p1 and _________p1 with __UNIQUE_ID(rcu)
Date:   Wed, 15 Sep 2021 17:02:18 +0800
Message-Id: <20210915090218.530565-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit replaced both ________p1 and _________p1 with __UNIQUE_ID(rcu).
Necessary modifications due to the changes in the RCU macros have also been
reflected in this commit.

__UNIQUE_ID(rcu) will generate unique variable names during compilation,
which eliminates the need of ________p1 and _________p1 (both having 4
occurrences prior to the code change). Also, this avoids the variable name
shadowing issue.

The same idea is used for the min/max macros (commit 589a978 and commit
e9092d0).

Signed-off-by: Jim Huang <jserv@ccns.ncku.edu.tw>
Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 include/linux/rcupdate.h | 50 ++++++++++++++++++++++------------------
 include/linux/srcu.h     |  3 ++-
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 434d12fe2d4f..213b7eb49974 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -363,6 +363,12 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
+#define __unrcu_pointer(p, local)					\
+({									\
+	typeof(*p) *local = (typeof(*p) *__force)(p);			\
+	rcu_check_sparse(p, __rcu);					\
+	((typeof(*p) __force __kernel *)(local)); 			\
+})
 /**
  * unrcu_pointer - mark a pointer as not being RCU protected
  * @p: pointer needing to lose its __rcu property
@@ -370,39 +376,35 @@ static inline void rcu_preempt_sleep_check(void) { }
  * Converts @p from an __rcu pointer to a __kernel pointer.
  * This allows an __rcu pointer to be used with xchg() and friends.
  */
-#define unrcu_pointer(p)						\
-({									\
-	typeof(*p) *_________p1 = (typeof(*p) *__force)(p);		\
-	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(_________p1)); 		\
-})
+#define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
 
-#define __rcu_access_pointer(p, space) \
+#define __rcu_access_pointer(p, local, space) \
 ({ \
-	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(_________p1)); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
-#define __rcu_dereference_check(p, c, space) \
+#define __rcu_dereference_check(p, local, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(________p1)); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
-#define __rcu_dereference_protected(p, c, space) \
+#define __rcu_dereference_protected(p, local, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
 	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(p)); \
 })
-#define rcu_dereference_raw(p) \
+#define __rcu_dereference_raw(p, local) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(p) ________p1 = READ_ONCE(p); \
-	((typeof(*p) __force __kernel *)(________p1)); \
+	typeof(p) local = READ_ONCE(p); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
+#define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
 
 /**
  * RCU_INITIALIZER() - statically initialize an RCU-protected global variable
@@ -489,7 +491,7 @@ do {									      \
  * when tearing down multi-linked structures after a grace period
  * has elapsed.
  */
-#define rcu_access_pointer(p) __rcu_access_pointer((p), __rcu)
+#define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
 
 /**
  * rcu_dereference_check() - rcu_dereference with debug checking
@@ -525,7 +527,8 @@ do {									      \
  * annotated as __rcu.
  */
 #define rcu_dereference_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_held(), __rcu)
 
 /**
  * rcu_dereference_bh_check() - rcu_dereference_bh with debug checking
@@ -540,7 +543,8 @@ do {									      \
  * rcu_read_lock() but also rcu_read_lock_bh() into account.
  */
 #define rcu_dereference_bh_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_bh_held(), __rcu)
 
 /**
  * rcu_dereference_sched_check() - rcu_dereference_sched with debug checking
@@ -555,7 +559,8 @@ do {									      \
  * only rcu_read_lock() but also rcu_read_lock_sched() into account.
  */
 #define rcu_dereference_sched_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_sched_held(), \
 				__rcu)
 
 /*
@@ -565,7 +570,8 @@ do {									      \
  * The no-tracing version of rcu_dereference_raw() must not call
  * rcu_read_lock_held().
  */
-#define rcu_dereference_raw_check(p) __rcu_dereference_check((p), 1, __rcu)
+#define rcu_dereference_raw_check(p) \
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), 1, __rcu)
 
 /**
  * rcu_dereference_protected() - fetch RCU pointer when updates prevented
@@ -584,7 +590,7 @@ do {									      \
  * but very ugly failures.
  */
 #define rcu_dereference_protected(p, c) \
-	__rcu_dereference_protected((p), (c), __rcu)
+	__rcu_dereference_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
 
 
 /**
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e6011a9975af..01226e4d960a 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -117,7 +117,8 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
  * lockdep_is_held() calls.
  */
 #define srcu_dereference_check(p, ssp, c) \
-	__rcu_dereference_check((p), (c) || srcu_read_lock_held(ssp), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || srcu_read_lock_held(ssp), __rcu)
 
 /**
  * srcu_dereference - fetch SRCU-protected pointer for later dereferencing
-- 
2.25.1

