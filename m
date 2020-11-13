Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F14C4742C
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F04822240
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrSn1Rx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKMMOh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgKMMOf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:35 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDEE82224B;
        Fri, 13 Nov 2020 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269675;
        bh=pVkdoCcCylVBGej69uN3zi3eWDQy5R0//b4FU0YwlBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrSn1Rx2k+JVfYWkbXWcsLqqKRGrkaiMSw2IvJw83NeVf5s7KTieyFLJh7dSl3vq0
         b18bEKqYbsGk4A/X7kHeu9gYG5MxDez4DQJ926b/B0rsrhkaxbdkQSmN13eIiCETcO
         Ke0cXVEWKu2PbgAo+mtrgKSO5Ke61wLwwYW0GVn8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 17/19] cpu/hotplug: Add lockdep_is_cpus_held()
Date:   Fri, 13 Nov 2020 13:13:32 +0100
Message-Id: <20201113121334.166723-18-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU needs to check if the cpu hotplug lock is held, in the middle of
other conditions to check the sanity of RCU-nocb. Provide a helper for
that.

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
---
 include/linux/cpu.h | 1 +
 kernel/cpu.c        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d6428aaf67e7..27eb3875e45a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -118,6 +118,7 @@ extern void cpus_read_lock(void);
 extern void cpus_read_unlock(void);
 extern int  cpus_read_trylock(void);
 extern void lockdep_assert_cpus_held(void);
+extern int lockdep_is_cpus_held(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..3cca5b27de25 100644
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
2.25.1

