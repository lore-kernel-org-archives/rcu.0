Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A189C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51084610D1
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhIOXnE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233034AbhIOXnD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 231306105A;
        Wed, 15 Sep 2021 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749304;
        bh=eNDxbvC/Ny0/oBeHtJWiZ0bdQ1QyTw8WO6B9CY82jW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBdIEB4JTMMTaS/8aElRn+3ygpouxm14GbZ+232lbqR2Qh7khGXeWS6P0NeKNgdc0
         Jlm5YFEpSHDaAZ3PIHOqfD9OxKMq7ivvj1F4Y6C/K1NIP5+NontLGfxKcDLkPXYJLO
         jgTp1KrcwfdZn3Elbq3iDF9T0RrVydpy9GiuhyO6725ctb4aHBYbo9A9g+ReP+GMyR
         +Er9KG6j5J+hIdVYUSpFsMSfXCc85hkz+r/WuT2WxSS3QYqof/ttaRo6ggwsVjHLxB
         YNm28VtHAyP/HoJdZkoIM+6pZAu5vxXmqX1UDyFQmxaijbDJ037JTDqbYgqqSOkf4z
         XeMrESdrUhQGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE01F5C0926; Wed, 15 Sep 2021 16:41:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/5] scftorture: Warn on individual scf_torture_init() error conditions
Date:   Wed, 15 Sep 2021 16:41:41 -0700
Message-Id: <20210915234141.3907301-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When running scftorture as a module, any scf_torture_init() issues will be
reflected in the error code from modprobe or insmod, as the case may be.
However, these error codes are not available when running scftorture
built-in, for example, when using the kvm.sh script.  This commit
therefore adds WARN_ON_ONCE() to allow distinguishing scf_torture_init()
errors when running scftorture built-in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 00bba2bdd4d1..5d42f44e3e1a 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -606,17 +606,17 @@ static int __init scf_torture_init(void)
 
 	if (onoff_interval > 0) {
 		firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval, NULL);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (shutdown_secs > 0) {
 		firsterr = torture_shutdown_init(shutdown_secs, scf_torture_cleanup);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (stutter > 0) {
 		firsterr = torture_stutter_init(stutter, stutter);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 
@@ -637,12 +637,12 @@ static int __init scf_torture_init(void)
 		scf_stats_p[i].cpu = i;
 		firsterr = torture_create_kthread(scftorture_invoker, (void *)&scf_stats_p[i],
 						  scf_stats_p[i].task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(scf_torture_stats, NULL, scf_torture_stats_task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 
-- 
2.31.1.189.g2e36527f23

