Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB24C2BBCD
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA792250F
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgLOORm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgLOORj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 09:17:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA47C0617A6
        for <rcu@vger.kernel.org>; Tue, 15 Dec 2020 06:16:59 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608041817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZySECGp9qaVnJvFkefRmhXKlIaLzZxsilA72uIY/LiI=;
        b=aVk/ytwJA452UZi18PeuqT5B2Guaq3IsHGLo11AfAYjq09yBK+MIK2Imj32APBji6QAN/o
        26o0X5iYKI11jNA4J6dBkSFtY2EbzdewbB413tMdzYzWe1whScsBm/LxlfWUy6PhNyd6oG
        1P2YR+p/IiG03Ou0i2D8U8UuqjS0UTBLMxWtJRRPtmz9AE5bVksQj5gxBbLfWAu+FS79nq
        jTnauzUl3Wk7WjI2ij+brBvGRJon/z9KQW1iwA+G/FmcBfQRj8vM9ZmV9X0WCbZ9YMYzqj
        tGSfKAbvfrX5HDjVOY9PEpLhd51yAXbinI1HHO9Zk1dnj0a/cHzMqAVsg41YkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608041817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZySECGp9qaVnJvFkefRmhXKlIaLzZxsilA72uIY/LiI=;
        b=5tYLo0AD9Vxa7dYHXiq6EM6Z5IC4YkAEQ7UOzGd1i86HG8gtIhJpAJYrN9Jm3sjCo3YqQm
        ekFFv5jtI1VmMQCw==
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] rcu: Use rcuc threads on PREEMPT_RT.
Date:   Tue, 15 Dec 2020 15:16:46 +0100
Message-Id: <20201215141649.796472-3-bigeasy@linutronix.de>
In-Reply-To: <20201215141649.796472-1-bigeasy@linutronix.de>
References: <20201215141649.796472-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Scott Wood <swood@redhat.com>

Using rcuc threads for processing callbacks over softirq has the
advantage that the callbacks can be processed independently. On
PREEMPT_RT the softirq can be preempted. Relying on softirq for callback
processing would mean to complete the current stage of softirq for the
sake of running callbacks. The softirq is processed on PREEMPT_RT in the
context of the task that is raising a softirq. If it is raised in-IRQ
context then the softirq processing is deferred to the `ksoftirqd'
thread.
Processing RCU callbacks in thread context was always the only option
for PREEMPT_RT and there have been no complains.

Disable softirq usage for RCU and disable its commandline parameter.

Signed-off-by: Scott Wood <swood@redhat.com>
[bigeasy: Reword commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 80ceee55f379a..57eff3b82104c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -100,8 +100,10 @@ static struct rcu_state rcu_state =3D {
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
 /* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
-static bool use_softirq =3D true;
+static bool use_softirq =3D !IS_ENABLED(CONFIG_PREEMPT_RT);
+#ifndef CONFIG_PREEMPT_RT
 module_param(use_softirq, bool, 0444);
+#endif
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
 module_param(rcu_fanout_exact, bool, 0444);
--=20
2.29.2

