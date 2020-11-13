Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A478C4742C
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97172085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H02HBad2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgKMMOY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgKMMOY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:24 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A4622250;
        Fri, 13 Nov 2020 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269663;
        bh=cwrRyVzdGrrcuNdx6Yw81kvmDTaQJhzLcZbdSDJINHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H02HBad2C6f3vjBnL1cWerFhqhOorUEXCx0z/1at6pqJ0kuoN9iI+y44yHR2fzrS9
         XIe8SYNdMlRNtzanjPv0OxPMDjAxeNgYrqGIbwfsWxJ8cOMp7AeRga86L5M8nDoeXy
         lxWoW5Gvy6Yr1yFbn9DZgvHWBgjYKNytTMEfNbF8=
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
Subject: [PATCH 13/19] rcu/nocb: Locally accelerate callbacks as long as offloading isn't complete
Date:   Fri, 13 Nov 2020 13:13:28 +0100
Message-Id: <20201113121334.166723-14-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The local callbacks processing checks if some callbacks need
acceleration. Keep that behaviour under nocb lock protection when
rcu_core() executes concurrently with GP/CB kthreads.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
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
 kernel/rcu/tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cc141337f3f9..b24d60a52f34 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2690,7 +2690,6 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
@@ -2711,11 +2710,11 @@ static __latent_entropy void rcu_core(void)
 
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
-	    rcu_segcblist_is_enabled(&rdp->cblist) && !offloaded) {
-		local_irq_save(flags);
+	    rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
+		rcu_nocb_lock_irqsave(rdp, flags);
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
-		local_irq_restore(flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 	}
 
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
-- 
2.25.1

