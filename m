Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BC4C46467
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjAEAuj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjAEAuS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673D4A958;
        Wed,  4 Jan 2023 16:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFEAA6189B;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA6AC433F0;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879503;
        bh=p1n9Oin+2YJ+fvK62lOQ034ZZbRWfu52tpQVaVSIkgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLorTwpXRP7RHiZKX9ilE9mVj9i5l3CORa+QRtRWE+Kx19J2SebW01pokDz4o6JEh
         MyvcQSJiy9wvDjZ/1T1BD2qQywHYDCI1X/yX+iD/Zu/LgP2ae3GHqJoyz0nxY6bMvn
         u8v6y0E9SbbMkH3WfR3zMp/fv65Y5+UFSPch+dQ1o3bx9CSxtUS7E89ZxDcoPzwyuO
         XSVB30zD+a/KEYDOwl2riDc2/PQEtO060vXa8t4UxYzqKiFJVDkPo+BRhnFk5JcCtJ
         +qD7rLianEGQEq7SYsmxTv9EesqnLQKR2XKR4Hm/UhGclpTlIGZf8ZW9bIWEnSGckA
         w6sBAi480clcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DAE285C086D; Wed,  4 Jan 2023 16:45:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/7] torture: Seed torture_random_state on CPU
Date:   Wed,  4 Jan 2023 16:44:50 -0800
Message-Id: <20230105004501.1771332-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The DEFINE_TORTURE_RANDOM_PERCPU() macro defines per-CPU random-number
generators for torture testing, but the seeds for each CPU's instance
will be identical if they are first used at the same time.  This commit
therefore adds the CPU number to the mix when reseeding.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 789aeb0e1159c..29afc62f2bfec 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -450,7 +450,7 @@ unsigned long
 torture_random(struct torture_random_state *trsp)
 {
 	if (--trsp->trs_count < 0) {
-		trsp->trs_state += (unsigned long)local_clock();
+		trsp->trs_state += (unsigned long)local_clock() + raw_smp_processor_id();
 		trsp->trs_count = TORTURE_RANDOM_REFRESH;
 	}
 	trsp->trs_state = trsp->trs_state * TORTURE_RANDOM_MULT +
-- 
2.31.1.189.g2e36527f23

