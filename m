Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39150C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1543D23106
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbhAFRTF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbhAFRSe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A65DF2313E;
        Wed,  6 Jan 2021 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953433;
        bh=PIpVwN3DLimIEne8pHFvgPYMDGBqCA5suiik04gf54o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4oA5Cf5P/Fo+eEaqmpTSx43wA0Ey/FRAQ3dp5X5siXbFrmUEdCBWnLyYRX759ogW
         S7Be7tENKWe1IqjAvtPBiFB1r+y+/ed89tLhkQu+U1t+upE8X+mzAUvNBNhOPYgLCx
         NlLcpGbViXuQqP6z7OPeEAWUPqwmEihTh4FBxsQDn9VAe5bMRLcv7DuFGkqFgcu/tu
         6dNoXT80kkyMd7OztnaPlehbFA9x675rfjbED1Y23jxpst49P0WLY2+ARqMDmqEQKW
         TP+yHnT6V0HBcNsFJzOMZ+lGXGxZYR0o8Vg153GNxUqXfL3GfrisckOHjO0RD7JfIP
         hJ5x0VhU6bMuw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/17] torture: Make stutter use torture_hrtimeout_*() functions
Date:   Wed,  6 Jan 2021 09:17:02 -0800
Message-Id: <20210106171710.22239-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit saves a few lines of code by making the stutter_wait()
and torture_stutter() functions use torture_hrtimeout_jiffies() and
torture_hrtimeout_us().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 7548634..7ad5c96 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -677,7 +677,6 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	ktime_t delay;
 	unsigned int i = 0;
 	bool ret = false;
 	int spt;
@@ -693,11 +692,8 @@ bool stutter_wait(const char *title)
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
 			while (READ_ONCE(stutter_pause_test)) {
-				if (!(i++ & 0xffff)) {
-					set_current_state(TASK_INTERRUPTIBLE);
-					delay = 10 * NSEC_PER_USEC;
-					schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
-				}
+				if (!(i++ & 0xffff))
+					torture_hrtimeout_us(10, 0, NULL);
 				cond_resched();
 			}
 		} else {
@@ -715,7 +711,6 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
-	ktime_t delay;
 	DEFINE_TORTURE_RANDOM(rand);
 	int wtime;
 
@@ -726,20 +721,15 @@ static int torture_stutter(void *arg)
 			if (stutter > 2) {
 				WRITE_ONCE(stutter_pause_test, 1);
 				wtime = stutter - 3;
-				delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
-				delay += (torture_random(&rand) >> 3) % NSEC_PER_MSEC;
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				torture_hrtimeout_jiffies(wtime, &rand);
 				wtime = 2;
 			}
 			WRITE_ONCE(stutter_pause_test, 2);
-			delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+			torture_hrtimeout_jiffies(wtime, NULL);
 		}
 		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
-			schedule_timeout_interruptible(stutter_gap);
+			torture_hrtimeout_jiffies(stutter_gap, NULL);
 		torture_shutdown_absorb("torture_stutter");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("torture_stutter");
-- 
2.9.5

