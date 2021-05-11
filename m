Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84910C43470
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A90A616E8
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhEKXI5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhEKXIz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:08:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8523061939;
        Tue, 11 May 2021 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774468;
        bh=dCeesBPD8EQLQ5NTaAbs0FYY7oV3gGlAfJXafP/iE/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L25Lg3jh7hOSF0jNM51XuL216lJeC+lmJRNEk3BqlafqUqiCC7Plkg4sW2e1MIi90
         sZWonatKKiEh3ejh6W/UAWMjFD2rMAzDmzOJtUzh3TF/FFF8lXyS1HSHWEVlKahUXu
         oLhFPtjsIZHar8krNVHNIxwh7H/qMro0AtEZ1PyrDDuWRDZz8er1nPHLP21Lqvvzxy
         5AeipXmjr81N8QQUNvZFd8bnyl7Vuks5jW8O5KP0hTIQ3DJBbvaim1+ihzls3H9caf
         OOqjPa+ykooEqbF1XujQQarzJnNqkEEMUS6AmVEmEPVKMAig8u/DtGogdcWE+qqpwq
         9IYvrY7C9fO0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E58995C0DB3; Tue, 11 May 2021 16:07:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/6] srcu: Early test SRCU polling start
Date:   Tue, 11 May 2021 16:07:45 -0700
Message-Id: <20210511230745.2894650-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Place an early call to start_poll_synchronize_srcu() before the the
invocation of call_srcu() on the same srcu_struct structure.

After the later call to srcu_barrier(), the completion of the
first grace period should be visible to a subsequent invocation of
poll_state_synchronize_srcu(), and if not, warn.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b95ae86c40a7..0aa118ac37ba 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -524,6 +524,7 @@ static void test_callback(struct rcu_head *r)
 }
 
 DEFINE_STATIC_SRCU(early_srcu);
+static unsigned long early_srcu_cookie;
 
 struct early_boot_kfree_rcu {
 	struct rcu_head rh;
@@ -536,8 +537,10 @@ static void early_boot_test_call_rcu(void)
 	struct early_boot_kfree_rcu *rhp;
 
 	call_rcu(&head, test_callback);
-	if (IS_ENABLED(CONFIG_SRCU))
+	if (IS_ENABLED(CONFIG_SRCU)) {
+		early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
 		call_srcu(&early_srcu, &shead, test_callback);
+	}
 	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 	if (!WARN_ON_ONCE(!rhp))
 		kfree_rcu(rhp, rh);
@@ -563,6 +566,7 @@ static int rcu_verify_early_boot_tests(void)
 		if (IS_ENABLED(CONFIG_SRCU)) {
 			early_boot_test_counter++;
 			srcu_barrier(&early_srcu);
+			WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
 		}
 	}
 	if (rcu_self_test_counter != early_boot_test_counter) {
-- 
2.31.1.189.g2e36527f23

