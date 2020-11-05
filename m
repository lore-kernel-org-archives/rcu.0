Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58665C4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053602083B
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617789;
	bh=4S+YMqJ17YkGCRrdvZh7Y1JGVEUCXN5SyXNOwkeNcAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bf4kkTncpGXNicZubkRr9ERQXBtZRqYwbm61FIEtK3xNgofHjbIIwTz+gDVCT5kAb
	 emcybHi2MA/pufuscSuyYHlygmJlZ7zrjC/7N2iSQ7To4gIRbKt9/4warH3Qe+RJhC
	 0HnST7Gq8Fz8SigRccUnKxJqnLMjsjLG0qYhVGmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbgKEXJa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732675AbgKEXJ3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:29 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C8820786;
        Thu,  5 Nov 2020 23:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617769;
        bh=4S+YMqJ17YkGCRrdvZh7Y1JGVEUCXN5SyXNOwkeNcAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMyD90U3SKz6VGW+9J9A4yqlnj6Bdwevv7c/zrc8VGxH6VUF4towzgNPP29IZ19Cw
         nhh+3Ry8u1HZs1RNExnMvSjdMVfTlemkxLvVcgpZ58ZyXZty51at1HTX0i9RJ+kMbr
         mL/FaA3fx8to+gaOnX1Jvp0fJkS5z6BIbX7rJVVY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/16] rcu: Fix a typo in rcu_blocking_is_gp() header comment
Date:   Thu,  5 Nov 2020 15:09:18 -0800
Message-Id: <20201105230921.19017-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

This commit fixes a typo in the rcu_blocking_is_gp() function's header
comment.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e790b85..e825b3b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3572,7 +3572,7 @@ void __init kfree_rcu_scheduler_running(void)
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.  Later on, this is never the case for PREEMPTION.
  *
- * Howevr, because a context switch is a grace period for !PREEMPTION, any
+ * However, because a context switch is a grace period for !PREEMPTION, any
  * blocking grace-period wait automatically implies a grace period if
  * there is only one CPU online at any point time during execution of
  * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
-- 
2.9.5

