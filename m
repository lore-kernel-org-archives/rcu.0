Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EC8C4727F
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA43A2076A
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335914;
	bh=fkNNUvYgKzjsGWy+k183GC6Ic/RauTWroHJP3SB9FMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n8OjEuLcqF1yg3xKm0ybhjiO21UzxYvw2A7L+GxR5mqRH+/qZJzvWsrxADMVtumY+
	 Hl8gR3hinkKWwNGRWFgl3faPC5Rj/XgbGqmT03WKY2P2Ei6PL4rY7lgVglNn7xRidq
	 CN/ZDzUJvC+KEn5RnufBGpDXg34WhzA6FZofCWno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgI1Xbp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgI1XbG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD8D22207;
        Mon, 28 Sep 2020 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335865;
        bh=fkNNUvYgKzjsGWy+k183GC6Ic/RauTWroHJP3SB9FMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZrETDKN9cjLPUpqfcBm6C+OCQgHH6Wy2jIBL+PvB3Qi5aH2tWBj4YV7lD83FEelB
         ux+UxTSXXrI70YaideL95Zvz54uqVEKX22jsVWgr2hZBqVQqQb0gdT5ZrENcIMapPe
         Ly1bAggQa/UUh9rpEIIWOrHkXb59JJEKmnXbukWI=
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
Subject: [PATCH tip/core/rcu 07/15] uaccess: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:54 -0700
Message-Id: <20200928233102.24265-7-paulmck@kernel.org>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 94b2854..b79a5a9 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -230,9 +230,9 @@ static inline bool pagefault_disabled(void)
  *
  * This function should only be used by the fault handlers. Other users should
  * stick to pagefault_disabled().
- * Please NEVER use preempt_disable() to disable the fault handler. With
- * !CONFIG_PREEMPT_COUNT, this is like a NOP. So the handler won't be disabled.
- * in_atomic() will report different values based on !CONFIG_PREEMPT_COUNT.
+ *
+ * Please NEVER use preempt_disable() or local_irq_disable() to disable the
+ * fault handler.
  */
 #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
 
-- 
2.9.5

