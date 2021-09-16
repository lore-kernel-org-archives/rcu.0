Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09330C433EF
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00D2611CA
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhIPAPP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhIPAPP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A6F361186;
        Thu, 16 Sep 2021 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751235;
        bh=28LEAyqhYYloDXEprQtLcQO+cxeAgXaUPrTyIkkOzRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3emXuyjQyOLjzIcyxiTC6RZpTg/Fxm0Hlwpd7QuOA83COKm1chhIXea1dA0WBMRM
         MnyHePkBJyXh9Qmxv8K9eXrc+ur8bIh7jB0eBlllelFSeVPYt0ebEUZbYs9rGpAdi+
         DpK+F0JqYxi4CtXI/l8bRZxi0MY7q57EH5ZR7O60kyBXjoUGi/TjVgZklZwKTCc55b
         9/BcQmUPwI9gVEFKWHB/Ac8AVGELhQ27EfJZNCFuFSY57jbA18BACzDJn1kfJMXoSS
         976EwWoJYom+/JBAqe+WUO7b80xmK+X+YqlDEwYEIyPfLhfpn6nSC4FBEKSlm54aeE
         7X7mGV3CFwdLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42D155C08E8; Wed, 15 Sep 2021 17:13:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/7] refscale: Warn on individual ref_scale_init() error conditions
Date:   Wed, 15 Sep 2021 17:13:49 -0700
Message-Id: <20210916001352.3909170-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
References: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When running refscale as a module, any ref_scale_init() issues will be
reflected in the error code from modprobe or insmod, as the case may be.
However, these error codes are not available when running refscale
built-in, for example, when using the kvm.sh script.  This commit
therefore adds WARN_ON_ONCE() to allow distinguishing ref_scale_init()
errors when running refscale built-in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 66dc14cf5687..1631ef8a138d 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -824,7 +824,7 @@ ref_scale_init(void)
 		init_waitqueue_head(&shutdown_wq);
 		firsterr = torture_create_kthread(ref_scale_shutdown, NULL,
 						  shutdown_task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 		schedule_timeout_uninterruptible(1);
 	}
@@ -851,7 +851,7 @@ ref_scale_init(void)
 	for (i = 0; i < nreaders; i++) {
 		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
 						  reader_tasks[i].task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 
 		init_waitqueue_head(&(reader_tasks[i].wq));
@@ -860,7 +860,7 @@ ref_scale_init(void)
 	// Main Task
 	init_waitqueue_head(&main_wq);
 	firsterr = torture_create_kthread(main_func, NULL, main_task);
-	if (firsterr)
+	if (torture_init_error(firsterr))
 		goto unwind;
 
 	torture_init_end();
-- 
2.31.1.189.g2e36527f23

