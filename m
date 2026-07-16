Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0617B418;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161092; cv=none; b=b++blSWnOlu17lq+b9K+CGmmH6aBJSDYBVPNANa4thVwk0jMp9wMyOPLoVsK8T7EiRQtNS9ZNsk1bILlQPAMFfxfVgXoUBSq9oQxvJWP4PUZ9ZY7rQr2R8Rph1ndtBwD03bF6Fi+O1540MQ4uGEHy81Ca9UqK3LZF3YFB2J+n7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161092; c=relaxed/simple;
	bh=k5jwZOVr3f1E5CeV2/EAlnYNwKzSLw3bW83Q6O+tBfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDqJ3fpmhxweVbsLwpNe8n1ldQzuDlDtx4LcadfHd6F7xgBpMi5M0ZhaAMQiWXyb/WwoiV3SqWfkOcneOi6BlA8iqExbtpdQk5N1UiyMvjV7UPKoYrNxPHoJf0DbOLuaZ4+P/RAaJSdG36TWtp2SHcZAWwGc4t3MjBtVGC5DICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBffTixB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBffTixB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC4F1F00ACF;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=Z+drtNt6IhXy3FJaowefTkmFOsaKLhYUt8b8U2czzzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FBffTixBC7xBecvpxOGKlo+EKHlVzdot5lEYOvIlx8w7pGGZdGNLeNP4AfHZPZq9p
	 IkF8r6/HFU6j8q1dtAirpTELUKhQqVcHr4uhbkjyDA97IgwEVSwOsO7Q66Co8VPsox
	 +OGWQ0cmZwGA1V36LQBeqHntcKLeOSebr/Fb8rke5yHhHLS8hhdmAdT2BdM00vSP7r
	 Ik8OgCDdr9n4EJQ+LGZX7HIIcD8jyyug6flDYIwJctlFPyH+c9toLKUnNrkwLUtb1D
	 +5bZRDDIzrq2+NFhejmtfVVs6xFHKHKb7gqcrMnyUjYINmmqw9jid0DmvyQgZ9NNft
	 CJwyxkdXTbPNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D838CE0C44; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 04/24] hazptrtorture: Add testing of on-stack hazptr_ctx structures
Date: Wed, 15 Jul 2026 17:17:49 -0700
Message-Id: <20260716001809.11084-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
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
 kernel/rcu/hazptrtorture.c                    | 48 ++++++++++++++-----
 .../rcutorture/configs/hazptr/NOPREEMPT.boot  |  1 +
 2 files changed, 38 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 70f12d2a149069..0f25637c82876b 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -30,7 +30,6 @@ MODULE_DESCRIPTION("Hazard-pointer module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmckrcu@meta.com>");
 
-torture_param(int, irqreader, 1, "Allow hazard-pointer readers from irq handlers");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
@@ -188,7 +187,8 @@ struct hazptr_torture_ops {
 static struct hazptr_torture_ops *cur_ops;
 
 /*
- * Definitions for hazard-pointer torture testing.
+ * Definitions for hazard-pointer torture testing using per-CPU hazptr_ctx
+ * structures.
  */
 
 static struct hazptr_torture *hazptr_torture_read_lock(struct hazptr_ctx **hcpp)
@@ -242,10 +242,33 @@ static struct hazptr_torture_ops hazptr_ops = {
 	.readunlock		= hazptr_torture_read_unlock,
 	.sync			= hazptr_synchronize,
 	.irq_capable		= 1,
-	.onstack_ctx		= 1,
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
+	.onstack_ctx		= 1,
+	.name			= "hazptr-stack"
+};
+
 /*
  * Hazard-pointer torture writer kthread.  Repeatedly substitutes a new
  * structure for that pointed to by hazptr_torture_current, freeing the
@@ -331,7 +354,8 @@ hazptr_torture_writer(void *arg)
  */
 static int hazptr_torture_reader(void *arg)
 {
-	struct hazptr_ctx *hcp;
+	struct hazptr_ctx hc;
+	struct hazptr_ctx *hcp = &hc;
 	struct hazptr_torture *htp;
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
@@ -482,13 +506,15 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
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
@@ -564,7 +590,7 @@ static int __init hazptr_torture_init(void)
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

