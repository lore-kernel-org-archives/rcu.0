Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244ABC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C436F20756
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620100;
	bh=//0hu7psAdChxmAFAEX5NFskbZhQL++78avbVvmvMOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mI8lRMGe6kBh0iS2R337B6fyeoGiOPA81e4SNAgp3zM41OlcevJxO0F1ZaxeYPlZB
	 ykIT8ZNGP2Io8kTynw84+SSg/lfAJSu73pd7W1wWgLCk3iLohkyN6B+a6KD8xAYErp
	 C8KxRVaITV0bp/SRsjRWIrmBCC8kK7/d44FxbPew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbgKEXrb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732782AbgKEXrb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:31 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F00D2224B;
        Thu,  5 Nov 2020 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620050;
        bh=//0hu7psAdChxmAFAEX5NFskbZhQL++78avbVvmvMOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWPMdsHb4C7P4Jk94QfcYUufm6JJ+jApTwVzC9GExG4wAIbQkQ5q5nIYPCGHnccoM
         oA3qdJlx4GDbetSd287fk7UI9xydVZ0QhDLOhqy4MwH5D7qhz9Ae9qcpE6RGkU94dS
         shugwwPXtJ5amEYX+EnyfqK4Yfi+uZ/54MCB0ZfI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 24/28] rcutorture: Don't do need_resched() testing if ->sync is NULL
Date:   Thu,  5 Nov 2020 15:47:15 -0800
Message-Id: <20201105234719.23307-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If cur_ops->sync is NULL, rcu_torture_fwd_prog_nr() will nevertheless
attempt to call through it.  This commit therefore flags cases where
neither need_resched() nor call_rcu() forward-progress testing
can be performed due to NULL function pointers, and also causes
rcu_torture_fwd_prog_nr() to take an early exit if cur_ops->sync()
is NULL.

Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e7d52fd..f4c0655 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1923,7 +1923,9 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	unsigned long stopat;
 	static DEFINE_TORTURE_RANDOM(trs);
 
-	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
+	if (!cur_ops->sync) 
+		return; // Cannot do need_resched() forward progress testing without ->sync.
+	if (cur_ops->call && cur_ops->cb_barrier) {
 		init_rcu_head_on_stack(&fcs.rh);
 		selfpropcb = true;
 	}
@@ -2149,8 +2151,8 @@ static int __init rcu_torture_fwd_prog_init(void)
 
 	if (!fwd_progress)
 		return 0; /* Not requested, so don't do it. */
-	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0 ||
-	    cur_ops == &rcu_busted_ops) {
+	if ((!cur_ops->sync && !cur_ops->call) ||
+	    !cur_ops->stall_dur || cur_ops->stall_dur() <= 0 || cur_ops == &rcu_busted_ops) {
 		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
 		return 0;
 	}
-- 
2.9.5

