Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66F80C0C;
	Fri, 16 Aug 2024 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788888; cv=none; b=qPq1YdBKKVTi36ir2e40934I+QHNvzZuT4KfsoPbTKMkw/nGoFo6JTS0iehZzaQrZoa2vWg1SQwhQbvTIFZ82IoNMOSi3ghSdX1IJDRWfgWGb7tE3aYdm6iSpWeGDFSxAmnoVZWkVdqBimxZdIjLSQnrU2O/qptoIMKWIpHB1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788888; c=relaxed/simple;
	bh=IX21ZbjyaTwTK68KfByMdmzZ2IeYlI7XNFXs1WUQi44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTWO5UHNmrY5vzt8/OSYZEMIYq+oGrfcEr7eiz+iLjiKL5OS86Ek3405qQnt2A1b/a/nTaQ5RBjGNr5uDeWx72Ts0AEnRzBsb7pFp2Wgf62K59Zas5JS0FeQJBFPKDs3sNkAlrtElvloytluj5hGcTQLn91QbVAk1btFWClJ3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYvAYCti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYvAYCti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AF2C32782;
	Fri, 16 Aug 2024 06:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723788887;
	bh=IX21ZbjyaTwTK68KfByMdmzZ2IeYlI7XNFXs1WUQi44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYvAYCti06hgDC9rKiUB5bmRSxRMhbHsbjvsyP9rk6qW12cVp8pqB6m9KZCz7W4vK
	 QrzOunJED+geNVtykKKW8uTlDV6WFQts9qKEYpunZQYdI73DiYuKqEMLmjkRd1UGgX
	 ywdD9qyxqM6xPc8j/5L9ccl2ng9N90+ihaEY+g7Bk34apuETf20ZYxoZikj/V7gyhZ
	 iK6BN1RiY1iGqQhJNl1L/WmwasnCLDVPmVlstfidN0Ek54gjhdfJaOdvFF12ybquyH
	 HW13GBVt2kC0BQlh3pT6s4VhtGfrOyQfqY/p8/9W9x1Sma4vTAwnVAi3n0LLkQOQIx
	 JNQ5CXTcgM5Ug==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH rcu 4/4] rcu: Let dump_cpu_task() be used without preemption disabled
Date: Fri, 16 Aug 2024 11:43:04 +0530
Message-Id: <20240816061304.48843-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816061050.GA46994@neeraj.linux>
References: <20240816061050.GA46994@neeraj.linux>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 --
 kernel/sched/core.c   | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d4be644afb50..c5d9a7eb0803 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -597,9 +597,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
 			mask = leaf_node_cpu_bit(rnp, cpu);
 			if (!(READ_ONCE(rnp->expmask) & mask))
 				continue;
-			preempt_disable(); // For smp_processor_id() in dump_cpu_task().
 			dump_cpu_task(cpu);
-			preempt_enable();
 		}
 		rcu_exp_print_detail_task_stall_rnp(rnp);
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9f655025607..78ae888a1fa2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9726,7 +9726,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 void dump_cpu_task(int cpu)
 {
-	if (cpu == smp_processor_id() && in_hardirq()) {
+	if (in_hardirq() && cpu == smp_processor_id()) {
 		struct pt_regs *regs;
 
 		regs = get_irq_regs();
-- 
2.40.1

