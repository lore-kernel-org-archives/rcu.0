Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0B4C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36CF23106
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbhAFRTK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbhAFRSe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D9552313C;
        Wed,  6 Jan 2021 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953433;
        bh=OGmZDzqwgbWi9Rg4zkjdMdAemN0aue1H41mwDuz02LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZkgg9I3zmhdDKy51Zxoz8OGFmq00aMGBUSquwjmP3QF2MaQQ/D5TNoQZvJDEyUQo
         akAorX2f9/2HsdFwCl5dMAC3ZiKAlYrDYXgi/anNUpqJngF+pBJR2JL6Q6cFh24bRB
         R6Kwz+pCfSzTpd/NKwVton8MMAo0rksp0zF3wOygRPHLl86498A6y5XkY66Z98janC
         vqS5qdjVWlJH9sQNjqT7Vi8pg7aSUzrU/mJ0Lag8e9a5ULkU29TpTy06ghLefppvHQ
         FAc9M2RbjVpjjgKku9cupyw32qVic+P1XRc65pXJYxjQYfvWljeh/CJYmAfn0A6TSL
         mBtC/o69c+dpw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/17] rcutorture: Use torture_hrtimeout_jiffies() to avoid busy-waits
Date:   Wed,  6 Jan 2021 09:17:01 -0800
Message-Id: <20210106171710.22239-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Because rcu_torture_writer() and rcu_torture_fakewriter() predate
hrtimers, they do timer-wheel-decoupled timed waits by using the
timer-wheel-based schedule_timeout_interruptible() functions in
conjunction with a random udelay()-based wait.  This latter unnecessarily
burns CPU time, so this commit instead uses torture_hrtimeout_jiffies()
to decouple from the timer wheels without busy-waiting.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1b70aa4..7b61086 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1194,10 +1194,7 @@ rcu_torture_writer(void *arg)
 			case RTWS_COND_GET:
 				rcu_torture_writer_state = RTWS_COND_GET;
 				gp_snap = cur_ops->get_gp_state();
-				i = torture_random(&rand) % 16;
-				if (i != 0)
-					schedule_timeout_interruptible(i);
-				udelay(torture_random(&rand) % 1000);
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
 				rcu_torture_writer_state = RTWS_COND_SYNC;
 				cur_ops->cond_sync(gp_snap);
 				rcu_torture_pipe_update(old_rp);
@@ -1206,12 +1203,9 @@ rcu_torture_writer(void *arg)
 				rcu_torture_writer_state = RTWS_POLL_GET;
 				gp_snap = cur_ops->start_gp_poll();
 				rcu_torture_writer_state = RTWS_POLL_WAIT;
-				while (!cur_ops->poll_gp_state(gp_snap)) {
-					i = torture_random(&rand) % 16;
-					if (i != 0)
-						schedule_timeout_interruptible(i);
-					udelay(torture_random(&rand) % 1000);
-				}
+				while (!cur_ops->poll_gp_state(gp_snap))
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_SYNC:
@@ -1290,7 +1284,6 @@ static int
 rcu_torture_fakewriter(void *arg)
 {
 	unsigned long gp_snap;
-	int i;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fakewriter task started");
@@ -1311,19 +1304,14 @@ rcu_torture_fakewriter(void *arg)
 				break;
 			case RTWS_COND_GET:
 				gp_snap = cur_ops->get_gp_state();
-				i = torture_random(&rand) % 16;
-				if (i != 0)
-					schedule_timeout_interruptible(i);
-				udelay(torture_random(&rand) % 1000);
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
 				cur_ops->cond_sync(gp_snap);
 				break;
 			case RTWS_POLL_GET:
 				gp_snap = cur_ops->start_gp_poll();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
-					i = torture_random(&rand) % 16;
-					if (i != 0)
-						schedule_timeout_interruptible(i);
-					udelay(torture_random(&rand) % 1000);
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
 				}
 				break;
 			case RTWS_SYNC:
-- 
2.9.5

