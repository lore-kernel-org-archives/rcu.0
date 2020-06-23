Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8FAC433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB5220702
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871792;
	bh=5KDY+n04rpxhpLhPUfPZ/lQBunRbEeYpva1R7qPZAPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=riRlDNCygCe+1Yj783JpU6CtOqvK8VGSghCidi6bF3ptplM/h9L1BUVGyjzoYSLTS
	 uM01YO+HrnAy+z2D0KrTpz3gBjEG6gqqwenu7/zcyCCFKsOUyH3BEwBroyd3LgS/jk
	 ae1sUYDctH1bpxbSD10R55UYvsipwO0n7TVKz3BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbgFWAXL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731481AbgFWAVv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAD822083E;
        Tue, 23 Jun 2020 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871711;
        bh=5KDY+n04rpxhpLhPUfPZ/lQBunRbEeYpva1R7qPZAPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxuvlQW1X6hxWBXqO0vDM8pWXObyCmc1iCkO4AfDguyLSVralzTZ9+LXYqjq8R+7r
         P24GjBLthFsaq8C+vGFfAP+6dlAWe2bNFZtANGVn5vErAHowvm2wnHZpoBr6Z0XlZV
         elWGrUobrIdPk+3kaPY1sXXeT7WdCkdfbiTFHTPE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/26] rcu: Priority-boost-related sleeps to idle priority
Date:   Mon, 22 Jun 2020 17:21:29 -0700
Message-Id: <20200623002147.25750-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the long-standing schedule_timeout_interruptible()
call used by RCU's priority-boosting kthreads to schedule_timeout_idle().
This conversion avoids polluting the load-average with RCU-related
sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3522236..25296c1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1033,7 +1033,7 @@ static int rcu_boost_kthread(void *arg)
 		if (spincnt > 10) {
 			WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_YIELDING);
 			trace_rcu_utilization(TPS("End boost kthread@rcu_yield"));
-			schedule_timeout_interruptible(2);
+			schedule_timeout_idle(2);
 			trace_rcu_utilization(TPS("Start boost kthread@rcu_yield"));
 			spincnt = 0;
 		}
-- 
2.9.5

