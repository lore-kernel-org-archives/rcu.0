Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE86ECAAD3
	for <rcu@archiver.kernel.org>; Wed, 31 Aug 2022 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiHaSYK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiHaSXq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 Aug 2022 14:23:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D55101E6;
        Wed, 31 Aug 2022 11:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BF85B82271;
        Wed, 31 Aug 2022 18:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF33C433D7;
        Wed, 31 Aug 2022 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969677;
        bh=X9PKdPFevUFDYLsifWGkcchXcPpnWnttSHK/jbXc4Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Af4g9TloRVFDTdFQkjLT/cgHc2KSQ5+Q5CesGxRZo5xSnVkKLO40MCX+zumCiDD5o
         OTOj2HS4nBcFpLL8V+WSkLKYrxTEFma7nBvV4iicQMxZhfkkpLCsQZoKSkisjmcoxN
         bJ/AKjo64fm4IFOr66DYQjy8eaddpvLDqF5JtZngTiCQkuwl9a40R5CMq3KGR3m6Xa
         JMgezTYCaMggIX+BgRtFbqi1o4jCjndoZfPB7ICzKLw3YdALO3apiJqYyCEfHAU8CG
         1LCJa4Tn1jcvxis7BLgUWjmmnUqtlvPHUm1ZKXY8yJvBVPjXJUQmjDz+tdKa9/ajJJ
         koOnkbiEZYitg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7887D5C02A9; Wed, 31 Aug 2022 11:14:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] srcu: Make Tiny SRCU poll_state_synchronize_srcu() more precise
Date:   Wed, 31 Aug 2022 11:14:34 -0700
Message-Id: <20220831181435.2695936-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit applies the more-precise grace-period-state check used by
rcu_seq_done_exact() to poll_state_synchronize_srcu().  This is important
because Tiny SRCU uses a 16-bit counter, which can wrap quite quickly.
If counter wrap continues to be a problem, then expanding ->srcu_idx
and ->srcu_idx_max to 32 bits might be warranted.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 92c002d654828..a2af24f214676 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -240,10 +240,10 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
  */
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 {
-	bool ret = USHORT_CMP_GE(READ_ONCE(ssp->srcu_idx), cookie);
+	unsigned short cur_s = READ_ONCE(ssp->srcu_idx);
 
 	barrier();
-	return ret;
+	return USHORT_CMP_GE(cur_s, cookie) || USHORT_CMP_LT(cur_s, cookie - 3);
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
 
-- 
2.31.1.189.g2e36527f23

