Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62145ECAAA1
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 05:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiIOF6z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Sep 2022 01:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIOF6y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Sep 2022 01:58:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F6790199
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 22:58:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h188so16334580pgc.12
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LLHYN7LHMfNXPe81ykcurF/+WoxshOqmmf34A1mIGv8=;
        b=JKPnb9Nk7w/Ri8Fsc3ZZ6kv/3ySZSfvr/cZcjTfZZc6Gt8PiyTeyq5Xo0cBrXU9qbe
         2h5vd7obJfefxDmzOsrNCmBK6W5iEIlmi6PfpOEqoprDbm6wuMpV7l9COPwlze18hfND
         Fbq37rsbfzTfaC9/IUGwZCyb/sOsbn5lBeF4OzmeGVHQghSB9/sZQ7RBOP5qMzZSPYPs
         REXYsUzEfPLOQaqPUn/cTXAl5mDY/EEpyr+KKPRL8L35PA2B6im6GKH5azw7C/1ugcph
         j9GAbRIOPO0u4RAYL/jKGch8dmR1ifBpb6sa9wTwcSopOYz1vx419/VpDLeZuvOckpTK
         YzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LLHYN7LHMfNXPe81ykcurF/+WoxshOqmmf34A1mIGv8=;
        b=YTDuNIP22FrB0h0OB+heue3IrCf2tJNu2AXySCylGblAxgU6Lr7PVti30PIA+OV/PK
         L6yuwm4pYP9WPTJp2rQXGCfHADFQwpPVFiPqXv/SwFTkKjbgYMX/DE0UVAxST2IlJYGD
         6m5u0kG6vd0XKq3fEZ0bvQLvmWEJx+CXmBl7zg3qpswRSfF0ghW5u8YC7lSEheetOFPL
         dDhwMBFWc5H+O4nvu0to7uBgYtRe9Ut75McY9KHiYfsai5fRJdc410whkYk308Y7Grwq
         24QPzYyt/rmz6EE8hLq25PYLB6t+CCrzCWuI3WAgDE6mpNNvbROF3OsjUj1tCWcDKHuG
         5o3w==
X-Gm-Message-State: ACgBeo1hWd96g3ppNV+4nd8kFfjvXzL/ZnI6KP2Qqh3dYeXaU3Wo22Jc
        DgA9g3uw7CWXkiiadS+m0Jh8daCatQ==
X-Google-Smtp-Source: AA6agR4sNzdf2IJ7GtDQBMcr07zBfOEMD9r/xyp41fZNdXJT57R8qeDXqC3QVkGADxaIlApG97Y3TQ==
X-Received: by 2002:aa7:9717:0:b0:53e:84e4:dceb with SMTP id a23-20020aa79717000000b0053e84e4dcebmr39026695pfg.48.1663221533072;
        Wed, 14 Sep 2022 22:58:53 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001768452d4d7sm11983386plg.14.2022.09.14.22.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 22:58:52 -0700 (PDT)
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
Subject: [PATCHv2 2/3] rcu: Resort to cpu_dying_mask for affinity when offlining
Date:   Thu, 15 Sep 2022 13:58:24 +0800
Message-Id: <20220915055825.21525-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220915055825.21525-1-kernelfans@gmail.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During offlining, the concurrent rcutree_offline_cpu() can not be aware
of each other through ->qsmaskinitnext.  But cpu_dying_mask carries such
information at that point and can be utilized.

Besides, a trivial change which removes the redudant call to
rcu_boost_kthread_setaffinity() in rcutree_dead_cpu() since
rcutree_offline_cpu() can fully serve that purpose.

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
 kernel/rcu/tree.c        | 2 --
 kernel/rcu/tree_plugin.h | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345..8a829b64f5b2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2169,8 +2169,6 @@ int rcutree_dead_cpu(unsigned int cpu)
 		return 0;
 
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
-	/* Adjust any no-longer-needed kthreads. */
-	rcu_boost_kthread_setaffinity(rnp, -1);
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ef6d3ae239b9..e5afc63bd97f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1243,6 +1243,12 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		    cpu != outgoingcpu)
 			cpumask_set_cpu(cpu, cm);
 	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
+	/*
+	 * For concurrent offlining, bit of qsmaskinitnext is not cleared yet.
+	 * So resort to cpu_dying_mask, whose changes has already been visible.
+	 */
+	if (outgoingcpu != -1)
+		cpumask_andnot(cm, cm, cpu_dying_mask);
 	if (cpumask_empty(cm))
 		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
 	set_cpus_allowed_ptr(t, cm);
-- 
2.31.1

