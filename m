Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E43C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD3A2072D
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724601;
	bh=a+d+yGszZsRkYNysaO47CtnEwZ3j2on+f+XowZQtC7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yP6BtlHjCo88+sjKWQdeL1jmnCmVUADzvr1BnISOtDdZyj9XNI/HJY9nI2dgvNx8E
	 lXRd9f0BAFFpDX8IhI6BVeUnsf+2609yPjZGbmQfKRuMkX37/3B/qE9pWniYkJ/K1f
	 D5tLafRxBQV97UZYIg56csH5WuwH2iXQjqtFmsnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBNX4k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgBNX4k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:40 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50B63206B6;
        Fri, 14 Feb 2020 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724599;
        bh=a+d+yGszZsRkYNysaO47CtnEwZ3j2on+f+XowZQtC7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQqawMAAwEqaaXlRoqPYLxsAUbOIJKFVWL/L93ytctxYttL2YhwHCzPJbU2hg9JDS
         GMmNMXbYOyp3ga6yS9AgIatkJJimfqq9TqzuN02p63g7liLiAU5uOhf+8DpSYhJpkl
         QS1zhNHp9hqqHVjoBEXdanxFPKzZ+yBmPQHUlvjA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/30] rcu: Add WRITE_ONCE() to rcu_state ->gp_req_activity
Date:   Fri, 14 Feb 2020 15:55:45 -0800
Message-Id: <20200214235607.13749-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_state structure's ->gp_req_activity field is read locklessly,
so this commit adds the WRITE_ONCE() to an update in order to provide
proper documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 236692d..9443909 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1200,7 +1200,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	}
 	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
-	rcu_state.gp_req_activity = jiffies;
+	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
 	if (!rcu_state.gp_kthread) {
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
@@ -1775,7 +1775,7 @@ static void rcu_gp_cleanup(void)
 		    rcu_segcblist_is_offloaded(&rdp->cblist);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
-		rcu_state.gp_req_activity = jiffies;
+		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
 		trace_rcu_grace_period(rcu_state.name,
 				       READ_ONCE(rcu_state.gp_seq),
 				       TPS("newreq"));
-- 
2.9.5

