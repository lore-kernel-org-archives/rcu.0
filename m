Return-Path: <SRS0=qouz=BG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2F6C433E3
	for <rcu@archiver.kernel.org>; Mon, 27 Jul 2020 21:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BB920786
	for <rcu@archiver.kernel.org>; Mon, 27 Jul 2020 21:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP+7r2dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgG0VKY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0VKW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jul 2020 17:10:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45611C061794;
        Mon, 27 Jul 2020 14:10:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i80so9772396lfi.13;
        Mon, 27 Jul 2020 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCi4uQupGH9wlbYDIIaXDuhHkIJkqnW5jRCmhH4yzys=;
        b=iP+7r2dt0mrERD07SdS+TGzP3SyiL1AoMitm778mxLBgJZrySPoHh14xUJfzeLz3EW
         daetsozIsLIZLGcVVraW3Pmc5VAuA2+odgfJLWBYul6shRJ9hh0Qgp/svRTItr1aTWTe
         RxWRKJCIdxzKFXV/QM9dPDBoGbmKArmISv250T5rYezYh69L6dIp0+NntO7tF00HJwr2
         R1KkIYCfuDYF3NKEpywJJuDXrFTbw83C9pNgaChmhw5v05WuAFe1eTxpXzAkoMG+dPLP
         DsRsoV7FL6PuFxs1I+S81exnBP7IBPH+DBS7qPlw8yaNONrobm9F0AqURFY18yLGtnSC
         k0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCi4uQupGH9wlbYDIIaXDuhHkIJkqnW5jRCmhH4yzys=;
        b=njxqLsWRPkpAbi7HqUA+39SJw/UM+zx0VFlLuQmO2qfQJgVAR24z07NOzpdl0QhhN9
         alvBrpWCBwjmzoEO2B43x/HHlNOzR9LyWdaRTryyP7T+rkN0LBt+6zVYbW9TfvyEVor7
         8QXeoPKj1sKSnow6hQTXZElda3DoaqUT/oE6QRIBiLpnjt8iYYrTVWf6rwcybLM63gha
         YDvnGpNQFnQPdNg4I4ThDRVWzYV67GtKeSPSRXa6r5oGfB5cuaPKE2bF+ExvSHqAvIqn
         zD0nbxZHVRQIjZDAXq75wtAuxRUmv3KY12yh+HnLsliE38EZt8NJ21MJr4e1KtP7WozL
         uYEQ==
X-Gm-Message-State: AOAM532jd9m04i0YoTwEKoIINIlMyAM7BjYLQD1mf4E2vzLD/9fiyREg
        98M0r6INbzg20mkH5iUc3w4icDii850=
X-Google-Smtp-Source: ABdhPJwJkrQ26iT00/yNlcmK6rwCV8JlV2VJHQdUO53NwZI5VUUccB9yeYw2y0rV9rMYW2G9Uff4ag==
X-Received: by 2002:a05:6512:10ca:: with SMTP id k10mr12911706lfg.177.1595884220130;
        Mon, 27 Jul 2020 14:10:20 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm3266078lfi.76.2020.07.27.14.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:10:19 -0700 (PDT)
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
Subject: [PATCH v2 1/1] rcu/tree: Drop the lock before entering to page allocator
Date:   Mon, 27 Jul 2020 23:10:12 +0200
Message-Id: <20200727211012.30948-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If the kernel is built with CONFIG_PROVE_RAW_LOCK_NESTING
option, the lockedp will complain about violation of the
nesting rules:

<snip>
[   28.060389] =============================
[   28.060389] [ BUG: Invalid wait context ]
[   28.060389] 5.8.0-rc3-rcu #211 Tainted: G            E
[   28.060389] -----------------------------
[   28.060390] vmalloc_test/0/523 is trying to lock:
[   28.060390] ffff96df7ffe0228 (&zone->lock){-.-.}-{3:3}, at: get_page_from_freelist+0xcf0/0x16d0
[   28.060391] other info that might help us debug this:
[   28.060391] context-{5:5}
[   28.060392] 2 locks held by vmalloc_test/0/523:
[   28.060392]  #0: ffffffffc06750d0 (prepare_for_test_rwsem){++++}-{4:4}, at: test_func+0x76/0x240 [test_vmalloc]
[   28.060393]  #1: ffff96df5fa1d390 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x5c/0x230
[   28.060395] stack backtrace:
[   28.060395] CPU: 0 PID: 523 Comm: vmalloc_test/0 Tainted: G            E     5.8.0-rc3-rcu #211
[   28.060395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   28.060396] Call Trace:
[   28.060397]  dump_stack+0x96/0xd0
[   28.060397]  __lock_acquire.cold.65+0x166/0x2d7
[   28.060398]  ? find_held_lock+0x2d/0x90
[   28.060399]  lock_acquire+0xad/0x370
[   28.060400]  ? get_page_from_freelist+0xcf0/0x16d0
[   28.060401]  ? mark_held_locks+0x48/0x70
[   28.060402]  _raw_spin_lock+0x25/0x30
[   28.060403]  ? get_page_from_freelist+0xcf0/0x16d0
[   28.060404]  get_page_from_freelist+0xcf0/0x16d0
[   28.060405]  ? __lock_acquire+0x3ee/0x1b90
[   28.060407]  __alloc_pages_nodemask+0x16a/0x3a0
[   28.060408]  __get_free_pages+0xd/0x30
[   28.060409]  kvfree_call_rcu+0x18a/0x230
<snip>

Internally the kfree_rcu() uses raw_spinlock_t whereas the
page allocator internally deals with spinlock_t to access
to its zones.

In order to prevent such vialation that is in question we
can drop the internal raw_spinlock_t before entering to
the page allocaor.

Short changelog (v1 -> v2):
    - rework the commit message;
    - rework the patch making it smaller;
    - add more comments.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 21c2fa5bd8c3..2de112404121 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3287,6 +3287,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 		return false;
 
 	lockdep_assert_held(&krcp->lock);
+	lockdep_assert_irqs_disabled();
+
 	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
@@ -3306,6 +3308,29 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			if (IS_ENABLED(CONFIG_PREEMPT_RT))
 				return false;
 
+			/*
+			 * If built with CONFIG_PROVE_RAW_LOCK_NESTING option,
+			 * the lockedp will complain about violation of the
+			 * nesting rules. It does the raw_spinlock vs. spinlock
+			 * nesting checks.
+			 *
+			 * That is why we drop the raw lock. Please note IRQs are
+			 * still disabled it guarantees that the "current" stays
+			 * on the same CPU later on when the raw lock is taken
+			 * back.
+			 *
+			 * It is important because if the page allocator is invoked
+			 * in fully preemptible context, it can be that we get a page
+			 * but end up on another CPU. That another CPU might not need
+			 * a page because of having some extra spots in its internal
+			 * array for pointer collecting. Staying on same CPU eliminates
+			 * described issue.
+			 *
+			 * Dropping the lock also reduces the critical section by
+			 * the time taken by the page allocator to obtain a page.
+			 */
+			raw_spin_unlock(&krcp->lock);
+
 			/*
 			 * NOTE: For one argument of kvfree_rcu() we can
 			 * drop the lock and get the page in sleepable
@@ -3315,6 +3340,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			 */
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+			raw_spin_lock(&krcp->lock);
 		}
 
 		/* Switch to emergency path. */
-- 
2.20.1

