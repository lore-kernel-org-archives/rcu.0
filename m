Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B619C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ADF2072D
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724631;
	bh=KDgPHykD0We0jRCxEKxxG0D6uKEtDAatkVlJdEZQ+E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GSv4mTEsheIEkQVQA8L/wlXEasPEjWWupzf958enNLTUhWWKDk4pkX+hO4lpLtIdX
	 pH8KpgqGZhqmJmstk1EtTuzO8ZwsCdC7YHv8poOIl/kdicqeOc5t5QIe8Zyg4DYUWT
	 4d6VprP0V+Try9sqhA8nXi/lJYKHZdjluQJk3F8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgBNX5K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNX5J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:09 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3592187F;
        Fri, 14 Feb 2020 23:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724629;
        bh=KDgPHykD0We0jRCxEKxxG0D6uKEtDAatkVlJdEZQ+E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlNsfA8b6DlgGznU66LiekGj6yA3vPGuq7TUqdaLNt9lvcdXw9y7L8+yU+3RMYDWr
         6dVEjyyRDTxgN7CDXtl0XAGIk0pH7iVpTMN9BxhbAJhTml4982rt9TMhmUb244ikNY
         YJv9jg92+zuz962B683pKbzBN4TTwlrz9YDYvf6A=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/30] rcu: Add *_ONCE() to rcu_node ->boost_kthread_status
Date:   Fri, 14 Feb 2020 15:55:53 -0800
Message-Id: <20200214235607.13749-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->boost_kthread_status field is accessed
locklessly, so this commit causes all updates to use WRITE_ONCE() and
all reads to use READ_ONCE().

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b5ba148..0f8b714 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1032,18 +1032,18 @@ static int rcu_boost_kthread(void *arg)
 
 	trace_rcu_utilization(TPS("Start boost kthread@init"));
 	for (;;) {
-		rnp->boost_kthread_status = RCU_KTHREAD_WAITING;
+		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
 		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
 		rcu_wait(rnp->boost_tasks || rnp->exp_tasks);
 		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
-		rnp->boost_kthread_status = RCU_KTHREAD_RUNNING;
+		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
 		if (more2boost)
 			spincnt++;
 		else
 			spincnt = 0;
 		if (spincnt > 10) {
-			rnp->boost_kthread_status = RCU_KTHREAD_YIELDING;
+			WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_YIELDING);
 			trace_rcu_utilization(TPS("End boost kthread@rcu_yield"));
 			schedule_timeout_interruptible(2);
 			trace_rcu_utilization(TPS("Start boost kthread@rcu_yield"));
@@ -1082,7 +1082,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 			rnp->boost_tasks = rnp->gp_tasks;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		rcu_wake_cond(rnp->boost_kthread_task,
-			      rnp->boost_kthread_status);
+			      READ_ONCE(rnp->boost_kthread_status));
 	} else {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
-- 
2.9.5

