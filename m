Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B7C77B7D
	for <rcu@archiver.kernel.org>; Wed, 10 May 2023 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjEJRDN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 May 2023 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjEJRDL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 May 2023 13:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489441BE1;
        Wed, 10 May 2023 10:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A89E64A23;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9363C433A0;
        Wed, 10 May 2023 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738163;
        bh=6K2M1cneLOAe74u4tZCwr+yARE8eIXwk93Jk4FtsLn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4R3E6uIcqhWGD8EYNG9KFHdbkY/l9v+pVqVqsInWzWRUn36+n0VVh6N5BQxai288
         qq+gR80SGvdKfiyN1tBxMPWF32Kkf+ona9PTtFoZV7UmDp8bzfcURR/QbBog3yF4tY
         7YAxqFOdOUyEZWIsc2LPNg5vGkYWRSHUW1EWnvzYkZGbQmBUiu8I/BdxCDK01K2nAL
         hvPrrPcxbyJ8svS3HxDd9qVN3oJaU71YJvh1V7D8E4LyPhPR8mH2GWA5zKR0lwIGox
         EiPp0oBQb2gLUCxUS2c9DxaUzrtTvur9BuZ+wvDod4n2kvMXhMmD6rBoUL/KkIXxhz
         BNUiDewW6oHvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55F22CE127F; Wed, 10 May 2023 10:02:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/8] rcu/kvfree: Use consistent krcp when growing kfree_rcu() page cache
Date:   Wed, 10 May 2023 10:02:39 -0700
Message-Id: <20230510170242.2187714-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
References: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

The add_ptr_to_bulk_krc_lock() function is invoked to allocate a new
kfree_rcu() page, also known as a kvfree_rcu_bulk_data structure.
The kfree_rcu_cpu structure's lock is used to protect this operation,
except that this lock must be momentarily dropped when allocating memory.
It is clearly important that the lock that is reacquired be the same
lock that was acquired initially via krc_this_cpu_lock().

Unfortunately, this same krc_this_cpu_lock() function is used to
re-acquire this lock, and if the task migrated to some other CPU during
the memory allocation, this will result in the kvfree_rcu_bulk_data
structure being added to the wrong CPU's kfree_rcu_cpu structure.

This commit therefore replaces that second call to krc_this_cpu_lock()
with raw_spin_lock_irqsave() in order to explicitly acquire the lock on
the correct kfree_rcu_cpu structure, thus keeping things straight even
when the task migrates.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 426f1f3bb5f2..51d84eabf645 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3279,7 +3279,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 			// scenarios.
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
-			*krcp = krc_this_cpu_lock(flags);
+			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
 		}
 
 		if (!bnode)
-- 
2.40.1

