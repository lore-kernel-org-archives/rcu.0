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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FADC433B4
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE1E61435
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhD1Npz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbhD1Npy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Apr 2021 09:45:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D35C061574;
        Wed, 28 Apr 2021 06:45:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m7so61449662ljp.10;
        Wed, 28 Apr 2021 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOcHw79BufjsyfuqtBTwSYNoekd4YMB2iJoEpjD8UK4=;
        b=vIRdjNJoooUM7Bvt94bvAkmYnsJ986bsP3xSBfYv3JdCAd1OfG8dLY167xD62Efjf2
         V/z1rOr4Nwu6ZorN3iNmJmw2Hp9mvpNSGld67MSBPhNEaUdfyS2JmnNSXRfxxWhG2HfJ
         McqHHislTj3lVjiEBCTXr/XqZOTS1VzrukGoK782v+E7IdMdAmlGguCutFWgLgtl5BOz
         BYULCPQlOtiFoZ1yGNOdBi6RgWMSDrrto4WiWeZzlNshpGsQvVHs7gawOENkNviuUWUs
         0iONngtw9jWuA/cybZcvCNRrXNLLNzuXiDo3dGnCZ7Qo8XBlSB5bjRckhc1VdL7htnYi
         a/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOcHw79BufjsyfuqtBTwSYNoekd4YMB2iJoEpjD8UK4=;
        b=e05X+8IwoX70DV7ZaBHKIcgdDNl0wiZ6pLr6AaRTfJSfISyh0BbZDtxVpFnQOFYwEr
         Z4iTOZoTZy5ShdrB1jSgzTXzFfMbLS7AYLwBzaXjvhmOpVVkqSMf0FC9FS/qSMk1oTsr
         WIWYNCGTUobKockWKHIwzLNfcvukkFaARoNCIksYeuURzq8hhL67kQeUY+vofE793wUr
         oVHeUIvFz/2Idyvok5xRm21v7m3dGkE1OBhUaw94+UqtdS8WD9nO+K8RMnbGTHp5vpHC
         fuglFtYWB50t22XREsBnlOGTaqEH5zXOSJx/OFh+jjaAFmhES+IhVeRsKoRyz53ualkb
         hPnA==
X-Gm-Message-State: AOAM532lQljLA9wPP8I43PyjC/wBDxKy7BPHVqBSQMFWdRHRYUb9Wet4
        Wv5tX5O8Lbzz+tcui4uMFnUHM+GlmKMmWuCJM+8=
X-Google-Smtp-Source: ABdhPJwrlgVcykRnyX5kq4lZwcM1aIWBxb4wxMaMeUqAp7deBph9moxP2APQXN1WBf/Ne/9DxQQvng==
X-Received: by 2002:a2e:4611:: with SMTP id t17mr20387048lja.334.1619617508096;
        Wed, 28 Apr 2021 06:45:08 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o16sm730253lfu.228.2021.04.28.06.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 06:45:07 -0700 (PDT)
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
Subject: [PATCH v1 3/5] kvfree_rcu: Rename rcu_invoke_kfree_bulk_callback
Date:   Wed, 28 Apr 2021 15:44:20 +0200
Message-Id: <20210428134422.1894-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210428134422.1894-1-urezki@gmail.com>
References: <20210428134422.1894-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The purpose of renaming is to have one common trace event
for APIs which use a special "bulk" form to release memory.

In our case we have kfree_bulk() and vfree_bulk(). It does
not make sense to implement two separate trace events which
would be identical expect for their names.

Rename it to "rcu_invoke_free_bulk_callback" and use it as
one trace event for both bulk API's.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/rcu.h |  4 ++--
 kernel/rcu/tree.c          | 16 +++++++++-------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 918585d85af9..0855cb35ae4e 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -681,11 +681,11 @@ TRACE_EVENT_RCU(rcu_invoke_kvfree_callback,
 
 /*
  * Tracepoint for the invocation of a single RCU callback of the special
- * kfree_bulk() form. The first argument is the RCU flavor, the second
+ * "free bulk" form. The first argument is the RCU flavor, the second
  * argument is a number of elements in array to free, the third is an
  * address of the array holding nr_records entries.
  */
-TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
+TRACE_EVENT_RCU(rcu_invoke_free_bulk_callback,
 
 	TP_PROTO(const char *rcuname, unsigned long nr_records, void **p),
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6bf170d01cd5..e44d6f8c56f0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3305,16 +3305,18 @@ static void kfree_rcu_work(struct work_struct *work)
 			debug_rcu_bhead_unqueue(bkvhead[i]);
 
 			rcu_lock_acquire(&rcu_callback_map);
-			if (i == 0) { // kmalloc() / kfree().
-				trace_rcu_invoke_kfree_bulk_callback(
-					rcu_state.name, bkvhead[i]->nr_records,
-					bkvhead[i]->records);
 
+			trace_rcu_invoke_free_bulk_callback(
+				rcu_state.name, bkvhead[i]->nr_records,
+				bkvhead[i]->records);
+
+			if (i == 0) // kmalloc() / kfree().
 				kfree_bulk(bkvhead[i]->nr_records,
 					bkvhead[i]->records);
-			} else { // vmalloc() / vfree().
-				vfree_bulk(bkvhead[i]->nr_records, bkvhead[i]->records);
-			}
+			else // vmalloc() / vfree().
+				vfree_bulk(bkvhead[i]->nr_records,
+					bkvhead[i]->records);
+
 			rcu_lock_release(&rcu_callback_map);
 
 			raw_spin_lock_irqsave(&krcp->lock, flags);
-- 
2.20.1

