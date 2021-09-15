Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A149C4167B
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A0A611CB
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhIOXfI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232951AbhIOXfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BCB86120C;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=234ahk6oNxQmkMKOFLCMjXlm+tyXj+IMXgmItbA+yC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGXDZWe6IOI/NqJqCPyhfd0lJyjWL1XAaYKkk0+4GSfGpiiD23FWK6DnL7ntyAOLM
         nLmpykFC2ruBCGNTrVquX05jtOiWUrtUD0jE6OxkR1vFIo+JKoUn7DL0QMIudVdW6L
         GghMUrRXV5/B6lA4qFKSntZJJ8pkJQQUbFSyjVkvs0TCU/8IOKW4K5D9NJ0PmSkzar
         9+pw6WVLd/hTas/1AwDjWt2/58phFG5EraINYV6anDT4Lj/NG7pqzxuKWk1P5syl97
         3nIsnHxJny+qT5WqT55GRpVfg6CN6Nln+9W6jM3koQ53FoqmKNqUI8YihsJRXaA4Qs
         Mx6jW69DoL4iw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CE6A55C0DA5; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/14] rcu: Make rcu_normal_after_boot writable again
Date:   Wed, 15 Sep 2021 16:33:40 -0700
Message-Id: <20210915233343.3906738-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

Certain configurations (e.g., systems that make heavy use of netns)
need to use synchronize_rcu_expedited() to service RCU grace periods
even after boot.

Even though synchronize_rcu_expedited() has been traditionally
considered harmful for RT for the heavy use of IPIs, it is perfectly
usable under certain conditions (e.g. nohz_full).

Make rcupdate.rcu_normal_after_boot= again writeable on RT (if NO_HZ_
FULL is defined), but keep its default value to 1 (enabled) to avoid
regressions. Users who need synchronize_rcu_expedited() will boot with
rcupdate.rcu_normal_after_ boot=0 in the kernel cmdline.

Reflect the change in synchronize_rcu_expedited_wait() by removing the
WARN related to CONFIG_PREEMPT_RT.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 1 -
 kernel/rcu/update.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2796084ef85a..d9e4f8eb9ae2 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -512,7 +512,6 @@ static void synchronize_rcu_expedited_wait(void)
 		j = READ_ONCE(jiffies_till_first_fqs);
 		if (synchronize_rcu_expedited_wait_once(j + HZ))
 			return;
-		WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT));
 	}
 
 	for (;;) {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38cc25e9..bd551134e2f4 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -57,7 +57,7 @@
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
-#ifndef CONFIG_PREEMPT_RT
+#if !defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)
 module_param(rcu_normal_after_boot, int, 0);
 #endif
 #endif /* #ifndef CONFIG_TINY_RCU */
-- 
2.31.1.189.g2e36527f23

