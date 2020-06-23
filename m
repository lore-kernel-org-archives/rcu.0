Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C4C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC1207DD
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871886;
	bh=fvg7edpN5UhbdDyxgVut+DhMZyQFLMSLs4aQ8/dgmE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJQ8tlTLStBJBbDl2MNrIWoJ4YYtNqBxvEWgNDsTUIK2ckWkMLVCKb+Kx4PAC9DH5
	 KSMRdy4gwAzjRnpniRbB/i489Cb8ZqbcK4QtRFqmhRFBmczF5KUpIvYyfkwQs60Hy8
	 +Memd0ru9OeH+42g+WUDE7HBzm2ahBsBMjxXAncc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgFWAYq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbgFWAYp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ABA220780;
        Tue, 23 Jun 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871885;
        bh=fvg7edpN5UhbdDyxgVut+DhMZyQFLMSLs4aQ8/dgmE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sfe5yPIxVv6YqTyMP7dj00iesVEr0E6J+SQ+7bCaf6M8jRsNEGzQJCxzslScYhsUz
         aBQPVZnIFuljLRQjhCCVHgNAskRoMfkdNgkgD3GN3Ss0Xe4b48q8S/exwlQaD1rfx/
         SpvOv/p7sdJHFgKBFka9WxmMrPX6+di/5zl7WoOE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/5] rcu-tasks: Make rcu_tasks_postscan() be static
Date:   Mon, 22 Jun 2020 17:24:40 -0700
Message-Id: <20200623002443.25954-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002423.GA25869@paulmck-ThinkPad-P72>
References: <20200623002423.GA25869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_tasks_postscan() function is not used outside of RCU's tasks.h
file, so this commit makes it be static.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 91fee81..da200e5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -402,7 +402,7 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 }
 
 /* Processing between scanning taskslist and draining the holdout list. */
-void rcu_tasks_postscan(struct list_head *hop)
+static void rcu_tasks_postscan(struct list_head *hop)
 {
 	/*
 	 * Wait for tasks that are in the process of exiting.  This
-- 
2.9.5

