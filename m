Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D87C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7060523106
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbhAFRRy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbhAFRRx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:17:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAAA123136;
        Wed,  6 Jan 2021 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953432;
        bh=FnBbvmuG7oJal3Njfldq6zTgCYvBVJQ4PiqgYB0ly+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEpE7KWFy8gOxGdprv1b2Sf/A1PLL/FYWr5M3alWzg5EK+1jfa/Q+LvfErYE+4EZ9
         yWuFP+mzafE3znuKeBYf75VhfyR3o/6YyQhejjawb4pNssFAYNl0Tm8/1K0p6I/51x
         KQysvDlP1fZ3ZhdC3FhHBQAI0+De8EdkGvLVNE6rwAdD8uiCc8gr2JkzNh5IuBhUw1
         lm9AFtyUPccs8SZ6ttGLiUi2gniRB2f9/X7rTRqSPpt6Ncj0EW9mGwVI/6bTXHQXxq
         DuxIYPWDr1AtG+R5nAhZgayFRvi90iP9sVOQXXUVWfDm3IStUpu96LsitNj2KLap4T
         k+OJR1JhrX8lw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/17] rcutorture: Require entire stutter period be post-boot
Date:   Wed,  6 Jan 2021 09:16:57 -0800
Message-Id: <20210106171710.22239-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the rcu_torture_writer() function checks that all required
grace periods elapse during a stutter interval, which is a multi-second
time period during which the test load is removed.  However, this check
is suppressed during early boot (that is, before init is spawned) in
order to avoid false positives that otherwise occur due to heavy load
on the single boot CPU.

Unfortunately, this approach is insufficient.  It is possible that the
stutter interval might end just as init is spawned, so that early boot
conditions prevailed during almost the entire stutter interval.

This commit therefore takes a snapshot of boot-complete state just
before the stutter interval, thus suppressing the check for failure to
complete grace periods unless the entire stutter interval took place
after early boot.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 338e118..1930d92 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1070,6 +1070,7 @@ rcu_torture_fqs(void *arg)
 static int
 rcu_torture_writer(void *arg)
 {
+	bool boot_ended;
 	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
 	unsigned long cookie;
 	int expediting = 0;
@@ -1239,12 +1240,13 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
+		boot_ended = rcu_inkernel_boot_has_ended();
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
 		    !READ_ONCE(rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
-		    rcu_inkernel_boot_has_ended())
+		    boot_ended)
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) !=
-- 
2.9.5

