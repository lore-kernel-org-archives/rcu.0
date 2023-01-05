Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E5C7112B
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbjAEAlQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbjAEAiv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B368C56;
        Wed,  4 Jan 2023 16:38:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A21C4B8198B;
        Thu,  5 Jan 2023 00:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC264C4333B;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=mKsNoUjuRkefu8oWnwwhbiT27WpnrGkS6A7pHvB9XEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rydFqGWdFKNTiCXwXkCtTLgXPrcIws9xkyksZRUmeHArYPiZ6nHJwuMpMhM5iH7Z4
         Trs1F6Jjn2SZcJHkq5+A9TYMnJpkN6ugjcU5FugLmAKAJYuktsbkmeOh57I5lbRUSu
         XkcbAj+g+OP0utYvGrT5HaY1XOL8sdEh0QLl6hzh9O7+J2BBH60JRRYM4MUC9ut8jE
         zoR2puFlIX2wfvw7HQWj+jIDu1jKHlEaZ6KMQfsAjLro3XOqBtqtVSXxcyQN7bDY4i
         m4xTZ7+vVbeLCmvPo7nwP2whE1k3DzfE6OpOKjZ4poK9AOMHXun0OMuL3hUdWFE50m
         jps2Cm/ulA9YA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E625D5C1CBC; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Borislav Petkov <bp@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH rcu 26/27] kernel/notifier: Remove CONFIG_SRCU
Date:   Wed,  4 Jan 2023 16:38:12 -0800
Message-Id: <20230105003813.1770367-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in conditional compilation based on CONFIG_SRCU.
Therefore, remove the #ifdef.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Borislav Petkov <bp@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 kernel/notifier.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index ab75637fd904f..d353e4b5402d7 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -456,7 +456,6 @@ int raw_notifier_call_chain(struct raw_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
 
-#ifdef CONFIG_SRCU
 /*
  *	SRCU notifier chain routines.    Registration and unregistration
  *	use a mutex, and call_chain is synchronized by SRCU (no locks).
@@ -573,8 +572,6 @@ void srcu_init_notifier_head(struct srcu_notifier_head *nh)
 }
 EXPORT_SYMBOL_GPL(srcu_init_notifier_head);
 
-#endif /* CONFIG_SRCU */
-
 static ATOMIC_NOTIFIER_HEAD(die_chain);
 
 int notrace notify_die(enum die_val val, const char *str,
-- 
2.31.1.189.g2e36527f23

