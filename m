Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF3C46467
	for <rcu@archiver.kernel.org>; Thu, 12 Jan 2023 00:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjALAwf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Jan 2023 19:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjALAwf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Jan 2023 19:52:35 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2615D202F
        for <rcu@vger.kernel.org>; Wed, 11 Jan 2023 16:52:34 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a25so8172724qto.10
        for <rcu@vger.kernel.org>; Wed, 11 Jan 2023 16:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qng87r2afyBWFugVmr/ToSxitn179pDEw8bgUuU7NSI=;
        b=gvNbDNcf4RL8zlbzVOgMt/Grt6Xy2W9WrWdryZnQNlhiIQrZvRAvmUKTl360QG43D2
         UEUwVYJQJn+v2Tm/K46xHvqw48oryZvzwGWvybOMqLhEao9wJCwaFhfLWrQCHCZlGfAF
         9Xz6Si1vL7gFeawCEE+HufH2JKzJWq55Tqr00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qng87r2afyBWFugVmr/ToSxitn179pDEw8bgUuU7NSI=;
        b=Wo+Hi91/b7jTTp2nx7nISr+sUBC3ZoqFJZrWy5IemqyZvDHqxIFhBJkWLPfxjszXQF
         8KybBnXZ3hhQVfE3j6WmxzuhKMoIM6XpBS3gsfS2rXjZ/ngJG6RmlmNRm4AeKSekSVu4
         XLaap8uD7p27Y7bIwVXGHek+XKSah3w1eGV1u1mBOJSom8L59HzzkvFiuJSzPYuCtG37
         RyUOrvedE2GfIz6M5lnp/T/GMXhKYa24CYZidSdaduR9JXx6nejP8t/3B/IrNcthcZs5
         gq92nW+1WLM1mMkjKH6nM+lD6dfsJM691JhOItBP1cuHmpz2Onc6F1X49QwRFf2hjaqZ
         Gu5g==
X-Gm-Message-State: AFqh2krMXYqS7bK95t4m7HlYwlvMspd7YObTDxyuTU9B+HIELIROfAWl
        vZC9h9nQTOpM0Gm6zxECQRiKGg==
X-Google-Smtp-Source: AMrXdXtctWPFOVAuHhWZLQkblPnhKGDs+gtqTKp2PO0wcs7YdlqORk8XfeoGeJctxn9asf49S9HzAg==
X-Received: by 2002:ac8:5710:0:b0:3a9:86dd:3c60 with SMTP id 16-20020ac85710000000b003a986dd3c60mr137977132qtw.47.1673484753191;
        Wed, 11 Jan 2023 16:52:33 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id z9-20020ac87ca9000000b003a7e2aea23esm8307523qtv.86.2023.01.11.16.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 16:52:32 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, fweisbec@gmail.com,
        urezki@gmail.com
Subject: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and suspend
Date:   Thu, 12 Jan 2023 00:52:22 +0000
Message-Id: <20230112005223.2329802-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During boot and suspend/resume, it is desired to prevent RCU laziness from
effecting performance and in some cases failures like with suspend.

Track whether RCU laziness is to be ignored or not, in kernels with
CONFIG_RCU_LAZY enabled. We do such tracking for expedited-RCU already, however
since Android currently expedites synchronous_rcu() always, we cannot rely on
that. The next patch ignores laziness hints based on this tracking.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Paul, could we take this and the next one for 6.2 -rc cycle?

I also booted debian Linux and verified the flag is reset correctly after boot
completes. Thanks.

 kernel/rcu/rcu.h    |  6 ++++++
 kernel/rcu/tree.c   |  2 ++
 kernel/rcu/update.c | 40 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 cc_list
 create mode 100644 to_list

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 5c8013f7085f..115616ac3bfa 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -449,14 +449,20 @@ do {									\
 /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
 static inline bool rcu_gp_is_normal(void) { return true; }
 static inline bool rcu_gp_is_expedited(void) { return false; }
+static inline bool rcu_async_should_hurry(void) { return false; }
 static inline void rcu_expedite_gp(void) { }
 static inline void rcu_unexpedite_gp(void) { }
+static inline void rcu_async_hurry(void) { }
+static inline void rcu_async_relax(void) { }
 static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
+bool rcu_async_should_hurry(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
 void rcu_unexpedite_gp(void);
+void rcu_async_hurry(void);
+void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 63545d79da51..78b2e999c904 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4504,11 +4504,13 @@ static int rcu_pm_notify(struct notifier_block *self,
 	switch (action) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+		rcu_async_hurry();
 		rcu_expedite_gp();
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
 		rcu_unexpedite_gp();
+		rcu_async_relax();
 		break;
 	default:
 		break;
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 3893022f8ed8..19bf6fa3ee6a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -144,8 +144,45 @@ bool rcu_gp_is_normal(void)
 }
 EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
 
-static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
+static atomic_t rcu_async_hurry_nesting = ATOMIC_INIT(1);
+/*
+ * Should call_rcu() callbacks be processed with urgency or are
+ * they OK being executed with arbitrary delays?
+ */
+bool rcu_async_should_hurry(void)
+{
+	return !IS_ENABLED(CONFIG_RCU_LAZY) ||
+	       atomic_read(&rcu_async_hurry_nesting);
+}
+EXPORT_SYMBOL_GPL(rcu_async_should_hurry);
+
+/**
+ * rcu_async_hurry - Make future async RCU callbacks not lazy.
+ *
+ * After a call to this function, future calls to call_rcu()
+ * will be processed in a timely fashion.
+ */
+void rcu_async_hurry(void)
+{
+	if (IS_ENABLED(CONFIG_RCU_LAZY))
+		atomic_inc(&rcu_async_hurry_nesting);
+}
+EXPORT_SYMBOL_GPL(rcu_async_hurry);
 
+/**
+ * rcu_async_relax - Make future async RCU callbacks lazy.
+ *
+ * After a call to this function, future calls to call_rcu()
+ * will be processed in a lazy fashion.
+ */
+void rcu_async_relax(void)
+{
+	if (IS_ENABLED(CONFIG_RCU_LAZY))
+		atomic_dec(&rcu_async_hurry_nesting);
+}
+EXPORT_SYMBOL_GPL(rcu_async_relax);
+
+static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
 /*
  * Should normal grace-period primitives be expedited?  Intended for
  * use within RCU.  Note that this function takes the rcu_expedited
@@ -195,6 +232,7 @@ static bool rcu_boot_ended __read_mostly;
 void rcu_end_inkernel_boot(void)
 {
 	rcu_unexpedite_gp();
+	rcu_async_relax();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
 	rcu_boot_ended = true;
-- 
2.39.0.314.g84b9a713c41-goog
