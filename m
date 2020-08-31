Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FDC433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE321789
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896895;
	bh=OV4rdtDJfndd8yIlNe+o4Ki+VpzlQTxASJjsVeMAmWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOVjkUqL2QbObCd7OXEmGFm0hmH2ffDDXhKMyAt3wCLi3bGnNu7AJccZ3XidR6dsk
	 yo/4vs6cO2p8Q6OWV3adoIkPzpa+4coLoEvdYaUHvdNIjdE3XmeQyJU8rkGsa9qJe2
	 JufRhxgKH8aSdyhBHEQuLiLZttxMd6JV6QE0lVN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgHaSBd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgHaSB0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7780C21707;
        Mon, 31 Aug 2020 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896886;
        bh=OV4rdtDJfndd8yIlNe+o4Ki+VpzlQTxASJjsVeMAmWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBMhrXPqNrjbNozJLgrbF0I9Daiv9qPQCga4nI/foekBthdIzdIyliuhJM4c6nC74
         k4EH+rrft/w1BsIlACxqq+Z2YsE4kZksM2aG40aLsYBh569NyPSLqL2KEkW7N7n1rb
         bssE3AD2+5BPYW3P6rHkT2kjtbM2xUAmOUqzJDUU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/24] rcu/nocb: Add a warning for non-GP kthread running GP code
Date:   Mon, 31 Aug 2020 11:01:11 -0700
Message-Id: <20200831180116.32690-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit increases RCU's ability to defend itself by emitting a warning
if one of the nocb CB kthreads invokes the GP kthread's wait function.
This warning augments a similar check that is carried out at the end
of rcutorture testing and when RCU CPU stall warnings are emitted.
The problem with those checks is that the miscreants have long since
departed and disposed of any and all evidence.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4d63ee3..cb1e8c8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1926,6 +1926,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * nearest grace period (if any) to wait for next.  The CB kthreads
 	 * and the global grace-period kthread are awakened if needed.
 	 */
+	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.9.5

