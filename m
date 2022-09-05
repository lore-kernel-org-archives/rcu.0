Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60407ECAAA1
	for <rcu@archiver.kernel.org>; Mon,  5 Sep 2022 03:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiIEDjP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 4 Sep 2022 23:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEDjO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 4 Sep 2022 23:39:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3B2ED50
        for <rcu@vger.kernel.org>; Sun,  4 Sep 2022 20:39:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so7039221pgs.3
        for <rcu@vger.kernel.org>; Sun, 04 Sep 2022 20:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rC6QPh/wv70zl3rSlxgqvQT2056BZtJ33zin0YGx0pI=;
        b=J4qPGfmpIIRZcQWl3gELg0nnnQoKgBkUmTHjIhufnFeoWu2aim27oZJaa/NXKMhlbd
         o5uLzwp1ayt9LaqTk163d4TM3pn5+o7qiIUhmJcoVopNkHdjGFO96e3/SuuCakriQWKw
         ss+xnDtdBDwIbsqdegrTQFTyGvS8O03J1WQ2gcssUqk1y9cyvP7gduHYtHrbiKHWNAMA
         7Obw362dPp2uJbl8HL3FgsMrwNzqtgJ7JVJhntyVt4G3+Jju/bW9/MjjBokTQnr4OE0z
         zIeejY51CcXIicGSX6svsZvueZ4+OmuGqrz1vLB1glAl/ehhVMoQMbkDqyRYq/zRghZ1
         UnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rC6QPh/wv70zl3rSlxgqvQT2056BZtJ33zin0YGx0pI=;
        b=B81Q0XQ8XXlGt+BI/ZNWKw6+pAr/+pZjc5eva/5diJVwwnbH0hLLJulzMj6Nxzo+XM
         1kprpbQMe5EpqFDRl3TYtXIJWM18iTfhIkH3lUza38Ikq3WRZnEi4SELxCiGb+41vYqd
         IljoXHIZZ+seQCt81T/IQ76JICeMvIJdIJDEgpbk19QrKR3FOt08cT7SMIVyCREVOp3s
         sce/tjlarivE5odLazntrrhFaWAjGlwj/ibyR36pMSbdFFakvdQLYDIUsWTkGFikkHmb
         hB+5Fdf3PAd2LnwYDKXi0LEfUlaFzJBEEUAKDktFAAW+MNkIAxdcRjVReVHuhIcQgqsf
         GU5g==
X-Gm-Message-State: ACgBeo033GbuXEbOSGakBAfMuK9GisZCWaO9k9UbzANp9D4Bnelg5SSR
        4i7GvM6T/DisFVJ5qW7/gjGDa7ul28naa4A=
X-Google-Smtp-Source: AA6agR4BiG7h3iIK8n8L34lUDPp7pOZhTVuBT5J5gSfmF0Z8Gs/aeHevZkCfO6QhlBR2aheb1N4PeQ==
X-Received: by 2002:a63:2048:0:b0:41c:daad:450d with SMTP id r8-20020a632048000000b0041cdaad450dmr39258797pgm.240.1662349151966;
        Sun, 04 Sep 2022 20:39:11 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o11-20020a62cd0b000000b0052cc561f320sm6403467pfg.54.2022.09.04.20.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 20:39:11 -0700 (PDT)
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
Subject: [PATCH 2/3] rcu: simplify the prototype of rcu_boost_kthread_setaffinity()
Date:   Mon,  5 Sep 2022 11:38:51 +0800
Message-Id: <20220905033852.18988-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220905033852.18988-1-kernelfans@gmail.com>
References: <20220905033852.18988-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Previously, the outgoing parameter is needed by rcutree_affinity_setting() since
when rcutree_offline_cpu() is called, ->qsmaskinitnext contains the outgoing cpu.

Now, it is not necessary and the prototype of
rcu_boost_kthread_setaffinity() can be simplified.

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
 kernel/rcu/tree.c        |  6 +++---
 kernel/rcu/tree_plugin.h | 12 +++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b90f6487fd45..f0535bd210b6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -145,7 +145,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
 static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
+static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
@@ -2170,7 +2170,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
 	/* Adjust any no-longer-needed kthreads. */
-	rcu_boost_kthread_setaffinity(rnp, -1);
+	rcu_boost_kthread_setaffinity(rnp);
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
@@ -3996,7 +3996,7 @@ int rcutree_online_cpu(unsigned int cpu)
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
-	rcu_boost_kthread_setaffinity(rdp->mynode, -1);
+	rcu_boost_kthread_setaffinity(rdp->mynode);
 
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 438ecae6bd7e..0bf6de185af5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1217,11 +1217,10 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
  * served by the rcu_node in question.  The CPU hotplug lock is still
  * held, so the value of rnp->qsmaskinit will be stable.
  *
- * We don't include outgoingcpu in the affinity set, use -1 if there is
- * no outgoing CPU.  If there are no CPUs left in the affinity set,
- * this function allows the kthread to execute on any CPU.
+ * If there are no CPUs left in the affinity set, this function allows the
+ * kthread to execute on any CPU.
  */
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp)
 {
 	struct task_struct *t = rnp->boost_kthread_task;
 	unsigned long mask = rcu_rnp_online_cpus(rnp);
@@ -1234,8 +1233,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		return;
 	mutex_lock(&rnp->boost_kthread_mutex);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
-		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
-		    cpu != outgoingcpu)
+		if ((mask & leaf_node_cpu_bit(rnp, cpu)))
 			cpumask_set_cpu(cpu, cm);
 	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
 	if (cpumask_empty(cm))
@@ -1261,7 +1259,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 }
 
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp)
 {
 }
 
-- 
2.31.1

