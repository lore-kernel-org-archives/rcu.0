Return-Path: <SRS0=65p9=BK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13334C433E1
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E731A208E4
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1gVhv+pl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34Ft422S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgGaJWx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732256AbgGaJWw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:52 -0400
Date:   Fri, 31 Jul 2020 09:22:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UGkgy8EkFUcjQ59lSdow0rWO1m7pYZnRW4/sMFesy3Y=;
        b=1gVhv+plLvT4F5geACUb6xGWGM3J2JWc9uJ1wM70XokN/0nH2bnOZE6ZQodi1475iXHm0M
        HYZETuJ4ymAaR71ahjG28+wwkfaR65It2BN6l8Map/b3xZNfAC2C99Cung7aG5ydVY3pCl
        ONx+o+q6JH8OGT8Y7dlxHzgGdNsHYXju22DpW8ngApaIe3H4+luDb4wstl6BRaUlvbrHxq
        117DWu8g4UNiU8vaLvPLQECG9duoSeGBI1tr/kJiPn8kTkTNHX4h/vIJAe6S5Dye6POpid
        IyAOa3qnu/JTycqZufezg4CsDxSK+3oV5Frk4Y0D2awuRtE5m/yd/ottAhOwMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UGkgy8EkFUcjQ59lSdow0rWO1m7pYZnRW4/sMFesy3Y=;
        b=34Ft422SM590bnpB3OhmsGVF5cTdSCOOLQC8OdGuaKTRTpuO4Mj9JV8aGLNiV+Ivq/npvR
        xxszKeLlLv48ppAg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Avoid local_irq_save() before acquiring spinlock_t
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736995.4006.14996866225655949863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bde50d8ff83e4ce9e576f7c5ba1edb48a3610a5b
Gitweb:        https://git.kernel.org/tip/bde50d8ff83e4ce9e576f7c5ba1edb48a3610a5b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 26 May 2020 15:41:34 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:22 -07:00

srcu: Avoid local_irq_save() before acquiring spinlock_t

SRCU disables interrupts to get a stable per-CPU pointer and then
acquires the spinlock which is in the per-CPU data structure. The
release uses spin_unlock_irqrestore(). While this is correct on a non-RT
kernel, this conflicts with the RT semantics because the spinlock is
converted to a 'sleeping' spinlock. Sleeping locks can obviously not be
acquired with interrupts disabled.

Acquire the per-CPU pointer `ssp->sda' without disabling preemption and
then acquire the spinlock_t of the per-CPU data structure. The lock will
ensure that the data is consistent.

The added call to check_init_srcu_struct() is now needed because a
statically defined srcu_struct may remain uninitialized until this
point and the newly introduced locking operation requires an initialized
spinlock_t.

This change was tested for four hours with 8*SRCU-N and 8*SRCU-P without
causing any warnings.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8ff71e5..c100acf 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -777,14 +777,15 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	unsigned long t;
 	unsigned long tlast;
 
+	check_init_srcu_struct(ssp);
 	/* If the local srcu_data structure has callbacks, not idle.  */
-	local_irq_save(flags);
-	sdp = this_cpu_ptr(ssp->sda);
+	sdp = raw_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
-		local_irq_restore(flags);
+		spin_unlock_irqrestore_rcu_node(sdp, flags);
 		return false; /* Callbacks already present, so not idle. */
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore_rcu_node(sdp, flags);
 
 	/*
 	 * No local callbacks, so probabalistically probe global state.
@@ -864,9 +865,8 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	}
 	rhp->func = func;
 	idx = srcu_read_lock(ssp);
-	local_irq_save(flags);
-	sdp = this_cpu_ptr(ssp->sda);
-	spin_lock_rcu_node(sdp);
+	sdp = raw_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
 	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_gp_seq));
