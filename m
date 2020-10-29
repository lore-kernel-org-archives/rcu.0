Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B0EC55179
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92C320FC3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct29Iqn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgJ2QvC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgJ2Qu6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:58 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A8C0613D6;
        Thu, 29 Oct 2020 09:50:57 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so4203271lfj.3;
        Thu, 29 Oct 2020 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpUt4mT/PoPxhoGI6GDvlTPnelKagQoJc6qRPSScVQw=;
        b=ct29Iqn0rHM+D3y4UNzDZVIr2ySU3BuWjzNTeAFChBXKf5anlkR3IdPMzwYAiYnCMe
         mg/cfnhwsMCTmDCGSnu/KDN2bhnB/sWNWR6jW9iJHBCs9BN3JagW7Ft7B2vsvHpiftTz
         7Z53zagyI9udlqcNcOtK04b/PLfbVjgJZ5yOhm2daJKEPvSBwvaXqpR/u6QShRWc1x19
         MDo2M61seHBths5M+cACp4YYj3Ma4eEWZUJj2rl6O0cQ7BfUpJzA58Ykz+6JgfgtXZyT
         KW+xsUxZ7ojjNd5LLdDDytqepJlz9V+sYzTvJDKsdkAsMvWDzlB+KBpT+t4r3CO2KbMf
         cgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpUt4mT/PoPxhoGI6GDvlTPnelKagQoJc6qRPSScVQw=;
        b=csmtNyCyEXqnxF6PNiF6LWGs/SMfADokPi+DHDIQxSjB/NOlRT3IQ/gk7+e4BB9gMb
         Xm79p0g8BuKCIznEbWU2GUFcY7m+fH/V811ga1Zg9kk7AafQqqTBiBb/1FtZfWZu+owJ
         Zc9gjNuxbaSRMyr//L9Ss/BSfl39K3uZyUA/C465MvdR847WxRnCexg6IPv52IGLB5oK
         SV+kft7Z/oiyCXBwBqhyXwtZ70vE0TI7/xpdf1kS4dQir6xHECWDia4VnHw7GK6wOqT7
         WiePr4kGy9RQueNF5c2Ty+cPT6KDi1ZgxwNwH8mb0AXkK2R5sMv/0rN6Dd4kmbWGl5By
         rgtw==
X-Gm-Message-State: AOAM532p4vRbfX6yvGX9qUzLtlnj8sYFrDvS0NzAq6JE9e3+XJFdgrI7
        b+hQl6x4UtDBxqI/TcytfIKdLPcwQGCEyA==
X-Google-Smtp-Source: ABdhPJwbYf7Gpq4DZ/csCqJxkLa08yb8emnU/yijIfn2pR0gCrr/OAyVbdkGI+4QIeo4uAlZvev2ow==
X-Received: by 2002:ac2:515b:: with SMTP id q27mr2011709lfd.123.1603990255361;
        Thu, 29 Oct 2020 09:50:55 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:54 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 15/16] rcu/tree: Allocate a page when caller is preemptible
Date:   Thu, 29 Oct 2020 17:50:18 +0100
Message-Id: <20201029165019.14218-15-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Given that CONFIG_PREEMPT_COUNT is unconditionally enabled by the
earlier commits in this series, the preemptible() macro now properly
detects preempt-disable code regions even in kernels built with
CONFIG_PREEMPT_NONE.

This commit therefore uses preemptible() to determine whether allocation
is possible at all for double-argument kvfree_rcu().  If !preemptible(),
then allocation is not possible, and kvfree_rcu() falls back to using
the less cache-friendly rcu_head approach.  Even when preemptible(),
the caller might be involved in reclaim, so the GFP_ flags used by
double-argument kvfree_rcu() must avoid invoking reclaim processing.

Note that single-argument kvfree_rcu() must be invoked in sleepable
contexts, and that its fallback is the relatively high latency
synchronize_rcu().  Single-argument kvfree_rcu() therefore uses
GFP_KERNEL|__GFP_RETRY_MAYFAIL to allow limited sleeping within the
memory allocator.

[ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 48 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f2da2a1cc716..3f9b016a44dc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3406,37 +3406,55 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	}
 }
 
+// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
+// state specified by flags.  If can_sleep is true, the caller must
+// be schedulable and not be holding any locks or mutexes that might be
+// acquired by the memory allocator or anything that it might invoke.
+// If !can_sleep, then if !preemptible() no allocation will be undertaken,
+// otherwise the allocation will use GFP_ATOMIC to avoid the remainder of
+// the aforementioned deadlock possibilities.  Returns true if ptr was
+// successfully recorded, else the caller must use a fallback.
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_sleep)
 {
 	struct kvfree_rcu_bulk_data *bnode;
+	bool can_alloc_page = preemptible();
+	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL :
+		GFP_ATOMIC) | __GFP_NOWARN;
 	int idx;
 
-	if (unlikely(!krcp->initialized))
+	*krcp = krc_this_cpu_lock(flags);
+	if (unlikely(!(*krcp)->initialized))
 		return false;
 
-	lockdep_assert_held(&krcp->lock);
 	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
-	if (!krcp->bkvhead[idx] ||
-			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
-		bnode = get_cached_bnode(krcp);
-		/* Switch to emergency path. */
+	if (!(*krcp)->bkvhead[idx] ||
+			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
+		if (!bnode && can_alloc_page) {
+			krc_this_cpu_unlock(*krcp, *flags);
+			bnode = (struct kvfree_rcu_bulk_data *)
+				__get_free_page(gfp);
+			*krcp = krc_this_cpu_lock(flags);
+		}
+
 		if (!bnode)
 			return false;
 
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
-		bnode->next = krcp->bkvhead[idx];
+		bnode->next = (*krcp)->bkvhead[idx];
 
 		/* Attach it to the head. */
-		krcp->bkvhead[idx] = bnode;
+		(*krcp)->bkvhead[idx] = bnode;
 	}
 
 	/* Finally insert. */
-	krcp->bkvhead[idx]->records
-		[krcp->bkvhead[idx]->nr_records++] = ptr;
+	(*krcp)->bkvhead[idx]->records
+		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
 
 	return true;
 }
@@ -3474,20 +3492,16 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
 
-		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
 
-- 
2.20.1

