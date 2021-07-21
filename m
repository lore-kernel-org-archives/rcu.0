Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A529C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90B261362
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhGUUYI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhGUUYH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51F0261264;
        Wed, 21 Jul 2021 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901483;
        bh=BRCA3cizbBxreJRulOEZaGT1dH+vBvoN0yRwdhOIDXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqjY/CkneNItcKa12J60Xuq2mrGrTF1kYM1PZBkd68l3VxTc8fsEVqFgpqskGPCls
         tzjCqRO1272inrIIrkoJMxzK47COzOD9mjoWZfiKGLgLOZDiNqjzbgrZ9aD9oDkyeZ
         W7DqFsjalpPGm4uNPSUVu/FHOxPZK7Cejdpl/mOBOhi3abaut6e0+AqCDt4sLuRmep
         48CbLY9fdItr7ECvRlE5R8UKPZJcuLPyflz5QH6yPQe0CeTaypL12EgV1G91/B69qj
         oEDrj2yq8HtCrlkl3XH5b8j8RzYpSvjje8zTsqlkxsXbI7RMh/Xg8A4DoJfMQt0x85
         macz8cEv/CXWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 20CF55C0A11; Wed, 21 Jul 2021 14:04:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Jiangong.Han" <jiangong.han@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/7] rcuscale: Console output claims too few grace periods
Date:   Wed, 21 Jul 2021 14:04:37 -0700
Message-Id: <20210721210441.796995-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Jiangong.Han" <jiangong.han@windriver.com>

The rcuscale console output claims N grace periods, numbered from zero
to N, which means that there were really N+1 grace periods.  The root
cause of this bug is that rcu_scale_writer() stores the number of the
last grace period (numbered from zero) into writer_n_durations[me]
instead of the number of grace periods.  This commit therefore assigns
the actual number of grace periods to writer_n_durations[me], and also
makes the corresponding adjustment to the loop outputting per-grace-period
measurements.

Sample of old console output:
    rcu-scale: writer 0 gps: 133
    ......
    rcu-scale:    0 writer-duration:     0 44003961
    rcu-scale:    0 writer-duration:     1 32003582
    ......
    rcu-scale:    0 writer-duration:   132 28004391
    rcu-scale:    0 writer-duration:   133 27996410

Sample of new console output:
    rcu-scale: writer 0 gps: 134
    ......
    rcu-scale:    0 writer-duration:     0 44003961
    rcu-scale:    0 writer-duration:     1 32003582
    ......
    rcu-scale:    0 writer-duration:   132 28004391
    rcu-scale:    0 writer-duration:   133 27996410

Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index dca51fe9c73f2..2cc34a22a5060 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -487,7 +487,7 @@ rcu_scale_writer(void *arg)
 	if (gp_async) {
 		cur_ops->gp_barrier();
 	}
-	writer_n_durations[me] = i_max;
+	writer_n_durations[me] = i_max + 1;
 	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
@@ -561,7 +561,7 @@ rcu_scale_cleanup(void)
 			wdpp = writer_durations[i];
 			if (!wdpp)
 				continue;
-			for (j = 0; j <= writer_n_durations[i]; j++) {
+			for (j = 0; j < writer_n_durations[i]; j++) {
 				wdp = &wdpp[j];
 				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
 					scale_type, SCALE_FLAG,
-- 
2.31.1.189.g2e36527f23

