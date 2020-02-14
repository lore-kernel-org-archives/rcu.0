Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B4CC3B1BF
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407062187F
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724623;
	bh=kgbOOD/LyyezKap7GowhfcJfIGGyH0kHTlo/T6LzXEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KIvLvRmkh8l71QdWFRzIZ2wIDaMPZHX/jV7IYkhSdGgvwMxDWI2qp7GOUMcEij6Wr
	 Cg6U8fjSy6WTEhIHvd2NfIArbEzv/nkiMrqJPwWDfZ3pGDp0dEqMH9JUUvlSdr8IPh
	 /JqFW6uQWcx0yRRh2BqS3CLDVRhl6Cnuqrxzuw+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgBNX5C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNX5C (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:02 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93CD22468C;
        Fri, 14 Feb 2020 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724621;
        bh=kgbOOD/LyyezKap7GowhfcJfIGGyH0kHTlo/T6LzXEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKgZvMn3/JjuIDIEWAuzQoURmDcjTpaGy6/nr3kU6t/w2MmfkA0FqXISruuoFzy/U
         7kP/QWtg5gefmNhZznCrMhg+pd1fou+qdfZYtGyIjYVupDxJ/K5aV50AlcV86XNShw
         qPCsMb9DJgNfVbrEaYN+D4TzWqctz1ankDrDDzKk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/30] rcu: Add READ_ONCE() to rcu_data ->gpwrap
Date:   Fri, 14 Feb 2020 15:55:51 -0800
Message-Id: <20200214235607.13749-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_data structure's ->gpwrap field is read locklessly, and so
this commit adds the required READ_ONCE() to a pair of laods in order
to avoid destructive compiler optimizations.

This data race was reported by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 2 +-
 kernel/rcu/tree_stall.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a70f56b..e851a12 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1322,7 +1322,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 
 	rcu_lockdep_assert_cblist_protected(rdp);
 	c = rcu_seq_snap(&rcu_state.gp_seq);
-	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
+	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		/* Old request still live, so mark recent callbacks. */
 		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
 		return;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 3dcbecf..3275f27 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -602,7 +602,7 @@ void show_rcu_gp_kthreads(void)
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			rdp = per_cpu_ptr(&rcu_data, cpu);
-			if (rdp->gpwrap ||
+			if (READ_ONCE(rdp->gpwrap) ||
 			    ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
 					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
-- 
2.9.5

