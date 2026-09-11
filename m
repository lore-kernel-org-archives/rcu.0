Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBEC3EEADF
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098071; cv=none; b=uEB7tk2UX8HcHmqOaJiYijvESD06gqivtZ2t4UNEqS4Gps0tN+XYHxiReL0eziwBfsneoDTcsFcq907A2cdHZpvjwRr8sSWCUjOnX/aioIdTvimOb39yCYoD3Nx/7ngXJ+35YdLfcIeGW5VNpdlctLIsVm8v3P3UGA36+B9q2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098071; c=relaxed/simple;
	bh=sHzRETS9PiweXRrgLV9bDFaHahGUpuvqfaDfXNBZXnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWdXhRK184PN/KwxR56Y6r97gf5UDLfU2MyqKNmDhlAxoCYEPqApYBqQ4Am8cBBBaRqTAdx65TwJL9IlCcDpqU4380aoBj8PExAnQ1+JY8T7nEeI4tOESEhuQQ80L+ZFznunJ0gNChnoiG6FhR1fkD4yn9Ce1MGZUnQVts2UR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Epl4KKc3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epl4KKc3"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so467422a91.0
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 20:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098070; x=1789702870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uimiES6hPReHTTa4bHIqRbXrOxmMJ+VmsCD/x7Fg6Is=;
        b=Epl4KKc3TtsGdeIXHqtJntDjpZLj0YiuAmLwP99i7X/c2IXE75QTQ1U4YBmyzbely8
         E0lscgtjST0Co87lDyqvqDbljdSTJzk99NW1Y6MHZ1WspYkzs/0DtBbvE5uV6qspFxtM
         HS78oa9IpjvkXWwm38VXySqJWWj/cJG3gBhPepWDzDPbBzIw3OIFXnncI2qliWHhvrni
         ns+vopE9CyfO92EIRkwRmSUrU3NAo5g5LMBXXGJoorJpn0jHtRSzDSXcry6g70Fwe+cV
         BNnh7nz8CM4jI23+W9m31Nk+M/rhWjcQOvo3NBM/zDLWCB9aotlClQ6/RNA21P8UTSpp
         DNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098070; x=1789702870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uimiES6hPReHTTa4bHIqRbXrOxmMJ+VmsCD/x7Fg6Is=;
        b=jqfO6XyB1FnHy/vPE2NRPrJRWifLWM2OA4i/YIfOZ16n5gSrS9dvq2hWUDiDNyv4+S
         LYSOg4hFKyvWZNSoD+xa+deTrvpYNT/7jiWUIm92Gvle72w3fdjdLX+XqAGoRz2Mn+FY
         UWQK0kZvWYYGAG7efKjeE+MuvftlTsYOnBBYIWziNNx1eDlXSfzcQ2OLH5hkYHI5tVcB
         8uhPbrkIKa6xFaPR2iQD475zF4bSIIdh1pIqRyrV19huiIBFIPfqeTaRyNT0g7Ge58RX
         j5mT7HtKmglcIZrZ204tk4ZE2fxX2K46hPYdjDbzRIdY7yle1pnGyzs4okLHSxg5nmzL
         SAfw==
X-Forwarded-Encrypted: i=1; AKwUvBypQB5uantWBShfnPDby8FOPSF75czMZGNHjTErJQjcdaf4crqKOfxW+Y6DJ2SdCgei7mw=@vger.kernel.org
X-Gm-Message-State: AFuF++kKPHonphYzT8FhJ5cnebtXPi82iElbG2cXYRtPjOYAfvpc2p1P
	W9x4EOp+abkR4UrfYXLQA6IcBiNjjxedzphhwJ1H9IIMbVwQXSQ15hDn
X-Gm-Gg: AYBFou1h3OetiPnNRhIwV+EaLJwI+21+KXcbk7oDUrFdVsmdSail/cRSGZP1d0rkBi7
	y9VzHqGuaj9D3BjGhrA/ucq0dnoE1E9uk+J6Zpw03naXSpeAuBq4UPYBXt8L4UNNE6x+6NuWm5J
	Ojnen0cPx8uaeAixoPj50EHsbl+npytE4mIichXmi/RBhbN+4F288ZvnrbuZtTSRnsNtTDEqRxj
	iDUJhaNWClgZWrdP26iSMs3ysd/yYTavjsLypX5ynhXjecDyGKNfqYrOR/RPnyOCS9ixfmxF+bN
	PNRyBE2fGdjr9zPZZf7OMf5akua9+oTLX5Jghv0ZJ3FIgUUpOT9jnO/ObBCQ7Qb0PIsfWDJWDHc
	fouiEkOuOmGUE1tc8s3RYf3yHphf6u3chrwanPVANLp2vbm3kce8ZNVz1YSl0jHBTQpw4blIMb1
	F7RqV+QyQBtW+Ea9MTIM0/2xyZuUErOw8L1vgplopoRi90jYD5DMMac22EKoPdh2Ixz41sK4iGN
	PiFnSPBNkUdrn72/SoF3ignPtVwiW6/A+meXpxBdk9JU78TkzAlqnuyQThNdCtJ9fsnVc8+IC7E
	Gz1Let11AsrnumjjqcPs0gTsR8+KvobwoY5rXi8JIvOb25Ro6CJQjrLRKcct3o0=
X-Received: by 2002:a17:90b:134f:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39d9beb0be4mr3669832a91.7.1789098069618;
        Thu, 10 Sep 2026 20:41:09 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9afa367bsm558148a91.0.2026.09.10.20.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:41:09 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: paulmck@kernel.org,
	urezki@gmail.com,
	harry@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	surenb@google.com,
	vbabka@kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] rcu: make userspace barrier hook drain kvfree_rcu work
Date: Fri, 11 Sep 2026 11:40:59 +0800
Message-ID: <20260911034059.3569914-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911034059.3569914-1-matthias.goergens@gmail.com>
References: <6092a9d0-0125-4da4-ac48-85ccaeb83beb@paulmck-laptop>
 <20260911034059.3569914-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The bcachefs ktest allocation-leak check writes rcutree.do_rcu_barrier
before reading /proc/allocinfo. While testing bcachefs performance
changes, small objects released with kfree_rcu() remained visible after
repeated writes to the hook and 20 seconds of waiting, causing otherwise
clean tests to fail their leak check.

The test assumes a stronger contract than the hook currently documents:
rcu_barrier() waits for ordinary callbacks, but does not flush objects
still held in kfree_rcu() batching or per-CPU SLUB sheaves. The retained
population eventually fell as a sheaf filled; there is no evidence here
of unbounded growth or OOM.

Changing the hook to drain kvfree_rcu() work let the same unmodified
bcachefs workload pass its allocation check. All eight checkpoints in
one VM, after 50 through 400 option changes, reported zero retained
reconcile_scan objects. This motivated the separate private-cache test
used to isolate the incomplete drain from bcachefs.

Calling kvfree_rcu_barrier() from rcu_barrier_throttled() was proposed
when kvfree_rcu_barrier() was added in 2024, to restore a clean baseline
between userspace benchmark runs. The discussion concluded that keeping
the existing hook name, adding the second operation and documenting both
was the safest compatibility choice, but the follow-up was not added.

Add that drain and document the stronger test interface. Always retain
the existing start-rate limit and perform the kvfree_rcu() drain: an
unrelated ordinary barrier does not establish that this work completed.

Retain the entry ordinary-barrier sequence snapshot. After draining,
skip the final ordinary barrier only if that snapshot is complete,
preserving the memory barrier on the completion path. Otherwise, invoke
rcu_barrier() explicitly. This keeps the ordinary-callback guarantee
independent of whether kvfree_rcu_barrier() embeds an ordinary barrier.

Clarify that the documented completion guarantee covers work queued
before the request, without preventing new work from being queued.

Earlier validation of the unconditional-drain version used four fresh
VM pairs with a private-cache fixture: controls retained the queued
object (60 to 60 active objects), and treatments drained it (60 to 59).
An ordinary-callback test passed on both kernels. Those runs predated
the guarded skip and do not validate that change. No elapsed-time
improvement is claimed.

Link: https://lore.kernel.org/all/20240820155935.1167988-1-urezki@gmail.com/
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++--
 kernel/rcu/tree.c                             | 30 ++++++++++++-------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..914b65ae9413 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5699,9 +5699,12 @@ Kernel parameters
 			there is an ongoing too-long CSD-lock wait.
 
 	rcutree.do_rcu_barrier=	[KNL]
-			Request a call to rcu_barrier().  This is
-			throttled so that userspace tests can safely
-			hammer on the sysfs variable if they so choose.
+			Wait for deferred kfree_rcu() frees and ordinary
+			call_rcu() callbacks queued before this request to
+			complete.  This does not prevent new work from being
+			queued concurrently.  Requests are throttled so that
+			userspace tests can safely hammer on the sysfs
+			variable if they so choose.
 			If triggered before the RCU grace-period machinery
 			is fully active, this will error out with EAGAIN.
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96848fc1f02b..93b71682306c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3989,12 +3989,12 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
 static unsigned long rcu_barrier_last_throttle;
 
 /**
- * rcu_barrier_throttled - Do rcu_barrier(), but limit to one per second
+ * rcu_barrier_throttled - Drain deferred RCU frees, but rate-limit starts
  *
- * This can be thought of as guard rails around rcu_barrier() that
- * permits unrestricted userspace use, at least assuming the hardware's
- * try_cmpxchg() is robust.  There will be at most one call per second to
- * rcu_barrier() system-wide from use of this function, which means that
+ * This can be thought of as guard rails around the deferred-free barriers
+ * that permit unrestricted userspace use, at least assuming the hardware's
+ * try_cmpxchg() is robust.  There will be at most one drain operation started
+ * per sixteenth of a second from use of this function, which means that
  * callers might needlessly wait a second or three.
  *
  * This is intended for use by test suites to avoid OOM by flushing RCU
@@ -4016,14 +4016,24 @@ static void rcu_barrier_throttled(void)
 	while (time_in_range(j, old, old + HZ / 16) ||
 	       !try_cmpxchg(&rcu_barrier_last_throttle, &old, j)) {
 		schedule_timeout_idle(HZ / 16);
-		if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
-			smp_mb(); /* caller's subsequent code after above check. */
-			return;
-		}
 		j = jiffies;
 		old = READ_ONCE(rcu_barrier_last_throttle);
 	}
-	rcu_barrier();
+	/*
+	 * kfree_rcu() can retain objects outside the ordinary callback lists in
+	 * per-CPU SLUB sheaves and kvfree_rcu batches.  Always drain those queues:
+	 * an ordinary barrier does not establish that this work was drained.
+	 */
+	kvfree_rcu_barrier();
+	/*
+	 * A completed barrier can still cover ordinary callbacks queued before
+	 * our entry snapshot.  Otherwise, retain an explicit ordinary barrier
+	 * without depending on the implementation of kvfree_rcu_barrier().
+	 */
+	if (rcu_seq_done(&rcu_state.barrier_sequence, s))
+		smp_mb(); /* caller's subsequent code after above check. */
+	else
+		rcu_barrier();
 }
 
 /*
-- 
2.55.0

