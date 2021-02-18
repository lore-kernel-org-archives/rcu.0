Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4677C433E9
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912FB64EBD
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhBRQnI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhBROcB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 09:32:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A07B564EC2;
        Thu, 18 Feb 2021 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613658569;
        bh=lVrfAWlr82/yipf5AmwiPr8OW5t7oViqE47qo3gopUI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ds7v2Mj7/IsIVXTYLSfZ3jv3tsiSDpDlBgxJbZnuvXRzMMA+DaUVdKig3Qk7mv8B2
         GOGFAzPVRBFrvL6LP2scH0KOHR+Q9CAU4vK0xnStN9N7v0tVpweYr0eKbLBzj81f+3
         1tMLphEK5JDW2nNwdymvMCUezy2BdlAbg5gxYnCh+MSJmrAe/hDcdzmAxW5gTCNSkf
         EAxJL1y3KB/xNOPHL7503ewwJ7uv2mrDz4ZhEmJsjZFh6fkUxy0ehqW4x9eoqqnvTh
         lKvZY4WsuY106z+XCcw6XNILFREyLy+Y+x3TviANZgn56NyVtdPeD34vEddKkuUPSL
         RTfnNNe9wFYzA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Date:   Thu, 18 Feb 2021 23:29:23 +0900
Message-Id: <161365856280.719838.12423085451287256713.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Commit 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
moved the kprobe setup in early_initcall(), which includes kprobe
jump optimization.
The kprobes jump optimizer involves synchronize_rcu_tasks() which
depends on the ksoftirqd and rcu_spawn_tasks_*(). However, since
those are setup in core_initcall(), kprobes jump optimizer can not
run at the early_initcall().

To avoid this issue, make the kprobe optimization disabled in the
early_initcall() and enables it in subsys_initcall().

Note that non-optimized kprobes is still available after
early_initcall(). Only jump optimization is delayed.

Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/kprobes.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d5a3eb74a657..779d8322e307 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -861,7 +861,6 @@ static void try_to_optimize_kprobe(struct kprobe *p)
 	cpus_read_unlock();
 }
 
-#ifdef CONFIG_SYSCTL
 static void optimize_all_kprobes(void)
 {
 	struct hlist_head *head;
@@ -887,6 +886,7 @@ static void optimize_all_kprobes(void)
 	mutex_unlock(&kprobe_mutex);
 }
 
+#ifdef CONFIG_SYSCTL
 static void unoptimize_all_kprobes(void)
 {
 	struct hlist_head *head;
@@ -2497,18 +2497,14 @@ static int __init init_kprobes(void)
 		}
 	}
 
-#if defined(CONFIG_OPTPROBES)
-#if defined(__ARCH_WANT_KPROBES_INSN_SLOT)
-	/* Init kprobe_optinsn_slots */
-	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
-#endif
-	/* By default, kprobes can be optimized */
-	kprobes_allow_optimization = true;
-#endif
-
 	/* By default, kprobes are armed */
 	kprobes_all_disarmed = false;
 
+#if defined(CONFIG_OPTPROBES) && defined(__ARCH_WANT_KPROBES_INSN_SLOT)
+	/* Init kprobe_optinsn_slots for allocation */
+	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
+#endif
+
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
@@ -2523,6 +2519,21 @@ static int __init init_kprobes(void)
 }
 early_initcall(init_kprobes);
 
+#if defined(CONFIG_OPTPROBES)
+static int __init init_optprobes(void)
+{
+	/*
+	 * Enable kprobe optimization - this kicks the optimizer which
+	 * depends on synchronize_rcu_tasks() and ksoftirqd, that is
+	 * not spawned in early initcall. So delay the optimization.
+	 */
+	optimize_all_kprobes();
+
+	return 0;
+}
+subsys_initcall(init_optprobes);
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
 		const char *sym, int offset, char *modname, struct kprobe *pp)

