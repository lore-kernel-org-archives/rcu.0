Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9693FC4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA8423120
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbhAFRTJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbhAFRSe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCE8223139;
        Wed,  6 Jan 2021 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953433;
        bh=0D0Yhy+THf9JOikUASKDeRni4EE+Laj92RDUxVdFfCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcQlcH1nMpGOGwo7KH8z3iM5DfNY60yV08aVHqhBamkJeVTMEozpIrWipQHII+dbg
         YD7+K/m82OURb3s4RDPNBAq9wWoj0Nqoo7SDFPubq9cLkdGBbf/nCy8xM8XdsIe4z6
         W9Mu6XXG1nfXc8kntgkM1QlFJNGsedklstFiLsAnKKUjRjOAx8+QCUI1SOKdF4Ejyf
         rAnSKIrnOF94WJK+sXeWZ23j5+Nc6k19rPZZa/Y/HLu3KmYLWTVpaLNpdWCW7Yrcf5
         LQGi7/+m8CxxiYN73uybQwSHPZhgRnl5qw0R2O78DeV8nwvDqFPS/eq5eVYWkfv5lO
         f4Sc4MNbOoz3Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/17] rcutorture: Use hrtimers for reader and writer delays
Date:   Wed,  6 Jan 2021 09:17:03 -0800
Message-Id: <20210106171710.22239-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces schedule_timeout_uninterruptible() and
schedule_timeout_interruptible() with torture_hrtimeout_us() and
torture_hrtimeout_jiffies() to avoid timer-wheel synchronization.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7b61086..4a0c6e6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1149,7 +1149,7 @@ rcu_torture_writer(void *arg)
 
 	do {
 		rcu_torture_writer_state = RTWS_FIXED_DELAY;
-		schedule_timeout_uninterruptible(1);
+		torture_hrtimeout_us(500, 1000, &rand);
 		rp = rcu_torture_alloc();
 		if (rp == NULL)
 			continue;
@@ -1290,8 +1290,7 @@ rcu_torture_fakewriter(void *arg)
 	set_user_nice(current, MAX_NICE);
 
 	do {
-		schedule_timeout_uninterruptible(1 + torture_random(&rand)%10);
-		udelay(torture_random(&rand) & 0x3ff);
+		torture_hrtimeout_jiffies(torture_random(&rand) % 10, &rand);
 		if (cur_ops->cb_barrier != NULL &&
 		    torture_random(&rand) % (nfakewriters * 8) == 0) {
 			cur_ops->cb_barrier();
@@ -1656,7 +1655,7 @@ rcu_torture_reader(void *arg)
 		if (!rcu_torture_one_read(&rand, myid) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
 		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
-			schedule_timeout_interruptible(1);
+			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
 		while (num_online_cpus() < mynumonline && !torture_must_stop())
-- 
2.9.5

