Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3BEC0015E
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGQSBP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGQSBO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FB999;
        Mon, 17 Jul 2023 11:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAF7E611C3;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2568FC433C8;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616872;
        bh=xVhWqN5eTUt3G/KbriOgUta82k5eGkWbLsO5XCSoMTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tM0uuN6VgnjizZ71vBqyLoTzTm8+0MnUxrBU309KsSO1E/YC9yI+2XWOfLkgkoJ8Q
         HGTEGBgjXuFw5SwUMnEyqajvfyTXVq4hoRiF2TzzMX6ZL/XpLmhvyMN1f28PqqCjoq
         EqgwgS32IGiLbQrHAbwFrxloDLifJegD1ZfKqq4PRKB7hRQ3ak5JZxh+yvpl40WUCW
         D5qCwV2p6nB5NW7lwaert+k7Rd8K7PCY6VzJBh5ZSR0r0Cry1U491BLV9B6rIozO+a
         kx7iGN+9DFtyyv1cpSnlgXbtjdlzNQQvcLIkuZQ6ld4UnVozqebFezZ4FV3tSFTyHY
         HSKADhFu8ya6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D11B4CE03F1; Mon, 17 Jul 2023 11:01:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Tycho Andersen <tandersen@netflix.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/7] documentation/rcu: Fix typo
Date:   Mon, 17 Jul 2023 11:01:04 -0700
Message-Id: <20230717180110.1097362-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
References: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Tycho Andersen <tandersen@netflix.com>

s/slat/splat/

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/lockdep-splat.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/lockdep-splat.rst b/Documentation/RCU/lockdep-splat.rst
index 2a5c79db57dc..bcbc4b3c88d7 100644
--- a/Documentation/RCU/lockdep-splat.rst
+++ b/Documentation/RCU/lockdep-splat.rst
@@ -10,7 +10,7 @@ misuses of the RCU API, most notably using one of the rcu_dereference()
 family to access an RCU-protected pointer without the proper protection.
 When such misuse is detected, an lockdep-RCU splat is emitted.
 
-The usual cause of a lockdep-RCU slat is someone accessing an
+The usual cause of a lockdep-RCU splat is someone accessing an
 RCU-protected data structure without either (1) being in the right kind of
 RCU read-side critical section or (2) holding the right update-side lock.
 This problem can therefore be serious: it might result in random memory
-- 
2.40.1

