Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C94BC433B4
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA13613EA
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbhD1NqC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhD1Np4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Apr 2021 09:45:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FA8C06138B;
        Wed, 28 Apr 2021 06:45:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u25so33956929ljg.7;
        Wed, 28 Apr 2021 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4RRxi73OEamqbLSZX4qWcNZMUEw8pOKLAfd+Koka7A=;
        b=BR/jO1prKlrgughIIKiL3Phw8cJK2ABFzl3HQ4yzpB9jxLVU79gDw9Qpmzw0qsy8+a
         gWsde4S5HgysiTAgfutn0JsH6T5eJL80HBobIUKTk7Q7sWKv3Zrct3ijlnHdc6QPWa7L
         L82dyLbASj0WeLJDuDuUCzEzxdD9QL+yCBQC0lLTPCsluTzHGJWj2mx5CzqB7xkhGYK4
         2cAgY3oYAVqZhIgmBDeyKZJvqPHsDy1fUSY+Vd8YcnE8jSxw5DJ6W9ALloe6e8QjdQFS
         XbmswhsEhXdAPYGo8LyCC/A2gpRg22qLNcJ/zySQ+pOJilXZ4KLOnkIb9K6zZMMUaQ8D
         zarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4RRxi73OEamqbLSZX4qWcNZMUEw8pOKLAfd+Koka7A=;
        b=lCoJi5u/UC4ILfh4QvLoBBtqOYtELlUUt/JdXU9I7J9bgn3DdNUmmB/1qE03/ig5xs
         ooWYIfaG8EAjX/7m00MYOksc2HbaH7lZHIp9bbiaj95jgKulESuvGKM9DCTXQFOaVaSI
         pnis5sQ68nskp42iAu2uRh7ly8Dc6j3G0RV6ePz/6gC7tVVn9AUvmHqfYzr3Op+ADQBe
         OorfAp+RI7sVnOWW9j11WrRzQTPByWEAN0lW3f5zd2R6ijbmHWCKoUI475IeTpfQ4ZYf
         YVQXL3WiUTJ0ZfEP0PO8x5p9Wj1htUkg/9WciKFDZLB2lp9ERDosH281i5/+V63fJqOS
         U95A==
X-Gm-Message-State: AOAM533OM/QZGlyccCuY7Gf062+wkmHcdA6BPUPv+LdbV/8VqoCSBsfe
        x+1A6FfmMh31JVMtbOcKF/G1/25UAxICsZjjJSY=
X-Google-Smtp-Source: ABdhPJz7gth6XMptfjLy54OTBeW5mnRb1e7uQcoqWwgR/UwYyYZ+QoXBPU5gwQ0T3l6FT9EjriXNtA==
X-Received: by 2002:a2e:9099:: with SMTP id l25mr21151274ljg.206.1619617509828;
        Wed, 28 Apr 2021 06:45:09 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o16sm730253lfu.228.2021.04.28.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 06:45:09 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 5/5] kvfree_rcu: Fix comments according to current code
Date:   Wed, 28 Apr 2021 15:44:22 +0200
Message-Id: <20210428134422.1894-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210428134422.1894-1-urezki@gmail.com>
References: <20210428134422.1894-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We used to have an "emergency path" and comments related
to it. According to current kvfree_rcu() design that path
is not considered as emergency anymore.

This patch rephrases and updates comments regarding this.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 229e909ad437..91b978e90c3b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3332,9 +3332,11 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 
 	/*
-	 * Emergency case only. It can happen under low memory
-	 * condition when an allocation gets failed, so the "bulk"
-	 * path can not be temporary maintained.
+	 * This is used when the "bulk" path can not be temporary
+	 * maintained for the double-argument of kvfree_rcu(). It
+	 * happens because a page-cache is empty, thus objects are
+	 * queued to the linked-list instead. This path is named
+	 * as "Channel 3".
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
@@ -3380,8 +3382,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
 			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
-			// Channel 1 corresponds to SLAB ptrs.
-			// Channel 2 corresponds to vmalloc ptrs.
+			// Channel 1 corresponds to SLAB ptrs. bulk path.
+			// Channel 2 corresponds to vmalloc ptrs. bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
 				if (!krwp->bkvhead_free[j]) {
 					krwp->bkvhead_free[j] = krcp->bkvhead[j];
@@ -3389,7 +3391,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				}
 			}
 
-			// Channel 3 corresponds to emergency path.
+			// Channel 3 corresponds to objects queued to the
+			// linked-list for both SLAB and vmalloc pointers.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				krcp->head = NULL;
-- 
2.20.1

