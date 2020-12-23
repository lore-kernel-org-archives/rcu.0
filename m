Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EDDC43217
	for <rcu@archiver.kernel.org>; Wed, 23 Dec 2020 02:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B574C22D73
	for <rcu@archiver.kernel.org>; Wed, 23 Dec 2020 02:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgLWCt6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:49:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbgLWCWB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Dec 2020 21:22:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3E86229CA;
        Wed, 23 Dec 2020 02:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690081;
        bh=8aXFr9okvNc7JEuduMQYmGkuL078hXr/6wxsC2UKEUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rf+poYK0XK8XSJPVxKi6WMSZhHd12FrV3Z5kUqmB0tMYL2i/nBKdPSKquxD5QGN+y
         hPtxWL8gnrHsVxzkj0K9cO7XS9cyKGYys7qH/kvjX5/blEQtnzFs66a0tDvNB1SV7p
         hPJEBDJD0dCRgWSspwnnkhRbE4SVYdu/qFs+z5b/mTgztPLhcGAzroVEWsaClXI3d1
         6re3jmdcUU9TWtnXVVMNJLYx5OsmgjxEI0y3w/4g2o3drMBm9mGK1Wz2M+7L3TiXHu
         Gh8CPevXTiP1Hll3sLCNKSAWSYgJdWuJJzb3ycJBC6AMFmSU3RU4DpAVSmJRuq1Q6G
         sn7lqhhpcoQpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/87] rcutorture: Prevent hangs for invalid arguments
Date:   Tue, 22 Dec 2020 21:19:50 -0500
Message-Id: <20201223022103.2792705-14-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022103.2792705-1-sashal@kernel.org>
References: <20201223022103.2792705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 4994684ce10924a0302567c315c91b0a64eeef46 ]

If an rcutorture torture-test run is given a bad kvm.sh argument, the
test will complain to the console, which is good.  What is bad is that
from the user's perspective, it will just hang for the time specified
by the --duration argument.  This commit therefore forces an immediate
kernel shutdown if a rcu_torture_init()-time error occurs, thus avoiding
the appearance of a hang.  It also forces a console splat in this case
to clearly indicate the presence of an error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0b7af7e2bcbb1..79129a91347f0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2134,6 +2134,10 @@ rcu_torture_init(void)
 unwind:
 	torture_init_end();
 	rcu_torture_cleanup();
+	if (shutdown_secs) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
-- 
2.27.0

