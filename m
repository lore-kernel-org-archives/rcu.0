Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CEEC6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6561C60725
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhGUT5q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhGUT5p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:57:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DB8A61222;
        Wed, 21 Jul 2021 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899901;
        bh=oKLPW9M7jcs30XzmVmiWriCs3Z6UUgtAL+H/Eg8hXHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R60aWChv4EEBRGiUmWFcSTDQlTJAvcDqblg5wLQk+Yh4GAORoLG0I7WaPsuuFFbrm
         9h4jcyu0+nb4B2/z+LUSekzGIXv1EO8N5qG77co8Fwx5zdPv7hBADEFkXsGytYjAux
         yj+VoW2EY6d/lnjpi/z4XoVNVSrawXfDpL7OL38HsYsdqfS3hUcKRjyWVphHHbImq9
         l/AnydfmLKlAM6hasNyHR3ohSLgecZgiMU9as5seDbumyZ3KATy0wYDVkH4PfOfv/y
         vuVVrKTKJRPS4Ij/s32Y2VVWXhi2Eub4inym3SVlRaRU51c84EU+NDDvGOF918n3OY
         LypBPwWiGLjHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 550E55C0A03; Wed, 21 Jul 2021 13:38:21 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] rcu-tasks: Mark ->trc_reader_nesting data races
Date:   Wed, 21 Jul 2021 13:38:15 -0700
Message-Id: <20210721203818.3398345-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
References: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are several ->trc_reader_nesting data races that are too
low-probability for KCSAN to notice, but which will happen sooner or
later.  This commit therefore marks these accesses, and comments one
that cannot race.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6a117375a62a1..f6b5320c44849 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -897,7 +897,7 @@ static void trc_read_check_handler(void *t_in)
 
 	// If the task is not in a read-side critical section, and
 	// if this is the last reader, awaken the grace-period kthread.
-	if (likely(!t->trc_reader_nesting)) {
+	if (likely(!READ_ONCE(t->trc_reader_nesting))) {
 		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
 			wake_up(&trc_wait);
 		// Mark as checked after decrement to avoid false
@@ -906,7 +906,7 @@ static void trc_read_check_handler(void *t_in)
 		goto reset_ipi;
 	}
 	// If we are racing with an rcu_read_unlock_trace(), try again later.
-	if (unlikely(t->trc_reader_nesting < 0)) {
+	if (unlikely(READ_ONCE(t->trc_reader_nesting) < 0)) {
 		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
 			wake_up(&trc_wait);
 		goto reset_ipi;
@@ -953,6 +953,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 			n_heavy_reader_ofl_updates++;
 		in_qs = true;
 	} else {
+		// The task is not running, so C-language access is safe.
 		in_qs = likely(!t->trc_reader_nesting);
 	}
 
@@ -985,7 +986,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 	// The current task had better be in a quiescent state.
 	if (t == current) {
 		t->trc_reader_checked = true;
-		WARN_ON_ONCE(t->trc_reader_nesting);
+		WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 		return;
 	}
 
@@ -1101,7 +1102,7 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
-		 t->trc_reader_nesting,
+		 READ_ONCE(t->trc_reader_nesting),
 		 " N"[!!t->trc_reader_special.b.need_qs],
 		 cpu);
 	sched_show_task(t);
@@ -1196,7 +1197,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
 	WRITE_ONCE(t->trc_reader_checked, true);
-	WARN_ON_ONCE(t->trc_reader_nesting);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 	WRITE_ONCE(t->trc_reader_nesting, 0);
 	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs)))
 		rcu_read_unlock_trace_special(t, 0);
-- 
2.31.1.189.g2e36527f23

