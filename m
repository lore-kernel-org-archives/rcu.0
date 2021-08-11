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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FC0C4338F
	for <rcu@archiver.kernel.org>; Wed, 11 Aug 2021 03:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA3D60243
	for <rcu@archiver.kernel.org>; Wed, 11 Aug 2021 03:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhHKDNN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhHKDNN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Aug 2021 23:13:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D8C061765;
        Tue, 10 Aug 2021 20:12:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a8so1196319pjk.4;
        Tue, 10 Aug 2021 20:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYZ0FfImjYYOyJPM3xU7MkNuSAhJfWOgyjhwSopSKMY=;
        b=mMSzDSilzYK3yhDnd30DmCmgY/DlYXXcqefC38X8+aNAotep1g2tRj+4CyqznkK83t
         SUoUQaB9ChgqJLzHS5nn94NYURG+E4hpcmbgluQDw2IRo/4wvUH20YbPSqyw7AY0XJB7
         PbUXV8UGDq9eTGhQNk+RdciSFpjIkolHRH8fC/SH4vAPxSt5zUrtNz8QCyO/Y7enPA96
         hj2vjPJo6QIuwHJhhXXuI5XbxVemIBeAGZtwN2KgvSQxv/W7BMe+RrkudG/qDwRks91t
         0zJzi+/AjNOz9KYwUZXv7ZSjkFLtfUF7SpIe8OFLZuoBb5koZcOxUQpCeu/wAClsuJPw
         WNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYZ0FfImjYYOyJPM3xU7MkNuSAhJfWOgyjhwSopSKMY=;
        b=Pou2IlPyekB5ImcxDyqQRteNo5HwDY7DnmF3mUZWemWezNuCBzW5Q6Yq+HaCe10NIF
         DkzYKl5zfj/jh3wij633Rt/ag7g0XOQZpD20K5ono7Jq9ZHiEwxZRlXN0WZTiWpHr5d4
         LQzCyBfyoUu0oWOFtk1BGMeSmUqn7OjEbMkWIPa5/onu5L+R7xU+x9b+pJOQuEAjOZd2
         Js1IRKutFIh7LEZfJZYxqxxLSHBs7W2weG+1ARwq2KKv65hiF2KKoQYt9UumaCAjl6jy
         VwrCuTKyZiXwqi0dlCKXV0ehbWGNwDPe7Cenma9TUnYZ3Tyu4QEWVWaAy6ZW7/7EQnV9
         JthA==
X-Gm-Message-State: AOAM5304fou2LYAepZZjznRmPtnHTttevbcdnhsFwQusjCMGYWBeiG6W
        6h2JSD/H2lKqA45PQvR0cb0=
X-Google-Smtp-Source: ABdhPJxPj9oB/tbZybJdQQeQmws5xRQhrCstouHBdrPFUBRqfUbvRHl8mL7JUqBxVcU+J/CMJ2OPqw==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr8178151pjj.165.1628651570276;
        Tue, 10 Aug 2021 20:12:50 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.173])
        by smtp.gmail.com with ESMTPSA id z9sm25309765pfa.2.2021.08.10.20.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 20:12:49 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH V3][RFC] lockdep: improve comments in wait-type checks
Date:   Wed, 11 Aug 2021 11:12:18 +0800
Message-Id: <20210811031218.21177-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

I think the comments in wait-type checks can be improved by mentioning the
PREEPT_RT kernel configure option.

Sorry for the previous noise.
Many thanks
Zhouyi

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 include/linux/lockdep_types.h | 2 +-
 kernel/locking/lockdep.c      | 2 +-
 kernel/rcu/update.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 3e726ace5c62..d22430840b53 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -21,7 +21,7 @@ enum lockdep_wait_type {
 	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
 
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
-	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
+	LD_WAIT_CONFIG,		/* preemptible in PREEMPT_RT, spinlock_t etc.. */
 #else
 	LD_WAIT_CONFIG = LD_WAIT_SPIN,
 #endif
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c881e4..952d0ccf8776 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4671,7 +4671,7 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 /*
  * Verify the wait_type context.
  *
- * This check validates we takes locks in the right wait-type order; that is it
+ * This check validates we take locks in the right wait-type order; that is it
  * ensures that we do not take mutexes inside spinlocks and do not attempt to
  * acquire spinlocks inside raw_spinlocks and the sort.
  *
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38cc25e9..690b0cec7459 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -247,7 +247,7 @@ struct lockdep_map rcu_lock_map = {
 	.name = "rcu_read_lock",
 	.key = &rcu_lock_key,
 	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_CONFIG, /* XXX PREEMPT_RCU ? */
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT implies PREEMPT_RCU */
 };
 EXPORT_SYMBOL_GPL(rcu_lock_map);
 
@@ -256,7 +256,7 @@ struct lockdep_map rcu_bh_lock_map = {
 	.name = "rcu_read_lock_bh",
 	.key = &rcu_bh_lock_key,
 	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_LOCK also makes BH preemptible */
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
 };
 EXPORT_SYMBOL_GPL(rcu_bh_lock_map);
 
-- 
2.25.1

