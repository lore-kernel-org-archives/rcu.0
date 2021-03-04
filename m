Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA1C433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F3964EA4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbhCDBBT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346602AbhCDAd1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:33:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8DDB64E51;
        Thu,  4 Mar 2021 00:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817966;
        bh=lP+g7j87U/ghOyT47Wf3gQv0BrQsVDF8bR8GwOA50eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/3kz6lBYbh6KyRzqF+Sg4CFVAwnZLc0el6tk36jTEKZ4UekIFi6++tgUXjdGH1uR
         +5WdP2GWmrq35gZovhw67xcHHxXr45g7S4+r0r/H35Rsndwbr0x930ag7VZ19qeMWe
         Ie3c7dloOmf6zc+dwyXvlDkaxqn4nN6aS0iD8eZx+G4qJeElWz/Xjv6g+zyJFaaTEu
         m/gOoUQXNQZQ9PSZ8XcOMVKY2n37rTXfg8q20fI4v//RtNXYhGfap72jWk1CmkspXm
         iR8mzbvTNyhHMRZmGIH7ecJX4irdww0GjtYCQkkpDXUjshRSTTKMo/TFnw/2ROQZM1
         dnpXCYR7H/XfA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/2] rcu-tasks: Rectify kernel-doc for struct rcu_tasks
Date:   Wed,  3 Mar 2021 16:32:44 -0800
Message-Id: <20210304003245.24327-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003226.GA24261@paulmck-ThinkPad-P72>
References: <20210304003226.GA24261@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

The command 'find ./kernel/rcu/ | xargs ./scripts/kernel-doc -none'
reported an issue with the kernel-doc of struct rcu_tasks.

This commit rectifies the kernel-doc, such that no issues remain for
./kernel/rcu/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index af7c194..17c8ebe 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -20,7 +20,7 @@ typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
 typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
 /**
- * Definition for a Tasks-RCU-like mechanism.
+ * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
  * @cbs_head: Head of callback list.
  * @cbs_tail: Tail pointer for callback list.
  * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
@@ -38,7 +38,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
- * @holdout_func: This flavor's holdout-list scan function (optional).
+ * @holdouts_func: This flavor's holdout-list scan function (optional).
  * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @name: This flavor's textual name.
-- 
2.9.5

