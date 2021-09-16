Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D1C433FE
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7382C61350
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 12:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhIPMMR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239273AbhIPMMQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 08:12:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4343360F26;
        Thu, 16 Sep 2021 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631794255;
        bh=WeiFChSOdJfNPcxCzD3qU5UiM7hTBB3yT7qKMMDBWFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qak6rhBfXpPitCR5jcuXweFqQWHQKFZu8CDCoz5eRgMzsfSbrRSOkRTMBMxodpfs6
         gmQtL8Cvph82BYOYwohCAw7hMUVjdj+Fy4VYVkFGSig2WehUtyBZtVbDcDrJM/EEeF
         UFIX884aMKfpDFX/FdYlqaGjlIsMXue2u0kZNMPeNC4LgSoDV08P1v9DDNLbSddH+T
         fR+ImlHQFy0kLWaQ8ZZJVAJ2Fg3w0GzVttNcwr5TizJcn2EhgLNgOW+Il79aTTWBnZ
         1f/SFjjjAb9Cm+SXROgeqGxxWJajggPKFQG/kxV9pAjxzm9k1GxpsuibnYLy3V3dVS
         p7XDZYSMOVJ6A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: [PATCH 1/4] rcu: Ignore rdp.cpu_no_qs.b.exp on premptible RCU's rcu_qs()
Date:   Thu, 16 Sep 2021 14:10:45 +0200
Message-Id: <20210916121048.36623-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916121048.36623-1-frederic@kernel.org>
References: <20210916121048.36623-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The preemptible RCU flavour doesn't rely at all on
struct rcu_data::cpu_no_qs::b::exp and use its own
struct rcu_data::exp_deferred_qs field to record the need for an
expedited quiescent state.

In fact rdp.cpu_no_qs.b.exp should never be set in preemptible RCU.

Make that fact clear and disambiguate the expectations on the
preemptible RCU's rcu_qs() implementation. In this flavour, common
quiescent states aren't expected to deal with expedited grace periods
because those have their own way to report expedited quiescent states:
rcu_read_unlock_special, context switches, etc...

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1a6fdb03d0a5..4c9aeabec242 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -277,12 +277,16 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
  * current task, there might be any number of other tasks blocked while
  * in an RCU read-side critical section.
  *
+ * Unlike non-preemptible-RCU, quiescent state reports for expedited
+ * grace periods are handled seperately via deferred quiescent states
+ * and context switch events.
+ *
  * Callers to this function must disable preemption.
  */
 static void rcu_qs(void)
 {
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!\n");
-	if (__this_cpu_read(rcu_data.cpu_no_qs.s)) {
+	if (__this_cpu_read(rcu_data.cpu_no_qs.b.norm)) {
 		trace_rcu_grace_period(TPS("rcu_preempt"),
 				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
-- 
2.25.1

