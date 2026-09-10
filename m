Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C873B6343
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035093; cv=none; b=SLdLrvSqAQ+X3CX7YGa9Jl0hb+TwARrefQy6YiZ2ptjbM0gT3bsB7FIrPcB7jMGXnfHn6CVSC0pV1oIjUTCOZw/gT656Fnvmm3+myl/zmwQiie7+/lrJrL1cZax6Y6TMtdtC/5YTwEj/b6MRgkOS2NQ4QKBqczghfBViHSZMhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035093; c=relaxed/simple;
	bh=bjn74m6lYgU75QWBxuODhlVr+jNtBBAQVRaQTBObXWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoMEnbAnTWerN+Kreci+wrj6CXfghH2ybzJxzUT8eKl6qmFYRALNvoDYQPTieqLHNEU5u0T1yBh9bBxsWPke5M/BQWlMuMJ2FxCiwntUv1Ki6Cmwi1jNS4dNr+heHC2Ivz7upEcUKcFJEQBtAFm0HDGoNHkd4mWK+UDwpXpNu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3ALvMjQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3ALvMjQ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39675172593so5828918a91.2
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789035084; x=1789639884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTa40VU/RgTGoI1uIvnZ9hj9zWpr2foPY3dyCyBq5dY=;
        b=O3ALvMjQ+60I03GtcbfHN6sKobYBFLTq0iMEh+MTNpsp6BoqJNqslBpbxf+vLn5sf5
         GtwUVedVTQyNXBa4gZUV9DX1P7MNbObveFzCFVSYKkWMeLt05WYHTb70R9FAiQe0oZvA
         /cQfs4+ddB5NFw0n4xKYfkB11WZ/UhvoFnAtkncVyeib5z9bjQznJEQyMcazpmKiCgx/
         AirNDdVtGnhgRNSd82xzAB1Y6jnmjP0Oz6aUbs8LvViqhYPJ/SYNDZKQhBSL6f9VPiEz
         ExIQDEFLgepCGGKIGUAl3A0BX5NUqNm3Gcwr4zkeWUufq5KgGObCVyzUKwuH4c9zct9U
         L47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789035084; x=1789639884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTa40VU/RgTGoI1uIvnZ9hj9zWpr2foPY3dyCyBq5dY=;
        b=PClV1ZPGN/Zjsnv84lZ4Q+KGsoBoRrFIVxlA38MTCJsy6u1lI6euYZDOonBE+p1y/D
         t88GBsO2PbYneosflAsZKjszQivbAz5W1Hg8SqJOvRTBb6fghexsV8GWWHEAPv3CbaNH
         TLO/kk7tWZ7yZrXPze8/rIYUA2H234kKl90vhug7Gy9PcPT46irHr7aTQoXB8alDsIXy
         Gd5kuBGd0MVbjyHQ5DpJJPxaT5pdjr4jBVYGA2RS2h8TWJR/97HepXNJa9MoqSKGuiwY
         hIM2j3rCnGc4hPhSf3z8L/0f1iqYtjTjo3gpHmXLcdNue+mcM3bkrihasUhyMHR7dQ22
         GXUA==
X-Forwarded-Encrypted: i=1; AKwUvBzPaXJS/X4mndDWGuhYFH/TGzcnsQrObWFDupTPQ57Yzp0kuijX8FFCD30ssMZF/JVm/nk=@vger.kernel.org
X-Gm-Message-State: AFuF++mykgO0sHl7F8gHATvMk3msf+OxSGCkGM0MnzUdRQssGIwQkBDt
	vQGYegH0Dx1RuLooMod7QTQHN8zhbjxuc+kWdby5J7EAe8scXrfwF+a2
X-Gm-Gg: AYBFou3zlbhZSesIMEjypwJHFiABMsegJEduH7tBP/QAOhr9sj4KawgA0JtWxFH3avH
	mYmEwyBhgMzGyrwzsMIeOJQDPs8Hxr4LbTsXadg7bggrvCnPjXakPFuodFxulrbCupscvkKJlTz
	zqeAP/fRHTz2ZdwXo0aO0SrO6OCC4zVSsk15ACDiVyr/mjd/oCrpEO4Dx+kfypQ4oJgWgFj/M6C
	P7sUSTBRqP1H8Q6qwFFhkZ3z9FUjUDUGXQCxmqsvA0DSjrQcBCOnHraF6SnCM+PJgF7GZGYlxdD
	pQHo2aaIS6TMIOy4I5MXw4bcPfu7QVw/wjc2doklhAysOceN+PjCHDM1SzNcihocXaAFhh5pDCa
	Q3bbg72J/0TIbC8qzC33Ecc5K7Uoq+Mkfw2AhPYhOPHE226JRPyEQLFrIjMOQ+P0mvVrrAN3447
	ib1M5PI5U5TUKi77CN+DEKXV/VyT6mPNTY3ajUB8sGQTYMYvdc8qqSVW68FRqOkDuDCMVA1IWbL
	GtcZBRH9HBu74u/eG1BT8DIybnCpPv/zPYOWHqX44HcABJ68bSOV0RV2oKsCEvQon5OcjyGn7cP
	OS4rMuu3k25TDQ6tFBix5cVFzr0CAjqlroopGgyaK+RTG5OlgrVWQ1IOC/cfGJoJ
X-Received: by 2002:a17:90b:50cc:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-39b26202ebamr63227635a91.14.1789035084186;
        Thu, 10 Sep 2026 03:11:24 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e8acf98sm4232116a91.15.2026.09.10.03.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 03:11:23 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	harry@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] rcu: drain kfree_rcu sheaves from the userspace barrier hook
Date: Thu, 10 Sep 2026 18:11:12 +0800
Message-ID: <20260910101112.1648978-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910101112.1648978-1-matthias.goergens@gmail.com>
References: <20260910101112.1648978-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcutree.do_rcu_barrier test hook is intended to prevent deferred RCU
callbacks from one stress test spilling into the next. Since kfree_rcu()
sheaves were added, an object can remain deferred without appearing on an
ordinary RCU callback list. rcu_barrier() therefore no longer fulfils the
hook's stated purpose by itself.

Drain kfree_rcu sheaves and kvfree_rcu batches before completing the
ordinary RCU barrier. Keep the explicit rcu_barrier() because the hook's
original ordinary-callback contract should not depend on the current,
undocumented fact that kvfree_rcu_barrier() includes one internally.

Keep the existing throttling because this remains a deliberately expensive
test-only action. Do not coalesce requests based on the ordinary
rcu_barrier() sequence: an unrelated ordinary barrier does not prove that
sheaves were drained.

A reproducer creates a private SLAB_NO_MERGE cache whose first allocation
populates a 60-object slab. It queues that object with kfree_rcu(), invokes
the hook, and reads the active-object count from /proc/slabinfo. In four
fresh VM pairs, the parent retained the object (60 to 60). The patched hook
drained it (60 to 59).

Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() operations")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++---
 kernel/rcu/tree.c                             | 27 ++++++++++++-------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..244a53166249 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5699,9 +5699,10 @@ Kernel parameters
 			there is an ongoing too-long CSD-lock wait.
 
 	rcutree.do_rcu_barrier=	[KNL]
-			Request a call to rcu_barrier().  This is
-			throttled so that userspace tests can safely
-			hammer on the sysfs variable if they so choose.
+			Request that deferred kfree_rcu() objects and
+			ordinary call_rcu() callbacks be drained.  This is
+			throttled so that userspace tests can safely hammer
+			on the sysfs variable if they so choose.
 			If triggered before the RCU grace-period machinery
 			is fully active, this will error out with EAGAIN.
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96848fc1f02b..014e28ec3bd3 100644
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
@@ -4011,18 +4011,25 @@ static void rcu_barrier_throttled(void)
 {
 	unsigned long j = jiffies;
 	unsigned long old = READ_ONCE(rcu_barrier_last_throttle);
-	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
 
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
+	/*
+	 * kfree_rcu() can retain objects outside the ordinary callback lists in
+	 * per-CPU SLUB sheaves and kvfree_rcu batches.  Test suites use this hook
+	 * to prevent deferred frees from spilling into the following test, so
+	 * drain those queues as well as ordinary call_rcu() callbacks.
+	 *
+	 * kvfree_rcu_barrier() currently includes an ordinary barrier, but that
+	 * is not part of its documented API.  Keep the explicit rcu_barrier() so
+	 * this hook's original contract does not depend on slab implementation
+	 * details.
+	 */
+	kvfree_rcu_barrier();
 	rcu_barrier();
 }
 
-- 
2.55.0

