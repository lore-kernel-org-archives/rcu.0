Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43095C433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2493361606
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEKXEq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXEp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:04:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A34561624;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774218;
        bh=SnoTqLlOBPMMzpTGhpvw3NJXjbQq0YDaTwokbU3jtas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oH6Rhea5qX9FLmV8CC1gRnI8451aedMCt/bskZC40WBRGbWtcy+Q6dBxOMfTO+h8H
         5cNlOSnOCqzy/O3h3TKHHjP2pArmxDsrPF9p8jKxdR0aiRKkpXMBoCjvYMdXUF4rzz
         uEaqCAB3SmqJwv0xSTHhqA1gFgDLL6NARbAoTA8d7eVe7THjv3TP5kSU0HHuaf059Z
         g7y1iVXQnbvgBFCIpzTEmj4G6Aqa+ny4uHh6jJA5m8xUpVt1yd8JoxnKwR3msbYUkE
         P2F0S2Qlc02ijo/NtyKcd3px1xsjA7Jl9rUh8DtbZMM4O+G9zNHUzRIIBFoG1ndf8I
         S71wjhIo+70RA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F39C5C0B55; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH tip/core/rcu 04/10] rcu/nocb: Allow de-offloading rdp leader
Date:   Tue, 11 May 2021 16:03:30 -0700
Message-Id: <20210511230336.2894314-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The only thing that prevented an rdp leader from being de-offloaded was
the nocb_bypass_timer that used to lock the nocb_lock of the rdp leader.

If an rdp gets de-offloaded, it will subtlely ignore rcu_nocb_lock()
calls and do its job in the timer unsafely.  Worse yet:  If it gets
re-offloaded in the middle of the timer, rcu_nocb_unlock() would try to
unlock, leaving it imbalanced.

Now that the nocb_bypass_timer doesn't use the nocb_lock anymore,
de-offloading the rdp leader is now safe.  This commit therefore allows
the rdp leader to be de-offloaded.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 82e9ffb92347..015adec5bdc5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2489,10 +2489,6 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	if (rdp == rdp->nocb_gp_rdp) {
-		pr_info("Can't deoffload an rdp GP leader (yet)\n");
-		return -EINVAL;
-	}
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
 	if (rcu_rdp_is_offloaded(rdp)) {
-- 
2.31.1.189.g2e36527f23

