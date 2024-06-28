Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533F1CAA2;
	Fri, 28 Jun 2024 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719548317; cv=none; b=ld9g1Gtuo2ziCTzowYrwQ8tDstyV8g3VB0H+rhliRuJIdsn+tPT6ClTRQYG0/e08V2KXMdv2YmOfbV9Dxwl5DSescas59rc2537+SnYE/V4RuWlW21gFK2SPQnOu138rqcjYRjDBGmcexknfCKb3U/YSWo6arCKXn3ftdCedhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719548317; c=relaxed/simple;
	bh=50jqPzDkQUKz1c/SNwg9W6ZkdpOJ1yleTDACudrtGuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHak9V9qNZ8S2VOZjvx0bjNctWdvjhiQdHX4WDPgNlqij9metzBXZ83BJ0ymB+XECIioQDNBXTlDL+RiTSZkRO6IsIVEYmtK2nAWr1jsvZqakVIqDBsgvflkBkoAk6qrQPuB4H/93JXefAuiwfCOC+zZ4JjrshmA6H6HpKfJjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id DEB54A9CFE;
	Fri, 28 Jun 2024 13:18:29 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WCCd8UzDQ9nd; Fri, 28 Jun 2024 13:18:29 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id A7B3FA9CF4;
	Fri, 28 Jun 2024 13:18:29 +0900 (JST)
From: takakura@valinux.co.jp
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH] rcu: Let rcu_dump_task() be used without preemption disabled
Date: Fri, 28 Jun 2024 13:18:26 +0900
Message-Id: <20240628041826.68587-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

The commit 2d7f00b2f0130 ("rcu: Suppress smp_processor_id() complaint
in synchronize_rcu_expedited_wait()") disabled preemption around
dump_cpu_task() to suppress warning on its usage within preemtible context.

Calling dump_cpu_task() doesn't required to be in non-preemptible context
except for suppressing the smp_processor_id() warning.
As the smp_processor_id() is evaluated along with in_hardirq()
to check if it's in interrupt context, this patch removes the need
for its preemtion disablement by reordering the condition so that
smp_processor_id() only gets evaluated when it's in interrupt context.

Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
---
 kernel/rcu/tree_exp.h | 2 --
 kernel/sched/core.c   | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8a1d9c8bd9f7..80c461b26144 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -617,9 +617,7 @@ static void synchronize_rcu_expedited_wait(void)
 				mask = leaf_node_cpu_bit(rnp, cpu);
 				if (!(READ_ONCE(rnp->expmask) & mask))
 					continue;
-				preempt_disable(); // For smp_processor_id() in dump_cpu_task().
 				dump_cpu_task(cpu);
-				preempt_enable();
 			}
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..38efbdafe3d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11485,7 +11485,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 void dump_cpu_task(int cpu)
 {
-	if (cpu == smp_processor_id() && in_hardirq()) {
+	if (in_hardirq() && cpu == smp_processor_id()) {
 		struct pt_regs *regs;
 
 		regs = get_irq_regs();
-- 
2.34.1

