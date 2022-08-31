Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F6ECAAD1
	for <rcu@archiver.kernel.org>; Wed, 31 Aug 2022 18:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiHaSTS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiHaSSx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 Aug 2022 14:18:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789398C8D;
        Wed, 31 Aug 2022 11:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11A97B82275;
        Wed, 31 Aug 2022 18:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8537C433D6;
        Wed, 31 Aug 2022 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969677;
        bh=cBcYSQi8ifVtJhthmgoriB/jVUKxKquenaTa9fU58ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utpCE3dqLooqWsoJE0FtXdY71lLKblks6OSe0OfUgCH7zg3s5IMnh9unnOrtphCO6
         gOM7RYwPccDhFPyAoc950ImBzITnkteqZVhD9H/waKvogDWKegK/hWptcp4w8yGRBV
         wbNJb2OgmhdgUL0KyqXSf8a7K6BGGua0myDm6B0iz2NkRh1Dg56JFx5X1EVFtNnWYx
         iDrmxGL8GTyTxdaWi5dbDdaToujlq3JKIGVZpTRupe0M8qnNGiUN+G/3dnv5X1XrhL
         0kZvgDPHKo9w4cMZQ5y2eKf/jAmL6l7XncMOaT8yV7U8WPirTLpxxSOCOrmTXpak25
         nLhOzSDg/4ovg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 741A45C015D; Wed, 31 Aug 2022 11:14:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] rcutorture: Make "srcud" option also test polled grace-period API
Date:   Wed, 31 Aug 2022 11:14:32 -0700
Message-Id: <20220831181435.2695936-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit brings the "srcud" (dynamically allocated) SRCU test in line
with the "srcu" (statically allocated) test, so that both test the full
SRCU polled grace-period API.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d8e1b270a065f..7168dc8d61e98 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -709,6 +709,9 @@ static struct rcu_torture_ops srcud_ops = {
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
+	.get_gp_state	= srcu_torture_get_gp_state,
+	.start_gp_poll	= srcu_torture_start_gp_poll,
+	.poll_gp_state	= srcu_torture_poll_gp_state,
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
-- 
2.31.1.189.g2e36527f23

