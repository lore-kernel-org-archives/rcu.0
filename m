Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623BC83004
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92284206F0
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp/cGmJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD1VAp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726543AbgD1U7k (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F8C03C1AD;
        Tue, 28 Apr 2020 13:59:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w20so268365ljj.0;
        Tue, 28 Apr 2020 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KpPRWZDvG8CgK8dZKCEsG9Emj5dGIpU0eqSTK3oTu4U=;
        b=Jp/cGmJks3FbPmO6cnSdkivz7OJHf87NIdc550TYVUo5oyct/fknb8SeQgG/Wa6AvT
         j1s4N78U0TRqqfWCoy4Cnwkj6gYaJjhBPoPA4SDXFmJLkSgX/GEs/heihzFRtuULBLuR
         ydXaywn1Lar7YFPryFl7cTeTeik4WiCd59r+Y9nk9wFiAtp1oezC4vFzgKC81AgGdBDL
         STIicmNXYpDyWAknzGXu+U4RdBzyt0gcZaLuVfHNt3i11xsecqtZeCVI8ivDe15kcRl0
         qrTiYkXv2wP3a7zEMIu2PMB0JHWoYrUnSoEO4DbpVVTeg46tQ5FPN0LKzJqMmpMJ/Mzu
         a/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KpPRWZDvG8CgK8dZKCEsG9Emj5dGIpU0eqSTK3oTu4U=;
        b=ei8ubK1yia5i+lRLBR53cn6PrcLlmuMi5shZMPPvSvzqonWXfoPYVd/eNftHICYMnV
         cvtDR9QdCc4+6UqTBjxHPK63uCCJOGpgEWpmdwJ82YomA96OmHNOJ5edKi1gwzNfwOwe
         dVlDexfV+hMWBRbtIGG0ORGZcmES6pHN1ewT4Fq9w5Fpu8+ViJSZHhNX6SLn7+/oi4XP
         srs3a+o8BP2qMosjR49FrDEaQA0ObsRh2/bWbwdV5oce+2LHR6PQzyEJsvRkjM2urCv2
         ycyHEfAaS1jkx68di7IwNJ0KLB/3jW/gBK7XvCd/VtnuF/9RsBut2qz2mPtE8QbXLMK1
         twTg==
X-Gm-Message-State: AGi0PuaYgnRDIYArX45ev/T86GhsTKjFp8sCLq140dfbn5gYXa9MQDl0
        jwQXV0mvbqUneLPl27wIpcbXd9cPjSee1A==
X-Google-Smtp-Source: APiQypIK0yNKxQMrJ+FmeTtM1yEhM2Bk+cTVBWd0YgRswTk8U0gkkBZkwM/NPoG1ukrhwMQjsmSyPQ==
X-Received: by 2002:a2e:9713:: with SMTP id r19mr19379545lji.89.1588107578198;
        Tue, 28 Apr 2020 13:59:38 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:37 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/24] rcu/tree: Use static initializer for krc.lock
Date:   Tue, 28 Apr 2020 22:58:47 +0200
Message-Id: <20200428205903.61704-9-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The per-CPU variable is initialized at runtime in
kfree_rcu_batch_init(). This function is invoked before
'rcu_scheduler_active' is set to 'RCU_SCHEDULER_RUNNING'.
After the initialisation, '->initialized' is to true.

The raw_spin_lock is only acquired if '->initialized' is
set to true. The worqueue item is only used if 'rcu_scheduler_active'
set to RCU_SCHEDULER_RUNNING which happens after initialisation.

Use a static initializer for krc.lock and remove the runtime
initialisation of the lock. Since the lock can now be always
acquired, remove the '->initialized' check.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bc6c2bc8fa32..89e9ca3f4e3e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2892,7 +2892,7 @@ struct kfree_rcu_cpu_work {
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
- * @initialized: The @lock and @rcu_work fields have been initialized
+ * @initialized: The @rcu_work fields have been initialized
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -2912,7 +2912,9 @@ struct kfree_rcu_cpu {
 	int count;
 };
 
-static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
+};
 
 static __always_inline void
 debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
@@ -2930,10 +2932,9 @@ krc_this_cpu_lock(unsigned long *flags)
 {
 	struct kfree_rcu_cpu *krcp;
 
-	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
+	local_irq_save(*flags);	/* For safely calling this_cpu_ptr(). */
 	krcp = this_cpu_ptr(&krc);
-	if (likely(krcp->initialized))
-		raw_spin_lock(&krcp->lock);
+	raw_spin_lock(&krcp->lock);
 
 	return krcp;
 }
@@ -2941,8 +2942,7 @@ krc_this_cpu_lock(unsigned long *flags)
 static inline void
 krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 {
-	if (likely(krcp->initialized))
-		raw_spin_unlock(&krcp->lock);
+	raw_spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
 
@@ -4168,7 +4168,6 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		raw_spin_lock_init(&krcp->lock);
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
-- 
2.20.1

