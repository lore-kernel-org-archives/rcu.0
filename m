Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA56C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D871207F5
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871800;
	bh=QdyVEtKG5bZE6YpANneYBroHwKvjQwPmzpo9lmFsayU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mhzoT8uvPzYhUlkx1VPh7sDtUD78FHC7yZJDFDmPMN8cW3jM42LM7Ekm7+GYSgxam
	 /WtoSe89Dr7wGaZdNcT6etHCiOx8OJU9JNB5ubEg0HjLAd0PHduWuG5ipiHsl21uT3
	 fj1uAUHdyy3TDm8GvNlrfWceAcr+Ffy0s1JjjkQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbgFWAXS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbgFWAVu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE77207F5;
        Tue, 23 Jun 2020 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871710;
        bh=QdyVEtKG5bZE6YpANneYBroHwKvjQwPmzpo9lmFsayU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jnifzw2SYUH+kxojlQPNqL1/nuv0hZ8a81YuhfNA/f8VVBuZjrYI7rfL87Queeu1c
         Vc8cI++4N/r9htg/+4l6oIa2n2ziADVCG2NqZYyli1q88YehSybLxtDwFlIReDg016
         qB0H3tH8LhZWMNPQKriG+Dtt+b/5uLQhqfkJrueI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/26] rcu: Add callbacks-invoked counters
Date:   Mon, 22 Jun 2020 17:21:25 -0700
Message-Id: <20200623002147.25750-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a count of the callbacks invoked to the per-CPU rcu_data
structure.  This count is printed by the show_rcu_gp_kthreads() that
is invoked by rcutorture and the RCU CPU stall-warning code.  It is also
intended for use by drgn.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 1 +
 kernel/rcu/tree.h       | 1 +
 kernel/rcu/tree_stall.h | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9caaeee..db17ffe 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2425,6 +2425,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
 	count = -rcl.len;
+	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 43991a4..9c6f734 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -171,6 +171,7 @@ struct rcu_data {
 					/* different grace periods. */
 	long		qlen_last_fqs_check;
 					/* qlen at last check for QS forcing */
+	unsigned long	n_cbs_invoked;	/* # callbacks invoked since boot. */
 	unsigned long	n_force_qs_snap;
 					/* did other CPU force QS recently? */
 	long		blimit;		/* Upper limit on a processed batch */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 54a6dba..2768ce6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -649,6 +649,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
  */
 void show_rcu_gp_kthreads(void)
 {
+	unsigned long cbs = 0;
 	int cpu;
 	unsigned long j;
 	unsigned long ja;
@@ -690,9 +691,11 @@ void show_rcu_gp_kthreads(void)
 	}
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
+		cbs += data_race(rdp->n_cbs_invoked);
 		if (rcu_segcblist_is_offloaded(&rdp->cblist))
 			show_rcu_nocb_state(rdp);
 	}
+	pr_info("RCU callbacks invoked since boot: %lu\n", cbs);
 	show_rcu_tasks_gp_kthreads();
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
-- 
2.9.5

