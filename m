Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57813DC4C9
	for <rcu@vger.kernel.org>; Wed, 11 Mar 2026 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255497; cv=none; b=rjy5DLdmp0lvcx7uiOCD+dFX6Kkc1fsg35l+PttqB5erHK+THAOTjcO0WYl7OypVOS7QM17+p+OKDsbUEvabvau0Fue+ng2crNk2g+BmM+c9BadUQkvTQiGv8utTjxA52b/JUUruJJ1KMvrnUfPqMxPa5WnqfwByoc4LoJPIVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255497; c=relaxed/simple;
	bh=9UWHoEZ/6S5a5NM0WSm1+0GGV6WBxi1GdbMqrJbDtZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auIR/5mjdwivcYVYY6vgarxniJLxPY4W9bb62PPC6e4lx3SDUXGA+MJeEV/YNlQ0pdQLBmX8Bd1skJdWLQWIWgO3OqT4v0r11I3Phihnnu9B2aJeGAZ26U3Aw2OeTPLzzCjmIjg0qEbN/LJHZ/8s9frNgXjrYP78/DRJ7nLNzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghN9Zotg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghN9Zotg"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so365627e87.1
        for <rcu@vger.kernel.org>; Wed, 11 Mar 2026 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773255494; x=1773860294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGpu8DFLIvKAZyVpE7LDhPhQ06G79YZx1Uuhwfgg/4I=;
        b=ghN9Zotg2HcS+trXsaOfexL7RLghxbEc8FAVa9vipUErp3jRTwNShpDpv69erJXToN
         y5tkQa0yG0ps6QW8EysJZrVbyzCgvSv7VcLDcMq1oOqyzsJPRgC3PbmZ4/WUEXx622ps
         Th5r6YypUMATSnCvP9O5xH2fgX3eUXsbF+X3jwseKtZ+Vuwo08X1D/AdVwwwQ2kPI9hR
         3VUtGWfQTBJPg6rchwe+yDR5d2WPa0ycZsPHX1WniiN/OY7UX0OJgtC/P4fvffnogAl7
         jXlrXdGumF8+qIP3al6XOMwZtoK7aNhAxjQtlBQnXrQOV+S9LM1EcPkbHi/0R3rOMLqI
         4q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773255494; x=1773860294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGpu8DFLIvKAZyVpE7LDhPhQ06G79YZx1Uuhwfgg/4I=;
        b=b1inrcALd+KwyN+zslamTXcEt5XdB/XqtntgL7Y4tLJz20osJOHsnoEwH1WBvHml0w
         6tW2NzzRQxftpdecL6rr5ff6TGGiKgoKKwjMlKy2PE41LK7OrApevR7dAr8KzsOX9M56
         geJq6xvYpiE4A+NbhB0OGy+sqbCQ/TYLlz9aukm5klU18QfhizvUmyUgRksbSWpV4w71
         weUiZ5vpLvIOLchkXvz07NomkTds5Yzf+/nBVdMf5PPKMMzEOI0GheIUnRTQarJHtz/C
         Fcgo2vPcqkya527r1kjb+IqPTKZVsv18jVpzAhy7/t0zqLpj2pgraG4OVV83mRDreKYM
         GZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtzkQjzKwfoHcrwvNyqwmLn/GvQyZNd3YJL7QaPSAfEqKP7Y5QkVZAslDJXCGMIDCywkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxUh8/00og9DGXQ3C9ND8iO6+CC+pYNv+vbXGLgECk/GBZSEQ
	jD929emMClNDu46y0OI0T49KpxRWN/k0KgbkLsjCjHYlpq1tm+v9mMCG
X-Gm-Gg: ATEYQzxFpwYBmsiaXLhjd+/c4n5r8EylZ1V2r8JKnUvUrlmHl/hspIohqSbHtrsMItq
	N4BYKsu0IWPIlVHBmD7PS2bk8gCRK6g69l04UegHG4E/ozmabXdYN46ZSuldrdmwql3s3xJnKZr
	Yc3GTfUuEN4ManiX+CUU690AkhokWA1mia0M+EUhP6YdLPbHKWEGiWip+sHUD24RXsaB25bESJm
	fuNujDQQDPb23FBi2z2okQf1zARgZM1UdewLJc/w01pd2Bo3Whz9wtWu8NXzaSBdi2t0Ou0//DL
	cCQu1t0L3VRF6xqwtHbZG3fP9MxzFdd+Z0JIWSxJcntammj6wqbMPHft6bt1HEn+1GvSOGRVeP5
	B7x3EDYX+oEdA5B6Bd57w2NyTC2fzBlT2R6huXhVDewD5Z50+uQg7EsJ0KIpU38s/HQgaI+E5IX
	ueFZeUe+0BpJxk4Qw=
X-Received: by 2002:ac2:50b2:0:b0:5a1:34a3:757f with SMTP id 2adb3069b0e04-5a156cbd06amr978934e87.25.1773255493583;
        Wed, 11 Mar 2026 11:58:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156162b82sm535526e87.56.2026.03.11.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:58:13 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Samir M <samir@linux.ibm.com>
Subject: [PATCH v3] rcu: Latch normal synchronize_rcu() path on flood
Date: Wed, 11 Mar 2026 19:58:11 +0100
Message-ID: <20260311185811.2388765-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rcu_normal_wake_from_gp is only enabled by default
on small systems(<= 16 CPUs) or when a user explicitly set it
enabled.

Introduce an adaptive latching mechanism:
 * Track the number of in-flight synchronize_rcu() requests
   using a new rcu_sr_normal_count counter;

 * If the count reaches/exceeds RCU_SR_NORMAL_LATCH_THR(64),
   it sets the rcu_sr_normal_latched, reverting new requests
   onto the scaled wait_rcu_gp() path;

 * The latch is cleared only when the pending requests are fully
   drained(nr == 0);

 * Enables rcu_normal_wake_from_gp by default for all systems,
   relying on this dynamic throttling instead of static CPU
   limits.

Testing(synthetic flood workload):
  * Kernel version: 6.19.0-rc6
  * Number of CPUs: 1536
  * 60K concurrent synchronize_rcu() calls

Perf(cycles, system-wide):
  total cycles: 932020263832
  rcu_sr_normal_add_req(): 2650282811 cycles(~0.28%)

Perf report excerpt:
  0.01%  0.01%  sync_test/...  [k] rcu_sr_normal_add_req

Measured overhead of rcu_sr_normal_add_req() remained ~0.28%
of total CPU cycles in this synthetic stress test.

Tested-by: Samir M <samir@linux.ibm.com>
Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 ++--
 kernel/rcu/tree.c                             | 52 ++++++++++++++-----
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb850e5290c2..d0574a02510d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5867,13 +5867,13 @@ Kernel parameters
 			use a call_rcu[_hurry]() path. Please note, this is for a
 			normal grace period.
 
-			How to enable it:
+			How to disable it:
 
-			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
-			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
+			echo 0 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
+			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=0"
 
-			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
-			disabled by the boot parameter passing 0.
+			Default is 1 if it is not explicitly disabled by the boot parameter
+			passing 0.
 
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..b0cc07c4dd62 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1632,17 +1632,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
 	atomic_set_release(&sr_wn->inuse, 0);
 }
 
-/* Enable rcu_normal_wake_from_gp automatically on small systems. */
-#define WAKE_FROM_GP_CPU_THRESHOLD 16
-
-static int rcu_normal_wake_from_gp = -1;
+static int rcu_normal_wake_from_gp = 1;
 module_param(rcu_normal_wake_from_gp, int, 0644);
 static struct workqueue_struct *sync_wq;
 
+#define RCU_SR_NORMAL_LATCH_THR 64
+
+/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
+static atomic_long_t rcu_sr_normal_count;
+static int rcu_sr_normal_latched; /* 0/1 */
+
 static void rcu_sr_normal_complete(struct llist_node *node)
 {
 	struct rcu_synchronize *rs = container_of(
 		(struct rcu_head *) node, struct rcu_synchronize, head);
+	long nr;
 
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
 		!poll_state_synchronize_rcu_full(&rs->oldstate),
@@ -1650,6 +1654,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 
 	/* Finally. */
 	complete(&rs->completion);
+	nr = atomic_long_dec_return(&rcu_sr_normal_count);
+	WARN_ON_ONCE(nr < 0);
+
+	/*
+	 * Unlatch: switch back to normal path when fully
+	 * drained and if it has been latched.
+	 */
+	if (nr == 0)
+		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
 }
 
 static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
@@ -1795,6 +1808,24 @@ static bool rcu_sr_normal_gp_init(void)
 
 static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
 {
+	/*
+	 * Increment before publish to avoid a complete
+	 * vs enqueue race on latch.
+	 */
+	long nr = atomic_long_inc_return(&rcu_sr_normal_count);
+
+	/*
+	 * Latch when threshold is reached. Checking for an exact match
+	 * restricts cmpxchg() to a single context.
+	 *
+	 * This latch is intentionally relaxed and best-effort. Concurrent
+	 * set/clear can race and temporarily lose the latch, which is OK
+	 * because it only selects between the fast and fallback paths.
+	 */
+	if (nr == RCU_SR_NORMAL_LATCH_THR)
+		(void)cmpxchg(&rcu_sr_normal_latched, 0, 1);
+
+	/* Publish for the GP kthread/worker. */
 	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
 }
 
@@ -3278,14 +3309,15 @@ static void synchronize_rcu_normal(void)
 {
 	struct rcu_synchronize rs;
 
+	init_rcu_head_on_stack(&rs.head);
 	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
 
-	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
+	if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
+			READ_ONCE(rcu_sr_normal_latched)) {
 		wait_rcu_gp(call_rcu_hurry);
 		goto trace_complete_out;
 	}
 
-	init_rcu_head_on_stack(&rs.head);
 	init_completion(&rs.completion);
 
 	/*
@@ -3302,10 +3334,10 @@ static void synchronize_rcu_normal(void)
 
 	/* Now we can wait. */
 	wait_for_completion(&rs.completion);
-	destroy_rcu_head_on_stack(&rs.head);
 
 trace_complete_out:
 	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
+	destroy_rcu_head_on_stack(&rs.head);
 }
 
 /**
@@ -4904,12 +4936,6 @@ void __init rcu_init(void)
 	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	WARN_ON(!sync_wq);
 
-	/* Respect if explicitly disabled via a boot parameter. */
-	if (rcu_normal_wake_from_gp < 0) {
-		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
-			rcu_normal_wake_from_gp = 1;
-	}
-
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
 	if (qovld < 0)
-- 
2.47.3

