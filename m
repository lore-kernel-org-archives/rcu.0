Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE28C63797
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8996128E
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbhGUTkz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237346AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A76E861357;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=QhuNcsunZD2QYw6aN/2PjhF7hYYh0BTHMfQNysrs8x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+azx71pU4jAYLhP++cXgQ7IP6GXrStmWvO5i03OCs6y5OoAb2KzDvBrEysUj1Ihb
         8Zi1yKpGXzjR07p7cM50EnZApUW0l9pt2uGI8ngoiIgPRTv0YGcKZWvzbR+jocozHM
         031cVGWeKaNmK5ECRzk4PBGWaZpItdfcQsfxuy1x5u6UiO6etZhwSt5cVpYiNNs1PY
         V8/V154E9bL9wik18M/u4KJ0GZ3BvNXOvJ/L1UizNQEFzLBU4jSdKWHEBCfygQokMO
         rVfp+w30LueQkMTHShz1EtwK0Ham3NSgHwV5A6rRy2k8oUPSwyzXTWNHPSmRXGWU2m
         GDhEQBOiCGJTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 26D025C0E45; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH rcu 09/18] rcu: Start timing stall repetitions after warning complete
Date:   Wed, 21 Jul 2021 13:21:17 -0700
Message-Id: <20210721202127.2129660-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Systems with low-bandwidth consoles can have very large printk()
latencies, and on such systems it makes no sense to have the next RCU CPU
stall warning message start output before the prior message completed.
This commit therefore sets the time of the next stall only after the
prints have completed.  While printing, the time of the next stall
message is set to ULONG_MAX/2 jiffies into the future.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index e199022dce9dc..42847caa3909b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -647,6 +647,7 @@ static void print_cpu_stall(unsigned long gps)
 
 static void check_cpu_stall(struct rcu_data *rdp)
 {
+	bool didstall = false;
 	unsigned long gs1;
 	unsigned long gs2;
 	unsigned long gps;
@@ -692,7 +693,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    ULONG_CMP_GE(gps, js))
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
-	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
+	jn = jiffies + ULONG_MAX / 2;
 	if (rcu_gp_in_progress() &&
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
@@ -709,6 +710,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		print_cpu_stall(gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
+		didstall = true;
 
 	} else if (rcu_gp_in_progress() &&
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
@@ -726,6 +728,11 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
+		didstall = true;
+	}
+	if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {
+		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
+		WRITE_ONCE(rcu_state.jiffies_stall, jn);
 	}
 }
 
-- 
2.31.1.189.g2e36527f23

