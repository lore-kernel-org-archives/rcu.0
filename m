Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77AC433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4965622227
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbhAFAza (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:55:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbhAFAza (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:55:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DAE623100;
        Wed,  6 Jan 2021 00:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894450;
        bh=pzBVc51kqixQCL1/u+W/WPWCJv7/RPB9IjtssDBXjV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fL90txU4sPJl63luUvpzvtWuVi/xC67NRzstM8ERf9oLAhHP6ubSgWeKNDMSDOCis
         xr8/eqOkGZURYyOzlJinAJof+LylbJ1NZzKxNBX4zgkVxjcX9cmLCVsCbooH7j6pXO
         VWVYLXTkZdh6/qznzYJT8iX0dR3BLGOiVbjIHCrINn7MlfakXCMVsr8MfhpwSnS3DS
         KGvgBwIzbaARvmVJ7m6Kh5wuaIB1c6raitLu0FHwZ2xDH/AsBc4P4T5kj2eT9b946u
         C20B3TjYnI5cjOV94xCOlVAVXG+iFOyAy5hRkkO1n/DnIprNEuHpiUC8cDVGejS4kG
         2013Pn7QNKGsA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 7/8] doc: Update RCU's requirements page about the PREEMPT_RT wiki.
Date:   Tue,  5 Jan 2021 16:54:06 -0800
Message-Id: <20210106005407.12295-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005334.GA12159@paulmck-ThinkPad-P72>
References: <20210106005334.GA12159@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The PREEMPT_RT wiki moved from kernel.org to the Linux Foundation wiki.
The kernel.org wiki is read only.

This commit therefore updates the URL of the active PREEMPT_RT wiki.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 65c7839..bac1cdd 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2317,7 +2317,7 @@ decides to throw at it.
 
 The Linux kernel is used for real-time workloads, especially in
 conjunction with the `-rt
-patchset <https://rt.wiki.kernel.org/index.php/Main_Page>`__. The
+patchset <https://wiki.linuxfoundation.org/realtime/>`__. The
 real-time-latency response requirements are such that the traditional
 approach of disabling preemption across RCU read-side critical sections
 is inappropriate. Kernels built with ``CONFIG_PREEMPT=y`` therefore use
-- 
2.9.5

