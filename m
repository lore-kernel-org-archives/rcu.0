Return-Path: <SRS0=xZUe=C3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADAC43464
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56625235F8
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L06jfMN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIRTsz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgIRTso (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 15:48:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD3C0613CE;
        Fri, 18 Sep 2020 12:48:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so6053326ljk.0;
        Fri, 18 Sep 2020 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SzvHH1kSKdJ2ziBgd9Jq8Z/nxeBRoANgHFle/0iuLew=;
        b=L06jfMN2PzbFEpKONJ57B5VlRj0rlQ0Zbw9IIWkpz1wKb8dQNExEe1OJMnfZHUCnko
         xX0nkCOl2aW4CdKV33nWLFKXSYE/xp0VPkqTgtkQdCwM/zJW72gYCjseA32MZawSOqBR
         asl+Iv2Nl/CSx7Hme52926esMeA3s2paJYuO0Doh3AZHAz4v/yq/wYUK9iLM4cZXU5xf
         Wp/Ts/6WBrsURw/Gr5AyZLA2x9hfSEOCutnjyFw9WqhtybeVfiXorWGBStNLRcH2oSqq
         aUcADxo/mRjYcLU7QDBOLqIDgnzdH/bAuyAkiM4ITemEsvaoKRQEb781x/xaU8/aM6Gb
         FYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SzvHH1kSKdJ2ziBgd9Jq8Z/nxeBRoANgHFle/0iuLew=;
        b=eKEW9P33/Ix4SwTlNcBmQKGHj0FnA4NlTUQCYSwGaMjwz5b8i6m3G5I9ZrP7gwzKTE
         F4lh7EzoqGjMWvZDZrxYXctqQId4qOABgxUg39kHHSJe4fMCUEPVxkAC3p9fXnSVg8VS
         yED8Qu1k1IEs1dTSxH1nAporu4OqnSqCUptZpNVuoXH6WRJA3l2hA+CtvWlKKvoX3klb
         oITOod44DjQ96KyNqsOJc8XB3Buiqqpd9+aOjffn5LXG+cNXWNULyx13nHNFyZYb8Kqv
         JTMCcBixJW5fsGmUMaHh1VQjANfJkh3sr8rpIPcp2bCdPkBQ8DHFVu5+9AHMOwxjUm8c
         T8iw==
X-Gm-Message-State: AOAM531eGoFdnVxmHoGjA243MZlZ8nKHxs9kuJSnW2EaSPbIL4zYQhA7
        6L4v7542UG1EQY37j6Vtvg3pWPSuaCE0u7KL
X-Google-Smtp-Source: ABdhPJzK/m1EMHaCbJdkbPMwOFhH52Qvuz4FPNXfeee2GFnRfrriSXfCcozLep37DAqr2fWTcDnZSQ==
X-Received: by 2002:a2e:6f1c:: with SMTP id k28mr11293487ljc.297.1600458521547;
        Fri, 18 Sep 2020 12:48:41 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a17sm766769lfd.148.2020.09.18.12.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 12:48:41 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 4/4] rcu/tree: Use schedule_delayed_work() instead of WQ_HIGHPRI queue
Date:   Fri, 18 Sep 2020 21:48:17 +0200
Message-Id: <20200918194817.48921-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918194817.48921-1-urezki@gmail.com>
References: <20200918194817.48921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Recently the separate worker thread has been introduced to
maintain the local page cache from the regular kernel context,
instead of kvfree_rcu() contexts. That was done because a caller
of the k[v]free_rcu() can be any context type what is a problem
from the allocation point of view.

From the other hand, the lock-less way of obtaining a page has
been introduced and directly injected to the k[v]free_rcu() path.

Therefore it is not important anymore to use a high priority "wq"
for the external job that used to fill a page cache ASAP when it
was empty.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d51209343029..f2b4215631f7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3100,7 +3100,7 @@ struct kfree_rcu_cpu {
 	 * lockless an access has to be protected by the
 	 * per-cpu lock.
 	 */
-	struct work_struct page_cache_work;
+	struct delayed_work page_cache_work;
 	atomic_t work_in_progress;
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
@@ -3354,7 +3354,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	struct kvfree_rcu_bulk_data *bnode;
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work);
+			page_cache_work.work);
 	unsigned long flags;
 	bool pushed;
 	int i;
@@ -3440,7 +3440,6 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
-	bool irq_disabled = irqs_disabled();
 	bool success;
 	void *ptr;
 
@@ -3473,9 +3472,9 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
-		// TODO: schedule the work from the hrtimer.
-		if (!irq_disabled && !atomic_xchg(&krcp->work_in_progress, 1))
-			queue_work(system_highpri_wq, &krcp->page_cache_work);
+		// Use delayed work, so we do not deadlock with rq->lock.
+		if (!atomic_xchg(&krcp->work_in_progress, 1))
+			schedule_delayed_work(&krcp->page_cache_work, 1);
 
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
@@ -4475,7 +4474,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.20.1

