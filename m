Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F87C388F7
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C93B2224B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xZq7rqZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKMMOW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgKMMOS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:18 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CE822254;
        Fri, 13 Nov 2020 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269657;
        bh=Z5X/BUa3lYsZAdJKBe7eO//9iGVXC/NYbUOc3HBV9+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xZq7rqZ3Ecwuwt4DW5cy3zDsGVYnHBdfuJSufck6AFxwzJbkvaYEwArAk7YN7Ia7O
         YkiRCQrr/L9XO8ygJJ7B9qL/3ESvUiKA31jg1VWrESBEXELx/Qait3SKwbO9XRu13J
         yGMuUoMaMPK8OC5q8BkZ83zT1A8LGz2xaRX+cqx4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 11/19] rcu/nocb: Only cond_resched() from actual offloaded batch processing
Date:   Fri, 13 Nov 2020 13:13:26 +0100
Message-Id: <20201113121334.166723-12-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_do_batch() will be callable concurrently by softirqs and offloaded
processing. So make sure we actually call cond resched only from the
offloaded context.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 049433d0fa05..da1ecf60c541 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2510,8 +2510,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			/* Exceeded the time limit, so leave. */
 			break;
 		}
-		if (offloaded) {
-			WARN_ON_ONCE(in_serving_softirq());
+		if (!in_serving_softirq()) {
 			local_bh_enable();
 			lockdep_assert_irqs_enabled();
 			cond_resched_tasks_rcu_qs();
-- 
2.25.1

