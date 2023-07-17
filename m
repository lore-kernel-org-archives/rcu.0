Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A1EB64DC
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjGQSUy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGQSUv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84939A1;
        Mon, 17 Jul 2023 11:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F94611F5;
        Mon, 17 Jul 2023 18:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4B6C43395;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618044;
        bh=XDuRFq+mHkr5+XpHsV+2nDbFWbS9cEpeXF9JX6lizsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0wuZpGJ7JN1bE4+fsoi2u1d+PL8FRvgU4yt0JU5sf6WcLvJHULSxnr3gCQmFdGZ6
         xBGkY+hsNjQvzjEc3JYU7cDtdbKeHlhnRAYYZnWD/lX3YGwHNYHv6VXN0PcnWM2Xtf
         H1PJKsIRf3V97vgU3YHzjFZpYC8mPKOjk4LQ0sLZpd/4ArSr6curreirh3x6haq4lF
         cmV60F2/THlsq/nOkIpSFdgOOMD4ROjYUmrD3G6eyNof3xt7+x3+tIgK7j4ow0t8+i
         zjBPt65uOHrtzW1YVxnteQU/qA/z7cZIxzrVwSWOViRB173qvBxq82+v3K+ih6kRNJ
         LfkBxG3mWJ5tQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D205CE097F; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 9/9] rcutorture: Stop right-shifting torture_random() return values
Date:   Mon, 17 Jul 2023 11:20:42 -0700
Message-Id: <20230717182042.1098651-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Now that torture_random() uses swahw32(), its callers no longer see
not-so-random low-order bits, as these are now swapped up into the upper
16 bits of the torture_random() function's return value.  This commit
therefore removes the right-shifting of torture_random() return values.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d291a1438c30..ade42d6a9d9b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1877,7 +1877,7 @@ static int
 rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 {
 	int mask = rcutorture_extend_mask_max();
-	unsigned long randmask1 = torture_random(trsp) >> 8;
+	unsigned long randmask1 = torture_random(trsp);
 	unsigned long randmask2 = randmask1 >> 3;
 	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
 	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
@@ -1936,7 +1936,7 @@ rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
 	if (!((mask - 1) & mask))
 		return rtrsp;  /* Current RCU reader not extendable. */
 	/* Bias towards larger numbers of loops. */
-	i = (torture_random(trsp) >> 3);
+	i = torture_random(trsp);
 	i = ((i | (i >> 3)) & RCUTORTURE_RDR_MAX_LOOPS) + 1;
 	for (j = 0; j < i; j++) {
 		mask = rcutorture_extend_mask(*readstate, trsp);
@@ -2137,7 +2137,7 @@ static int rcu_nocb_toggle(void *arg)
 		toggle_fuzz = NSEC_PER_USEC;
 	do {
 		r = torture_random(&rand);
-		cpu = (r >> 4) % (maxcpu + 1);
+		cpu = (r >> 1) % (maxcpu + 1);
 		if (r & 0x1) {
 			rcu_nocb_cpu_offload(cpu);
 			atomic_long_inc(&n_nocb_offload);
-- 
2.40.1

