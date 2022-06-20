Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB17CCA483
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 23:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345752AbiFTXAF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbiFTW7r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6898193FA;
        Mon, 20 Jun 2022 15:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 201C56149F;
        Mon, 20 Jun 2022 22:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E5CC341D0;
        Mon, 20 Jun 2022 22:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765900;
        bh=TEhrntzTc8W9GmaHoeo/y0VQ2Ibq7HY4eHYBzDb30IA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBJXcHreyiCNgJQfL0+2/Ie/226iIrAchhAJGgYGcj3B5HHrh2P4yyK1dplPcvUlR
         goPFscMvNlKFTry9qBSxmIZCrC23A6k/GbWDZ9f7gtbs/VXBSoGY+IzLsWVDzBiA5f
         BthWiS/c2UICYXwoqyJKXCUX50k7V5iut+LhtUnT0aabyBCSxcFqQXJ13XE8kNRtOO
         A+Q/mNamBMJj8Vb4535VvPREd2hRkc8qDth2NTHkEXbxcIBdj3f/N6Z9bF0p9CAE6W
         gIO0uEv+keabSB+jLD4Ewnl3AZavM9pMWIrmGqQOCt/xFXGfB0VqhrSt7NPZhbG0V/
         udIAq/IbzTS8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A94495C0DEB; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu 11/12] torture: Flush printk() buffers before powering off
Date:   Mon, 20 Jun 2022 15:58:16 -0700
Message-Id: <20220620225817.3843106-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The rcutorture test suite produces quite a bit of console output
at the end of a test.  This means that the new printk() kthreads
are likely to be in the process of flushing output at the time of
the torture_shutdown() function's call to kernel_power_off().

This commit therefore invokes pr_flush(1000, true) to flush this
pending console output before invoking kernel_power_off().

Fixes: 8e274732115f ("printk: extend console_lock for per-console locking")
Cc: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/torture.c b/kernel/torture.c
index 789aeb0e1159c..6d7b282fbb5f8 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -651,6 +651,7 @@ static int torture_shutdown(void *arg)
 		VERBOSE_TOROUT_STRING("No torture_shutdown_hook(), skipping.");
 	if (ftrace_dump_at_shutdown)
 		rcu_ftrace_dump(DUMP_ALL);
+	pr_flush(1000, true);
 	kernel_power_off();	/* Shut down the system. */
 	return 0;
 }
-- 
2.31.1.189.g2e36527f23

