Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7B5C433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023CB20866
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897662;
	bh=rGKklSf+KAEiImD/ndxXbwagP/8paMyPH/KVvGJiOv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sFXcGJLutoz0BzCwk0ZB3lMtrew0YlJDDhgci7rkrDVy64QQ/11nQVbnXQJoSFO80
	 vu+l/BbCaTqGf3DNsCYakqC4PgpHpNpc5MQjUkdi+mST7Dqx8CwCY6y9Ru/IZ4Ohgb
	 UenDp2gtsHeGlcsugB0+f4JsfQmIq/E6lMSJqV/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgHaSOV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgHaSOT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:14:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6EF820EDD;
        Mon, 31 Aug 2020 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897659;
        bh=rGKklSf+KAEiImD/ndxXbwagP/8paMyPH/KVvGJiOv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJJPXrOhpnefddVTdKSPoKk4HEC8mNC+5CbY2ITFa/X7U1lSsXfK0QnJK6xJsNyIF
         5pz5Pnyv7ON1hvzNrKPd611zVQXe+rMcS0GpO2621KZkLBGOpvFU6Z18e8yvRjbbho
         iW0s8v0l4t/bsCXAyDPZrTKaW1y4A7J0oa6zFpKg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] smp: Add source and destination CPUs to __call_single_data
Date:   Mon, 31 Aug 2020 11:14:15 -0700
Message-Id: <20200831181417.1378-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181356.GA1224@paulmck-ThinkPad-P72>
References: <20200831181356.GA1224@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a destination CPU to __call_single_data, and is inspired
by an earlier commit by Peter Zijlstra.  This version adds #ifdef to
permit use by 32-bit systems and supplying the destination CPU for all
smp_call_function*() requests, not just smp_call_function_single().

If need be, 32-bit systems could be accommodated by shrinking the flags
field to 16 bits (the atomic_t variant is currently unused) and by
providing only eight bits for CPU on such systems.

It is not clear that the addition of the fields to __call_single_node
are really needed.

Link: https://lore.kernel.org/lkml/20200615164048.GC2531@hirez.programming.kicks-ass.net/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/smp.h       | 3 +++
 include/linux/smp_types.h | 3 +++
 kernel/smp.c              | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 80d557e..9f13966 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -26,6 +26,9 @@ struct __call_single_data {
 		struct {
 			struct llist_node llist;
 			unsigned int flags;
+#ifdef CONFIG_64BIT
+			u16 src, dst;
+#endif
 		};
 	};
 	smp_call_func_t func;
diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
index 364b3ae..2e8461a 100644
--- a/include/linux/smp_types.h
+++ b/include/linux/smp_types.h
@@ -61,6 +61,9 @@ struct __call_single_node {
 		unsigned int	u_flags;
 		atomic_t	a_flags;
 	};
+#ifdef CONFIG_64BIT
+	u16 src, dst;
+#endif
 };
 
 #endif /* __LINUX_SMP_TYPES_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index d0ae8eb..a47382d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -375,6 +375,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
 	csd->func = func;
 	csd->info = info;
+	csd->dst = cpu;
 
 	err = generic_exec_single(cpu, csd);
 
@@ -540,6 +541,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
+		csd->dst = cpu;
 		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
-- 
2.9.5

