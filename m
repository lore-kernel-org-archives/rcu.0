Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F31C47420
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDAE21775
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335870;
	bh=HW3WLAbLa/DDacocfXYxB/vBr3vj5XsMjR75MZeRWFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tor5yfeFKJDH4V/qVL7V6IBSKTJenJydqHNgBX37UjVLMZBRINCJZeBbXxuzNztHw
	 TykEzbkM8/PBcl7F6S6UL6Ndp+/cdoeYJzNTI+l9VjXIilprgdPYcbxil2r1CIQnPj
	 op6xR+kQlLWhS4GdN3fxzM9wfy/JqYPN4E8KyitE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgI1XbK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbgI1XbF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:05 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E77221EF;
        Mon, 28 Sep 2020 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335865;
        bh=HW3WLAbLa/DDacocfXYxB/vBr3vj5XsMjR75MZeRWFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IR9+I8ZuK6FafBQuDFZUNiEgjTo8ljxHJQ961A34knvPVzpwFIPiI1O+84YMb70Nb
         JJNwUOMjLNjHZNfogZw85A+boWrkC8MzWATT7hZgzIFcsS41yhsZxYR0UbkXgrDE8N
         FQAh1830dQxS8O55pLXXP4klwfoMfNIewE+7pJgQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/15] mm/pagemap: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:52 -0700
Message-Id: <20200928233102.24265-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
[ paulmck: Fix !SMP build error per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/pagemap.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7de11dc..b3d9d92 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -168,9 +168,7 @@ void release_pages(struct page **pages, int nr);
 static inline int __page_cache_add_speculative(struct page *page, int count)
 {
 #ifdef CONFIG_TINY_RCU
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
+	VM_BUG_ON(preemptible());
 	/*
 	 * Preempt must be disabled here - we rely on rcu_read_lock doing
 	 * this for us.
-- 
2.9.5

