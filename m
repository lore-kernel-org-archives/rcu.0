Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5249C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D9021744
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970666;
	bh=MQRM0/HQlmKRuLIFZx65g5hgTfSSjkIn3Ao0U3fJ+No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zLqR/5VCgrIJCvfrNRPgc4QxiG2kS8bPmZsQNgNvU/uq4+oF3nSNRuaL3nBxzc334
	 mDtWiGRlTLzmjs1E7/dZu+NhpEU/nR9b/nYloNL6mXNHlzPUHIYaHSAuHcvmtjHZ/Y
	 NWx1/Th1JsaGZSOqSpgAAvNkMKbc3NGWIQ9f+lpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410730AbgDORLD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410712AbgDORK6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86DFD21D79;
        Wed, 15 Apr 2020 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970657;
        bh=MQRM0/HQlmKRuLIFZx65g5hgTfSSjkIn3Ao0U3fJ+No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGUfAq/Bs6j0+b4rV3X1S21BYmFJqy5D6Vb/IvPQ7nvgOLbgQAVwmqyfczA4WmG0u
         ZFYXFINGf5tJxM6QLCpiF1rAOGTFNXW0sDnhQ23BjytfMclO6nSoMyUAxXjaX3WdgZ
         s497GbStHEWDQ/z9fOIC9rWXyv+bTASRit/MBlr4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/19] rcu: Add READ_ONCE and data_race() to rcu_node ->boost_tasks
Date:   Wed, 15 Apr 2020 10:10:40 -0700
Message-Id: <20200415171054.9013-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->boost_tasks field is read locklessly, so this
commit adds the READ_ONCE() to one load in order to avoid destructive
compiler optimizations.  The other load is from a diagnostic print,
so data_race() suffices.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 35d77db..ed6bb46 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -760,7 +760,7 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 		pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx\n",
 			__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext);
 	pr_info("%s: ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p\n",
-		__func__, READ_ONCE(rnp->gp_tasks), rnp->boost_tasks,
+		__func__, READ_ONCE(rnp->gp_tasks), data_race(rnp->boost_tasks),
 		READ_ONCE(rnp->exp_tasks));
 	pr_info("%s: ->blkd_tasks", __func__);
 	i = 0;
@@ -1036,7 +1036,8 @@ static int rcu_boost_kthread(void *arg)
 	for (;;) {
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
 		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
-		rcu_wait(rnp->boost_tasks || READ_ONCE(rnp->exp_tasks));
+		rcu_wait(READ_ONCE(rnp->boost_tasks) ||
+			 READ_ONCE(rnp->exp_tasks));
 		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
-- 
2.9.5

