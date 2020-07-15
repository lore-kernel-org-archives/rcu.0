Return-Path: <SRS0=HY8l=A2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C33C433E1
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 18:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1CC20656
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 18:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHh+UXQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGOSfs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgGOSfr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jul 2020 14:35:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8CAC061755;
        Wed, 15 Jul 2020 11:35:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so3708890ljj.10;
        Wed, 15 Jul 2020 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9PukKTmvcEtFB/zd8C81i1uDCtVpQUHLXdMmIW0atQ=;
        b=IHh+UXQJ7ALwam/o+gFoelFuyxHtkXg6aIc41790oeW8Jop7ibxd/8Yn1QicWPXRp4
         cge9/FbC6c/CqS2j2tYZ4Dzb2/Od1HS0HggYxGxUEmVXQeHCEf3NY53e1FVOHy9HVXl1
         vRmYPi/QHrxmXmBCGkh/HIrBQo1zlDqLJYkwliuDSZzrPHsCIK1FUynrX2ZbtGf4Kj1f
         4YDBoG5clgz7f+4Sdlx3IGclHWLrWLfYno/PMYhT/jnWP4AqmtV3/KaE3idd8Bp56PAl
         djmoDFM13a8i/ckLXXWGKffm/1FkWWyVLyWx/hZkhiVtmNkt5yHhidfS4Ok1Fdg26Yd/
         68HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9PukKTmvcEtFB/zd8C81i1uDCtVpQUHLXdMmIW0atQ=;
        b=OpjOmdMppIIMV7DiL61yyusqSymVnD4fiEio8XeZjQTb3Z26ZcAskOGZIYd4w+xOXQ
         Cv0bEL4ouvZNJDovI1UNy+KaAn35+zE/HKqXb8FesbKxDNrbU6WwcQuDMDdMlz6e6RwQ
         n5cSahV7X7jEjlnqRjJd8TmuoWU05fbGcI9gMPxtl0JIQ6dc220TlNC4IWalypa5dGRg
         UTkep9cQPnMaRCBRNTNqlO6rAGn4BpJBigesm/i+cVeYwoAuBqPsD8T6ixVv8fW+JJWW
         kxkosVKEjihYUvU/LjpZxipO+VMgOvuRfAuiL0lv9LRt/XajzPKLn9++pxt50EPqrZ6h
         YtQg==
X-Gm-Message-State: AOAM5320BtbuZdi+BwBLM/y+ThKsNGEfRIWD2ZHOWx8YqP0AJhWQZ7kv
        Iolgp4YdC9PiVyW5qmTUWv4sJaok9ac=
X-Google-Smtp-Source: ABdhPJwGU5kzEPsSphSpBxfCet59z1f+F8QI5AGjewge8SCR03L2rLj/ScWSD4l0X7MjA1+f8rBqUw==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr198256ljg.400.1594838145336;
        Wed, 15 Jul 2020 11:35:45 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u27sm586992ljd.79.2020.07.15.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 11:35:44 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/1] rcu/tree: Drop the lock before entering to page allocator
Date:   Wed, 15 Jul 2020 20:35:37 +0200
Message-Id: <20200715183537.4010-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If the kernel is built with CONFIG_PROVE_RAW_LOCK_NESTING
option, the lockedp will complain about violation of the
nesting rules. It does the raw_spinlock vs. spinlock nesting
checks.

Internally the kfree_rcu() uses raw_spinlock_t whereas the
page allocator internally deals with spinlock_t to access
to its zones.

In order to prevent such vialation that is in question we
can drop the internal raw_spinlock_t before entering to
the page allocaor.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 21c2fa5bd8c3..7469bd1e5c2c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3278,21 +3278,22 @@ static void kfree_rcu_monitor(struct work_struct *work)
 }
 
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr)
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
+	if (!(*krcp)->bkvhead[idx] ||
+			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
 		if (!bnode) {
 			/*
 			 * To keep this path working on raw non-preemptible
@@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			if (IS_ENABLED(CONFIG_PREEMPT_RT))
 				return false;
 
+			preempt_disable();
+			krc_this_cpu_unlock(*krcp, *flags);
+
 			/*
 			 * NOTE: For one argument of kvfree_rcu() we can
 			 * drop the lock and get the page in sleepable
@@ -3315,6 +3319,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			 */
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+			*krcp = krc_this_cpu_lock(flags);
+			preempt_enable();
 		}
 
 		/* Switch to emergency path. */
@@ -3323,15 +3330,15 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 
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
@@ -3369,24 +3376,19 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
-
-		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
 	/*
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr);
 	if (!success) {
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
-- 
2.20.1

