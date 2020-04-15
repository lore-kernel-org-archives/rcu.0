Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D292C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6121707
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970668;
	bh=SyzD83B0mOK8LK3sIjriYCc7SfUO2UZRZFCObjgRwhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xmlO2Pvn7axIXUc9vjl68xK/xU7jMmbFadkeHyTT7Q/Zk3WxtnYWhWVVLCS+Okp+T
	 flvXTdlOdM/Q8fwQqEoMYzKhEUdO7d8gUzFkdxHUfyELKco5w9bzslDtUo3aWbKSXi
	 KC9OK+CzrgRX1gnx/rHYhWR57Mx/TjDHBwlVpfJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410744AbgDORLG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410727AbgDORLC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01ABA221EC;
        Wed, 15 Apr 2020 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970662;
        bh=SyzD83B0mOK8LK3sIjriYCc7SfUO2UZRZFCObjgRwhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVtQ+x3+BN5ejTPVSBhFGZghA9FL7pWprKe3gkHT9p3va4eT0fgeRA8wgMIFwdp6d
         lBE1ohy3Hdq0dF+ElBwII7WSMg798jUR76T8PA6vcfOSytvgSVNw8GG5YfNKWLjc+w
         J8HPEi40eLjk2ZwULyh6zI8ggejZ/+sXuop9wvY0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/19] rcu: Convert rcu_initiate_boost() ULONG_CMP_GE() to time_after()
Date:   Wed, 15 Apr 2020 10:10:53 -0700
Message-Id: <20200415171054.9013-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the ULONG_CMP_GE() in rcu_initiate_boost() to
time_after() to reflect the fact that it is comparing a timestamp to
the jiffies counter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 664d0aa..5cd27c2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1080,7 +1080,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	    (rnp->gp_tasks != NULL &&
 	     rnp->boost_tasks == NULL &&
 	     rnp->qsmask == 0 &&
-	     (ULONG_CMP_GE(jiffies, rnp->boost_time) || rcu_state.cbovld))) {
+	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
 		if (rnp->exp_tasks == NULL)
 			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-- 
2.9.5

