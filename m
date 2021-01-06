Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C7AC433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1DB2313B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbhAFQ4r (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbhAFQ4q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB9F823331;
        Wed,  6 Jan 2021 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952133;
        bh=L2mg8ik93/nh6+02F4G1cablM0xWLGwvjKRbUhtEeAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c42OjCv/SoMo39bQbW+V5pKcnQzsObIdVFYd0Kn9z3NvFVCZLLF9AWIavXNC4hSJK
         YOSNplW3usJLSh71a6Ltkg80xDC0hW2AMXx0NPjgQL47Sygn+HJ/3on+UagbJtJG3t
         TBmM58b2dkIdcJxvzuNgPJ3BWeLvDjzWKgLUWh86gMnJFuRFgNREWyl3aWtVCwKNWR
         QOZ4opCBb/uAqyolgOn+0qCHJ6jUs1B5HLw+SOawizsez2tL7y1D9BIBNB8Eby9BTW
         hM8CAJyIk8jHQn1M0uTS1jsVhfs23up2dlJePleL4MSYgpXGVqavVdgvE15wnE5Gc4
         sz/WwtiGubr3w==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/10] rcutorture: Prepare for ->start_gp_poll and ->poll_gp_state
Date:   Wed,  6 Jan 2021 08:55:29 -0800
Message-Id: <20210106165531.20697-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The new get_state_synchronize_srcu(), start_poll_synchronize_srcu() and
poll_state_synchronize_srcu() functions need to be tested, and so this
commit prepares by renaming the rcu_torture_ops field ->get_state to
->get_gp_state in order to be consistent with the upcoming ->start_gp_poll
and ->poll_gp_state fields.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 528ed10..bcea23c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -311,7 +311,7 @@ struct rcu_torture_ops {
 	void (*deferred_free)(struct rcu_torture *p);
 	void (*sync)(void);
 	void (*exp_sync)(void);
-	unsigned long (*get_state)(void);
+	unsigned long (*get_gp_state)(void);
 	void (*cond_sync)(unsigned long oldstate);
 	call_rcu_func_t call;
 	void (*cb_barrier)(void);
@@ -461,7 +461,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.deferred_free	= rcu_torture_deferred_free,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
-	.get_state	= get_state_synchronize_rcu,
+	.get_gp_state	= get_state_synchronize_rcu,
 	.cond_sync	= cond_synchronize_rcu,
 	.call		= call_rcu,
 	.cb_barrier	= rcu_barrier,
@@ -1050,10 +1050,10 @@ rcu_torture_writer(void *arg)
 	/* Initialize synctype[] array.  If none set, take default. */
 	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_sync1)
 		gp_cond1 = gp_exp1 = gp_normal1 = gp_sync1 = true;
-	if (gp_cond1 && cur_ops->get_state && cur_ops->cond_sync) {
+	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
 		pr_info("%s: Testing conditional GPs.\n", __func__);
-	} else if (gp_cond && (!cur_ops->get_state || !cur_ops->cond_sync)) {
+	} else if (gp_cond && (!cur_ops->get_gp_state || !cur_ops->cond_sync)) {
 		pr_alert("%s: gp_cond without primitives.\n", __func__);
 	}
 	if (gp_exp1 && cur_ops->exp_sync) {
@@ -1119,7 +1119,7 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_COND_GET:
 				rcu_torture_writer_state = RTWS_COND_GET;
-				gp_snap = cur_ops->get_state();
+				gp_snap = cur_ops->get_gp_state();
 				i = torture_random(&rand) % 16;
 				if (i != 0)
 					schedule_timeout_interruptible(i);
-- 
2.9.5

