Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4BDC6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8234261261
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhGUTk7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240353AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB0E6135B;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=zkNcUtGzSM1axGH1YkGEbGCh6UhvBb3FXQgCYblFtKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBDQHnlQjN6UGXPTEiD6cAaWB05HOaDg/bk+8Ilk0X1HCrapSaDXgQjgU/un8IoSx
         vfyM9gKkFUXZjCQtLZT/8oK4Z8Z3vIE+AJb8j16VTLwJBS6HePXZeUM7n5Lc5JBZtR
         tS+pJqq/kVwbfYacfC+z5V2INCZOx/LjJQ9muwzklAmxjBgVpoRdTq56FuoWi9+pQx
         rITti1o5jusGyc9NzvjY3XWXSLXflw/1TnZH1LOVWVrGZEP3DqJaoX0P3Dw1Ak1Cu/
         /GinxZkOYzXknM4j3+1EtFzt+seCRTlzAg2s1cAQW3YKt5h4y8BAnI2zKVhwvMekIo
         LopozORnw3rtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 47AC55C0F91; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/18] rcu: Mark accesses in tree_stall.h
Date:   Wed, 21 Jul 2021 13:21:22 -0700
Message-Id: <20210721202127.2129660-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit marks the accesses in tree_stall.h so as to both avoid
undesirable compiler optimizations and to keep KCSAN focused on the
accesses of the core algorithm.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 63 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6dd6c9aa3f757..a8d0fcf0826f4 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -465,9 +465,10 @@ static void rcu_check_gp_kthread_starvation(void)
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
-		       data_race(rcu_state.gp_flags),
-		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
-		       gpk ? gpk->__state : ~0, cpu);
+		       data_race(READ_ONCE(rcu_state.gp_flags)),
+		       gp_state_getname(rcu_state.gp_state),
+		       data_race(READ_ONCE(rcu_state.gp_state)),
+		       gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
 		if (gpk) {
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
@@ -510,7 +511,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
-		       gpk->__state);
+		       data_race(READ_ONCE(gpk->__state)));
 		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
 		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
 	}
@@ -569,11 +570,11 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 			pr_err("INFO: Stall ended before state dump start\n");
 		} else {
 			j = jiffies;
-			gpa = data_race(rcu_state.gp_activity);
+			gpa = data_race(READ_ONCE(rcu_state.gp_activity));
 			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
 			       rcu_state.name, j - gpa, j, gpa,
-			       data_race(jiffies_till_next_fqs),
-			       rcu_get_root()->qsmask);
+			       data_race(READ_ONCE(jiffies_till_next_fqs)),
+			       data_race(READ_ONCE(rcu_get_root()->qsmask)));
 		}
 	}
 	/* Rewrite if needed in case of slow consoles. */
@@ -815,32 +816,34 @@ void show_rcu_gp_kthreads(void)
 	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
 	j = jiffies;
-	ja = j - data_race(rcu_state.gp_activity);
-	jr = j - data_race(rcu_state.gp_req_activity);
-	js = j - data_race(rcu_state.gp_start);
-	jw = j - data_race(rcu_state.gp_wake_time);
+	ja = j - data_race(READ_ONCE(rcu_state.gp_activity));
+	jr = j - data_race(READ_ONCE(rcu_state.gp_req_activity));
+	js = j - data_race(READ_ONCE(rcu_state.gp_start));
+	jw = j - data_race(READ_ONCE(rcu_state.gp_wake_time));
 	pr_info("%s: wait state: %s(%d) ->state: %#x ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state, t ? t->__state : 0x1ffff, t ? t->rt_priority : 0xffU,
-		js, ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
-		(long)data_race(rcu_state.gp_seq),
-		(long)data_race(rcu_get_root()->gp_seq_needed),
-		data_race(rcu_state.gp_max),
-		data_race(rcu_state.gp_flags));
+		data_race(READ_ONCE(rcu_state.gp_state)),
+		t ? data_race(READ_ONCE(t->__state)) : 0x1ffff, t ? t->rt_priority : 0xffU,
+		js, ja, jr, jw, (long)data_race(READ_ONCE(rcu_state.gp_wake_seq)),
+		(long)data_race(READ_ONCE(rcu_state.gp_seq)),
+		(long)data_race(READ_ONCE(rcu_get_root()->gp_seq_needed)),
+		data_race(READ_ONCE(rcu_state.gp_max)),
+		data_race(READ_ONCE(rcu_state.gp_flags)));
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
-		    !data_race(rnp->qsmask) && !data_race(rnp->boost_tasks) &&
-		    !data_race(rnp->exp_tasks) && !data_race(rnp->gp_tasks))
+		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
+		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
 			continue;
 		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
 			rnp->grplo, rnp->grphi,
-			(long)data_race(rnp->gp_seq), (long)data_race(rnp->gp_seq_needed),
-			data_race(rnp->qsmask),
-			".b"[!!data_race(rnp->boost_kthread_task)],
-			".B"[!!data_race(rnp->boost_tasks)],
-			".E"[!!data_race(rnp->exp_tasks)],
-			".G"[!!data_race(rnp->gp_tasks)],
-			data_race(rnp->n_boosts));
+			(long)data_race(READ_ONCE(rnp->gp_seq)),
+			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
+			data_race(READ_ONCE(rnp->qsmask)),
+			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
+			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
+			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
+			".G"[!!data_race(READ_ONCE(rnp->gp_tasks))],
+			data_race(READ_ONCE(rnp->n_boosts)));
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
@@ -850,12 +853,12 @@ void show_rcu_gp_kthreads(void)
 					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
 			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
-				cpu, (long)data_race(rdp->gp_seq_needed));
+				cpu, (long)data_race(READ_ONCE(rdp->gp_seq_needed)));
 		}
 	}
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
-		cbs += data_race(rdp->n_cbs_invoked);
+		cbs += data_race(READ_ONCE(rdp->n_cbs_invoked));
 		if (rcu_segcblist_is_offloaded(&rdp->cblist))
 			show_rcu_nocb_state(rdp);
 	}
@@ -937,11 +940,11 @@ void rcu_fwd_progress_check(unsigned long j)
 
 	if (rcu_gp_in_progress()) {
 		pr_info("%s: GP age %lu jiffies\n",
-			__func__, jiffies - rcu_state.gp_start);
+			__func__, jiffies - data_race(READ_ONCE(rcu_state.gp_start)));
 		show_rcu_gp_kthreads();
 	} else {
 		pr_info("%s: Last GP end %lu jiffies ago\n",
-			__func__, jiffies - rcu_state.gp_end);
+			__func__, jiffies - data_race(READ_ONCE(rcu_state.gp_end)));
 		preempt_disable();
 		rdp = this_cpu_ptr(&rcu_data);
 		rcu_check_gp_start_stall(rdp->mynode, rdp, j);
-- 
2.31.1.189.g2e36527f23

