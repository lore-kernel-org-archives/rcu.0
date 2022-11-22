Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810EC43217
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 01:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiKVBEc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiKVBE0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Nov 2022 20:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB81E711;
        Mon, 21 Nov 2022 17:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0FB8B818E7;
        Tue, 22 Nov 2022 01:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6D6C43152;
        Tue, 22 Nov 2022 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669079063;
        bh=uyDGWyzfPaiQ/+Iwibul18/2tA5ta5E2a9H+CSNE/yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFD1MnASm3nHVWtRNYrL1YNSkJ5NsCu6EMrtc9wT9RYHFupnOEhBIAelJJBkbzfGL
         seRGP7i+PbVg1o0P3F1yYAPd3lyPeCP89i7G3HCyh1Yv2OdZmtWtWY2D7lQ6m2ik6S
         tTy8OF9izkP9LALFdQy2sxTkMETa6y9JhV0xijdnV7JSV0nk1zGEAM4OispMp4zXi2
         20ag4F1cNLMmHLWWwfLlY+W9hIoK+z4kDZR0I9gS0SoA9wxDdH6r7XvH6mtchSbpcD
         DKKtg8DLBSgLnq7hdM6bn6h1dGUIgGSqhWoppMo0DBYToKWLv5JVS5Z2JO1tePUUKi
         cwSGc+lBsYzHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 814A35C1409; Mon, 21 Nov 2022 17:04:22 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 rcu 09/16] rcu/sync: Use call_rcu_flush() instead of call_rcu
Date:   Mon, 21 Nov 2022 17:04:14 -0800
Message-Id: <20221122010421.3799681-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

call_rcu() changes to save power will slow down rcu sync. Use the
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 5cefc702158fe..bdce3b5d7f714 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -44,7 +44,7 @@ static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
 {
-	call_rcu(&rsp->cb_head, rcu_sync_func);
+	call_rcu_flush(&rsp->cb_head, rcu_sync_func);
 }
 
 /**
-- 
2.31.1.189.g2e36527f23

