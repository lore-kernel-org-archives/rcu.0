Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC851C4167D
	for <rcu@archiver.kernel.org>; Wed, 19 Oct 2022 22:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiJSWwE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJSWvx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485918F27F;
        Wed, 19 Oct 2022 15:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E64C6619E8;
        Wed, 19 Oct 2022 22:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388EAC43156;
        Wed, 19 Oct 2022 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219907;
        bh=RL61tOwimeBcU4/Vfql47BzA0BOTvlir0vUZt/Njig0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cz96/20x4CieacmsCHfXGXf22cmpZZpQLoV+8usewU9hRJspL4ooU4Pxu+9K2EXFG
         mThTNKGqTjG0TsUKUUP6pEm9Cxl30fEpyAc2cGXKnIWr9glas7ieDnYS7IQXpa46wJ
         awcwKw4A3BWg1cHTtQRUSF5K4E6ltIQchbyCjLYldvtCQ2lzmUP2eC79z0MSn5Js6B
         xpxY2fV7hzdeYwOirjrx7tgVucLlQ3std5DSee86C1q8BAAoW9PVnISsiefYWcGcQZ
         Y2sXBgwD57W+E6szViTyIj6EfdmMOcaBG3SmJ4dr92rbvolD2jNTKCDwxVHbwzu6Az
         0T7v05UiCo7JA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8ED6C5C0F19; Wed, 19 Oct 2022 15:51:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/14] rxrpc: Use call_rcu_flush() instead of call_rcu()
Date:   Wed, 19 Oct 2022 15:51:44 -0700
Message-Id: <20221019225144.2500095-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

call_rcu() changes to save power may cause slowness. Use the
call_rcu_flush() API instead which reverts to the old behavior.

We find this via inspection that the RCU callback does a wakeup of a
thread. This usually indicates that something is waiting on it. To be
safe, let us use call_rcu_flush() here instead.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 net/rxrpc/conn_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 22089e37e97f0..fdcfb509cc443 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -253,7 +253,7 @@ void rxrpc_kill_connection(struct rxrpc_connection *conn)
 	 * must carry a ref on the connection to prevent us getting here whilst
 	 * it is queued or running.
 	 */
-	call_rcu(&conn->rcu, rxrpc_destroy_connection);
+	call_rcu_flush(&conn->rcu, rxrpc_destroy_connection);
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

