Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80E4C8300C
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8638621707
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTgjdo+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgD1U7l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgD1U7k (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC37C03C1AC;
        Tue, 28 Apr 2020 13:59:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so239066ljg.5;
        Tue, 28 Apr 2020 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hjFgrHN/AobfDhCW7uHxtGVQp6m3WKcxFSvew6M5pw=;
        b=mTgjdo+bMst6VnOjdPMHNcx3tuDQ+BDhhX1LfQSV21Z7Uad2qAHdhz6tArXTjHtGWl
         ryL105FvQsaXCwDc/qECPQ3udl9XQdUVbLE0LAdDz63i47h/7cb7vjI+6eqoIUP0xKsr
         g5zCswt3KHkAUxPHoA63BYFFGiLwPCNe3NeSZ0/96qaiby/d5cHjc1x6xI+B4aFyLBRx
         RofJAnQaSKp63kKtqXQ8yj2WYWRRnTdUpWISvo4OIJNJRF8RMuhGfOhhr+D1Nd1Vbgq5
         gCRPyRachrNlHGaNEzoS7iOonxh8Ti62fbG8mG+5pWVItXTa0pw/kOk8udN/D99y03Ju
         9JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hjFgrHN/AobfDhCW7uHxtGVQp6m3WKcxFSvew6M5pw=;
        b=b6XhbX5nHvRfB8Sh/YIwc3h3YREBphG7mat3tXbmFvcPHA5xUQYAcWE02k++sCGQTz
         ian9KMI+tWDrNDT0LtRCizaX38GSI47N+Sx11wCvurZ0VQKmML/rISdfSQsD+iW+zUWz
         Q7JT4C4EzcE6s0JGRxdTUqRM3/K9XEJyExYTFt+6ajtWevmvy4i79dm7n+0UY13RWn0D
         r1eb8Iq8gqf/MlkNGiWGPYbc8fU7AO0xCZmpNPZ5vlT7InqkqIsNoCd9IA/UkOibE4sI
         W2Mq7XnbLPBOutvIYC7Pwm1oEv0tObTBoan0JnlxCHh58/uGdq5VuFFrU3tTPDEWLOBZ
         m80g==
X-Gm-Message-State: AGi0Puba3TFtjONon7WTgWa45wgy9AxROmWYs6qKVJwz6Hsge1TN/A+3
        ja0Ib5kJcEamZeMEMvdda1igTiURfd1E7A==
X-Google-Smtp-Source: APiQypLbRFLIsVOfuz0lNkpuDjqlP3snMnoaGJKNyj3Wqv3N49M2dESfMr2LkQ60hBGlniDH8cEjaA==
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr18548017lji.272.1588107577075;
        Tue, 28 Apr 2020 13:59:37 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:36 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 07/24] rcu/tree: move locking/unlocking to separate functions
Date:   Tue, 28 Apr 2020 22:58:46 +0200
Message-Id: <20200428205903.61704-8-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Introduce two helpers to lock and unlock an access to the
per-cpu "kfree_rcu_cpu" structure. The reason is to make
kfree_call_rcu() function to be more readable.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eebd7f627794..bc6c2bc8fa32 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2925,6 +2925,27 @@ debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 #endif
 }
 
+static inline struct kfree_rcu_cpu *
+krc_this_cpu_lock(unsigned long *flags)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
+	krcp = this_cpu_ptr(&krc);
+	if (likely(krcp->initialized))
+		raw_spin_lock(&krcp->lock);
+
+	return krcp;
+}
+
+static inline void
+krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
+{
+	if (likely(krcp->initialized))
+		raw_spin_unlock(&krcp->lock);
+	local_irq_restore(flags);
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -3150,11 +3171,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	struct kfree_rcu_cpu *krcp;
 	void *ptr;
 
-	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
-	krcp = this_cpu_ptr(&krc);
-	if (krcp->initialized)
-		raw_spin_lock(&krcp->lock);
-
+	krcp = krc_this_cpu_lock(&flags);
 	ptr = (void *)head - (unsigned long)func;
 
 	/* Queue the object but don't yet schedule the batch. */
@@ -3185,9 +3202,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 unlock_return:
-	if (krcp->initialized)
-		raw_spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	krc_this_cpu_unlock(krcp, flags);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
-- 
2.20.1

