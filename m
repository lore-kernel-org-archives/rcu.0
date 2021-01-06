Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66512C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C5623106
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbhAFRSu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbhAFRSt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E353523329;
        Wed,  6 Jan 2021 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953435;
        bh=SQ0emNJ+31FO7tK0fn+VA6loEnezx7MG3kujiqNvJTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FExKHsEz2+5bWWpffItT2L0bz9wPHGux+9ANG8GvPJY7mN3+a3EZhuo+h8tkB7gFK
         kTxGJtwOpLn/uS+w2wHQBAXQTqlhLgJ8HcG8/3f9WV6yCtORkCmfCC5ovfaPUPB70C
         OD8sRUxS079z4tAbU+XIpIN1uji/IRXWRpfkjw5PLzl15XonPS9ORpPie4H6LPg+c5
         kw3WLPA5eDlV6ByxbldtKsMDtalBeLvj4/PS+qh5bvnSExxolI044018cjfILe9sI3
         d8zESrb2KWVdY1i0xyJXB8KiZFVy8hRgFSdF3IdMBY0DQUVIa3rlAZzZitj9ig74el
         l4V9e6Myu+U2A==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/17] torture: Break affinity of kthreads last running on outgoing CPU
Date:   Wed,  6 Jan 2021 09:17:09 -0800
Message-Id: <20210106171710.22239-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The advent of commit 06249738a41a ("workqueue: Manually break affinity
on hotplug") means that the scheduler no longer silently breaks affinity
for kthreads pinned to the outgoing CPU.  This can happen for many of
rcutorture's kthreads due to shuffling, which periodically affinities
these ktheads away from a randomly chosen CPU.  This usually works fine
because these kthreads are allowed to run on any other CPU and because
shuffling is a no-op any time there is but one online CPU.

However, consider the following sequence of events:

1.	CPUs 0 and 1 are initially online.

2.	The torture_shuffle_tasks() function affinities all the tasks
	away from CPU 0.

3.	CPU 1 goes offline.

4.	All the tasks are now affinitied to an offline CPU, triggering
	the warning added by the commit noted above.

This can trigger the following in sched_cpu_dying() in kernel/sched/core.c:

	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq))

This commit therefore adds a new torture_shuffle_tasks_offline() function
that is invoked from torture_offline() prior to offlining a CPU.  This new
function scans the list of shuffled kthreads and for any thread that
last ran (or is set to run) on the outgoing CPU, sets its affinity to
all online CPUs.  Thus there will never be a kthread that is affinitied
only to the outgoing CPU.

Of course, if the sysadm manually applies affinity to any of these
kthreads, all bets are off.  However, such a sysadm must be fast because
the torture_shuffle_tasks_offline() function is invoked immediately before
offlining the outgoing CPU.  Therefore, let it be known that with great
speed and great power comes great responsibility.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/torture.c b/kernel/torture.c
index 01e336f..40c5c68 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -155,6 +155,8 @@ EXPORT_SYMBOL_GPL(torture_hrtimeout_s);
 
 #ifdef CONFIG_HOTPLUG_CPU
 
+static void torture_shuffle_tasks_offline(int cpu);
+
 /*
  * Variables for online-offline handling.  Only present if CPU hotplug
  * is enabled, otherwise does nothing.
@@ -212,6 +214,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			 torture_type, cpu);
 	starttime = jiffies;
 	(*n_offl_attempts)++;
+	torture_shuffle_tasks_offline(cpu);
 	ret = remove_cpu(cpu);
 	if (ret) {
 		s = "";
@@ -512,6 +515,20 @@ static void torture_shuffle_task_unregister_all(void)
 	mutex_unlock(&shuffle_task_mutex);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+// Unbind all tasks from a CPU that is to be taken offline.
+static void torture_shuffle_tasks_offline(int cpu)
+{
+	struct shuffle_task *stp;
+
+	mutex_lock(&shuffle_task_mutex);
+	list_for_each_entry(stp, &shuffle_task_list, st_l)
+		if (task_cpu(stp->st_t) == cpu)
+			set_cpus_allowed_ptr(stp->st_t, cpu_online_mask);
+	mutex_unlock(&shuffle_task_mutex);
+}
+#endif // #ifdef CONFIG_HOTPLUG_CPU
+
 /* Shuffle tasks such that we allow shuffle_idle_cpu to become idle.
  * A special case is when shuffle_idle_cpu = -1, in which case we allow
  * the tasks to run on all CPUs.
-- 
2.9.5

