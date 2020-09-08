Return-Path: <SRS0=z7K1=CR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C42C433E2
	for <rcu@archiver.kernel.org>; Tue,  8 Sep 2020 17:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456FD20936
	for <rcu@archiver.kernel.org>; Tue,  8 Sep 2020 17:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgIHRQZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:16:25 -0400
Received: from 107-174-27-60-host.colocrossing.com ([107.174.27.60]:48248 "EHLO
        ozlabs.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731638AbgIHQSb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:31 -0400
X-Greylist: delayed 2642 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2020 12:18:30 EDT
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 03ED9AE80120;
        Tue,  8 Sep 2020 10:42:51 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     rcu@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH kernel] srcu: Fix static initialization
Date:   Wed,  9 Sep 2020 00:43:06 +1000
Message-Id: <20200908144306.33355-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

init_srcu_struct_nodes() is called with is_static==true only internally
and when this happens, the srcu->sda is not initialized in
init_srcu_struct_fields() and we crash on dereferencing @sdp.

This fixes the crash by moving "if (is_static)" out of the loop which
only does useful work for is_static=false case anyway.

Found by syzkaller.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 kernel/rcu/srcutree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c100acf332ed..49b54a50bde8 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -135,6 +135,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
 				   levelspread[level - 1];
 	}
 
+	if (is_static)
+		return;
+
 	/*
 	 * Initialize the per-CPU srcu_data array, which feeds into the
 	 * leaves of the srcu_node tree.
@@ -161,8 +164,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
 		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
 		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
-		if (is_static)
-			continue;
 
 		/* Dynamically allocated, better be no srcu_read_locks()! */
 		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
-- 
2.17.1

