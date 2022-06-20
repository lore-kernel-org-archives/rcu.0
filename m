Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1364CCA47C
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 23:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbiFTXMN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346790AbiFTXLt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 19:11:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464626135;
        Mon, 20 Jun 2022 16:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7455B8125A;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926A6C341C4;
        Mon, 20 Jun 2022 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766631;
        bh=ZVejpdvjiEzycawhaOOnxLRps1g1Vw9+JCtNa1JMx9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3roUHt24laqwZmqI1xvHPeT3YwiBpsNq4jG28Ba1+/keE/dLW+96AKw4BsmQHRQe
         LMXD6KkuxUnw5CE0QcQBG4aEtbsFSnVhAazm0QfTx9AxoZqE4mHvpolY0Ju8ufzIGX
         tthP8HomN97pe3BNS5xxlY1X8gUEt3R4APt+J27FQumgXdSGnNCnEgS8CX3NcOsQi0
         AHwQlzSMDPhiuTLpRUodvYI07Ply3BooyGIw1KLfR5ol9SPaUCTE24j6BCpA3/1TjZ
         NkceKrA2EvvdDjWlZc+ikMCO2l0CCtYc+qOr18j9kvLODW9BhxCyBUwXN6xgVSNd0n
         aAHx2jusI3i8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4CF405C05C8; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: [PATCH rcu 02/23] rcu: Apply noinstr to rcu_idle_enter() and rcu_idle_exit()
Date:   Mon, 20 Jun 2022 16:10:08 -0700
Message-Id: <20220620231029.3844583-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit applies the "noinstr" tag to the rcu_idle_enter() and
rcu_idle_exit() functions, which are invoked from portions of the idle
loop that cannot be instrumented.  These tags require reworking the
rcu_eqs_enter() and rcu_eqs_exit() functions that these two functions
invoke in order to cause them to use normal assertions rather than
lockdep.  In addition, within rcu_idle_exit(), the raw versions of
local_irq_save() and local_irq_restore() are used, again to avoid issues
with lockdep in uninstrumented code.

This patch is based in part on an earlier patch by Jiri Olsa, discussions
with Peter Zijlstra and Frederic Weisbecker, earlier changes by Thomas
Gleixner, and off-list discussions with Yonghong Song.

Link: https://lore.kernel.org/lkml/20220515203653.4039075-1-jolsa@kernel.org/
Reported-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Yonghong Song <yhs@fb.com>
---
 kernel/rcu/tree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c25ba442044a6..9a5edab5558c9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -631,8 +631,8 @@ static noinstr void rcu_eqs_enter(bool user)
 		return;
 	}
 
-	lockdep_assert_irqs_disabled();
 	instrumentation_begin();
+	lockdep_assert_irqs_disabled();
 	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
@@ -659,9 +659,9 @@ static noinstr void rcu_eqs_enter(bool user)
  * If you add or remove a call to rcu_idle_enter(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_idle_enter(void)
+void noinstr rcu_idle_enter(void)
 {
-	lockdep_assert_irqs_disabled();
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	rcu_eqs_enter(false);
 }
 EXPORT_SYMBOL_GPL(rcu_idle_enter);
@@ -861,7 +861,7 @@ static void noinstr rcu_eqs_exit(bool user)
 	struct rcu_data *rdp;
 	long oldval;
 
-	lockdep_assert_irqs_disabled();
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	rdp = this_cpu_ptr(&rcu_data);
 	oldval = rdp->dynticks_nesting;
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
@@ -896,13 +896,13 @@ static void noinstr rcu_eqs_exit(bool user)
  * If you add or remove a call to rcu_idle_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_idle_exit(void)
+void noinstr rcu_idle_exit(void)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	rcu_eqs_exit(false);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(rcu_idle_exit);
 
-- 
2.31.1.189.g2e36527f23

