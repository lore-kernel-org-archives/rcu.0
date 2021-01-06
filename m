Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E24C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC43423135
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbhAFQ4q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbhAFQ4q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F6A023329;
        Wed,  6 Jan 2021 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952133;
        bh=LhiptoWrtIWdrHDEXso8k8aBWMuY2+9LUJZkIKvBGhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tykWPLZ41kFmfeg0RBpcacgpl4KFwzRV3KhGiybJiDi/JIVjOVA+dHsgPGt0xGTBc
         /eSdqfAYPVxeSK2Veh8PhcJP4gHt15JyRO00kRxWoHcbMV9VbeVPKmbSZmZ6e9zQqA
         SKhOvcWsKhA331O2co319ekr4hp3MglUP5xJseKZXvzjGKYGQvZQpvdnsaWQktcFuP
         yKOWtLraXWn68ggWAmBCuxbwUV1B+0cvT/t2vd/NAWS1iYFsbjaXOAQuRRH6MP1apV
         Ikx7ZBxC8PIM5TELSt8UfxqyWVccQtavQeVWQCNYSDtwpfuQmFc/tEQWJSpszmxTdP
         m7N64owaeUHgQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/10] srcu: Add comment explaining cookie overflow/wrap
Date:   Wed,  6 Jan 2021 08:55:28 -0800
Message-Id: <20210106165531.20697-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds to the poll_state_synchronize_srcu() header comment
describing the issues surrounding SRCU cookie overflow/wrap for the
different kernel configurations.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c5d0c03..119938d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1058,6 +1058,21 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
  * get_state_synchronize_srcu() or start_poll_synchronize_srcu(), and
  * returns @true if an SRCU grace period elapsed since the time that the
  * cookie was created.
+ *
+ * Because cookies are finite in size, wrapping/overflow is possible.
+ * This is more pronounced on 32-bit systems where cookies are 32 bits,
+ * where in theory wrapping could happen in about 14 hours assuming
+ * 25-microsecond expedited SRCU grace periods.  However, a more likely
+ * overflow lower bound is on the order of 24 days in the case of
+ * one-millisecond SRCU grace periods.  Of course, wrapping in a 64-bit
+ * system requires geologic timespans, as in more than seven million years
+ * even for expedited SRCU grace periods.
+ *
+ * Wrapping/overflow is much more of an issue for CONFIG_SMP=n systems
+ * that also have CONFIG_PREEMPTION=n, which selects Tiny SRCU.  This uses
+ * a 16-bit cookie, which rcutorture routinely wraps in a matter of a
+ * few minutes.  If this proves to be a problem, this counter will be
+ * expanded to the same size as for Tree SRCU.
  */
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 {
-- 
2.9.5

