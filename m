Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152C3FCB03;
	Thu,  7 May 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172678; cv=none; b=dLhVCiKdA4ET8xM+IdEdXOF+VV6D3oBldNI7QrALMql8a88wP+b5GMW4R3Sd8NYEWb84UZ7EXi8mLZN405TFevj9gjLmt3NhqYXDGvSDDtdviNetOF5tS53bBP0/x1JQWaryuFkY2cWYS78BD88P+Cyw/SPjdh8Gsle2eVAaXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172678; c=relaxed/simple;
	bh=lr0xdIdDI31fTQQCHgc1R9osfRZceuX3vZywvp6dVSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pjeRC057g1P11v+PpGGstyvawaf5bEAOwIPlHCEleoHgiaPnUVOT7OuWssus16ZMITtU/vbUM9lCTSJdQL1hzpo53faY1+zpK4RSMJCxC2x7mO/A5L0Re9Pn9d/fdIy+5PxTroP1xkoWKhuOaAPjAj69Njkwketui2p6N0bz9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxwVjtBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxwVjtBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27213C2BCB2;
	Thu,  7 May 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778172678;
	bh=lr0xdIdDI31fTQQCHgc1R9osfRZceuX3vZywvp6dVSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxwVjtBOTNM9O1I5iekZ6Njngnqrny2aHNepyhjl+yvjE8dvnPeuyUk/m5cnWfYC7
	 eiHvlqawUCmjNyoTWeZ1ckPjcPsa2QQ0coRvqNHir2Ymo8b6U7wrCIIvheSNxXVWO8
	 kZIO0n98Rn55v0D95TuQzcpBWC/1JKAWCOmjcKFcT0KbPDg76sa/h3uh5xK6fmeQFL
	 6gevyrPrlkeVvX5lZlACWtNrSx1xo+c/dsi6nU1XBwqiWNMCemWScsnLmiD6fImU7g
	 NJGUdmk6s8ic2WgSFQnowJl8B7gr3NiBWV6mpef/PdzR/KR/I42qtx4dNqNzOmP20d
	 PK0ybr50l9P3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6D5ECE0863; Thu,  7 May 2026 09:51:17 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 2/4] hazptrtorture: Add testing of on-stack hazptr_ctx structures
Date: Thu,  7 May 2026 09:51:11 -0700
Message-Id: <20260507165113.2039524-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <5bfe6ac9-432e-43b8-8290-59ca249b0f80@paulmck-laptop>
References: <5bfe6ac9-432e-43b8-8290-59ca249b0f80@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a test using on-stack hazptr_ctx structures, in contrast
with the per-CPU structures used by the initial test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c                    | 48 +++++++++++++++----
 .../rcutorture/configs/hazptr/NOPREEMPT.boot  |  1 +
 2 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 1949a8da4f8c9d..1a61d35ade1d9d 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -30,9 +30,10 @@ MODULE_DESCRIPTION("Hazard-pointer module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmckrcu@meta.com>");
 
-torture_param(int, irqreader, 1, "Allow hazard-pointer readers from irq handlers");
+// @@@ torture_param(int, irqreader, 1, "Allow hazard-pointer readers from irq handlers");
 // @@@ torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
+// @@@ Does testing CPU hotplug make sense for hazard pointers?
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
 // @@@ Move the rcu_torture_preempt() function and friends to kernel/torture.c.
@@ -194,7 +195,8 @@ struct hazptr_torture_ops {
 static struct hazptr_torture_ops *cur_ops;
 
 /*
- * Definitions for hazard-pointer torture testing.
+ * Definitions for hazard-pointer torture testing using per-CPU hazptr_ctx
+ * structures.
  */
 
 static struct hazptr_torture *hazptr_torture_read_lock(struct hazptr_ctx **hcpp)
@@ -252,6 +254,29 @@ static struct hazptr_torture_ops hazptr_ops = {
 	.name			= "hazptr"
 };
 
+/*
+ * Definitions for hazard-pointer torture testing using on-stack
+ * hazptr_ctx structures.
+ */
+
+static struct hazptr_torture *hazptr_torture_read_lock_stack(struct hazptr_ctx **hcpp)
+{
+	struct hazptr_torture *htp;
+
+	htp = (struct hazptr_torture *)hazptr_acquire(*hcpp, (void *)&hazptr_torture_current);
+	return htp;
+}
+
+static struct hazptr_torture_ops hazptr_stack_ops = {
+	.init			= hazptr_sync_torture_init,
+	.readlock		= hazptr_torture_read_lock_stack,
+	.read_delay		= hazptr_read_delay,
+	.readunlock		= hazptr_torture_read_unlock,
+	.sync			= hazptr_synchronize,
+	.irq_capable		= 1,
+	.name			= "hazptr-stack"
+};
+
 /*
  * Hazard-pointer torture writer kthread.  Repeatedly substitutes a new
  * structure for that pointed to by hazptr_torture_current, freeing the
@@ -337,7 +362,8 @@ hazptr_torture_writer(void *arg)
  */
 static int hazptr_torture_reader(void *arg)
 {
-	struct hazptr_ctx *hcp;
+	struct hazptr_ctx hc;
+	struct hazptr_ctx *hcp = &hc;
 	struct hazptr_torture *htp;
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
@@ -488,13 +514,15 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 {
 	pr_alert("%s" TORTURE_FLAG
 		 "--- %s: nreaders=%d "
-		 "stat_interval=%d verbose=%d "
-		 "shuffle_interval=%d stutter=%d irqreader=%d "
-		 "onoff_interval=%d onoff_holdoff=%d\n",
+		 "onoff_interval=%d onoff_holdoff=%d "
+		 "preempt_duration=%d preempt_interval=%d "
+		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
+		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders,
-		 stat_interval, verbose,
-		 shuffle_interval, stutter, irqreader,
-		 onoff_interval, onoff_holdoff);
+		 onoff_interval, onoff_holdoff,
+		 preempt_duration, preempt_interval,
+		 shuffle_interval, shutdown_secs, stat_interval, stutter,
+		 verbose);
 }
 
 // Randomly preempt online CPUs.
@@ -570,7 +598,7 @@ static int __init hazptr_torture_init(void)
 	long i;
 	int cpu;
 	int firsterr = 0;
-	static struct hazptr_torture_ops *torture_ops[] = { &hazptr_ops, };
+	static struct hazptr_torture_ops *torture_ops[] = { &hazptr_ops, &hazptr_stack_ops, };
 
 	if (!torture_init_begin(torture_type, verbose))
 		return -EBUSY;
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot
new file mode 100644
index 00000000000000..1d09a6446080a1
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot
@@ -0,0 +1 @@
+hazptrtorture.torture_type=hazptr-stack
-- 
2.40.1

