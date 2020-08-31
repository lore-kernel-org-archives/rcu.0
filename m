Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1D9C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D552083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897024;
	bh=xBYCcO3EI/laB8yUb8DrmnchvpxpQDbnTIfeq3TmuJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LuZGuJ1JWH4j0jonCUB/u9A4JT46VEYS+BaIwr5XAqMZCH8Hy+YKrcp3HvJYaVS6R
	 RZtvG4AnRDKTeQDKDzNMHq/euTKcFlCl0Twr++66nZ+w5L0aHDx6bK9wzXtwjPDMu4
	 UOeQxcM3rvFnmps/TF4jUlekcqGQu+gu8QqXXYpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgHaSBW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgHaSBV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:21 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404962151B;
        Mon, 31 Aug 2020 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896880;
        bh=xBYCcO3EI/laB8yUb8DrmnchvpxpQDbnTIfeq3TmuJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbRpxAFSHMmTbcUVpW3heSbRuOV2soYx1J2ztcylzJmppEWwwuTiiHBmHlkNCkRaU
         D4KCDpAYPiLA3IcOprbrWt4zqAcE5PJYi+m9GngLzqg0inzhqb+YVeTtZD8V8l+B9n
         1woZvfV88yNvq3E5nYN6dzuEjYkSANvzYb7hepWc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/24] rcu: Initialize at declaration time in rcu_exp_handler()
Date:   Mon, 31 Aug 2020 11:00:56 -0700
Message-Id: <20200831180116.32690-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit moves the initialization of the CONFIG_PREEMPT=n version of
the rcu_exp_handler() function's rdp and rnp local variables into their
respective declarations to save a couple lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1888c0e..8760b6e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -732,11 +732,9 @@ static void rcu_exp_need_qs(void)
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
 static void rcu_exp_handler(void *unused)
 {
-	struct rcu_data *rdp;
-	struct rcu_node *rnp;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_node *rnp = rdp->mynode;
 
-	rdp = this_cpu_ptr(&rcu_data);
-	rnp = rdp->mynode;
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
-- 
2.9.5

