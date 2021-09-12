Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55670C433F5
	for <rcu@archiver.kernel.org>; Sun, 12 Sep 2021 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B56560F43
	for <rcu@archiver.kernel.org>; Sun, 12 Sep 2021 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhILUnd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 12 Sep 2021 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhILUnc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 12 Sep 2021 16:43:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E11C061574;
        Sun, 12 Sep 2021 13:42:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so11395238wrn.5;
        Sun, 12 Sep 2021 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ow1HoVLX+9HoNdnX4/sLVCN3K6sWaqzs/vefkU1HZMg=;
        b=JeX/eVDgXgXbXR2dFxLq73meQq6/0AyQLg+gujPwrPLDbdlcO9JdnZPPwfcnx7FgxU
         /scjLibLCTHIKgW+L230CWtTCFS6x+eyMckmZWz0YqXe/3JMXBQ4jPKphpgEB92Lzqty
         3d6JOYtWJwRRQgAM8CV6QpGNHXXhGbpa1S2BNJLUTnwY3n/d+Zi263ew76S6fGdQzFu0
         8Fd/otQ7l2GIXmRHRlvOJe6aB/g740Ok+Oy+dUfGvh/1LeloWI9N71jDPShjjVKGYrmS
         ZsUhDXb7S4svOHAeGPcEHgVVIxwmvfZ1/ck7EVhNlHuMUZ/Jk4QQjZmCogzgQ7EDjK6L
         pB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ow1HoVLX+9HoNdnX4/sLVCN3K6sWaqzs/vefkU1HZMg=;
        b=vLo6IoYCegHWJJ/nrEihpLQBbz/9INeE8FICbGu9BvbNfQ1XZFwWbLVbr7+HVk0PMq
         +1t1ugNMTcPaHnymcPj8n4gtJuOfegZp0NoWu989i4+WZj71gtPpixmc9FN9AqwVOfee
         YGh/ZJhcuxkz1suU5IYQyfSVO74Ffk3IHwpCuw8+KVKDnUhmX/J7/6NzhC/imSvQEaVi
         77o9wOUe25MoAV8mP6dmflw0J4PhJqZcodHF0pdZWnCjVGOaM0zBEB939BSjWR71ryQM
         eKWfZ3D3TX16Nzhxti2IKMtJcUUMqA/qxoL1jO+E+ZwaleCcLLNebAKbkpkJRnlyzihJ
         aGCQ==
X-Gm-Message-State: AOAM530ekU78e4SVDLguhpPMkR3nMCOaoqqbw/TSYoLSYX3RDnX+hyLX
        vcP9OezObkpXes2M+sqIB08=
X-Google-Smtp-Source: ABdhPJwq5N8xd+5st7VxAz0bSZqVLzUiY7NtVzeroaf5ZK1Y5gC8+0GEAaaRsY9Bt08imGhYlCt4lQ==
X-Received: by 2002:adf:b781:: with SMTP id s1mr9027170wre.165.1631479336100;
        Sun, 12 Sep 2021 13:42:16 -0700 (PDT)
Received: from ubuntu.localdomain (bbcs-125-202.pub.wingo.ch. [144.2.125.202])
        by smtp.gmail.com with ESMTPSA id z2sm5103151wma.45.2021.09.12.13.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:42:15 -0700 (PDT)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chun-Hung Tseng <henrybear327@gmail.com>,
        Jim Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH] rcu: replace _________p1 with __UNIQUE_ID(rcu)
Date:   Mon, 13 Sep 2021 04:41:31 +0800
Message-Id: <20210912204131.93206-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit replaced _________p1 with __UNIQUE_ID(rcu), which
generates unique variable names during compilation. Necessary
modifications due to the changes in the RCU macros have also been
reflected in this commit.

The same idea is used for the min/max macros (commit 589a978 and commit
e9092d0), which aims to reduce variable shadowing issues caused by hard
coded variable names.

Signed-off-by: Jim Huang <jserv@ccns.ncku.edu.tw>
Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 include/linux/rcupdate.h | 44 +++++++++++++++++++++++-----------------
 include/linux/srcu.h     |  3 ++-
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 434d12fe2d4f..a5ab20822040 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -370,39 +370,41 @@ static inline void rcu_preempt_sleep_check(void) { }
  * Converts @p from an __rcu pointer to a __kernel pointer.
  * This allows an __rcu pointer to be used with xchg() and friends.
  */
-#define unrcu_pointer(p)						\
+#define __unrcu_pointer(p, local)					\
 ({									\
-	typeof(*p) *_________p1 = (typeof(*p) *__force)(p);		\
+	typeof(*p) *local = (typeof(*p) *__force)(p);			\
 	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(_________p1)); 		\
+	((typeof(*p) __force __kernel *)(local)); 			\
 })
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

