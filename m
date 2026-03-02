Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B008129D29F
	for <rcu@vger.kernel.org>; Mon,  2 Mar 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445850; cv=none; b=fB3o6ZTZecbnZ0ifkE2USPSuQ08WcgSV5OuGwCZSy3APHn4rjRj0OPp3TJC5fr2EGNDhU2Efk0icyyYT56gdv7Qnva6k3v/uSqopXO5jnJYic55170po8r7LAjfcMCCJcsckB9frw4N4C9e3spPOJoZqrN+yk2qSr2WqPcjIFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445850; c=relaxed/simple;
	bh=rismH0zt1KGRZ2cxdyV3viNlzpaLKZWSpbzTLdgus9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G52ir83l6JuSNvPr/VnMxAJbGv0V41+KuacAA0ZX9YmxXO7s2h86/mK218EyIguo/R88qPxPaqwPkOP531b10TsWSOFnyywRCBahmhtSlQRV1XBfcbQ3jtefCgGeXJToYfO9JxdHMYXEuJt9VfWZqNwyiAOw2R8GVYFnF0b109I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqu8OlOJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqu8OlOJ"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-389fa0d1040so56624341fa.2
        for <rcu@vger.kernel.org>; Mon, 02 Mar 2026 02:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772445847; x=1773050647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyTw7sUlt+rTY5vZwdK74vF7EDt3IUIWzn1vHdPOEms=;
        b=mqu8OlOJT3WLWzNngc8pZxOpRUo/wyScl3J0iKYPLLk/qtcJMMxXECA5z5xFoAY+LT
         9O8FhxafWnRC45VkYqkvp4KaBJUFz+/FztUFdbgzRLOkD7IHB7uN2uzFNwVzcOQNU3sy
         ZrJxC8vvLFRR+L+/anNaDhsJTcUmmCqEfaIiK3OvWpI/wOCd7jlYXEZbRg5R8DJvQpUk
         WuCVUZV2slzKkv5MBZm1JrdMXiHzC43ZLTwNdNWQK99eR8LqgnoZKZLCvTA7Rdl9jaX+
         wlPrh/alnJEqChUlseNnjiRQgSAGHX6rxC+KedK4J3+jiCG98cPff3Tqx1AS+pM6Uq85
         /t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445847; x=1773050647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyTw7sUlt+rTY5vZwdK74vF7EDt3IUIWzn1vHdPOEms=;
        b=UHZcEndL42HZ4Jh6eosLEz/wIGpuXt+xKCJ+RVotzJE2GcBgWHmwcM+9F1G/z700RE
         ERC+j35hZkG45/E+CLgqyr1GUOuGtu3sf9hVzfBCaKAjn/M6oXmIm/r1BHi9bww1il+F
         BmecSEDHNzhW/7hvQ3z2njRMQk6vb2jtgphVVt0AQWYvC0NcjZ2BPAMHgbEI4am/m22S
         glMzgpNLOzf24meoKvzcfhmcTyrUT+r8g6KjW9x4iWnHfn+WXyaZLcgPhxL5ppafgl4S
         YKMivXLTOPXkgP0FZEkLZOwfx1XKmI6fHnnLxkNPNCYXuCPyXkz6MpHYtoGI3+0I14hP
         sVtw==
X-Forwarded-Encrypted: i=1; AJvYcCWD7XSWnqY6Fm59Y52rBp73pW15O75tECXQnb3vIEu/PHvMRDe7UNi5KoJCWhAI/qDuc4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFsPoPf0ooIWB8MFVzOUOSnc6XDI/R4LohaFl9+qIL2Gx6qsr
	/enU505AACI+zq8ZPHMxxv5cw9scaHxvfgtgqsluqmg85wy5uyVtw3C1yRc8Pyi2
X-Gm-Gg: ATEYQzy9reCkawqBDPBm+Va4vJBbP1v5aYCWw3qaQibwsdaaC9Wz1SgEE7TGmIuIaHe
	ayF0PcCE5V8t5GD3KD/Ea8Sl9p+Ny9AKSbiGTuTRxnIP8EYJd+mtaYUwY3WHn0A9hLIvczEkwmO
	eee06dXWyL4iPf8JMfYj7crLIibiRC1tfIRsDHeciCjBY9AnSThu0LOsPT3/aNQRgvv4yAzzqJU
	MrRdsaiWekMHT8IL2qlcH7PsQ8ydbSSxbuFh5B6IMHJ7DmmNmrpSKo9xyGVLidRTWATEY2GvWwy
	pVzEe9/SetrmMkMgnVNgZe4QnSFUeA4rL0qlRmt00iowtsuRlcsjIRrVeB4IAMWmYT+wQQA3bSs
	9jbolyMycPxXWxMUIWAFyfkeV1CucRVuDcueP99IRoFCog27pFSzf64Rdll4xZQTLS1bb1pMsP6
	8GfhVOOEkEgkods1A=
X-Received: by 2002:a05:651c:2112:b0:38a:34a:7823 with SMTP id 38308e7fff4ca-38a034a7c3dmr81810141fa.21.1772445846530;
        Mon, 02 Mar 2026 02:04:06 -0800 (PST)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a11a12923dsm953371e87.64.2026.03.02.02.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:04:06 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Samir M <samir@linux.ibm.com>
Subject: [PATCH v2] rcu: Latch normal synchronize_rcu() path on flood
Date: Mon,  2 Mar 2026 11:04:04 +0100
Message-ID: <20260302100404.2624503-1-urezki@gmail.com>
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
 .../admin-guide/kernel-parameters.txt         | 10 ++---
 kernel/rcu/tree.c                             | 41 +++++++++++++------
 2 files changed, 33 insertions(+), 18 deletions(-)

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
index 55df6d37145e..86dc88a70fd0 100644
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
+static atomic_t rcu_sr_normal_latched;
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
+		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
 }
 
 static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
@@ -1795,7 +1808,14 @@ static bool rcu_sr_normal_gp_init(void)
 
 static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
 {
+	long nr;
+
 	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
+	nr = atomic_long_inc_return(&rcu_sr_normal_count);
+
+	/* Latch: only when flooded and if unlatched. */
+	if (nr >= RCU_SR_NORMAL_LATCH_THR)
+		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
 }
 
 /*
@@ -3278,14 +3298,15 @@ static void synchronize_rcu_normal(void)
 {
 	struct rcu_synchronize rs;
 
+	init_rcu_head_on_stack(&rs.head);
 	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
 
-	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
+	if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
+			atomic_read(&rcu_sr_normal_latched)) {
 		wait_rcu_gp(call_rcu_hurry);
 		goto trace_complete_out;
 	}
 
-	init_rcu_head_on_stack(&rs.head);
 	init_completion(&rs.completion);
 
 	/*
@@ -3302,10 +3323,10 @@ static void synchronize_rcu_normal(void)
 
 	/* Now we can wait. */
 	wait_for_completion(&rs.completion);
-	destroy_rcu_head_on_stack(&rs.head);
 
 trace_complete_out:
 	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
+	destroy_rcu_head_on_stack(&rs.head);
 }
 
 /**
@@ -4904,12 +4925,6 @@ void __init rcu_init(void)
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

