Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57ABC35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75281206CC
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727314;
	bh=8Kxm3zyAZ3fmYD0WfbKmxTzytBdFkh6lWSPKacF2s0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kgH83/lOisExqOJJusLJ+doTQRHdyPn03CG2ruIEo049ivR2Vw7Sqd1rU3nu7xZ+j
	 ruia1FaPiK9caGNVD3Lj3ziWro8d/fOQHwgvWBLmqZWHbgHiw5LGsPLjVcnTCGhyPR
	 RF4FTj7btZkD7JAs0ipSlxXea+wmT6yVUGbizm2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBOAly (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:41:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:53 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2305A222C4;
        Sat, 15 Feb 2020 00:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727313;
        bh=8Kxm3zyAZ3fmYD0WfbKmxTzytBdFkh6lWSPKacF2s0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/PDvtCIpq7PWjm7ixuyovbCCGsSAnJGJX/pftT6d7bJ2Xo6zyCm1xifW9MfN/k4/
         LK9UAbduoISJy3JNjIEW9rGCi4Lnox2rrsQ2zkJ+898UT42rCVOy/3wLk3m4mdR7XE
         P63TmHc32Chm2Ugg//FNKzrTimXcl8JYQ+J+JeyE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/18] rcutorture: Add READ_ONCE() to rcu_torture_count and rcu_torture_batch
Date:   Fri, 14 Feb 2020 16:41:20 -0800
Message-Id: <20200215004125.16953-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcutorture rcu_torture_count and rcu_torture_batch per-CPU variables
are read locklessly, so this commit adds the READ_ONCE() to a load in
order to avoid various types of compiler vandalism^Woptimization.

This data race was reported by KCSAN. Not appropriate for backporting
due to failure being unlikely and due to this being rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 124160a..0b9ce9a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1413,8 +1413,8 @@ rcu_torture_stats_print(void)
 
 	for_each_possible_cpu(cpu) {
 		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
-			pipesummary[i] += per_cpu(rcu_torture_count, cpu)[i];
-			batchsummary[i] += per_cpu(rcu_torture_batch, cpu)[i];
+			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
+			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
 	}
 	for (i = RCU_TORTURE_PIPE_LEN - 1; i >= 0; i--) {
-- 
2.9.5

