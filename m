Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BCDC46CA1
	for <rcu@archiver.kernel.org>; Tue, 17 Oct 2023 12:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjJQMTk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Oct 2023 08:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjJQMTa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Oct 2023 08:19:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A0E3865;
        Tue, 17 Oct 2023 05:19:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958DBC433C7;
        Tue, 17 Oct 2023 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697545155;
        bh=nGQYsoxqCkQ0YYtiYb1sIwFgNYda2Lk6AkqvILuiiAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5axE8Pul/yenI/J6sA0VNYiyRKQqzkRIlEytcBQPSg9NMWVX/2V6EPzoq+BZIUZF
         S3DBwH1b8DuDz6u2UBExSIBDhPKHRGuePjcUUFzPG6w+Tm2tB3Tx3sZIAFTmdWgi/R
         A84riQ1fDmzKpKYSbrVAEze2MyTjqIn5FITBqU3wzfHBngBcUcZ7VEzl7wf1wNvsae
         hgK5A5ay1/kb0ysqyrKn0YFghJJ2rVHXhRL8yJyzWQX8U9Woz4ElUa9Pt7yZiiztG/
         Wa2qvjJaex8ghV4cCLYH+zQhawt6ZRAsWXGLhIbNlAJIJWhRGopGqLlpo2+HM8K+pr
         SB2YZni0fCPxA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/3] rcu-tasks: Add printk()s to localize boot-time self-test hang
Date:   Tue, 17 Oct 2023 14:19:03 +0200
Message-Id: <20231017121905.1156166-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017121905.1156166-1-frederic@kernel.org>
References: <20231017121905.1156166-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, rcu_tasks_initiate_self_tests() prints a message and then
initiates self tests on up to three different RCU Tasks flavors.  If one
of the flavors has a grace-period hang, it is not easy to work out which
of the three hung.  This commit therefore prints a message prior to each
individual test.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8d65f7d576a3..83049a893de5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1979,20 +1979,22 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 
 static void rcu_tasks_initiate_self_tests(void)
 {
-	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
+	pr_info("Running RCU Tasks wait API self tests\n");
 	tests[0].runstart = jiffies;
 	synchronize_rcu_tasks();
 	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_RUDE_RCU
+	pr_info("Running RCU Tasks Rude wait API self tests\n");
 	tests[1].runstart = jiffies;
 	synchronize_rcu_tasks_rude();
 	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_TRACE_RCU
+	pr_info("Running RCU Tasks Trace wait API self tests\n");
 	tests[2].runstart = jiffies;
 	synchronize_rcu_tasks_trace();
 	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
-- 
2.34.1

