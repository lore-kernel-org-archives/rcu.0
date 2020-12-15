Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DFEC2BB48
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C358D224D2
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgLOORm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgLOORj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 09:17:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D081C0617A7
        for <rcu@vger.kernel.org>; Tue, 15 Dec 2020 06:16:59 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608041817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULkU1PcbpU2l78G0960G5T5ULxU0eHA7I68Bh4WAkAs=;
        b=2N8vwfNesIbjMsnaZv1Pa641cJW2CutAPno9ssCZehFw+hU283saN7357z/MisfuQ7l5pE
        WQzvh5NdNg9GJWJYhHWJf5BvO79E3HaXbEEHxq8geZZdLLI98UYc40r27CQevc/g1skPCw
        Aupd//h+OcNCKdE6u+Ok+/XQg93Bf4jukka7B4Vlniu5oPvDWAoWJwNUZGvzdCx7jqUOw2
        JzyRALXGL07ohgS0vl92SNtrsmV4AqM2lgcbeWzd55SiF3N1zUo/ZJ7AzSQHUrcgOg4YaA
        kizra7Cg2RmDoKYHeLk4fEim0Wz4jxPv59Ta+5qpdlNFiC9UZCcXacwESQBBUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608041817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULkU1PcbpU2l78G0960G5T5ULxU0eHA7I68Bh4WAkAs=;
        b=Vx+awOVGxDrnLs+DfoOVhaaSmR3a3nOBWx5XeOeHG6FT5LyMn1T2SIN2XWzKMNG654USX0
        kGZFF6uveYUiIhCQ==
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/5] rcu: make RCU_BOOST default on CONFIG_PREEMPT_RT
Date:   Tue, 15 Dec 2020 15:16:45 +0100
Message-Id: <20201215141649.796472-2-bigeasy@linutronix.de>
In-Reply-To: <20201215141649.796472-1-bigeasy@linutronix.de>
References: <20201215141649.796472-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

With RCU callbacks deferred to the `rcuc' thread it is more likely that
people run into OOM if the RCU reader or the thread is stalled for too
long and RCU can't continue its work.
On PREEMPT_RT this is more likely because the amount of RT tasks is
higher and the general workload involves more RT tasks.

Make RCU_BOOST default on PREEMPT_RT to ease the configuration. It can
be still disabled if someone knows better.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index cdc57b4f6d48a..aa8cc8c977e78 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -188,8 +188,8 @@ config RCU_FAST_NO_HZ
=20
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
-	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
-	default n
+	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT
+	default y if PREEMPT_RT
 	help
 	  This option boosts the priority of preempted RCU readers that
 	  block the current preemptible RCU grace period for too long.
--=20
2.29.2

