Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195CC433F5
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55EC61157
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhIOXr0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232836AbhIOXrZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F9D610E8;
        Wed, 15 Sep 2021 23:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749565;
        bh=T9JJaPoA7qsXm/0bMzGOJxDkivMKAqiIsSB90vRnVcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lOMa9D7h/fbSzLHk5viP9DdUdXMXG4HGQ4/Qf+tazXYSaeO7pJEgI1k25lQtNuPw9
         0F4ewWI8MZQI7dcPaWe0J3E/NWKsdYvVicJTNnt/TRPbQNXIzrak2M/Ieu3/a3SNg4
         kxtMaYwqIQLcZ7LZx5XLFy9kmiOpTGJmyyBhfHzu3BaWwtEieZ7pFkrEJk4/NE2nrw
         BICdz9SbFGJaPb3jBAV4VnE1K0PKimmKWOntCSIZQPlnp3UlsN6NP133VNe619iUfj
         fqWip4ZasloCexaPhU+4mlT78Isl7njvDlJCSA3Cj2EOCpKS6BrMjyULm9Ra7NoSlH
         KFGI6PIunPv/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BD9595C054E; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/13] rcu-tasks: Wait for trc_read_check_handler() IPIs
Date:   Wed, 15 Sep 2021 16:45:52 -0700
Message-Id: <20210915234604.3907802-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, RCU Tasks Trace initializes the trc_n_readers_need_end counter
to the value one, increments it before each trc_read_check_handler()
IPI, then decrements it within trc_read_check_handler() if the target
task was in a quiescent state (or if the target task moved to some other
CPU while the IPI was in flight), complaining if the new value was zero.
The rationale for complaining is that the initial value of one must be
decremented away before zero can be reached, and this decrement has not
yet happened.

Except that trc_read_check_handler() is initiated with an asynchronous
smp_call_function_single(), which might be significantly delayed.  This
can result in false-positive complaints about the counter reaching zero.

This commit therefore waits for in-flight IPI handlers to complete before
decrementing away the initial value of one from the trc_n_readers_need_end
counter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 806160c44b17..3b2f8038064a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1150,14 +1150,28 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 	}
 }
 
+static void rcu_tasks_trace_empty_fn(void *unused)
+{
+}
+
 /* Wait for grace period to complete and provide ordering. */
 static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 {
+	int cpu;
 	bool firstreport;
 	struct task_struct *g, *t;
 	LIST_HEAD(holdouts);
 	long ret;
 
+	// Wait for any lingering IPI handlers to complete.  Note that
+	// if a CPU has gone offline or transitioned to userspace in the
+	// meantime, all IPI handlers should have been drained beforehand.
+	// Yes, this assumes that CPUs process IPIs in order.  If that ever
+	// changes, there will need to be a recheck and/or timed wait.
+	for_each_online_cpu(cpu)
+		if (smp_load_acquire(per_cpu_ptr(&trc_ipi_to_cpu, cpu)))
+			smp_call_function_single(cpu, rcu_tasks_trace_empty_fn, NULL, 1);
+
 	// Remove the safety count.
 	smp_mb__before_atomic();  // Order vs. earlier atomics
 	atomic_dec(&trc_n_readers_need_end);
-- 
2.31.1.189.g2e36527f23

