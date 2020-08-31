Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D2C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED212068E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897505;
	bh=NcJJDjKPbJHUqCWQSv0m7YSMWH5nrU0mAQI5DfMA5YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n+ZCM/Em76K5DcyR83aZH/PjU719y8ZrkaD9ZcSAh0VyK+UU2vgZeq9MYoSceFRp0
	 ClIMcw3Xmsx8a1FUZOvKLTbQQRulhYuyokGXz0Pmcl/qMlA5iVNnUMEVoasopppII8
	 Bjf/gFpxqPgWF3Inm44DpQmieahB+rE41ek3B4AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgHaSLa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgHaSL0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D05A214D8;
        Mon, 31 Aug 2020 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897483;
        bh=NcJJDjKPbJHUqCWQSv0m7YSMWH5nrU0mAQI5DfMA5YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzm+EwNk1Eg6HPojLgueCwlma5KIffWsm2goG97DboPk81YZLY3C+6Pq2tIlyx6DF
         SsVfZexMjfhgBRFBfdtnqD4A93KZSQMiCNLSYWJhrHtcVu9PgMou6sp5eFrhPjwgeU
         FU7u+96iHf9HZ9zx0FGEIMzWs3UMckRd4+HM3txU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/13] rcu: IPI all CPUs at GP start for strict GPs
Date:   Mon, 31 Aug 2020 11:11:15 -0700
Message-Id: <20200831181120.1044-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, each CPU discovers the beginning of a given grace period
on its own time, which is again good for efficiency but bad for fast
grace periods.  This commit therefore uses on_each_cpu() to IPI each
CPU after grace-period initialization in order to inform each CPU of
the new grace period in a timely manner, but only in kernels build with
CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 36a860c..88f4fa6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1696,6 +1696,15 @@ static void rcu_gp_torture_wait(void)
 }
 
 /*
+ * Handler for on_each_cpu() to invoke the target CPU's RCU core
+ * processing.
+ */
+static void rcu_strict_gp_boundary(void *unused)
+{
+	invoke_rcu_core();
+}
+
+/*
  * Initialize a new grace period.  Return false if no grace period required.
  */
 static bool rcu_gp_init(void)
@@ -1823,6 +1832,10 @@ static bool rcu_gp_init(void)
 		WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	}
 
+	// If strict, make all CPUs aware of new grace period.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
+
 	return true;
 }
 
-- 
2.9.5

