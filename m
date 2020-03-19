Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D80BC55188
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8937216FD
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576687;
	bh=6byI644vY95Z8j8I2/LLCQleRYKanOWh2SiaJcHFMDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v53Hp5kQsT6cehv91kfyAWZQSdJDc+IAxfhgxzOi7ZjNeOu+pZMV1GVf+KXVtYgIx
	 pxynjKYEBWZnVeG1JMvO8MqmEb/WdZt5dETBxXQH/60/08le0VrpL2KBqUixy9gIWg
	 LQ2iC9tHkXvVj64xR2LToI7ExHmTJO3KWm9QzyZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgCSAL0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbgCSALJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0D78212CC;
        Thu, 19 Mar 2020 00:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576669;
        bh=6byI644vY95Z8j8I2/LLCQleRYKanOWh2SiaJcHFMDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqYzOI7XWp7ElP4SCoGBWyaJ7GMGNnVnPv9pzQuaCArzV9YlGSmPR+6NYTuHV+YVJ
         /KhxWAEYRIFVt0LUpqyRGv6qkdEV2V8Apzo8rbQF98K6vG8vAwPhZ78pbVz1CUdZbR
         5axC4dU5+FEy0wMazV8MCspgam789p5YwoYQWJis=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 21/22] rcu-tasks: Add a grace-period start time for throttling and debug
Date:   Wed, 18 Mar 2020 17:10:59 -0700
Message-Id: <20200319001100.24917-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a place to record the grace-period start in jiffies.
This will be used by later commits for debugging purposes and to throttle
IPIs early in the grace period.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ca5fbde..6d237c4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -46,6 +46,7 @@ struct rcu_tasks {
 	raw_spinlock_t cbs_lock;
 	int gp_state;
 	unsigned long gp_jiffies;
+	unsigned long gp_start;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -200,6 +201,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		// Wait for one grace period.
 		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
+		rtp->gp_start = jiffies;
 		rtp->gp_func(rtp);
 
 		/* Invoke the callbacks. */
-- 
2.9.5

