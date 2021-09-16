Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D07DC433F5
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752F6611CE
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhIPAPR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhIPAPP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1CE761209;
        Thu, 16 Sep 2021 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751235;
        bh=E3i0Wp/NI7GLbCY2ElztfyiA75zrtSW/HRh66Q1bQgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oj4qDDierWbH4Z9zNA4N/ViPSfo5Cwvwdo7erfA2ax2Ww0Jighn9DQpJC84IAp7xY
         Xoj7IytNhFknXY+6MP32evYAL97sC4ybsjZa9tq0SAAYsQWDK+CJSu1ko+4JHu+xgX
         l1qV8+hQOm9peMi6I0drpycEykgjgUiT9bY77tcTCOTfi0XfVj5f/dqoZm2xA0AOrH
         BePWQsB2Xv+7O5wdNqCX0hb3GhHAHmp0h6gr/Ov/A61mnFSCIBXuA+z5hMTgSptzy/
         2kwvfhZ4UFiF2qHXpUar1S8bBEPXcaRERIcifbXuwyaUfwFznu3W6jFi8zsQMEBnKW
         sEDV2KKE1Pucw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4796D5C0954; Wed, 15 Sep 2021 17:13:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/7] rcutorture: Don't cpuhp_remove_state() if cpuhp_setup_state() failed
Date:   Wed, 15 Sep 2021 17:13:51 -0700
Message-Id: <20210916001352.3909170-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
References: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, in CONFIG_RCU_BOOST kernels, if the rcu_torture_init()
function's call to cpuhp_setup_state() fails, rcu_torture_cleanup()
gamely passes nonsense to cpuhp_remove_state().  This results in
strange and misleading splats.  This commit therefore ensures that if
the rcu_torture_init() function's call to cpuhp_setup_state() fails,
rcu_torture_cleanup() avoids invoking cpuhp_remove_state().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b90cd4d98a20..424184764ef0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2819,7 +2819,7 @@ rcu_torture_cleanup(void)
 		 rcutorture_seq_diff(gp_seq, start_gp_seq));
 	torture_stop_kthread(rcu_torture_stats, stats_task);
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
-	if (rcu_torture_can_boost())
+	if (rcu_torture_can_boost() && rcutor_hp >= 0)
 		cpuhp_remove_state(rcutor_hp);
 
 	/*
@@ -3132,9 +3132,9 @@ rcu_torture_init(void)
 		firsterr = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "RCU_TORTURE",
 					     rcutorture_booster_init,
 					     rcutorture_booster_cleanup);
+		rcutor_hp = firsterr;
 		if (torture_init_error(firsterr))
 			goto unwind;
-		rcutor_hp = firsterr;
 
 		// Testing RCU priority boosting requires rcutorture do
 		// some serious abuse.  Counter this by running ksoftirqd
-- 
2.31.1.189.g2e36527f23

