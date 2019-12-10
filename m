Return-Path: <SRS0=BMES=2A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7548C43603
	for <rcu@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8225F2071E
	for <rcu@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950892;
	bh=lwnUtQxHILM1DOKS0NZn4YW5OHWHwryStmJW7TMHfGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZMrAFm30sxCl5C6Xn+dB4HPNlk2jwbIIfnmrRnR6oTDXcRV4hSCz7D4AMB6PnvzuI
	 38z6VHas9r0568oHzmSVtST0pgIpEam3r/7xGlxa5liUkDwMB/h+nYlZsu3Ci72SiH
	 P3C8suxdjfm4MDPQLGGGuzIEa9wj/OVARPQtkbqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLJEIM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfLJEHt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:49 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1D9208C3;
        Tue, 10 Dec 2019 04:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950868;
        bh=lwnUtQxHILM1DOKS0NZn4YW5OHWHwryStmJW7TMHfGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueKTyIy9CiNF9/rZ2JaY8RP2g+EDkyoGJCNzY++M3diMkZ6OTEmn2kzDnXEEp3w97
         oVR2aH2ISQiJuaUN7P1TOVMsJdMk9k71X8thqiQDtfZeWIJcIzSc2d1d/34W9fliFW
         qsWYO4Uuj7+iUFeDVl5f3rSFaYZ4odZncbHK08mI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/12] rcu: Switch force_qs_rnp() to for_each_leaf_node_cpu_mask()
Date:   Mon,  9 Dec 2019 20:07:37 -0800
Message-Id: <20191210040741.2943-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, force_qs_rnp() uses a for_each_leaf_node_possible_cpu()
loop containing a check of the current CPU's bit in ->qsmask.
This works, but this commit saves three lines by instead using
for_each_leaf_node_cpu_mask(), which combines the functionality of
for_each_leaf_node_possible_cpu() and leaf_node_cpu_bit().  This commit
also replaces the use of the local variable "bit" with rdp->grpmask.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bbb60ed..d950764 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2298,14 +2298,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			continue;
 		}
-		for_each_leaf_node_possible_cpu(rnp, cpu) {
-			unsigned long bit = leaf_node_cpu_bit(rnp, cpu);
-			if ((rnp->qsmask & bit) != 0) {
-				rdp = per_cpu_ptr(&rcu_data, cpu);
-				if (f(rdp)) {
-					mask |= bit;
-					rcu_disable_urgency_upon_qs(rdp);
-				}
+		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
+			rdp = per_cpu_ptr(&rcu_data, cpu);
+			if (f(rdp)) {
+				mask |= rdp->grpmask;
+				rcu_disable_urgency_upon_qs(rdp);
 			}
 		}
 		if (mask != 0) {
-- 
2.9.5

