Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5524C43331
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AEC2073B
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347952;
	bh=C0mR+oVSGsBrT/NnbUHWzDYpCT/o9GJoOYQwwGwT130=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Axu6/lEkQpE57TmHZxYWcvdcPvSldl3k7E46h2ZuL3fC6CGsLrGdaQvaGdcrVhXp6
	 H84nF8y4AnQ30fM8CAvkrtZ12VbU2gwOI/r5djc/MqpCh1kpe/02n+V4aoQWOsJ0GP
	 qBW7GI8nGmLhEx3zgZ2Zq6wIwFsKtPo/W/98rocM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgC0WZn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgC0WZJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE4D21556;
        Fri, 27 Mar 2020 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347908;
        bh=C0mR+oVSGsBrT/NnbUHWzDYpCT/o9GJoOYQwwGwT130=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+BrxhK3aZM6YhMrgIFxH+BCHwzcNaUySEDGnjfPyPf1qUL1HyFJ037IH9b661Ds0
         4QQtAzoOyWgboBFh27sedGCi4aK4jW2hzx3MRII09LaXLaocI5bc5FTyJooJxXhX5W
         BMpiM1RPZ4A5wzdF6sbNJtUF7RbFywAEJ+nj628g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 29/34] rcu-tasks: Handle the running-offline idle-task special case
Date:   Fri, 27 Mar 2020 15:24:51 -0700
Message-Id: <20200327222456.12470-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The idle task corresponding to an offline CPU can appear to be running
while that CPU is offline.  This commit therefore adds checks for this
situation, treating it as a quiescent state.  Because the tasklist scan
and the holdout-list scan now exclude CPU-hotplug operations, readers
on the CPU-hotplug paths are still waited for.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index df6e785..d1fa7715 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -818,16 +818,20 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 {
 	int cpu = task_cpu(t);
 	bool in_qs = false;
+	bool ofl = cpu_is_offline(cpu);
 
 	if (task_curr(t)) {
+		WARN_ON_ONCE(ofl & !is_idle_task(t));
+
 		// If no chance of heavyweight readers, do it the hard way.
-		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		if (!ofl && !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 			return false;
 
 		// If heavyweight readers are enabled on the remote task,
 		// we can inspect its state despite its currently running.
 		// However, we cannot safely change its state.
-		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+		if (!ofl && // Check for "running" idle tasks on offline CPUs.
+		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return false; // No quiescent state, do it the hard way.
 		in_qs = true;
 	} else {
-- 
2.9.5

