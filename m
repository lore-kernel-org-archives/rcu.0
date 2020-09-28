Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C16C2D0A8
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310FF2076A
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335915;
	bh=eoYp+mSYmZ1ppUAhtwOie70jW0uzDbT+p6LOQaPzRRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lGu4uJWfYwrqTSev9hlceWUvMdGQeU6jFYVjdHkRw6lSwv4aUVwXu8AEhoaYIQXy8
	 ly6+Wpf2qBz3m4pqq5XThPOe189EgtxuvqqnAbzDosGe1P2Yyrkhw2me6/89YeTzWU
	 s9IBbJZvYbvIwuSyHV93Q0L9JNddS64oJvs9DLQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgI1Xbp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgI1XbG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D6421D7F;
        Mon, 28 Sep 2020 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335865;
        bh=eoYp+mSYmZ1ppUAhtwOie70jW0uzDbT+p6LOQaPzRRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jq+onNwb1/7eY13b05zMUB/+/d6eOOk3FqvRGEDxdRYbP33SwyfBvkwc3UJ6VxL4i
         Zkhbhb/Rnn9603dv5qQV0zTt7/9/KBPSTHtEpDUQkSYAf/7GL1oRez42BdgimuDoja
         q4cG9WtSyiJjmTFmT0ZhDxepT/SZUhL9I7Kkm+Ho=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/15] locking/bitspinlock: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:53 -0700
Message-Id: <20200928233102.24265-6-paulmck@kernel.org>
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
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/bit_spinlock.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730..1e03d54 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -90,10 +90,8 @@ static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT_COUNT
-	return preempt_count();
 #else
-	return 1;
+	return preempt_count();
 #endif
 }
 
-- 
2.9.5

