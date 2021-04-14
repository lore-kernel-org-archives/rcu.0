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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD8C43460
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6476100C
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhDNMNA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhDNMM7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Apr 2021 08:12:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF73CC061756;
        Wed, 14 Apr 2021 05:12:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id n138so32890078lfa.3;
        Wed, 14 Apr 2021 05:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAsiCLgMbg1vUEQUf+3fpmzcw4q07DLXKXDvD0egTx4=;
        b=DhO7CpRrTE4EhaDjdmHattrNUfRuDXoTGgVaXaHXvjaDAWop/OpwyFKWea5SC/IuDg
         KhM2THPg+ogeYMxhz2b2z86OCwyux7gdetbJW85nn6OkWsWE2BGFIa723yOOUv8gTF83
         muAu3395IXCPTmM7MpvUglMDGHeJo9HqFMNtX3SbUgfGJSqDBURrKp3kMeeFRsGbQ5sq
         OajFlNpfmFFE1NHSdfxHBJskFesJre4BGayLRCCOc96xV4ATgs/pi1r0Bs80ee3AXhTd
         FklMYNLzLuZatOfiYnzLaFZu1kH31kyOgP+ioOvTRjctWWCx0z2epT2bhD0dXCssqsOB
         2d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAsiCLgMbg1vUEQUf+3fpmzcw4q07DLXKXDvD0egTx4=;
        b=FPZ3HnPE8R+q4vnpNtLhMhaRFPLGdJHfkCFrJ1u7auKLoMgDuPJyHJJ41g0T2DxtLd
         S14mYcGtciqoqYshX7H7zd7qWdEJyow+M5Oe3QWe9w/0shPp8vpQ0ezTulrKshkeIqhA
         oT5At33G+jrrFgZCl635ROeQwcJEaSTNjStIa3Xjz6jrguW1oVTvSwv0XK+Y4a8DT6Jk
         5tvUo8Qom7sM3EWSFQsO85wa89RqiJmpNug8HLf7dARL990hukAfP6EA5bchGvhgOoFO
         dd4CDiqJtaoNDn9gGlGfPHyr1ryS+Sd9xmRRvKlUvLwulg3/3Qh3GpQxewtFLkXlH5bE
         5oHg==
X-Gm-Message-State: AOAM531FA4j0s9IOh5q8/MrvewEyhG/lCQnHSD3Hm4FiCYtywFAZbbLv
        fz+hpphshXdDHV5nFDEvFTyVVkAM6oNExw==
X-Google-Smtp-Source: ABdhPJxKM6nhKyIRGMmSnmZ4mWxiXcgJD3zerFt1ZZR4gK0K7S11Y/BQ+kx7rV79l6ltFNcFBQhZwA==
X-Received: by 2002:a19:24d4:: with SMTP id k203mr24915756lfk.249.1618402356286;
        Wed, 14 Apr 2021 05:12:36 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i4sm4338061lfu.33.2021.04.14.05.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:12:35 -0700 (PDT)
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
Subject: [PATCH 2/6] kvfree_rcu: use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
Date:   Wed, 14 Apr 2021 14:12:22 +0200
Message-Id: <20210414121226.2650-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210414121226.2650-1-urezki@gmail.com>
References: <20210414121226.2650-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

nr_bkv_objs represents the counter of objects in the page-cache.
Accessing to it requires taking the lock. Switch to READ_ONCE()
WRITE_ONCE() macros to provide an atomic access to that counter.
A shrinker is one of the user of it.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8b74edcd11d4..1b0289fa1cdd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3220,10 +3220,10 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 static inline struct kvfree_rcu_bulk_data *
 get_cached_bnode(struct kfree_rcu_cpu *krcp)
 {
-	if (!krcp->nr_bkv_objs)
+	if (!READ_ONCE(krcp->nr_bkv_objs))
 		return NULL;
 
-	krcp->nr_bkv_objs--;
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs - 1);
 	return (struct kvfree_rcu_bulk_data *)
 		llist_del_first(&krcp->bkvcache);
 }
@@ -3233,13 +3233,12 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 	struct kvfree_rcu_bulk_data *bnode)
 {
 	// Check the limit.
-	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
+	if (READ_ONCE(krcp->nr_bkv_objs) >= rcu_min_cached_objs)
 		return false;
 
 	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
-	krcp->nr_bkv_objs++;
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs + 1);
 	return true;
-
 }
 
 static int
@@ -3251,7 +3250,7 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	page_list = llist_del_all(&krcp->bkvcache);
-	krcp->nr_bkv_objs = 0;
+	WRITE_ONCE(krcp->nr_bkv_objs, 0);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	llist_for_each_safe(pos, n, page_list) {
@@ -3655,18 +3654,13 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
 	unsigned long count = 0;
-	unsigned long flags;
 
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		count += krcp->nr_bkv_objs;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
+		count += READ_ONCE(krcp->nr_bkv_objs);
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
-- 
2.20.1

