Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD9BC6FD1D
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 19:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjCOToe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCOTod (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:33 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98396136FB
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:44:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y10so17531412qtj.2
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqFrNqITGGDLlhPYnkJjrrLRlwOYf2ibTxsThXGpk8A=;
        b=VEyLp9OjLmJF5YzG1BBVxZJwxAFxMj+a4hkb4juSICDtdMWn8iT2nSGV1mAMg+JGAf
         usO9i856r9iQFDut5RGxvV/cwJqOKC6yQiQqrFSVmBrJqPxApDUBvZ0+dfZ3iMEtsCLO
         XfvJmsZnSgkJMKtqKzf1Wmk2eEKQgYX45tu9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqFrNqITGGDLlhPYnkJjrrLRlwOYf2ibTxsThXGpk8A=;
        b=j0O0VQJqIHpxHY/kS4vpwbLRDO3h1s2fl9f+lA5phjtvjOGcBmV2eNS/6mEDox912c
         bIUqugzKMvjXehdVr8Tx54c8QzAIBK+vi/IIqPdvXag7zrdpYEznXyaSgrGDYH4QZvpq
         OiEtpAbaevqNjGH4VFPoaLctS0ic2QJ23s2l+8l8+Y5WHklDXI+5tlO7d7ME4k9+pUF8
         4BfIAfU+C9OReElakJpXthurnWUih+6LeZkw9urfPpRAtc5XeZpHFY7JhUxF0++XW81e
         59iXRhf3htP3Sm/zjjbR732CAKpSdrFai/zitIjsjCNMpe6pa7eylZwvvvCdenQIqWTB
         8k5Q==
X-Gm-Message-State: AO0yUKUHaZrVb7dQQYw6+ScOikFFRTERDjRooHrG10/jRZSzr6h7WFLY
        WxouwaZlGmY1+pF5NAClDnsCxvmlUeBiJf7ULt8=
X-Google-Smtp-Source: AK7set9dfK434dXDr0yIat6SPxVU8XoMS5ZcP+FDLE+fW7L96CzOkOycO/RXcxTtUb42myef7phsBQ==
X-Received: by 2002:a05:622a:60f:b0:3b7:ec70:30af with SMTP id z15-20020a05622a060f00b003b7ec7030afmr1753785qta.46.1678909468933;
        Wed, 15 Mar 2023 12:44:28 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:28 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: [PATCH 1/9] rcu: Fix set/clear TICK_DEP_BIT_RCU_EXP bitmask race
Date:   Wed, 15 Mar 2023 19:43:41 +0000
Message-Id: <20230315194349.10798-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

For kernels built with CONFIG_NO_HZ_FULL=y, the following scenario can result
in the scheduling-clock interrupt remaining enabled on a holdout CPU after
its quiescent state has been reported:

	CPU1                                                 CPU2
rcu_report_exp_cpu_mult                          synchronize_rcu_expedited_wait
   acquires rnp->lock                               mask = rnp->expmask;
                                                    for_each_leaf_node_cpu_mask(rnp, cpu, mask)
   rnp->expmask = rnp->expmask & ~mask;                rdp = per_cpu_ptr(&rcu_data, cpu1);
   for_each_leaf_node_cpu_mask(rnp, cpu, mask)
      rdp = per_cpu_ptr(&rcu_data, cpu1);
      if (!rdp->rcu_forced_tick_exp)
             continue;                                 rdp->rcu_forced_tick_exp = true;
                                                       tick_dep_set_cpu(cpu1, TICK_DEP_BIT_RCU_EXP);

The problem is that CPU2's sampling of rnp->expmask is obsolete by the
time it invokes tick_dep_set_cpu(), and CPU1 is not guaranteed to see
CPU2's store to ->rcu_forced_tick_exp in time to clear it.  And even if
CPU1 does see that store, it might invoke tick_dep_clear_cpu() before
CPU2 got around to executing its tick_dep_set_cpu(), which would still
leave the victim CPU with its scheduler-clock tick running.

Either way, an nohz_full real-time application running on the victim
CPU would have its latency needlessly degraded.

Note that expedited RCU grace periods look at context-tracking
information, and so if the CPU is executing in nohz_full usermode
throughout, that CPU cannot be victimized in this manner.

This commit therefore causes synchronize_rcu_expedited_wait to hold
the rcu_node structure's ->lock when checking for holdout CPUs, setting
TICK_DEP_BIT_RCU_EXP, and invoking tick_dep_set_cpu(), thus preventing
this race.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 249c2967d9e6..7cc4856da081 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -594,6 +594,7 @@ static void synchronize_rcu_expedited_wait(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root = rcu_get_root();
+	unsigned long flags;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_exp_jiffies_till_stall_check();
@@ -602,17 +603,17 @@ static void synchronize_rcu_expedited_wait(void)
 		if (synchronize_rcu_expedited_wait_once(1))
 			return;
 		rcu_for_each_leaf_node(rnp) {
+			raw_spin_lock_irqsave_rcu_node(rnp, flags);
 			mask = READ_ONCE(rnp->expmask);
 			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp = true;
-				preempt_disable();
 				if (cpu_online(cpu))
 					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
-				preempt_enable();
 			}
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 		j = READ_ONCE(jiffies_till_first_fqs);
 		if (synchronize_rcu_expedited_wait_once(j + HZ))
-- 
2.40.0.rc1.284.g88254d51c5-goog

