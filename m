Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA72C433E9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB11264E76
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhCDBAe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240186AbhCDABC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:01:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 787BC64FCA;
        Thu,  4 Mar 2021 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816021;
        bh=KyhESCEyk95eJXUdX1QrZPaV6Phl+cBTOepbGY9cM04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqmisaPsaTSFMUX24m82jvJiEBwyuBK+pqhsm6cZjGmUVbtDFx13Df1a+wYeiotU9
         iXL3n+17rzt2AjtX7GyurgF9wyMMGYZXv7D9/mU48jPtmnf2Vsqv0a4ToUn2nkn9Nn
         YXPdobmdxSwtQoEwOag+TOzswHekWffY0EUFo13QB3ApnfoOSFVg4ZU3+jCC3LP3+3
         UnChLsmNzNrWW9gpIAOliAwwVrMzhRKTQiKUbgFa1SNU+EYnXaeqVfmo+xO+iE0KG7
         eD3I2/5ME2SbWMD9xayzZvmDpCVkw4z0EttQfm3gyZPw96Zz1r2kwHw8pBpzdbtrLq
         6eK4qaCGdakpw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/10] rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()
Date:   Wed,  3 Mar 2021 16:00:12 -0800
Message-Id: <20210304000019.22459-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

In rcu_nmi_enter(), there is an erroneous instrumentation_end() in the
second branch of the "if" statement.  Oddly enough, "objtool check -f
vmlinux.o" fails to complain because it is unable to correctly cover
all cases.  Instead, objtool visits the third branch first, which marks
following trace_rcu_dyntick() as visited.  This commit therefore removes
the spurious instrumentation_end().

Fixes: 04b25a495bd6 ("rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr")
Reported-by Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e62c2de..4d90f20 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1076,7 +1076,6 @@ noinstr void rcu_nmi_enter(void)
 	} else if (!in_nmi()) {
 		instrumentation_begin();
 		rcu_irq_enter_check_tick();
-		instrumentation_end();
 	} else  {
 		instrumentation_begin();
 	}
-- 
2.9.5

