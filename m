Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED150C43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13752310A
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAFEtg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbhAFEtg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:49:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3251230FA;
        Wed,  6 Jan 2021 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908535;
        bh=5YiD2+QmyC4o+qsFxRl04nuqdIL2UYzlQdzk90xpocA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bS55uBKiir5CRl2qxbCJiMUVRYMuADTFHAdKVxOqUX1ER29ZDagXaNDZhirC0GsJS
         EYUtVsPCcLSKgZCxxyhxx3/pXJP8etkeOiMUfwKq0T4UaI1SXXKV3toIYBorFUnqlE
         ZxSxS1jrY+F10n0S8NrEjm+i2wtoyY+CtCFLEcBmW/VLOkhvuAcEk2IpBktGDgTxcG
         RZ06ql642Zx5mC2ssR9aFJRSTYY3oBhGNuytm6RaQhpj959jMRh32njaBHVz8MVAdJ
         BGHIOyW30NIZ04Sq1qS4MU8pgLvoLuH+vmsi72+BvMJIw5lcyALQylVrkL0C/w87QN
         iRLH3Ok420DMA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/21] rcu/nocb: Don't deoffload an offline CPU with pending work
Date:   Tue,  5 Jan 2021 20:48:37 -0800
Message-Id: <20210106044853.20812-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Offloaded CPUs do not migrate their callbacks, instead relying on
their rcuo kthread to invoke them.  But if the CPU is offline, it
will be running neither its RCU_SOFTIRQ handler nor its rcuc kthread.
This means that de-offloading an offline CPU that still has pending
callbacks will strand those callbacks.  This commit therefore refuses
to toggle offline CPUs having pending callbacks.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1b870d0..b70cc91 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2227,6 +2227,15 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	printk("De-offloading %d\n", rdp->cpu);
 
 	rcu_nocb_lock_irqsave(rdp, flags);
+	/*
+	 * If there are still pending work offloaded, the offline
+	 * CPU won't help much handling them.
+	 */
+	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		return -EBUSY;
+	}
+
 	rcu_segcblist_offload(cblist, false);
 
 	if (rdp->nocb_cb_sleep) {
-- 
2.9.5

