Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC04C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18ECB64EC4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbhCDBAg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353199AbhCDADm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7CB664FD1;
        Thu,  4 Mar 2021 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816024;
        bh=2cVOxQi7iGBZVGepm0aakhFw6rUOY5A0rKFcxvguoJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzCDfXSkiCpwpjA+gBaI/y78YzD8DI4+n1cNsQx3lh3WSbtjMFjjS6WwEnTITUXMK
         NLaU4Fki6FtCs0SJaME1I/EKheG2uIrZv85OwpmOslpTEY6QDPHKB3jvVWhI+11Fl+
         EsFdtVtupYHFlFvTJH7Pf3/qxujX0EulOrT3ZSwbZiK9q2F/U9LmsrvdH3425ldgy3
         S04eNXb8MXNJGVIQF/l61jO3rRiZYhGJ35c/wUlOE5z5y5t09vzL8VihE/FmZ3X4pm
         pci08sBZQYDStYfvgeCm9rXz2u3M7c/68fSqYu3NS3XFqzjZGFGkGGJMJcWIKnR29D
         ykJcK4nuZ6rSQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/10] rcu: Add explicit barrier() to __rcu_read_unlock()
Date:   Wed,  3 Mar 2021 16:00:18 -0800
Message-Id: <20210304000019.22459-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Because preemptible RCU's __rcu_read_unlock() is an external function,
the rough equivalent of an implicit barrier() is inserted by the compiler.
Except that there is a direct call to __rcu_read_unlock() in that same
file, and compilers are getting to the point where they might choose to
inline the fastpath of the __rcu_read_unlock() function.

This commit therefore adds an explicit barrier() to the very beginning
of __rcu_read_unlock().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 36212de..d9495de 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -393,8 +393,9 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
+	barrier();  // critical section before exit code.
 	if (rcu_preempt_read_exit() == 0) {
-		barrier();  /* critical section before exit code. */
+		barrier();  // critical-section exit before .s check.
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
 	}
-- 
2.9.5

