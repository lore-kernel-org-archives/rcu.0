Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAB29E113;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=q/Ug7UKUK+bsHMr+MyaFKGSPgvakJ5UrZ2QPPmoGih0Kaep+P2dJ4S2re/cEjaH8SK/BU3dsHABi1BHLpYGPgia2rRCMoC+81hb04maKRukBBdklidWaI9lJrJkSLHOgdT8UlWk/ireMOoUfSu9YMcVSMMA+Xrbp4Qtp/dMDsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=rAn+D1aKec9450avC0ni1vP7cPV1yyUFx1owntShnrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNn+mBNOwu/ejc2nQ+mgqzb88Xnl+J7l3xo2bHhfjSv7znNowJgHngiZYiuyHaModkbSBoopIYT9bXB+V3+Z9g3LPK1rsPWBfc7I/GxLXTs1icK/Q335nKj2BR4mj2Mcl5Ce0r7CIhKQBt8G6HQHcOIsqMuW3G8qD3xs3ENS5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCWh5bCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCWh5bCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C6BC19423;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=rAn+D1aKec9450avC0ni1vP7cPV1yyUFx1owntShnrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCWh5bCooV/BYDOiUgheIY7JAnyKGdfFKWJCw+z5Jz2LxF41Duczb2nhMfaHBjFX5
	 R33EGyxiiY6RRSYF02QTwnAvXuJF606g3wxJR05l5yO3zjiZVzTNqm/ATCEzuCFXz2
	 YF2d7vjgAAaHbWIXtL3j0wilbmwtG0RM0mAgOpMUAPxdgzn4fJqfIfZSbV4kNq+AnU
	 jJYfLoGNzQGPPnisai7w/rIe8uPbrfgTNFV+hrPEoYwaO+4cX5uM2oNGVoYeTpJBCg
	 yQSnrhTCXeKV3T42sslsIyRIQTc3Q7YFvTRCCiqx3Abe12LyjRCkXd/Ufrb6PrGlgP
	 0gLDHv0HCzaUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F33F4CE12A7; Sun,  2 Nov 2025 14:49:49 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 6/8] refscale: Add non-atomic per-CPU increment readers
Date: Sun,  2 Nov 2025 14:49:46 -0800
Message-Id: <20251102224948.3906224-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds refscale readers based on READ_ONCE() and WRITE_ONCE()
that are unprotected (can lose counts, "refscale.scale_type=incpercpu"),
preempt-disabled ("refscale.scale_type=incpercpupreempt"),
bh-disabled ("refscale.scale_type=incpercpubh"), and irq-disabled
("refscale.scale_type=incpercpuirqsave").  On my x86 laptop, these are
about 4.3ns, 3.8ns, and 7.3ns per pair, respectively.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 155 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 479d86cad652..2b247355de40 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -389,6 +389,155 @@ static const struct ref_scale_ops percpuinc_ops = {
 	.name		= "percpuinc"
 };
 
+// Note that this can lose counts in preemptible kernels.
+static void ref_incpercpu_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		unsigned long *tap = this_cpu_ptr(&test_acqrel);
+
+		WRITE_ONCE(*tap, READ_ONCE(*tap) + 1);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) - 1);
+	}
+}
+
+static void ref_incpercpu_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		unsigned long *tap = this_cpu_ptr(&test_acqrel);
+
+		WRITE_ONCE(*tap, READ_ONCE(*tap) + 1);
+		un_delay(udl, ndl);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) - 1);
+	}
+}
+
+static const struct ref_scale_ops incpercpu_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= ref_incpercpu_section,
+	.delaysection	= ref_incpercpu_delay_section,
+	.name		= "incpercpu"
+};
+
+static void ref_incpercpupreempt_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		unsigned long *tap;
+
+		preempt_disable();
+		tap = this_cpu_ptr(&test_acqrel);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) + 1);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) - 1);
+		preempt_enable();
+	}
+}
+
+static void ref_incpercpupreempt_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		unsigned long *tap;
+
+		preempt_disable();
+		tap = this_cpu_ptr(&test_acqrel);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) + 1);
+		un_delay(udl, ndl);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) - 1);
+		preempt_enable();
+	}
+}
+
+static const struct ref_scale_ops incpercpupreempt_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= ref_incpercpupreempt_section,
+	.delaysection	= ref_incpercpupreempt_delay_section,
+	.name		= "incpercpupreempt"
+};
+
+static void ref_incpercpubh_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		unsigned long *tap;
+
+		local_bh_disable();
+		tap = this_cpu_ptr(&test_acqrel);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) + 1);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) - 1);
+		local_bh_enable();
+	}
+}
+
+static void ref_incpercpubh_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		unsigned long *tap;
+
+		local_bh_disable();
+		tap = this_cpu_ptr(&test_acqrel);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) + 1);
+		un_delay(udl, ndl);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) - 1);
+		local_bh_enable();
+	}
+}
+
+static const struct ref_scale_ops incpercpubh_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= ref_incpercpubh_section,
+	.delaysection	= ref_incpercpubh_delay_section,
+	.name		= "incpercpubh"
+};
+
+static void ref_incpercpuirqsave_section(const int nloops)
+{
+	int i;
+	unsigned long flags;
+
+	for (i = nloops; i >= 0; i--) {
+		unsigned long *tap;
+
+		local_irq_save(flags);
+		tap = this_cpu_ptr(&test_acqrel);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) + 1);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) - 1);
+		local_irq_restore(flags);
+	}
+}
+
+static void ref_incpercpuirqsave_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	unsigned long flags;
+
+	for (i = nloops; i >= 0; i--) {
+		unsigned long *tap;
+
+		local_irq_save(flags);
+		tap = this_cpu_ptr(&test_acqrel);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) + 1);
+		un_delay(udl, ndl);
+		WRITE_ONCE(*tap, READ_ONCE(*tap) - 1);
+		local_irq_restore(flags);
+	}
+}
+
+static const struct ref_scale_ops incpercpuirqsave_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= ref_incpercpuirqsave_section,
+	.delaysection	= ref_incpercpuirqsave_delay_section,
+	.name		= "incpercpuirqsave"
+};
+
 // Definitions for rwlock
 static rwlock_t test_rwlock;
 
@@ -1325,8 +1474,10 @@ ref_scale_init(void)
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcu_fast_ops, RCU_TRACE_OPS RCU_TASKS_OPS
-		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
-		&percpuinc_ops, &acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
+		&refcnt_ops, &percpuinc_ops, &incpercpu_ops, &incpercpupreempt_ops,
+		&incpercpubh_ops, &incpercpuirqsave_ops,
+		&rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
+		&sched_clock_ops, &clock_ops, &jiffies_ops,
 		&preempt_ops, &bh_ops, &irq_ops, &irqsave_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
-- 
2.40.1

