Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE03C43331
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B968022CE3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbhAFEuq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbhAFEuS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDD3C23101;
        Wed,  6 Jan 2021 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908537;
        bh=jPl+1MfjWlYdlMsRVl0RfkOPROmCL3TMfTW66AWcpbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1QtAPnq5moEEHX8Ho7Js6W9rCMrtwRTXg3DsaG2aF4dYWGeaJl3MkdSmfmbWL1vK
         xqO3qQ9VUtGsuxvtmN2eF7OWJVxciUBDlwGLWS5a1qruKZLg9dmc7qOSifoSZoQZa5
         2NDv0bd2o2GcUB3ItyoOvvXpOMXKCZ5OW+l9GcI9cIYIq4fh8sJucTmXrn9dwI1fkF
         kpI/YPjV+gL2fD2ad7tKRhN6cqXJjGBRwsIrlTn8Q1u60mD0g8XK2ZvG+2pRMPEKJC
         EwlBOcsS+8jnmnUHOJw/2q3oCldr2/hTUjUNDhH/G77VjsiZo4K53frIv5RbBL2Ewp
         Dk3pYGBLf6a4Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH tip/core/rcu 14/21] cpu/hotplug: Add lockdep_is_cpus_held()
Date:   Tue,  5 Jan 2021 20:48:46 -0800
Message-Id: <20210106044853.20812-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit adds a lockdep_is_cpus_held() function to verify that the
proper locks are held and that various operations are running in the
correct context.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/cpu.h | 2 ++
 kernel/cpu.c        | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d6428aa..3aaa068 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -111,6 +111,8 @@ static inline void cpu_maps_update_done(void)
 #endif /* CONFIG_SMP */
 extern struct bus_type cpu_subsys;
 
+extern int lockdep_is_cpus_held(void);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpus_write_lock(void);
 extern void cpus_write_unlock(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4e11e91..1b6302e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -330,6 +330,13 @@ void lockdep_assert_cpus_held(void)
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
 
+#ifdef CONFIG_LOCKDEP
+int lockdep_is_cpus_held(void)
+{
+	return percpu_rwsem_is_held(&cpu_hotplug_lock);
+}
+#endif
+
 static void lockdep_acquire_cpus_lock(void)
 {
 	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
-- 
2.9.5

