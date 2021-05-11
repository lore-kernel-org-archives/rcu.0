Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CDC433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A8C613A9
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEKWmz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKWmz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:42:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A4A861139;
        Tue, 11 May 2021 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620772908;
        bh=vdAgi26FJPAMLFViCxdAqQtScDX/RYmsLmTqCNSzZPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4BAYlTM8QqIs0OYD4kss7VkuHY0bq33vwytpQcN0AiUSggPsFEy891vydKvbxSSt
         mW8Gd+TJyJTunEfLwWJjYUzSusGMnSWr0sB9qbh3aLoNgvmyher4i11yXCaT4lF0Ib
         N/Kk0viIXLQigW5lhKXq7omqei+qnDY0rRaQP2adS8S+t5XlWuPjLurDeBCBKdmPKJ
         yditdLrkALv5ntBnCh/O89sYaBIByK5XfaYOo27go6wMwkW8wz4v19X5vTOpbSOXLf
         iEe3yrALiyKnOtu1bPfIwpuNVI5+Ntlbo12xMQc5R1i4leHDOnZl6E3qakHOHZpp2+
         FJzx50vIPOyOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DBF2B5C014E; Tue, 11 May 2021 15:41:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/2] rcu/tree_plugin: Don't handle the case of 'all' CPU range
Date:   Tue, 11 May 2021 15:41:46 -0700
Message-Id: <20210511224146.2892226-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511224115.GA2892092@paulmck-ThinkPad-P17-Gen-1>
References: <20210511224115.GA2892092@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>

The 'all' semantics is now supported by the bitmap_parselist() so we can
drop supporting it as a special case in RCU code.  Since 'all' is properly
supported in core bitmap code, also drop legacy comment in RCU for it.

This patch does not make any functional changes for existing users.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad0156b86937..3f7a345b3814 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1535,13 +1535,10 @@ static void rcu_cleanup_after_idle(void)
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
+	if (cpulist_parse(str, rcu_nocb_mask)) {
+		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
 		cpumask_setall(rcu_nocb_mask);
-	else
-		if (cpulist_parse(str, rcu_nocb_mask)) {
-			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-			cpumask_setall(rcu_nocb_mask);
-		}
+	}
 	return 1;
 }
 __setup("rcu_nocbs=", rcu_nocb_setup);
-- 
2.31.1.189.g2e36527f23

