Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D1DC433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4F664F1D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhCDBA6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355389AbhCDAXy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:23:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B71864ECF;
        Thu,  4 Mar 2021 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817393;
        bh=b+/S08LQWzwt79w0mW8el2iuTxwwAuT1isXEsqM/qu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPAR+k984POx2l/cqn3u21vbFJq6xRD7Ny6DTTp0jgubDFWk0f5XGDoZBfT/i6ITi
         ZeTpfWUHYbg8qD6QV1QGSdZzCQz6OjYESe7T4btdcKErl8ax/wJHBvLlRu2R1be/h4
         hrNbekBC+QcSfIn2cpIHcIBqyCK+WHp2umTQEoOtjm2GoltC7eZL6rJNSZeLJb4R7b
         zorkEO/TlHolOJwvQOPf4GI5eUKl59otS4zSWf6w5w9b8YSk7elvsTIcZUHSUmq7cM
         xRNAUJpt+toF2vgzwvlTBZhrkh0OPHkC4Td4eVObD5jGSI9AkykXSzez6Z9AFvkzBw
         508rEESODJIvQ==
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
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/12] rcu/nocb: Comment the reason behind BH disablement on batch processing
Date:   Wed,  3 Mar 2021 16:23:02 -0800
Message-Id: <20210304002311.23655-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit explains why softirqs need to be disabled while invoking
callbacks, even when callback processing has been offloaded.  After
all, invoking callbacks concurrently is one thing, but concurrently
invoking the same callback is quite another.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index cd513ea..013142d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2235,6 +2235,12 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
 	local_irq_restore(flags);
+	/*
+	 * Disable BH to provide the expected environment.  Also, when
+	 * transitioning to/from NOCB mode, a self-requeuing callback might
+	 * be invoked from softirq.  A short grace period could cause both
+	 * instances of this callback would execute concurrently.
+	 */
 	local_bh_disable();
 	rcu_do_batch(rdp);
 	local_bh_enable();
-- 
2.9.5

