Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973F0C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8231360725
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhGUT5p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhGUT5p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:57:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C1DE61003;
        Wed, 21 Jul 2021 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899901;
        bh=YmBLYBxzI0vMAZMzEd2rQpdpJpi5+nzi5i79rBSEKfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRUilrOpdQSgjt3Wjg/YI0tKcZnzS0ey3WaCgEMEGFYdC94xH21S3fpiK39S4cfLV
         oU/Lr+20sfJrWh+cp+f/gQ4jkDTdyPCFeEm5IQK2t25O+ocszu5rDsXhMt0RNKY8Gj
         eHlAw2gAyEvE09ZC0tg572oaGIaYsUrbSEEQ+SGKEQ4aT97IF6wV3vmAfBaP6BuLzt
         C8yfxJwNmMvadm/XsJ88Hw2dQzZFXrqmeS1q7fvJmHOQfQ+JL8tggNX72kL/kDj+h1
         2b3n3xcFdSnIaHYsbcnZJzYVQoUxLTUA/dwnG8JezPD+BM2+zDghRg+ZZmd9tnAtjZ
         EtSmqzRkgwwzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51CDA5C09A4; Wed, 21 Jul 2021 13:38:21 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/5] rcu-tasks: Add comments explaining task_struct strategy
Date:   Wed, 21 Jul 2021 13:38:14 -0700
Message-Id: <20210721203818.3398345-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
References: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Accesses to task_struct structures must be either protected by RCU
or by get_task_struct().  Tasks trace RCU uses these in a non-obvious
combination, in conjunction with an IPI handler.  This commit therefore
adds comments explaining this usage.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8536c55df5142..6a117375a62a1 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -785,7 +785,10 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
 //	set that task's .need_qs flag so that task's next outermost
 //	rcu_read_unlock_trace() will report the quiescent state (in which
 //	case the count of readers is incremented).  If both attempts fail,
-//	the task is added to a "holdout" list.
+//	the task is added to a "holdout" list.  Note that IPIs are used
+//	to invoke trc_read_check_handler() in the context of running tasks
+//	in order to avoid ordering overhead on common-case shared-variable
+//	accessses.
 // rcu_tasks_trace_postscan():
 //	Initialize state and attempt to identify an immediate quiescent
 //	state as above (but only for idle tasks), unblock CPU-hotplug
@@ -994,6 +997,12 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 	}
 	put_task_struct(t);
 
+	// If this task is not yet on the holdout list, then we are in
+	// an RCU read-side critical section.  Otherwise, the invocation of
+	// rcu_add_holdout() that added it to the list did the necessary
+	// get_task_struct().  Either way, the task cannot be freed out
+	// from under this code.
+
 	// If currently running, send an IPI, either way, add to list.
 	trc_add_holdout(t, bhp);
 	if (task_curr(t) &&
-- 
2.31.1.189.g2e36527f23

