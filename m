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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3B6C5519F
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 11:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655FB22254
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 11:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nabdbzL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgKTLta (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgKTLt3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 06:49:29 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70720C0613CF;
        Fri, 20 Nov 2020 03:49:29 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 11so9748441ljf.2;
        Fri, 20 Nov 2020 03:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=siq01dsnoBEVAA2j5Gd4vmHNXcANoBmTuWqv5FdkRRg=;
        b=nabdbzL3qLoy6eyU1INiss6AzaU3MOG7PfET7Y8JPQdPzpvCja7qs0wNQjVbWzV67i
         ugyreE5Pn4JcBpdetLsXMZlCv+h5x2ATavRmHkEVs0rFUM7S76fara/rSK41MdAfy1g4
         lwWWJoLFGnPu9xg1IcdQyaimv/qTNkuHkXtulExJPC3/BLscFhSYcqbpHCmCcV45tHqu
         gG1N1IM2uRfcWEdj5liqNIzTwSDG8p/I5OHnd3tLr6QNSrJckwH9DZY/44Sf03jY26GX
         XWE0VfZ7EXoifXpXLyUlFytzIBhpFhZP+MT/2vkzqTOTrURvSuLQl8038Dw4NxyHkvcC
         68nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=siq01dsnoBEVAA2j5Gd4vmHNXcANoBmTuWqv5FdkRRg=;
        b=gX4q7NvE1m1quFdOjdxnjv3fC0er17xwhohK9VK13FRFypFuArFUve/o9Gf+9Cw6mp
         g+QOxP2BPmKYH6oNndWBVbikl6js4Vi4gdujzrDILqEd4rMTA2hhmMUWIfIWwaxdncZc
         69nlxfCi97c52aEiNEE8Olc0hKN1TugiFKXq0ICIToVgsyfD06xrTk8eC78opEN4nW3I
         cUSie5SAhukP0/QKaXBx/GOE/ID7xLf+GDltrBgc09T4bVv0eoyGxG6leesrlKCsWCZx
         QdVHSNvt7DAHccxPHEY5nqD++1LDi0/NR4kCZEGUiOn2ZOH1awpjbCskZwimidkqxhfC
         6hmA==
X-Gm-Message-State: AOAM533347PTwB09Bnzhp7wxYIOHkYFNa3opeGIPxwUhcmrbuUM8yXk7
        4vUTMcfzQBXu9YAbNUgJGPIBKYXF6hyAvUDl
X-Google-Smtp-Source: ABdhPJzFGWiC4bBLK+dTr2G0AiHCUim+NlzToVpyQaOg5ek+5X0QP/ptD2YnYaVdQOUDhPB3iQcFyw==
X-Received: by 2002:a2e:9614:: with SMTP id v20mr8167013ljh.13.1605872967505;
        Fri, 20 Nov 2020 03:49:27 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i17sm262683ljb.1.2020.11.20.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:49:26 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/2] rcu: introduce kfree_rcu() single argument macro
Date:   Fri, 20 Nov 2020 12:49:16 +0100
Message-Id: <20201120114917.5263-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There is a kvfree_rcu() single argument macro that pairs
with kvmalloc() allocated pointer. Even though it also
deals with SLAB one, it might be confused for the users.

That is why add an extra kfree_rcu() macro that explicitly
pairs with kmalloc() pointer and its name, so it becomes
more obvious for users.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e09c0d87b3c3..b1e75648d402 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -853,8 +853,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /**
  * kfree_rcu() - kfree an object after a grace period.
- * @ptr:	pointer to kfree
- * @rhf:	the name of the struct rcu_head within the type of @ptr.
+ * @ptr: pointer to kfree(both for single argument and double one)
+ * @rhf: the name of the struct rcu_head within the type of @ptr,
+ *       only for double argument.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
@@ -877,13 +878,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rhf)						\
-do {									\
-	typeof (ptr) ___p = (ptr);					\
-									\
-	if (___p)							\
-		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
-} while (0)
+#define kfree_rcu kvfree_rcu
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
@@ -915,7 +910,14 @@ do {									\
 	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
 
 #define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
-#define kvfree_rcu_arg_2(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu_arg_2(ptr, rhf)					\
+do {									\
+	typeof (ptr) ___p = (ptr);					\
+									\
+	if (___p)							\
+		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+} while (0)
+
 #define kvfree_rcu_arg_1(ptr)					\
 do {								\
 	typeof(ptr) ___p = (ptr);				\
-- 
2.20.1

