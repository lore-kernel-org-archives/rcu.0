Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D211C433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4E420720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871903;
	bh=BYXm29KJj9Z265W9P4EdU/JUSgSluBZZAEaSUoJJsQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SZAU889eL0REXiIeGuByyoZiCt/7Sw85I8zMUneDwHPOKmX3liAz/Syyx9Occ+gBr
	 Y1SrgVUA5JddlaZCnFHDUEiuKRYWujbJJXzs3aZG4YQr4Mb6PpBcr/ukG+A1kzIE5t
	 ifcKaQAEBEA9l8MVthb7j9fP1oAucYgOKIkObYHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgFWAYq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbgFWAYp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D1820702;
        Tue, 23 Jun 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871885;
        bh=BYXm29KJj9Z265W9P4EdU/JUSgSluBZZAEaSUoJJsQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7CKfT95tW8KyfFsxg+PGDlY0uHG/O2nqJn/dL8dJtxSHrRqIxikMbNu1WYuHEkhO
         uVA3Ma/1zlyGV992up/UImsvQAUhdBrlW53ik5d9lwV8u2PDfpTwMWBxr0G9kpUjo4
         cR/KsBj4EQqWGm/pOk4O0eTZeKQc0L0pJCab4RI0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/5] rcu-tasks: Convert sleeps to idle priority
Date:   Mon, 22 Jun 2020 17:24:39 -0700
Message-Id: <20200623002443.25954-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002423.GA25869@paulmck-ThinkPad-P72>
References: <20200623002423.GA25869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the long-standing schedule_timeout_interruptible()
and schedule_timeout_uninterruptible() calls used by the various Tasks
RCU's grace-period kthreads to schedule_timeout_idle().  This conversion
avoids polluting the load-average with Tasks-RCU-related sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ce23f6c..91fee81 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -205,7 +205,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			if (!rtp->cbs_head) {
 				WARN_ON(signal_pending(current));
 				set_tasks_gp_state(rtp, RTGS_WAIT_WAIT_CBS);
-				schedule_timeout_interruptible(HZ/10);
+				schedule_timeout_idle(HZ/10);
 			}
 			continue;
 		}
@@ -227,7 +227,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			cond_resched();
 		}
 		/* Paranoid sleep to keep this from entering a tight loop */
-		schedule_timeout_uninterruptible(HZ/10);
+		schedule_timeout_idle(HZ/10);
 
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 	}
@@ -336,7 +336,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 		/* Slowly back off waiting for holdouts */
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		schedule_timeout_interruptible(HZ/fract);
+		schedule_timeout_idle(HZ/fract);
 
 		if (fract > 1)
 			fract--;
-- 
2.9.5

