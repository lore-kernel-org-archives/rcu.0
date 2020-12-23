Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD29C43381
	for <rcu@archiver.kernel.org>; Wed, 23 Dec 2020 03:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3903F207B1
	for <rcu@archiver.kernel.org>; Wed, 23 Dec 2020 03:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgLWDKd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Dec 2020 22:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgLWCS0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Dec 2020 21:18:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA9192336D;
        Wed, 23 Dec 2020 02:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608689843;
        bh=2cnefVCPz8PbbbG4hHhsXluf8g54FTpfNw1fDCftVso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzBLMp9B2OLJEEC+/KroQAhQhtmIby6IVM/zhbauAjn2/cYqGMRxSvmn+LbPz3PwU
         2kmD7Tbu0upGNH7mGtTVUpRL2ePimlk1gPGccNwt37OAU7HiRi41ggoW5NrJLNQW1I
         fQ+5w7KKvvWa1xgLshaXkUAh6sRcBYkWX6nBHOs4XYUMT7K1ehmR4vw14rhHC2FblT
         NR/oSdhOHVEcw7sQTsPzpNXkoFdQ4aYIVGN1ZjH1UsL3O61t5NXjrbs5RLc7XGm10i
         8xvsj1TwjfC6J6RSTZlFbMTBxsz2NJEPdpib99h4tomXtwzRJR9odNgCLlIHvLtYSA
         cEDlTfuB0zXTA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 043/217] rcuscale: Prevent hangs for invalid arguments
Date:   Tue, 22 Dec 2020 21:13:32 -0500
Message-Id: <20201223021626.2790791-43-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021626.2790791-1-sashal@kernel.org>
References: <20201223021626.2790791-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 2f2214d43ccd27ac6d124287107c136a0f7c6053 ]

If an rcuscale torture-test run is given a bad kvm.sh argument, the
test will complain to the console, which is good.  What is bad is that
from the user's perspective, it will just hang for the time specified
by the --duration argument.  This commit therefore forces an immediate
kernel shutdown if a rcu_scale_init()-time error occurs, thus avoiding
the appearance of a hang.  It also forces a console splat in this case
to clearly indicate the presence of an error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcuscale.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 2819b95479af9..c7b6529a0c39f 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -772,7 +772,6 @@ rcu_scale_init(void)
 		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -846,6 +845,10 @@ rcu_scale_init(void)
 unwind:
 	torture_init_end();
 	rcu_scale_cleanup();
+	if (shutdown) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
-- 
2.27.0

