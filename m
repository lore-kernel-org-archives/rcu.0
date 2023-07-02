Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDE1C001DD
	for <rcu@archiver.kernel.org>; Sun,  2 Jul 2023 19:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjGBTkU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Jul 2023 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjGBTkO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Jul 2023 15:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014210DE;
        Sun,  2 Jul 2023 12:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4460860CBB;
        Sun,  2 Jul 2023 19:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C226C433C8;
        Sun,  2 Jul 2023 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326759;
        bh=OU6c1TPuGPZuBbKgCP2iz/IdtmI8ALFFeo0Kvdv/Xfk=;
        h=From:To:Cc:Subject:Date:From;
        b=XUVHIRa/gBiqeNnO2JQiMDA7p4PHfz+TV6X1GTQK9azlnadsRPMri8hhCKmV9u9ug
         ZkV0B8w9Lqs+2iLbUsUF2S+hf3/WPm/VkJS78zZ2LmiS08cmXdfAsJUjZ/Sk+jus3c
         xkynVlGPHuFitKOxKj7IU7lq6ZL9cmF5BEmQKWmHDxpnn8xeOXig2Dea2JYxcmtmNI
         aAyXbeyNNkAWoJ9vHB4UrtiEKKMrgLQXcs1qltzJ6p43vBMP9/CzMVqCYwksRSpxOI
         nNK+cUOBHLCqGqxEwrL1Muu9Wr5J5D4ToiA7YiWaulqccpEPJ9ZkNuQ3zLGIxcat9+
         ECMmP6k3E6AXg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>, dave@stgolabs.net,
        josh@joshtriplett.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/2] refscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Sun,  2 Jul 2023 15:39:15 -0400
Message-Id: <20230702193916.1776226-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
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
index 952595c678b37..4e419ca6d6114 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -625,7 +625,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
-- 
2.39.2

