Return-Path: <SRS0=2S7T=7B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F3C433E0
	for <rcu@archiver.kernel.org>; Tue, 19 May 2020 20:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F56206C3
	for <rcu@archiver.kernel.org>; Tue, 19 May 2020 20:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgESUUm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 May 2020 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgESUUm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 May 2020 16:20:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002EC08C5C0;
        Tue, 19 May 2020 13:20:42 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jb8if-00012c-Gr; Tue, 19 May 2020 22:20:09 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data access
Date:   Tue, 19 May 2020 22:19:07 +0200
Message-Id: <20200519201912.1564477-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519201912.1564477-1-bigeasy@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

SRCU disables interrupts to get a stable per-CPU pointer and then
acquires the spinlock which is in the per-CPU data structure. The
release uses spin_unlock_irqrestore(). While this is correct on a non-RT
kernel, this conflicts with the RT semantics because the spinlock is
converted to a 'sleeping' spinlock. Sleeping locks can obviously not be
acquired with interrupts disabled.

Add a local lock and use the corresponding local lock operations.  Split
the restore into unlock and local_lock_irqrestore(). The local lock
operations map to local_irq_disable/enable() on a non-RT kernel. On a RT
kernel the local lock is substituted with a real per CPU lock which
serializes the access and guarantees CPU locality, but keeps the code
section preemptible. No functional change.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/srcutree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0c71505f0e19c..8d2b5f75145d7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/srcu.h>
+#include <linux/locallock.h>
=20
 #include "rcu.h"
 #include "rcu_segcblist.h"
@@ -735,6 +736,7 @@ static void srcu_flip(struct srcu_struct *ssp)
 	smp_mb(); /* D */  /* Pairs with C. */
 }
=20
+static DEFINE_LOCAL_LOCK(sda_lock);
 /*
  * If SRCU is likely idle, return true, otherwise return false.
  *
@@ -765,13 +767,13 @@ static bool srcu_might_be_idle(struct srcu_struct *ss=
p)
 	unsigned long tlast;
=20
 	/* If the local srcu_data structure has callbacks, not idle.  */
-	local_irq_save(flags);
+	local_lock_irqsave(sda_lock, flags);
 	sdp =3D this_cpu_ptr(ssp->sda);
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(sda_lock, flags);
 		return false; /* Callbacks already present, so not idle. */
 	}
-	local_irq_restore(flags);
+	local_unlock_irqrestore(sda_lock, flags);
=20
 	/*
 	 * No local callbacks, so probabalistically probe global state.
@@ -851,7 +853,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct=
 rcu_head *rhp,
 	}
 	rhp->func =3D func;
 	idx =3D srcu_read_lock(ssp);
-	local_irq_save(flags);
+	local_lock_irqsave(sda_lock, flags);
 	sdp =3D this_cpu_ptr(ssp->sda);
 	spin_lock_rcu_node(sdp);
 	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
@@ -867,7 +869,8 @@ static void __call_srcu(struct srcu_struct *ssp, struct=
 rcu_head *rhp,
 		sdp->srcu_gp_seq_needed_exp =3D s;
 		needexp =3D true;
 	}
-	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	spin_unlock_rcu_node(sdp);
+	local_unlock_irqrestore(sda_lock, flags);
 	if (needgp)
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
--=20
2.26.2

