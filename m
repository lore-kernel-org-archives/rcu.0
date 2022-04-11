Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0103C433F5
	for <rcu@archiver.kernel.org>; Mon, 11 Apr 2022 15:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347702AbiDKPV3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347777AbiDKPV2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Apr 2022 11:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90836625D;
        Mon, 11 Apr 2022 08:19:12 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649690351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NmWU2hHPYbcLm3As00YP4pmz7fm1ZhKTVUH/i4HM8Ic=;
        b=qSzzWZ4RrhqpnxfCqhFGOGjz3b0CAIvjPdrlaR0ULm0096qqQGnbxrgL2pkax/kio3vt+n
        RAi2oJ8owPK17hYfWiPhIdAnpZYPdp4ONCeERMJnrtS9mFWK2x7ABPxh8QIWmSURAI690q
        mqG87unIKfga6k5V2GMwCPOpr9YQQ7hwH121mGGATDg0Ho5c/7eymfM8kpRPLZiVPS5Xk+
        3VWYnJREsCLoCRTlKIaY1/iS0Ti0ky3mmL78DqUAKX+eQPM/9Dop6RBK05Ly4H4aFq0URJ
        iXvAmqphR3hAmf+jpH/pcTTBQxvpgVLnNjtV1CuTRTDw1X+w2Vs0aCzWCvuCZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649690351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NmWU2hHPYbcLm3As00YP4pmz7fm1ZhKTVUH/i4HM8Ic=;
        b=xLRJtSTE6Pn3pdtgiWo0sqPkApwUVzCOS81wSVbR/y4jVPuZfYWCLQdnKuELZECI8zEtUu
        WqyoV9fJsRShhOAQ==
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH] rcu/torture: Change order of warning and trace dump
Date:   Mon, 11 Apr 2022 17:19:03 +0200
Message-Id: <20220411151903.28167-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dumping a big ftrace buffer could lead to a RCU stall. So there is the
ftrace buffer and the stall information which needs to be printed. When
there is additionaly a WARN_ON() which describes the reason for the ftrace
buffer dump and the WARN_ON() is executed _after_ ftrace buffer dump, the
information get lost in the middle of the RCU stall information.

Therefore print WARN_ON() message before dumping the ftrace buffer in
rcu_torture_writer().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 55d049c39608..cbbe37d7701e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1287,8 +1287,8 @@ rcu_torture_writer(void *arg)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) !=
 				    &rcu_tortures[i]) {
-					rcu_ftrace_dump(DUMP_ALL);
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
+					rcu_ftrace_dump(DUMP_ALL);
 				}
 		if (stutter_waited)
 			sched_set_normal(current, oldnice);
-- 
2.20.1

