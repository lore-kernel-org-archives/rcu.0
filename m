Return-Path: <SRS0=5qLc=CB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F880C433DF
	for <rcu@archiver.kernel.org>; Sun, 23 Aug 2020 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F7E2078D
	for <rcu@archiver.kernel.org>; Sun, 23 Aug 2020 03:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KdOT92ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHWDEd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 22 Aug 2020 23:04:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44426 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgHWDEb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 22 Aug 2020 23:04:31 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3765C279;
        Sun, 23 Aug 2020 05:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1598151868;
        bh=V8+O/BBRw6hBiOTq3Utipe4nXVwNkDQuH5To/5j126k=;
        h=From:To:Cc:Subject:Date:From;
        b=KdOT92ERp70Y8OyjDn04zZT0FZu+vPkuLxkRe5gz8Cn19AW1AbwqruciNW/eWJhqw
         mpoRJMjWTsa9hnjS1q+VgFLwAvpI07RbS1NwPEkSggeVvsizelfJySmvxF89QG9M8H
         Jtw3TZX71JkOwJP54YmqMYbohGXOjkF27GXHuk6M=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] rcu-tasks: Fix compilation warning with !CONFIG_TASKS_RCU and CONFIG_TINY_RCU
Date:   Sun, 23 Aug 2020 06:04:05 +0300
Message-Id: <20200823030405.22174-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Commit 8344496e8b49 ("rcu-tasks: Conditionally compile
show_rcu_tasks_gp_kthreads()") introduced conditional compilation of
several functions, but forgot one occurrence of
show_rcu_tasks_classic_gp_kthread() that causes the compiler to warn of
an unused static function. Fix it.

Fixes: 8344496e8b49 ("rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 835e2df8590a..bddf3968c1eb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -590,7 +590,9 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
+#ifndef CONFIG_TINY_RCU
 static void show_rcu_tasks_classic_gp_kthread(void) { }
+#endif /* #ifndef CONFIG_TINY_RCU */
 void exit_tasks_rcu_start(void) { }
 void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
-- 
Regards,

Laurent Pinchart

