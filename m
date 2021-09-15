Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6FAC4332F
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE1C61165
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhIOXr1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232965AbhIOXrZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4EB161131;
        Wed, 15 Sep 2021 23:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749565;
        bh=DJbg8Ie7q2ejCdJXF8FVvHWuYnea1IcGRs3WO9/D8Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yluj5w9HneTzBdGz6bwRW7nAH+cSAutP4VhwiqR2HAQnRR7xalhkRQq07DFte78Bg
         2ePrMwTwwu3k0YofixxQJ14fitUkU2Onz4pw5oF8NUkgb6EGAABtUA2AkL/dTKM+qV
         ZGWJETJPecBSOGe7AV0sMLD96bg8YY1O00cbzR3SOTbu5K5zj3rMmwMy1TyrFshhsJ
         UrtydGKWH5f3S7NfqQwpr1GPSBkXeTQ+gvcv/ngtTzBGp+RTniqUWRTMEtwkRTGX0B
         hMv9RnUZIM7eMF4PF6WMvQGmALkbzbm9NfkDi0RzfqDHN5RBqJDEEgvz80JxjfqQ0/
         s7ZXQ/ZhMvpCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C230E5C08DB; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/13] rcu-tasks: Add trc_inspect_reader() checks for exiting critical section
Date:   Wed, 15 Sep 2021 16:45:54 -0700
Message-Id: <20210915234604.3907802-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, trc_inspect_reader() treats a task exiting its RCU Tasks
Trace read-side critical section the same as being within that critical
section.  However, this can fail because that task might have already
checked its .need_qs field, which means that it might never decrement
the all-important trc_n_readers_need_end counter.  Of course, for that
to happen, the task would need to never again execute an RCU Tasks Trace
read-side critical section, but this really could happen if the system's
last trampoline was removed.  Note that exit from such a critical section
cannot be treated as a quiescent state due to the possibility of nested
critical sections.  This means that if trc_inspect_reader() sees a
negative nesting value, it must set up to try again later.

This commit therefore ignores tasks that are exiting their RCU Tasks
Trace read-side critical sections so that they will be rechecked later.

[ paulmck: Apply feedback from Neeraj Upadhyay and Boqun Feng. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c9d8583ffe59..8387e70e6b00 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -923,7 +923,7 @@ static void trc_read_check_handler(void *t_in)
 static bool trc_inspect_reader(struct task_struct *t, void *arg)
 {
 	int cpu = task_cpu(t);
-	bool in_qs = false;
+	int nesting;
 	bool ofl = cpu_is_offline(cpu);
 
 	if (task_curr(t)) {
@@ -943,18 +943,18 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		n_heavy_reader_updates++;
 		if (ofl)
 			n_heavy_reader_ofl_updates++;
-		in_qs = true;
+		nesting = 0;
 	} else {
 		// The task is not running, so C-language access is safe.
-		in_qs = likely(!t->trc_reader_nesting);
+		nesting = t->trc_reader_nesting;
 	}
 
-	// Mark as checked so that the grace-period kthread will
-	// remove it from the holdout list.
-	t->trc_reader_checked = true;
-
-	if (in_qs)
-		return true;  // Already in quiescent state, done!!!
+	// If not exiting a read-side critical section, mark as checked
+	// so that the grace-period kthread will remove it from the
+	// holdout list.
+	t->trc_reader_checked = nesting >= 0;
+	if (nesting <= 0)
+		return !nesting;  // If in QS, done, otherwise try again later.
 
 	// The task is in a read-side critical section, so set up its
 	// state so that it will awaken the grace-period kthread upon exit
-- 
2.31.1.189.g2e36527f23

