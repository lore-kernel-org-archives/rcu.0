Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4507C677F1
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbjAEAlI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbjAEAix (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BE7DC0;
        Wed,  4 Jan 2023 16:38:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D0F618B6;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D1EC43331;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=GxCQJo192VD3OzGEZf6V7v83CQvu18lIxIn+I4KK/Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPvwDfu/dxtu1tKjf6stLL5tgBRxLS7oOWidfG65dmX4eA+4+XLGKj63OhDJhmcGF
         sMHh1R8nH4rNFZHs4vB7LQKoRBGvoLDH1EGRVPHwMjOMNNtdcOzX0g1RAgcVinYkNm
         Qgh1w1qA0cIutxfu9nSwF/JI6bst7q/ZKlK2gU93NQ1zw9KcQSqP7NZwudkO3yxo/v
         v60ixmR1HYpQxifHPlXJM/BKByZWrPD8a/Kfn4fIlHfOrAq0rmsQIwCHdcRuntwvJo
         HFh0ZlqiM1xg+DEEu1Jj7UeexZasXtEDYkScR1QdoHo7kKoCtgKpyMoFFuRLYbd/2P
         zwBvx0KqJqh4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E255C5C1CB9; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        linux-mm@kvack.org
Subject: [PATCH rcu 24/27] mm: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:38:10 -0800
Message-Id: <20230105003813.1770367-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrew Morton
Cc: <linux-mm@kvack.org>
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec055..dc660775b7d3f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -667,7 +667,6 @@ config BOUNCE
 
 config MMU_NOTIFIER
 	bool
-	select SRCU
 	select INTERVAL_TREE
 
 config KSM
-- 
2.31.1.189.g2e36527f23

