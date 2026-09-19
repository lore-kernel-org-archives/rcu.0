Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB735464C;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776061; cv=none; b=EVe0UyXVHR677VnYH//FImC3DBiq5eSGSG5egaF9pv4au4jeEqxlVVr+oi6ukyziEdcUFcNpVI8ommL9E5irY6/wL/JysGk+27hI3M3pdVGlI0jUlFlsx4H1kwFwQ6UBtaIcLWysczmNhDYjJ4DzWIx+0fq1iUKyNRl80K1Xkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776061; c=relaxed/simple;
	bh=HwtsuBlBCux5ymcpXL33cyngWC6vsOFs30puxCcDz+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pzos3/XecxU1CJlKFSY6Ep3DaW5FpXyq5YeDX43Q+9JM+E2jfNwkTVUROAbUgKgtBbuIHcfm6EnSaXk7qJGb0Y+MIme5BJcjfSNVkRTuxhymeCpN2MqG0l/7KL5BU2JmlsE3idQW9Oialysmt0G3dkHlLGcxTVKN6BLt9YBNkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoAH6+7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoAH6+7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE0E1F008A0;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776059;
	bh=PjRr4ujnHmXXCsFKqamYXOTjxfDUky2OWpuGXT2k7KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DoAH6+7L4O6Fmiw4FRbYl/JJ1GWpdyhnINx0qbESoC6JIk+M6t10HEWpINL9EiCFm
	 f5kvd1Me4lD3rPAoNf2XVZQj/80j9ms6AVSdi3wb5gJU7KG9aR6PWkB75sxFoBWSwT
	 wtbAlVKeSG1XswD4IWqTRH241Y4la2RKlFqat5QbzAZJDcr69Is/Qzz8U4iUQDRczo
	 c5Ib6OoVWLAj1wn7nSMTHPsjFeAu06R3CXp391oZAkQ9Ae3lkeN9LvYxqimPodBHfi
	 4C2m16QIa7Q9GfMzn5y00ShIDV/iuJ6aEH6OXsxCzc3iefXlZq0nSFY4Sq0nVqNXRk
	 7FT+QSXrUkDig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54B0FCE09F8; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 04/28] hazptrtorture: Add testing of on-stack hazptr_ctx structures
Date: Fri, 18 Sep 2026 17:00:32 -0700
Message-Id: <20260919000056.3132131-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
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
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c                    | 48 ++++++++++++++-----
 .../rcutorture/configs/hazptr/NOPREEMPT.boot  |  1 +
 2 files changed, 38 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index c656ba980100..22a0610d0dbd 100644
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
@@ -481,13 +505,15 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
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
@@ -563,7 +589,7 @@ static int __init hazptr_torture_init(void)
 	long i;
 	int cpu;
 	int firsterr = 0;
-	static struct hazptr_torture_ops *torture_ops[] = { &hazptr_ops, };
+	static struct hazptr_torture_ops *torture_ops[] = { &hazptr_ops, &hazptr_stack_ops, };
 
 	if (!torture_init_begin(torture_type, verbose))
 		return -EBUSY;
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot
new file mode 100644
index 000000000000..1d09a6446080
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot
@@ -0,0 +1 @@
+hazptrtorture.torture_type=hazptr-stack
-- 
2.40.1

