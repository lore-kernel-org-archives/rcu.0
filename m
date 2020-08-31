Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82328C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6016020E65
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897078;
	bh=+eMk/MFGdcAHBuSZ4HbjsCXhiKaiNkxWmakPUc86lpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RUyyx0dCDOR/+7SsezRjqN7Tq9QLlk9xRb3sJCAUfzivqrBZ4Wn41lNxG29oiNAe1
	 +yr3nAxPVgYaq/q+dqe2XuiDHFIxF5Eq7qkdMGDUUC+3swaWvtrvhLsFQ/pIkWicv/
	 bFk8VHppuDtXOOskZ4em+Ip/fGZ1CDp2XPTfkR0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgHaSEh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbgHaSEL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 210D5216C4;
        Mon, 31 Aug 2020 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897051;
        bh=+eMk/MFGdcAHBuSZ4HbjsCXhiKaiNkxWmakPUc86lpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6KHWOWK60n4MYSUaAE5zsWz+HwSh9IUy2j6f++YHkDJd3tTunH6Z3T13JoZUVvGL
         6LwwGKL2iERMhBO1YduptPYQAgmxFwBbRXB0wb29+ArxqkE1t8/joQfbgVp1xMYIhm
         3AmNdZJr+pMKYk7j/51aQIl+bOaIYUtafWbzE8PE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/14] rcutorture: Properly synchronize with OOM notifier
Date:   Mon, 31 Aug 2020 11:04:02 -0700
Message-Id: <20200831180406.494-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The current rcutorture forward-progress code assumes that it is the
only cause of out-of-memory (OOM) events.  For script-based rcutorture
testing, this assumption is in fact correct.  However, testing based
on modprobe/rmmod might well encounter external OOM events, which could
happen at any time.

This commit therefore properly synchronizes the interaction between
rcutorture's forward-progress testing and its OOM notifier by adding a
global mutex.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7942be4..2b3f04e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1796,6 +1796,7 @@ struct rcu_fwd {
 	unsigned long rcu_launder_gp_seq_start;
 };
 
+static DEFINE_MUTEX(rcu_fwd_mutex);
 static struct rcu_fwd *rcu_fwds;
 static bool rcu_fwd_emergency_stop;
 
@@ -2062,8 +2063,14 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 static int rcutorture_oom_notify(struct notifier_block *self,
 				 unsigned long notused, void *nfreed)
 {
-	struct rcu_fwd *rfp = rcu_fwds;
+	struct rcu_fwd *rfp;
 
+	mutex_lock(&rcu_fwd_mutex);
+	rfp = rcu_fwds;
+	if (!rfp) {
+		mutex_unlock(&rcu_fwd_mutex);
+		return NOTIFY_OK;
+	}
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
 	rcu_torture_fwd_cb_hist(rfp);
@@ -2081,6 +2088,7 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 	smp_mb(); /* Frees before return to avoid redoing OOM. */
 	(*(unsigned long *)nfreed)++; /* Forward progress CBs freed! */
 	pr_info("%s returning after OOM processing.\n", __func__);
+	mutex_unlock(&rcu_fwd_mutex);
 	return NOTIFY_OK;
 }
 
@@ -2148,7 +2156,9 @@ static int __init rcu_torture_fwd_prog_init(void)
 		return -ENOMEM;
 	spin_lock_init(&rfp->rcu_fwd_lock);
 	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
+	mutex_lock(&rcu_fwd_mutex);
 	rcu_fwds = rfp;
+	mutex_unlock(&rcu_fwd_mutex);
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
@@ -2158,7 +2168,9 @@ static void rcu_torture_fwd_prog_cleanup(void)
 
 	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
 	rfp = rcu_fwds;
+	mutex_lock(&rcu_fwd_mutex);
 	rcu_fwds = NULL;
+	mutex_unlock(&rcu_fwd_mutex);
 	kfree(rfp);
 }
 
-- 
2.9.5

