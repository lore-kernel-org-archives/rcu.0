Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED73C43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EAD23134
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbhAFQ4z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbhAFQ4y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0316D23332;
        Wed,  6 Jan 2021 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952134;
        bh=4LG+A5nBqGrNwzad8okpBkoWV5G6uEL0A1Ds8zP3RBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXZ+CzMmed6fnWp09Rz3aoDV+dUpaRsnFn3vApW3Pxb3AeCeXVXHXR4H9mubuJ0l5
         obc3ydVOCboEFFwhFliEX2+pHk2fu5zYt2z6tWPsVKOKMsGiDqsGCsfFemRucFWzSm
         XhE/Kie6sosMjEWxyDB4JkpgpzSUV+iBzmIjcx3OOQtt5Ug3wIqhxnogjngQ3Pybab
         vZhKI5BO/H92NEZ/C3Jx8a2HQjtjSgKz2J/XkY6I2UCbtIbRmd8w+WX5036IOduP0g
         crpfYAFBn5HatlnCMSGhyhZC03Ey9JRS+mkd4HdJqW5Pa8f7FCKb66lVL2n3uf+wnZ
         qS2722eZSV5MQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/10] rcutorture: Add writer-side tests of polling grace-period API
Date:   Wed,  6 Jan 2021 08:55:30 -0800
Message-Id: <20210106165531.20697-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds writer-side testing of the polling grace-period API.
One test verifies that the polling API sees a grace period caused by
some other mechanism.  Another test verifies that using the polling API
to wait for a grace period does not result in too-short grace periods.
A third test verifies that the polling API does not report
completion within a read-side critical section.  A fourth and final
test verifies that the polling API does report completion given an
intervening grace period.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 79 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bcea23c..78ba95d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -85,6 +85,7 @@ torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(bool, gp_normal, false,
 	     "Use normal (non-expedited) GP wait primitives");
+torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
@@ -183,9 +184,11 @@ static int rcu_torture_writer_state;
 #define RTWS_EXP_SYNC		4
 #define RTWS_COND_GET		5
 #define RTWS_COND_SYNC		6
-#define RTWS_SYNC		7
-#define RTWS_STUTTER		8
-#define RTWS_STOPPING		9
+#define RTWS_POLL_GET		7
+#define RTWS_POLL_WAIT		8
+#define RTWS_SYNC		9
+#define RTWS_STUTTER		10
+#define RTWS_STOPPING		11
 static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_FIXED_DELAY",
 	"RTWS_DELAY",
@@ -194,6 +197,8 @@ static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_EXP_SYNC",
 	"RTWS_COND_GET",
 	"RTWS_COND_SYNC",
+	"RTWS_POLL_GET",
+	"RTWS_POLL_WAIT",
 	"RTWS_SYNC",
 	"RTWS_STUTTER",
 	"RTWS_STOPPING",
@@ -312,6 +317,8 @@ struct rcu_torture_ops {
 	void (*sync)(void);
 	void (*exp_sync)(void);
 	unsigned long (*get_gp_state)(void);
+	unsigned long (*start_gp_poll)(void);
+	bool (*poll_gp_state)(unsigned long oldstate);
 	void (*cond_sync)(unsigned long oldstate);
 	call_rcu_func_t call;
 	void (*cb_barrier)(void);
@@ -570,6 +577,21 @@ static void srcu_torture_synchronize(void)
 	synchronize_srcu(srcu_ctlp);
 }
 
+static unsigned long srcu_torture_get_gp_state(void)
+{
+	return get_state_synchronize_srcu(srcu_ctlp);
+}
+
+static unsigned long srcu_torture_start_gp_poll(void)
+{
+	return start_poll_synchronize_srcu(srcu_ctlp);
+}
+
+static bool srcu_torture_poll_gp_state(unsigned long oldstate)
+{
+	return poll_state_synchronize_srcu(srcu_ctlp, oldstate);
+}
+
 static void srcu_torture_call(struct rcu_head *head,
 			      rcu_callback_t func)
 {
@@ -601,6 +623,9 @@ static struct rcu_torture_ops srcu_ops = {
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
+	.get_gp_state	= srcu_torture_get_gp_state,
+	.start_gp_poll	= srcu_torture_start_gp_poll,
+	.poll_gp_state	= srcu_torture_poll_gp_state,
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
@@ -1027,18 +1052,20 @@ static int
 rcu_torture_writer(void *arg)
 {
 	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
+	unsigned long cookie;
 	int expediting = 0;
 	unsigned long gp_snap;
 	bool gp_cond1 = gp_cond, gp_exp1 = gp_exp, gp_normal1 = gp_normal;
-	bool gp_sync1 = gp_sync;
+	bool gp_poll1 = gp_poll, gp_sync1 = gp_sync;
 	int i;
+	int idx;
 	int oldnice = task_nice(current);
 	struct rcu_torture *rp;
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
 	bool stutter_waited;
 	int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC,
-			   RTWS_COND_GET, RTWS_SYNC };
+			   RTWS_COND_GET, RTWS_POLL_GET, RTWS_SYNC };
 	int nsynctypes = 0;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
@@ -1048,8 +1075,8 @@ rcu_torture_writer(void *arg)
 			 torture_type, cur_ops->name);
 
 	/* Initialize synctype[] array.  If none set, take default. */
-	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_sync1)
-		gp_cond1 = gp_exp1 = gp_normal1 = gp_sync1 = true;
+	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_poll1 && !gp_sync1)
+		gp_cond1 = gp_exp1 = gp_normal1 = gp_poll1 = gp_sync1 = true;
 	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
 		pr_info("%s: Testing conditional GPs.\n", __func__);
@@ -1068,6 +1095,12 @@ rcu_torture_writer(void *arg)
 	} else if (gp_normal && !cur_ops->deferred_free) {
 		pr_alert("%s: gp_normal without primitives.\n", __func__);
 	}
+	if (gp_poll1 && cur_ops->start_gp_poll && cur_ops->poll_gp_state) {
+		synctype[nsynctypes++] = RTWS_POLL_GET;
+		pr_info("%s: Testing polling GPs.\n", __func__);
+	} else if (gp_poll && (!cur_ops->start_gp_poll || !cur_ops->poll_gp_state)) {
+		pr_alert("%s: gp_poll without primitives.\n", __func__);
+	}
 	if (gp_sync1 && cur_ops->sync) {
 		synctype[nsynctypes++] = RTWS_SYNC;
 		pr_info("%s: Testing normal GPs.\n", __func__);
@@ -1107,6 +1140,18 @@ rcu_torture_writer(void *arg)
 			atomic_inc(&rcu_torture_wcount[i]);
 			WRITE_ONCE(old_rp->rtort_pipe_count,
 				   old_rp->rtort_pipe_count + 1);
+			if (cur_ops->get_gp_state && cur_ops->poll_gp_state) {
+				idx = cur_ops->readlock();
+				cookie = cur_ops->get_gp_state();
+				WARN_ONCE(rcu_torture_writer_state != RTWS_DEF_FREE &&
+					  cur_ops->poll_gp_state(cookie),
+					  "%s: Cookie check 1 failed %s(%d) %lu->%lu\n",
+					  __func__,
+					  rcu_torture_writer_state_getname(),
+					  rcu_torture_writer_state,
+					  cookie, cur_ops->get_gp_state());
+				cur_ops->readunlock(idx);
+			}
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
 			case RTWS_DEF_FREE:
 				rcu_torture_writer_state = RTWS_DEF_FREE;
@@ -1128,6 +1173,18 @@ rcu_torture_writer(void *arg)
 				cur_ops->cond_sync(gp_snap);
 				rcu_torture_pipe_update(old_rp);
 				break;
+			case RTWS_POLL_GET:
+				rcu_torture_writer_state = RTWS_POLL_GET;
+				gp_snap = cur_ops->start_gp_poll();
+				rcu_torture_writer_state = RTWS_POLL_WAIT;
+				while (!cur_ops->poll_gp_state(gp_snap)) {
+					i = torture_random(&rand) % 16;
+					if (i != 0)
+						schedule_timeout_interruptible(i);
+					udelay(torture_random(&rand) % 1000);
+				}
+				rcu_torture_pipe_update(old_rp);
+				break;
 			case RTWS_SYNC:
 				rcu_torture_writer_state = RTWS_SYNC;
 				cur_ops->sync();
@@ -1137,6 +1194,14 @@ rcu_torture_writer(void *arg)
 				WARN_ON_ONCE(1);
 				break;
 			}
+			if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+				WARN_ONCE(rcu_torture_writer_state != RTWS_DEF_FREE &&
+					  !cur_ops->poll_gp_state(cookie),
+					  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
+					  __func__,
+					  rcu_torture_writer_state_getname(),
+					  rcu_torture_writer_state,
+					  cookie, cur_ops->get_gp_state());
 		}
 		WRITE_ONCE(rcu_torture_current_version,
 			   rcu_torture_current_version + 1);
-- 
2.9.5

