Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95945C43461
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3C02068E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897506;
	bh=Md1F4JPJeRjrVLa/O8zZqOK+IKqCvmD2zTJEeJk3ut8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q26bg6H+tbalskGV6ZAN1PdOacFbi2IXArz31EBUOeSeebaLU3nH9gQ6Dk7vTY1o7
	 U1kOhxh+6xf1gqwIOC4FOStYT0tLsmYJZC7SbR6+8rrDYwenr1ZTKH0JpLpoDxU1jY
	 4oU3yHk3eLKoZxr5sYGDqZaJkgSLn03pOAErEtxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHaSLq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbgHaSL1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:27 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3D22151B;
        Mon, 31 Aug 2020 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897484;
        bh=Md1F4JPJeRjrVLa/O8zZqOK+IKqCvmD2zTJEeJk3ut8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqEr/u1O+dXKVsOTUmIwBfv416WKGJi58bEDo6EiTwcjyI12RC70aPxu7VTqlSVyp
         Wj8chE+TKuUQQ7xBJ5SAjihTDcZtqoTZSVrHSWxFETZSDyObqQ078o7rid/JlcQahQ
         g8KrN2YZ3gP5VCqOHWa+sSnTVdEBVtuRtwclikww=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/13] rcu: Remove unused "cpu" parameter from rcu_report_qs_rdp()
Date:   Mon, 31 Aug 2020 11:11:20 -0700
Message-Id: <20200831181120.1044-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The "cpu" parameter to rcu_report_qs_rdp() is not used, with rdp->cpu
being used instead.  Furtheremore, every call to rcu_report_qs_rdp()
invokes it on rdp->cpu.  This commit therefore removes this unused "cpu"
parameter and converts a check of rdp->cpu against smp_processor_id()
to a WARN_ON_ONCE().

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 8 ++++----
 kernel/rcu/tree_plugin.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a295cadf..c612765 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2240,7 +2240,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
  * structure.  This must be called from the specified CPU.
  */
 static void
-rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
+rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
@@ -2249,6 +2249,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_node *rnp;
 
+	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
@@ -2265,8 +2266,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
-	if (rdp->cpu == smp_processor_id())
-		rdp->core_needs_qs = false;
+	rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
@@ -2315,7 +2315,7 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 	 * Tell RCU we are done (but rcu_report_qs_rdp() will be the
 	 * judge of that).
 	 */
-	rcu_report_qs_rdp(rdp->cpu, rdp);
+	rcu_report_qs_rdp(rdp);
 }
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 25a676d..ca31be0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -461,7 +461,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	t->rcu_read_unlock_special.s = 0;
 	if (special.b.need_qs) {
 		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
-			rcu_report_qs_rdp(rdp->cpu, rdp);
+			rcu_report_qs_rdp(rdp);
 			udelay(rcu_unlock_delay);
 		} else {
 			rcu_qs();
@@ -791,7 +791,7 @@ void rcu_read_unlock_strict(void)
 	   irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
-	rcu_report_qs_rdp(rdp->cpu, rdp);
+	rcu_report_qs_rdp(rdp);
 	udelay(rcu_unlock_delay);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_strict);
-- 
2.9.5

