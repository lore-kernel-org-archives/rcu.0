Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720AFC43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3855D23137
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhAFQ4d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbhAFQ4d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7605D23137;
        Wed,  6 Jan 2021 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952133;
        bh=tG4Z2uO2Haz2h0kg2BZL/xOya/XrbXKkyUe83b3IrE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tej6Pl0sfO2WkwXJhR2rUSNpUq4aHCYcVQoMIr5hD7UslSUSKu67XX+WOCRSP7Mux
         SAuv+LOB3w8lrWONTtFZKWfNP4vPqBfdrkG8vUPbNVSYCxUVTzbTvdSJLyBY5CpgJL
         +wVkjNjmlZuR7taZiP/Xs7ldRRFoUusFjwIsRVOK4yx4PpgNYnpYTRSQm4mEwVcdNj
         4gX6/pNYVh3L/nxPmMGWnB/tkh9niCdb6/4cSxD6RmxqtMrslmd+u9YsBl1JaOkdTZ
         g2rXCXGUk0++95AbHZkQNn7mDj4tn3eNBUADp3WihRzat0qTJNesyOCKiZVw3ijeNT
         HfbrrpeBVMlqA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/10] srcu: Document polling interfaces for Tree SRCU grace periods
Date:   Wed,  6 Jan 2021 08:55:27 -0800
Message-Id: <20210106165531.20697-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds requirements documentation for the
get_state_synchronize_srcu(), start_poll_synchronize_srcu(), and
poll_state_synchronize_srcu() functions.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index e8c84fc..93a189a 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2600,6 +2600,24 @@ also includes ``DEFINE_SRCU()``, ``DEFINE_STATIC_SRCU()``, and
 ``init_srcu_struct()`` APIs for defining and initializing
 ``srcu_struct`` structures.
 
+More recently, the SRCU API has added polling interfaces:
+
+#. start_poll_synchronize_srcu() returns a cookie identifying
+   the completion of a future SRCU grace period and ensures
+   that this grace period will be started.
+#. poll_state_synchronize_srcu() returns ``true`` iff the
+   specified cookie corresponds to an already-completed
+   SRCU grace period.
+#. get_state_synchronize_srcu() returns a cookie just like
+   start_poll_synchronize_srcu() does, but differs in that
+   it does nothing to ensure that any future SRCU grace period
+   will be started.
+
+These functions are used to avoid unnecessary SRCU grace periods in
+certain types of buffer-cache algorithms having multi-stage age-out
+mechanisms.  The idea is that by the time the block has aged completely
+from the cache, an SRCU grace period will be very likely to have elapsed.
+
 Tasks RCU
 ~~~~~~~~~
 
-- 
2.9.5

