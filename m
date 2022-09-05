Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0178ECAAA1
	for <rcu@archiver.kernel.org>; Mon,  5 Sep 2022 03:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiIEDjM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 4 Sep 2022 23:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEDjK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 4 Sep 2022 23:39:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83EF2ED7D
        for <rcu@vger.kernel.org>; Sun,  4 Sep 2022 20:39:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b144so2657264pfb.7
        for <rcu@vger.kernel.org>; Sun, 04 Sep 2022 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6COL0uv9jVcnHwrCkLTkl2eKFIaAF2AYoaUOPinQbCw=;
        b=CIyIOtpNS+IsSU8H/N8UqA2zWuyWLg8ivovPZmtoqpWgf45hb1DprECphVjg/KLdEE
         198ea74fVkKtLrKYyD/+cFDHLREQjVGND3HVrUBUpNK8uo16Sctmt1U3Ww1KP5GqtY76
         cxnd7oLGKxP9CU2fEUxRvHi0Fq9kUt0ZgEclgFvSIbLcY+3heLuYf8wSnLP0rqlplmeD
         QE8AfSaQSC6y96OuZryl0vB788SLSVrbTJZ6ZoF423bTW+W3PYdVO9+NaS2CuzxSFAqu
         C+BoRwBiy/6KG06JghYi62BOEkFKs3QNoXMvMGzoQ1AyLs0yUJ2QL7zlchBhR9OXihP6
         H+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6COL0uv9jVcnHwrCkLTkl2eKFIaAF2AYoaUOPinQbCw=;
        b=RaoYiC+nxMFZWcQoW+VEFHyGHiyfe9bVcwjzYtxubY7UnpDq84nC8w6NwLyYfEBISg
         HlwAlqXEUQM16tWEyQIyv4aGNGKeHLNIPlRzq7d0cF3ZQaO24PwflZHZ04B5KItnCX0m
         6Q0Y+f9I1YhSm+g/AY9QT3/bQl8pYqmyQKVXU5Mw68N5XocfpUhiwUEA5Xh8Hx5aJoK8
         io54C+A/9NVQarGFBQ0TThs++nbDBYRCRCWnb095E+X0u4LqV/GKN67eCbDKI+/I4TSg
         QCs5xTOwvUteHePuJrhqtmOlpPPhTs50pWuJwN4wDHrRwejwkueFoKVqSsP7s59/QqZl
         kBBQ==
X-Gm-Message-State: ACgBeo2zGaZsuFyp/k9uEYCT5FKRxPBz0CruSJRfcrf4lJIsdvAjt0Vw
        1iwhtkGUVcFOD5OjfOurR3ukXarcKqqjlkw=
X-Google-Smtp-Source: AA6agR42MFhwCDd07hV2TrxxYh20m6w7qAggUA+kTH70qvW+lE39nZa/UTqgBj1JriqphwLQyc1OPA==
X-Received: by 2002:a63:be0f:0:b0:434:2d63:5036 with SMTP id l15-20020a63be0f000000b004342d635036mr5921383pgf.488.1662349148205;
        Sun, 04 Sep 2022 20:39:08 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o11-20020a62cd0b000000b0052cc561f320sm6403467pfg.54.2022.09.04.20.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 20:39:07 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/3] rcu: remove redundant cpu affinity setting during teardown
Date:   Mon,  5 Sep 2022 11:38:50 +0800
Message-Id: <20220905033852.18988-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

At present, during the cpu teardown, rcu_boost_kthread_setaffinity() is
called twice. Firstly by rcutree_offline_cpu(), then by
rcutree_dead_cpu() as the CPUHP_RCUTREE_PREP  cpuhp_step callback.

From the scheduler's perspective, a bit in cpu_online_mask means that the cpu
is visible to the scheduler. Furthermore, a bit in cpu_active_mask
means that the cpu is suitable as a migration destination.

Now turning back to the case in rcu offlining. sched_cpu_deactivate()
has disabled the dying cpu as the migration destination before
rcutree_offline_cpu().  Furthermore, if the boost kthread is on the dying
cpu, it will be migrated to another suitable online cpu by the scheduler.
So the affinity setting by rcutree_offline_cpu() is redundant and can be
eliminated.

Besides, this patch does an trival code rearrangement by unfolding
rcutree_affinity_setting() into rcutree_online_cpu(), considering that
the latter one is the only user of the former.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/tree.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345..b90f6487fd45 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3978,16 +3978,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Update RCU priority boot kthread affinity for CPU-hotplug changes.
- */
-static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-
-	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
-}
-
 /*
  * Near the end of the CPU-online process.  Pretty much all services
  * enabled, and the CPU is now very much alive.
@@ -4006,7 +3996,7 @@ int rcutree_online_cpu(unsigned int cpu)
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
-	rcutree_affinity_setting(cpu, -1);
+	rcu_boost_kthread_setaffinity(rdp->mynode, -1);
 
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
@@ -4029,8 +4019,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	rnp->ffmask &= ~rdp->grpmask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
-	rcutree_affinity_setting(cpu, cpu);
-
 	// nohz_full CPUs need the tick for stop-machine to work quickly
 	tick_dep_set(TICK_DEP_BIT_RCU);
 	return 0;
-- 
2.31.1

