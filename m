Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9E2BE7C3;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154354; cv=none; b=BQhYQAjckH7WTfjKe/6r4ElWXx3V45atlKHZKZ94dkPR8S+uRmRuuMhdsw5/el7FFXnu+0QIGg6CceIqL/h19cBv2Kyss0GFbHGjkX3SUoUtsyVsS4QE00p12ZpZUagLGz52iOKsoszx4wdj6Lb2vxZSMI+IcGaeGtb9se+BAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154354; c=relaxed/simple;
	bh=QSNK7smghetxwTK4O0dGzA6u/s8ZwbjtzYihf+jP9hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAZVavAa6Jp6sGHnSojAxN7c9xewkE8qtqCbc9ZSsnOVosfmm5KuylHO7F9aRFEOsxv7tpup0L1lY0obKNyAE2TaY7CVeNhaWLhvrUCzfevOVYpA+iJFSnTMUiUFelN+GaR+RsM1YSUT/oFbYCh9d/iq9znc4WSG1dY9isleob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb3eJfad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb3eJfad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CCEC19425;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154354;
	bh=QSNK7smghetxwTK4O0dGzA6u/s8ZwbjtzYihf+jP9hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sb3eJfadfbdZf4W+HdKeBdXRa8rwC0JrRf03zVFFXGf6lwsFZ/ldpCceh1b1ynSrR
	 vkQJH/VMWcFhjh76JhOrPRgAyebVN3qDt7LQzMh0hXN7f53SKVhkYoqEw88cfvU4nC
	 D+4bqlHS/QaptVzXEmxkEEIsEh1EAD2F7brZuEex51LLg0C1pQfMa4BbFCEGOra/FD
	 IAebUtbo0unNpfWpKN5VIN47Do1uTJ5hkjT5t7zdOghOfVw3EGYZw4PFI2ao2+BgmC
	 22cQe/olaYsGnYSo2ZQ8DwIqezx33tG91EuVV+hXsbtVqf1E8tHZtJDrumR4kcem9f
	 FG7Usq7aDZV6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E8DFFCE0FF8; Sun,  2 Nov 2025 14:49:49 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/8] refscale: Add local_irq_disable() and local_irq_save() readers
Date: Sun,  2 Nov 2025 14:49:42 -0800
Message-Id: <20251102224948.3906224-2-paulmck@kernel.org>
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

This commit adds refscale readers based on local_irq_disable() and
local_irq_enable() ("refscale.scale_type=irq") and on local_irq_save()
and local_irq_restore ("refscale.scale_type=irqsave").  On my x86 laptop,
these are about 2.8ns and 7.5ns per enable/disable pair, respectively.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 66 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index ece77f6d055b..266a3fa94b54 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -636,6 +636,70 @@ static const struct ref_scale_ops jiffies_ops = {
 	.name		= "jiffies"
 };
 
+static void ref_irq_section(const int nloops)
+{
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		local_irq_disable();
+		local_irq_enable();
+	}
+	preempt_enable();
+}
+
+static void ref_irq_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		local_irq_disable();
+		un_delay(udl, ndl);
+		local_irq_enable();
+	}
+	preempt_enable();
+}
+
+static const struct ref_scale_ops irq_ops = {
+	.readsection	= ref_irq_section,
+	.delaysection	= ref_irq_delay_section,
+	.name		= "irq"
+};
+
+static void ref_irqsave_section(const int nloops)
+{
+	unsigned long flags;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		local_irq_save(flags);
+		local_irq_restore(flags);
+	}
+	preempt_enable();
+}
+
+static void ref_irqsave_delay_section(const int nloops, const int udl, const int ndl)
+{
+	unsigned long flags;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		local_irq_save(flags);
+		un_delay(udl, ndl);
+		local_irq_restore(flags);
+	}
+	preempt_enable();
+}
+
+static const struct ref_scale_ops irqsave_ops = {
+	.readsection	= ref_irqsave_section,
+	.delaysection	= ref_irqsave_delay_section,
+	.name		= "irqsave"
+};
+
 ////////////////////////////////////////////////////////////////////////
 //
 // Methods leveraging SLAB_TYPESAFE_BY_RCU.
@@ -1172,7 +1236,7 @@ ref_scale_init(void)
 	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcu_fast_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
-		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
+		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops, &irq_ops, &irqsave_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
 
-- 
2.40.1

