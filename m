Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F3EB64D9
	for <rcu@archiver.kernel.org>; Sun,  2 Jul 2023 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGBTlA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Jul 2023 15:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjGBTke (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Jul 2023 15:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689A019BA;
        Sun,  2 Jul 2023 12:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 505DC60C75;
        Sun,  2 Jul 2023 19:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398A0C433C8;
        Sun,  2 Jul 2023 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326739;
        bh=g8i1cvnrJTprc6jL7uG9qN1A5swdSdlan7Q+tB1GZx0=;
        h=From:To:Cc:Subject:Date:From;
        b=ONpRnvFRrguJXoSLT2xDVhH/pDZZvgA1rEfPjyu+eqW8sJvWZVDbBeCnju72khSYg
         vyQosulWii110QB5S8Lg2MmjMDLJhuNzDr153B+ztVr1fR7GfAxTzG9er8+aoLx61L
         WFK5GfjYeUdDKhYNyiQ9mS6uQzDSJwyIKJJrHa1EnlR+KtmJ0+gLB1MSyUs66s39rR
         QHuqEHVncIwstngW0TF0JGtcWXbDmsA9LR1ID5tzP06oshfMCVdFlevWaXcyr4OLkm
         E0q061NKDlOzqM+digB/TGhNJiaztk+0JEW604Fajh2CCiKORMuwhw8/02WpsfQY5q
         VYpCi/jq7N4Gg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>, dave@stgolabs.net,
        josh@joshtriplett.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 1/3] refscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Sun,  2 Jul 2023 15:38:53 -0400
Message-Id: <20230702193855.1775909-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 6bc6e6b27524304aadb9c04611ddb1c84dd7617a ]

The ref_scale_shutdown() kthread/function uses wait_event() to wait for
the refscale test to complete.  However, although the read-side tests
are normally extremely fast, there is no law against specifying a very
large value for the refscale.loops module parameter or against having
a slow read-side primitive.  Either way, this might well trigger the
hung-task timeout.

This commit therefore replaces those wait_event() calls with calls to
wait_event_idle(), which do not trigger the hung-task timeout.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index afa3e1a2f6902..1970ce5f22d40 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1031,7 +1031,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
-- 
2.39.2

