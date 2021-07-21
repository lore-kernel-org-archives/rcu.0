Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233EEC6377E
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A20261244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbhGUTlA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240365AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6CFC6135F;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=FfhUhy89/u3Y2WYri9XqTocli/05xvUKwKukL+25oAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCpuYZOu/1Bf55Mc+JMKG3ZmEnX2fKIZ0sD4zqLCyXQrcKiYuyEzFT0NRVL3x7pbl
         FrrRxOV3Si1sMt/OmCKxNL/coyhX5+SNyM9x3nZY6dAuxIljdSHIbW8Vw5wL9B5jqi
         064310HAthpcbKQ2CKndvZd8URJDdaYHY2O6Q7iBw12S9n0Pv92tt49/fdl+PLnKWf
         c71cN/HD2X3dvFx92FtOkBiCPeNECxerWEdZKu4IXqJruhpVGEGxwN7mkPzkU7SZHp
         a1BxL6GPhCiRXPFNC3lLuegRtHMpBa14cvUOQksBh0BCbBzGU9DUlLE3qZdAUYEf2T
         1cUA2MCK0a6vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4651F5C0FA2; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH rcu 12/18] rcu: Make rcu_gp_init() and rcu_gp_fqs_loop noinline to conserve stack
Date:   Wed, 21 Jul 2021 13:21:20 -0700
Message-Id: <20210721202127.2129660-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The kbuild test project found an oversized stack frame in rcu_gp_kthread()
for some kernel configurations.  This oversizing was due to a very large
amount of inlining, which is unnecessary due to the fact that this code
executes infrequently.  This commit therefore marks rcu_gp_init() and
rcu_gp_fqs_loop noinline_for_stack to conserve stack space.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Rong Chen <rong.a.chen@intel.com>
[ paulmck: noinline_for_stack per Nathan Chancellor. ]
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bc6ccf0ba3b24..e472c78036011 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1739,7 +1739,7 @@ static void rcu_strict_gp_boundary(void *unused)
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
-static bool rcu_gp_init(void)
+static noinline_for_stack bool rcu_gp_init(void)
 {
 	unsigned long firstseq;
 	unsigned long flags;
@@ -1933,7 +1933,7 @@ static void rcu_gp_fqs(bool first_time)
 /*
  * Loop doing repeated quiescent-state forcing until the grace period ends.
  */
-static void rcu_gp_fqs_loop(void)
+static noinline_for_stack void rcu_gp_fqs_loop(void)
 {
 	bool first_gp_fqs;
 	int gf = 0;
-- 
2.31.1.189.g2e36527f23

