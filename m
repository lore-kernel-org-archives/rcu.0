Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B2ECDB483
	for <rcu@archiver.kernel.org>; Fri, 13 Oct 2023 12:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjJMMAo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Oct 2023 08:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjJMMAP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Oct 2023 08:00:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7471718;
        Fri, 13 Oct 2023 04:59:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676A5C433CD;
        Fri, 13 Oct 2023 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198394;
        bh=DWCRnZosrwhCtgibC90qwLkqDfB/lV91PpsutuxykGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWNbhv1UYD+5FMyjhsmroXXEl7ntF14NZ9IwxNXCXTG0hNaWAryF9wCiKDUblKWMq
         HlgU2pVpNeEqJv0fmRrCbjc2REyUxDiZXY9HMyz/fJ+qmdsvxoFR7i2u4/IMyRdgKV
         fYLKDiC+z5G8cDs2TVuCkVWV1XZndocU9EJ5mFuOVIBM30sRZss9yjeOPuq69SKfT+
         S333nwDOFbqbuahG/VeBrus6DJaTmG+A0hyzANKLfsviFV50AMj9CLiqF0dlV1Yspa
         6DQa4vEewIsK0+2A9BmMP23lnzbgPDNYodygKD2ecGbf0xZpgy0Ph7wTZ/5T6w4yGy
         GE1NfHOtmJyeg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 16/18] rcu: Comment why callbacks migration can't wait for CPUHP_RCUTREE_PREP
Date:   Fri, 13 Oct 2023 13:59:00 +0200
Message-Id: <20231013115902.1059735-17-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The callbacks migration is performed through an explicit call from
the hotplug control CPU right after the death of the target CPU and
before proceeding with the CPUHP_ teardown functions.

This is unusual but necessary and yet uncommented. Summarize the reason
as explained in the changelog of:

	a58163d8ca2c (rcu: Migrate callbacks earlier in the CPU-offline timeline)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2491766e1fd5..3b9d5c7eb4a2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1372,7 +1372,14 @@ static int takedown_cpu(unsigned int cpu)
 	cpuhp_bp_sync_dead(cpu);
 
 	tick_cleanup_dead_cpu(cpu);
+
+	/*
+	 * Callbacks must be re-integrated right away to the RCU state machine.
+	 * Otherwise an RCU callback could block a further teardown function
+	 * waiting for its completion.
+	 */
 	rcutree_migrate_callbacks(cpu);
+
 	return 0;
 }
 
-- 
2.34.1

