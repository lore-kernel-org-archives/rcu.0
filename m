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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78389C4338F
	for <rcu@archiver.kernel.org>; Wed, 11 Aug 2021 03:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA460EC0
	for <rcu@archiver.kernel.org>; Wed, 11 Aug 2021 03:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhHKDCF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbhHKDBa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Aug 2021 23:01:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9EC061388;
        Tue, 10 Aug 2021 19:59:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so7365326pjb.3;
        Tue, 10 Aug 2021 19:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSZRq8ntqj28TNNxiPdEJFUwJIVmHzf13EePntIiFzY=;
        b=cYME/lcwe1HDj+Fk7/SdLr/gMbjUtjKli+dt53YhEmFFkckwdhAmprNhFHtKmi6P+j
         X+QYknbISTmyegACbuZDCY25Uv1VPf+R7CkOCV4bcEHDY/KtiJkqwQ80+Hi8hip5cVkR
         xcy9wK/OTDXlHH7zdSERSX0XOSoK9tFPzFKwITtwDi21gmQ6Z6IoZXPLUYwPAupMZofF
         Cba7McADXuoym9sdxSxxp5l98Yl+rvZ4PCfS1WOfABIHf6u8s8P2DEw81xuzQphZebBK
         ENu0KUvcR7C0gqLJsJIGhin8jKMspIUP+ouDqYgG3U139xi+Q8U7JSMz2asIaAQDwjpY
         pUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSZRq8ntqj28TNNxiPdEJFUwJIVmHzf13EePntIiFzY=;
        b=M/0CMAzOfgfcigoHguri0ohKLX1tMswiAWWJvCAkLm0y9TE8TqJ6uzVBqf2XAZ/8ZE
         jY2hI2XDAxNa9G5NX0Ov/vlVko+rFbZlalhz39wn0SCnDGB9u+QMMHnB3T81P9SW/oM/
         AV/8X+eBVLXqU+3egkLlRrmOnUyjZL+Ep2V6PXrizKUxPyOPVbBR2DlW9RUpQee0/VGC
         KZPRaVJm05KgDp85P7uezYzWUjGSUF0olfJlsKE3o53Miag1Uy3yPtWMsk8dW0W440mj
         on+GVAphFaC2nN44QEZg42pRYn8RaU/aqZWobQskW4mIQTi/D2Uw7JGOHXB4ligUJQUW
         7PZQ==
X-Gm-Message-State: AOAM5312Ua+TGLp0GibcJ7ePf7Nc/mq64DYJzKI4sUtyDeQveNepnU60
        1x96OqZxe5RJVVLZYxrHBaM=
X-Google-Smtp-Source: ABdhPJzn3RA+PlWT/jS6cwheRBfz2s3WPTEeiZkjKvDQtnrI9sut+MPGLcSENH8yOTQfLbWgjUTtww==
X-Received: by 2002:a17:902:7889:b029:12b:cf54:4bf1 with SMTP id q9-20020a1709027889b029012bcf544bf1mr1249957pll.85.1628650794747;
        Tue, 10 Aug 2021 19:59:54 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.173])
        by smtp.gmail.com with ESMTPSA id h7sm23657036pjs.38.2021.08.10.19.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 19:59:54 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH V2][RFC] lockdep: improve comments in wait-type checks
Date:   Wed, 11 Aug 2021 10:59:20 +0800
Message-Id: <20210811025920.20751-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

comments in wait-type checks be improved by mentioning the
PREEPT_RT kernel configure option.

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

