Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF414C43331
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E8564EAE
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhCDBBZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451142AbhCDAf4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:35:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97C0164F2B;
        Thu,  4 Mar 2021 00:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818115;
        bh=sWPjlONkWPQdTKmuq5MzEYdLXV8HZABP8qk23sdmkbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jc6KV/WfL7LvKFLvrEjtoyHHSlqWYd79+XTDMoZF+OZ8f5s5FYliDWWmlQ8b7adKF
         NUFQ2qVazdZX+gmwQd7RYLZkK0h2jYm0CxB7mWYSdIYnoRmZ27mkmTyE4lrHaiUc21
         03TbfKQJOKNrXM1e4RFfjSDZLMYaJ6YNP62ak8QNPTOKdDU8qJua5LcBn8qSva1R7S
         IOdt2k9Cjys1Xi7Z3Cqct1T9aQ2CcA/xsea5ChPPr9SpmwJGvvOH5ezx50Vc0jo78O
         L1okl+pT4pAQKaPCtbUawSfNGiQhd2QjTpALvrNF0lgBhhsr4oF16JI473SS+RKQAp
         4c3x61fycR2fw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/2] torture: Replace torture_init_begin string with %s
Date:   Wed,  3 Mar 2021 16:35:12 -0800
Message-Id: <20210304003513.24488-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003431.GA24413@paulmck-ThinkPad-P72>
References: <20210304003431.GA24413@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Stephen Zhang <stephenzhangzsd@gmail.com>

This commit replaces a hard-coded "torture_init_begin" string in
a pr_alert() format with "%s" and __func__.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 01e336f..0a315c3 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -816,9 +816,9 @@ bool torture_init_begin(char *ttype, int v)
 {
 	mutex_lock(&fullstop_mutex);
 	if (torture_type != NULL) {
-		pr_alert("torture_init_begin: Refusing %s init: %s running.\n",
-			 ttype, torture_type);
-		pr_alert("torture_init_begin: One torture test at a time!\n");
+		pr_alert("%s: Refusing %s init: %s running.\n",
+			  __func__, ttype, torture_type);
+		pr_alert("%s: One torture test at a time!\n", __func__);
 		mutex_unlock(&fullstop_mutex);
 		return false;
 	}
-- 
2.9.5

