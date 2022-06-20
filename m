Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BA0C433EF
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 23:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiFTXMv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347091AbiFTXMF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 19:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99ED22505;
        Mon, 20 Jun 2022 16:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BFD661502;
        Mon, 20 Jun 2022 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4A3C341F4;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=gT7MwZiGJkiPueXwvV+cr0NVj3jFSUZd3lPg3Go3xJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNOgQPsGunQcJycedFWFIbU6kXAyWGvRcF/Ndv8oWcD/kYqdV7ezjASLrroYc/ybL
         AGuvzFjTr5WT6Y7ULbZ2gjschh/fQWNdtn8Q34OC4gihZ5SzJ5sYYhgblcBKWAagUj
         JCI28LUjuFb1GwXXOb36wcC1cSP5dAgBoHnLh4ky8ZylDA2e1fd9BvzRebQCvgHBN/
         e15HpSJXk1ddP5SKt6AdNTEMgqReMN+e3O1wxlFhNqe/Dzh1qSa0C8GC8HPJpAE88K
         brPpTi0m7a8hYBvp/k9Nf+SwExQWetqmel0UYSbTLFaAB/Up3yTUp0YUwDbOmW2ga1
         2BfQf3nzvJ9mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 79F045C13B9; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 23/23] context_tracking: Interrupts always disabled for ct_idle_exit()
Date:   Mon, 20 Jun 2022 16:10:29 -0700
Message-Id: <20220620231029.3844583-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Now that the idle-loop cleanups have ensured that rcu_idle_exit() is
always invoked with interrupts disabled, remove the interrupt disabling
in favor of a debug check.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/context_tracking.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 1da44803fd319..99310cf5b0254 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -332,11 +332,8 @@ EXPORT_SYMBOL_GPL(ct_idle_enter);
  */
 void noinstr ct_idle_exit(void)
 {
-	unsigned long flags;
-
-	raw_local_irq_save(flags);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
-	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
 
-- 
2.31.1.189.g2e36527f23

