Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE0C4742C
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34702085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8KEhJ7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKMMOW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgKMMOP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:15 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA88522258;
        Fri, 13 Nov 2020 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269654;
        bh=bALlOIi7yasa+JiMZsL5IFvPGgyRZmbOkhz70oqMO1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8KEhJ7YNw7SkbL5q8v6ftAMlkvbHQpSf1gHxSpvROYJTPmQPvvEo/mhLoQ7xW5Pi
         MWfxaq08gpoiS2e9eSsJMQFTvvcfrJexrMFnmjcmmUypFKORHmK/G/XJyTippGj4Rv
         5qqh0p/vviGf1T1gesSccPOWhfAjo4u6TNBZSrIE=
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
Subject: [PATCH 10/19] rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
Date:   Fri, 13 Nov 2020 13:13:25 +0100
Message-Id: <20201113121334.166723-11-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Set SEGCBLIST_SOFTIRQ_ONLY once everything is settled. After that, the
callbacks are handled locklessly and locally.

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
 kernel/rcu/tree_plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dfb4b62c6b88..b68714e5ce64 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2352,7 +2352,14 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
+	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
+	/*
+	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
+	 * rcu_nocb_unlock_irqrestore() anymore. Theoretically we
+	 * could set SEGCBLIST_SOFTIRQ_ONLY with cb unlocked and IRQs
+	 * disabled now, but let's be paranoid.
+	 */
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 
 	return ret;
 }
-- 
2.25.1

