Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80202BD5A2;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=pV/kEGu4EHgdJQXbyxm9SJmYSV+dv8//Z/dA22C9YnUmaOFZaqHncT2vgsyPmXYX35Et7KdDVipOE5gLuyZdx8vt2jn63FSiCgm08LIuNutvxIRDD1mQuJORdNOrTwrA9cDnZ0L56swYeUOkXcQcByyxuV8QqoTILHUiYMEmA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=1F2Dota48fNMOMG+prFXxULTEjMwm4pw9eYEAGb2MqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcTCmZY7LPuzI2uI+rdoHRD3b8NoyQS/FURCWso3S2FpsMWut7g4qDDrAj2uAselUQe9U4vsID5B7bsV5aT3PSKWORyT2UxEHVcxfKJYtf+9FKx106l/igEOr1czSabHxMMeXStet2F+qjY2vfErh1yC6CnmUEBpPrcf3LYM73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InCRKSvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InCRKSvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65639C2BCB6;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=1F2Dota48fNMOMG+prFXxULTEjMwm4pw9eYEAGb2MqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InCRKSvfYpOox/bY9s1vopDyRlCruUv1OsPtKMkZznmc2icLdh3zzpx1849eO7nRd
	 nADpa0iPIwGho06ZIs/koMcoRr7bShwdRiSEDRnpUQtiOfdF7c50JjDTpM2741NKgd
	 8HBEcla+3p/coyawbAp2GcKijUR/fjtLm78rotPP3YyUFRrlx6naqbGEVIQ3lQEiOw
	 QaD1Uj+WGIhStoVE6kjMfXYRHyRQGEkpCPCiP4s+JkdnptLtvJCkiyByzXnKng9+qZ
	 OEK3pZ20UshAQfgPI8ZlgQPv0ahdJR9ThZ0RKjs3dn2FKl8TGnOKi3o07seH88G8vd
	 hV6lM+d2w7J/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F0B70CE1257; Sun,  2 Nov 2025 14:49:49 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/8] refscale: Add this_cpu_inc() readers
Date: Sun,  2 Nov 2025 14:49:45 -0800
Message-Id: <20251102224948.3906224-5-paulmck@kernel.org>
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

This commit adds refscale readers based on this_cpu_inc() and
this_cpu_inc() ("refscale.scale_type=percpuinc").  On my x86 laptop,
these are about 4.5ns per pair.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index ac9a0b6332ac..479d86cad652 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -330,6 +330,9 @@ static const struct ref_scale_ops rcu_trace_ops = {
 // Definitions for reference count
 static atomic_t refcnt;
 
+// Definitions acquire-release.
+static DEFINE_PER_CPU(unsigned long, test_acqrel);
+
 static void ref_refcnt_section(const int nloops)
 {
 	int i;
@@ -358,6 +361,34 @@ static const struct ref_scale_ops refcnt_ops = {
 	.name		= "refcnt"
 };
 
+static void ref_percpuinc_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		this_cpu_inc(test_acqrel);
+		this_cpu_dec(test_acqrel);
+	}
+}
+
+static void ref_percpuinc_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		this_cpu_inc(test_acqrel);
+		un_delay(udl, ndl);
+		this_cpu_dec(test_acqrel);
+	}
+}
+
+static const struct ref_scale_ops percpuinc_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= ref_percpuinc_section,
+	.delaysection	= ref_percpuinc_delay_section,
+	.name		= "percpuinc"
+};
+
 // Definitions for rwlock
 static rwlock_t test_rwlock;
 
@@ -501,9 +532,6 @@ static const struct ref_scale_ops lock_irq_ops = {
 	.name		= "lock-irq"
 };
 
-// Definitions acquire-release.
-static DEFINE_PER_CPU(unsigned long, test_acqrel);
-
 static void ref_acqrel_section(const int nloops)
 {
 	unsigned long x;
@@ -1298,7 +1326,7 @@ ref_scale_init(void)
 	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcu_fast_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
-		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
+		&percpuinc_ops, &acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&preempt_ops, &bh_ops, &irq_ops, &irqsave_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
-- 
2.40.1

