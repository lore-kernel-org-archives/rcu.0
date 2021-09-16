Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7896C433F5
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EC0611CA
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhIPAPP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhIPAPP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70069611C4;
        Thu, 16 Sep 2021 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751235;
        bh=xQikrOVczBlHti67jFTnzWecDajquNYAn0jlFoj7aBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2aY24JCL2sQ8WbprCLTOdWcztz+/+oeS2X/8U0iBiyeOFXGchF0Uq+bbfay/PZfe
         NPscxdZ1CRvmjpMGr3zskS2U0tIjFGkeQUyJigHPIyNLsFn/RwHG3aNsxYBByLBRPY
         yiDXtKRoa5dr6CocGS82thGZJu82iUb2tGFkrqBtG5NcqIXAeCCPBYxs+/MffP99+D
         KEb/+Hq3aIIpBTb8TIu1ONEzsII2Ci8AcE/Rdfq0UxZ9ZwhAue999uetDGX6g+ucXf
         pYwMDM9dowfwzQe2OAouLEl/mWxOnz9bAXBL8MD5kXSXNOv1/LdloHtaXVnG/d+J0I
         yyOPQP/rtTU7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4577D5C0926; Wed, 15 Sep 2021 17:13:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/7] rcuscale: Warn on individual rcu_scale_init() error conditions
Date:   Wed, 15 Sep 2021 17:13:50 -0700
Message-Id: <20210916001352.3909170-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
References: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When running rcuscale as a module, any rcu_scale_init() issues will be
reflected in the error code from modprobe or insmod, as the case may be.
However, these error codes are not available when running rcuscale
built-in, for example, when using the kvm.sh script.  This commit
therefore adds WARN_ON_ONCE() to allow distinguishing rcu_scale_init()
errors when running rcuscale built-in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 2cc34a22a506..228f143bf935 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -758,7 +758,7 @@ kfree_scale_init(void)
 		init_waitqueue_head(&shutdown_wq);
 		firsterr = torture_create_kthread(kfree_scale_shutdown, NULL,
 						  shutdown_task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 		schedule_timeout_uninterruptible(1);
 	}
@@ -775,7 +775,7 @@ kfree_scale_init(void)
 	for (i = 0; i < kfree_nrealthreads; i++) {
 		firsterr = torture_create_kthread(kfree_scale_thread, (void *)i,
 						  kfree_reader_tasks[i]);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 
@@ -838,7 +838,7 @@ rcu_scale_init(void)
 		init_waitqueue_head(&shutdown_wq);
 		firsterr = torture_create_kthread(rcu_scale_shutdown, NULL,
 						  shutdown_task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 		schedule_timeout_uninterruptible(1);
 	}
@@ -852,7 +852,7 @@ rcu_scale_init(void)
 	for (i = 0; i < nrealreaders; i++) {
 		firsterr = torture_create_kthread(rcu_scale_reader, (void *)i,
 						  reader_tasks[i]);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	while (atomic_read(&n_rcu_scale_reader_started) < nrealreaders)
@@ -879,7 +879,7 @@ rcu_scale_init(void)
 		}
 		firsterr = torture_create_kthread(rcu_scale_writer, (void *)i,
 						  writer_tasks[i]);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	torture_init_end();
-- 
2.31.1.189.g2e36527f23

