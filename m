Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A39EC6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4460F61244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhGUTk4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237450AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAF2E61358;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=BKxY760Q0+rm4WqKjHEoXmDIxEOWQtXd1bpJVPxdpAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H164hPdmIF7rWaKoONLGVL2Rr9yWzrw62TBX/WET7LZ7lrjlfw8DmAkVlj3BbbdcU
         2jhGSrdNI9wZ+TXNP5EkxFKeJ4nB8KfTK5DuUOz/QfaMVrSk0i/d/HzNH/HKbVqKbS
         B0pDLI2SEoKhS6+A+wIOcklX9lhS16JcmdcLlHL6+lHtChrczAhE4lvLlYykXVJs2F
         Y0sabhNsqZvRjRXuMbdO54Xo4l3PeAuEz7sxudDxCIdTvk8eqcuctZimAVy50PEm+v
         u6+wIJoT6s6Ha+aYkkqjF41IftFaKvET7WcwcepZgXnCvy9xRsFrGPl+/9cjFTwOa0
         mmRIW6+2dn8zg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 434A35C0C70; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Liu Song <liu.song11@zte.com.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 15/18] rcu: Remove useless "ret" update in rcu_gp_fqs_loop()
Date:   Wed, 21 Jul 2021 13:21:23 -0700
Message-Id: <20210721202127.2129660-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Liu Song <liu.song11@zte.com.cn>

Within rcu_gp_fqs_loop(), the "ret" local variable is set to the
return value from swait_event_idle_timeout_exclusive(), but "ret" is
unconditionally overwritten later in the code.  This commit therefore
removes this useless assignment.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 37bc3a702b6ea..7b65ac3f49e5a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1960,8 +1960,8 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 				       TPS("fqswait"));
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
-		ret = swait_event_idle_timeout_exclusive(
-				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
+		(void)swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
+				 rcu_gp_fqs_check_wake(&gf), j);
 		rcu_gp_torture_wait();
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
 		/* Locking provides needed memory barriers. */
-- 
2.31.1.189.g2e36527f23

