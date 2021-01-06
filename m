Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A470FC43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8006D23135
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbhAFQsw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbhAFQsw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:48:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 894F22313F;
        Wed,  6 Jan 2021 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951691;
        bh=p9T+tLvOKaqZQUc30xA1d4qcRneMxSvwFbZkeZJ+fHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reedywnF8oXM3f7gyGcFgV3J+eoAa4bX+G2VM/JPEAFhs5iLf4KJdjTIHS0Ja/+78
         mX3z38RPo/pcAlt5EB3qpI9SvOlKgbln1GHReEE8m2tL3IThPKxCHZJO6CLg8QAit+
         1N8+NhS5gC+dV0en0ovtOuQ5kVH1gN1iVbFJM4NCghBlpQCXW/DZNfyLpTB1FGsVcA
         fEM6Ngg/LLZSWq8+1E+QJkp90ItAM7J1BDn89YWBpbL0DksdounO5riavB3hBVSGPS
         Ib+28r9NIZ7zHoSt6E/c7aqdUASFMo/g4Glkd2gwok+B7t3IlsUWNkxS6+ufQBRg/S
         1vuy4udCjvi9g==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Julia Cartwright <julia@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/3] rcu: Enable rcu_normal_after_boot unconditionally for RT
Date:   Wed,  6 Jan 2021 08:48:09 -0800
Message-Id: <20210106164809.20068-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106164746.GA19969@paulmck-ThinkPad-P72>
References: <20210106164746.GA19969@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Julia Cartwright <julia@ni.com>

Expedited RCU grace periods send IPIs to all non-idle CPUs, and thus can
disrupt time-critical code in real-time applications.  However, there
is a portion of boot-time processing (presumably before any real-time
applications have started) where expedited RCU grace periods are the only
option.  And so it is that experience with the -rt patchset indicates that
PREEMPT_RT systems should always set the rcupdate.rcu_normal_after_boot
kernel boot parameter.

This commit therefore makes the post-boot application environment safe
for real-time applications by making PREEMPT_RT systems disable the
rcupdate.rcu_normal_after_boot kernel boot parameter and acting as
if this parameter had been set.  This means that post-boot calls to
synchronize_rcu_expedited() will be treated as if they were instead
calls to synchronize_rcu(), thus preventing the IPIs, and thus avoiding
disrupting real-time applications.

Suggested-by: Luiz Capitulino <lcapitulino@redhat.com>
Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ paulmck: Update kernel-parameters.txt accordingly. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 kernel/rcu/update.c                             | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 521255f..e0008d9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4474,6 +4474,13 @@
 			only normal grace-period primitives.  No effect
 			on CONFIG_TINY_RCU kernels.
 
+			But note that CONFIG_PREEMPT_RT=y kernels enables
+			this kernel boot parameter, forcibly setting
+			it to the value one, that is, converting any
+			post-boot attempt at an expedited RCU grace
+			period to instead use normal non-expedited
+			grace-period processing.
+
 	rcupdate.rcu_task_ipi_delay= [KNL]
 			Set time in jiffies during which RCU tasks will
 			avoid sending IPIs, starting with the beginning
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39334d2..b95ae86 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -56,8 +56,10 @@
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
-static int rcu_normal_after_boot;
+static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
+#ifndef CONFIG_PREEMPT_RT
 module_param(rcu_normal_after_boot, int, 0);
+#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.9.5

