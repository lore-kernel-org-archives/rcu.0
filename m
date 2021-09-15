Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1150DC433F5
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E472061101
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhIOXnE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhIOXnD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 251AA60527;
        Wed, 15 Sep 2021 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749304;
        bh=MJS3GnPbCWccucd2X6EOTL/cfmSRpQjcBUOzKM74s3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9Eve+Sds6fquiYDRPD9N6gUdHHvgnGC/zvAIa5m8OmJ2yMcauItdis5iD49v9Dqn
         PL/1dulty9AgifF+2dm+pb2m5M6zlkjRflHtv6B7loBPB0iyQzwkSDgGHhsbVUiiXB
         9+XXWV7r2XkpI2Bo1eDNms1dPFQuGCE+xn7qGu7xxkURPb+TiwjEXacr2W5/4yIT1F
         /WTsMkKzO77WaeDaKFbBj9NGEzYXrsUDMJfFY7Qvc2imfFsuLYwvSnK0moOSQ3OwRu
         CvzkQlPZYQrO/wKc0pQrkTuWFEo7lh6DompPqity4zb+7Rw4yba8xGtJtli+WTl7EL
         81Bh1XoBSsyLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E9D465C08DB; Wed, 15 Sep 2021 16:41:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] scftorture: Account for weight_resched when checking for all zeroes
Date:   Wed, 15 Sep 2021 16:41:39 -0700
Message-Id: <20210915234141.3907301-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The "all zero weights makes no sense" error is emitted even when
scftorture.weight_resched is non-zero because it was left out of
the enclosing "if" condition.  This commit adds it in.

Fixes: 1ac78b49d61d4 ("scftorture: Add an alternative IPI vector")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 31b458b3b113..74348abc792b 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -583,8 +583,8 @@ static int __init scf_torture_init(void)
 		if (weight_all_wait == -1)
 			weight_all_wait1 = 0;
 	}
-	if (weight_single1 == 0 && weight_single_rpc1 == 0 && weight_single_wait1 == 0 &&
-	    weight_many1 == 0 && weight_many_wait1 == 0 &&
+	if (weight_resched1 == 0 && weight_single1 == 0 && weight_single_rpc1 == 0 &&
+	    weight_single_wait1 == 0 && weight_many1 == 0 && weight_many_wait1 == 0 &&
 	    weight_all1 == 0 && weight_all_wait1 == 0) {
 		VERBOSE_SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
 		firsterr = -EINVAL;
-- 
2.31.1.189.g2e36527f23

