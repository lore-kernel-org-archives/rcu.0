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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17A8C433DB
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870F122CE3
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 16:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403947AbhATQ0e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732122AbhATQWQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Jan 2021 11:22:16 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112EC061575;
        Wed, 20 Jan 2021 08:22:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o19so34881273lfo.1;
        Wed, 20 Jan 2021 08:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VriEGqHJd7ubfWb3Z6Vz74ftrCFRLMr6jr+eNOE2nDc=;
        b=XZeJlXxbBvwiuH1+DLfBzdw0Z9UQhvUK6/yfgiEYhs3N2rx2/4g5Mx2XUNa0pLx2o2
         FxjDXEVgpEj1tZyZA8Pm/drgLsIuLJG1VLHBJpXkaeTLYZLmSxDO3lQhC45vumLE8WlW
         5PReriT5Vjx4ITwyv/13uV85ZqOlmCSCrOQRINj8EfELoeUKSDjtEnjuFjYs6VIVrgfs
         6Zz7iP6jWq+B6dAow9eZ+QZz/tcUZiQsDiRTIwbDohPEsKC9B5Q6cNGXJuNAEFSCEJ/X
         62lEBJt9rQrmKU+aBFe0Aql7YQFjn6pf6S1/yle4hw8WrKGANX3zY1flNygDPS8ko90j
         6zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VriEGqHJd7ubfWb3Z6Vz74ftrCFRLMr6jr+eNOE2nDc=;
        b=Ps4Hvr4hK8Yno3sLflE7XIVGgInUdzcvSsA18oVmqWWpwrPW9eKjZTntYwTr2sMYZA
         6RNerKzGJCwivN7sl30tmCammjtJO6X0P5T++SXc4RFrfTchWj2zf6NwQ2YsUNDu2IPh
         mdsPuY7sWbci1DVKJ/3dXi0lp5oezRUvMtvjppkTQ7VYbQioxumh6SYCagGy2wyO6V2Q
         q85ocHHGjJYbveUqvchAJcAkYzgjOaLoC7GMZTldR7qogY88XIf0w96EbDNe42saH3IY
         8Q3xFlcMnSVLMYXpkUZQh3/Fvn0oxxbLe1TVzPFCm9BTw+RBMiRA+sZ/J1bEfY9xuVBj
         m1GQ==
X-Gm-Message-State: AOAM5330hrwLxqtyHTvHOEfE6pe8g1puxZgdg9V10ZVJspmA1/eNGwtK
        8iPuSNnBF5BAaagLxsz/1Di+Ol6+P4g=
X-Google-Smtp-Source: ABdhPJwZRwBNnLP34wQVSIx33j2/6mh/2omlXo3EYuynACOcIXmtwKR2H9LgsrWGFF/VBNJpluZq5w==
X-Received: by 2002:a19:c20a:: with SMTP id l10mr4662296lfc.155.1611159719511;
        Wed, 20 Jan 2021 08:21:59 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id l8sm237631lfd.276.2021.01.20.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:21:58 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Date:   Wed, 20 Jan 2021 17:21:46 +0100
Message-Id: <20210120162148.1973-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

For a single argument we can directly request a page from a caller
context when a "carry page block" is run out of free spots. Instead
of hitting a slow path we can request an extra page by demand and
proceed with a fast path.

A single-argument kvfree_rcu() must be invoked in sleepable contexts,
and that its fallback is the relatively high latency synchronize_rcu().
Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
to allow limited sleeping within the memory allocator.

[ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e04e336bee42..2014fb22644d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3465,37 +3465,50 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	}
 }
 
+// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
+// state specified by flags.  If can_alloc is true, the caller must
+// be schedulable and not be holding any locks or mutexes that might be
+// acquired by the memory allocator or anything that it might invoke.
+// Returns true if ptr was successfully recorded, else the caller must
+// use a fallback.
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_alloc)
 {
 	struct kvfree_rcu_bulk_data *bnode;
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
+		if (!bnode && can_alloc) {
+			krc_this_cpu_unlock(*krcp, *flags);
+			bnode = (struct kvfree_rcu_bulk_data *)
+				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
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
@@ -3533,8 +3546,6 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
@@ -3542,12 +3553,11 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			  __func__, head);
 
 		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
 	kasan_record_aux_stack(ptr);
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
 
-- 
2.20.1

