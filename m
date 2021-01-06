Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0440FC43332
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C195722D6F
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhAFA6f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbhAFA6e (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:58:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBC1A22EBD;
        Wed,  6 Jan 2021 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894658;
        bh=ov4a0gxGqWWt0k0QEL+7JqwNYWJD2jENOKdcm9IBpPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7bMyRURVhxPETEaBSrLXPsov+nt7JhD8hupC1IaSsTWAn6HUbQHaBuM9W8PKA7Fw
         rxha8a1322sf0SxhvOSlTiK/NtIvJIFf4t2HkptYhiGT9+wobttdSwzympEM8yF9o4
         8UzE5CGB4uc6gmBqa4LV22yi0WqRuPJ0AVhP3Nn7MiOd93d+mjvgca7CjdH37iGLlM
         rBkcsPcOl2SA6dppQPfYZS9CzD+Wuy4ZcTJ+664sOdCTF/bCIXVxcmiwvJlLhKjptT
         orY/lqmWO7EHbV2Tb4dRg62yZeXhRfKfklgFBwDHek3bKVuMBi2Vx0JKY/KSpsJDtH
         BOdN/A6Ze7cUw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/6] rcu: Make TASKS_TRACE_RCU select IRQ_WORK
Date:   Tue,  5 Jan 2021 16:57:36 -0800
Message-Id: <20210106005736.12613-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005713.GA12492@paulmck-ThinkPad-P72>
References: <20210106005713.GA12492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Tasks Trace RCU uses irq_work_queue() to safely awaken its grace-period
kthread, so this commit therefore causes the TASKS_TRACE_RCU Kconfig
option select the IRQ_WORK Kconfig option.

Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b71e21f..84dfa8d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -95,6 +95,7 @@ config TASKS_RUDE_RCU
 
 config TASKS_TRACE_RCU
 	def_bool 0
+	select IRQ_WORK
 	help
 	  This option enables a task-based RCU implementation that uses
 	  explicit rcu_read_lock_trace() read-side markers, and allows
-- 
2.9.5

