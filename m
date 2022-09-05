Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6ECECAAA1
	for <rcu@archiver.kernel.org>; Mon,  5 Sep 2022 03:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiIEDjT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 4 Sep 2022 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEDjS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 4 Sep 2022 23:39:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F272ED50
        for <rcu@vger.kernel.org>; Sun,  4 Sep 2022 20:39:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b196so7024094pga.7
        for <rcu@vger.kernel.org>; Sun, 04 Sep 2022 20:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qxkPzWWZI92LxvOm1fKr9hzMe+kooWrVanvPGMIZF1Y=;
        b=hRKyV0j0Vpa127A0xdJNV/mPFlFEPGv7yHytbIw8lt3bStgKQ2hH/Sp7EbgkQ+2KMY
         JKmqU8jJwn8Zw0XBa0c9h3PVmjev2Ztf756o7ew8dVBtX6JvJ3nxvsbM8oIHigCMF1g7
         3jfJuS64h8GjrAsX+jDKly6g53O3VtfRtsjXRszX2dS5PNEDa2vznif6vod0L+ttFMYW
         3/LZtaWyJC1UehsLY1C9gjuU7biiXBJ+LFhLtYiOX/81TN6nC8nQeT3xDnd+qlFZm9Vl
         M+1S55OgW1awoxzE9NuAQA2HQSAbG+gRllD8LmJq4larksV2NZvSgpgHhv5I8yBd23c+
         3SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qxkPzWWZI92LxvOm1fKr9hzMe+kooWrVanvPGMIZF1Y=;
        b=a6RFqGRYVphexqoJehw54e/YZYW9TkhappSkpAoGP/ACOWTobA5JDKYPVJXdyedUuF
         H6pclHZB2ceOolN97jMHQnLnUd9GUGtSOsi8kK0nY+rH7+3KP1Q9ky/6gcVXL6P8Jaix
         txTlpmhuk+ECoP2kvc8QpUExgvI4A7pvBRO5CYSTQt10Yazpf1jPnc2gTdqm3UXhRCgQ
         uv+7e73InznpQBRh8r99RtuZ1FO09gP6ld1C9OmGrd18wf3uNsAAdl8MzvwvoUACa78T
         1vzW6Qq7dUvFPVfYxLMldp+2pFSjnKUG7h/SGCRu0q9rLYuNWr8qCETD2k5j4/h4ozOE
         FpKw==
X-Gm-Message-State: ACgBeo1+l8U449GPqYR35MMgR2744/GIQwEg2ISknhQ75//BskbbOKL3
        UhPX90a2XTm/z3aweaGgwz1L3CdlT001QUo=
X-Google-Smtp-Source: AA6agR4LLcd9oIDcxCtr/9bJXEI8SFWV1McZoV8UoI6XCXklpXIkxDjyrq6vnhXNIs9kD+PISpsSjA==
X-Received: by 2002:a63:5007:0:b0:42a:29:2780 with SMTP id e7-20020a635007000000b0042a00292780mr39591460pgb.45.1662349155957;
        Sun, 04 Sep 2022 20:39:15 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o11-20020a62cd0b000000b0052cc561f320sm6403467pfg.54.2022.09.04.20.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 20:39:15 -0700 (PDT)
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
Subject: [PATCH 3/3] rcu: Keep qsmaskinitnext fresh for rcu_boost_kthread_setaffinity()
Date:   Mon,  5 Sep 2022 11:38:52 +0800
Message-Id: <20220905033852.18988-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220905033852.18988-1-kernelfans@gmail.com>
References: <20220905033852.18988-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcutree_online_cpu() is concurrent, so there is the following race
scene:

        CPU 1                               CPU2
mask_old = rcu_rnp_online_cpus(rnp);
...

                                   mask_new = rcu_rnp_online_cpus(rnp);
                                   ...
                                   set_cpus_allowed_ptr(t, cm);

set_cpus_allowed_ptr(t, cm);

Consequently, the old mask will overwrite the new mask in the task's cpus_ptr.

Since there is a mutex ->boost_kthread_mutex, using it to build an
order, then the latest ->qsmaskinitnext will be fetched for updating cpus_ptr.

Notes about the cpu teardown: The cpu hot-removing initiator executes
rcutree_dead_cpu() for the teardown cpu. If in future, an initiator can
hot-remove several cpus at a time, it executes rcutree_dead_cpu() in
series for each cpu. So it is still race-free without the mutex.  But
considering this is a cold path, applying that redundant mutex is
harmless.

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
 kernel/rcu/tree_plugin.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0bf6de185af5..b868ac6c6ac8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1223,7 +1223,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp)
 {
 	struct task_struct *t = rnp->boost_kthread_task;
-	unsigned long mask = rcu_rnp_online_cpus(rnp);
+	unsigned long mask;
 	cpumask_var_t cm;
 	int cpu;
 
@@ -1232,6 +1232,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp)
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
 	mutex_lock(&rnp->boost_kthread_mutex);
+	/*
+	 * Relying on the lock to serialize, so the latest qsmaskinitnext is for
+	 * cpus_ptr.
+	 */
+	mask = rcu_rnp_online_cpus(rnp);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)))
 			cpumask_set_cpu(cpu, cm);
-- 
2.31.1

