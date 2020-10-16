Return-Path: <SRS0=fWV6=DX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43E8C433E7
	for <rcu@archiver.kernel.org>; Fri, 16 Oct 2020 10:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43658207F7
	for <rcu@archiver.kernel.org>; Fri, 16 Oct 2020 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395307AbgJPKbz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Oct 2020 06:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395305AbgJPKbz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Oct 2020 06:31:55 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96EBC0613D3
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2020 03:31:54 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id gaXp2300X4C55Sk01aXpLe; Fri, 16 Oct 2020 12:31:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kTN1V-0002dl-SE; Fri, 16 Oct 2020 12:31:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kTN1V-00067e-Pw; Fri, 16 Oct 2020 12:31:45 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] rcu-tasks: Add missing inline to show_rcu_tasks_rude_gp_kthread() dummy
Date:   Fri, 16 Oct 2020 12:31:44 +0200
Message-Id: <20201016103144.23491-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If CONFIG_TINY_RCU=y:

    In file included from kernel/rcu/update.c:591:
    kernel/rcu/tasks.h:710:13: warning: ‘show_rcu_tasks_rude_gp_kthread’ defined but not used [-Wunused-function]
     static void show_rcu_tasks_rude_gp_kthread(void) {}
		 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by marking show_rcu_tasks_rude_gp_kthread() inline.

Fixes: e21408ceec2de5be ("rcu-tasks: Add RCU tasks to rcutorture writer stall output")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Exposed by commit 1e6c62a882155772 ("bpf: Introduce sleepable BPF
programs"), which selects TASKS_TRACE_RCU.
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5d9f2d03e8a0ac9..8c290cc45e6fc63a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -707,7 +707,7 @@ static void show_rcu_tasks_rude_gp_kthread(void)
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #else /* #ifdef CONFIG_TASKS_RUDE_RCU */
-static void show_rcu_tasks_rude_gp_kthread(void) {}
+static inline void show_rcu_tasks_rude_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
-- 
2.17.1

