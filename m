Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55B0C2BB9A
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEF22250F
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgLOORm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgLOORk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 09:17:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA51CC0617B0
        for <rcu@vger.kernel.org>; Tue, 15 Dec 2020 06:16:59 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608041818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Q6KSzr7NAxfowGjdx2GiERE3dvkdCAmXnmQzbVs6EM=;
        b=xLbmkpa5TkGywVJLfUXWZ/E+2NsfNrbWQ6iGsP2mVdJSPybCr/xPxzttAc9E5z3HGBJyNq
        B22SYftoaOI6+1OfVIUv7oUM+8jUEmxvIWIjYnJYtIvHmDeGa/Gdze351AzvI84swvBkdD
        3g32As6Jcv5e0NFJNbbP3twcJ/nFE0nfwBCLrP93sdF4oHYyAq7q4ux0o9NA1kNsgqxkL1
        e9d8lGymQqva8DLjcyGvSMJCiVqXdpeK8l97nOoQ/eHEXgqOcdQtOQg0vwuoI4QxDnwfrV
        IRVckb9H6hdBqT5KK8JiWc8g2LNgZm3BXx2XjjbmUWn+NbI8C56V4s2CTMkzpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608041818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Q6KSzr7NAxfowGjdx2GiERE3dvkdCAmXnmQzbVs6EM=;
        b=WdxiLrOAblZLPvVVsTBjIw4KeGWsXh8knl+ZuhgsPpf2VuVSPGbXOjuasFXeOqOrOrLWcP
        WCfx9ybN1ui/RKDw==
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] rcu: enable rcu_normal_after_boot by default for RT
Date:   Tue, 15 Dec 2020 15:16:47 +0100
Message-Id: <20201215141649.796472-4-bigeasy@linutronix.de>
In-Reply-To: <20201215141649.796472-1-bigeasy@linutronix.de>
References: <20201215141649.796472-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Julia Cartwright <julia@ni.com>

The forcing of an expedited grace period is an expensive and very
RT-application unfriendly operation, as it forcibly preempts all running
tasks on CPUs which are preventing the gp from expiring.

By default, as a policy decision, disable the expediting of grace
periods (after boot) on configurations which enable PREEMPT_RT.

Suggested-by: Luiz Capitulino <lcapitulino@redhat.com>
Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/update.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39334d2d2b379..b95ae86c40a7d 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -56,8 +56,10 @@
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
-static int rcu_normal_after_boot;
+static int rcu_normal_after_boot =3D IS_ENABLED(CONFIG_PREEMPT_RT);
+#ifndef CONFIG_PREEMPT_RT
 module_param(rcu_normal_after_boot, int, 0);
+#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
--=20
2.29.2

