Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77386ECAAD4
	for <rcu@archiver.kernel.org>; Wed, 31 Aug 2022 18:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiHaSIS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiHaSIM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC33E3962;
        Wed, 31 Aug 2022 11:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75DB2B8220A;
        Wed, 31 Aug 2022 18:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C62CC433D6;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=UBju2okSl8/q5Sdd+pxIbphkj3m0c6OMyYxyLduTv9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHZVuyX6uOE/uI7HlKdl9Z73vVGpgsOpKfsNmSa4xB1ZpBGOqJ5M+c7sMI8DequyL
         Zc9QkNuWSu9O+bYt3RdISY24OjXpiFrQod3PpOZP4QTCseEXzuit6NPEPPo5Vg6hoc
         2hGfvngdCFKo8lGD+16cxuQofqSijU9f5a1l3rNbcRQAWoberduJKyP/WG8iazseZ2
         P62gCmdIn9ZzTJiyDGyGS2469Jo3U6icjvxNUUnMnZerRDVdTXpNdg1C2j51QbLphS
         TNWNjgkeOqWnB6gkeD4rmETuDdL//1+hKFJ6S0LfQ/ob/vspm5+2l+LBNn4h12FViO
         22DSDHw6ZjysQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EEDB95C02A9; Wed, 31 Aug 2022 11:08:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/10] rcu: Add QS check in rcu_exp_handler() for non-preemptible kernels
Date:   Wed, 31 Aug 2022 11:07:58 -0700
Message-Id: <20220831180805.2693546-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

Kernels built with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y maintain
preempt_count() state.  Because such kernels map __rcu_read_lock()
and __rcu_read_unlock() to preempt_disable() and preempt_enable(),
respectively, this allows the expedited grace period's !CONFIG_PREEMPT_RCU
version of the rcu_exp_handler() IPI handler function to use
preempt_count() to detect quiescent states.

This preempt_count() usage might seem to risk failures due to
use of implicit RCU readers in portions of the kernel under #ifndef
CONFIG_PREEMPTION, except that rcu_core() already disallows such implicit
RCU readers.  The moral of this story is that you must use explicit
read-side markings such as rcu_read_lock() or preempt_disable() even if
the code knows that this kernel does not support preemption.

This commit therefore adds a preempt_count()-based check for a quiescent
state in the !CONFIG_PREEMPT_RCU version of the rcu_exp_handler()
function for kernels built with CONFIG_PREEMPT_COUNT=y, reporting an
immediate quiescent state when the interrupted code had both preemption
and softirqs enabled.

This change results in about a 2% reduction in expedited grace-period
latency in kernels built with both CONFIG_PREEMPT_RCU=n and
CONFIG_PREEMPT_COUNT=y.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/all/20220622103549.2840087-1-qiang1.zhang@intel.com/
---
 kernel/rcu/tree_exp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index be667583a5547..b07998159d1fa 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -828,11 +828,13 @@ static void rcu_exp_handler(void *unused)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
+	bool preempt_bh_enabled = !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
 
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
-	if (rcu_is_cpu_rrupt_from_idle()) {
+	if (rcu_is_cpu_rrupt_from_idle() ||
+	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) && preempt_bh_enabled)) {
 		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 		return;
 	}
-- 
2.31.1.189.g2e36527f23

