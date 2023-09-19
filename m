Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FEDCE79A9
	for <rcu@archiver.kernel.org>; Tue, 19 Sep 2023 23:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjISXJe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Sep 2023 19:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjISXJ2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3817F9;
        Tue, 19 Sep 2023 16:09:19 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayShZA5Y6+vqpU4ni2cr8EGVcvIF6GWDCtcZG+RumvA=;
        b=qWi4MpNE17XSTOZC15znu3okHtAskd1+gALDOCzTERnor7ZLmT4BWOTJ3SSSZacqDGfiOR
        cUYZw1W1x/dKVngg0utCkfIoE2HXz0xvGerwCc1bZkXBztclbspNQFbye0EHFyqn5q9emC
        DLqD5mEO2SkvCkj1goTYsLV0as0CCSyZ85xlxLCEO9cL6IOR+LMQxJv/M9T7PfhphXQjPS
        dmFqj/KfCTonrYTNj2gcEpjlHU0TAKebq5Opb9Y4rv+upIs/HzvcyhQ4K4DOJK1zyCSeWK
        jQLdDV04pCBe6+pHsDre7Bq+V5+/U1ZkkTYjAEMYlqqZL4wwdPGScwGttJdYDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayShZA5Y6+vqpU4ni2cr8EGVcvIF6GWDCtcZG+RumvA=;
        b=1RJuv2+vauyF4pdXRf65q7Di4PvGlO48NYMcr4OCbk3zNzp+SBuVjXBekdVfdWPEbzx6t4
        +dOdJccxuO8tY1DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH printk v2 10/11] rcu: Add atomic write enforcement for rcu stalls
Date:   Wed, 20 Sep 2023 01:14:55 +0206
Message-Id: <20230919230856.661435-11-john.ogness@linutronix.de>
In-Reply-To: <20230919230856.661435-1-john.ogness@linutronix.de>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Invoke the atomic write enforcement functions for rcu stalls to
ensure that the information gets out to the consoles.

It is important to note that if there are any legacy consoles
registered, they will be attempting to directly print from the
printk-caller context, which may jeopardize the reliability of
the atomic consoles. Optimally there should be no legacy
consoles registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/rcu/tree_stall.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6f06dc12904a..0a58f8b233d8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kvm_para.h>
+#include <linux/console.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -582,6 +583,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
+	enum nbcon_prio prev_prio;
 	int cpu;
 	unsigned long flags;
 	unsigned long gpa;
@@ -597,6 +599,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -651,6 +655,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
+
+	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
 }
 
 static void print_cpu_stall(unsigned long gps)
-- 
2.39.2

