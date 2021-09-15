Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52990C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA6161186
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhIOXr3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233137AbhIOXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A7F46120C;
        Wed, 15 Sep 2021 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=urgWUwpjU48Uw8l1LXBJ0WdQjGvrePBShwdZMhjRLTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjeCT2vrgEyXmiCNeDnP4BHu5ADdwbvG81CZzZXGuHr1dcfl2c8GUcX5N9fzPZ+zr
         P7UjI8SsI13OAk9lXUloOVTcLoKlB/1LznnTcjul7bugTGWjvqENZf2a/KfT03JB53
         ew1a9t8BRYOUzfXbHNnDu1LmDaU5ut+8vcIqGcVAyccjKFxxqGUKcgV+D8DCwYrmH1
         kLtlYIm1hlk6IsMzhpwmayVvB0Imfvi/EQII8x7YD3m6Bl42GUe/0XejhzmIMgGsMi
         Xo6Ta464Gauf/EbGb8SoGd9VRlwpajKVaxJSaTcswUEfO7suPTFDVXNtr4+5xWbVSo
         /Jt4MlJuyOgEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D1C1B5C0DA5; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/13] rcu-tasks: Fix read-side primitives comment for call_rcu_tasks_trace
Date:   Wed, 15 Sep 2021 16:46:02 -0700
Message-Id: <20210915234604.3907802-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

call_rcu_tasks_trace() does have read-side primitives - rcu_read_lock_trace()
and rcu_read_unlock_trace(). Fix this information in the comments.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8c63b4d23829..47a29e411217 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1207,15 +1207,11 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
  * @rhp: structure to be used for queueing the RCU updates.
  * @func: actual callback function to be invoked after the grace period
  *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_tasks_trace()
- * assumes that the read-side critical sections end at context switch,
- * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
- * there are no read-side primitives analogous to rcu_read_lock() and
- * rcu_read_unlock() because this primitive is intended to determine
- * that all tasks have passed through a safe state, not so much for
- * data-structure synchronization.
+ * The callback function will be invoked some time after a trace rcu-tasks
+ * grace period elapses, in other words after all currently executing
+ * trace rcu-tasks read-side critical sections have completed. These
+ * read-side critical sections are delimited by calls to rcu_read_lock_trace()
+ * and rcu_read_unlock_trace().
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -1231,7 +1227,7 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
  *
  * Control will return to the caller some time after a trace rcu-tasks
  * grace period has elapsed, in other words after all currently executing
- * rcu-tasks read-side critical sections have elapsed.  These read-side
+ * trace rcu-tasks read-side critical sections have elapsed. These read-side
  * critical sections are delimited by calls to rcu_read_lock_trace()
  * and rcu_read_unlock_trace().
  *
-- 
2.31.1.189.g2e36527f23

