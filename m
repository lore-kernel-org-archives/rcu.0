Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8A3B5310
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219936; cv=none; b=LzvWt3WvIKP5lSrUJV1GwO2KzSGrUrtTjH31Jclc+4LTZuLQh2lZk6y9ePj4FQMD92kT8xIXLtNOtpEgR2jkYirhzlbxNJT+LWpN3OncdVPpOvWQHqg6wsJ7bXj0vTYLzPAoE1pScLpz3GmgLb3/TRLASxQNsy65L1/SSV33O5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219936; c=relaxed/simple;
	bh=N1ZRO99Xmu7eMJ4ncdKQ4oBgaMAOlGsvAg+Q2j1/DMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKyrWMY6SXxZeZb2iLkT34g86Eo70uAGaBiLEQq83EbcVYKJHAn+rJdFgRpXCszIgJSSmjyfUCtd9d/thoQ28LwdUIld2kdM47Z7yfwpRZ8UUzAA4kt1GMm0BalgUBzqp+F9uuLyPWeaIkAH2ggkIn7JHFHfwXXm0wnm/MUCjDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DajfT7oI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DajfT7oI"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso37070831fa.3
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219932; x=1779824732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSjCy54KooYgtOnKS1P4NfKbs3McoPoMDdY9GznQwyk=;
        b=DajfT7oIOa6xIzArkrPVKZoJPBjl3K4FmdCpK7aYoqiBZ4jQqlxNlSkuhFzp3tmr2R
         eIan66XkBNNgSc4OGxlEne+Xu93s4huOTTVWfWmqzk2aVfnd88++7oQly7wIK2u/uLJA
         UlShsrDqkES0rbvYZEErGXlNuYK0opVYQVToIZ5w9HsFOo7heSGHzhw8MZe//FSNdXuV
         r0uX3L7Bxk0Pfl4mEOTJDsjCxsPeu1N7NXDnwz8ntyKk7RcuNz7i/vsFdpbjuNO1PMdG
         6QK9ptUb/duTZyb/KjX0E6E1MDLwenZMRrJmRH92J1QVa8qHpcc5pyNfdiYwdHx3OEnc
         /F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219932; x=1779824732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSjCy54KooYgtOnKS1P4NfKbs3McoPoMDdY9GznQwyk=;
        b=PQ8pO1XGPwzTEhyWFyI9KN8BbW7RinPl/QoH2sPlReb5bgbQzajH97w0Zo8BlIPFiK
         YIDVVvaMaW+ywTHOu3mQMjA3CNZhINxQgzkP11KNid7XcqTcT8rZDEUV5sc9WH3qwMx3
         yQwmzNERCK/RmNYx6OCvZSltQBB+P2Q0DgEv/GO3ZGeo5vknjPzh1rz45FPMGxUYbnhj
         XZm4zjN3Ux1/XaJnFXTWnSUxxOccHfOUxTbKO/aTpIRJDyFAzi/+K6RGn/Wdfxh7qleC
         YMcBrDIJuzi3xenlvmh50x5A3PBo7wo1tcAHGayszo2w6bAvzLtWajtamGUwQUEArdKX
         aVng==
X-Gm-Message-State: AOJu0Yy/QHcszKa/cfn4Wlro2FxYXPsC4tX93q1Kz2NA4Zjj0e4Zor+L
	/wgkmOKpHvOhL5HFFeFr+grqJLlT8UTl7Ava0sADUqgE88/VKpSSRvOK
X-Gm-Gg: Acq92OFw0fLadUQU+0T//hd4zhRhRWxTuw6jqvqk2afS1W2t6qqHJGm2a/3iTbDgWXf
	qyWTKalxwShbIGRg3F9Lsw7z3pERY0v7ak9iGYJFO1tBjzrmDBevTD2tcDo+GKGQLtANDkA8Fac
	3AdYA9DHAm1hi5vmzxy030Hl2/96FoxushdA4grbLzSVaVOTyh0tRIGKRFstpUN5iRA5ZN2IwJk
	o6IBhSj+XgdzSL5HN5j1L48ISLZ0ApLbSWELDWCdUGuTLe0ej0stNRdkclvIjh3dBtxQG4r4qBG
	RSBGjnu+HrIu7UBZX5O+1z0JMgbgYri2CyOUcjQ8kA00ZX8yOnszb/vh3DZti3h37jDKDBeyz9M
	6ltDPu7qX3zns4IHFjwZw32uonmmqWaQLvDnUw/Ssqz3opBYTWqyO/hwV0657aUOnR9WhdnZyBP
	tTX2IrX6fZoONieeA=
X-Received: by 2002:a2e:c41:0:b0:394:5c9a:f31f with SMTP id 38308e7fff4ca-39561fa8ed4mr43748971fa.16.1779219931855;
        Tue, 19 May 2026 12:45:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:31 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Samir M <samir@linux.ibm.com>
Subject: [PATCH -next v2 10/11] rcu: Latch normal synchronize_rcu() path on flood
Date: Tue, 19 May 2026 21:45:23 +0200
Message-ID: <20260519194524.158515-11-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
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
index 4d0f545fb3ec..d5db2e85d551 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5862,13 +5862,13 @@ Kernel parameters
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
index 09f0cef5014c..94274330d1db 100644
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

