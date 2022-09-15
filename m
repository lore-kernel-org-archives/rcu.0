Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D553ECAAA1
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 05:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIOF7C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Sep 2022 01:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIOF7B (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Sep 2022 01:59:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC890199
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 22:59:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so16541651pjl.0
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=92owxcP8FsQYEgA9nCUUN+ZZEwVzMqZqaSjqiZXq0Co=;
        b=e9NJ1th2a1Xz9ysAot9r4SldrLzXY/TeA1dQehbT0bhVU/WVOQ2TOs28XsSbDZqeOO
         7PQ8mFK4NLpxhrYNbeTlS1cKPz4scGZivWsmitEkELb6ap5Bs0U1eWjnMXoZ6+P8CrST
         xX6hg9phfJIoxheNikGzhgNEziaCh0sEhXfDYjkK2INVzAXVv5cZ8GsQBl6hFmLsg7Rd
         9hC7cAHu1jDLpZtzEPwCjPjI+wU5tUq//i7Hl6V2X5FidT4ezC7Eyti0odS8fJ4AZo+n
         PFjhmu7qER5+EA//fNQOmr2afziVkmYxW6L+wrJhlheZ5BtcK01jmjLEipgxtAGHBuMS
         x0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=92owxcP8FsQYEgA9nCUUN+ZZEwVzMqZqaSjqiZXq0Co=;
        b=Gz5T2sHkt2QRIxqVEzc1vl8VRHv1p9xu1HfIu7ZmcgPkG3vlp6wpc6MxIR+zvm7YHr
         MDRhtAhFblEo+eIeuv5lE7qNw7vHFx4MK4/b+4hGgCaz/tMT5cqQe+Xg70vWyQ18C2ES
         DSfxMJmBclyFpLe3oCpteu3aElR3XdoJgPiuNZmSfRUdm77fK4WaQ33jaXOLemeTPvDw
         3kHKgHp8X4WF4xwaimrPqa/xB8inaaMVsziihp3AQBnxZZibPrNYllGoNJ3EhojPX21S
         o71iWhRQZq9aPfv7sXAsl5cH2nzKn8k35fr8Cyu+Er4lpJXaz6iC/egG/Y54vm6caoIC
         8NfQ==
X-Gm-Message-State: ACrzQf3IidK3zOtZs4gXyMqPK+VQr7cIRpjRIo+6q1/FH7w0AJcBVwnf
        Z1qRdgfPwqLplTF75OLxcVwZkcQnOQ==
X-Google-Smtp-Source: AMsMyM7X+WXO1r/aVIhvEvhzTl2fK7jdYGx2z4hjtMZ0h6cpyrKSknUXHgTN1rME/wnqewSUEBoYbw==
X-Received: by 2002:a17:903:41c8:b0:178:3128:b58a with SMTP id u8-20020a17090341c800b001783128b58amr2736955ple.118.1663221539317;
        Wed, 14 Sep 2022 22:58:59 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001768452d4d7sm11983386plg.14.2022.09.14.22.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 22:58:58 -0700 (PDT)
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
Subject: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
Date:   Thu, 15 Sep 2022 13:58:25 +0800
Message-Id: <20220915055825.21525-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220915055825.21525-1-kernelfans@gmail.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

As Paul pointed out  "The tick_dep_clear() is SMP-safe because it uses
atomic operations, but the problem is that if there are multiple
nohz_full CPUs going offline concurrently, the first CPU to invoke
rcutree_dead_cpu() will turn the tick off.  This might require an
atomically manipulated counter to mediate the calls to
rcutree_dead_cpu(). "

This patch introduces a new member ->dying to rcu_node, which reflects
the number of concurrent offlining cpu. TICK_DEP_BIT_RCU is set by
the first entrance and cleared by the last.

Note: now, tick_dep_set() is put under the rnp->lock, but since it takes
no lock, no extra locking order is introduced.

Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
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
 kernel/rcu/tree.c | 19 ++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8a829b64f5b2..f8bd0fc5fd2f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2164,13 +2164,19 @@ int rcutree_dead_cpu(unsigned int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
+	unsigned long flags;
+	u8 dying;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
-	// Stop-machine done, so allow nohz_full to disable tick.
-	tick_dep_clear(TICK_DEP_BIT_RCU);
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	dying = --rnp->dying;
+	if (!dying)
+		// Stop-machine done, so allow nohz_full to disable tick.
+		tick_dep_clear(TICK_DEP_BIT_RCU);
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	return 0;
 }
 
@@ -4020,17 +4026,20 @@ int rcutree_offline_cpu(unsigned int cpu)
 	unsigned long flags;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	u8 dying;
 
 	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->ffmask &= ~rdp->grpmask;
+	/* Let rcutree_dead_cpu() know a new offlining. */
+	dying = rnp->dying++;
+	if (!dying)
+		// nohz_full CPUs need the tick for stop-machine to work quickly
+		tick_dep_set(TICK_DEP_BIT_RCU);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	rcutree_affinity_setting(cpu, cpu);
-
-	// nohz_full CPUs need the tick for stop-machine to work quickly
-	tick_dep_set(TICK_DEP_BIT_RCU);
 	return 0;
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c..b508a12ac953 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -81,6 +81,7 @@ struct rcu_node {
 	int	grphi;		/* highest-numbered CPU here. */
 	u8	grpnum;		/* group number for next level up. */
 	u8	level;		/* root is at level 0. */
+	u8	dying;		/* num of concurrent rdp offlining */
 	bool	wait_blkd_tasks;/* Necessary to wait for blocked tasks to */
 				/*  exit RCU read-side critical sections */
 				/*  before propagating offline up the */
-- 
2.31.1

