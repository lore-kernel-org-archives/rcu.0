Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546F3C6FD1D
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 18:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjCOSUQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjCOSTv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB8664EE
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 11:19:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cf14so17177845qtb.10
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C875UW3frLz1lRISgaVupsCOUcY7ixEg8V710uhHfA=;
        b=DPSkv5UuukMQB08VeLhWDOZpTsKRs7XRm8Z7PYEO2J1A3Fp78UTsApYrFQwlOxMViU
         KlIZY+sUHHk4B22w99eFw5THO2D8yPtupryB73gk56KlbQQEhhQukLDCu+ytVgTy+DM+
         V819OE0WU+vOdwSGrLQboPd96Y//tbADX9h2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C875UW3frLz1lRISgaVupsCOUcY7ixEg8V710uhHfA=;
        b=jNvRQTBo4dEmHi9Aks1xt0PaCy7OVGxhutANpjxGxJSvstHIfxyiZnrvDc2TR1wDtQ
         pot0/alaTweevWfl6SfruINl11y7g5toonD4N1UTa7xYXg1Hx5u0H1+hW0SZj9zQau3E
         VMUNRMN9oHULDrNjpCb1X+uFseQ33XyhnS9+Zw4Osin53ZF9GAAlL/hgccLY5fyhN+lj
         HxaJ4HMunUMOqR80K6w4wPn7OvwIJrOo+cLQx3/N+R2xidwHnTxENBWwKdsYMMD/iGkh
         DD0Z2CLdljUodAmuEl3IxcmzobLUK0v5CispZCpPr+xPvKA3JV4eUN1UAVm3dZEWl+DA
         tS7w==
X-Gm-Message-State: AO0yUKXITUMbZcHUS3A5CPPRMYH/Nah/nOhN6zLtqeOqVEOvIdYOH8ax
        g+m5F/oT+mWW0Z/OMoo3ePovdg==
X-Google-Smtp-Source: AK7set/+DQUInzPQv7zg0jpqq9Z8pFaM3HKmCv83UgP5J0Ng/wXnoIoKyNsPk0qA4oLZ+MhQ5btm7Q==
X-Received: by 2002:a05:622a:14c8:b0:3d4:6185:72eb with SMTP id u8-20020a05622a14c800b003d4618572ebmr1282272qtx.34.1678904376337;
        Wed, 15 Mar 2023 11:19:36 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
Date:   Wed, 15 Mar 2023 18:18:58 +0000
Message-Id: <20230315181902.4177819-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() and kfree_rcu() APIs are hazardous in that if you forget
the second argument, it works, but might sleep.  This sleeping can be a
correctness bug from atomic contexts, and even in non-atomic contexts it
might introduce unacceptable latencies.  This commit therefore removes the
single-argument kvfree_rcu() and kfree_rcu() macros.  Code that would have
previously used these single-argument kvfree_rcu() and kfree_rcu() macros
should instead use kvfree_rcu_mightsleep() or kfree_rcu_mightsleep().

[ paulmck: Apply Joel Fernandes feedback. ]

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 094321c17e48..7571dbfecb18 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -957,9 +957,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /**
  * kfree_rcu() - kfree an object after a grace period.
- * @ptr: pointer to kfree for both single- and double-argument invocations.
- * @rhf: the name of the struct rcu_head within the type of @ptr,
- *       but only for double-argument invocations.
+ * @ptr: pointer to kfree for double-argument invocations.
+ * @rhf: the name of the struct rcu_head within the type of @ptr.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
@@ -982,26 +981,18 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
+#define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
+#define kvfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
 
 /**
- * kvfree_rcu() - kvfree an object after a grace period.
- *
- * This macro consists of one or two arguments and it is
- * based on whether an object is head-less or not. If it
- * has a head then a semantic stays the same as it used
- * to be before:
- *
- *     kvfree_rcu(ptr, rhf);
- *
- * where @ptr is a pointer to kvfree(), @rhf is the name
- * of the rcu_head structure within the type of @ptr.
+ * kfree_rcu_mightsleep() - kfree an object after a grace period.
+ * @ptr: pointer to kfree for single-argument invocations.
  *
  * When it comes to head-less variant, only one argument
  * is passed and that is just a pointer which has to be
  * freed after a grace period. Therefore the semantic is
  *
- *     kvfree_rcu(ptr);
+ *     kfree_rcu_mightsleep(ptr);
  *
  * where @ptr is the pointer to be freed by kvfree().
  *
@@ -1010,13 +1001,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * annotation. Otherwise, please switch and embed the
  * rcu_head structure within the type of @ptr.
  */
-#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
-	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
-
+#define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
 #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
-#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
 
-#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
 	typeof (ptr) ___p = (ptr);					\
-- 
2.40.0.rc1.284.g88254d51c5-goog

